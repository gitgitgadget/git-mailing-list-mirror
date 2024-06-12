Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269EE16F29D
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193040; cv=none; b=YKaroH4QyJq3cFkOVjDDzd4LMe9NM1fiLoWi6JtlYGJizX5l2LDnDEqzSeB411X87wkbfZrqWvROhlB+BWBS3x9PO4Wv/5e+aXSNNLxbR2DbkRprwLTLJ9sPpWj+xRaveJzHx98RP2rHqckLC9f86sFr1cN/4sodJ7ZWCWRTP3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193040; c=relaxed/simple;
	bh=vsb5fRoAMgYoUfNCfhh6S+25ec3OnDq+yjfb0ukvwD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVSlaPBrY8NFbziAgi5O/CdAnV7e9fIepMDDmdmcTYjg/yp4UeBaQpyKqD8i3DiMTWwVWqFFBzTK3UWHLLx2zR+omkMqXLIEBJ5v+1oSFo0wk1iJgbns5BLFUn1bXlM725WSZVxfYNmNee1kDNz0hLJUSUS4nFpngKAavTVu7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me; spf=pass smtp.mailfrom=dwim.me; dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b=bpITIaBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoJDHve5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwim.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b="bpITIaBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoJDHve5"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 40D3213801CB;
	Wed, 12 Jun 2024 07:50:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 07:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwim.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718193038;
	 x=1718279438; bh=F1JGHRV6IUH7m0K5xcyzgGLr2Sd9NLJ8lf4dHPVc/ys=; b=
	bpITIaBMhnN+NuNhSPwsxhXNWQD3NSDavIVluXUCCAfJbOOQacbFujGuo0Psc87Q
	W6yw9XVEUyH2TuNze/QSmcX35uQPBUGBoqPfgIP5/yS/Dzclq6gMEtH3EEfxWEM0
	z3YvDBkRXCfZQGrlzxGCI1XElnL1jPzyNepq/Y5WMt8pwRz+Rs8SgReKuxog9MML
	502DbZul3wwEmcWcYgWRQaV2UeskkKURwNQs2RQFYvbjjmbLiOZBxUmHmaGi5h/X
	s5VUplk1yoo9JKgVyyFFCLilBSPe6biqj2jWWg9PMDQnzJnbfx1qyo1Y103YVzRq
	p3t/H/Mb/3UE6Edo/r8r3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718193038; x=
	1718279438; bh=F1JGHRV6IUH7m0K5xcyzgGLr2Sd9NLJ8lf4dHPVc/ys=; b=H
	oJDHve5/Ef9+TcXR1ZpTtv23CLtjrTZgeI3acsbrtG7DHL9ZkEbR42NCExvejgS7
	nWlIl5VfX5a00r/py8cte3LCT0d8KuZTe6wRYOBG5WTfuvQ3Mib08Bj1+pt3D8Sa
	xKyzospL3T0amoGn9t+qQ4YFhD3K5FHnAouF3rEofQozY7tZ22HdgWrMl98sfB38
	i6HoCA5TECxd3F1v48wKLikCiobvUd9k6i/f2Acwa5po6hLe7MFZb2Im7swApBmU
	0pU9aSCbunMh2t4E+VXp+4t7YkuEZ3xOeYJ/GywG0uAlcOy7lmjd/eYbjabFbx4v
	R4vMYLlO9BgY+FiDCV7RA==
X-ME-Sender: <xms:jotpZgLK8TRhuTWWfVkNlsfI6Fve5sSEEG6IP2qy6UFqPa-5S4Z7rg>
    <xme:jotpZgLrPgQEn3Ewurnyo3IZdTdHIYiXh7070wkzCCgtNpj2f1yiDOV0SL2uCYODf
    RxJ_tyB6Jltjpu--w>
X-ME-Received: <xmr:jotpZgs0Jq8640m89EMNH8clJmMWmVtj53iJck-nbWAJ9dupOGnWGLuU_qoVFVjjPwBwslgCkdS0XQgdz9NxvP4aR8l4vRR9y5kLi1o4JuLzkwOIIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepvegrrhhlohhsucforghrthovnhcupfhivghtohcuoegt
    mhhnsegufihimhdrmhgvqeenucggtffrrghtthgvrhhnpeffvdfhgeeftdehfffhveeuhf
    ekudduffefieeiudehudefgeefueeufeehvdfftdenucffohhmrghinhephhhtthhpugdr
    shhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptg
    hmnhesugifihhmrdhmvg
X-ME-Proxy: <xmx:jotpZtZ2Da8UdlaT88X_Am0AErrniSRgByeOlDtcu8QQmRVjlikIVA>
    <xmx:jotpZnahC__NSuxbSM8tGloUnJr5G6h0lIyVVrpAvS4c-IXjclMU4g>
    <xmx:jotpZpBfsrgbp2TJrWoKLDuhrOZD9cclstbaiO1-Qj8oqO0nhm6_nw>
    <xmx:jotpZtahK1HNR768QqisVWleHD9CHhdIuG8fzhl90L3UdkWiCTjkjg>
    <xmx:jotpZmknoXalQp0kk-TTYIm7yR0ZLAwufxmS5d98zs_U_x3PZth00Ozk>
Feedback-ID: ifc4b4307:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 07:50:37 -0400 (EDT)
Received: (nullmailer pid 1169212 invoked by uid 1000);
	Wed, 12 Jun 2024 11:50:29 -0000
From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
Subject: [PATCH 3/4] t5541: add test for rejecting a push due to packfile size
Date: Wed, 12 Jun 2024 13:50:27 +0200
Message-ID: <20240612115028.1169183-4-cmn@dwim.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612115028.1169183-1-cmn@dwim.me>
References: <20240612115028.1169183-1-cmn@dwim.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This rejection requires us to make sure we handle this kind of error
correctly rather than throw away the report in remote-curl and end up
with "Everything up-to-date" due to the lack of report.

Signed-off-by: Carlos Martín Nieto <cmn@dwim.me>
---
 t/t5546-receive-limits.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
index 9fc9ba552f1..ccbdf3945ab 100755
--- a/t/t5546-receive-limits.sh
+++ b/t/t5546-receive-limits.sh
@@ -5,6 +5,11 @@ test_description='check receive input limits'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+
+ROOT_PATH="$PWD"
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_serve_git
+
 # Let's run tests with different unpack limits: 1 and 10000
 # When the limit is 1, `git receive-pack` will call `git index-pack`.
 # When the limit is 10000, `git receive-pack` will call `git unpack-objects`.
@@ -83,4 +88,23 @@ test_expect_success "create known-size (1024 bytes) commit" '
 test_pack_input_limit index
 test_pack_input_limit unpack
 
+test_expect_success 'reject too-large push over HTTP' '
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/error_too_large" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/error_too_large" config receive.maxInputSize 128 &&
+	test-tool genrandom foo $((10*1024*1024)) >large-file &&
+	git add large-file &&
+	test_commit large-file &&
+	test_must_fail git push --porcelain \
+		$GIT_SERVE_URL/error_too_large \
+		HEAD:refs/tags/will-fail >actual &&
+	test_must_fail git -C "$HTTPD_DOCUMENT_ROOT_PATH/error_too_large" \
+		rev-parse --verify refs/tags/will-fail &&
+	cat >expect <<-EOF &&
+	To $GIT_SERVE_URL/error_too_large
+	!	HEAD:refs/tags/will-fail	[remote rejected] (unpacker error)
+	Done
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0

