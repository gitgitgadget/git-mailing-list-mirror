From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] MINGW: config.mak.uname: auto-detect
 MinGW build from compiler
Date: Wed, 08 Oct 2014 12:26:52 -0700
Message-ID: <xmqqoatm8irn.fsf@gitster.dls.corp.google.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
	<1412791267-13356-15-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCG77UMM3EJRB7U722QQKGQEAGPONEY@googlegroups.com Wed Oct 08 21:26:56 2014
Return-path: <msysgit+bncBCG77UMM3EJRB7U722QQKGQEAGPONEY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f192.google.com ([209.85.220.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB7U722QQKGQEAGPONEY@googlegroups.com>)
	id 1Xbwsy-0002gU-2E
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 21:26:56 +0200
Received: by mail-vc0-f192.google.com with SMTP id hq11sf1602629vcb.19
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=V3xqxXJqnPLtJtfKgZgJh8TOsl2hrLmWKqoadcLMNsg=;
        b=u5ul8+Kd6G1ZF+JxRmJ1afL6oo7xY/BSJo5GmW48AcmZsLa8TMQ+mwLywEhLSMFw04
         FlvUANHyFQOGviN9sa1OJTLJJSj19v87u1WZG5GIlONJKTUFzwauZBHj0/Y7d7mh3nvs
         nXMMqINsjRmc9Ztn1kLqYJ8m+vjZquKPsEgJlX2EVktrPYABMPv8HT1v/jZ6e+lB0KRg
         x0RXUFBOltCYzKbLVnAreaifQTTqUBVPgb/R20OCEvwfbjNIS/Y9ZTaw7gAxSKGbMwGo
         PMnbT79JsEvsCYTonf3Yeek1T1RFd/G2Sb5ZzEyU7D6Q/CZRPQITXy3VbaaSHmMO2kh8
         5Bbw==
X-Received: by 10.182.130.133 with SMTP id oe5mr80496obb.9.1412796415284;
        Wed, 08 Oct 2014 12:26:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.80.130 with SMTP id r2ls1306944obx.80.gmail; Wed, 08 Oct
 2014 12:26:54 -0700 (PDT)
X-Received: by 10.182.251.135 with SMTP id zk7mr8088828obc.14.1412796414793;
        Wed, 08 Oct 2014 12:26:54 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id h8si1319052igq.0.2014.10.08.12.26.54
        for <msysgit@googlegroups.com>;
        Wed, 08 Oct 2014 12:26:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C83114859;
	Wed,  8 Oct 2014 15:26:54 -0400 (EDT)
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10BB014858;
	Wed,  8 Oct 2014 15:26:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D84E14857;
	Wed,  8 Oct 2014 15:26:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F3958C2-4F21-11E4-AB0A-855A93717476-77302942!pb-smtp1.pobox.com
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
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Marat Radchenko <marat@slonopotamus.org> writes:

> When crosscompiling, one cannot rely on `uname` from host system.

That may well be true, but is that limited to cross-compiling to
mingw?   Would it be generally true for any cross compilation,
wouldn't it?

What I am wondering is if it is a better solution to make it easier
to allow somebody who is cross compiling to express "Mr.  Makefile,
we know better than you and want you to do a MINGW build for us
without checking with `uname -?` yourself", i.e.

	$ make uname_O=MINGW uname_S=MINGW

which would hopefully allow cross-compilation into other
environments, not just MINGW.

>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  config.mak.uname | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 9f7037e..182da50 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -14,6 +14,11 @@ ifdef MSVC
>  	uname_O := Windows
>  endif
>  
> +ifneq (,$(findstring mingw,$(CC_MACH)))
> +	uname_S := MINGW
> +	uname_O := MINGW
> +endif
> +
>  # We choose to avoid "if .. else if .. else .. endif endif"
>  # because maintaining the nesting to match is a pain.  If
>  # we had "elif" things would have been much nicer...
> -- 
> 2.1.1
>
> -- 

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
