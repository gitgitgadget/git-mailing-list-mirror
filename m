Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B401D2F55
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053843; cv=none; b=FNk4Rz6nPGN7vnd/za8efHMmFAva1Qhm75LoI81bgRcxYnOFSacJb9gqZtJ6Bg1NHo/gRQa/lpN2DaAe7SPZAd1pOfhu78N7qyIHq27xdEu5dkmEFFr3lOrHf5z/IGI83NB1U39tiaU4RrjwSt26IG4+C7Y39jJdqKU6eAG5egw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053843; c=relaxed/simple;
	bh=xXQI9bPHsibh5ykQnN60/A3w+NBdwwJOXWG7VeDMykc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF0WWUVzjcTZ8Jkv6VXDFbYGwx8ZrAcPOfts84kzQTveYmsapPrkpP1QmnpUavQfH35fUB19d605QZWlXWa4KxGm6jETc0J0PYMgn+f8g5o2Jis7vIdNZmJrT6RuoUISbzRqLzp4ippEkaJoq7APRX9rlnJID/TzOZ59iF1MvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ERY1uU/g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZapj/M2; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ERY1uU/g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZapj/M2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 20E8C114018F;
	Fri,  8 Nov 2024 03:17:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 08 Nov 2024 03:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731053839; x=1731140239; bh=lCagS+XSQk
	2olLCjdqrFbHG/vyMcZD3FjknPNbXrnzA=; b=ERY1uU/g0W1T6o7FqjXifliIH3
	dTCFF18095UViazSCUVnNlbbITgso8/xWO3j+7iqABDKBO5miC6XrGzkdZwfWUac
	PiECLJ5McrsTXkoGM4PyR1Kb8ZHRPWI8kr7MHgnZDdkpdIOhVtJshfAKaUgpjg+m
	e+XzND11GqY4/WA4zYsQAcBBbPzTFYHvpU9uvfkVuTlCp/qXhO3sRXODDbydw/Tr
	JBbWAbn13EW61o2yzY9OKMET267QshETOOXAoZshAlImPSzNxe55q3pU9VwSw7/r
	YVQyA9YVAwl7r2xrjVlrTjhPZ/zTWvBEj0xwu4LfRGxvcMb3iIozG7YsaR1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731053839; x=1731140239; bh=lCagS+XSQk2olLCjdqrFbHG/vyMcZD3Fjkn
	PNbXrnzA=; b=UZapj/M2t6C9e+tFSanAwz1L21nLJ8LDFVE9fOoM/PivOxz5i6N
	sPhH/9R4K6ocXlDvVqU64RgnlVBcwouIj1BPspRsec61NYY8Q5706TPW5wLbTRkm
	fl8/96AiITmzaVRMP3QkpKgJQtvL+YtuS5AcRsZ9+7Emxh8OjX4kOE6yvE3CNFPe
	JWh2/SgrXYxb1vEo/QH4EUvdIKt2Glm/1DNDuzUyJBAlXaxj+EmQWA7bi8INUI6g
	cywKlbRrMC3pEmDzpPmmSR6UmIUbIPIE2I1MWezh63CFJmIBdZ0eNiUo6aJf1NBV
	yV9TeHME74aFejmb3vPc/k8z+x3fR70gsjw==
X-ME-Sender: <xms:D8ktZ8Pa0LkLFLWPLeR4jdkjC8INXMSJ5WTDIqGBU5aew5_Qvi4meA>
    <xme:D8ktZy9zMtA_VnCoeW9LbCJ4I5A7W2PyJS6cqEa307kJ9ddXVn0ifxJROWa7n-MBq
    rw1sSdb_DrLG55_QA>
X-ME-Received: <xmr:D8ktZzSdq-EzDy4rDWZJpWvCMZHHRj_hjP7tcNyHPQGLEKKLAOOUY63mos-uafSbjcrWdsBdSpxwHQr1KGWDRLnRZVGW4Vdkrm53qDLDjkQJ-R4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:D8ktZ0sTIo5jyQ6ePEM_puYglrLyiZjD4l9xIunNGEIIxwaPfzTHFw>
    <xmx:D8ktZ0ddPzFGo0sdT7M2BPLw2AhGzHdItVb2iA0wDbAJgHQjBM-thw>
    <xmx:D8ktZ40dI_aPGMvqwTBn9Fu1wYQmxUxKJbRAfDP7nWz4UtPzQZCfKg>
    <xmx:D8ktZ4_UGVCwH5Xme-6ECWXRf8WalxlqEMLme9ITJXzQ3wNoe8totg>
    <xmx:D8ktZz7G9TwZ2N30wyoXxHDGHIS0E_0szn0ceg2rpixWxcXLseUrLWRH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:17:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c9c3d64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 08:16:51 +0000 (UTC)
Date: Fri, 8 Nov 2024 09:17:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/7] reftable: explicitly handle hash format IDs
Message-ID: <38cfe85bf5b82c70848e4b295ba6cae33dcfd667.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731047193.git.ps@pks.im>

The hash format IDs are used for two different things across the
reftable codebase:

  - They are used as a 32 bit unsigned integer when reading and writing
    the header in order to identify the hash function.

  - They are used internally to identify which hash function is in use.

When one only considers the second usecase one might think that one can
easily change the representation of those hash IDs. But because those
IDs end up in the reftable header and footer on disk it is important
that those never change.

Create separate constants `REFTABLE_FORMAT_ID_*` and use them in
contexts where we read or write reftable headers. This serves multiple
purposes:

  - It allows us to more easily discern cases where we actually use
    those constants for the on-disk format.

  - It detangles us from the same constants that are defined in
    libgit.a, which is another required step to convert the reftable
    library to become standalone.

  - It makes the next step easier where we stop using `GIT_*_FORMAT_ID`
    constants in favor of a custom enum.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h |  8 ++++++++
 reftable/reader.c | 10 ++++++----
 reftable/writer.c | 16 +++++++++++++++-
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 7aa46d7c30d..bcab0b529b0 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -150,4 +150,12 @@ int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
 
 int hash_size(uint32_t id);
 
+/*
+ * Format IDs that identify the hash function used by a reftable. Note that
+ * these constants end up on disk and thus mustn't change. The format IDs are
+ * "sha1" and "s256" in big endian, respectively.
+ */
+#define REFTABLE_FORMAT_ID_SHA1   ((uint32_t) 0x73686131)
+#define REFTABLE_FORMAT_ID_SHA256 ((uint32_t) 0x73323536)
+
 #endif
diff --git a/reftable/reader.c b/reftable/reader.c
index 90dc950b577..64eb6938efe 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -109,16 +109,18 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 	if (r->version == 1) {
 		r->hash_id = GIT_SHA1_FORMAT_ID;
 	} else {
-		r->hash_id = get_be32(f);
-		switch (r->hash_id) {
-		case GIT_SHA1_FORMAT_ID:
+		switch (get_be32(f)) {
+		case REFTABLE_FORMAT_ID_SHA1:
+			r->hash_id = GIT_SHA1_FORMAT_ID;
 			break;
-		case GIT_SHA256_FORMAT_ID:
+		case REFTABLE_FORMAT_ID_SHA256:
+			r->hash_id = GIT_SHA256_FORMAT_ID;
 			break;
 		default:
 			err = REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
+
 		f += 4;
 	}
 
diff --git a/reftable/writer.c b/reftable/writer.c
index fd136794d5a..9aa45de6340 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -103,8 +103,22 @@ static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
 	put_be64(dest + 8, w->min_update_index);
 	put_be64(dest + 16, w->max_update_index);
 	if (writer_version(w) == 2) {
-		put_be32(dest + 24, w->opts.hash_id);
+		uint32_t hash_id;
+
+		switch (w->opts.hash_id) {
+		case GIT_SHA1_FORMAT_ID:
+			hash_id = REFTABLE_FORMAT_ID_SHA1;
+			break;
+		case GIT_SHA256_FORMAT_ID:
+			hash_id = REFTABLE_FORMAT_ID_SHA256;
+			break;
+		default:
+			return -1;
+		}
+
+		put_be32(dest + 24, hash_id);
 	}
+
 	return header_size(writer_version(w));
 }
 
-- 
2.47.0.229.g8f8d6eee53.dirty

