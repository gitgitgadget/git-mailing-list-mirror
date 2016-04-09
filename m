From: The Fox in the Shell <KellerFuchs@hashbang.sh>
Subject: [PATCH] Documentation: clarify signature verification
Date: Sat, 9 Apr 2016 20:08:39 +0000
Message-ID: <20160409200756.GA22694@hashbang.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 22:17:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aozJr-0002ST-Ky
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 22:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbcDIURS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 16:17:18 -0400
Received: from mail.hashbang.sh ([104.236.230.244]:36194 "EHLO
	mail.hashbang.sh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbcDIURR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 16:17:17 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Apr 2016 16:17:17 EDT
Received: from to1.hashbang.sh (to1.hashbang.sh [104.245.37.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.hashbang.sh (Postfix) with ESMTPS id 2E31C37F8;
	Sat,  9 Apr 2016 20:08:59 +0000 (UTC)
Received: by to1.hashbang.sh (Postfix, from userid 3412)
	id 0D0A9E00BA; Sat,  9 Apr 2016 20:08:39 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291123>

Hi,

I encountered some issues with the git documentation while modifying
my deployment scripts to enforce that the tree being fetched was
signed by a trusted key.

It was unclear which commits needed to be signed (in the case of `git
merge`) and what were the criteria for the signature to be considered
valid.

Here is a patch proposal.

Signed-off-by: The Fox in the Shell <KellerFuchs@hashbang.sh>
---
 Documentation/merge-options.txt  | 4 +++-
 Documentation/pretty-formats.txt | 4 ++--
 Documentation/pretty-options.txt | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index f08e9b8..edd50bf 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -89,8 +89,10 @@ option can be used to override --squash.
 
 --verify-signatures::
 --no-verify-signatures::
-	Verify that the commits being merged have good and trusted GPG signatures
+	Verify that the commits being merged have good and valid GPG signatures
 	and abort the merge in case they do not.
+	For instance, when running `git merge --verify-signature remote/branch`,
+	only the head commit on `remote/branch` needs to be signed.
 
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
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 54b88b6..62cbae2 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -78,5 +78,5 @@ being displayed. Examples: "--notes=foo" will show only notes from
 endif::git-rev-list[]
 
 --show-signature::
-	Check the validity of a signed commit object by passing the signature
-	to `gpg --verify` and show the output.
+	Check the validity of a signed commit object, by passing the signature
+	to `gpg --verify`, and show the output.
-- 
2.1.4
