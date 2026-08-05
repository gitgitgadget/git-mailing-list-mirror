Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB503E63A2
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915918; cv=none; b=uQW7mtnYUqKzraFrK1qomoRcCkVkhda6ft8pj4FujRSe0Bb6dTZLC5ukmgAnwoWa0kR2VDvyZnKU9Zx/17nTzazBbzoZti3GTtkyO8VhTMLQSnTzQD9uFbWK9ACxWhV6Ad+DgcqI+cTukIoc0JIeK51TxwUs6j7mp1s2yruAIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915918; c=relaxed/simple;
	bh=nW3MdNaCabMs/N6ER1ITv+9qsS0HhIgET1eEi4LStzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItJvT+JD6ayOgkThR0AJng+RWVOz912qc6GCigAHwAkbdA+CF4Smkmd0TckUINuuvgRMUtvXieFGgIfxIY5AoFaUXBKYxJgr0qqZcN7JWcN0As7S9uh4OA0sU74q7I5aINiIZOqn0gbpdj5o7ZOkDjGidnzv6Bft9nNKpOI1b4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kqW+dGvB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QKVWJEYw; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kqW+dGvB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QKVWJEYw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 91119EC00E1;
	Wed,  5 Aug 2026 03:45:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Aug 2026 03:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785915915;
	 x=1786002315; bh=CYMs0b1DXufz2pFTpcqQACJQQtFFiN9DaYimwhR7NjU=; b=
	kqW+dGvBg329UFNBoOQxP4BuodaogZWmbCdr8xkoXG6/e7CaMYAwzHMHErADxRuW
	SngI9xwBXL2kISPA/hsP6V6TaSVf7CeooeP5vlW3n31kYq4jAfMKejtSAgQ2azG7
	Wu9pUDDz2PlUqzwQ1qF53hLC1sXt3bmwjzK5HT3bxBZ4nKcYOnj6k3J32MgnNF1j
	Oi8oNAk80nUCh3ur4fM5lco5P/x9Sqtm9xc60H026LmFzaqNnBgJ8I1IJ5pilmpc
	CfI62PQH6scTwaGYYij1ylqtznxgKdlOVVVVaHvvBLIlrIqas+qFDq1KA4/YYW1i
	bbfTJoCqwv6b8Bpw2O/34Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785915915; x=
	1786002315; bh=CYMs0b1DXufz2pFTpcqQACJQQtFFiN9DaYimwhR7NjU=; b=Q
	KVWJEYw/Q+Yd07NJhzb716q6MA+RPT3gRScukZ85L7PIRzhqfaMopZXN9oESX1ct
	8yDKOpFAAPSanoC1hULYBQPxRnRNcok+OdBh+g7e1w9262mYwiSIvzL5N2vIYSXP
	nQo65WfO5xUBDp5ultgzUItBCLnAwcCWHppRSSTKLetFYHtFGQ1K5ZMRJ2nWRaUu
	7Nzv3tDEAhrkpdpSdty8ULmYlFmc5AJEGnd7QW5o+NEwgrLwpbmDQUYJ7WpVOj2D
	zLyfBE6dlv334pSMUbv8CUW+M/Nrv07EwdepjZPSqZtmksU6k1fQyElp0ei/WCcM
	XzVPrE809ucd5A/y3LLxg==
X-ME-Sender: <xms:C-pyaiacIoVg0hWDSj0USFSgzXdBFgVBXO7Oaxl97s19b8KoJULvug>
    <xme:C-pyas2X4GCqcOxesymSaPEZ7lDgPSMiJrperUu6FstV9-wT0D_YpjVHRz5RQgSiD
    SPN9tWgdBWg7oFkndOBNTsy2X7PlaSEFdzB7acoKEBsso6QiGUd4g>
X-ME-Received: <xmr:C-pyaqXYfPPEV9YqlzBla0QhuHFhQZgOQASphjgjIGuYV_00E9e3nfk6HHkF58GOOj34T2zViJETkkXZBVe-fBlhc6aQycuiA7_PrqD6dA>
X-ME-Proxy-Cause: dmFkZTGpwBjScrTu4fzMswfblkaWle0RKtSKW3o/hrxgqB0YO/0yqzJ3WERA//z5p8kfYw
    YkvnNRBegMcT9Ka4VSDGuQQ90UMjIG2RtSPQKNKViVpoHWSw2xZtgxDrrgJ0Pz+aRvV1Bt
    5QcSCDB0nDMUWyJZBKxwPt/flW+k7rVqPl5vgOo+xEAJYPt/p25b72bDGMiWCDBsak0qOw
    gcf63DywJBZOqExrUc3Fi+5+tFMDl3Nw50F8ffQoOiPZGkCcEQXp9CIOy67nShTPU+sUbd
    yHsjFiqwhp6xs4ZK2MB2bN/rGADqB6Cy7C6QuLf4HjVWlbaVEYlrLPrbNREB/TbVR0MpG5
    FlYA1mJWfVqZyhVyYM07t/CSSGKJPasWESoe3+uzoaR6E+fghY2mnMmTfeheFmWQA5R4tl
    XaGg6HCYm2oZuywAjPZ1J9og1+EWIXHzgre8l1j4niwBAw1ZEcLYZw21rQ/dUQyQ7eNPB4
    QbneQFeSlDhVQ3H+X9LBDdkKenyPEiSMLkZXIDC/ImdfXYKj5AI/cL+lAD5owQHFjOCCkU
    ht/1Khdj36f/SO+7laUZ1NC8wGaDSgTaVBTcNB85brPA/A+ubLdHdLaCOxH/GY5Ur1oMqm
    3PHWDprbvgpYyx1LhNbqmnW1WnhVRYvX/N4+yJKUw52O4j54mYAp8SQegRdw
X-ME-Proxy: <xmx:C-pyauX_so1ZvGjDhXOpgupAMVuZA5jHo3Y01UbrGILpRQIdzqJALA>
    <xmx:C-pyahcunA47qquAjx4ZHCjT0PiRC_g13JQYZTe--dr2D1lF-WaLBw>
    <xmx:C-pyavXKrQOChi33_8uwaWtOxBvAJkfe64TRze0T1Mo7AcYEpGunDA>
    <xmx:C-pyaieSBrPi6otbSsCnKyaw8Vp6wezpAaVvYh2OAoLfg3ZaZ0J4PQ>
    <xmx:C-pyak0k4Oa23YH5Tjy85adw8lzrZCwoEb2rY6J5kWz12kEpZtdxi_bc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:45:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f85098d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 07:45:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 09:44:51 +0200
Subject: [PATCH v2 7/8] odb/streaming: rename `struct input_zstream_data`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-stream-unification-v2-7-b8c369564641@pks.im>
References: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

With the preceding refactorings the `struct input_zstream_data` is now
somewhat misnamed, as it doesn't only contain the data anymore, but also
the stream itself. Rename the structure to `struct zlib_stream` to
better match the new structure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/unpack-objects.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 05a2d48011..3392a3b87d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -358,16 +358,16 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 		write_object(nr, type, buf, size);
 }
 
-struct input_zstream_data {
+struct zlib_stream {
 	struct odb_stream base;
 	git_zstream *zstream;
 	int status;
 };
 
-static ssize_t feed_input_zstream(struct odb_stream *in_stream,
-				  char *buf, size_t buf_len)
+static ssize_t zlib_stream_read(struct odb_stream *in_stream,
+				char *buf, size_t buf_len)
 {
-	struct input_zstream_data *data = container_of(in_stream, struct input_zstream_data, base);
+	struct zlib_stream *data = container_of(in_stream, struct zlib_stream, base);
 	git_zstream *zstream = data->zstream;
 
 	if (data->status != Z_OK)
@@ -389,9 +389,9 @@ static ssize_t feed_input_zstream(struct odb_stream *in_stream,
 static void stream_blob(unsigned long size, unsigned nr)
 {
 	git_zstream zstream = { 0 };
-	struct input_zstream_data in_stream = {
+	struct zlib_stream in_stream = {
 		.base = {
-			.read = feed_input_zstream,
+			.read = zlib_stream_read,
 			.size = size,
 			.type = OBJ_BLOB,
 		},

-- 
2.55.0.679.g6767b8d81c.dirty

