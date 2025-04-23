Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4326C3A9
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394514; cv=none; b=gOqdjYoeVYgxoJLKIu4I0KdgbhQVeX5GWlqJsJ87MiO0Iq+rA5uTsBHEAGkUjZ6XiMHnc+QCMwk9QuSm6dogxJ5tM1ddOE/8owR9hTtsUF/UO1Vccxa5QpW4GOf1MAiIK5UwhzG2e1yJDTtYE1EpKBFITnDUX10sXxdQRi7fQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394514; c=relaxed/simple;
	bh=6boOCADUrSnmQO1q+1EfD+HJy84EJKd06qTL/GO7nLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=URreDh3bc/eqfv0vbf+kdad9LULC2AJWswOIjaWLvQVchjSJYL5qiZ/0EPQollg+YYxovQG3YV/awgNcRliv2z8fLPL7IjUtXJuWr1+AyUW65owudFtZ9TCT6hqk9TsYDLwtnEtW1R/AuLMI2ihL/WUwFwuCfWYznBFGwKeao50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gviT3EC/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Liwl6NGJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gviT3EC/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Liwl6NGJ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9894C13801A0
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 23 Apr 2025 03:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394511;
	 x=1745480911; bh=aSvkC62kO96CjfmeXSwYNIJsHnL12iUn42oBlMB5RMQ=; b=
	gviT3EC/uLwSDxwKZi6K0nD4t+yzKVtuYf1mq01Ck4H4ec4ufLPofSWZb5nnIP4g
	iZkpaNhV3moMGY/MR9+sXcXaGmUG2Ak5GoNK+k8a+mcaZ0IC21wJWntUWQKg/3/j
	zcNghuy1rxAUYuNoS2r5FBmAUfDHnJ41lY2XoJleAuXpHhmWE8L2FCgjEaeOgZC0
	D8n1I1howopl64Gz4MK49g04Bg80MQZD5Y2QTkWAyVbzH/gv1OkZWYR7Mvy5ghEd
	8MNfDF7H6hpnvdA+hBCIUXqoH1D6nw6V871DfEqrGz5YxdT+OcCY+k2l+vsVJPYe
	/WDZA7pxGgfGrvDf+YBRnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394511; x=
	1745480911; bh=aSvkC62kO96CjfmeXSwYNIJsHnL12iUn42oBlMB5RMQ=; b=L
	iwl6NGJO55JDWRsZp3igs9O64jEd8zVUjGpnXAhRhq3CTiTgKEra6ePQwFuB9gNo
	+ueQ9usHZ3BB0MDl2SCAJYUeOMYTxsKyYLCV1vSazUIbK0dAutaYFnt+dpQSoeQH
	HfewRON3gWSy1JGiZleo5myLqw7h0DpvvV9/MrcaJNYUM9m4ninJ+MBzygIzGLiA
	bMh4D3dT2hVLUasObQD4QI7IYbwnXnybsWhNCkZ/C5BR18jYAcwda/Z0wAtMtV6k
	RuV+AoRUYJoXE1nlojRM2MFcMy21M6FxNgB91e3AKnwVhZLuTpXt0CxVZJiYO6bV
	v0FBsoIebatuHjlhNxKxw==
X-ME-Sender: <xms:T5sIaFe-3ApknDlUpKf3U7N9zXJJBHW3ncrvgAm8BCjvVULQPAxNRg>
    <xme:T5sIaDNRKSWB0aEBLmNm0_8xNaTcaoQvCEIyDlplPDWLDQbva1FXwQJnErEMwWJ6j
    7ugjAR8TyMc6q0oQg>
X-ME-Received: <xmr:T5sIaOi87_2ZUz4l-jjLkvGggeZsJFn_l_vZ0XIvwQ-bJp_02DbYD35y3PV2qOiWxa0mRa6Xc7sFO79_zGKR-U3wleJkqWI5Rom_663TQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:T5sIaO9Kjx3-IbA-NDFPvjsQ68umznytx9fd9_GkDw0gJUGtXCJ3Sw>
    <xmx:T5sIaBtm7eURvIBu09_fAwgs8w0H9A7t8csA-p6jpy1tpPOdeb_6_w>
    <xmx:T5sIaNFXmzsSUeNQegeBgngeSCdgFYZHlqw_48xHExthmmt724D6TQ>
    <xmx:T5sIaIO7U5dEKGWsJi7sUHwQaVcALwWiz1ljG-Co3ah8HrKie1H1xg>
    <xmx:T5sIaHIFWVHkRaceup0hdOJGb7YcYp5hXlj0hRehBDmD8SZS14Ixrov0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca49b44b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:19 +0200
Subject: [PATCH 09/13] refs: don't fetch promisor objects in
 `ref_resolves_to_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-9-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Similar to the preceding commit, don't try to fetch objects pointed to
by references. Any reference whose object does not exist is broken by
definition an, so we should report it accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 6559db37890..0492cf0d13a 100644
--- a/refs.c
+++ b/refs.c
@@ -376,7 +376,7 @@ int ref_resolves_to_object(const char *refname,
 {
 	if (flags & REF_ISBROKEN)
 		return 0;
-	if (!repo_has_object_file(repo, oid)) {
+	if (!has_object(repo, oid, HAS_OBJECT_RECHECK_PACKED)) {
 		error(_("%s does not point to a valid object!"), refname);
 		return 0;
 	}

-- 
2.49.0.901.g37484f566f.dirty

