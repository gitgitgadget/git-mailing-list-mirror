Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060A548F0
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532019; cv=none; b=CKTNO2ySsmizELcm4SdyXyeKYnhSWigfvrhQfR5unykcEa3I6wLpzvewmIUEp7StvP2DJNC4NFlU4HyktxnFf/Q2UDmHDjrdvGIRNzZl+xi2ktlTIZ8SKLIPRFSqTcW4CMk4RJQ5EI/EQxUIXqBA7PYP1vABZw/I86XjcMPa8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532019; c=relaxed/simple;
	bh=Ka5Cjs70+6pU9eIPGJj+hJfBDJq6YqNeVh3vxWfJhYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUkMpa710G2onbcr8nWtgpHPxJlwTzygpDSRwbMrE3O/q6BOrGTHJQeN0MYZbJJ0UuIuIqifopxhTThxXdHEZbnTji5sU8csOIIldg87uF8yFtQ7/K5ZsugFH0npRBk+wgSfztyQ+kmchCqZjic+eYSiFnNZfh1hbCR4iPhKAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDW2-000000002GF-0l17
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:54 +0100
Received: from [10.20.10.233] (port=35730 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDW1-006ash-0A;
	Fri, 15 Mar 2024 20:46:53 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id B71AE1800FD;
	Fri, 15 Mar 2024 20:46:51 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:51 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 20/22] t/t9*: merge "grep | sed" pipelines
Date: Fri, 15 Mar 2024 20:46:17 +0100
Message-ID: <20240315194620.10713-21-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315194620.10713-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t9118-git-svn-funky-branch-names.sh | 2 +-
 t/t9350-fast-export.sh                | 2 +-
 t/t9824-git-p4-git-lfs.sh             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index a159ff96b718..d3261e35b818 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -38,7 +38,7 @@ test_expect_success 'setup svnrepo' '
 # SVN 1.7 will truncate "not-a%40{0]" to just "not-a".
 # Look at what SVN wound up naming the branch and use that.
 # Be sure to escape the @ if it shows up.
-non_reflog=$(svn_cmd ls "$svnrepo/pr ject/branches" | grep not-a | sed 's/\///' | sed 's/@/%40/')
+non_reflog=$(svn_cmd ls "$svnrepo/pr ject/branches" | sed -ne '/not-a/ { s/\///; s/@/%40/; p }')
 
 test_expect_success 'test clone with funky branch names' '
 	git svn clone -s "$svnrepo/pr ject" project &&
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index d86d07a79d4f..1eb035ee4ce5 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -537,7 +537,7 @@ test_expect_success 'full-tree re-shows unmodified files'        '
 
 test_expect_success 'set-up a few more tags for tag export tests' '
 	git checkout -f main &&
-	HEAD_TREE=$(git show -s --pretty=raw HEAD | grep tree | sed "s/tree //") &&
+	HEAD_TREE=$(git show -s --pretty=raw HEAD | sed -n "/tree/s/tree //p") &&
 	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
 	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
 	git tag    tag-obj_tag     -m "tagging a tag" tree_tag-obj &&
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index fd430403d716..80c8c31e320f 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -18,7 +18,7 @@ test_file_in_lfs () {
 	sed -n '3,3 p' "$FILE" | grep "^size " &&
 	test_line_count = 3 "$FILE" &&
 	grep "size $SIZE" "$FILE" &&
-	HASH=$(grep "oid sha256:" "$FILE" | sed -e "s/oid sha256://g") &&
+	HASH=$(sed -ne "/oid sha256:/s/oid sha256://gp" "$FILE") &&
 	LFS_FILE=".git/lfs/objects/$(echo "$HASH" | cut -c1-2)/$(echo "$HASH" | cut -c3-4)/$HASH" &&
 	echo $EXPECTED_CONTENT >expect &&
 	test_path_is_file "$FILE" &&
-- 
2.44.0

