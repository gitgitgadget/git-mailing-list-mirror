Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F7189B9D
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687644; cv=none; b=RVTDv6OZDWwz927RJ9fm3g1yyF5vGTahYngOG+oFnpdusBOSl9AA/NjnC03/QGHjzmwiJTXF3l1v5jlGEyXr6ixWlqOwq1aF1yZCKYwl6KHs+1f/hILj5N2CslXeJZVhl00EMOqTYc3mfn7JAEPIiuYNsxiB1Y8JK/nna1//cKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687644; c=relaxed/simple;
	bh=8RFLKRkNUZHLOj/cOWBG8pPv9dXIFZgnULHvje1BIn4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6VrRDjeory7eC113ZnurQi8e45jEMFcAG75Wy/0PXaBbEmFOiKbVxeUUw1wZabnVrvwNtq2zD1amST+om2MVrOhC0flZjEaOpNo0qfPwNeKNWS2cc5fc49pK3nraaDhO07JSOWtdtNVx+1INSkX8KKZfVv/YLwG8nhyfTfKftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QlXVpcuo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FJOl8UJx; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QlXVpcuo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FJOl8UJx"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D84001140259
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 30 Sep 2024 05:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687641; x=1727774041; bh=9u4LD4Ms2h
	XiiRBwJSsqoastO9z8xmpfgOompqTiH+E=; b=QlXVpcuoC5KVL6KWuztu3ngaAO
	gy1Er4e7kB5GgZrgHDfY54KfYxvsdsK8AB4C4O54/CzUm+HJ9m1FEOCFQECDR7WR
	YuvNqIVa8WKgmEK78VrWdTbyW2CKQ59109dwGrAmcZmU862hQr7gJl6YycBVMhzA
	ACC0LBGXZVpalKxv4cHvi7fHerfwLonYoz26t+6La9IIpatzLIR72VqzN287NRGY
	kHvTWxWTRR1BZjEWIxIjLnS6krLpkyqyl5oTVawfcwbKRmGMhlGJqZNocoScUNI3
	z/q0xGBujzvK4pIEQqUuPczH+NjwQNtOkfm1mfrerjtAZAnucVyPSxS0XFkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687641; x=1727774041; bh=9u4LD4Ms2hXiiRBwJSsqoastO9z8
	xmpfgOompqTiH+E=; b=FJOl8UJxs8W4Ps0xQKtgNOB8/ZUcYuoFt7iueOJDiTcn
	MCGG42YLgKnVLDr6HjVl9WiqRYWSJOkYADBZ0YhkmcGBpT5WFqo5pMppgRz5/8D5
	krZAT9n0cu2IrYtDIxasGOgTWZwjOM0QKV/fwiGGqbyBsGVz41RhKwt4e/0zoUj4
	jBYd+lbK58RaA1pBYRx52whxtnAB4wl0aRj8LqGOYUj4mWZE1ZoIRsIku/mPOZ/h
	QmsQXoPYW211r6aQN+7hvjmMM9S9wiG8J9RbxVM6FM45Vmose0qnYQb6ppvVTbRK
	96jeunT9Q1bnfKTLIqIyfUsvK3s+DsnCN4GZk1JhmA==
X-ME-Sender: <xms:2Wv6ZgXUnV4bcAlSH1vW0XFvvoMSGJwUakSnjXHrlhHAJt-ABqHl4A>
    <xme:2Wv6ZkngQShuW-4E7AOf8zPbL7BBK1wY5tWw4dt1Os8NGu7PPsyu6GfobNmCMGJ7h
    mfUk3qXCkuEJyxLXQ>
X-ME-Received: <xmr:2Wv6ZkZtOlxp4LGAuCUKYlDnlVM4pJVmThNON7FwTYlFs8hnEOq0vn7hzMh_VA63YTsf5mMhYmbBs1xBLwpK7tj3NFB06X2EIR9Ho4Io2nvV6tI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2Wv6ZvXWeHhuTgF1j5oTFUXw6GY8l8DyaZ0P_36nwFF5W3Cwr2GFdA>
    <xmx:2Wv6Zqlos7giydVGzcHAkBaWLvhwRvM16WqhUJzVLF_tiFQp75-plA>
    <xmx:2Wv6ZkcCHl8-Jjcr3um8Ov3oO-cMOIJDO68LJcC5QRrnYIfhgmF1-A>
    <xmx:2Wv6ZsFT5JMxAYkhFPBeRbjoi4WXVKf6WyUcJUkLjdhuXYsbbNznQA>
    <xmx:2Wv6Zuvr1exrWm_imfbucnCyPF3EBSdLzc1s-CTP0tDmcAizBlTviQj->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0a5117d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:15 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/23] pack-bitmap-write: fix leaking OID array
Message-ID: <98228243be04d7ab296ccf7516e092549bbd1236.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

Fix a leaking OID array in `write_pseudo_merges()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap-write.c             | 1 +
 t/t5333-pseudo-merge-bitmaps.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 6413dd1731..49758e2525 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -913,6 +913,7 @@ static void write_pseudo_merges(struct bitmap_writer *writer,
 	for (i = 0; i < writer->pseudo_merges_nr; i++)
 		bitmap_free(commits_bitmap[i]);
 
+	oid_array_clear(&commits);
 	free(pseudo_merge_ofs);
 	free(commits_bitmap);
 }
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 1dd6284756..eca4a1eb8c 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -4,6 +4,7 @@ test_description='pseudo-merge bitmaps'
 
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_pseudo_merges () {
-- 
2.46.2.852.g229c0bf0e5.dirty

