Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CED205ABA
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508389; cv=none; b=s6C7dWQk3kFikkPDgqEfSwDuoHzk4DHlKj2zFzDoYz0vrdCKp9nlsRPcCridS20gTNCJzaugRxFUgU15OIZjLwNn1xwKkpryrE+zT8u1dIYK+OFWxcdFKUh3In5Voog1gFmwibp0vioBjJrubf92/m8VbM9i0xnsXSYEL0NyXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508389; c=relaxed/simple;
	bh=rroawE1WrcsSTAHmcRxeqBCxzgiMvn5MeQH/x77lfCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mg9349STP0O3y4LXW2SZ/MSQBAWNCJJ5AAmc6hd0nePjlNHBGWAMWNkUE14qwYexumZr1/32gc1GAfPZlHsJpQF0t/MN/DqB4wiifAUA0bzssFsNKcDJ9ZYKq3P2DVpsygUoCqpRXorEFf4TVU85xwPO8x5mjnW57LKraT+GLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kHsC0IWi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kmfnhx7a; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kHsC0IWi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kmfnhx7a"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A62431140192;
	Fri, 10 Jan 2025 06:26:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 10 Jan 2025 06:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508386;
	 x=1736594786; bh=lV981FIK1dv54vGvlofa7UIYAaKPo2Dv+0KrZHo7Anw=; b=
	kHsC0IWiUIpFXEZymZcy2mr8hlaxBcO2mCCTnH9BdyKT25VNTjJzQgpJByjb54eQ
	2Oui2zrp3dfuddLDDrpnnnMYyz+dQ7fWbOGFVVai0WNLW2bH1y3NTIS+QfVy+wD2
	KhN2CaJw5/ou/+V+kzCbfUlp1wE31CuAP6R5sgvd7lGAT9P28yhYia7DXNfegvTi
	7BcS7NiOw8zSBMpZH9VqCitq+HTibAWfE5CYc5IBfu8zV6VwKDSF3cVojhqzrU/I
	66CuYd3DfdNblmKXjaA6tjygaaBLSsqn02IfoEqCnAGyH1Eg6HHaf2Fh7Sq4sphu
	5eArzuOt8MweT2YQYhomAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508386; x=
	1736594786; bh=lV981FIK1dv54vGvlofa7UIYAaKPo2Dv+0KrZHo7Anw=; b=K
	mfnhx7afsWDe6Tssza2MdebvOeUiP/0+lVrxiHVRnAFJG3k4IfUrZ5f/p0fwc+3b
	2eA7pPi/V05cRisUuXRLUl8JudizfOgq3iZoqzkdbc8xEAAw8FaGZ/p9BIQpMuDJ
	Ar486TQtitYEjp1+tjx76EbqQy0BYcKM8oB/s2PDuJvsAcqExDPoBkd5lhQDZ1uj
	AiaLZes2OHrbv55IAR6c8/HhJFR8trRdajukli4FpB65UrpRkrpgA2MQbClRThRP
	V4/bgdVK3vUrZmdvTKLrC9j5WSf+je1CgpI2xjL0GBhDrROfqvb5kdJQEE5gd21R
	xMPXkQRpIzVQEMxBizduw==
X-ME-Sender: <xms:4gOBZ8MOQDbGLF950IBZyTybfIesdlzneu_L1g5enkOeBfZwBqIV7A>
    <xme:4gOBZy-XQ6Rh9YTaCmcdXj6gtDBJyRcCX-0_XmDC1oAG8j56-I8J3pfy02tbDBSBf
    tzRnJ8r4sL3WvMATw>
X-ME-Received: <xmr:4gOBZzTxT8N3ifHuvHCp4A6ubEVaTJ5_vrV7wAFQ5n5mWhYTDw1fF70k6BEifN0bhggMACa0e2drBSfs8qJzs8x2qDuhWHe0f5wpfMx5N7a1Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4gOBZ0vXkbQ6nE1uLPzMHjl_-7SI9N428V1ShqwCSKtZGruCJfEpew>
    <xmx:4gOBZ0fR7aisO2uEFoIju0f7Y0EwTTTJC9G5J2MvHJXJkvS1ocDX7A>
    <xmx:4gOBZ42BopfMYL1MV2Wfnk0iDLDx4dSE6QS1tAtemKGjGGj69ISfIQ>
    <xmx:4gOBZ49oL7fbf2h4xfHma_wwg5nUaIy0kK-CpyWEVlX4OI17xti3MQ>
    <xmx:4gOBZz7aqVGiesm1kVTjvYKYldXHmZxNn1ezkROvXS1ibOwbws2aWgcP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:26:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8e638b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:26:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:26:18 +0100
Subject: [PATCH v3 2/2] builtin/blame: fix out-of-bounds write with blank
 boundary commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-blame-truncate-hash-length-v3-2-e61f25b68f30@pks.im>
References: <20250110-b4-pks-blame-truncate-hash-length-v3-0-e61f25b68f30@pks.im>
In-Reply-To: <20250110-b4-pks-blame-truncate-hash-length-v3-0-e61f25b68f30@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When passing the `-b` flag to git-blame(1), then any blamed boundary
commits which were marked as uninteresting will not get their actual
commit ID printed, but will instead be replaced by a couple of spaces.

The flag can lead to an out-of-bounds write as though when combined with
`--abbrev=` when the abbreviation length is longer than `GIT_MAX_HEXSZ`
as we simply use memset(3p) on that array with the user-provided length
directly. The result is most likely that we segfault.

An obvious fix would be to cull `length` to `GIT_MAX_HEXSZ` many bytes.
But when the underlying object ID is SHA1, and if the abbreviated length
exceeds the SHA1 length, it would cause us to print more bytes than
desired, and the result would be misaligned.

Instead, fix the bug by computing the length via strlen(3p). This makes
us write as many bytes as the formatted object ID requires and thus
effectively limits the length of what we may end up printing to the
length of its hash. If `--abbrev=` asks us to abbreviate to something
shorter than the full length of the underlying hash function it would be
handled by the call to printf(3p) correctly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c  |  6 +++---
 t/t8002-blame.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index d7630ac89cb7bd6e9ce5d72c6a98aa433b3b12da..7555c445abe7ca2fa54670ac8fee1d95a6dbafe3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -489,9 +489,9 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			fputs(color, stdout);
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
-			if (blank_boundary)
-				memset(hex, ' ', length);
-			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
+			if (blank_boundary) {
+				memset(hex, ' ', strlen(hex));
+			} else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
 				length--;
 				putchar('^');
 			}
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index b3f8b63d2e6744dd434f38fd9f10b56cd432141b..1ad039e1234828ca8779ad76147bfa7fe14c5a2e 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -134,6 +134,24 @@ test_expect_success 'blame --abbrev gets truncated with boundary commit' '
 	check_abbrev $hexsz --abbrev=9000 ^HEAD
 '
 
+test_expect_success 'blame --abbrev -b truncates the blank boundary' '
+	# Note that `--abbrev=` always gets incremented by 1, which is why we
+	# expect 11 leading spaces and not 10.
+	cat >expect <<-EOF &&
+	$(printf "%0.s " $(test_seq 11)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
+	EOF
+	git blame -b --abbrev=10 ^HEAD -- abbrev.t >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'blame with excessive --abbrev and -b culls to hash length' '
+	cat >expect <<-EOF &&
+	$(printf "%0.s " $(test_seq $hexsz)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
+	EOF
+	git blame -b --abbrev=9000 ^HEAD -- abbrev.t >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git blame --exclude-promisor-objects one
 '

-- 
2.48.0.rc2.279.g1de40edade.dirty

