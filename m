From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Rename V15_MINGW_HEADERS into CYGWIN_OLD_WINSOCK_HEADERS
Date: Sat, 17 Nov 2012 09:38:25 -0500
Message-ID: <50A7A161.9020805@gmail.com>
References: <201211170809.50395.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 17 15:39:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZjXz-0006u7-Ej
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 15:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953Ab2KQOid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 09:38:33 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56140 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab2KQOi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 09:38:28 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so3803548vbb.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 06:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=RaGtWV5aDVrGFOiPSz4ixQh76jnbeFAk7dIr7nkWt6k=;
        b=HA6Xh/6T3GT/W8MmbmkzuEBdFz/Y0MiLpb1D8BaPzxyhCuvQP4E9uarSC+MSizTT8K
         iO3tMBHkgf/xsqvXSA3EuVfNpKocrIzGsUKG7SSkqK1rvizNOpx4MOLKgMsw3E6mNWeR
         iC/a06L8eKyj1pOyXMsCF4XrJGkPWge8ZddbAy+QsS3zX7/hl4DP3rg/4unwChBYgMqD
         rwpxJjR8ckr6aRWIP2WQEbKqe2Q4Dt5WAXdH7GUVs2uvuLfeviAcQqoyTJdD4XAG+9hO
         k40xMf5KuqVzQe8rDO3Db5KBfBI1j8YAl3omlMOlCI9Oc+OHWMDF/fuyIxz/sZIZ16G2
         Dv4Q==
Received: by 10.58.145.161 with SMTP id sv1mr9443717veb.52.1353163107896;
        Sat, 17 Nov 2012 06:38:27 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-107-139.washdc.fios.verizon.net. [173.79.107.139])
        by mx.google.com with ESMTPS id x4sm2619426vdh.13.2012.11.17.06.38.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 06:38:26 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
In-Reply-To: <201211170809.50395.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209960>

On 11/17/2012 02:09 AM, Torsten B=C3=B6gershausen wrote:
> See commit 380a4d927bff693c42fc6b22c3547bdcaac4bdc3:
> "Update cygwin.c for new mingw-64 win32 api headers"
> Cygwin up to 1.7.16 uses some header file from the WINE project
> Cygwin 1.7.17 uses some header file from the mingw-64 project
> As the old cygwin (like 1.5) never used mingw,
> the name V15_MINGW_HEADERS is confusing.
> Rename it into CYGWIN_OLD_WINSOCK_HEADERS
>
>
> diff --git a/Makefile b/Makefile
> index c3edf8c..c2ea735 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1089,7 +1089,7 @@ ifeq ($(uname_O),Cygwin)
>   		NO_SYMLINK_HEAD =3D YesPlease
>   		NO_IPV6 =3D YesPlease
>   		OLD_ICONV =3D UnfortunatelyYes
> -		V15_MINGW_HEADERS =3D YesPlease
> +		CYGWIN_OLD_WINSOCK_HEADERS =3D YesPlease
>  =20
WINSOCK is certainly a part of the win32 api implementation, but it is=20
is the entire win32api that changed, not just the tiny bit dealing with=
=20
sockets.
Basically, WINDOWS.h, and everything it includes, and all of the dlls i=
t=20
touches, and the .o files, changed. Calling it "OLD" is not helpful,=20
what happens in the future with the next change? The only version info=20
we really have is the dll version. We are switching between the win32=20
api implementation shipped with cygwin dll version 1.5.x and the one=20
that is now current. And, the shift is not tied to any particular cygwi=
n=20
1.7.x dll version either (there are no cross dependencies between the=20
win32api implementation and any particular dll in the 1.7.x series, jus=
t=20
a coincidence in time as to what packages got updated when). So my=20
suggestion in the bike shedding category is to

s/V15_MINGW_HEADERS/CYGWIN_V15_WIN32API/

/end of bike shedding.

If this is really worth a second patch, I'll be happy to send one :^)

Mark
