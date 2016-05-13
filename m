From: Fox in the shell <KellerFuchs@hashbang.sh>
Subject: [PATCH] Documentation: clarify signature verification
Date: Fri, 13 May 2016 09:51:01 +0000
Message-ID: <1463133061-6834-1-git-send-email-KellerFuchs@hashbang.sh>
References: <20160409200756.GA22694@hashbang.sh>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>,
	Keller Fuchs <kellerfuchs@hashbang.sh>,
	Keller Fuchs <KellerFuchs@hashbang.sh>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 11:52:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b19lb-0008Eq-1R
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 11:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbcEMJwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 05:52:09 -0400
Received: from mail.hashbang.sh ([104.236.230.244]:53506 "EHLO
	mail.hashbang.sh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbcEMJwI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 05:52:08 -0400
Received: from to1.hashbang.sh (to1.hashbang.sh [104.245.37.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.hashbang.sh (Postfix) with ESMTPS id 48AAFA4B0;
	Fri, 13 May 2016 09:52:07 +0000 (UTC)
Received: by to1.hashbang.sh (Postfix, from userid 3412)
	id 973D9E00BF; Fri, 13 May 2016 09:51:48 +0000 (UTC)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20160409200756.GA22694@hashbang.sh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294518>

From: Keller Fuchs <kellerfuchs@hashbang.sh>

Uniformise the vocabulary used wrt. key/signature validity with OpenPGP:
- a signature is valid if made by a key with a valid uid;
- in the default trust-model, a uid is valid if signed by a trusted key;
- a key is trusted if the (local) user set a trust level for it.

Helped-by:     Junio C Hamano <gitster@pobox.com>
Signed-off-by: Keller Fuchs   <KellerFuchs@hashbang.sh>
---
 Documentation/merge-options.txt  | 7 +++++--
 Documentation/pretty-formats.txt | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index f08e9b8..30808a0 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -89,8 +89,11 @@ option can be used to override --squash.
 
 --verify-signatures::
 --no-verify-signatures::
-	Verify that the commits being merged have good and trusted GPG signatures
-	and abort the merge in case they do not.
+	Verify that the tip commit of the side branch being merged is
+	signed with a valid key, i.e. a key that has a valid uid: in the
+	default trust model, this means the signing key has been signed by
+	a trusted key.  If the tip commit of the side branch is not signed
+	with a valid key, the merge is aborted.
 
 --summary::
 --no-summary::
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 671cebd..29b19b9 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -143,8 +143,8 @@ ifndef::git-rev-list[]
 - '%N': commit notes
 endif::git-rev-list[]
 - '%GG': raw verification message from GPG for a signed commit
-- '%G?': show "G" for a Good signature, "B" for a Bad signature, "U" for a good,
-  untrusted signature and "N" for no signature
+- '%G?': show "G" for a good (valid) signature, "B" for a bad signature,
+  "U" for a good signature with unknown validity and "N" for no signature
 - '%GS': show the name of the signer for a signed commit
 - '%GK': show the key used to sign a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}`
-- 
2.1.4
