Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4963E5ED6
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915914; cv=none; b=WVHUmELC3jVLDAQBxg99wjYjqtp59gVhWJT+KLYeE/D0in9biJc+YV18xCd7schXCZrS/ASNn7vUzsiWTU3aWgztx3t7wsvAKHlmq30zjuqlCbEP1TvhkT5pm6rUxi9cSqCeDPaIgzbRLzI41/91qakWPkB2R7Ax9qansDrcvq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915914; c=relaxed/simple;
	bh=k29Rkyj+l1m9HM/3DQzRvIexA+861H+yrpbPPJxzhPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoA8CPrGY2u4VIbIpRsN7c4CFc8syQxUyhAfZIShp3ZENnuRD5nMgfRdCPUiXtzQy6d1Fb0XFMtZlUO4EjdRCdaEFlxSsaj7LH75OoqoMBzvPQL4aZbdXL7rlwXqtzIk+IEdyGRdmSqVuw3s4aSF7Rl9J4LMMcZseLI8fLbG11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U4K04Vq5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQsz9YWB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U4K04Vq5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQsz9YWB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B9421400137;
	Wed,  5 Aug 2026 03:45:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 03:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785915912;
	 x=1786002312; bh=oh+KqGv6CE6O0VaQ4ut0oCRosBWJoh1sbk3ywal/KYg=; b=
	U4K04Vq5JikiMYG5Afvl+ynLJux6GhTEQiwHmTmrUr/l5o3A8a8xesQPjUaWbs0c
	nIY6eXN5s536AjOX8egmBocZCbz68/0Mf85DDLgefOXXNLASm7ggFIsPzHnte0EK
	r3o7We6GzQH6UCHsSBckm528Bxa07KRlhmaGnVpH1tjZTpcPKb3xCGEKZbYaAyfD
	7Tu0149yp0g6GkJWy0K29ueUjEiILW5mefL+1/+OEWSjEDYsljPxIuevNgtXpSsX
	tHKPPjbQNW8bSu61OqZ1UY88478pOrY0fRaZMsaVC4ZN94z0lIuWub00bw9xz/f7
	HKvD2ag5oEOc8VkN6sVMAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785915912; x=
	1786002312; bh=oh+KqGv6CE6O0VaQ4ut0oCRosBWJoh1sbk3ywal/KYg=; b=f
	Qsz9YWBUfSLFWYlPYlvfG8p597HsqosMHdkVzQubDW8KgLJTtDVByTZYKqr9I6SK
	sW2Cz4dgnM70CA18HEs5AMrW+L3MlPMJ9nEJJWOn0tcTF3n6t9DStblAfSzxOEj1
	flTg7Kpp7Grfc7HyRuMRFj6FGgg3A+W9qbX8NzCzZQgcsd6fG2L0ELzOwoyE11v2
	HO7k9yPQyR0F9ofJo0FnqZiij3nqPCvltU91xCDsjs8lGSUj/GEJ3EVUqhO2ZqoH
	Y4DZ946R7EAHulnY0UybvU0g/nahCZaOtdFx3IIoCEr8P6BrlhIRRfbmx0VjYLMw
	e1a93A6xCzQBG7gftqC/Q==
X-ME-Sender: <xms:COpyajK8NEZduuGjixMOsYVLj_QXJ6Mwzmxw2h2czkT8a91v1WMgIw>
    <xme:COpyaukEc9HYXu9HVEiXmmTubeqXBl401qANSBy6mg-KAW3vw0owUqC1HWXINlEoR
    fWB9oyekZncYqwn-waBco0PLUNQ890YFsUC8vktUMVT048gSHeUH2o>
X-ME-Received: <xmr:COpyapF1rE1TiDIyj6MgnIH_B42n7bv1pJf8LpDVRaC5mW492TUmMa766FEmA3XIjVKW2QRrm5CK0elpqZGX3fesXWb9HmZIJ3jquOOo5Q>
X-ME-Proxy-Cause: dmFkZTGbFAdPF9viVotmQAeejs2iFwYGaIE3Xvu7z2dOFSzpgzu+bJgUZWbJGfroDHLppw
    b2qQI/xK3lI9uqsKuOxDjzNZo+TCP7M0K+Ph7sizlC4tAmJrhNk8fNvKdkaCZsUmShp5GN
    5bfJSaSyQoCY7YPZBigA0vyOzA7y8zOK7vl7kjMapNQEYl1kwhUijEA9ur5nb7erw9/I6d
    MPahvSBJu/fcAWjMAYaeqkIX+4CUcox7IQClhReQnfdsxRh5VaWyrXYzboCISKvMLgLWF0
    ECH77MBkiZofsQvRAVlATkjC1kPlOtDX5vQHSUthS1YV1dYpE7uIkZ+V85StH4Co7hp2lz
    JHCE8i9ffTD8YzhbI78qcB+xs/i6z6+EwlKlYXXH7VTCvEMmX8FvovUmw4+vy6ooXsykeB
    187z8MXpt5QhvGaKMNqFmrxEo3r8WjuI28hB6iseGkVNzLQ5PSYQzA7xpC5zsNzsRAI8In
    gXgLzAkovprze5hyZleRpuOF1zOT40ZHRKAhHSW6KceFvQz0lZI+Kd03xtcbhzEqY+4z7b
    woXsNfghGNPrzitODDMFr5J+6JJoBQxDCQM5vIUAvE6jopm/iWr0sTeDEkWcWaFmxecmZP
    IWyGn21G7mAMYp9pHk57NCuFpwpcdqYbXTasg/fXt8/zgAUSROiswPmENVmA
X-ME-Proxy: <xmx:COpyamHYhAzjzrfx0tTJXkroQmNq_AdfwbTvq_k03y3lwK6CQZfkWA>
    <xmx:COpyauPCxLABD8t-OAc8MdIMO6cikALVUr7C_u26UNYHj-TjsPehJA>
    <xmx:COpyatFttJhlXIetBQPOQH-LlLAp-KjNdMXrQ-J8EZuBhUbNJ0_nXw>
    <xmx:COpyatOR-webNoJZLeNlibiEuRWB8XRa8dbNSPpp-trRyTUZ0j4LUQ>
    <xmx:COpyammMN4efVae4aY9OP01UiqK1R-CN0D-7jQHuT2YFuWPZdSTEqBrE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:45:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 40cc6d3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 07:45:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 09:44:50 +0200
Subject: [PATCH v2 6/8] odb/streaming: rename `struct read_object_fd_data`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-stream-unification-v2-6-b8c369564641@pks.im>
References: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

