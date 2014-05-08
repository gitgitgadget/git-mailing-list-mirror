From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: Always normalize paths to Windows-style
Date: Thu, 08 May 2014 13:13:25 -0700
Message-ID: <xmqqd2fo2fmi.fsf@gitster.dls.corp.google.com>
References: <20140428083931.GA10257@camelia.ucw.cz>
	<CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com>
	<20140428113815.GA10559@camelia.ucw.cz>
	<20140428114224.GA11186@camelia.ucw.cz>
	<CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
	<20140428142931.GA12056@camelia.ucw.cz>
	<20140507184444.GB4013@sandbox-ub>
	<xmqqmwet8gre.fsf@gitster.dls.corp.google.com>
	<20140508101115.GC4511@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>,  GIT Mailing-list <git@vger.kernel.org>,  Johannes Sixt <j6t@kdbg.org>,  msysgit@googlegroups.com
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRB2WKV6NQKGQESN2BEOI@googlegroups.com Thu May 08 22:13:33 2014
Return-path: <msysgit+bncBCG77UMM3EJRB2WKV6NQKGQESN2BEOI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f63.google.com ([209.85.213.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB2WKV6NQKGQESN2BEOI@googlegroups.com>)
	id 1WiUhA-0000Mg-RH
	for gcvm-msysgit@m.gmane.org; Thu, 08 May 2014 22:13:33 +0200
Received: by mail-yh0-f63.google.com with SMTP id z6sf639720yhz.28
        for <gcvm-msysgit@m.gmane.org>; Thu, 08 May 2014 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=I2oLPb52e71GUhPfbQfvaZpv4Ik+fuJldQJKqGOgDNQ=;
        b=lVxmag4lQ850ciEStE1v9y2zNrgLo8PyWJpOkbVxTQtkzPEQY/Mox9FlIki+c0JqZ6
         bW4Vi+8Sc6QCMvgDQ1Aandb+Txw8J1RdjI7UjumfYGV+MMdWr9IN054cOLK0JJv/JCbG
         wx3JTl0GMm6VraIw/FNdzaQ0vfPiKLAa1yE+D0DRFEdLCedZVRPXT22fXl5pX6S3yMNe
         85qrVYPRHpmh47qxujGwH7CO+Y1jKtjLMypdhajYhRlW9cNTys12zVpuERj8rhNVTrVu
         YLAiltddnJIrdkdiVawSwKi6kZZSalHsW4DND6UkuY4+Y7QcexBe1wqt11ToGV18WJd3
         tDaQ==
X-Received: by 10.50.79.137 with SMTP id j9mr858292igx.15.1399580011845;
        Thu, 08 May 2014 13:13:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.79.225 with SMTP id m1ls618121igx.9.canary; Thu, 08 May
 2014 13:13:30 -0700 (PDT)
X-Received: by 10.42.29.138 with SMTP id r10mr2564254icc.11.1399580010716;
        Thu, 08 May 2014 13:13:30 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ga1si319800qcb.0.2014.05.08.13.13.30
        for <msysgit@googlegroups.com>;
        Thu, 08 May 2014 13:13:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2CA8A157C7;
	Thu,  8 May 2014 16:13:30 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F183157C5;
	Thu,  8 May 2014 16:13:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 94731157C3;
	Thu,  8 May 2014 16:13:27 -0400 (EDT)
In-Reply-To: <20140508101115.GC4511@camelia.ucw.cz> (Stepan Kasal's message of
	"Thu, 8 May 2014 12:11:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3764FF06-D6ED-11E3-9395-9CEB01674E00-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248439>

Stepan Kasal <kasal@ucw.cz> writes:

> This one was accepted to git, but was reverted in msysGit almost
> immediately by 64a8a03.  Things stayed that way for 2 years.
> So it seems no one has ever actually used this code.
> Consequently, I propose to revert 4dce7d9b from git.

OK, let's do this.  I'd like you to take the authorship of it (and
correct any mistake I may have made in the description) with your
sign-off.

Thanks.

-- >8 --
From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] Revert "submodules: fix ambiguous absolute paths under Windows"

This reverts commit 4dce7d9b408b2935b85721b54a2010eda7ec1be9,
which was originally done to help Windows but was almost
immediately reverted in msysGit, and the codebase kept this
unnecessary divergence for almost two years.

Not-Signed-off-yet-by: Stepan Kasal <kasal@ucw.cz>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 66f5f75..821e6d4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -285,9 +285,6 @@ module_clone()
 	# resolve any symlinks that might be present in $PWD
 	a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
 	b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
-	# normalize Windows-style absolute paths to POSIX-style absolute paths
-	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} ;; esac
-	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} ;; esac
 	# Remove all common leading directories after a sanity check
 	if test "${a#$b}" != "$a" || test "${b#$a}" != "$b"; then
 		die "$(eval_gettext "Gitdir '\$a' is part of the submodule path '\$b' or vice versa")"
-- 
2.0.0-rc2-397-ga0fd1fc

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
