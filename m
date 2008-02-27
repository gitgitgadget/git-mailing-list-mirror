From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 7/9] builtin-archive: mark unused prefix "unused_prefix"
Date: Wed, 27 Feb 2008 23:40:07 +0700
Message-ID: <20080227164007.GA28099@laptop>
References: <cover.1204130175.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 17:41:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUPL0-00027A-Jw
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 17:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbYB0QkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 11:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbYB0QkS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 11:40:18 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:64403 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbYB0QkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 11:40:17 -0500
Received: by an-out-0708.google.com with SMTP id d31so645327and.103
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=MBY9W4fkcMXbn2VrzDk16eTSnZ7PBSSbT0g58omJRj0=;
        b=Hny2NwMVBqGOQyH0YWwvDer7SAFPAPpTrWliZ4GTe/p6b5cjLoVi2h2QqSF23GcmSpgxxXneJl9+zQKqxhsPWt0zbtpm0CbO3i6LEMD8lB4HQtIR1+fYdhYRqrO7n+LmEd1wLIUPqqCxuOcnZhlRVmKZcKBIy0J+eZqYdspmhYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=s484ZJbuLsNA0exiANSXAPTiBRwXQwc5BB5PaIqwmQ4gxxR26Trte8V5zwWK14eefxMJ4DA9ih5jbi+3GO0piq9wnwhG8bmdVmJZIunyn11ybX1hz6C5FuNUBJFqNKoHn22N2o1PEBQ6DZe8tjKH84Pl6SESGuSyLK06BbW+nPU=
Received: by 10.100.7.1 with SMTP id 1mr12583327ang.59.1204130416785;
        Wed, 27 Feb 2008 08:40:16 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.231])
        by mx.google.com with ESMTPS id s30sm10497050elf.3.2008.02.27.08.40.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 08:40:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Feb 2008 23:40:07 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204130175.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75240>

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
