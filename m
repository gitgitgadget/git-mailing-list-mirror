Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B9C3B9DB3
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149126; cv=none; b=BE2hC02pImfrfF6n2AW6D/w7j+6HGdv1/67CCMquJWwSszwJ78Jofc7QJ0rq4YgV91iBCAEtm0zKKJxbtBFA7kjE2XnjCHgyAXEkg5ViM22oS5XYUVOelWmcFK60t6hNrv2+mrIt/5/H7lnHT0HE2QHylX1Jleykg4IUf3rbeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149126; c=relaxed/simple;
	bh=9CXamLf9q8x63UER8rUtzNhfrVoWebgLh+K1gfWfoc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKO7w0OunWN1da8L/kr6WDcbDsfbkImbldiYHOeuQT2ft2j+uPCuDH9eAns5q/Nb/3POzC2FibtDwZhsz64ewqC2ePzTuo3WYbDhpS5MvM7CdHJ6mhR/YRDq6m8hTDR2VgKGzv8YeVFOWGEMBEJG4/gNdUf1ZTvM6MdB3eLkXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AUXGXN45; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zHD1YZjl; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AUXGXN45";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zHD1YZjl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1FD61EC0610;
	Tue, 10 Mar 2026 09:25:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 09:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149124;
	 x=1773235524; bh=2mHwtmD2oidoJg5pHHjGCgsjgoDtFh3HXNm6jInQ+Lw=; b=
	AUXGXN45HOtl/eVSFYpqbGiKu2ySZzfGFLT/v7lqlHe8BrOycU6Iv9VjXuuz6E9c
	zGYMKGcnUSXzJFJX0wUW+/N+c+ovz2FzfROes+dYv9efdvCMp1SJXPqawqO7A/yB
	Ve1h+mymkSb652fKUvE/0jOMifaPjUU+C92i7WO4ozQPP11Bx1HabolP6EaY93+y
	3JXD8TnxyVFkHAg43Fz1xjJzNq1ZGSR6cELR44zgRq30I4mDgfsz++9ZEXM6Ac2N
	64XY/1NBtcZZ5KxQ1t9A5B9xYurZ4g+8pcUleJP+n3CFnBz4s/POlCHJm5II4AnB
	RmyXBN5yszHUl7v0EAx2tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149124; x=
	1773235524; bh=2mHwtmD2oidoJg5pHHjGCgsjgoDtFh3HXNm6jInQ+Lw=; b=z
	HD1YZjliWtGBh//u04RV0EIGSk1R967xqFTs4xxPI0/L1yWDMZlokW+I8au2n7aZ
	ukJZtvlJ9+4PRJwDxSj5H6UbXQ+Nms9Ugn7fRjKNT2zij/Ri9gC0jcLkQDFyyFJG
	B0NHRr/e7QhVgH8gU8NCUwfcJN16TzZwuY4c8Dyp/QfgF7JNhVMif2dMYl/ob3fB
	gAH1shAVAmDiipUmXGRjNg2Oqnfhan2w3eH5btlbPULlkmK401cECT9Am3QxWw0R
	PKt636Qp2sXG8q4dGnkk2oqB3PtQZzOZHnKtFAIHSdyJkB8cOzP5fpT8TlLVthgQ
	/DyL6fRKZMmO7x/UxQWqQ==
X-ME-Sender: <xms:wxuwaRSC1OU7hmIPJXIz1yUcibysltWQWbqI1pd7Ky1pEkqKJYLBGA>
    <xme:wxuwaRpB9iXROUY6TboZrq2qN22iwNsQdTu04WBDNSTMSx_qt3BcYV2spcHfIgVus
    _NVzlCn5CgyGjRXEDyLgUkuC78xBghaL27ZCmouA8jElnpsQ2Eo4g>
X-ME-Received: <xmr:wxuwafKmYZs1p_rZe0zc_S2B819jDs4v4r36LfKU4A_6mcFbJvxc3dzLmwtHGu1mMGvlh0FOC9awRzEV9qbtW6SNHMkUOqZ5p2ix78fn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomh
    dprhgtphhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:xBuwaUqrSi2ChBs80iWCNIaH_13bjFxNEyBjHAbBUQlgCMoKI0uLkg>
    <xmx:xBuwaXwn_acIJBycl1DE-577iRknBJfhD7wnfN4BYt48rMSAwMEUeA>
    <xmx:xBuwaYORj-oYwmxjw3nllFtJpomdazNFanB6omEUhNQMqdb97g9Yeg>
    <xmx:xBuwac7u2fAKO0ZQkzMJYbNY9zidHJb9WHOwJ0avVERKCxVf3ZZVKw>
    <xmx:xBuwaRIV9ieajqLddBh6iT7uICimVYi0pyNLUMma_8_pfgz_xU7lhrVM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba87ab9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 14:25:03 +0100
Subject: [PATCH v3 07/10] sideband: use writev(3p) to send pktlines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-pks-upload-pack-write-contention-v3-7-8bc97aa3e267@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

Every pktline that we send out via `send_sideband()` currently requires
two syscalls: one to write the pktline's length, and one to send its
data. This typically isn't all that much of a problem, but under extreme
load the syscalls may cause contention in the kernel.

Refactor the code to instead use the newly introduced writev(3p) infra
so that we can send out the data with a single syscall. This reduces the
number of syscalls from around 133,000 calls to write(3p) to around
67,000 calls to writev(3p).

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sideband.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sideband.c b/sideband.c
index ea7c25211e..1ed6614eaf 100644
--- a/sideband.c
+++ b/sideband.c
@@ -264,6 +264,7 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 	const char *p = data;
 
 	while (sz) {
+		struct iovec iov[2];
 		unsigned n;
 		char hdr[5];
 
@@ -273,12 +274,19 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 		if (0 <= band) {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
 			hdr[4] = band;
-			write_or_die(fd, hdr, 5);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 5;
 		} else {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 4);
-			write_or_die(fd, hdr, 4);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 4;
 		}
-		write_or_die(fd, p, n);
+
+		iov[1].iov_base = (void *) p;
+		iov[1].iov_len = n;
+
+		writev_or_die(fd, iov, ARRAY_SIZE(iov));
+
 		p += n;
 		sz -= n;
 	}

-- 
2.53.0.880.g73c4285caa.dirty

