Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B62397E72
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149132; cv=none; b=orIDDOmLYAWNSsTrbANSwsQ1WXnT7yCOa5eEA2d5ZOeMZkY5aozagrttwfMOFQ4oaEW04DaKS5eTN/qV7/D38IQjNJdqSVs5xFKatuQKJd94OcfNktDqattCdsi34odpoAb7VW8H3rp9k7iP2u+BaEYLBvEHrPNBOzRmjnJli2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149132; c=relaxed/simple;
	bh=odjX/y0h2/pWaKDUsobDpw3q5DN595EnKbZrtGaVk+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOX6AmBfLWPqR+cKGpj4lHf75Yxv08ep+U069pUV5dnXXCxUFiQmhp9LM1p702/AWprzrsPypxHrE28MmwIUKTKBNCE19ofBe5+2tCP63utW4iv8U2zEbXXbV2AJgQCN/K1UI/aMwZi+gLvxmCNdj0FtW1kdWLNFZWS7QpCTXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JfkF6Slm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oWJP+RVc; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JfkF6Slm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oWJP+RVc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DF9CFEC0B0A;
	Tue, 10 Mar 2026 09:25:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 09:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149130;
	 x=1773235530; bh=aZHbn1JxWv8qaEToX6nz1Vc4FTg4w4xAMuHDsfvILok=; b=
	JfkF6Slm4ILuklG6rf7sD3oIbeWyKA9cJMl6+tSGKfh8uY9r+7Y5wuPSX3wW5YbS
	4As0q1J8cet2UL9XzqOxk8HyuQLK7rmwSjjmrOUrr+qU6Nr/nitNftZ6L6dUIVA7
	d/rgmOi1e7/nwlDVGPIbP8KZKA5EP5m1F9DmEyaHHxF8e6wtJp5Mq3/2jKo9EUVY
	7D4SHaUDfvnkc46bsecTDQDr1Fs1g+5/wG2soDboa496KPTndVOcYhgpCX2G5xom
	MXKkuvR0D66HplX0FLMXt9cPO9oZoL4ZnWVonJ7/hbtsR8TWM2gZsbXZQQIyXGv4
	MIKdo59o+rLvHxoGSsMpuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149130; x=
	1773235530; bh=aZHbn1JxWv8qaEToX6nz1Vc4FTg4w4xAMuHDsfvILok=; b=o
	WJP+RVcEykgeYht2bvsBtDfWlhrkmbWfGSjputpoHxe5eQBiDh7Ytw9+vbjg+6HG
	Lxe98anqTLFHvAaeeO9+Q419GXXbaT9oPHSK3CwSht89pB/4WNPF3bE4taHf0aGG
	J9VRw9G23NfBZmJFbm4ZEwHK7+IQjQpq+L+YNNugBAqrxjOlIEVZWAjJugI/NIXm
	xWnXMVK89diQkvfl5WHapNW/4KwW1sQ5OQ3Pj62/FLCqx2TTfMXYgHmQ30Uhmu5I
	xS7dpK9b+u3ji2PPXa7ySKvMc7o3wiPXhJntCjNUs6oOmvSDZ7GCqwv3FT5d8T7l
	mDQBCGlndhKYDlH+F3EtA==
X-ME-Sender: <xms:yhuwaUZqYvGrqrlBxzF0Q_CTVhpM8ErfA6mWWYSERAiC5FLi-DhDYQ>
    <xme:yhuwaWQKF_qGe7igHy-4z0CSojkT7Vtd1yr_ozZPsaxzgh0BE5mH5n2sTembzgt0x
    fxrpqAzQMs8uDC3z7ROrZhxmZMuRiylFQVFpp58jH9vqBUMd1Xm8Xg>
X-ME-Received: <xmr:yhuwaXTXZx5Y5yhFj8n1aZrN14LUDw5LyBca4vqhBiOKfwXeso6Ze5JZ5QWPGrVVWtYrAB3lFRLwkS8gBWR_HMXZYJkxLSNe9CSgKqBi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehmshhmihhlvgihsehgihhtlhgrsgdrtghomh
X-ME-Proxy: <xmx:yhuwaaQeWvryKUzpyfCEalGKTGciukUSi4ocbKbjvETY6AozcljBBw>
    <xmx:yhuwac4gLDxxXE25-EHax-6wBK_nVy6bxQMDkpSxQEJYFckh-LtQvg>
    <xmx:yhuwaW1lJyrbOwwceZTWuA3WalWrEIno1T-7uHBgcvz4m3wIXDDdpA>
    <xmx:yhuwaXBlm7RZEQ3je7Syy01rQDUfCKs-5zBXBSfQeFM3RmZFkrU_zQ>
    <xmx:yhuwaSzeqtw8ZsENB43G_pBo73GdvGFH2_ltj0tAp_EGiSqtoqhdK-09>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a1697dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 14:25:06 +0100
Subject: [PATCH v3 10/10] builtin/pack-objects: reduce lock contention when
 writing packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-pks-upload-pack-write-contention-v3-10-8bc97aa3e267@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

When running `git pack-objects --stdout` we feed the data through
`hashfd_ext()` with a progress meter and a smaller-than-usual buffer
length of 8kB so that we can track throughput more granularly. But as
packfiles tend to be on the larger side, this small buffer size may
cause a ton of write(3p) syscalls.

Originally, the buffer we used in `hashfd()` was 8kB for all use cases.
This was changed though in 2ca245f8be (csum-file.h: increase hashfile
buffer size, 2021-05-18) because we noticed that the number of writes
can have an impact on performance. So the buffer size was increased to
128kB, which improved performance a bit for some use cases.

But the commit didn't touch the buffer size for `hashd_throughput()`.
The reasoning here was that callers expect the progress indicator to
update frequently, and a larger buffer size would of course reduce the
update frequency especially on slow networks.

While that is of course true, there was (and still is, even though it's
now a call to `hashfd_ext()`) only a single caller of this function in
git-pack-objects(1). This command is responsible for writing packfiles,
and those packfiles are often on the bigger side. So arguably:

  - The user won't care about increments of 8kB when packfiles tend to
    be megabytes or even gigabytes in size.

  - Reducing the number of syscalls would be even more valuable here
    than it would be for multi-pack indices, which was the benchmark
    done in the mentioned commit, as MIDXs are typically significantly
    smaller than packfiles.

  - Nowadays, many internet connections should be able to transfer data
    at a rate significantly higher than 8kB per second.

Update the buffer to instead have a size of `LARGE_PACKET_DATA_MAX - 1`,
which translates to ~64kB. This limit was chosen because `git
pack-objects --stdout` is most often used when sending packfiles via
git-upload-pack(1), where packfile data is chunked into pktlines when
using the sideband. Furthermore, most internet connections should have a
bandwidth signifcantly higher than 64kB/s, so we'd still be able to
observe progress updates at a rate of at least once per second.

This change significantly reduces the number of write(3p) syscalls from
355,000 to 44,000 when packing the Linux repository. While this results
in a small performance improvement on an otherwise-unused system, this
improvement is mostly negligible. More importantly though, it will
reduce lock contention in the kernel on an extremely busy system where
we have many processes writing data at once.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f5cb80e870..59876b024d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -41,6 +41,7 @@
 #include "promisor-remote.h"
 #include "pack-mtimes.h"
 #include "parse-options.h"
+#include "pkt-line.h"
 #include "blob.h"
 #include "tree.h"
 #include "path-walk.h"
@@ -1332,14 +1333,17 @@ static void write_pack_file(void)
 
 		if (pack_to_stdout) {
 			/*
-			 * Since we are expecting to report progress of the
-			 * write into this hashfile, use a smaller buffer
-			 * size so the progress indicators arrive at a more
-			 * frequent rate.
+			 * This command is most often invoked via
+			 * git-upload-pack(1), which will typically chunk data
+			 * into pktlines. As such, we use the maximum data
+			 * length of them as buffer length.
+			 *
+			 * Note that we need to subtract one though to
+			 * accomodate for the sideband byte.
 			 */
 			struct hashfd_options opts = {
 				.progress = progress_state,
-				.buffer_len = 8 * 1024,
+				.buffer_len = LARGE_PACKET_DATA_MAX - 1,
 			};
 			f = hashfd_ext(the_repository->hash_algo, 1,
 				       "<stdout>", &opts);

-- 
2.53.0.880.g73c4285caa.dirty

