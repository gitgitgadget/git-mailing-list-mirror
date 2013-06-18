From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation/git-merge.txt: weaken warning about uncommited changes
Date: Tue, 18 Jun 2013 10:42:55 +0200
Message-ID: <1371544975-18703-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: artagnon@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 18 10:43:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UorVb-0007Sh-B9
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 10:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab3FRInL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 04:43:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58224 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827Ab3FRInG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 04:43:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5I8h08G023929
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 10:43:00 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UorVF-0005Fa-A9; Tue, 18 Jun 2013 10:43:01 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1UorVF-0004sM-08; Tue, 18 Jun 2013 10:43:01 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Jun 2013 10:43:00 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228173>

Commit 35d2fffd introduced 'git merge --abort' as a synonym to 'git reset
--merge', and added some failing tests in t7611-merge-abort.sh (search
'###' in this file) showing that 'git merge --abort' could not always
recover the pre-merge state.

Still, in many cases, 'git merge --abort' just works, and it is usually
considered that the ability to start a merge with uncommited changes is
an important property of Git.

Weaken the warning by discouraging only merge with /non-trivial/
uncommited changes.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This is a followup to an old discussion:

http://thread.gmane.org/gmane.comp.version-control.git/221069

I don't think documenting all the failure cases in the doc would be a
good idea, so I've left the "in some cases" part.

 Documentation/git-merge.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 67ca99c..8c7f2f6 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -56,8 +56,8 @@ especially if those changes were further modified after the merge
 was started), 'git merge --abort' will in some cases be unable to
 reconstruct the original (pre-merge) changes. Therefore:
 
-*Warning*: Running 'git merge' with uncommitted changes is
-discouraged: while possible, it leaves you in a state that is hard to
+*Warning*: Running 'git merge' with non-trivial uncommitted changes is
+discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
 
-- 
1.8.3.1.495.g13f33cf.dirty
