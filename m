Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883C1DE2D8
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763334632; cv=none; b=uvPizUtzxZ1/aJat7Ymw7R6mXm0+6rqQi7ogsX35iXS0b2e4Kh3p3xXL65z5uPmNYhjYwnMeYmfCyST2I6pnmkn9qib/aFavenSnoad7ZIXbnYE2Azh/lc6vhRuEuws4Xcrk2DwSKL0MdMJUWtwWsgdp8huFNjuwDoozIr9m1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763334632; c=relaxed/simple;
	bh=ZW/ItP52T7PEY4apXYJnRCJ8Cn2xAc97E0nr9l3UIoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=In9DurAZiNubxVhKjUjBnYjDkQ1Ce2LuV5xI8E7gtFEp/9Y63Lzddptx4E9KDKvFDxSNCqoC5vSTFCg5be3+imQauoPgPvqlZeVrMdP9Q+6f2VHke33lQ4is06c3E71iIwZoUlIVYpJCHWDp03rwyyQsP8D6bMF4INIM01OHVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VbLcg3TL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=viemeKWK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VbLcg3TL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="viemeKWK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 18D4AEC0183;
	Sun, 16 Nov 2025 18:10:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 16 Nov 2025 18:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1763334630; x=1763421030; bh=tmAHcoSUhlqyNolar+TZ7cM85bWUINHN
	JVBo4D3mWjk=; b=VbLcg3TLOwiEZmxGpTxrD+yjfBA091RkZCTLys+3X2oho09j
	Dt+oER54gw8CDZ8iwxXzJ3zQXU6wTtVKC9Jpi7a5AkVJWjxyqaDew4MmW5Rm641z
	DLjtLh1VMf525mEXuH3dZa/BPBn0mkDJAEOvxMYIrYhekGn28L69t9F7DRzDr811
	oRWoo/3QUDiQhW9v77PYixl2lmzMkTUIE5QZZP4ylDTOrXUMZHC0rFttwR6czw9A
	gx6ycyPEH5NDjVx0ImLCYUQ1U6CP1Z5/2qWJg+2EvNXNzWGaiRDyMkLGZJzexp4q
	vRhMAmXdBrUt9xFglbhqid6NFCXveIONggDLZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763334630; x=
	1763421030; bh=tmAHcoSUhlqyNolar+TZ7cM85bWUINHNJVBo4D3mWjk=; b=v
	iemeKWKc7HtiQh6zivU7xuCmFqUNIUbH69sA74iF9EQwGHAuSu5SE20VNrB/5ADa
	wKAX45A29sXaGgt8mZWxnt4OGhiRxUTIdjr6BNYjm2sKnZwO+zSLTFB/2mPYcSD3
	8/zwfxBwOYKvNha4Klb5Nqh8ermCWybG/QQGGUeCBMIM5kGNe/AAxkl+N+ewoKq2
	5u41ACON5BYH76SRlfF8dfRxOf3qK5d2A1eiX+qTxjiDZnsVQD367OBX5GBSSrx3
	AqlB0GRMMh4PP+TFBnwcyt9XxNUTCkXPHBSw/PGGBCyP2a1qlgpTraKyYSAd7ZvI
	902E4Dzg9QsS+wX3qj/9Q==
X-ME-Sender: <xms:5VkaaROnXCDjQ3W0SRpb1ZwgyyFNYR1QrA4RWdAo_t_VmmvMYmUlaA>
    <xme:5VkaabYs5DZcG4b239id35DixcAUFRNQrjKpbxyUk1ut1XI8mDgeypZtoiBhH8o1U
    1PBK7nj_L3fVerFHHQT4Ji43e7e9Itm3T-RJg2mvHb49vbdsWARTQ>
X-ME-Received: <xmr:5VkaadqVmJ9t2ZxaYnPhTxKWc3QyB3JR5LaiSKe7QfmFnCONaqhF9skbU6DpgkDmfze1Ug3TRvYguuxOfLTxpdtVtLCtaIagmIOy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepjefhgfefvdekfedthfejgeffieevieeifeegueeihfejleeufeffjeetkeffffej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5VkaaXYtXCSzOUY85tK3S_i78pFEhv9k2jUTsldJnLJVPCPdpz9qvw>
    <xmx:5VkaadTaQPNBFiW4sKJW9IxhNoKYkv5KVh3JUoiewFVtIj0UWYO-FA>
    <xmx:5VkaaW4lOXX4AyTa4io66x36HDz1P9y9F1MRaCYsGWb2P3K3UWgoLA>
    <xmx:5VkaaazNMJT8tG06O3uz7CfI2kvyya1O2IszUvjRKLg4CPHagbMEMw>
    <xmx:5lkaaRFY2XrSCHO2PbSX1AauBxqK6osb-GxSQbYtsOtMqhWqExZEWb07>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 18:10:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Koji Nakamaru <koji.nakamaru@gree.net>
Subject: [PATCH] Use Perforce arm64 binary on macOS CI jobs
Date: Sun, 16 Nov 2025 15:10:28 -0800
Message-ID: <xmqqy0o5bml7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The previous step replaced deprecated macos-13 image with macos-14
image on GitHub Actions CI.  While x86-64 binaries can work there,
because macos-14 images are arm64 based (we could replace it with
macos-14-large that is x86-64), it makes more sense to use arm64
binary there.  Without this change, we have been getting unusually
higher rate of failures from random macOS CI jobs railing to run
t98xx series of tests.

Helped-by: Koji Nakamaru <koji.nakamaru@gree.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cf. <CAOTNsDwS2er+31iFt4EnhW_ZupPG+Uree_qobBVj9v1q1+0vPA@mail.gmail.com>

 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 6668c4df84..51ffa7c1ec 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -103,7 +103,7 @@ macos-*)
 	brew link --force gettext
 
 	mkdir -p "$CUSTOM_PATH"
-	wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
+	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
 	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
 	sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true
 	rm helix-core-server.tgz
-- 
2.52.0-rc2-475-g51926caeaa
