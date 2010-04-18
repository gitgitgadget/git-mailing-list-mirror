From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH 1/2] SubmittingPatches: Add new section about what to base work on
Date: Mon, 19 Apr 2010 01:24:20 +0530
Message-ID: <1271620400-sup-4850@kytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 21:56:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3abW-0008Iq-BL
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 21:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab0DRT4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 15:56:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59498 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab0DRT4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 15:56:24 -0400
Received: by gyg13 with SMTP id 13so2265239gyg.19
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:date:message-id:user-agent:content-transfer-encoding;
        bh=HkcNwph2UVyTOe1tB4Cd5IOlddBYjpqKFWZHZ28SfyM=;
        b=euTRHLiGWQJFDmT5MdzwEd3drNEVy21wrKSRo/lXKrY/p0ISjE6m3nxmZR6/T/Jjoz
         /hETLo04LtkUnKGl+V2SgMVCDAdaUcBOwicMgFLj+5pHKA9zmwF6YsV6k8lSEnNo0VW1
         ueoX8m/XT+oH9MqmQQP2wedZZpj9Cg9cDprFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:date:message-id:user-agent
         :content-transfer-encoding;
        b=pxgvVnmxUf2ngfNmh5cAZYGaOSE9QdZuuWCxepxVkaQ7IkWmIeyF/AM6XSA6oI3VBZ
         iGL1TsTHchFJ9qBdrvh8tkFFH1K3o0KL5YF3Ghfihxw2GudZI/9FdcLgdKVc6gsZscqg
         cO2wk05SrlPmFJpHC3/aWJtbbqhAL48VozjoY=
Received: by 10.150.209.2 with SMTP id h2mr336042ybg.36.1271620582926;
        Sun, 18 Apr 2010 12:56:22 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 20sm4228296iwn.9.2010.04.18.12.56.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Apr 2010 12:56:22 -0700 (PDT)
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145240>

Add a section 0 explaining which commit to base patches on. Rewrite a
couple of paragraphs about signing off patches to reflect Junio's
updated preferences.

From: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/SubmittingPatches |   52 ++++++++++++++++++++++++++++++--------
 1 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index abc65de..a90155c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -53,6 +53,37 @@ But the patch submission requirements are a lot more relaxed
 here on the technical/contents front, because the core GIT is
 thousand times smaller ;-).  So here is only the relevant bits.
 
+(0) Decide what to base your work on.
+
+The general principle is always to base your work on the oldest branch
+that your change is relevant to.
+
+ - A fix for a bug that has been with git from older releases should be
+   included in both the upcoming feature release and the current
+   maintenance release.  Try to base your work on the 'maint' branch.  A
+   work to kill a bug that is in 'master' but not in 'maint' should be
+   based on 'master'.
+
+ - A fix for a bug that is not yet in 'master' is the best bug to kill.
+   If you can find the topic that introduces the regression, base your
+   work on the tip of the topic.  "log --first-parent master..pu" would be
+   a good way to find the tips of topic branches.
+
+ - A new feature should be based on the 'master' branch in general.
+
+ - If your new feature depends on some other topics that are not in
+   'master' yet, and if it relies only on one topic, base your work on the
+   tip of that topic.  If it depends on too many topics that are not in
+   'master', you can privately start working on 'next' or even 'pu' and
+   send out your patches for discussion, but it is possible that your
+   maintainer may ask you to wait and rebase your changes on 'master'
+   after some of the larger topics your topic depends on graduate to
+   'master'.
+
+ - Base corrections and enhancements on a topic that are not in 'master'
+   yet but already merged to 'next' on the tip of the topic.  If the topic
+   has not been merged to 'next', it is Ok to add a note that the patch is
+   a trivial fix and can be squashed into the series.
 
 (1) Make separate commits for logically separate changes.
 
@@ -170,17 +201,16 @@ patch, format it as "multipart/signed", not a text/plain message
 that starts with '-----BEGIN PGP SIGNED MESSAGE-----'.  That is
 not a text/plain, it's something else.
 
-Note that your maintainer does not necessarily read everything
-on the git mailing list.  If your patch is for discussion first,
-send it "To:" the mailing list, and optionally "cc:" him.  If it
-is trivially correct or after the list reached a consensus, send
-it "To:" the maintainer and optionally "cc:" the list for
-inclusion.
-
-Also note that your maintainer does not actively involve himself in
-maintaining what are in contrib/ hierarchy.  When you send fixes and
-enhancements to them, do not forget to "cc: " the person who primarily
-worked on that hierarchy in contrib/.
+Unless your patch is a very trivial and an obviously correct one,
+first send it with "To:" set to the mailing list, with "cc:" listing
+people who are involved in the area you are touching (the output from
+"git blame $path" and "git shortlog --no-merges $path" would help to
+identify them), to solicit comments and reviews.  After the list
+reached a consensus that it is a good idea to apply the patch, re-send
+it with "To:" set to the maintainer and optionally "cc:" the list for
+inclusion.  Do not forget to add trailers such as "Acked-by:",
+"Reviewed-by:" and "Tested-by:" after your "Signed-off-by:" line as
+necessary.
 
 
 (4) Sign your work
-- 
1.7.0.4
