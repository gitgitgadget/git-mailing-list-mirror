From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] builtins: reset startup_info->have_run_setup_gitdir
 when unsetting up repository
Date: Sat, 27 Mar 2010 19:34:16 -0500
Message-ID: <20100328003416.GA8011@progeny.tock>
References: <1269681184-1992-1-git-send-email-pclouds@gmail.com>
 <1269681184-1992-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 01:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvgST-0004l2-8O
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 01:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab0C1AeY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 20:34:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40047 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337Ab0C1AeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 20:34:23 -0400
Received: by gyg13 with SMTP id 13so766361gyg.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 17:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=htZNCsSw3TDVDiZVsUo62lu1p/3ToSor361WTT0MPSA=;
        b=iHeeQE+4oKeVduy3mzIQrEXsAYneBUYYHxiPfXtA+eRsGZ0Qn+yA70gGWKraJWEMdw
         Y0Uf23P9BkRgzSy94rXpKJsk/gooy/CHaj02sUDPEZpS+GcAuSxrq1+c3NQWrz/uQ8+n
         9XHyZVKiS/1Q7jbqHJnVqCrymhM6Vn6017R7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=le9wihR/ec2W5vkM/+UY++P6GbtL5Ncg6egIAp4lTOTJKQ1ng6eM/4M9+ZY8Z6xII3
         2OxKhxjqM0ppjorj6CD/6dLQZdcLreDOuYRoOftFSe0RfeIisTNtglTvVxGTm517M9GU
         PI021fKad/U5o6X+AFZmVWo5gaaJ+gt510v3w=
Received: by 10.100.53.1 with SMTP id b1mr4814211ana.112.1269736462493;
        Sat, 27 Mar 2010 17:34:22 -0700 (PDT)
Received: from progeny.tock (wireless-207-194.uchicago.edu [128.135.207.194])
        by mx.google.com with ESMTPS id 22sm2328464iwn.12.2010.03.27.17.34.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 17:34:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1269681184-1992-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143368>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  - alias handling will always be done before help_unknown_cmd()
>  - alias handling code will search and set up repository if found
>  - alias handline code will not undo repository setup
>=20
> These ensure that repository will always be set up (or attempted to
> set up) before help_unknown_cmd(), so there is no issue. But the setu=
p
> dependency here is subtle. It may break some day if someone reorders
> the loop, for example.
>=20
> Make a note about this.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Makes sense, thanks.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> startup_info->have_run_setup_gitdir is used to guard unallowed access
> to repository. When a repository has been set up and the real command
> does not expect any setup, we should revert to the original "fresh"
> state, including startup_info->have_run_setup_gitdir. Otherwise, the
> next attempt to set up repository will fail.
[...]
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

The test this adds fails for current master, too.

The cause: core.worktree gets set to point to the trash directory.
This results from a facet of the test I was not paying attention to ---
the trash directory is a git repository itself, which poisons git with
some extra information it hadn=E2=80=99t learned to forget yet.

The third and fourth tests below fail in master for this reason.

The first test passes everywhere; it is just checking basic behavior.

The second test passes in master and fails in nd/setup without the
git.c hunk of your patch.  It is a more targeted test, meant to check
only for the problem your patch solves.

Of course, with your patch applied, all four tests pass.  Thanks.

Reviewed-and-tested-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 6757734..6d6766e 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -33,6 +33,59 @@ test_expect_success 'plain' '
 	check_config plain/.git false unset
 '
=20
+test_expect_success 'plain nested in bare' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		git init --bare bare-ancestor.git &&
+		cd bare-ancestor.git &&
+		mkdir plain-nested &&
+		cd plain-nested &&
+		git init
+	) &&
+	check_config bare-ancestor.git/plain-nested/.git false unset
+'
+
+test_expect_success 'plain through aliased command' '
+	mkdir alias-config &&
+	echo "[alias] aliasedinit =3D init" >alias-config/.gitconfig &&
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG_NOGLOBAL &&
+		GIT_CEILING_DIRECTORIES=3D$(pwd) &&
+		HOME=3D$(pwd)/alias-config &&
+		export GIT_CEILING_DIRECTORIES HOME &&
+		mkdir plain-aliased &&
+		cd plain-aliased &&
+		git aliasedinit
+	) &&
+	check_config plain-aliased/.git false unset
+'
+
+test_expect_success 'plain nested through aliased command' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		git init plain-ancestor-aliased &&
+		cd plain-ancestor-aliased &&
+		echo "[alias] aliasedinit =3D init" >>.git/config &&
+		mkdir plain-nested &&
+		cd plain-nested &&
+		git aliasedinit
+	) &&
+	check_config plain-ancestor-aliased/plain-nested/.git false unset
+'
+
+test_expect_success 'plain nested in bare through aliased command' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		git init --bare bare-ancestor-aliased.git &&
+		cd bare-ancestor-aliased.git &&
+		echo "[alias] aliasedinit =3D init" >>config &&
+		mkdir plain-nested &&
+		cd plain-nested &&
+		git aliasedinit
+	) &&
+	check_config bare-ancestor-aliased.git/plain-nested/.git false unset
+'
+
 test_expect_success 'plain with GIT_WORK_TREE' '
 	if (
 		unset GIT_DIR
