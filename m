Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161C8F49
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710570434; cv=none; b=uEITZP4Hudh8SCqR81jI2iDkFBOmCViuh1B0wVsD7M/ymMYK+d83nJmOrKEEAv5IJ+0SYRcuCwSlguqnt2Sh/5aWe4Yg9T8onZbULBFuB4xeZiSmCpECSHgQ9uVc7T42yxIURcyImm91xtb45yPyAxqTqi4nfIBtLoGWd8kRdd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710570434; c=relaxed/simple;
	bh=80X67DI7aF5hrHdqSseuDB3it+OyxHl9Gy50onQDU8Q=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S8llW3iNUk/0WHCPWhJ6E69eJZkuNLttmLSHV0Qyk0FNkRHeV/Rb9MK42zSONduwSR2o9dpUt+57PsVF9CMyVqbK1aFI1Bj6kmWPO19wtkvwD14UVOm6pmULXj0Bg5z2D407S5Znwj+9KG2V+xhu0NCmvV8KCKocbqO5sstHAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUK9r4QR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUK9r4QR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-413ef770363so23862015e9.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710570430; x=1711175230; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKLrpgwqPaFMYDoMpIo/JUVy7Y0gCAs/fTuse1xiu6U=;
        b=HUK9r4QRaCMKv61gCq1F0km8s7mthPea4/sDP+uicnv6XtoBzGVua9Fr4md9IgRioM
         QgaBsaX50k3sUVTN0Vnm4On3VjDtDGotXlY0Pr2eYz6cvk5ay/bwJWq9JTX1+kLQhC8H
         9U1JTHyBRZz3/guc3Ww1Gcw+1gxpleaoZ3zNOW63/RlV03KU0c7jyr/GijSXBEitbrL7
         gK3SZhfKvK/C0AFMbCDnsJNS7gz43mN/1KKOfb7WoS/9L3a+lIOZeKqA4foh7bHJCxKs
         LhicP7D3DDaULLzP2FcUQtlFHEqcxwDQY1DwWoFzRNkIuHPYP8IPPu/qeXRRKiyP1hju
         Oqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710570430; x=1711175230;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKLrpgwqPaFMYDoMpIo/JUVy7Y0gCAs/fTuse1xiu6U=;
        b=R2xGs5btfzNJsWuTlaQt2JTNKcSkqD5bLY68n5HB790so2Aqdj3blgXte3eI0qy9QK
         EBv0KasJemvQns9oDxq/XW3GN2MoKQcYGLEKl/KtBDMf8sPkPkD9b/rZfQgsMmQU5wDh
         N6VoQDjuZUmSPn6FmjJt3oC9ZK+ZHOrXq/KPZMzkgvL8EMkU5ETBkwEj1wLb1W4oL2wx
         bKJRXCEsNBMcXVbUtwbVapcoDn3105pfceAGKzb8orVy2Tbm/cxVbysSn5VJ7iNTXs78
         9KLLztSrZe27ZSD3mH1Z23HAIQQnKwOkMrs/Z9CL5fU3BM+cvU2a2MRN1AM38ZlolrKp
         H6Yw==
X-Gm-Message-State: AOJu0Yxbdba2fop78DabS6XXqnVbDTT/zgYjBk57kMIT9bC2smn+oc4m
	o3pz3+5/DCiMDIBomQzN4VHuAPEz0eex6dUCa3jHXlEAGV9y+jKp5OLfXNWu
X-Google-Smtp-Source: AGHT+IHucGmsuXDuykohiAuKNmryihn5FMW2dvaHaUHXlRSnceGdR4oHwadHbnrGMPIGWw8euYlErg==
X-Received: by 2002:a05:600c:3556:b0:412:beee:36b3 with SMTP id i22-20020a05600c355600b00412beee36b3mr1102601wmq.7.1710570429898;
        Fri, 15 Mar 2024 23:27:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c350200b00413177c3f1dsm7741904wmq.18.2024.03.15.23.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 23:27:09 -0700 (PDT)
Message-ID: <32ad0397737375b826d8af893e14a04628e9e803.1710570428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 06:27:03 +0000
Subject: [PATCH 1/6] trailer: teach iterator about non-trailer lines
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Previously the iterator did not iterate over non-trailer lines. This was
somewhat unfortunate, because trailer blocks could have non-trailer
lines in them since 146245063e (trailer: allow non-trailers in trailer
block, 2016-10-21), which was before the iterator was created in
f0939a0eb1 (trailer: add interface for iterating over commit trailers,
2020-09-27).

So if trailer API users wanted to iterate over all lines in a trailer
block (including non-trailer lines), they could not use the iterator and
were forced to use the lower-level trailer_info struct directly (which
provides a raw string array that includes all lines in the trailer
block).

Change the iterator's behavior so that we also iterate over non-trailer
lines, instead of skipping over them. The new "raw" member of the
iterator allows API users to access previously inaccessible non-trailer
lines. Reword the variable "trailer" to just "line" because this
variable can now hold both trailer lines _and_ non-trailer lines.

The new "raw" member is important because anyone currently not using the
iterator is using trailer_info's raw string array directly to access
lines to check what the combined key + value looks like. If we didn't
provide a "raw" member here, iterator users would have to re-construct
the unparsed line by concatenating the key and value back together again
--- which places an undue burden for iterator users.

The next commit demonstrates the use of the iterator in sequencer.c as an
example of where "raw" will be useful, so that it can start using the
iterator.

For the existing use of the iterator in builtin/shortlog.c, we don't
have to change the code there because that code does

    trailer_iterator_init(&iter, body);
    while (trailer_iterator_advance(&iter)) {
        const char *value = iter.val.buf;

        if (!string_list_has_string(&log->trailers, iter.key.buf))
            continue;

        ...

and the

        if (!string_list_has_string(&log->trailers, iter.key.buf))

condition already skips over non-trailer lines (iter.key.buf is empty
for non-trailer lines, making the comparison still work even with this
commit).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 12 +++++-------
 trailer.h |  8 ++++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3e4dab9c065..4700c441442 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1146,17 +1146,15 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 
 int trailer_iterator_advance(struct trailer_iterator *iter)
 {
-	while (iter->internal.cur < iter->internal.info.trailer_nr) {
-		char *trailer = iter->internal.info.trailers[iter->internal.cur++];
-		int separator_pos = find_separator(trailer, separators);
-
-		if (separator_pos < 1)
-			continue; /* not a real trailer */
+	if (iter->internal.cur < iter->internal.info.trailer_nr) {
+		char *line = iter->internal.info.trailers[iter->internal.cur++];
+		int separator_pos = find_separator(line, separators);
 
+		iter->raw = line;
 		strbuf_reset(&iter->key);
 		strbuf_reset(&iter->val);
 		parse_trailer(&iter->key, &iter->val, NULL,
-			      trailer, separator_pos);
+			      line, separator_pos);
 		/* Always unfold values during iteration. */
 		unfold_value(&iter->val);
 		return 1;
diff --git a/trailer.h b/trailer.h
index 9f42aa75994..ebafa3657e4 100644
--- a/trailer.h
+++ b/trailer.h
@@ -125,6 +125,14 @@ void format_trailers_from_commit(const struct process_trailer_options *,
  *   trailer_iterator_release(&iter);
  */
 struct trailer_iterator {
+	/*
+	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
+	 * key/val pair as part of a trailer block. A trailer block can be
+	 * either 100% trailer lines, or mixed in with non-trailer lines (in
+	 * which case at least 25% must be trailer lines).
+	 */
+	const char *raw;
+
 	struct strbuf key;
 	struct strbuf val;
 
-- 
gitgitgadget

