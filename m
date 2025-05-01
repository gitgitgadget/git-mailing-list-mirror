Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6A213E94
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135261; cv=none; b=gv7vPIjwD4og7SEk4+wVQnGJbiLU9kHkNrzhPceDsCjzv90gA/xXnoZ8A8F1mggY/rfNfYTc/pzpGgqCLn4sCUZaPK8QPQb74k7+MuLxhxXs+7XpwEr1Jb/TV4Di+7Z2y73lH4nzUKUBRr7TEfGtkheAaXFbBmxSBeh9k5rOXDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135261; c=relaxed/simple;
	bh=HBAPilbvTTS7HvQKXiSjKU5oVAA0LeNk1gpQtVDSaeg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i06nX4WmBUx4sOM8Bx6ff+ZRUN/L5Zb2lqu8zAlOFr2V1VWX173uXKbC+LYlP1zsZOIYR1k3LXBzfDMJ9vTme5jK/DmwjdwHlpH4z8gHXjNeYWlnWUdGHu+2Mc/BhnRWFtr9NJo6CaoniJTaXW1wpO54RTTgtBBs8OxXn4354ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dG5gKr6w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5QjT9zL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dG5gKr6w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5QjT9zL"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3DB11140281;
	Thu,  1 May 2025 17:34:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 01 May 2025 17:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746135257; x=
	1746221657; bh=QkV0bsSqUKmHNjXCuzsRLAcO5c6ZpT+C8d57nimrB/g=; b=d
	G5gKr6wHOcobHuj+IjKJQN/4JyRc4cm6wVXqzmVmNg2HbPkKvyA6fJIQw1rf38SI
	0wOmFVLG2otbVHZNMm0iGoSROfH2N/01+ID5aBaheHnANJlUi6jrdor2lnW5YaTV
	4YMbNVjYXfEv9bffrdvC8kQMxuszNCp/i7qbzXWWRQyl9t5Nk66hSIMeG0Z2AVT/
	yJnqXSoG08NLMoLImV7bNE44pdWs1drYsNbXgHaE1XUY8ptLjfZbgW0I4cOwENzy
	DoCQTFjAiliVxKSbb980O9UdjIelaAJlIPOJdIp99GrSoMT1yRM6VXtWbmLp5+XZ
	fonvmv/Y2JSy6XOhLMwsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746135257; x=1746221657; bh=QkV0bsSqUKmHNjXCuzsRLAcO5c6Z
	pT+C8d57nimrB/g=; b=Z5QjT9zL2EV00puyX3LSKgTSoyHVW1wQGtXQljLN7Dkg
	g9XS4DSBN1VOgux3YfdFVzczg84tkCTvxZPjoFcm45jN3fG62VOE9jkn1KPC4MvO
	HmtlGeBJytjI/T7G+INAlzJHos1cfvrE3p8szYF3NzFbAYmcUk4qR2wIg7ImlFx7
	WVMaFuwfsktYajJiaXAeE3o+oHWd+YN6kvHP4k5q92dPlBNKdNgtgHbtzZLgiXyN
	TkMjCwCtd/SeosnjCmt4v6BRbLSKAt3PY655eMkSb0+OkohWkLw+R/vBC25I753o
	JkanvoUGddqTzyl7Ldr126M0bAwbiYXGaLCujtTUrw==
X-ME-Sender: <xms:2egTaF5dPgx9pSSeqAbtjh5FVc6JApwhO400Js__GBIqjKUNOEQI9g>
    <xme:2egTaC5RDh2gOYQvKSFS9ZYOpK1iYxInuIKnrkUluKV8aagixgB1Vhp4IxOj4x4-9
    LsIveK5VDsuX84sPQ>
X-ME-Received: <xmr:2egTaMc80O0_lbz2UHRmmtOUfUBiyT6uq6VXso22DojhU3gWY-R6tWhPRcz3jYoZ5kytURfW0a0qYwSHSu1oar915p06w-igvxDz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2egTaOIWnDbE52BoyGUO3Yf1MRI56Kc_qyq_DbUGFw5dCh_l_QGeyQ>
    <xmx:2egTaJKOoM2VcREp499a0x_VyWGk0BXFAIkrtKYgMotOJ6eeLvd32A>
    <xmx:2egTaHx88lipL3umL1UPn8glVmZikqWF8t93fp2j75ztUSttaU-bzA>
    <xmx:2egTaFL6A3ihhoMo4Ib7s2sgZX-Z7iH7v4PF9nSKadK76hI_jKfAIg>
    <xmx:2egTaJ5-szJ1GndKYWB1tdOqVWszD19nUxhRlqU7xaDVdmlpcMTExmJ2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:34:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/4] git-verify-* doc: update mark-up of synopsis option descriptions
Date: Thu,  1 May 2025 14:34:11 -0700
Message-ID: <20250501213414.370514-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501213414.370514-1-gitster@pobox.com>
References: <20250501213414.370514-1-gitster@pobox.com>
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
2.49.0-599-g90c2cffacf

