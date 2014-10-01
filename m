From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 19/32] setup.c: support multi-checkout repo setup
Date: Wed, 01 Oct 2014 18:19:20 +0200
Message-ID: <542C2988.6060306@kdbg.org>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com> <1411867366-3821-1-git-send-email-pclouds@gmail.com> <1411867366-3821-20-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 18:19:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZMcl-0007ib-SH
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 18:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbaJAQT2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 12:19:28 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:52261 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751612AbaJAQT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 12:19:27 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3j7N2T2kLHz5tlK;
	Wed,  1 Oct 2014 18:19:13 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 176DC19F5C3;
	Wed,  1 Oct 2014 18:19:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1411867366-3821-20-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257756>

Am 28.09.2014 um 03:22 schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
> +test_expect_success 'GIT_DIR set (2)' '
> +	echo "gitdir: repo.git/repos/foo" >gitfile &&
> +	echo "$TRASH_DIRECTORY/repo.git" >repo.git/repos/foo/commondir &&
> +	(
> +		cd work &&
> +		GIT_DIR=3D../gitfile git rev-parse --git-common-dir >actual &&
> +		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
> +		test_cmp expect actual
> +	)
> +'

This requires the following fixup because MinGW git will understand
only DOS style absolute paths, but $TRASH_DIRECTORY is in
POSIX-MSYS-style /c/foo/bar.

--- 8< ---
Subject: [PATCH] fixup! setup.c: support multi-checkout repo setup

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t1501-worktree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index e6ac7a4..4df7a2f 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -366,7 +366,7 @@ test_expect_success 'GIT_DIR set (1)' '
=20
 test_expect_success 'GIT_DIR set (2)' '
 	echo "gitdir: repo.git/repos/foo" >gitfile &&
-	echo "$TRASH_DIRECTORY/repo.git" >repo.git/repos/foo/commondir &&
+	echo "$(pwd)/repo.git" >repo.git/repos/foo/commondir &&
 	(
 		cd work &&
 		GIT_DIR=3D../gitfile git rev-parse --git-common-dir >actual &&
--=20
2.0.0.12.gbcf935e
