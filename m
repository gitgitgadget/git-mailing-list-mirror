Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AED34DB41
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104688; cv=none; b=MxhhnRtL36yzClgx3UMcjSue0MCDQ1FTJpUJAJ3ZyNFU8ThNG3GE5oiCGIOOOE1VeGPyZ8cB2hjsU+NyDL/8iZSRxSoqqZKGzoVLkMBlrawqE4/uOfOHj42ltHPHuso75Rdxg4fKKfsnb+EsOK8ZrUBvuoiwCiFdWO1B08RODJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104688; c=relaxed/simple;
	bh=sZo/g30JVSTPob55eSe2k4BV/eKohNtsZD9VaHf6628=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PpxfPpoH6aMxhSv+a/NxFkuWdjUSLaQR2JGOofnHF7Ar+NgPXMV9i4Y3Vs3fb301jbBntDtpYS9gRo2UfiKhMo0v1OXQctxrigmo2/v318MqrraWOYOMLYGIGHubBAZ0BWchwOkjg8eq3KnyWAV1oqfu+rx7mT4EXF4wn7UtgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N9g9AzdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g5i7iciG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N9g9AzdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g5i7iciG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B15E1400057;
	Mon, 13 Apr 2026 14:24:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 14:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1776104686; x=1776191086; bh=iw0ERGLgd48Np9WiQcsq/+GXWHy0A2pZ
	y56mNViXxZ8=; b=N9g9AzdAxCpHx1Wh678VE0Yv9yoC6DmtmfbCHRBweiqfcjfM
	HocOO2CsNsbFQxPCxB/UdA1RkadxBphcs4cffMzSul4+FZot11Ps4giYBDR5JLBb
	nWg/hpsJIkNtStUlVRMwyn5ti5E0/60hxUldlN+ksv9V4BwJJY9eMV3Aa7Q70cK9
	rqNXFzqyi6HhVMrjmdJzcEpyyrmaUlcv021NEEVpGP7ZTgNy6+Ydsn6s11MBu6En
	oNTW6+YlRQi8TtKy3Vkz7+mZWQu0Vw53JGVC7UY4LI4qwJTHBDUzhaHmfv52cjkx
	RXKQqCFH57HUaxh0H09ugvJb1hA+82CJ9bqNsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776104686; x=
	1776191086; bh=iw0ERGLgd48Np9WiQcsq/+GXWHy0A2pZy56mNViXxZ8=; b=g
	5i7iciGx2vKpG5t45tM4DXV8JpKj0PkJpGboVbdZPt+WLy9ScrNTC4y+oUC0SyLa
	8PTQpPq9NwwXDpoaJg06Vg6pgNv55oPZxiR2jTwc9zVmsT2JRjPr4icQ4rYNmWXe
	sOHhOgKKexaH7CKp7SPi3jgAvvRqqmWI+LmvOp74zAay3vavLVzvIoK3vKxhLHpM
	KAhY0wWOnDOmuuuqz8riIFT06p58+aesLhVuzp2cTsVmMeFje+tcPjUEBW9Gyf65
	XLtU97atxR/6PPlXtY6w1Us94t5jzkRpix0lLt8Gsb6xlzhAeaebN3CPtCZsTXok
	vUAD4vMLR6nBgF7Cg/pSg==
X-ME-Sender: <xms:7jTdaZ5ER9fAMvC2UPQIh1iVlec4T1x_nE9de6G-9-RfWVRQ_QUD9g>
    <xme:7jTdad7r1Fn5MbYYaz6at1gu-ZNjdTpvsed3m6fDkDrrz0I6Rh-29A3JgXcpbPiK1
    x7ULqhEGubZpLUlEKhSNWH6xyXZasKkg4I2Egq-pI3JYoemdk16gA>
X-ME-Received: <xmr:7jTdaVfvI-4rit6-lgfkubP5CYFdtXzcopjNsCIhOfmEcSlxwoPGzAwd8--FxQS92SLk4ghtYRbSBEx3KIZvQxEZEz98vHVAWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeejhffgfedvkeeftdfhjeegffeiveeiieefgeeuiefhjeelueefffejteekffffjeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:7jTdaRAgqZ0OPPcUO4ApyxeO1fVk6LXANTm7u0_31ry6ZvXn4M3JOg>
    <xmx:7jTdaY880i8Bf-WHDxLflGx1RFH15h0HGuk3cGcqKy5OsqyItBe1hg>
    <xmx:7jTdacKQVmMll0y93B3fpnq4XOzM4EUJcUCC-1P4mWawbq5D20LleA>
    <xmx:7jTdaRgCrUj3m-sID75Y85373w2qCl2gKud_QpEPndvKXZKukV26BA>
    <xmx:7jTdaXbGjojv4MqWCY0UlCqsJlVNoqP6KdHpX6pPSUZA1kChq7b5ULUz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 14:24:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt
 <ps@pks.im>
Subject: [PATCH] CI: bump actions/checkout from 4 to 5 for rust-analysis job
Date: Mon, 13 Apr 2026 11:24:44 -0700
Message-ID: <xmqqfr4yhg5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

GitHub Actions started complaining about use of Node.js 20 and I was
wondering why only one job uses actions/checkout@v4, while everybody
else already uses actions/checkout@v5.  It turns out that it is a
semantic mismerge between e75cd059 (ci: check formatting of our Rust
code, 2025-10-15) that added a new use of actions/checkout@v4 that
happened very close to another change 63541ed9 (build(deps): bump
actions/checkout from 4 to 5, 2025-10-16) that updated all uses of
actions/checkout@v4 to use actions/checkout@v5.

Update the leftover and the last use of actions/checkout@v4 to use
actions/checkout@v5 to help ourselves to move away from Node.js 20.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/.github/workflows/main.yml w/.github/workflows/main.yml
index 826f2f5d3a..6f3d94e3a6 100644
--- c/.github/workflows/main.yml
+++ w/.github/workflows/main.yml
@@ -480,7 +480,7 @@ jobs:
       group: rust-analysis-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - run: ci/install-dependencies.sh
     - run: ci/run-rust-checks.sh
   sparse:
