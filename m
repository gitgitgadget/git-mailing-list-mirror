Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB71E47BB
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502934; cv=none; b=o0bwImBklSAo6gRdxvQ7br8a3+JAO+7qgdUeEYvFc8Q8PQ+70Z2sLKLOkq6q9ggZnxFVOtVPSlHgWNh7tOj7ZCcZwKjOGJbuM3vwjy2sprOSvgXXmsYlyb79EMzAxu7ZzMKrlmOllR73MBVNjKoqlNfnKvYTlC/hbUU2yliIWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502934; c=relaxed/simple;
	bh=ze2W6jwTxIEF7cVucvLNadGu6LsKCHTw+gRQxne+8yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5HTdTGZ2RYWMS/2SarvrYu8AxkckBFS6FUYQ59h+BEcauVeo9OO/220rmxOEaRVWtUar8i9O1TYwyfwaqmqkfD0tloQTVd9AkJ77qHiZgWkS4mJR/qq19bYXrsbW7XkHf9fwARGB0EC2FNFBI/jodznjl25wqCuCBwwhQxMEsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=khLIBRyK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNdvJfxF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="khLIBRyK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNdvJfxF"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D92111380267;
	Mon, 21 Oct 2024 05:28:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 21 Oct 2024 05:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502931; x=1729589331; bh=+spxKJQ7vt
	uNMBUccFn9flU8TZnx0g0P60ahbctbYso=; b=khLIBRyKCR6/M0jzBg/bB8uUJo
	/hdgYYDKfOUOLY0+S+TGjgleuV+u2KECKMTKSXiImMGwQ2gEOtB2jEcF/7BHbipl
	ZrZC+Z5bySee2Up0iU5JPGQUp1RqnBpmhWudbxGdHR6SCVQS5XdDhk3orOuzPnbd
	a9rUCmgy0516yJxmNOVXfESnyBDT+cUZ0+m1dRw4NtbkOv8ePOPQK43fMc6cfR6C
	xrWjj0Qjf+glRk8aqyR2LphilLRYHXM3ajSFPH6aJ214Tsq9uhTJBNvPl0iqJMf/
	Qlz74kVnHDZsvh1l4iEV+Prq9m9E6nVVuPakr9uyYp7spvXmY9J9k2kkiJ6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502931; x=1729589331; bh=+spxKJQ7vtuNMBUccFn9flU8TZnx
	0g0P60ahbctbYso=; b=cNdvJfxFDeehQvt3mZnr4ZRaQ1i1NLpyiT0EdslEpSSG
	JfhMqukQaxN5wODtT9CN9X+NLHYbW9Has99lRFNhBiENj4vD+PoF+41jhEOZL8MI
	HLIp5CRC6B5okGx1RTK9WjgenSbjhDdwoNWT08P8LA24eQ6+6PNuKTF1SprdgDzW
	lkBjjLZCyse4E2/TkkhGQcKn/pauPsJzmnVvfsH3ZwpHCEJ+Ik1kmm7riVhkDaOq
	dG6k7ZpzNIrhraToprv9hW5/e9XAxxp86s0H6QCLRwWhOTdhEVBqvqqqHTsNoAhT
	NraWWMij6SfbZRtc/8oyMcLKHANI/bU9RPTOhTi21A==
X-ME-Sender: <xms:0x4WZzTtMd1pIPh6K7LI1YU7DTogcDGhQ7HP__KLsFS4UuOB9ZlbMw>
    <xme:0x4WZ0zTRBVgK5ZTNZQhP38C2siQS33e4m53Bh-8zpXZcoTIbxqvTvbaPBLDdckRq
    Uu9-V4iWqwIACzUiw>
X-ME-Received: <xmr:0x4WZ42XlI1ZdBydvaa4tTgpT-mbuxVRJ7ECJ232Ttwuu_wWvfsylhou-0D-4RZ9IaZDIufDq5ZibhVCdykeEgfllsV21iLxpM4ysx__ioXJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhm
X-ME-Proxy: <xmx:0x4WZzChTAkXe2qN_Keq81M6DRDDUnOTc-yEBZ89p2GEN1Gp_1GYoQ>
    <xmx:0x4WZ8iF9UIFGMy0sMZgpkWSxFtzRw5lFIuIL00gPWSVIfju4Ll_Aw>
    <xmx:0x4WZ3pCAl6ShDtO6j4yI-03mCfH2NBGvqz-yw5EiTGETZlpJl4-hg>
    <xmx:0x4WZ3h7xZVZ5soA_vxsDx2JvZNTwleIYBDWpBa_O3oL4cixk0yAbw>
    <xmx:0x4WZ1u93szlovY5kNYY1FyHpX9Ck8u2yhogCFEUsUgKVp50zeWamblK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a5dc05b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:23 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 15/22] combine-diff: fix leaking lost lines
Message-ID: <76bbcb3fe301fe273578a71849f99953ea94695c.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

The `cnt` variable tracks the number of lines in a patch diff. It can
happen though that there are no newlines, in which case we'd still end
up allocating our array of `sline`s. In fact, we always allocate it with
`cnt + 2` entries. But when we loop through the array to clear it at the
end of this function we only loop until `lno < cnt`, and thus we may not
end up releasing whatever the two extra `sline`s contain.

Plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 combine-diff.c           | 2 +-
 t/t4038-diff-combined.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index f6b624dc288..3c6d9507fec 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1220,7 +1220,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	}
 	free(result);
 
-	for (lno = 0; lno < cnt; lno++) {
+	for (lno = 0; lno < cnt + 2; lno++) {
 		if (sline[lno].lost) {
 			struct lline *ll = sline[lno].lost;
 			while (ll) {
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 2ce26e585c9..00190802d83 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -5,6 +5,7 @@ test_description='combined diff'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
-- 
2.47.0.72.gef8ce8f3d4.dirty

