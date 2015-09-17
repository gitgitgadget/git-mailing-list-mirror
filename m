From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 14/14] tag.c: implement '--merged' and '--no-merged' options
Date: Thu, 17 Sep 2015 15:09:19 -0700
Message-ID: <xmqq37ycitps.fsf@gitster.mtv.corp.google.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441902169-9891-3-git-send-email-Karthik.188@gmail.com>
	<20150917213619.GI17201@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Sep 18 00:09:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZchMv-00029F-F2
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 00:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbbIQWJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 18:09:25 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34886 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbbIQWJY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 18:09:24 -0400
Received: by pacfv12 with SMTP id fv12so30934300pac.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 15:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sfNFGFdMqTca3DC0IMWlaZv7B1ATGVy0aCLiJgdLc/k=;
        b=Kxpil0dj8wKrJcGqVv0b/DgJE9saG58jZfrXZ9vFA/9KLJzP576DQFXGzfUqadUE/B
         7xuYBeqh/8Pc/RlNxQQNMkbxq7QbTGA/IsMDV4+CeqH+23kcA9pc3YYxKJkMq4fc6KSO
         ATpvUJKa+JcfOdLxgXFGyWPrcd0quYj38tQxTwqd7DpTlsYJzK8yU7KfWIi0IQpmURkD
         daGBv7g3KDnNyMBF7mp3WQ9ejXv47XLPPvwsmZZWaNhE9WNYED4on21RbRsZ5kCCYcu5
         41N7YIq1bRFZH3DwttGK/8C3gEw21ZlJFNtI4vxzm9iWbPJvGMhH9xTeas4FnpD0cZSO
         1VyA==
X-Received: by 10.68.239.202 with SMTP id vu10mr2871865pbc.135.1442527764395;
        Thu, 17 Sep 2015 15:09:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id un2sm5204332pac.28.2015.09.17.15.09.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 15:09:23 -0700 (PDT)
In-Reply-To: <20150917213619.GI17201@serenity.lan> (John Keeping's message of
	"Thu, 17 Sep 2015 22:36:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278173>

John Keeping <john@keeping.me.uk> writes:

>> +--[no-]merged [<commit>]::
>
> We prefer to write --[no-]* as:
>
> 	--option::
> 	--no-option::
>
> although this may be the first instance that we see this combination
> with an argument.
>
> I also found the "[<commit>]" syntax confusing and had to go and figure
> out what PARSE_OPT_LASTARG_DEFAULT does; I wonder if it's worth
> appending something like the following to the help for this option:
>
> 	The `commit` may be omitted if this is the final argument.

"may be omitted" must be followed by a description of what happens
when omitted (i.e. "defaults to ...").
