Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B092C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 09:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351406AbhLCJje (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhLCJjc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 04:39:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E4BC06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 01:36:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gt5so1922480pjb.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 01:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0fSyWvuSH1lEGO4/AwXmgO6qm/qkgZ+kkMxuH3kXWk=;
        b=ozEG5mT8CeLE6qBXD6lp1WR+yvVEBIhrR080b5bIA7MiStqnJIxNV13qAmJ8smsLOE
         YmdY6nKh7vyYqIqBXSHnUilS46PxOLsr0gxwT5ErpPtDUkEPXTsvx8w3YUEHp7AKdeT5
         vD5VMebvX56PHYPGsxPY46eRhxsFZlK1fgoVRa3g1jGA18ttEKMKxJ5ZIrXWEHdY/hTl
         spleTUyPMXjR2iiI1u0FXwDf167b3Z1LBZdi52TBJ6L3Ok/pcqZVpUSqT5z05IqAlurA
         Rck0FY6yxz1Y3EfCRypBc9oRtWf9J5OQOV6SNx/Gh8vV9xGDZ6Y11yZyI1FfPMhnZRrY
         M+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0fSyWvuSH1lEGO4/AwXmgO6qm/qkgZ+kkMxuH3kXWk=;
        b=NMZ25YxXho0G40QhckqKibpll7khfwfUxW3NNbXT4Fb7Ux7HWthD5VZTYkg1e9L5RM
         pOp1gTR7ci4HHImw1G4Yfcs059eAtOiOV34+GkzaPvcV/8MDOVDW4OaF22EMosdwZP0S
         tzytxOobVhn790PiE3wl6Foi7PnPmsrrXrj0xbmI/o+eTtHap6HYJL2TAB8cXzniW5sU
         tPUkltSoQxDpkK45JMFp2Fkix736CEBoDqAG6H+bDeFaYERAVFEF0OVXPqxA5hmwnxM7
         9UiAP50sRZ7/0Nu8ajDtHOQRhKt03peCg2rYu/TG/Z3AZ9UJ3wFKC6EE8d6ZlnPiUNTX
         RCHA==
X-Gm-Message-State: AOAM5316mmsGPVuADKpgqtpGknylfQFXW5thBVCZZNcgkzOtXjNHeQ7q
        /JOoyCN/WvuW5G+H8T13ZrY=
X-Google-Smtp-Source: ABdhPJxjg9wVGBj/d+p/RJbc5K+uKAnU9AI5UYcEYZKSTVO6dZ2GmbtsNB4brT94P+AIjTn8LDUFJg==
X-Received: by 2002:a17:902:b615:b0:143:bbf0:aad0 with SMTP id b21-20020a170902b61500b00143bbf0aad0mr21565873pls.12.1638524168141;
        Fri, 03 Dec 2021 01:36:08 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id g9sm2708142pfj.160.2021.12.03.01.36.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 01:36:07 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v4 1/5] object-file: refactor write_loose_object() to read buffer from stream
Date:   Fri,  3 Dec 2021 17:35:26 +0800
Message-Id: <20211203093530.93589-2-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122033220.32883-1-chiyutianyi@gmail.com>
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

We used to call "get_data()" in "unpack_non_delta_entry()" to read the
entire contents of a blob object, no matter how big it is. This
implementation may consume all the memory and cause OOM.

This can be improved by feeding data to "write_loose_object()" in a
stream. The input stream is implemented as an interface. In the first
step, we make a simple implementation, feeding the entire buffer in the
"stream" to "write_loose_object()" as a refactor.

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++----
 object-store.h |  6 ++++++
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index eb972cdccd..82656f7428 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1860,8 +1860,26 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
+struct simple_input_stream_data {
+	const void *buf;
+	unsigned long len;
+};
+
+static const void *feed_simple_input_stream(struct input_stream *in_stream, unsigned long *len)
+{
+	struct simple_input_stream_data *data = in_stream->data;
+
+	if (data->len == 0) {
+		*len = 0;
+		return NULL;
+	}
+	*len = data->len;
+	data->len = 0;
+	return data->buf;
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
-			      int hdrlen, const void *buf, unsigned long len,
+			      int hdrlen, struct input_stream *in_stream,
 			      time_t mtime, unsigned flags)
 {
 	int fd, ret;
@@ -1871,6 +1889,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	struct object_id parano_oid;
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
+	const void *buf;
+	unsigned long len;
 
 	loose_object_path(the_repository, &filename, oid);
 
@@ -1898,6 +1918,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
+	buf = in_stream->read(in_stream, &len);
 	stream.next_in = (void *)buf;
 	stream.avail_in = len;
 	do {
@@ -1960,6 +1981,14 @@ int write_object_file_flags(const void *buf, unsigned long len,
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
+	struct input_stream in_stream = {
+		.read = feed_simple_input_stream,
+		.data = (void *)&(struct simple_input_stream_data) {
+			.buf = buf,
+			.len = len,
+		},
+		.size = len,
+	};
 
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
@@ -1968,7 +1997,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
 				  &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
-	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
+	return write_loose_object(oid, hdr, hdrlen, &in_stream, 0, flags);
 }
 
 int hash_object_file_literally(const void *buf, unsigned long len,
@@ -1977,6 +2006,14 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 {
 	char *header;
 	int hdrlen, status = 0;
+	struct input_stream in_stream = {
+		.read = feed_simple_input_stream,
+		.data = (void *)&(struct simple_input_stream_data) {
+			.buf = buf,
+			.len = len,
+		},
+		.size = len,
+	};
 
 	/* type string, SP, %lu of the length plus NUL must fit this */
 	hdrlen = strlen(type) + MAX_HEADER_LEN;
@@ -1988,7 +2025,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 		goto cleanup;
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
-	status = write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
+	status = write_loose_object(oid, header, hdrlen, &in_stream, 0, 0);
 
 cleanup:
 	free(header);
@@ -2003,14 +2040,22 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 	int ret;
+	struct simple_input_stream_data data;
+	struct input_stream in_stream = {
+		.read = feed_simple_input_stream,
+		.data = &data,
+	};
 
 	if (has_loose_object(oid))
 		return 0;
 	buf = read_object(the_repository, oid, &type, &len);
+	in_stream.size = len;
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
+	data.buf = buf;
+	data.len = len;
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
-	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
+	ret = write_loose_object(oid, hdr, hdrlen, &in_stream, mtime, 0);
 	free(buf);
 
 	return ret;
diff --git a/object-store.h b/object-store.h
index 952efb6a4b..a84d891d60 100644
--- a/object-store.h
+++ b/object-store.h
@@ -34,6 +34,12 @@ struct object_directory {
 	char *path;
 };
 
+struct input_stream {
+	const void *(*read)(struct input_stream *, unsigned long *len);
+	void *data;
+	size_t size;
+};
+
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct object_directory *, 1, fspathhash, fspatheq)
 
-- 
2.34.0

