Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F30C2FB
	for <git@vger.kernel.org>; Sat,  3 May 2025 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746234943; cv=none; b=iqEW1ea/vBBQOkuzJqSoNST607nYMxVePoAZOf2WXB2/BB4ejh7S+TChGRUaHGI+8JrHSJeXGFcPoRFSNBoShsPwSPyAZVU5nzHrkyvrNAF0hvZlg4lcfkSKAvepL0eE2++GztQVSvsWvUaWD4XplV4Eu1PW+5K20B0XeHr83q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746234943; c=relaxed/simple;
	bh=EWOLJ8rwqBzTlXzgaZeW50GQPX0ga7DGDgwnUhnsWHk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+CeG9ehaDBI7hZ1PZcdWxJPo2KFDCdy2fGfMDJ2hkX+toaiNJgI97fmwi+dVxfa0em062FWqtklKthHpL/gqW7KFFLrVRAyxMnTJOvqDemZ7Pp2o+4WA/ZYEwuW7TsvfSCgjqndXynGqzjFX2RCTGDZbjytLQJqZL0aKKzc3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mY5xxdoG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jb3InJKR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mY5xxdoG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jb3InJKR"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D43061380F96;
	Fri,  2 May 2025 21:15:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 02 May 2025 21:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746234940; x=
	1746321340; bh=Xvh6KVsA5ejBnCzEb7JwwWZMdXKzcmoFDOYRCotKqms=; b=m
	Y5xxdoGTnU5+r8oukrL1PltHtJBo0rJporz2xb88+mP0H5enJfG5xkR92yvBC0b0
	6zbF6IM/3cTPbuT5ANz4H2brzE6TfP0D3A4dibCnRUq8OTjsAIYkYoHabGyMG3B+
	zehBBxbYs6/tv+hm/w6u4y9FmItitWzPKL40u5167AkD+FtZZVKmPpMKXZwx8qzi
	pcAISbOlOVQj+2TWpLQ7PNGlpYtu6zLCf+1LMGiixj0sW0OxEqNLPSekFimyyrpG
	oNd50Qx4kmdn0Otu3mANlvixVNLO9u6HHxrXe5HgljoUOMfrsUQrCIlsQI7TTPrB
	TTSqScwpLIVnrTVI+QUaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746234940; x=1746321340; bh=Xvh6KVsA5ejBnCzEb7JwwWZMdXKz
	cmoFDOYRCotKqms=; b=Jb3InJKR+MmiT9VwKxhgs1xW1j+RwR5VlLFRHgHdqwsT
	3+7WtoWVRVNva0ZOqJkHmNKa1TpGULAVEiY8s7Ec3Z2hQCuRhg3oLX9UZpNMArfS
	CN8ofr5DL+fwbyywOOnnh3KULLbLL49GEDsdAiw/YT2TEjA4yYGYHS2JnSFc5Tn7
	DcNIbToQRDb8NonK3auN1EvVmx3ODAsA8oimWHx62mUz1ABGiekfZNLPHwoqVEcb
	QY91Wq8pfWHWA2+0nB7dBv6DuygL/5mjJ3ISHZkbu3GDY0mhrThwoTtKg1SMRjaQ
	sy4mvBxcNzYV65rIgcyltkaflkR6QXXxTTPwCg8yHw==
X-ME-Sender: <xms:PG4VaPywS-O6eKkBZ2K4R33eL7iBtcBecQc_z3vErMBCxySlIkOsZg>
    <xme:PG4VaHTfgsAC4GVS69v4J695inR_loihh3kwrgvdYI41DvS-uj-IcGy9JfLcE7EGn
    qQVHgozfLh93lX3Gw>
X-ME-Received: <xmr:PG4VaJW0yxo1WZVLqj-SKPXnXulvw1iYYy4DZDLcGFAcPm5V1S6CFJGFQzSkoaWe6FEPeVIFGbpGw-mFkT6wQSqNwlfLtYs74H9i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PG4VaJgtOWH8bVDvEmNGhRAkxiVu-2kwv8bxRtilIFV_jeK9wX1ijQ>
    <xmx:PG4VaBC-stjezUilFIdKwtTcB58dbBzm0p8M172n-3V-W2FHnMN13g>
    <xmx:PG4VaCLpg3L0vp74LwQMx8VyyZnjkCiJVUyZ7c1zf7oqGe8oo8nlWA>
    <xmx:PG4VaABhlB8quotUiYrfKBU0mLwGGmvb8xVtXQU86rGmBX4DsoPiLw>
    <xmx:PG4VaDz5OLDK1zOIxOr9bfp4pVPFJvI_-OqdSTjjOzf8Ourw6e_GOUYM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 21:15:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/3] git-verify-* doc: update mark-up of synopsis option descriptions
Date: Fri,  2 May 2025 18:15:35 -0700
Message-ID: <20250503011537.3035416-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-601-ga5925c3955
In-Reply-To: <20250503011537.3035416-1-gitster@pobox.com>
References: <20250501213414.370514-1-gitster@pobox.com>
 <20250503011537.3035416-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To unify mark-up used in our documentation to a newer convention,
started by 22293895 (doc: apply synopsis simplification on git-clone
and git-init, 2024-09-24), update the documentation pages for 'git
verify-commit', 'git verify-tag', and 'git verify-pack' to

 * use [synopsis], not [verse] in the SYNOPSIS section
 * enclose `--option=<value>` in backquotes
 * do not describe non-option arguments in the OPTIONS section

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-verify-commit.adoc | 16 +++++++---------
 Documentation/git-verify-pack.adoc   | 28 ++++++++++++----------------
 Documentation/git-verify-tag.adoc    | 16 +++++++---------
 3 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-verify-commit.adoc b/Documentation/git-verify-commit.adoc
index aee4c40eac..ff5b8b97ef 100644
--- a/Documentation/git-verify-commit.adoc
+++ b/Documentation/git-verify-commit.adoc
@@ -7,26 +7,24 @@ git-verify-commit - Check the GPG signature of commits
 
 SYNOPSIS
 --------
-[verse]
-'git verify-commit' [-v | --verbose] [--raw] <commit>...
+[synopsis]
+git verify-commit [-v | --verbose] [--raw] <commit>...
 
 DESCRIPTION
 -----------
-Validates the GPG signature created by 'git commit -S'.
+Validates the GPG signature created by `git commit -S`
+on the commit objects given on the command line.
 
 OPTIONS
 -------
---raw::
+`--raw`::
 	Print the raw gpg status output to standard error instead of the normal
 	human-readable output.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Print the contents of the commit object before validating it.
 
-<commit>...::
-	SHA-1 identifiers of Git commit objects.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-verify-pack.adoc b/Documentation/git-verify-pack.adoc
index d7e886918a..b0462d8db3 100644
--- a/Documentation/git-verify-pack.adoc
+++ b/Documentation/git-verify-pack.adoc
@@ -8,43 +8,39 @@ git-verify-pack - Validate packed Git archive files
 
 SYNOPSIS
 --------
-[verse]
-'git verify-pack' [-v | --verbose] [-s | --stat-only] [--] <pack>.idx...
+[synopsis]
+git verify-pack [-v | --verbose] [-s | --stat-only] [--] <pack>.idx...
 
 
 DESCRIPTION
 -----------
-Reads given idx file for packed Git archive created with the
-'git pack-objects' command and verifies the idx file and the
-corresponding pack file.
+Read each idx file for packed Git archive given on the command line,
+and verify the idx file and the corresponding pack file.
 
 OPTIONS
 -------
-<pack>.idx ...::
-	The idx files to verify.
-
--v::
---verbose::
+`-v`::
+`--verbose`::
 	After verifying the pack, show the list of objects contained
 	in the pack and a histogram of delta chain length.
 
--s::
---stat-only::
+`-s`::
+`--stat-only`::
 	Do not verify the pack contents; only show the histogram of delta
 	chain length.  With `--verbose`, the list of objects is also shown.
 
-\--::
+`--`::
 	Do not interpret any more arguments as options.
 
 OUTPUT FORMAT
 -------------
-When specifying the -v option the format used is:
+When specifying the `-v` option the format used is:
 
-	SHA-1 type size size-in-packfile offset-in-packfile
+	object-name type size size-in-packfile offset-in-packfile
 
 for objects that are not deltified in the pack, and
 
-	SHA-1 type size size-in-packfile offset-in-packfile depth base-SHA-1
+	object-name type size size-in-packfile offset-in-packfile depth base-object-name
 
 for objects that are deltified.
 
diff --git a/Documentation/git-verify-tag.adoc b/Documentation/git-verify-tag.adoc
index 81d50ecc4c..ec995323f6 100644
--- a/Documentation/git-verify-tag.adoc
+++ b/Documentation/git-verify-tag.adoc
@@ -7,26 +7,24 @@ git-verify-tag - Check the GPG signature of tags
 
 SYNOPSIS
 --------
-[verse]
-'git verify-tag' [-v | --verbose] [--format=<format>] [--raw] <tag>...
+[synopsis]
+git verify-tag [-v | --verbose] [--format=<format>] [--raw] <tag>...
 
 DESCRIPTION
 -----------
-Validates the gpg signature created by 'git tag'.
+Validates the gpg signature created by 'git tag' in the tag
+objects listed on the command line.
 
 OPTIONS
 -------
---raw::
+`--raw`::
 	Print the raw gpg status output to standard error instead of the normal
 	human-readable output.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Print the contents of the tag object before validating it.
 
-<tag>...::
-	SHA-1 identifiers of Git tag objects.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.49.0-601-ga5925c3955

