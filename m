From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/16] commit: rewrite outgoing commits
Date: Sat, 31 Jul 2010 23:18:24 +0700
Message-ID: <1280593105-22015-16-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:39:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOSs-0003BW-2a
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab0HACjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:39:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49942 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0HACjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:39:44 -0400
Received: by pzk26 with SMTP id 26so976843pzk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fw+s+LYix6R4r+uIqFpxcpPKN6jf3FwCvhJxIjzhUXs=;
        b=UxFv//nPJclgz/BsMu4PY1wVd6tae614K3iCpIg60Ct4JA6xaF+/NAeSMKWSV2rOaF
         tooPmkVNof/m1Ueevdu1/I5dF222fLHk8pgUGy1jHbtgICP3Fn07E+SiBGTu2cMKZJKU
         Z2Acpbbkx2WlRLLgKFwjckAP3A0aOgoZujCvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GBG88gEtfP1n72seoZflPw4ACRnqqOU0YZv/NPfHwbIfD8uD9NbqCNM8KQnwH7mRKn
         Tea2B6NpdWkFzscVIMSolwXs/b3H/KD784iN5Hd5j3dzoeboC1GALL75Yn03IkuJOmMG
         T9J+PRCnNas0pyFNTCfS8KzMVmV0js5C5qNZI=
Received: by 10.114.88.18 with SMTP id l18mr4849402wab.175.1280630384364;
        Sat, 31 Jul 2010 19:39:44 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id 33sm7706670wad.6.2010.07.31.19.39.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:39:43 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:20:36 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152362>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6b4c678..c551d72 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1350,7 +1350,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		exit(1);
 	}
=20
-	if (commit_tree(sb.buf, active_cache_tree->sha1, NULL, parents, commi=
t_sha1,
+	if (commit_tree(sb.buf, active_cache_tree->sha1,
+			parents ? parents->item->object.sha1 : NULL,
+			parents, commit_sha1,
 			fmt_ident(author_name, author_email, author_date,
 				IDENT_ERROR_ON_NO_NAME))) {
 		rollback_index_files();
--=20
1.7.1.rc1.69.g24c2f7
