Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF053EB811
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550058; cv=none; b=b1r4V+/U967QrqDr5qz5bDozK97NUzHKAi/YglCzlTBMAmgiMJFpFTwi16TTiCyLONKqMDXsG4+5NALp5Y5Wa3cokjyIlKEBHhpIXt7dEcf6ihOOOcoOxbm5siMtZrT0A9aIZxChX/aU8dWRJTAKpVUHBaurdpav6oRJA0aa3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550058; c=relaxed/simple;
	bh=snolIxJ9so5a16v4+tK37myWhTSWeJQWCyvmasuZH9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQLlah/mivbGQhG6oAC7QJlNedfBaDJutjzQ+wNH6ZEIrazXpEXC9PIAmm+e0TkHWTo1dbAc+oQqZWRjUU0YPXK8IyQg/8MfPdBbb+eRdQsXS/3XpEBXd46fa/aVDM6O+r2T1+5agnE3S1uEGYbImU48koryZvHh150v9dwfmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nlXC/bo6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKuOtm43; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nlXC/bo6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKuOtm43"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id ECD75EC05C7;
	Tue,  3 Mar 2026 10:00:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 03 Mar 2026 10:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550056;
	 x=1772636456; bh=hO9iCA51pUfc4VqxhkAWFs8AMWhhfd1Ktvncw2MM1eQ=; b=
	nlXC/bo63oBJl1UufGsTdPBQk2bfHI0uh+KVd9n/viigsCXLE2cJ2TITLlj4WseX
	JNDgrdCEzsnjvvd9rQgS9GQPjf676D8rm47PO9oCJxCXGZ1CJFlj8hjPogVQT+rd
	ql3pbplKJ/8aSx1Z7r8wyfr6HLB4NXVJ9nOKdsrsn89y7PkIpbQhJw6byxhKzLMV
	RW/jOXK4QsGn+eOyDv54US+4aspwepV6Y6/PMbv6fXyJEE1YUQIalSEV9tLQdI45
	H14+yqg8Irlux8ki5SEbcmSIt+cLE5GdUyciG9GF8n0vpk1JvZ0gQYto7Eg5hZIa
	UCG3H4wLqc88zehZWlSS9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550056; x=
	1772636456; bh=hO9iCA51pUfc4VqxhkAWFs8AMWhhfd1Ktvncw2MM1eQ=; b=U
	KuOtm43TvgilGoJTR0JyezUndAWtgGIAX8ZGkYn+uABDSJhsT1IfIA6OR8744EzA
	E9uAt0ij9QUwAseayh6m4SOYIJHBnEtEzrnEm33fFHI32Zq3kkuuAIKBUbsJL2rS
	OvxW7wcnWS794faHcC8lYfu/xZsdneuC9jY93MggdCQA9Jfvl4q5UPA6C9wBLv0T
	XpRe95Ahe9T4EyF20hEHwcXXg+xYcAxbvjEnMxQK7zUMDsVqy1GjWjEcJDWogBPQ
	zCUIc1GuJ6QeeJ/idRmBzF/4gphFw2p4WyPBmBci7uxF0r/5C4x0zGjmM/WmRCdE
	Z+EDXq6pPnZGZNckV/91A==
X-ME-Sender: <xms:qPemaXn6Py3LussT84FcmhueSbeZvnXZ3ABsADXfTbkkZrXzU9zWeg>
    <xme:qPemaR0cAfgvtLc8_0OLeuVPjpU37ublq7pQP-FYcXWXLFHSC3BhA8wuNRknx-iCJ
    W871FRPTJ9LmRL_5fiZGF4cQ0Em2u5kzhMyppkaL_yCYGy9AGVK7A>
X-ME-Received: <xmr:qPemaSoUYRa9iTEVFikz0ubLg1TMnDLCTP_50i5kS3pGHZzfA-WwRgZuKvJHWES4x_4G6DH18fxreLeuGGgyChNvnc1g5W9TWrNyCGHLwejR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qPemaedfS5thfMSZG-44zghPstI3W743uesCs8UxYxLdulOmoX41oQ>
    <xmx:qPemaRqVdj-Z1KTxd4Xqv2m63XETzzrDFxbBwF1B_jS30axkLa1Aeg>
    <xmx:qPemafElAd5YzlIjI8ZQXtZSVHVVaYzwzXbLaFQpGHu8KBXs-nucBA>
    <xmx:qPemaRvBqg4g9596WgESpsotn1mLC_uM1dKzFOlG4tN9C0cqjfHs7g>
    <xmx:qPemafD_Z6h17Vkh7LVEB__Unu2emISmnSYMFyLdRRw9JnDhsL5_cQl1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84d73118 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Mar 2026 16:00:25 +0100
Subject: [PATCH v2 10/10] builtin/pack-objects: reduce lock contention when
 writing packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pks-upload-pack-write-contention-v2-10-7321830f08fe@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
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
index db04e6dd0e..b8d684522d 100644
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
2.53.0.697.g625c4fb2da.dirty

