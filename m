Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C7254B06
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031792; cv=none; b=iHh/BXPGN1BHqTEXVD59mzoCpoGblPJxmzA1GBS97dj8H86GJTmrSMhRP3qye30WYouV9xApUiiclq8pPSEHMJEJ2fQGbkWgAkRrKuhdhvpk6UUwd2biFPpD1Hklhx8t49uwrac3ToDXgH6YDd+t521df53tITeZnR/Fu/8tS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031792; c=relaxed/simple;
	bh=FNzaxPpnPc1UmJ54YaeF5tdlhCzepg0sEe9Qtc2ik5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbpG5MXXch7ywNR9ogqCjTB2Nzt8RYqGo8qE146l65KH7rY6m/k/Ur0jYZghhmCiOoIvvKYY6mt/xcehxgRwbnyMP+epp9pkAcqsaKqIxyT45AGK2a69OKB4BW7bWPW8rV3rZI+lg4bi1PVn1Sq0qGk1Ss7GHBmUoXoQEQoJ8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A1nlAVoh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s1xfl9LW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A1nlAVoh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s1xfl9LW"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB5C8114021E;
	Mon,  7 Apr 2025 09:16:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 07 Apr 2025 09:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031789;
	 x=1744118189; bh=GfI3GjqovTr+NO4OovG9dDXowrPS3ukWkfvxem7+gF4=; b=
	A1nlAVohY5nfVOMwJkGv1VexzyhBQtPpwhKJuNi1sU63jgC3OmoqYl3z2Jd0QFcK
	rU39hNu6Npud0kTF0ZcyzwEWw5rY0w311EEC1pFlR0GSU+1WgJIiVs16R9senvaQ
	Ea/CqTydxm5pRkd71Eyn8R8D4MpdBFkNm0W7lYE0fCaZB6ST62GVVy67BZpz+v/M
	PVFQheyKRPv8eecqoNjk4BVrXWBcKM6r+6RrGeCR6mTYzZuiZKlGUpGdCiVeN7f3
	YaSIol8Q5lKge8OJo3W4bjoOdWt5ePmHHBZdBVG+YQYCU2Te1r91VYXq2vH8yll4
	LSnhqK5eqNdvzK19nvHk+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031789; x=
	1744118189; bh=GfI3GjqovTr+NO4OovG9dDXowrPS3ukWkfvxem7+gF4=; b=s
	1xfl9LWH/fu6bscy1xVYlQ1aCE5y3K20zJuTqwZ5qmGnpQLL4ogRFZmmS3Az0gL1
	DnVCv42zMr51rVWPOlM9nI9f5L7OHD38vaLXo1aaUBlK2tXg2vNbm5VqwezXpUeT
	1e/6ijH1XwEr0KxhMT6Yxq/zLJlIJEyuNABH9ol7SEoe3Tfa0LPLIpoKp5sxSwRg
	Cal6xSa6KkDg9a8TdjyExT3wSHZeIMA815va9K3mn3geFen1/Sq/AtoOUqRMyC9e
	ntu+S9TZCuj5vzjiZOT7RWUSI1BYQo/q/atg2Wd6ePHbgnf2WdSIwo9Czti/KOGw
	sqaykVvlVs3L8A6/CbEdQ==
X-ME-Sender: <xms:LdDzZ14BKiNW4016x8y8ip7cpApCXisi_iZIZ-hJrnzlHPb6uMNjqg>
    <xme:LdDzZy4lu8TydeAewYN9KTl8u5ZGsjF2EWpq-OEmH5ZtElC2Gh3lw6IH__encHJB9
    DOZPYfq8WHQNQu9Jg>
X-ME-Received: <xmr:LdDzZ8eA3gh3kcunMF6drMtI_AM2mlTSceOxSApC9EZXfupMox5ZPxyHH6CniIP6uTOigsN1fP6Ny72f-cDocrRIuPxnbhgE67Wzdud5W-emAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LdDzZ-IKxzxY_X0dlo0mRrIqZqlgrvp8GCVAidKZlO2e9qHsFvqAIg>
    <xmx:LdDzZ5JyIvXuXrS0imuJbRAT5vOV9CDxTJuX5HKC4fzRU64T5ylvbQ>
    <xmx:LdDzZ3yQGA6lfJN5BDrIKsq5m_Tv47jslJPf7olK6ivTGunI5mZONg>
    <xmx:LdDzZ1J-Mj8DBf5tRzppw4RZE3wiJFzXPy2Bxd-u0jHbvKw4mBw-_w>
    <xmx:LdDzZ0UAcc3TkJ_dUTl6oF-Gk_XNNcjeFvLZqo43qMygVrLxlrn8nGE1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f21eff2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:20 +0200
Subject: [PATCH v2 08/16] git-zlib: use `struct z_stream_s` instead of
 typedef
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-8-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Throughout the Git codebase we're using the typedeffed version of
`z_stream`, which maps to `struct z_stream_s`. By using a typedef
instead of the struct it becomes somewhat harder to predeclare the
symbol so that headers depending on the struct can do so without having
to pull in "zlib-compat.h".

We don't yet have users that would really care about this: the only
users that declare `z_stream` as a pointer are in "reftable/block.h",
which is a header that is internal to the reftable library. But in the
next step we're going to expose the `struct reftable_block` publicly,
and that struct does contain a pointer to `z_stream`. And as the public
header shouldn't depend on "reftable/system.h", which is an internal
implementation detail, we won't have the typedef for `z_stream` readily
available.

Prepare for this change by using `struct z_stream_s` throughout our code
base. In case zlib-ng is used we use a define to map from `z_stream_s`
to `zng_stream_s`.

Drop the pre-declaration of `struct z_stream` while at it. This struct
does not exist in the first place, and the declaration wasn't needed
because "reftable/block.h" already includes "reftable/basics.h" which
transitively includes "reftable/system.h" and thus "git-zlib.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/howto/recover-corrupted-object-harder.adoc | 4 ++--
 compat/zlib-compat.h                                     | 4 ++--
 git-zlib.h                                               | 2 +-
 reftable/block.h                                         | 6 ++----
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/howto/recover-corrupted-object-harder.adoc b/Documentation/howto/recover-corrupted-object-harder.adoc
index 5efb4fe81ff..86a1ba75cf9 100644
--- a/Documentation/howto/recover-corrupted-object-harder.adoc
+++ b/Documentation/howto/recover-corrupted-object-harder.adoc
@@ -125,7 +125,7 @@ static int try_zlib(unsigned char *buf, int len)
 {
 	/* make this absurdly large so we don't have to loop */
 	static unsigned char out[1024*1024];
-	z_stream z;
+	struct z_stream_s z;
 	int ret;
 
 	memset(&z, 0, sizeof(z));
@@ -278,7 +278,7 @@ int main(int argc, char **argv)
 	static unsigned char buf[25 * 1024 * 1024];
 	static unsigned char out[25 * 1024 * 1024];
 	int len;
-	z_stream z;
+	struct z_stream_s z;
 	int ret;
 
 	len = read(0, buf, sizeof(buf));
diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index 0c60e3af331..ac082766229 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -4,8 +4,8 @@
 #ifdef HAVE_ZLIB_NG
 # include <zlib-ng.h>
 
-# define z_stream zng_stream
-#define gz_header_s zng_gz_header_s
+# define z_stream_s zng_stream_s
+# define gz_header_s zng_gz_header_s
 
 # define crc32(crc, buf, len) zng_crc32(crc, buf, len)
 
diff --git a/git-zlib.h b/git-zlib.h
index 1e8d9aabcb4..0e66fefa8c9 100644
--- a/git-zlib.h
+++ b/git-zlib.h
@@ -4,7 +4,7 @@
 #include "compat/zlib-compat.h"
 
 typedef struct git_zstream {
-	z_stream z;
+	struct z_stream_s z;
 	unsigned long avail_in;
 	unsigned long avail_out;
 	unsigned long total_in;
diff --git a/reftable/block.h b/reftable/block.h
index 3957aee4293..422e2f872c5 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -18,7 +18,7 @@
  * allocation overhead.
  */
 struct block_writer {
-	z_stream *zstream;
+	struct z_stream_s *zstream;
 	unsigned char *compressed;
 	size_t compressed_cap;
 
@@ -62,8 +62,6 @@ int block_writer_finish(struct block_writer *w);
 /* clears out internally allocated block_writer members. */
 void block_writer_release(struct block_writer *bw);
 
-struct z_stream;
-
 /*
  * A block part of a reftable. Contains records as well as some metadata
  * describing them.
@@ -78,7 +76,7 @@ struct reftable_block {
 	uint32_t hash_size;
 
 	/* Uncompressed data for log entries. */
-	z_stream *zstream;
+	struct z_stream_s *zstream;
 	unsigned char *uncompressed_data;
 	size_t uncompressed_cap;
 

-- 
2.49.0.604.gff1f9ca942.dirty

