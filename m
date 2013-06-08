From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Bug: `gitsubmodule` does not list modules with unicode
 characters
Date: Sat, 8 Jun 2013 14:06:00 +0200
Message-ID: <20130608120600.GA2159@paksenarrion.iveqy.com>
References: <loom.20130323T171809-46@post.gmane.org>
 <51500B34.30801@web.de>
 <20130608010556.GA28819@paksenarrion.iveqy.com>
 <20130608091836.GA2925@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Ilya Kulakov <kulakov.ilya@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 14:03:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlHrq-0007Bc-3l
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 14:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab3FHMD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 08:03:29 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:56295 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab3FHMD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 08:03:28 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so562779lbc.17
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 05:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5EbR6j4cGRut++ojHE4CjYLz6VQWJANQoW/vCZMuliI=;
        b=k22rHbyqdoZckGdXfsbJaP9vetW1fy3nSWshnbLlkG2U5sggPL93re68yfdi+ZBRnM
         QN+qIdig6JFVEXEn88dnH6JbsQtvi4zmirNN/TRuOk7WiOmTUkNHkviBy6t1s7fXuYhk
         pclvU/TKMtaOVhfK104TQFiWMa2cco0UEtCUa8N9RqqdoSpYi0qR5szvlxCvd552aTOh
         3zEWLy0BY1nYLqd2TiFlsP/i1ODqvsDYZhmaUrOXZsK7tD44LwmZL2IPymQxHzvnpU7D
         95Gq9Et1xEUXq1RBshHGrBit/wG2zMw1YBbVZlZ0kSNxwyIiw67h4LGSy9XVsc/+UV7G
         Ibfw==
X-Received: by 10.152.42.171 with SMTP id p11mr1236812lal.79.1370693007130;
        Sat, 08 Jun 2013 05:03:27 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id p16sm2454291lbi.13.2013.06.08.05.03.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 05:03:26 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UlHuC-0000oA-Lf; Sat, 08 Jun 2013 14:06:00 +0200
Content-Disposition: inline
In-Reply-To: <20130608091836.GA2925@elie.Belkin>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226805>

On Sat, Jun 08, 2013 at 02:18:36AM -0700, Jonathan Nieder wrote:
> The whole point of "-z" is that by using a terminator that is guarant=
eed
> not to appear in filenames, it avoids the need to quote filenames.
> Otherwise at least \n would need to be quoted.

Thanks, now I understand why.

>=20
> How about something like this patch?
>=20
> -- >8 --
> Subject: ls-files doc: clarify purpose of "-z" option
>=20
> The purpose of the "-z" option is to avoid quoting issues by using a
> delimiter that implies a binary-clean parser and cannot appear in
> filenames, and in that spirit, "-z" turns off C-style quoting.  But
> without looking carefully through the entire manpage, it is too easy
> to miss that.
>=20
> Reported-by: Fredrik Gustafsson <iveqy@iveqy.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Documentation/git-ls-files.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-fi=
les.txt
> index c0856a6e..753c223f 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -75,7 +75,9 @@ OPTIONS
>  	succeed.
> =20
>  -z::
> -	\0 line termination on output.
> +	Terminate lines with NUL instead of LF.
> +	This avoids the need to quote filenames; see the Output section
> +	below for details.
> =20
>  -x <pattern>::
>  --exclude=3D<pattern>::
> --=20
> 1.8.3
>=20

That would be very helpfull. I would suggest to add something about
unicode also (and maybe about the quotes that's added?). I'm a bit
unsure about the formulating but how about something like this:


=46rom 114c34ea482873b39c02e63eeaf866c3e9ebfc14 Mon Sep 17 00:00:00 200=
1
=46rom: Jonathan Nieder <jrnieder@gmail.com>
Date: Sat, 8 Jun 2013 02:18:36 -0700
Subject: [PATCH] Subject: ls-files doc: clarify purpose of "-z" option

The purpose of the "-z" option is to avoid quoting issues by using a
delimiter that implies a binary-clean parser and cannot appear in
filenames, and in that spirit, "-z" turns off C-style quoting.  But
without looking carefully through the entire manpage, it is too easy
to miss that.

Reported-by: Fredrik Gustafsson <iveqy@iveqy.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-ls-files.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index c0856a6..ef785ba 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -75,7 +75,9 @@ OPTIONS
 	succeed.
=20
 -z::
-	\0 line termination on output.
+	Terminate lines with NUL instead of LF.
+	This avoids the need to quote filenames; see the Output section
+	below for details.
=20
 -x <pattern>::
 --exclude=3D<pattern>::
@@ -172,7 +174,8 @@ path. (see linkgit:git-read-tree[1] for more inform=
ation on state)
=20
 When `-z` option is not used, TAB, LF, and backslash characters
 in pathnames are represented as `\t`, `\n`, and `\\`,
-respectively.
+respectively. Multibyte characters are represented by they escaped
+equivalents.
=20
=20
 Exclude Patterns
--=20
1.8.1.5


--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
