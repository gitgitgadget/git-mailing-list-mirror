From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [patch 12/16] host-OSF1.patch
Date: Tue, 27 Apr 2010 16:10:56 +0200
Message-ID: <l2jd2d39d861004270710w8e5416d5iad3fa7497e620733@mail.gmail.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
	 <20100427135904.486582000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 16:11:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lV9-00031m-HT
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab0D0OK6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 10:10:58 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:39272 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726Ab0D0OK6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 10:10:58 -0400
Received: by ewy20 with SMTP id 20so4263090ewy.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=uj3WHqrVttPnk16MvoAQaHlkJYVaCyhcbrTCZgvq4uc=;
        b=fPnZRvURFDq7QcWMM1JRHjwl8m5pIq8kkdPqbE73ULyNwoia7sVJFn6DST9xrvOTnB
         PLHlIydpbaR4i/WrJLX5STVLHjg7V18EdjMpxVNqJuegoOyhXSt5ndaoyB29urVqDK3E
         NTeGz5w7gWpAyG/chCdPwpc+75UL65S9iILhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=HQNf+nBK7a/IR8m+BL+BrOUBvc/75QPSP9jMlK9zbO1SK/TzSwIEJfOfv71CPvDANm
         hkwH1JY/qtZ/BYAsex05hWXkOLWJVcK9X/GW0xLaQqy9d9tbgb6RK0BLBP87Q0Yz6Kuf
         YNvNiZ9WFwFJLNx8WKQUK49bqlsqFE8kDeExA=
Received: by 10.239.188.202 with SMTP id q10mr549956hbh.12.1272377456276; Tue, 
	27 Apr 2010 07:10:56 -0700 (PDT)
Received: by 10.239.179.197 with HTTP; Tue, 27 Apr 2010 07:10:56 -0700 (PDT)
In-Reply-To: <20100427135904.486582000@mlists.thewrittenword.com>
X-Google-Sender-Auth: e83c756f0cdac4d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145920>

On Tue, Apr 27, 2010 at 15:57, Gary V. Vaughan
<git@mlists.thewrittenword.com> wrote:
> Add defaults for Tru64 Unix. =A0Without this patch I cannot compile
> git on Tru64 5.1.
> ---
> =A0Makefile | =A0 =A06 ++++++
> =A01 file changed, 6 insertions(+)
>
> Index: b/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/Makefile
> +++ b/Makefile
> @@ -734,6 +734,12 @@ EXTLIBS =3D
> =A0# because maintaining the nesting to match is a pain. =A0If
> =A0# we had "elif" things would have been much nicer...
>
> +ifeq ($(uname_S),OSF1)
> + =A0 =A0 =A0 # Need this for u_short definitions et al
> + =A0 =A0 =A0 BASIC_CFLAGS +=3D -D_OSF_SOURCE
> + =A0 =A0 =A0 NO_STRTOULL =3D YesPlease
> + =A0 =A0 =A0 NO_NSEC =3D YesPlease
> +endif

I'll try your patch for OSF1, but (ref. a patch I sent earlier, in its
first revision) I needed several other changes in order to compile on
5.1 (I also needed those you have above), e.g.
-D_POSIX_C_SOURCE=3D1 NO_STRCASESTR =3D YesPlease NO_STRTOUMAX =3D YesP=
lease
NO_STRLCPY =3D YesPlease NO_MEMMEM =3D YesPlease NO_UINTMAX_T =3D YesPl=
ease
NO_C99_FORMAT =3D YesPlease
and
NO_TCLTK =3D YesPlease
because V5.1 comes with tcl/tk 8.2 and gitk refuses to start with
anything older than 8.4.
I had some other too, but those could be worked around by building and
installing own versions of iconv, openssl, zlib, python, expat.

-Tor
