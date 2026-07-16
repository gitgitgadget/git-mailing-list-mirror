Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0933B8BBF
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188382; cv=none; b=X0o4jMZgFgk1NS+DXWmZFYCuy9N8MfHj/jKFhLYkcUlmQHoFA8uRbcHH0+JhhZ2ATsd76KwVAwmGfcOcyZd0skvXx8xq8FE+XlzvdBeJ4udNmILWiuOiGYAe+tkcZo8ubSVIAvYvaC8+ZIP0xwN0rWn7aoIaHUDTPJpjVCOEMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188382; c=relaxed/simple;
	bh=hLu7yCy+LWHaB1a7ORK07lxP4ERR4RIQUULV0+L6068=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OLUcb9fFxkHwM+hXyOozlnJQxOHvus7fALeirbOH3gi/gwsRVMk0WpMDYc4nw/mJ3osnhBE3oHugWbdnwFgMHHnw9fNOGDrWr0/hxOisltyqM/UWL6wnweDHHkT5LMsFDF62cO2n4IK5CPh5NF5h9OyugmBoBCI/p45SUz/pRk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dqmUiDbd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oA1rWjov; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dqmUiDbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oA1rWjov"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6C5F7A0179;
	Thu, 16 Jul 2026 03:52:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 03:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784188369;
	 x=1784274769; bh=S+osyQAK/MgLoCBF8ZUYim641tmlHQpg9g6Bq9WeNqw=; b=
	dqmUiDbd/+7Icc1RxVlowapJ9zY9b09yie2ncQ4QMFON1oNOFDHfvxYgShiIbvEF
	CDw9M4XXSgwtOpH3cgPoBBrbQmUZhdceNTLkvWj+KA31IkEKRb2JF9/5bWd6+6Jp
	qbhirfCLEFdPxmzHg46KGHaMjn7ffrm/LA03Kv9+P8GcHAOiNz2fLKmsTPCjplHa
	WHEOCGTTQx+2DeI3bAYbb6uHW3rj+8o5KuQYP2DE0jibhYNq6Jf0xET5dfXpaTwh
	Sq3vP6Ia8pLjm8viluJwIVPgewr74XEP5hElO8sbmzSww0qxgdseJC3ztW7xAisH
	JCrzT460sR71jlhOm7bbBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784188369; x=
	1784274769; bh=S+osyQAK/MgLoCBF8ZUYim641tmlHQpg9g6Bq9WeNqw=; b=o
	A1rWjovcDnWs3bPSY4Qho4ZMpuFEunFXU/OzgksAlw5TLAfgAm56W4nz4QEYOVoV
	I5i4qoCGVKNSc+SeYIfPMF82Q04Gl9dn1HtGYLK/y3t7pBt2eFGOTyvCU66soCz4
	SoPrdZJdGKsSwv/sGHs+Pp2LdVbioEH2dA/nBqE5BefaogZgXQ0ojUP8V5eXBV2F
	7wP5gNbAvfPzTYbHl2H4GGpUcIlGoszBz3KqvHtogO+/lsaasdeYKo0niPf/tISO
	LfRqDi3saEkNK32CdcwaN2BeS1wEyj2G7uqZUS9HscDE2TXh4lU6rsu4jZC2kRuX
	upsJ8/PjHr6Y5I1YNj04A==
X-ME-Sender: <xms:0Y1Yar6f_Lq59L-PqVKbbrNnSM6pFg7gvfcB15WmFfxuuujd5GGvow>
    <xme:0Y1Yaq7VJREiu538Kbz7m7bDuiHpsxJUSTkSuie4pgGkgpSr9isDt3_hslfzjhs15
    5_thT84KgDIb8skFNA_nwSIe6-7_9elPBiiiAMuWPZ_WSbCsOw2SA>
X-ME-Received: <xmr:0Y1YapHdvFPXpiDFiNTIyfn29Q9ZNpFHpvsSCvhoRMSZ6GElJ21zcSzAm7_1Q2Ci1Y7S77WmlfSZ1IoWFVLGPZGDwUrY3xRy_wfQesZW>
X-ME-Proxy-Cause: dmFkZTFcEXeyN38yd6mYso2C3UMaXrK4MHbBaeBAp1bg8GHD7/ZWMJC9+/oZNdSJAUnAhM
    FUM4bmNPdb0caG+q3Z/IgIR8yRApr9zU12PvTkXki4424VLjWBI2j5Pbrh4PG9eKEtLXvD
    tZliInukeOCslq7pw7VHH5wypogf4YD9vzh3Uhjg2VERdPBjRraFvZQ9gYxAZsnwi9AJAM
    Q9hHf/60PX4e31jY8eZGgsQp2R1fIDCckoL9efZvWL+BUIq5gn49p9LFRVSia9gMVvUZ3+
    r7s4VqvPvWmm/B4IlF//QZFlckmtNBbuJFC32M9dWl5UzRnJOUQ1/w2Z5wY2b+I/AU4Pgh
    Hz9IFlPoOG/HjzHkEd2ORSw8WaAbzXbOU8kBhqXSOKYXU4a7TMQh/r16DCsOj07edrQccD
    Oe8OrjO71jueijXw6zRDoNVKeqwovJUxBMuq1x84bF7tfxmascbx4v9qzOUAfVpnASOgrU
    Dg3i+oIO448VxN82fP2A5pxAueTNQJRDti5uLdfj8Hf6d4mhY2k8iYcCBXMqyFkeklydLv
    9Aef1KclyLmnrmZ/BAjk72En6k9A1CgizTBFzrJwEyHgTp7ZlRta/oduXhVR/0x5YakBsP
    70ZlN0fF1B4Y4YcIdyxAM2KodMTqbp8nNEMwGeGF+ITGbPY4BGNnRKcx57Bw
X-ME-Proxy: <xmx:0Y1YaqWa3jbzeemyq_TJ_0fW_cZqvRGG94rz1NCrm5CZq7YixxytTA>
    <xmx:0Y1YatVml4TRBKdfi6Io1glv9OQzWvYRPz2j6V0hcj7BS0R1i_lGnQ>
    <xmx:0Y1YagIH6i9FE4YeniPF7E9xoNtm-HIqOo6rNmwYjcLnn_VISGqEDQ>
    <xmx:0Y1YatCc5mGIJK6N8aqKw47ddcQMDwvrAAdJmCsqixGf131onM14Ow>
    <xmx:0Y1YaqrBPDU-pOaVySglkHIMgsT_CAWcu2MPE3Xr8ltf82wKf4YjXAuH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 03:52:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 426925b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 07:52:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 09:52:23 +0200
Subject: [PATCH 5/5] fast-import: use writev(3p) to send cat-blob responses
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-pks-reintroduce-writev-v1-5-ea9038c884bc@pks.im>
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
In-Reply-To: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

When answering a `cat-blob` command, `cat_blob()` issues three separate
calls to write(3p) on the cat-blob fd: one for the header line, one for
the full blob payload, and one for the trailing newline. Frontends like
git-filter-repo issue these commands in bulk, once per rewritten blob,
so the syscall overhead adds up.

Use `writev_in_full()` to send all three parts with a single syscall.

This can be benchmarked with the following setup:

    $ git cat-file --unordered --filter=object:type=blob
        --batch-check='cat-blob %(objectname)' --batch-all-objects >request
    $ git fast-import --cat-blob-fd=3 <request

Executing this with 100,000 objects in linux.git:

  Benchmark 1: HEAD~
    Time (mean ± σ):      1.320 s ±  0.003 s    [User: 1.154 s, System: 0.161 s]
    Range (min … max):    1.314 s …  1.324 s    10 runs

  Benchmark 2: HEAD
    Time (mean ± σ):      1.270 s ±  0.022 s    [User: 1.133 s, System: 0.132 s]
    Range (min … max):    1.209 s …  1.282 s    10 runs

  Summary
    HEAD ran
      1.04 ± 0.02 times faster than HEAD~

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index aa656c5195..48fda01c94 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3332,6 +3332,7 @@ static void cat_blob_write(const char *buf, unsigned long size)
 static void cat_blob(struct object_entry *oe, struct object_id *oid)
 {
 	struct strbuf line = STRBUF_INIT;
+	struct iovec iov[3];
 	unsigned long size;
 	enum object_type type = 0;
 	char *buf;
@@ -3365,10 +3366,21 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 	strbuf_reset(&line);
 	strbuf_addf(&line, "%s %s %"PRIuMAX"\n", oid_to_hex(oid),
 		    type_name(type), (uintmax_t)size);
-	cat_blob_write(line.buf, line.len);
+
+	/*
+	 * Write the header, the payload and the trailing newline with a
+	 * single writev(3p) call instead of three separate write(3p) calls.
+	 */
+	iov[0].iov_base = line.buf;
+	iov[0].iov_len = line.len;
+	iov[1].iov_base = buf;
+	iov[1].iov_len = size;
+	iov[2].iov_base = (void *) "\n";
+	iov[2].iov_len = 1;
+
+	if (writev_in_full(cat_blob_fd, iov, ARRAY_SIZE(iov)) < 0)
+		die_errno(_("write to frontend failed"));
 	strbuf_release(&line);
-	cat_blob_write(buf, size);
-	cat_blob_write("\n", 1);
 	if (oe && oe->pack_id == pack_id) {
 		last_blob.offset = oe->idx.offset;
 		strbuf_attach(&last_blob.data, buf, size, size + 1);

-- 
2.55.0.313.g8d093f411d.dirty

