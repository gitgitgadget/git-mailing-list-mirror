Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759891E32C2
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502898; cv=none; b=bB6wSXwRmCdvsQQ9XHqm2zpWDziypFDpAanOvpNVfk6X1I89NwffTqLuR9hl5aWAriP7nIi7XyNqxSyjB2B7DyE+t2Xgm2WOOyEu84Y1Qy3ha+TRNECPmGypy1BWjvejzx80/G9LpKzUuz6Sm3wV9P2DbWauTqb8x+EOagsnHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502898; c=relaxed/simple;
	bh=dmhku9I+xjEmIdtx8s4InORSL1GetWMvoaU9hIwWKNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqL7w5xdYw7F4iKPhnpCoUQSoU59af/iStP5quIFYe6QbJgJu9RbpMUbVZtJ3ywMyeCM+wCuQhaa4GhK2HBtYk0vZY3UZghhaXL3j+hP/M9sZkp45NPeRwMWshlRmTFLA3thGnDUfuqLCNdjzBiLBiVhxDuiH2k8LOh+ns7ufQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z33AKpIU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y6p4e9lN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z33AKpIU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y6p4e9lN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 818EA114022C;
	Mon, 21 Oct 2024 05:28:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 05:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502895; x=1729589295; bh=fHx/3g08IN
	oJxKL92997fXzhsl1i94dP+2ktPlSm0LE=; b=Z33AKpIUi7ssQ1Ih3xc5kv+9cL
	A/CxjSiVA+ilDRKLDfSn+uBmsaCcfg5PlTP/1ZDdw+B6cOlvDZAVdZbcfo3wANkD
	rdo8GDYMXsSt00QPwuckx3XgFT4esUMYBIWVPmjOYGNm5ke3em3LGX+5WOnAb6d4
	rC8KS1OvsBoeLcMmys41sYwjoyBZZkVD2lkdHyjthldDSbXA/8ILjgjHfTBAqx9d
	wbpBjWF7RPj+sDFUZc8u7qHrwozezoA10Q2dR92BycicOZeK6SE1pZNdJs2AfeHl
	GYzXH79fkdK+v+lDmd4cxA8/QiBJSzTRXyr1XyWQJbCyb4nsdYxCpAMAjt2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502895; x=1729589295; bh=fHx/3g08INoJxKL92997fXzhsl1i
	94dP+2ktPlSm0LE=; b=Y6p4e9lNnjRuuSWBWAb2L8IAFi3MjYh4PnG5y6QnOMQu
	f2V+AYxeJwdRVnNTOF5KqGMLnkvEiXnC5xt4/vLbRHZVzOfd06jFQBNTVmA184GA
	k2S+LwEq8lcScUHYyEiLqEoeHBi58kLZ/PooVOkDY3ScfHzyiiqmc4vR0xBK0mYn
	No201mPmAaZwIEkAjGIuQRwtqHp0Q1wp45TzSONDpOB9qZ0EuzwY7lhcF2onpPdJ
	ZOVgZQT/0wkTAVCGplycQ4kuQFhP5aL6PSZLtgc/5+OJipLbqd1oZiJSeG+ynTRt
	5jnloVgmgz3xYI2zqvL5h/l2KvSARgCT5lcJ5jAZGg==
X-ME-Sender: <xms:rx4WZ-uhK4iMGMRtqBYsVLVU8pVR81-D42SxaPrk0bZU_TF-XAw9rw>
    <xme:rx4WZzcvp4RkrGF_UntByc3Bi2KR3B9U5Du9_qGzlUzF9__Ov_9v5Pn5uJLKTndgi
    pJNFDDSR-YG0OxzKw>
X-ME-Received: <xmr:rx4WZ5zcrt_lZ6j1GNoi6SjEZ4Azs8GK-F1VEQdmOc_MQStB-k2u_o6uS8mA4elwo7d8UpfT5djnuu_A-N9ujSiAT9Kx1AXhqJO2kA0jceb6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:rx4WZ5OCW0TNQYpRm6BoOJA3W_vHhRtfzgfWR5RdtZeXI51Q5s8G-Q>
    <xmx:rx4WZ-9uDmhfr7Fvmipqwd3lpWqK8BfCbEusgYritQk5hT2lhFygUw>
    <xmx:rx4WZxWSCk0mqQ09J3NZ07jFG11npF5Q7o3J9dnkkyh8D7OcTo03tg>
    <xmx:rx4WZ3eiuKB3Grld1GjXMo2iPprlNqvGq7K-xM2V64LHlbd_3gnqaA>
    <xmx:rx4WZ1ZFyYzgghxnwl2MzO-LFk3XKpymK3BTNrcwEO3xMpbedPt_l8aw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 782a8195 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:26:47 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 04/22] builtin/grep: fix leak with `--max-count=0`
Message-ID: <6b2c8842ef53a3e550aa3de7447c9c3d23bc6772.1729502824.git.ps@pks.im>
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

When executing with `--max-count=0` we'll return early from git-grep(1)
without performing any cleanup, which causes memory leaks. Plug these.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c  | 13 ++++++++++---
 t/t7810-grep.sh |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index f17d46a06e4..98b85c7fcac 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -906,6 +906,7 @@ int cmd_grep(int argc,
 	int dummy;
 	int use_index = 1;
 	int allow_revs;
+	int ret;
 
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
@@ -1172,8 +1173,10 @@ int cmd_grep(int argc,
 	 * Optimize out the case where the amount of matches is limited to zero.
 	 * We do this to keep results consistent with GNU grep(1).
 	 */
-	if (opt.max_count == 0)
-		return 1;
+	if (opt.max_count == 0) {
+		ret = 1;
+		goto out;
+	}
 
 	if (show_in_pager) {
 		if (num_threads > 1)
@@ -1267,10 +1270,14 @@ int cmd_grep(int argc,
 		hit |= wait_all();
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
+
+	ret = !hit;
+
+out:
 	clear_pathspec(&pathspec);
 	string_list_clear(&path_list, 0);
 	free_grep_patterns(&opt);
 	object_array_clear(&list);
 	free_repos();
-	return !hit;
+	return ret;
 }
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index af2cf2f78ab..9e7681f0831 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -9,6 +9,7 @@ test_description='git grep various.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_invalid_grep_expression() {
-- 
2.47.0.72.gef8ce8f3d4.dirty

