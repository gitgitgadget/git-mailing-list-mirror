From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/4] make_absolute_path(): Do not append redundant slash
Date: Tue, 9 Feb 2010 20:10:43 +0100
Message-ID: <201002092010.43910.j6t@kdbg.org>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 20:12:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NevVT-0003KO-E6
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 20:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab0BITMO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 14:12:14 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:43908 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751065Ab0BITMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 14:12:14 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C922B2C400C;
	Tue,  9 Feb 2010 20:12:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2FD5619F6B8;
	Tue,  9 Feb 2010 20:10:44 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1265734950-15145-1-git-send-email-pclouds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139432>

On Dienstag, 9. Februar 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 wrote:
> @@ -54,8 +54,9 @@ const char *make_absolute_path(const char *path)
>  			if (len + strlen(last_elem) + 2 > PATH_MAX)
>  				die ("Too long path name: '%s/%s'",
>  						buf, last_elem);
> -			buf[len] =3D '/';
> -			strcpy(buf + len + 1, last_elem);
> +			if (*buf !=3D '/' || buf[1] !=3D '\0')
> +				buf[len++] =3D '/';

Huh? You are adding a slash unless buf is exactly "/". That is, when bu=
f=20
is "/foo/" you still add a slash? That's not exactly avoiding redundanc=
y.=20
(Disclaimer: I didn't analyze the rest of the function whether my claim=
 is=20
true.)

> +			strcpy(buf + len, last_elem);
>  			free(last_elem);
>  			last_elem =3D NULL;
>  		}

-- Hannes
