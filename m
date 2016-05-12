From: Fox in the shell <KellerFuchs@hashbang.sh>
Subject: [PATCH] Documentation: clarify signature verification v2
Date: Thu, 12 May 2016 06:50:22 +0000
Message-ID: <20160512065022.GA32387@hashbang.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 08:50:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0kSN-0005kR-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 08:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbcELGun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 02:50:43 -0400
Received: from mail.hashbang.sh ([104.236.230.244]:45242 "EHLO
	mail.hashbang.sh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbcELGun (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 02:50:43 -0400
Received: from to1.hashbang.sh (to1.hashbang.sh [104.245.37.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.hashbang.sh (Postfix) with ESMTPS id 9D0BE9529;
	Thu, 12 May 2016 06:50:41 +0000 (UTC)
Received: by to1.hashbang.sh (Postfix, from userid 3412)
	id AF9C3E00BE; Thu, 12 May 2016 06:50:22 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294395>

Hi,

Here is a second attempt at this patch.
Sorry for the delay, life somewhat got in the way.

--
Clarify which commits need to be signed.

Uniformise the vocabulary used wrt. key/signature validity with OpenPGP:
- a signature is valid if made by a key with a valid uid;
- in the default trust-model, a uid is valid if signed by a trusted key;
- a key is trusted if the (local) user set a trust level for it.

Thanks to Junio C Hamano <gitster@pobox.com> for reviewing
  the first attempt at this patch.
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
