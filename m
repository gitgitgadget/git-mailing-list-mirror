From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v4 2/3] Show items of interactive git-clean in columns
Date: Fri, 3 May 2013 09:26:21 +0800
Message-ID: <CANYiYbGsMbJ=Ra6_fv12fnC_-Y5YfdWMgnROFWxo+Y=mkPKsiA@mail.gmail.com>
References: <6e795640952cad0eb25cb0db4243b2712f11e957.1367500374.git.worldhello.net@gmail.com>
	<vpq38u6n397.fsf@grenoble-inp.fr>
	<3b80db3d2e8f31b1d9373406cce3cbdee2094a29.1367500374.git.worldhello.net@gmail.com>
	<vpqppx9fmpu.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 03 03:26:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY4li-0000zF-SM
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 03:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762314Ab3ECB00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 21:26:26 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:59298 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762325Ab3ECB0W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 21:26:22 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so631648pbc.9
        for <git@vger.kernel.org>; Thu, 02 May 2013 18:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8UWXQEaRb8Hwy1V3ZoiSJh4VHf70v2sPOaMLJNJxcfU=;
        b=qhyDGGiOU9d2qsPXHF45/MxjxEA3XwQ1TqUJuNWsMpKyI/Hjl+bGEU3snXXQG2WR0G
         FU+RiV3QkTaRsm3iZVT7YX6fTQ+eC4JB1rgeWwE8neERS63SFJf5eJmTQxE0SDilmCxj
         kT9oU5XO3lHM8hRjbx+ZHrB6Cvyxi2a2t8eckw/Q1yc5c5v3G/T23TSUZ/os02YEHPpU
         E4juzDP31aLfqtGtc1eV1zv6nUV0iZvQAqp4wVKjLsFBRiBlrW5MP0bRPis1XjT+XlgB
         bC+Ht7vMQegvhPkPcChiG2MaDWl+uSrPmF3YPoXExUy3S6ow0vpHlBgJbxgKdKXil2KN
         usNQ==
X-Received: by 10.66.151.142 with SMTP id uq14mr12623694pab.50.1367544381797;
 Thu, 02 May 2013 18:26:21 -0700 (PDT)
Received: by 10.68.197.234 with HTTP; Thu, 2 May 2013 18:26:21 -0700 (PDT)
In-Reply-To: <vpqppx9fmpu.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223266>

2013/5/2 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>
> This lacks a proper commit message (why is this a good thing?), and

Rewrite the log as following:

Show items of interactive git-clean in columns

When there are lots of items to be cleaned, it is hard to see them all
in one screen. Show them in columns instead of in one column will solve
this problem.

Since no longer show items to be cleaned using the "Would remove ..."
format (only plain filenames), we add instructions/warnings as header
before them.

> documentation (you introduce column.clean) but the code sounds good
> (that's a very quick look from me, not a "review" sorry).

Will honors column.ui config variable only, not introduce new config variable.
So no more documentations needed ;-)

Fix-up looks like this:

 static int git_clean_config(const char *var, const char *value, void *cb)
 {
+       /* honors the column.ui config variable only */
        if (!prefixcmp(var, "column."))
-               return git_column_config(var, value, "clean", &colopts);
+               return git_column_config(var, value, NULL, &colopts);
        if (!strcmp(var, "color.interactive")) {
                clean_use_color = git_config_colorbool(var, value);
                return 0;

-- 
Jiang Xin
