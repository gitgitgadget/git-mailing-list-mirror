Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C87E764
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196370; cv=none; b=Qap7NljSxNZ7FxtYhV+hWyeqycD4F7sEBSSbOhtva/8NNYvPlTU65sM7UDcof1hZVrIKVrTuJQ3VGlibBXyMfHNEiQNcnlW3fZ20aHOTdFwuLQU5tXl4e3fukii4haq0XiZXESarlVdyeQFiyS/P282GL0hYnh80wgijjiFqW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196370; c=relaxed/simple;
	bh=MEYiwAN/ulo59GN6jIJNn05hE6VFyk9IQhxQU8/XIAo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V6eUS1NMA1GbICEDNK2I8W1TFEkxADZTtthFk6VTosS21HNEWShlJaslnAPLz6ZpRK9psILFPuLXDZ7O3ihrx0pdPfiGH8DY8J5fJsQ7YuSrbBjDgH98VrQkl64m22xipg9sIwn+BCaL3RGnlwVaq9wGdXdYkW8L/b3OXP8lRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFwkkXWm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFwkkXWm"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fe2d3d5cbso1667755e9.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196366; x=1707801166; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA0UYy8RBrNV+cHfrIRf8ezv4EVkB43oJyzX4fmFLIA=;
        b=DFwkkXWm+/GZaNrASEhYWIgTTCmkCXviZeeGlOTsggnLpepf0m5GqcJNADznFZifWp
         sd3VgfmE4kfz0RfOi7eh1/0S4WZgaog4QTd6G72p7KWiPeKdwZ87K1gsxYU34X3RBDDh
         DcJEQbyYvVvafRdvn1XaN35Cqf9j1TL2ZkA/sUnyo8NYWPifEs59RgvO0biJpHSnwDTw
         KAEHi6o8gYWsP8hFtiMgZVwyMG1umlEOEslzhEZPFbGLaUV0qo407hQgOsUrwpvjWg5S
         7sgr6QsqcfbCwHicz3RwEP/8GPx6wZd/rodveCqN2TEI0zSmEckKuMsmLbRom41InfDI
         ZWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196366; x=1707801166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA0UYy8RBrNV+cHfrIRf8ezv4EVkB43oJyzX4fmFLIA=;
        b=QJoPB3HMsMaXIzVl/6yqPCtMsRNLQie620N4xXrvwNrHBWZGyZfiA+JUFYGBjqp+B0
         LTi8vPxUl2iK3dp6rvNL7+8EGBLnR3qpjk3xR4exDzuytMUbgWTD+I7z5b78BxwTSeWg
         Zwx9eKBQcUz7c7+jNS8aqL47bL9D/BT9uf2as8do3/C5/KVouhPToBArAwRnS08h2NSq
         9/vTMc+nwlQ7J3rfCEfAyRaaHij53MNnUEebx4cfcP4wsAMsF0+oGhmJ7YyJE+Rfw4x0
         fZqZeD17MyW8+eX+ySGYfnbTai1MnbYFoq0d0UsnS3Ht9pKsn+D+fE1D9VYYyN1ilJeR
         vq6g==
X-Gm-Message-State: AOJu0YzflU7QkQML7C2pHbeIoycgjq+XgK19e+HDb52RjP6lcaLw6pe+
	e79fu+98Uev5I0AWq7GCACVlOLRJLrwdk3HetvLCeKWmx9QdKmoMXVQADGFC
X-Google-Smtp-Source: AGHT+IEQXhcR65PYy9Vz2XPpBmZ+KEa3NjDbS69giMEirMG5bvI0jwvOCqgaoUIHAX2v/jb1vOPy+w==
X-Received: by 2002:a05:600c:5109:b0:40e:ac4f:7156 with SMTP id o9-20020a05600c510900b0040eac4f7156mr1308169wms.5.1707196366618;
        Mon, 05 Feb 2024 21:12:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVaJQxhfDHKgxa/LspvwuOnl3bu8rfh80lyP7jVFJiEeOPMPA20IjPN8/I0LqJzxJB7Ml6pGuzyVmCVhY9rD/QfhHZEgbzsX5G4ny9dYr9n3qh9NaWZixWvwrwo/BfygdeZ/sqv/UFXXczTnzqACz7V6j+6+G9wZedK4FY4sTiO5/HgnOWipCOqLIFoUS1fJ8pvud5Mowlunw==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c378300b0040fd24653d4sm636290wmr.36.2024.02.05.21.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:45 -0800 (PST)
Message-ID: <6f17c022b15479191a1a965d762b6b8a956532e4.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:17 +0000
Subject: [PATCH v4 17/28] trailer: teach iterator about non-trailer lines
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

The next patch demonstrates the use of the iterator in sequencer.c as an
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
for non-trailer lines, making the comparison still work unmodified even
with this patch).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 12 +++++-------
 trailer.h |  8 ++++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/trailer.c b/trailer.c
index 4f3318802d1..2cc4a910411 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1147,17 +1147,15 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 
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

