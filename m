Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E0204C03
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588034; cv=none; b=OndzhS3R0YMh12WIcVHQIRyRLFhePXkICn04t71uY2T0srayzPJh62nUPTEedLrtZEXNQ278sHycOLjCOmIW8iu1hDoHFM/1tsKDc//jhBrwqxuP5x07KVNV2f/M1gnSCwXDEeymDaCA3lS8ShEV8biTo45jZbENY7t34FIzgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588034; c=relaxed/simple;
	bh=Qs0BbSSF//271g4GiUgEr60l9N7FFIhWmKAl54/lWCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzSS6Ss4mgwtD0mgT8w1qkPsVtlQSs4ITNHRcYfTXGLjSBGD5OkE3fkp4PaapFjCs3UDULPM/vqUS2AgEef9nYpLTvMWezKliThtuPEXgB3Wd4H0pc6epkNprXKEwN4Z2/KOQPn/lRN6qe8JWpq/D8yGwj4YQ3C7xcbh+UiD8so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kv6tlae0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y1kfsGAw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kv6tlae0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y1kfsGAw"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 686321140195
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:07:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 03 Feb 2025 08:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738588031;
	 x=1738674431; bh=VEu1Dq1P4Esxt3OYUiIJ7ICZ9CheURnOeavvaJ4OGk8=; b=
	kv6tlae0p37MNoLKdwQuIvIGDFsetS+wzCv7AJwxXmn0lyhGxA/QPRga/zGDe9KN
	rpepRP3LlWlsVUQPC5P7J9AHzCJg5yqRS64D+3PTs0yOL1t1ViEzVhCuq78f/GWh
	C7Jl1/UlOsUyMg6zZh8//LbgJdil7fQ2AE3G3I+XjKrgfuvqf31oc4cliOIkR5Xh
	8XjQZLrAWc7iYnT8DUYSWAnRo0HbetdMgjLjsaiKhg9O/r2Yvuz+zEZu6v9nOgK/
	ba7cSvotlXYkuXFzXui1t0nkhqItotHyIK9HbEzzP5dcZqf1AhTZkQlnjWScOulI
	sZMW4VlHBRTGPqEEvD+rSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738588031; x=
	1738674431; bh=VEu1Dq1P4Esxt3OYUiIJ7ICZ9CheURnOeavvaJ4OGk8=; b=y
	1kfsGAw3itQ3iby/wi9mKQGlYfV5DGSgfJ+mX8dfYNXCP7X30P5Zgejx9lROnCoj
	mTAc0KmWeYAN9rGYV4ccOCRSXZvbSYHaKQvWnpHOEoS+ojlcKBB+OUNSbPKUcJys
	hnX0zOeRnPSMAfbdeayt7uMrV7kT4LMJSXoOOSe8APeud6eOyag3GPw5NYjcr7Ct
	F4EoC2h5iEzyUUtqwj2Zt6JIqBYwRnLrysVAWh55V0sdIZOX30whIvH4GI9aga2j
	UyIfb2IsfL1E88On11vfImH/akBPBgm+5RLkpUq9VYTEOGZVotHx0xdS2pJ35PXv
	3h12rsy+vzVqx87eTPMtg==
X-ME-Sender: <xms:f7-gZwfjmeY1i-Ac4PN8kVQqG8A2U6zubgkR9NzAGKtp6k5c99HXBA>
    <xme:f7-gZyMQ6BVuJ3Wb3SZWtk9K9wMFkZTZqWUx23zkVMS52ZOdynH-KMNWWUZcQd6eH
    9WX2nrwWaQ75obKTw>
X-ME-Received: <xmr:f7-gZxip8gMvA2soNwaS58x5vk8Mqp4KbkNuBsX5y9wXDXEgaclmQMyNV259ZlGxYJjn5WTdcyUk_aWP95EBsizdANn9SvXKE416wsOvpmbRVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:f7-gZ1_7QKmALRaPib0csmskZuKDWSO6Ri0dRI2gwIfVOcUAh5fwOA>
    <xmx:f7-gZ8slWsyZJEC_n0RNZ2dH29ED4Umipte6Fz-wS9X6BpnU30kafQ>
    <xmx:f7-gZ8EVYWLAkG83njirIUX3rAyCJJfz513VL--ldnxhp-CSmNhg7w>
    <xmx:f7-gZ7M6a_uwb0GH85Uvc2agkUWYtFNtMmlelWcYQ_MKLHf9QGBtOQ>
    <xmx:f7-gZ5Vzkp4VVQKr1ifdePscs5q3JV5-Ux7NGU42vsNMKrNXnVpeecm_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Feb 2025 08:07:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a5b285a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Feb 2025 13:07:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 14:06:54 +0100
Subject: [PATCH 1/2] t7700: add tests for `--keep-unreachable`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-1-7c4d69c5072c@pks.im>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
In-Reply-To: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We don't have any tests for `git repack --keep-unreachable`. Add three
tests that exercise its behaviour with different packed states for the
unreachable object.

Note that the last test is failing. This will be fixed in the next
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7700-repack.sh | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index be1188e736..b26566473f 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -826,4 +826,77 @@ test_expect_success '-n overrides repack.updateServerInfo=true' '
 	test_server_info_missing
 '
 
+expect_object_count () {
+	find .git/objects \( -type d \( -name pack -o -name info \) -prune \) -o -type f -print >objects &&
+	test_line_count = "$1" objects
+}
+
+expect_object_in_idx () {
+	git verify-pack -v "$1" >objects &&
+	test_grep "^$2" objects
+}
+
+test_expect_success '--keep-unreachable appends unreachable packed objects to new pack' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set core.logAllRefUpdates false &&
+
+		# Set up the repo so that all objects, including the
+		# unreachable one, are packed.
+		test_commit --no-tag unreachable &&
+		git repack -ad &&
+		expect_object_count 0 &&
+		unreachable_oid=$(git rev-parse --verify HEAD) &&
+		git commit --amend --message rewritten &&
+
+		git repack -ad --keep-unreachable &&
+		expect_object_count 0 &&
+		expect_object_in_idx .git/objects/pack/*.idx "$unreachable_oid"
+	)
+'
+
+test_expect_success '--keep-unreachable packs unreachable loose object with existing packs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set core.logAllRefUpdates false &&
+
+		# Set up the repo so that we have an existing packfile with
+		# reachable objects, only. The unreachable object as well as
+		# the rewritten commit are both loose.
+		test_commit --no-tag initial &&
+		git repack -ad &&
+		git commit --amend --message unreachable &&
+		unreachable_oid=$(git rev-parse --verify HEAD) &&
+		git commit --amend --message rewritten &&
+		expect_object_count 2 &&
+
+		git repack -ad --keep-unreachable &&
+		expect_object_count 0 &&
+		expect_object_in_idx .git/objects/pack/*.idx "$unreachable_oid"
+	)
+'
+
+test_expect_failure '--keep-unreachable packs unreachable loose object without existing packs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set core.logAllRefUpdates false &&
+
+		# Set up the repo so that all objects are unpacked.
+		test_commit --no-tag unreachable &&
+		unreachable_oid=$(git rev-parse --verify HEAD) &&
+		git commit --amend --message rewritten &&
+		expect_object_count 4 &&
+
+		git repack -ad --keep-unreachable &&
+		expect_object_count 0 &&
+		expect_object_in_idx .git/objects/pack/*.idx "$unreachable_oid"
+	)
+'
+
 test_done

-- 
2.48.1.502.g6dc24dfdaf.dirty

