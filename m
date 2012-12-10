From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] mingw_rmdir: do not prompt for retry when non-empty
Date: Mon, 10 Dec 2012 08:25:58 -0800
Message-ID: <7vr4mxc1rd.fsf@alter.siamese.dyndns.org>
References: <1355150547-8212-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysgit@googlegroups.com, 
 johannes.schindelin@gmx.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBGM2TCDAKGQECDUEBWY@googlegroups.com Mon Dec 10 17:26:18 2012
Return-path: <msysgit+bncBCG77UMM3EJRBGM2TCDAKGQECDUEBWY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f186.google.com ([209.85.220.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBGM2TCDAKGQECDUEBWY@googlegroups.com>)
	id 1Ti6BL-0003tO-Mf
	for gcvm-msysgit@m.gmane.org; Mon, 10 Dec 2012 17:26:15 +0100
Received: by mail-vc0-f186.google.com with SMTP id fl17sf2296365vcb.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 10 Dec 2012 08:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=xO3r+AcTlTxITqMlNjUmPVgH2fRnQsD7zH+y9OZ3YFA=;
        b=KcAi9W/yzUBrxp/C1T+W1JsNtqGDiOf8G/XABdH4qmhd+rozIMRy6qTv/PHxPW569X
         euz8q3oYikIXosyLUNN+J8ZC68/7T/8xHZbnCY76zPNGHlQF5drkIohXSljSWZ2Z4n7F
         7D8cmTesi1nlbmcz1U277p/0xk8jAvyWCdrH1YYr1PsONdKwbCWN4rCsHOSCmoos0A3Y
         tU78Zj4SlPchpkGIOmWsEu/bFRISfayVsZddHHzZZXYhqsWHf7PbXcv5QLlzctRuJN75
         t64BfdjKe31rLRma1EUksTYSqjwLaC2dKWfl7zntpBVff1YibausjqcU9HJDBd/z0r6 
Received: by 10.49.87.1 with SMTP id t1mr3209615qez.41.1355156762683;
        Mon, 10 Dec 2012 08:26:02 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.87.72 with SMTP id v8ls4048348qez.78.gmail; Mon, 10 Dec
 2012 08:26:01 -0800 (PST)
Received: by 10.224.173.202 with SMTP id q10mr12105398qaz.3.1355156761088;
        Mon, 10 Dec 2012 08:26:01 -0800 (PST)
Received: by 10.224.173.202 with SMTP id q10mr12105384qaz.3.1355156760746;
        Mon, 10 Dec 2012 08:26:00 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id fg3si5453495qcb.2.2012.12.10.08.26.00;
        Mon, 10 Dec 2012 08:26:00 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CFB287A4;
	Mon, 10 Dec 2012 11:26:00 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6854087A2;
	Mon, 10 Dec 2012 11:26:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B889E87A0; Mon, 10 Dec 2012
 11:25:59 -0500 (EST)
In-Reply-To: <1355150547-8212-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Mon, 10 Dec 2012 15:42:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 484FDD0A-42E6-11E2-98BB-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio@b-sasl-quonix.pobox.com designates
 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
 dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211257>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> in ab1a11be ("mingw_rmdir: set errno=ENOTEMPTY when appropriate"),
> a check was added to prevent us from retrying to delete a directory
> that is both in use and non-empty.
>
> However, this logic was slightly flawed; since we didn't return
> immediately, we end up falling out of the retry-loop, but right into
> the prompting-loop.
>
> Fix this by setting errno, and guarding the prompting-loop with an
> errno-check.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> Here's the second version of this patch, sorry for the slight delay.

Is this meant for me, or is it to be applied to msysgit and later
somehow fed to me in different form?

I can s/_wrmdir/rmdir/;s/wpathname/pathname/ if that is what you
want me to do, but otherwise this patch does not apply.

>
>  compat/mingw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 1eb974f..440224c 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -260,6 +260,8 @@ int mingw_rmdir(const char *pathname)
>  
>  	while ((ret = _wrmdir(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
>  		if (!is_file_in_use_error(GetLastError()))
> +			errno = err_win_to_posix(GetLastError());
> +		if (errno != EACCES)
>  			break;
>  		if (!is_dir_empty(wpathname)) {
>  			errno = ENOTEMPTY;
> @@ -275,7 +277,7 @@ int mingw_rmdir(const char *pathname)
>  		Sleep(delay[tries]);
>  		tries++;
>  	}
> -	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
> +	while (ret == -1 && errno == EACCES && is_file_in_use_error(GetLastError()) &&
>  	       ask_yes_no_if_possible("Deletion of directory '%s' failed. "
>  			"Should I try again?", pathname))
>  	       ret = _wrmdir(wpathname);

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
