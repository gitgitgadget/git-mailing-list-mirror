Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C11B85D0
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320818; cv=none; b=IRAGN3+a28RuKe2PnJ4XC66DBLFT5s/7gJ+d9ZbRI6xwGFTq3Q7iWkqpc4UIETLBcDlHZfJs2aj+P2Xdr8Ryn45sLviKeAoriQfQgCNBNHoYXAzIsTYg6RvdIEPfFIUZzA7n5qrxV42IeAl1vPeI+B5SIQ6Z24h+e/c0bc2SY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320818; c=relaxed/simple;
	bh=nFeC6BtcS+hOfHxDK3EtT6qcz0nydlJdwyNZA2ujWho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gArVz9Z/DnL+iC0bX3vpO4DKFJatGJ+BaOdGN9ybZTtwJaBvGZuQJsxI08dyky1jkBrK5RUpqV+ijrDRSuco5ywIaArgbr+0UaRyJGX0I98W85PsUdaDpX6IEBZMISAQndNZdSMS4MKCtviqMVdCccoLPPFnQZ4s5Y5U9ruhl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y7mICj5N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbOWl2/h; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y7mICj5N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbOWl2/h"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF9591140109;
	Fri, 31 Jan 2025 05:53:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 31 Jan 2025 05:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738320815;
	 x=1738407215; bh=3y8btysFk6GGvvuftdxS6BVIk/hr4qyQagAbM69FupY=; b=
	Y7mICj5NCzdhaOZ4IPNrGzqH/bP+xNK1c6D4CH6DgxYtxAdHSXLzvqmxvuzxZ6pM
	TrSJxsXzDgrAhW6zSNAobA4S4/AcW6x67gDBBNLFIWqXsadfxrGgbj6hlxV01tYH
	TAuTzJ5d6+6k2EUK6meh703TwKRFLFTeXxk6fui4Cy64aYFJ4qJvE1oMxugoRrWM
	T74ZpTJAEp49Ah4YEzTl7aWwRzCFlSvigHyeUQ/1SOQCdPUFBnEfmr77ZGUCf59a
	fu/ekaq3kwzEzhkdrEeop9m84K/vxijletHKjgCXZgvR/9z9DEPi5N684Q9QPanL
	3R1PUSs2sW8TAvIQ6Nthvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738320815; x=
	1738407215; bh=3y8btysFk6GGvvuftdxS6BVIk/hr4qyQagAbM69FupY=; b=b
	bOWl2/hnCioYMdzFH5C8QyFliK6NyX4hwlOW+ySovhWGrsq2T72X68iD7WOlkj2F
	9S2u/mvqLfjIt83bRaq5uCp3o7Yer2x/lcFx/y8jtvyGApyjojy0D/EmEsWxbFqM
	YeJdAAA+Sif4ItXaiR5V3hk0pTJ1mW2BSIynK/NlgkAAJ1zp7puwUZqrDmS2KG4G
	VZncYI1KimwDf61TznQJDTZpsX7Ctx5WTmkQyhQ4G7UbrYtKUT7wAQEpPYCbscT7
	cItzTNPjvma9IuiCifV/i4l1tklD6ZKpuKWU27nL1Es9AALvk4Y3AtzApe406m3t
	aveIE1aE3UPicKIS3gSIQ==
X-ME-Sender: <xms:r6ucZ_bwpKIxINvkqERHdNa7v1yW5ipuUgrCPbLfRTqOrwuNzZcY7Q>
    <xme:r6ucZ-a4dS9QZYpXmEOqs6mQKhonG36XKEKWeEwqU2uvI7O3_l3_jY8CBPlBLaDEp
    hnhDo0HQbO5v50RNg>
X-ME-Received: <xmr:r6ucZx-2pthXYBymxZRA4eyvvStwED7ndQ5S73MJcmjEkVc6equHg_WAZCi9OofQUFlFvZxOyoxd4IBVbFFb75psRstteTTwwb_0e6_7-nSRgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepiihhihih
    ohhurdhjgiesrghlihgsrggsrgdqihhntgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:r6ucZ1rREhIFTknmxcRDGAu-_Y-Mn2YCxpt4LTzCC4i3zLNd8SbagA>
    <xmx:r6ucZ6rDVeFjnz5pBp_qXE_LOz-AC5QcbWvIExsEJLL4hHdUROHGAg>
    <xmx:r6ucZ7Sn7UyUF0Hra-3BiFgEyTbxu3ipNayIyMq54RsRtswJiXD4Mg>
    <xmx:r6ucZyqxaWrVmr-xe_j6X-tOtQHbm7G34xaEJJiSPhTsU7LPtrXcVw>
    <xmx:r6ucZ9XPd3Ra8Ps7d8hYpDpdaZukcHN2iSWyweVzsxqx2aCHN8m1d9WL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 05:53:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ccf7192c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 10:53:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 11:53:31 +0100
Subject: [PATCH v4 7/8] t5543: atomic push reports exit code failure
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-pks-push-atomic-respect-exit-code-v4-7-a8b41f01a676@pks.im>
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Add new test cases in t5543 to avoid ignoring the exit code of
git-receive-pack(1) during atomic push with "--porcelain" flag.

We'd typically notice this case because the refs would have their error
message set. But there is an edge case when pushing refs succeeds, but
git-receive-pack(1) exits with a non-zero exit code at a later point in
time due to another error. An atomic git-push(1) would ignore that error
code, and consequently it would return successfully and not print any
error message at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5543-atomic-push.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 04b47ad84a..32181b9afb 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -280,4 +280,34 @@ test_expect_success 'atomic push reports (reject by non-ff)' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'atomic push reports exit code failure' '
+	write_script receive-pack-wrapper <<-\EOF &&
+	git-receive-pack "$@"
+	exit 1
+	EOF
+	test_must_fail git -C workbench push --atomic \
+		--receive-pack="${SQ}$(pwd)${SQ}/receive-pack-wrapper" \
+		up HEAD:refs/heads/no-conflict 2>err &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	 * [new branch]      HEAD -> no-conflict
+	error: failed to push some refs to ${SQ}../upstream${SQ}
+	EOF
+	test_cmp expect err
+'
+
+test_expect_failure 'atomic push reports exit code failure with porcelain' '
+	write_script receive-pack-wrapper <<-\EOF &&
+	git-receive-pack "$@"
+	exit 1
+	EOF
+	test_must_fail git -C workbench push --atomic --porcelain \
+		--receive-pack="${SQ}$(pwd)${SQ}/receive-pack-wrapper" \
+		up HEAD:refs/heads/no-conflict-porcelain 2>err &&
+	cat >expect <<-EOF &&
+	error: failed to push some refs to ${SQ}../upstream${SQ}
+	EOF
+	test_cmp expect err
+'
+
 test_done

-- 
2.48.1.502.g6dc24dfdaf.dirty

