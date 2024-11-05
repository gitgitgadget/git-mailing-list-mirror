Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A11B6D04
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787426; cv=none; b=mXQMGyWWdb2sMuBcv+VGPMaXhjU3twU8ajr27P3OxDx3xV+9V6fO1FG2Rs2q9Hglruinf5wYgSHF4VhcEoWunE/QKYOjlKyKGsfEqAg6z0o4j9SJ3K4ewHpCpE02KiUE7J78QqdlSRZWfIeWdjnnxOYIeOlkAYMtY59iNhsE+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787426; c=relaxed/simple;
	bh=TWDd2MZ4m3r4gK7/RsRXm+qIM26EHfeUjYYkQWpN9jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5YDM9ao7rSk0/xvrvzkJaB2+Ltqh16bfWPd01sOl0i6xAs9B6kEerJ2DCtMXZ26L1qR0SMYwmyV6JQu2bclVAh+ifUslGzt3uzUQM5kC7SGZ48/QOY94sEZKJnLhbEYpGwaNFxuS57gFHIgGbV8x4WrfZgBCudF20JUwdyZSEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ec6fAywC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+G9BZKv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ec6fAywC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+G9BZKv"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id B53AB114016D;
	Tue,  5 Nov 2024 01:17:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 01:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787423; x=1730873823; bh=v+wOuqPYeP
	QZ4nSvEMO0RUZTg/18UUqRdIndd1MEBg8=; b=ec6fAywCZGTq2UXCDFLSlAYKWR
	FViXpmoTOdDtpbYFGr3NU0guiRQRgrceyeqPWcmFVvDOKdKtQU9697mxsqkgJq+y
	OQ9T/mB8m3P01rVc7HFlDg03ZDaycxvbfoZZr2kwGhWancpDgKoa2o5o8vksK4Mf
	Kebpx21eMbvrOyLElcvaJ0H5O4tG43IGmGno+TW6df3M4vQJAu5dZV/wfP9JxmzM
	OBZU/HAEIntBBTR7fZLI1TTqDkpbw17X4aseOJurrWIVnZSybv/jr1Z+n9vTZEyZ
	V9ocq/nu2kwQK8MHukyjISgaAof5AfIdJlXrM97far2Fr1JBx7TuieWpyojg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787423; x=1730873823; bh=v+wOuqPYePQZ4nSvEMO0RUZTg/18UUqRdIn
	dd1MEBg8=; b=W+G9BZKvoW3biDx2SO96yLXzVcMI2U7UJ434mfP2Fn03AEf7BAX
	zgSt0NjDxLcmOXrRgtydPwbk6wWyBXEQv/83ULkVEkW+WxNWixQmd1y9NIOq1vKa
	XaBDX76J25W+/SioJiOG2ElTq4Y3Ot3OiE60j6GHQraVt+/LIYhZL6qQIah6YIhl
	F5kzrPxeJUAA4q+UOtEstJ4RU8T/7a+cGgI4IF31gbuUko5qq0thPoR0dCtoRQGO
	+hPGLmkxwb9QujYYW2SHjIkviYzmLrGO2TP2wUcHcoMeEVDCoxNVFqkIJFIkbBEf
	JsZkddQ0OFioiZzLoY1b8JekpQ6zF2Rx6eg==
X-ME-Sender: <xms:X7gpZwBo_gq-wScqZ0zDa_3aF9SOoPsu0iuvPi-8DjhKeiPCqkQOTQ>
    <xme:X7gpZyhkuGdQe3QovlMGLXzmk2KsjfsFRjZNQNcQ_YbHO0haSVkkGDJgLEH89LV3c
    8uYsZ-KQ6gpEznVtA>
X-ME-Received: <xmr:X7gpZzntvs8q8aUPXuxk1DmMLs5nq38vvQKfk-bNqcdAkqnNogk7TRpIP1yGlt3qNho5yUh-YZ-YFhOR0jq8ltYADWcSzLQWY3rUth0x-fJtvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:X7gpZ2yj22BU6szUMjmGVUQStQErUzS9ac7wXCqs_ZEgkMVpj0Blig>
    <xmx:X7gpZ1RhKx7JTMxaXdq8h35_x5zvuTYzTE6dnJrARJ8vtLzXm3hFfg>
    <xmx:X7gpZxaFQOT5HSlIpAn_HNOGjmoe0RNQA6oBaf1bMHKWYOwKCvm8bw>
    <xmx:X7gpZ-T_711wiDMxAgHMvm_zTwY7Qy4EXuXl77okbezgmkkmYo0-VQ>
    <xmx:X7gpZ-J4CVhLUGLndTqy4V2bF_bYKeL1ouKq2VMsO2N5AzGLRFg-7AcA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ecb4a12b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:40 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:16:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 04/22] builtin/grep: fix leak with `--max-count=0`
Message-ID: <d716f93169a5a7c2352684998f75e85cf70b9224.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

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
2.47.0.229.g8f8d6eee53.dirty

