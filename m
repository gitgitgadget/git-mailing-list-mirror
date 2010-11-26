From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 46/47] Revert "Documentation: always respect core.worktree if set"
Date: Fri, 26 Nov 2010 22:32:42 +0700
Message-ID: <1290785563-15339-47-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:51:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0a8-00026L-L5
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab0KZPvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:51:24 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:53985 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271Ab0KZPvX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:51:23 -0500
Received: by pzk26 with SMTP id 26so458657pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ni8r0cXVtgmGIlKCjPIaKkUBdz6meQB2iwAPuI+YNcM=;
        b=lg+9tmDRWVx3LombbZsuKPQaBdDVTt5cgfyqZN1BRdB071BO8eZ809zmrMi3Cdzp2Z
         Wfysu3lBA5l0TvnA/eZM6fahtAgV2TbqvtXfAp58kZIQDy7jDMM2mtOFbgWdqobtmyaD
         h9/h+Ds1ki0rrnD9JU7a+v3+yWBqMJsunaPAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XgDegtmXf7c6zT5HoDqIXV8MlNthbgoefCsQKslXvFL5ejad7+mLknU/ykHr3RXI2L
         zkpqHagDOKZwQer8hj6iF+98xaBdMDeIPqN+gIHBpADYZyU9VWcRvjTVMhiAv1cdayti
         33InKT5wO6GjC+UUOgm/clLig8z2enfzlJf+I=
Received: by 10.142.109.18 with SMTP id h18mr2525387wfc.196.1290786683155;
        Fri, 26 Nov 2010 07:51:23 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id v19sm2698183wfh.0.2010.11.26.07.51.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:51:22 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:50:09 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162254>

This reverts commit f5e025a9d5b35e24768475f6890b836ce0d5ed15.

The commit reflected what the code did. But the code did that because
it had bugs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 538ebb5..e29b174 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -317,24 +317,17 @@ false), while all other repositories are assumed =
to be bare (bare
 =3D true).
=20
 core.worktree::
-	Set the path to the root of the work tree.
+	Set the path to the working tree.  The value will not be
+	used in combination with repositories found automatically in
+	a .git directory (i.e. $GIT_DIR is not set).
 	This can be overridden by the GIT_WORK_TREE environment
 	variable and the '--work-tree' command line option. It can be
-	an absolute path or a relative path to the .git directory,
-	either specified by --git-dir or GIT_DIR, or automatically
-	discovered.
-	If --git-dir or GIT_DIR are specified but none of
+	a absolute path or relative path to the directory specified by
+	--git-dir or GIT_DIR.
+	Note: If --git-dir or GIT_DIR are specified but none of
 	--work-tree, GIT_WORK_TREE and core.worktree is specified,
-	the current working directory is regarded as the root of the
-	work tree.
-+
-Note that this variable is honored even when set in a configuration
-file in a ".git" subdirectory of a directory, and its value differs
-from the latter directory (e.g. "/path/to/.git/config" has
-core.worktree set to "/different/path"), which is most likely a
-misconfiguration.  Running git commands in "/path/to" directory will
-still use "/different/path" as the root of the work tree and can cause
-great confusion to the users.
+	the current working directory is regarded as the top directory
+	of your working tree.
=20
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
--=20
1.7.3.2.316.gda8b3
