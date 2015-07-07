From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 27/44] builtin-am: implement --[no-]scissors
Date: Tue, 7 Jul 2015 16:23:18 +0800
Message-ID: <CACRoPnR1kJVg-SKGJggc-gWAtDVoeyRG6G8SHx7T7XNUMyGozw@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-28-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 10:24:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCOAd-0005tR-Cf
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 10:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849AbbGGIXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 04:23:39 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35506 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbbGGIX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 04:23:27 -0400
Received: by wgjx7 with SMTP id x7so160690309wgj.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+MgG1382Ru8PX1FaUu2O+2rIipea2raAXu+vIeakgs0=;
        b=rwBQtui6GUjTYfV5DO+BHJgeYT3TrUq00MNN4BntqMUs8nJovEP4L8yWoUSwggkDuw
         o2EKGlVtECcU08W6dkAhckqb7E7/6uYmCY1BY45B9sALuPi13qBtGFv+cc/wsYIQHzvc
         6CqjztjyyVWipukIHzacZ3ZRFvF63R7Uq2XNuSLJ/unB9gikY0ArN+yI1Le7TcgiH0eY
         /uBTLxvvzXouioyDn9tHJn9ySmQnw7hxD7O++pQ2Lx2UFWh3ECWyfVkRuHP4M44nbpxg
         JAgIehLR0mvdm662++qWZlrl74kuE8wwXQmxpYEvZNoKVv0QQl98qM0wLysKM5yNeqZ+
         5gGA==
X-Received: by 10.180.95.101 with SMTP id dj5mr61524993wib.16.1436257398910;
 Tue, 07 Jul 2015 01:23:18 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Tue, 7 Jul 2015 01:23:18 -0700 (PDT)
In-Reply-To: <1435500366-31700-28-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273490>

On Sun, Jun 28, 2015 at 10:05 PM, Paul Tan <pyokagan@gmail.com> wrote:
> diff --git a/builtin/am.c b/builtin/am.c
> index 2387726..55989e5 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -74,6 +74,12 @@ enum keep_type {
>         KEEP_NON_PATCH  /* pass -b flag to git-mailinfo */
>  };
>
> +enum scissors_type {
> +       SCISSORS_UNSET = -1,
> +       SCISSORS_TRUE,  /* pass --scissors to git-mailinfo */
> +       SCISSORS_FALSE  /* pass --no-scissors to git-mailinfo */
> +};
> +

Heh, the improved test coverage[1] caught a bug here. Whooops.

[1] http://thread.gmane.org/gmane.comp.version-control.git/273254/focus=273264

Regards,
Paul
