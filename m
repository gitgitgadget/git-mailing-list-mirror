Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1A48123A
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550043; cv=none; b=Jun50Td04iZ5aM9HfYUouvTtSaAp4jEOyOOMWOlGQ260Rld5Vw2bqGKs8XRr0U4wXBVCi3vHpTA39AlbDvnpJShZpak3Ey9ViRhsbXXDX57qYtM7k3LBDL9v/LnFid2dVp3Jc/j4SF5FGrLs440mxArr0RMaw3T77YIs+8QXCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550043; c=relaxed/simple;
	bh=BLutqVKwaDlhvYYKvGUt5V8wXhArvrQkzAdTaz08mGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=doN0dgHdv97wrW0ACHF98XhhhUaFlc/pmE8m6sng67qosOHKKPZRvSUWmoY+rqPw53ZgxY4CG10eAzQTcWOcC+fI5KX9OLS+wGtrVHzjtttaxnX/ahpGV9RmE9I7Tx7A/CpBKyY/ZboZwG4oKqGeZPIOuWJj9ZsX/GrJfkrWknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FrMk4zxB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U3syV7X6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FrMk4zxB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U3syV7X6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AD58EEC05C3;
	Tue,  3 Mar 2026 10:00:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 03 Mar 2026 10:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550041;
	 x=1772636441; bh=+Hk3fbUsTH8EbY1W0m925cekOXAIFlbRS3fvg5tUSW4=; b=
	FrMk4zxBSPiTb+sYBx9alme+ElLSNpovaJ2dJNgX6HhkQcS1rFVsMh8CUQKNL/hN
	03mFPjZTmDa2mVOjx03LwqpiLCyL4xNGyBUTxAl+SVE9/RKcHav6c7zIsXome9Jb
	gM4fcQe37Co/WNFnTMvhMkHP7J2RXyDP6hogVaawlAS2sdaOCn4+aA79Gn1VMbX9
	9rnCLaKSBYm3rLCqkD+9MplYKqYuDZBOQbYZuJ2DWCFtaUEbA+wzYPzfDsbYIhta
	BTIiTe48tzlpAvpCkytRCUSoTA12bADaxYiPWibOH7XbZyGiRbMqpYvwc2hbVkWg
	S1R8+ha+Io/hQyLJ5Awseg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550041; x=
	1772636441; bh=+Hk3fbUsTH8EbY1W0m925cekOXAIFlbRS3fvg5tUSW4=; b=U
	3syV7X6hiOeE3DOw1tviTqGQRjgmtteYiZYxlc/UCByJ/vLdWPGJ/5op+DkkU2zP
	7rDXC+tFinOWk5XG+Pp5CHdoP618jDUHJ8Y7l9CnoIymjhK0URiSk6taMPH1Iq5e
	klR2K70Au1G6RW85YBwkefFX3dg6xBZ1/E5HDJB/Gu6YUC9x8ioPNPqWeCHvxKqB
	bFUk7iEsKhBQ/USGzQyFj2+E2w1DnNNRywAis0ipnxzVs5rXRZzqiv7HiQJuEDsD
	qx2V7/NyLclgVehTLbXY2zuQ9B6aYv/u3I1cHK+e4jdC7YLSWMIaOedXdctd5D1d
	kLxt/fljpmh41RT4YRxwg==
X-ME-Sender: <xms:mfemae7j4AABTr-UgorIDkhvgJ5Y_Rxwh2VNz7E5O2ERxdbC0NzhPQ>
    <xme:mfemae6gH1Mu7lP61jPzfcUFS26B2UEk0Y2qw8ZGWmzol7khsh2HBbcBlk7Tomcz5
    ibMf0NFrlvl0hEwrIsUb9j6UP-rx3v0mBUx-wPv7dwuUO_wKNrQnQ>
X-ME-Received: <xmr:mfemaSdnX_xNjFQyI7BnP1j0ofTsq3pAT6dBF0UhT8A78OHUE-AK2sLxeQiL-MK2ipgbmjSlCCaBwSd3B4F3a_rv4vzEMh5ybAkV9GNVKGx->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhhsmhhilhgvhiesghhith
    hlrggsrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mfemaaADYO6dZvYPWKy5HCA5mDGfffmpywuWaIStIWcWWHrUx5XZbw>
    <xmx:mfemad-A5IbUtD2fWN_sh0og-0Lnf9ILAljvVS-r_AABJDgLTBdDew>
    <xmx:mfemadKGPTnwMMw_cU-IXTwQqw-dYMKw0UD9yL-qxFaNyAiGmDqVJw>
    <xmx:mfemaegm1pOEKFsqDWI0hkLFLrJK9_IGhl7VLmdcSxV6ZgMeZUZ2cw>
    <xmx:mfemafVzI5tBrHa9FtaPu_KriDAbxvLhIYeChm7KB-NUYHeqHxiOPaGR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28b68554 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Mar 2026 16:00:19 +0100
Subject: [PATCH v2 04/10] git-compat-util: introduce
 `cast_size_t_to_ssize_t()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pks-upload-pack-write-contention-v2-4-7321830f08fe@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

Introduce a new helper function `cast_size_t_to_ssize_t()`. This
function will be used in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index bebcf9f698..c6af04cd7a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -665,6 +665,14 @@ static inline int cast_size_t_to_int(size_t a)
 	return (int)a;
 }
 
+static inline ssize_t cast_size_t_to_ssize_t(size_t a)
+{
+	if (a > maximum_signed_value_of_type(ssize_t))
+		die("number too large to represent as ssize_t on this platform: %"PRIuMAX,
+		    (uintmax_t)a);
+	return (ssize_t)a;
+}
+
 static inline uint64_t u64_mult(uint64_t a, uint64_t b)
 {
 	if (unsigned_mult_overflows(a, b))

-- 
2.53.0.697.g625c4fb2da.dirty

