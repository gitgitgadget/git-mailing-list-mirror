From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Documentation: always respect core.worktree if set
Date: Tue, 29 Dec 2009 14:48:41 +0700
Message-ID: <1262072921-11280-1-git-send-email-pclouds@gmail.com>
References: <7viqbrv4pa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 08:50:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPWpl-0006BG-Q6
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 08:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbZL2Htb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2009 02:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbZL2Htb
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 02:49:31 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:50283 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbZL2Htb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 02:49:31 -0500
Received: by iwn1 with SMTP id 1so7735585iwn.33
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 23:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fD8ad6tPJqufvLFrhdggClBbNBlu2h3bzm8j1l8KF6c=;
        b=kepqtwEujhIab0J6vg1Yshcep9Vu9UVa3PPeUNPUB3bzUO2a6yE3TtRmJvq8HKumR6
         rgXKD61JoIcbgmuGmKXFAu1Jd5oElqE7aP017pAZh9NehWtyJyfHNHfKFKWfJLax37iy
         89W4f5dj/VgFMPPXfvoKWsiiLmJr7DLfP2kDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hSHMytlvws8Z3UGRwEuF2Op0qLjctTLXrz/pSeoTg0oVOdAev5Wns0zPqTUF/e6+gp
         RThOeYSj931+JgeYoRB5UJViXEI1sRtibDzsqthmpPuMkIY6EP3sRryB839V+FD6e9CQ
         WejOWBGfmgoYi9wKIAiUdHYjUviR4mYOZDrNg=
Received: by 10.231.25.199 with SMTP id a7mr1352655ibc.51.1262072969202;
        Mon, 28 Dec 2009 23:49:29 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.227.183])
        by mx.google.com with ESMTPS id 22sm11726381iwn.12.2009.12.28.23.49.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 23:49:27 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 29 Dec 2009 14:48:42 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <7viqbrv4pa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135780>

The value of core.worktree in a ".git/config" is honored even when it
differs from the directory that has the ".git" directory as its
subdirectory.  This is likely to be a misconfiguration, so warn users
about it.  Also, drop the part of the documentation that incorrectly
claimed that we ignore such a misconfigured value.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7d10a21..2eb9758 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -297,17 +297,24 @@ false), while all other repositories are assumed =
to be bare (bare
 =3D true).
=20
 core.worktree::
-	Set the path to the working tree.  The value will not be
-	used in combination with repositories found automatically in
-	a .git directory (i.e. $GIT_DIR is not set).
+	Set the path to the root of the work tree.
 	This can be overridden by the GIT_WORK_TREE environment
 	variable and the '--work-tree' command line option. It can be
-	a absolute path or relative path to the directory specified by
-	--git-dir or GIT_DIR.
-	Note: If --git-dir or GIT_DIR are specified but none of
+	an absolute path or a relative path to the .git directory,
+	either specified by --git-dir or GIT_DIR, or automatically
+	discovered.
+	If --git-dir or GIT_DIR are specified but none of
 	--work-tree, GIT_WORK_TREE and core.worktree is specified,
-	the current working directory is regarded as the top directory
-	of your working tree.
+	the current working directory is regarded as the root of the
+	work tree.
++
+Note that this variable is honored even when set in a configuration
+file in a ".git" subdirectory of a directory, and its value differs
+from the latter directory (e.g. "/path/to/.git/config" has
+core.worktree set to "/different/path"), which is most likely a
+misconfiguration.  Running git commands in "/path/to" directory will
+still use "/different/path" as the root of the work tree and can cause
+great confusion to the users.
=20
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
--=20
1.6.5.2.216.g9c1ec
