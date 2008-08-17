From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/6] Don't use struct stat's st_blocks member on Haiku
Date: Sun, 17 Aug 2008 02:28:59 -0700 (PDT)
Message-ID: <m31w0ot2ga.fsf@localhost.localdomain>
References: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-15?q?Andreas_F=E4rber?= <andreas.faerber@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 11:30:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUeaN-0002nJ-R5
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 11:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbYHQJ3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2008 05:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbYHQJ3E
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 05:29:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:28269 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbYHQJ3C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 05:29:02 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1000837nfc.21
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=FFtOIIvEekAcqJCKc8ql4vCe7A3Naj1FOTw7BWAR0FI=;
        b=XECPE+QlFCOrfiJsHKzFkSAnq8Rj591SeGg8CYwxlK5TsDelRj4W08P+i5ZYz/fUjy
         hmA2PYKOh9WYoEPCG0JjglBOQpaHBvAJL6SjDKnTzvsfHJBNh/fKDabhHdS4DfP3weop
         Lg0ERTtIXcd2g96sAZBtJjcuTfLDlHHOIKEGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=QZxwPKBN1qlZ4ii6LtUBnZSO8k+nRkRZutV0QExDHCGbiYzKDZrEcAPlcAG4kRDYQS
         RtwgeJs3Ig9uuyIYhLsCjrv3Drk+ex1ryf/Yn1VUsiiC3KLwBlrb1EvnIu4apbI6zlAB
         ydPwZHcACTsdxKC8FdPyGK9e76xOsxmXo3tYw=
Received: by 10.210.39.2 with SMTP id m2mr6127733ebm.97.1218965340560;
        Sun, 17 Aug 2008 02:29:00 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.208.28])
        by mx.google.com with ESMTPS id g12sm4678626nfb.28.2008.08.17.02.28.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 02:28:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7H9StPL017485;
	Sun, 17 Aug 2008 11:28:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7H9SsPZ017482;
	Sun, 17 Aug 2008 11:28:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92593>

Andreas F=E4rber <andreas.faerber@web.de> writes:

> Signed-off-by: Andreas Faerber <andreas.faerber@web.de>
> Signed-off-by: Ingo Weinhold <ingo_weinhold@gmx.de>
> ---
> BeOS didn't have that field, so neither has Haiku currently.
> It is part of the optional XSI POSIX feature.
>=20
>   Makefile                |    4 ++++
>   builtin-count-objects.c |    4 ++++
>   configure.ac            |    8 ++++++++
>   3 files changed, 16 insertions(+), 0 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 5dba2c7..a4d73fc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -730,6 +730,7 @@ ifeq ($(uname_S),HP-UX)
>   endif
>   ifeq ($(uname_S),Haiku)
>   	NO_IPV6 =3D YesPlease
> +	NO_ST_BLOCKS_IN_STAT =3D YesPlease
>   	EXTLIBS +=3D -lnetwork
>   endif
>   ifneq (,$(findstring MINGW,$(uname_S)))
> @@ -867,6 +868,9 @@ endif
>   ifdef NO_D_INO_IN_DIRENT
>   	BASIC_CFLAGS +=3D -DNO_D_INO_IN_DIRENT
>   endif
> +ifdef NO_ST_BLOCKS_IN_STAT
> +	BASIC_CFLAGS +=3D -DNO_ST_BLOCKS_IN_STAT
> +endif
>   ifdef NO_C99_FORMAT
>   	BASIC_CFLAGS +=3D -DNO_C99_FORMAT
>   endif

It it is _new_ define you should have described it in comments in
Makefile header too.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
