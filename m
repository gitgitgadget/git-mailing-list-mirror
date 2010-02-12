From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2] Documentation: describe --thin more accurately
Date: Fri, 12 Feb 2010 00:00:46 -0800
Message-ID: <1265961646-28585-1-git-send-email-bebarino@gmail.com>
References: <1265778851-5397-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 09:00:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfqSP-0006km-4r
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 09:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab0BLIAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 03:00:52 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:46891 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab0BLIAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 03:00:51 -0500
Received: by iwn39 with SMTP id 39so394644iwn.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 00:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5R2MM0hdCNLeSV0At4X1Q+Cgxjib9Zlrx5A0oMd3YFE=;
        b=LbfW2/epoQ7ymfxF5ULfV7dEn39dEFSfC/awfKpaOr1SBOpS60/7SSDqOmsHJ6Xbru
         P9MMHrUL1QVOb5u1ei/MAThGkktz6RlCxyIS4Ty44q2ayHON04gdU5ZzDt2t02MRnZ4+
         bEyO1ThRZ74d6YeIp1XJrjzCs5jCbnqld32uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tqkBguyV3RVo//XJIKZ6rCmnOxYw/dKk5f8jkb9sKA93/fPY53LRKe6PqQLPETcvhq
         Bf4nZ/0kIsJ/2whjkm4hCS2rt17Lwb7JAj9RLROlW92Xc+qDe2AzOuRSFyVcgMYkgx0H
         1cfxAtqtJoL5kLIEEo0605ISU1iRyVM5DMF3Y=
Received: by 10.231.182.142 with SMTP id cc14mr1578369ibb.81.1265961650129;
        Fri, 12 Feb 2010 00:00:50 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm2718262iwn.6.2010.02.12.00.00.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 00:00:49 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc2.28.gf476c0
In-Reply-To: <1265778851-5397-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139660>

The description for --thin was misleading and downright wrong. Correct
it with some inspiration from the description of index-pack's --fix-thin
and some background information from Nicolas Pitre <nico@fluxnic.net>.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Changes since v1:
 - No longer bollocks ;-)
 - Document --thin for pack-object

 Documentation/git-fetch-pack.txt   |    6 ++++--
 Documentation/git-index-pack.txt   |    4 ++--
 Documentation/git-pack-objects.txt |    8 ++++++++
 Documentation/git-push.txt         |    7 ++++---
 Documentation/git-send-pack.txt    |    6 ++++--
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index e9952e8..c428f6d 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -44,8 +44,10 @@ OPTIONS
 	locked against repacking.
 
 --thin::
-	Spend extra cycles to minimize the number of objects to be sent.
-	Use it on slower connection.
+	Fetch a "thin" pack, which records objects in deltified form based
+	on objects not included in the pack to reduce network traffic.
+	The excluded objects are expected to be present on the receiving
+	end.
 
 --include-tag::
 	If the remote side supports it, annotated tags objects will
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 65a301b..73fe51a 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -46,10 +46,10 @@ OPTIONS
 	'git repack'.
 
 --fix-thin::
-	It is possible for 'git pack-objects' to build
+	It is possible for 'git pack-objects' to build a
 	"thin" pack, which records objects in deltified form based on
 	objects not included in the pack to reduce network traffic.
-	Those objects are expected to be present on the receiving end
+	The excluded objects are expected to be present on the receiving end
 	and they must be included in the pack for that pack to be self
 	contained and indexable. Without this option any attempt to
 	index a thin pack will fail. This option only makes sense in
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index ffd5025..f32c322 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -179,6 +179,14 @@ base-name::
 	Add --no-reuse-object if you want to force a uniform compression
 	level on all data no matter the source.
 
+--thin::
+	Create a "thin" pack, which records objects in deltified form based
+	on objects not included in the pack to reduce network traffic.
+	The excluded objects are expected to be present on the receiving end
+	and eventually must be included in the pack for that pack to be self
+	contained and indexable. This option only makes sense in
+	conjunction with --stdout.
+
 --delta-base-offset::
 	A packed archive can express base object of a delta as
 	either 20-byte object name or as an offset in the
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index bd79119..c67b06c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -141,9 +141,10 @@ useful if you write an alias or script around 'git push'.
 
 --thin::
 --no-thin::
-	These options are passed to 'git send-pack'.  Thin
-	transfer spends extra cycles to minimize the number of
-	objects to be sent and meant to be used on slower connection.
+	These options are passed to linkgit:git-send-pack[1]. A thin transfer
+	significantly reduces the number of sent objects when the sender and
+	receiver share many of the same objects in common. The default is
+	\--thin.
 
 -v::
 --verbose::
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 8178d92..1d7c4d4 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -48,8 +48,10 @@ OPTIONS
 	Run verbosely.
 
 --thin::
-	Spend extra cycles to minimize the number of objects to be sent.
-	Use it on slower connection.
+	Send a "thin" pack, which records objects in deltified form based
+	on objects not included in the pack to reduce network traffic.
+	The excluded objects are expected to be present on the receiving
+	end.
 
 <host>::
 	A remote host to house the repository.  When this
-- 
1.7.0.rc2.28.gf476c0
