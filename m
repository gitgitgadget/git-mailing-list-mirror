Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387F1E201E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543685; cv=none; b=lWe9Bgcv88mxZNTfCoTt1wbXFqbHDyxAoyuHgzVAbjc4Om2VY/ERnaYXhdiHfnHM8EOf/0Sqq8SlG9TvZ2YDC60Qiaeuf8QGIHyhk2Fd/5+k1GR+FITW3wMIIJtZhMX7gYc79b2KPRb1CbU/DSffCRSjIXj6PTwwuTraLK7AFog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543685; c=relaxed/simple;
	bh=7CAacwziBV4R6PPzPEq2bWS68KMP2AL4agciuxGblDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxTNakf9i1A1XxUZRLsYs3aftssasZZR0Vu/snrKJ1MkxG4z3cdWBg1D74XV3MjW20KCez0OtvhwGg/uj+x5laCbN/nTlIxDMGR4jZrsio4sILlQOM9R5uF0AcvDYGk6M8wWaSHAcHSu5VPrxX0YHvgcb3nG1C1cBUGjxUVwEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AaNaVLfb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HwKen/mm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AaNaVLfb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwKen/mm"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 560781380471;
	Mon, 21 Oct 2024 16:48:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 21 Oct 2024 16:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729543683;
	 x=1729630083; bh=FB4Qk5kjhluw9wUxq9LPjIlLfG7MdeHMse38g4RAYnA=; b=
	AaNaVLfb06HCCaaRnVkrLkwYiRIpJFL4gMxNQjH9fDmBL3RJqXpRTZcIpxD2sm22
	mIJk3NQp6oKZl4kVyNFw80qLCW2Jb4Vgwx72tsm6TLdKtp73Ys8WRZGAga4CR1EZ
	fxXvCzJ31EHcvpv9bTsFpleIvWrwe6njukhnlrujqOLN0Qak3iY/Msax7VLYEojY
	0PN/tlS64hJm1Y+kQGGdVF9OBEVts1Qit/hlyXhpLYWgQakzV1lti91qAvd0LPQA
	5AOUmJqD4Ey8W5MRYeZZdwX1mg2qA3h2/BTt4jkn+woKPYeZO5cGasCbLWipB5k1
	fCgPoU6GrQPodA2T2YhF0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729543683; x=
	1729630083; bh=FB4Qk5kjhluw9wUxq9LPjIlLfG7MdeHMse38g4RAYnA=; b=H
	wKen/mmvlOVsBuUPT/ni0WK3ldI4+pkASWahG83UX+jpd6R7eAmldePiB8D8/Yte
	PSV2BHf2eBXYJnwve/Lpug+DFTWJnbHhpSr9q7bUbLgWr3NkXVdTy2xkveKMpDXf
	nMv6DxKP0QpcqHk2Am+HAWlOXPsRvzVdUHJZbaU1TTdkK5pqYBLUZ/TjuGHTP/ba
	y3Jg0Gbi/+orTsoz7YMlKDDMFKpJhr527hAkEwH8F4inrjvHA77UDcMb/JXaAUqZ
	HkqC8m9m06XknrwQ+ycP7bjnInvPxqvDeqSLMGlHyOv1EWuHzBJOvDbrI7vy7RC7
	fQrJ+WYcuK+7Tlm9t9Gdw==
X-ME-Sender: <xms:A74WZ3mCkK2YO-ejTvE4aHU7totKYywQref3PBkI2e-Aq_y23K77p1c>
    <xme:A74WZ61fQjm4lpntlOOYHxlmX-G6KEdkZJLVR8MlLoanVoKPyUprDk2xza_mkxp5s
    zSBZ976tOq4LJhEYw>
X-ME-Received: <xmr:A74WZ9qCFDTAYHjHINZKUv1zpCghJ1rQiJIK2I3MsgIhZwd6Wd_kmE0eZ8iWHyDxFniGjs7jy8tPcQ0s5TMMgX2SRkgPaZwC6cRQhwyZYPGoUCLmbrV2TmfQaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhgt
    vgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:A74WZ_n-JowHWtTvpDr17gLlhHhdqnu98Yhbf-Sdqb7_qbLslOGlLA>
    <xmx:A74WZ10Kfu0fUcMnWWnkqfoph76rKPbbFkJzxzQkC2eGseeODIWQ9g>
    <xmx:A74WZ-uTnBD0JP7nrpPHZWvCxwXYlxcp4tVUxkSOEoW616tWPOj70A>
    <xmx:A74WZ5Wu0VhWecPTdkPRAQW8-EKVi_1-0VrI5iLzYJfrdcts4LOm2Q>
    <xmx:A74WZ-LVsaQ5QlHHrT6nR1KcIGkoL_5Y_neNkowE51xULoruS4Q8HOow>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 16:48:00 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 3/6] Documentation/git-update-ref.txt: demote symlink to last section
Date: Mon, 21 Oct 2024 22:47:26 +0200
Message-ID: <6c8ff72c23052b3f592888a64566ba8c7c4a2ea6.1729543007.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729543007.git.code@khaugsbakk.name>
References: <cover.1729367469.git.code@khaugsbakk.name> <cover.1729543007.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 6c8ff72c23052b3f592888a64566ba8c7c4a2ea6
X-Previous-Commits: ca786bff9783d671d5e3c36ffa35ade6029eada5
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Move the discussion of file system symbolic links to a new “Notes”
section (inspired by the one in git-symbolic-ref(1)) since this is
mostly of historical note at this point, not something that is needed in
the main section of the documentation.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-update-ref.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 1a0aec041ea..6aaa7339d71 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -29,14 +29,6 @@ It also allows a "ref" file to be a symbolic pointer to another
 ref file by starting with the four-byte header sequence of
 "ref:".
 
-More importantly, it allows the update of a ref file to follow
-these symbolic pointers, whether they are symlinks or these
-"regular file symbolic refs".  It follows *real* symlinks only
-if they start with "refs/": otherwise it will just try to read
-them and update them as a regular file (i.e. it will allow the
-filesystem to follow them, but will overwrite such a symlink to
-somewhere else with a regular filename).
-
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
@@ -185,6 +177,17 @@ An update will fail (without changing <ref>) if the current user is
 unable to create a new log file, append to the existing log file
 or does not have committer information available.
 
+NOTES
+-----
+
+Symbolic refs were initially implemented using symbolic links.  This is
+now deprecated since not all filesystems support symbolic links.
+
+This command follows *real* symlinks only if they start with "refs/":
+otherwise it will just try to read them and update them as a regular
+file (i.e. it will allow the filesystem to follow them, but will
+overwrite such a symlink to somewhere else with a regular filename).
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.46.1.641.g54e7913fcb6

