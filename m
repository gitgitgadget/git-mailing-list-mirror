From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH 1/3] vcs-svn: rename check_overflow arguments for clarity
Date: Thu, 2 Feb 2012 17:05:23 +0600
Message-ID: <CA+gfSn9Exv3T0UCB-bFShmSvRCMgygVuWraiToR6ZjgOA_sZ8A@mail.gmail.com>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
	<20120131192053.GC12443@burratino>
	<7vipjpzxav.fsf@alter.siamese.dyndns.org>
	<20120202104128.GG3823@burratino>
	<20120202105923.GJ3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Barr <davidbarr@google.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:05:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsuTp-0002FI-7L
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608Ab2BBLFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 06:05:25 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63999 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578Ab2BBLFY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 06:05:24 -0500
Received: by qcqw6 with SMTP id w6so1300006qcq.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eKOywBZCeK+N0+j94tqM15ruWyHjxcuu20z/tgfb6ls=;
        b=ORir+b4N2VufYDBiVUa83RJIfDXWjv+IXvHwgQKGh8UEQ/r1duLCV8z+5x1kmFb4RA
         9KOCB+GEyC91BB58SfQqjh81fuyGBttsBywYkbWOXWI5vSLN7usXF7jqpj1BuxULfj8g
         bT7xo6eDJWuzkLx6XdLeKBA+yFPbkr0ZXiMGw=
Received: by 10.229.78.227 with SMTP id m35mr798138qck.0.1328180723650; Thu,
 02 Feb 2012 03:05:23 -0800 (PST)
Received: by 10.229.226.19 with HTTP; Thu, 2 Feb 2012 03:05:23 -0800 (PST)
In-Reply-To: <20120202105923.GJ3823@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189625>

Hi

On Thu, Feb 2, 2012 at 4:59 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>
> Code using the argument names a and b just doesn't look right (not
> sure why!). =A0Use more explicit names "offset" and "len" to make the=
ir
> type and function clearer.
Well, it's still not clear. Given off_t a, size_t b, check that a+b
fits into type... which type?
"offset" and "length" don't imply that it's "type of offset" or maybe
"type of length".

>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Split out from Ramsay's patch.
>
> =A0vcs-svn/sliding_window.c | =A0 10 +++++-----
> =A01 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
> index 1bac7a4c..fafa4a63 100644
> --- a/vcs-svn/sliding_window.c
> +++ b/vcs-svn/sliding_window.c
> @@ -31,15 +31,15 @@ static int read_to_fill_or_whine(struct line_buff=
er *file,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int check_overflow(off_t a, size_t b)
> +static int check_overflow(off_t offset, size_t len)
> =A0{
> - =A0 =A0 =A0 if (b > maximum_signed_value_of_type(off_t))
> + =A0 =A0 =A0 if (len > maximum_signed_value_of_type(off_t))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error("unrepresentable length i=
n delta: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%"PRIu=
MAX" > OFF_MAX", (uintmax_t) b);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%"PRIu=
MAX" > OFF_MAX", (uintmax_t) len);
> - =A0 =A0 =A0 if (signed_add_overflows(a, (off_t) b))
> + =A0 =A0 =A0 if (signed_add_overflows(offset, (off_t) len))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error("unrepresentable offset i=
n delta: "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%"PRI=
uMAX" + %"PRIuMAX" > OFF_MAX",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (uintma=
x_t) a, (uintmax_t) b);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (uintma=
x_t) offset, (uintmax_t) len);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> --
> 1.7.9
>
