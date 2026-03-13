Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0F1A6832
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384347; cv=none; b=WLL43qcaXE8FQL779V6P389Dd707L+UEc41shWs3BMNkJqw9XpJ9O61a+4pMFzfLyaE9JFEkBCGp4zGEYJ/j4aNpk0TfuYv+GNL1S16bK6HAQCwvKVG2ypursKkIbK021G84hpsGf9GPbaoulagC32vcsDgQio6tR4ByCm3Kb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384347; c=relaxed/simple;
	bh=8U/l9ym3m3p71TmRw62BLpCrmL/2aZoL9FNxuiA/ITc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scMV1c216+H4czbibQYzmbnX9+OuH+AZdWFGPDhPYuGL5WoF4eXL7uXDk+MZLO3IBji+devmKWoKsH8LS6h4Q+9cfP4QXSx/7L6KoKC7p/uDrycdJex8qHAftcYBOWedfJMMWzR6caZ0oAN+sabDkOsq4qB0PcqFG+PqVaNMzUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jgp6BQTd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GmRxKPBf; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jgp6BQTd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GmRxKPBf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B75861D00126;
	Fri, 13 Mar 2026 02:45:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 13 Mar 2026 02:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384345;
	 x=1773470745; bh=ir14Mg3oHXncJ00IUC+83dO3xCbqAiCMJvNAcaPN94s=; b=
	jgp6BQTd8ZBdm7PE1MDNUY8rpKbZhs8854JYtUcPB7ycIyPu0W0lpeJskslY4q5e
	RuJwrH6S18ygAHz/EMZOgkqc24pvRn3aU9Ho3uVSYYskjrKVQEEzA2DhmNPOdbde
	zjDfncNWwlGT6S0daN/BwqsTIAzv7pb90iVjaoBLj7nabVr6OmztsomsI2GqLmB4
	FOhtzIHhhb1vLf6UDyM7YaUI8E46GnzUeDAXAmW4h1eZKF35WRkJ+WofvUTp+baL
	WGS1b3wnz1+xBmv5BhyRqWi6ogG506IoWBdCVN+ju0uG6WZpDGaadXFueMCR/LXv
	b+9xa0MfvtcZwgU8Sv7mKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384345; x=
	1773470745; bh=ir14Mg3oHXncJ00IUC+83dO3xCbqAiCMJvNAcaPN94s=; b=G
	mRxKPBf1p9gRdI85JT7LWF5wnBWtOH3sf0avNv1Uhn95MENo+NDZaneREQC+jBf5
	KCT122gMRHUBJd09nGJ4p4wvfFP1FsYZon6q8kwfb2RvkmXV4o19DjuEqRriIAg2
	ktBljDSqDtFKSmnyv8rlwRvIhoYfKJo8S+Qp8okLIX9wQfhF3MRXe2KFJSg2WFFk
	jDz4QL6PPQkbmAy9sjDK8p1PBZzzH2ThGgVSxmGoZxBGWlCtvYMSdpYHDZioLfQx
	TWTdURIhoHipTBOVhRBQ7LSOQsw3BdB6tr3a2b9SaXUvyiQ1TQVHsB2OAz+6mgHk
	JL30XpFz8iACjv/UsgrVw==
X-ME-Sender: <xms:mbKzaavOuVAfAmK5nPcWWaQUdbzB8tk3ymviYe6cHvrRS5sRoNYh8g>
    <xme:mbKzaa8zgcHSG12fAYgsnch3DOnTlIGMy7u1tZJYwdSdub5cuF82TrZFxV4_FKM1T
    6aYtwnpzXtiMUuFJc0d5MxK5sgXesvdIOT5JoA57mo4YQHecUTF-A>
X-ME-Received: <xmr:mbKzacNlZ2WMA0MpMZ67P15jik0jRAYwhzrIHv3Z9dW_P45VxYfZCwQhY666Atfsd9Nd_aXJp3YEWsVmYeTfHrdISCWd9T2nPIH6NCegmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhhsmhhilhgvhiesghhith
    hlrggsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:mbKzaQFDTTFEedA2Stqlm-fJxS3_qVoCY2m3qRLGztq8cPURLbKqow>
    <xmx:mbKzaSTHAA-XNVB-pvRmTNshwuJAcS8VN7p8ku88ZmFQV2EgQWvtKQ>
    <xmx:mbKzaVtqqDkvzkIS-JhGwMG9i8JAT5-0hCIUUrHfqdrzrfjdxCadkA>
    <xmx:mbKzaSJMmMmAU6F_I3ae7iOjhvLZS3UAcaVfTnEB-diUXuxB0duZDA>
    <xmx:mbKzaU4epv4zmy7ybZicZ66312JOW6p-GXiz16gMJiPoSdRk2vP4xflQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dcbe6191 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Mar 2026 07:45:21 +0100
Subject: [PATCH v4 10/10] builtin/pack-objects: reduce lock contention when
 writing packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pks-upload-pack-write-contention-v4-10-7a9668061f7f@pks.im>
References: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
In-Reply-To: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
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
2.53.0.904.g2727be2e99.dirty

