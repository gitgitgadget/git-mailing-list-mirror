Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312E4192FC
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828365; cv=none; b=TApJ3pi1E+oN9OXWGlAAdkYTcE7Afdf2Qxu2KRKi3afnBJOQHsU2PQBy8HY/THrJeGL6a7XE+jFRLxzWDOTBGZpO96cA1pQet3Fn0J7d38JfM/Q3lrEW5hJ+F0JIK77rWbCeo+uLFHY397f0sQm0ae18VlrnMWG38FtSZbY4WrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828365; c=relaxed/simple;
	bh=k29Rkyj+l1m9HM/3DQzRvIexA+861H+yrpbPPJxzhPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6GXMXqJm0SBe15mPNV7JyohZvCLgMP9xduOBC5n5XxvSRQM4RtvYBW05Tg2Ce5cwpYM4czqpCgd/EnU+dN9vUtd22pTDPhXBwDn2sxUgokbSFH7wDiJrfYMK6hDcVUjojAG2VaAKtAyuaj8OghRNAjIs9U4ZEX3whHecC4Pjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IBMzNU/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bH4wuqf6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IBMzNU/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bH4wuqf6"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DADC17A0148
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 03:26:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 04 Aug 2026 03:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785828363;
	 x=1785914763; bh=oh+KqGv6CE6O0VaQ4ut0oCRosBWJoh1sbk3ywal/KYg=; b=
	IBMzNU/H8ze4dhvsM/eu+3PewODkbOqVI7evUO8cY0+YER7/sUKw4LsvhGC8/lyC
	yX37tpCrUajySRMLb62z9EbzheLBsBDgDFRkCJI3lpOzow1TjVLyMj5daLHidqvX
	YYhdl6lUWliyWsLNO98X+Da6BB7/6qc8a876xqTFw7AKSEGEi1r49z7HCpG415V/
	XtOy8mmpKi/QfkIkKHD/JFKqfNcjyqzShNjAd0u94Ekyboiv/HrzG6tTJb0AyG3c
	PzH8RpxgTkhLj/Pp0J++ARaR5R6rJuFBYR/MSAsKO5fZaYB9m/vfUk0Y7oQVd8am
	A+Xza2BOyjGrvsYwSyb19A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785828363; x=
	1785914763; bh=oh+KqGv6CE6O0VaQ4ut0oCRosBWJoh1sbk3ywal/KYg=; b=b
	H4wuqf6shCQwGWbe7FJyX1Jtw7UGfXFwRvR/OkszClitedXCnYIif2G/cUhPtkxE
	AMX2LFXMP4b6P1hh3lICPnOXMW7uC8HxnDEfLn4LrUUUPQQnYzoJTFFDy0fvC1ek
	5LeL1kXTqdq/JZKkvreAPTZnltsm9INkUkUwLyEtFjeDuun7YMUxgTfmY0z9ETrf
	Y9w3ocrDAJoLU3sskTBwjlaDBi5efEDgIXdHFG0trrDQdTJZHQ7+y489c9D4ZZbU
	Sa55fZabropidUwhOrq8kcriYdpALF5JYXi99C6ih0+547n9Y3On71eO+Gb/gEa3
	1JIW1nVnWg5CnLbIWOu/g==
X-ME-Sender: <xms:C5Rxauy6Un9XcV_YrzJmlt8hD0Z3LNf-18hWl-Jdl6gd2YO9jFYwUg>
    <xme:C5RxahOzWSquoxGPPmbE0dgoDrAHlmOO7ny4NL9L1jAFzLbBSyuwd0N4029Jh4DGI
    VjZoF1D3tbgTFiOgZZRJXkeAdDnfoYV2G25DkyJbLLL3dzgPop6X8g>
X-ME-Received: <xmr:C5Rxal-8uqrM5AVudBBZTVdhVrgr65hDBpTZqePCKoLr5GiVr_HZzDoiqMSPyAbh4Xk0PPiBd_q968HBpbzwNSi5BPdhZPwPzE6f8W5F>
X-ME-Proxy-Cause: dmFkZTEgfwCPY+YczcdG3bBGhuMkCaaLpOwwAurkDQmNqkrgqEETLIWAXDEa07U3w75fN6
    z+4KZvgbkM5CllzxTBahXGbAFjAFRK3ZOya1oQGONljUHkJ2e4MZ0DPiMsp7kZmB7l4L+L
    f/bW8uMbD8VJej61IJAWw/S+cx1uE7gG60h927kj1n5GDTH5hTXqFFeAumRJW/4TLnfS4U
    0/qFdMKxwG3PQcNT/io2LPR+vZvqX8SHuITvKPub/EdMvYZvATlXD9KofpjlirE/sUnZav
    g2q/dhEw0XQpM4uUmUsE0sbfUhUhwzhPJ0ACpmJdBl+XTH5z/fwe+M1e9JqAnD7kpuVUT/
    ZvaSQJjVj1lZU0B0pe6USAJBKTfhsUYLLc0J4gHS2h1Uoru9zkI5KoqQ+8dzfeQNrgn60j
    wX9205lGTkCF7XCv81g7x1O+ItE0zmJZs8Qzgaw8pvaz/f06okPMFiLdzSHy3K1nRYoS4+
    9EsMmCWQdVgE5TBoQ/PCsqx+BocCsr7j8BSjNyZJWDoh0CoCziC5tPJ4vZSFIT5oWSqqwx
    SMbxrnAA+LwXlig0gcbuGwSL1Y2YERgwGGgHklEikoz8VpfsmZ2J/LlKes4xJqJVEJhcua
    vRtg6Q949h4OoUI4h1Wq9n3HyJ2s8+8uyOp3m3wgqoBHjNvPlUomzC3CEUhA
X-ME-Proxy: <xmx:C5RxapoPyejgP1XmoI-HS1EW2pav037PlhyY91-rEG81MEvH0F0d5w>
    <xmx:C5Rxav71vFCIrcKF8wVAKVbFcsRQ1WFuGGdDIm6khDPtYIXttPbG0A>
    <xmx:C5RxahPeSfFAY7sjwZUjx-aQ2h2BljWm-3e2cLiJLp5qJR_fbgRp0g>
    <xmx:C5RxapOpe1yLKwGTyE9IHYE1MLDQw0tJz6XcSJtJ7q0TagwQAiXOZw>
    <xmx:C5Rxaox56OA-lXVTgJcVDiYJnEMkz6xJ9n8eWNsrzMoMI-nv1hY5yScC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 4 Aug 2026 03:26:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8d4be2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 4 Aug 2026 07:26:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Aug 2026 09:25:34 +0200
Subject: [PATCH 6/7] odb/streaming: rename `struct read_object_fd_data`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pks-odb-stream-unification-v1-6-86d70e82345e@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
In-Reply-To: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

With the preceding refactorings the `struct read_object_fd_data` is now
somewhat misnamed, as it doesn't only contain the data anymore, but also
the stream itself. Rename the structure to `struct fd_stream` to better
match the new structure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/streaming.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/odb/streaming.c b/odb/streaming.c
index 1a267e6b90..c436b18d39 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -288,33 +288,33 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 	return result;
 }
 
-struct read_object_fd_data {
+struct fd_stream {
 	struct odb_stream base;
 	int fd;
 	size_t remaining;
 };
 
-static ssize_t read_object_fd(struct odb_stream *stream,
+static ssize_t fd_stream_read(struct odb_stream *stream,
 			      char *buf, size_t len)
 {
-	struct read_object_fd_data *data = container_of(stream, struct read_object_fd_data, base);
+	struct fd_stream *fds = container_of(stream, struct fd_stream, base);
 	ssize_t read_result;
 	size_t count;
 
-	if (!data->remaining)
+	if (!fds->remaining)
 		return 0;
 
-	count = data->remaining < len ? data->remaining : len;
-	read_result = read_in_full(data->fd, buf, count);
+	count = fds->remaining < len ? fds->remaining : len;
+	read_result = read_in_full(fds->fd, buf, count);
 	if (read_result < 0 || (size_t)read_result != count)
 		return -1;
 
-	data->remaining -= count;
+	fds->remaining -= count;
 
 	return read_result;
 }
 
-static int close_object_fd(struct odb_stream *stream UNUSED)
+static int fd_stream_close(struct odb_stream *stream UNUSED)
 {
 	/* The file descriptor is owned by the caller for now. */
 	return 0;
@@ -322,15 +322,15 @@ static int close_object_fd(struct odb_stream *stream UNUSED)
 
 struct odb_stream *odb_write_stream_from_fd(int fd, size_t size, enum object_type type)
 {
-	struct read_object_fd_data *data;
+	struct fd_stream *fds;
 
-	CALLOC_ARRAY(data, 1);
-	data->base.read = read_object_fd;
-	data->base.close = close_object_fd;
-	data->base.size = size;
-	data->base.type = type;
-	data->fd = fd;
-	data->remaining = size;
+	CALLOC_ARRAY(fds, 1);
+	fds->base.read = fd_stream_read;
+	fds->base.close = fd_stream_close;
+	fds->base.size = size;
+	fds->base.type = type;
+	fds->fd = fd;
+	fds->remaining = size;
 
-	return &data->base;
+	return &fds->base;
 }

-- 
2.55.0.679.g6767b8d81c.dirty

