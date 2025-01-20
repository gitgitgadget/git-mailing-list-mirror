Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3BC191F95
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373298; cv=none; b=pvMCk1dji1BqAhjm+8a7/jSSE6Pk5QOvb3NT49XHVDOz8NSxVjBzQGEDcIy7hqRibcOsfKaEwwIHz0hiRz6T8jm4tZJKqUUcvC5Nh/5gEFCUtZdkbmGJstWKl3BdBciJsDjnBSw2trA9uLHgEHWa83G5ST2baV/eZWvm/mArFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373298; c=relaxed/simple;
	bh=MwKMicVuw4zgZgyVODf967NoOnzkAELtQfMsCIGmVtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0aP5NZEIDiEcnE9Lr61mPuQs7VQekAOJaAoR9kvx82EqFw4GXu4AuYh7YSkbJqlp9ytF1uy2YI7QXycD7yEq5VlYP4hGCIq5Z2lPEq+jkz31mWo3X/xGvrHQd4xy4zCHoUq3pp4xikZJTpEgbT51QmZHOON+q9WwbVm6Ro41LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=iYTXSN1s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lRjnDCO8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="iYTXSN1s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lRjnDCO8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A37D1380219;
	Mon, 20 Jan 2025 06:41:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 20 Jan 2025 06:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1737373295; x=1737459695; bh=O2xXbnm7Jd6eGZ6K5rTjv
	zONQ+XCjzWCDzCo3MzpcQk=; b=iYTXSN1sGeHyNxRTLU/JRn5Z04VWDLnwZb3CU
	ljhCMy+JPTYIRqSS03s34qRKwdQFWLfsKNM7KUZsQl55WnTN4lVo+0Ys8jRFnQQH
	Tzn/OB6yIa1t+ddhHPGuXOehezzOXtRN138ZUcszLcm3Vg8xmDu8OyLXNCrKScKG
	saX5moCmKbc7+vBiw01CI3xrcmzl71Rb+A67wijFQIH/2eyCj59teoJsIVw0eUUE
	f7w4icUgJAcwppv5MnzddpNrW93+OPt/X62EXWoAN4HpJTtsIeRd970jCgZMN2X2
	Q6MgK1CNXFHWRfl4VMikVWbqtTf0CLoEYw/2CFCSeAbeA632g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737373295; x=1737459695; bh=O2xXbnm7Jd6eGZ6K5rTjvzONQ+XCjzWCDzC
	o3MzpcQk=; b=lRjnDCO8/DvLi7uPj2td6H4PCzGUK8XhzFuI79yKqdns7b0/dUD
	RHv5Ld7wQUTk+d4uP9Ve+ClOJK+jvgyM2frNxsrkLW0N4l21BxerPUiypl5i0rhe
	4N23/GOXBtCXzevVPz7QQbddmrFIR7sWUwakQ3+71g8O2jnDREiXy6JTG7Sr9PAz
	DJpJWyGwfubbGq9IaWt8u8bYrV4d2ZFWK3On1hvsoTFuZR5arALVeDiYSPLPqiav
	KXOjhyhElMZ8KC21/nz+Gt7d1cHEi3jc96wRTgfHbaY1bDP83gzS5/QKx1fjNjRK
	bEGoM27voaGqCnZqlmBeehlZYaVZhVBocWQ==
X-ME-Sender: <xms:bzaOZ31ghKYa16zTnUouHDCZakLLdVQOU5QIRdyzOsAwG4o4bUXI9A>
    <xme:bzaOZ2F_P3YlwQbZmLatQuKpXdB17JEEhLpUSxSgO9osD3CQ7CSjvk6wxV63OqC7K
    kEiRqv1xu1_fCcOiQ>
X-ME-Received: <xmr:bzaOZ366RujdPOU-F5TTbC1slX5DtlYCObTn8WOYs-yBBjXM3gc-A5RLS-CkTa35lDgLfQLZVIWzSgwkS_nljS3raLNTgDO9wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomheplfgrnhcurfgrlhhushcuoehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpefhkedvvdegkefhjeduieevueeihfdukeehjefhleehudfh
    hfelgefgtedtteeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bzaOZ80HtuYIiZ3pDWsSztuyronoiJze-rPibwodq7H8ClkIA70qfA>
    <xmx:bzaOZ6FEw_lcZrewzFbClUWp53tOekw-hDEHfTv8ry3lxkNqTCgHfg>
    <xmx:bzaOZ996HyuIHIhWojIWgVUViTHVUr6z5fLBBdYWrVnEZVQFJxKjgQ>
    <xmx:bzaOZ3k8_b6BwFWatQ--7eznRpg0-yr0cb52KBztd-hXP7Asoj1BMQ>
    <xmx:bzaOZ2iBoiAnvEKTkrMsi8n0BlfbryOD-wrJZpsIoVJNuCpM1A1Q1y3A>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 06:41:34 -0500 (EST)
From: Jan Palus <jpalus@fastmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jan Palus <jpalus@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] t8002: fix ambiguous printf conversion specifications
Date: Mon, 20 Jan 2025 12:41:06 +0100
Message-ID: <20250120114106.2844157-1-jpalus@fastmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In e7fb2ca945 (builtin/blame: fix out-of-bounds write with blank
boundary commits, 2025-01-10), we have introduced two new tests that
expect a certain amount of padding. This padding is generated via
printf using the "%0.s" conversion specification. That directive is
ambiguous because it might be interpreted as field width (most shells)
or 0-padding flag for numeric fields (coreutils).

Fix this issue by using "%${N}s" instead, which is already being
used in other tests (i.e. t5300, t0450) and is unambiguous.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jan Palus <jpalus@fastmail.com>
---
 t/t8002-blame.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 1ad039e123..e98993276a 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -138,7 +138,7 @@ test_expect_success 'blame --abbrev -b truncates the blank boundary' '
 	# Note that `--abbrev=` always gets incremented by 1, which is why we
 	# expect 11 leading spaces and not 10.
 	cat >expect <<-EOF &&
-	$(printf "%0.s " $(test_seq 11)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
+	$(printf "%11s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
 	EOF
 	git blame -b --abbrev=10 ^HEAD -- abbrev.t >actual &&
 	test_cmp expect actual
@@ -146,7 +146,7 @@ test_expect_success 'blame --abbrev -b truncates the blank boundary' '
 
 test_expect_success 'blame with excessive --abbrev and -b culls to hash length' '
 	cat >expect <<-EOF &&
-	$(printf "%0.s " $(test_seq $hexsz)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
+	$(printf "%${hexsz}s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
 	EOF
 	git blame -b --abbrev=9000 ^HEAD -- abbrev.t >actual &&
 	test_cmp expect actual
-- 
2.48.1

