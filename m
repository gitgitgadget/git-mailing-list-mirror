From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 07/10] builtin-archive: mark unused prefix "unused_prefix"
Date: Sun, 2 Mar 2008 17:34:46 +0700
Message-ID: <20080302103446.GA8983@laptop>
References: <cover.1204453703.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:35:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlXc-0003Ts-7x
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbYCBKe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbYCBKe6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:34:58 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:54970 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbYCBKe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:34:57 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2353724gve.37
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=MBY9W4fkcMXbn2VrzDk16eTSnZ7PBSSbT0g58omJRj0=;
        b=mXSmO16vxmgt3bw3bXl/eYQEsdWFJdPqwWUYZMnu3tp++qkzT8HE4QJ5RoBP++Y3FsIsTagnaG9Fdq8GBL3ZMhc5HlkL+ky9PabQxBGPKmwXhZllM+nGtDDB7Ghwfpfgallio7tcgsQjgMiccLmsmzu3hPgRav2ICAX30Zk1qww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=W2MAoEXO/VGbHpUiQxJPDIfJHWpRyX0QgX6MhXRmpJlycL7p9vA3K+AbLHrHOyG1ls7HVcjsLo8oOflhKx2YPl6S3Q7BHd6gr5aoqq0Qyx4g4z80ROfSXvpE/QOKEljsNnOva3J+utoNQVI7RNc1f7R3gqcsiwFSYDn7D5Fa1ec=
Received: by 10.114.152.17 with SMTP id z17mr4872001wad.128.1204454095728;
        Sun, 02 Mar 2008 02:34:55 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id m27sm23127799wag.50.2008.03.02.02.34.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:34:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:34:46 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204453703.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75767>

cmd_archive() is registered without RUN_SETUP so its prefix
will be NULL forever. Let's make that clear.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-archive.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index c2e0c1e..84405df 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -236,11 +236,12 @@ static const char *extract_remote_arg(int *ac, co=
nst char **av)
 	return remote;
 }
=20
-int cmd_archive(int argc, const char **argv, const char *prefix)
+int cmd_archive(int argc, const char **argv, const char *unused_prefix=
)
 {
 	struct archiver ar;
 	int tree_idx;
 	const char *remote =3D NULL;
+	const char *prefix;
=20
 	remote =3D extract_remote_arg(&argc, argv);
 	if (remote)
@@ -250,9 +251,8 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
=20
 	memset(&ar, 0, sizeof(ar));
 	tree_idx =3D parse_archive_args(argc, argv, &ar);
-	if (prefix =3D=3D NULL)
-		prefix =3D setup_git_directory();
=20
+	prefix =3D setup_git_directory();
 	argv +=3D tree_idx;
 	parse_treeish_arg(argv, &ar.args, prefix);
 	parse_pathspec_arg(argv + 1, &ar.args);
--=20
1.5.4.2.281.g28d0e
