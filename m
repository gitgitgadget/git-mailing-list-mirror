Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA68BC54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiISRsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiISRru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:47:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFA242AE2
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:47:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z6so347394wrq.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=IVExRzoVYUYDA3I88XpF4NcetiQyv1HYI6hq8PFQsIA=;
        b=B07esSkBWPnFx9cP5mkf/PdgKm5if0rI039hJpIwOijd7ibqLOrQYs1pIazeoLN7sg
         pMFWSputwCWf/TSVQlP5HLR2UHFfr/b5Z7+HyzeeDFDXiDyj6n+gaoE3dufbcyQ4mFDr
         PBODP8PeTfM8jHGg4QKkwGxAqLevdlcROIDu+XWrrgwFJKeMUsodTwbQr7/lvtp5eEA3
         fIRWXX/8tDs9etEC0JiC1UF4icvAOpcHCabj1ZlzxUxGvXKrAAqQtilCm2oAG1QAi1IO
         CVzyXNIAnTCTLsa5C38ULqLUzLImmivqhhs1E1swv7aQcZqJTign/bEDrTbdTU52fNR7
         o0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IVExRzoVYUYDA3I88XpF4NcetiQyv1HYI6hq8PFQsIA=;
        b=LTRWpE2tgzFLapDGUXiG+SisqQ9jpLvkfEjDDMIDk10tA0F+n3ttMVQnVFv/xc7YD9
         KScVY8Ca4fmcZA8jyZnI35wEU+JMcP7s+N/QKQGdbwlVL5N7WNcOsbT33gzhVoT9tQjC
         W363Ra9udpkeOniVjxctiTHk6hWT66Q9000VN+J/ApSyuuw02OlvbHPmH6MWIrmuLQRa
         QdyWh8UzUxWJkqJg7ZIg1lkXvHSzkb0GMCSoV+NIR9aGgtaohAaKcOH6+kZnjkZYLidO
         OOSNUenMZjz2mqYSJTjnDbbpQzqL4ftM6YdxFDE23Y5uN+4Wpha9dcLxMPtEx0Pkyt/e
         TwaA==
X-Gm-Message-State: ACrzQf2/lsU5kb0lFnefdPNtvnC3dgnRDWFzYINZA5t69GYtUBomFFDJ
        OB3AltDGMQAy1DEO02U2lkfgD+ljts4=
X-Google-Smtp-Source: AMsMyM4O9gjGra81ELgPM2VE2gCizLPqlJtJEW2HyZAYzhANUNH/KD1Q3o+HFNX8xe77NlrB3GCT5A==
X-Received: by 2002:adf:eb89:0:b0:22a:c7fc:27c8 with SMTP id t9-20020adfeb89000000b0022ac7fc27c8mr11723541wrn.397.1663609664656;
        Mon, 19 Sep 2022 10:47:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020adff751000000b0022afe4fb459sm4301772wrp.51.2022.09.19.10.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:47:44 -0700 (PDT)
Message-Id: <38ec2360f4fbfe65fa2d9f1e9cfb7d4944d1714f.1663609659.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 17:47:36 +0000
Subject: [PATCH 2/5] roaring.[ch]: apply Git specific changes to the roaring
 API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Though the Roaring library is introduced in previous commit, the library
cannot be used as is. One reason is that the library doesn't support Big
endian machines. Besides, Git specific file related functions does use
`hashwrite()` (or similar). So there is a need to modify the library.

Implement and modify new functions so that Git can actually use the
library.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 roaring/roaring.c | 565 ++++++++++++++++++++++++++++++++++++++++++++--
 roaring/roaring.h |  17 ++
 2 files changed, 562 insertions(+), 20 deletions(-)

diff --git a/roaring/roaring.c b/roaring/roaring.c
index df2d90544cd..ee44de20996 100644
--- a/roaring/roaring.c
+++ b/roaring/roaring.c
@@ -1791,6 +1791,10 @@ bool array_container_iterate64(const array_container_t *cont, uint32_t base,
  *
  */
 int32_t array_container_write(const array_container_t *container, char *buf);
+
+int array_container_network_write(const array_container_t *container,
+				  int (*write_fn) (void *, const void *, size_t),
+				  void *data);
 /**
  * Reads the instance from buf, outputs how many bytes were read.
  * This is meant to be byte-by-byte compatible with the Java and Go versions of
@@ -1801,6 +1805,9 @@ int32_t array_container_write(const array_container_t *container, char *buf);
 int32_t array_container_read(int32_t cardinality, array_container_t *container,
                              const char *buf);
 
+int32_t array_container_network_read(int32_t cardinality, array_container_t *container,
+                        	     const char *buf);
+
 /**
  * Return the serialized size in bytes of a container (see
  * bitset_container_write)
@@ -2506,6 +2513,10 @@ bool bitset_container_iterate64(const bitset_container_t *cont, uint32_t base,
  */
 int32_t bitset_container_write(const bitset_container_t *container, char *buf);
 
+int bitset_container_network_write(const bitset_container_t *container,
+				   int (*write_fn) (void *, const void *, size_t),
+				   void *data);
+
 /**
  * Reads the instance from buf, outputs how many bytes were read.
  * This is meant to be byte-by-byte compatible with the Java and Go versions of
@@ -2515,6 +2526,9 @@ int32_t bitset_container_write(const bitset_container_t *container, char *buf);
  */
 int32_t bitset_container_read(int32_t cardinality,
                               bitset_container_t *container, const char *buf);
+
+int32_t bitset_container_network_read(int32_t cardinality, bitset_container_t *container,
+				      const char *buf);
 /**
  * Return the serialized size in bytes of a container (see
  * bitset_container_write).
@@ -3029,6 +3043,10 @@ bool run_container_iterate64(const run_container_t *cont, uint32_t base,
  */
 int32_t run_container_write(const run_container_t *container, char *buf);
 
+int run_container_network_write(const run_container_t *container,
+				int (*write_fn) (void *, const void*, size_t),
+				void *data);
+
 /**
  * Reads the instance from buf, outputs how many bytes were read.
  * This is meant to be byte-by-byte compatible with the Java and Go versions of
@@ -3041,6 +3059,9 @@ int32_t run_container_write(const run_container_t *container, char *buf);
 int32_t run_container_read(int32_t cardinality, run_container_t *container,
                            const char *buf);
 
+int32_t run_container_network_read(int32_t cardinality, run_container_t *container,
+                        	   const char *buf);
+
 /**
  * Return the serialized size in bytes of a container (see run_container_write).
  * This is meant to be compatible with the Java and Go versions of Roaring.
@@ -4513,6 +4534,24 @@ static inline int32_t container_write(
     return 0;  // unreached
 }
 
+static int container_network_write(const container_t *c, uint8_t typecode,
+				   int (*write_fn) (void *, const void *, size_t),
+				   void *data)
+{
+	c = container_unwrap_shared(c, &typecode);
+	switch (typecode) {
+		case BITSET_CONTAINER_TYPE:
+			return bitset_container_network_write(const_CAST_bitset(c), write_fn, data);
+		case ARRAY_CONTAINER_TYPE:
+			return array_container_network_write(const_CAST_array(c), write_fn, data);
+		case RUN_CONTAINER_TYPE:
+			return run_container_network_write(const_CAST_run(c), write_fn, data);
+	}
+	assert(false);
+	__builtin_unreachable();
+	return 0;
+}
+
 /**
  * Get the container size in bytes under portable serialization (see
  * container_write), requires a
@@ -6609,6 +6648,7 @@ static inline container_t *container_remove_range(
 #include <assert.h>
 #include <stdbool.h>
 #include <stdint.h>
+#include <arpa/inet.h>
 
 
 #ifdef __cplusplus
@@ -6811,6 +6851,10 @@ bool ra_range_uint32_array(const roaring_array_t *ra, size_t offset, size_t limi
  */
 size_t ra_portable_serialize(const roaring_array_t *ra, char *buf);
 
+int ra_portable_network_serialize(const roaring_array_t *ra,
+				  int (*write_fn) (void *, const void *, size_t),
+				  void *data);
+
 /**
  * read a bitmap from a serialized version. This is meant to be compatible
  * with the Java and Go versions.
@@ -7421,15 +7465,6 @@ void ra_append_range(roaring_array_t *ra, roaring_array_t *sa,
     }
 }
 
-container_t *ra_get_container(
-    roaring_array_t *ra, uint16_t x, uint8_t *typecode
-){
-    int i = binarySearch(ra->keys, (int32_t)ra->size, x);
-    if (i < 0) return NULL;
-    *typecode = ra->typecodes[i];
-    return ra->containers[i];
-}
-
 extern inline container_t *ra_get_container_at_index(
     const roaring_array_t *ra, uint16_t i,
     uint8_t *typecode);
@@ -7670,6 +7705,18 @@ uint32_t ra_portable_header_size(const roaring_array_t *ra) {
     }
 }
 
+static uint32_t ra_portable_network_header_size(const roaring_array_t *ra)
+{
+	if (ra_has_run_container(ra)) {
+		if (ra->size < NO_OFFSET_THRESHOLD) // for small bitmaps, we omit the offsets
+			return 4 + (ra->size + 7) / 8 + 4 * ra->size;
+
+		return 4 + (ra->size + 7) / 8 + 8 * ra->size;
+	} else {
+		return 4 + 8 * ra->size;
+	}
+}
+
 size_t ra_portable_size_in_bytes(const roaring_array_t *ra) {
     size_t count = ra_portable_header_size(ra);
 
@@ -7679,6 +7726,15 @@ size_t ra_portable_size_in_bytes(const roaring_array_t *ra) {
     return count;
 }
 
+static size_t ra_portable_network_size_in_bytes(const roaring_array_t *ra)
+{
+	size_t count = ra_portable_network_header_size(ra);
+
+	for (int32_t k = 0; k < ra->size; ++k)
+		count += container_size_in_bytes(ra->containers[k], ra->typecodes[k]);
+	return count;
+}
+
 size_t ra_portable_serialize(const roaring_array_t *ra, char *buf) {
     char *initbuf = buf;
     uint32_t startOffset = 0;
@@ -7740,6 +7796,80 @@ size_t ra_portable_serialize(const roaring_array_t *ra, char *buf) {
     return buf - initbuf;
 }
 
+int ra_portable_network_serialize(const roaring_array_t *ra,
+				  int (*write_fn) (void *, const void *, size_t),
+				  void *data)
+{
+	uint32_t initial_offset;
+	uint32_t cookie;
+	bool has_run = ra_has_run_container(ra);
+
+	if (has_run) {
+		uint8_t *bitmap_of_run_containers = NULL;
+		size_t bitmap_run_container_size = (ra->size + 7) / 8;
+
+		cookie = htonl(SERIAL_COOKIE | ((ra->size - 1) << 16));
+		if (write_fn(data, &cookie, 4) != 4)
+			return -1;
+		initial_offset = sizeof(cookie);
+
+		bitmap_of_run_containers = (uint8_t *)roaring_calloc(bitmap_run_container_size, 1);
+
+		for (uint32_t i = 0; i < ra->size; i++) {
+			if (get_container_type(ra->containers[i], ra->typecodes[i]) ==
+                	    RUN_CONTAINER_TYPE)
+				bitmap_of_run_containers[i / 8] |= (1 << (i % 8));
+		}
+
+		for (size_t i = 0; i < bitmap_run_container_size; i++) {
+			if (write_fn(data, bitmap_of_run_containers + i, 1) != 1) {
+				free(bitmap_of_run_containers);
+				return -1;
+			}
+		}
+		free(bitmap_of_run_containers);
+		initial_offset += bitmap_run_container_size;
+	} else {
+		cookie = htonl(SERIAL_COOKIE_NO_RUNCONTAINER | (ra->size - 1) << 16);
+		if (write_fn(data, &cookie, 4) != 4)
+			return -1;
+
+		initial_offset = sizeof(cookie);
+	}
+
+	/* description table */
+	for (uint32_t i = 0; i < ra->size; i++) {
+		uint16_t card;
+		uint16_t nt_key = htons(ra->keys[i]);
+
+		if (write_fn(data, &nt_key, sizeof(uint16_t)) != sizeof(uint16_t))
+			return -1;
+
+		card = (uint16_t)(container_get_cardinality(ra->containers[i], ra->typecodes[i]) - 1);
+		card = htons(card);
+		if (write_fn(data, &card, 2) != 2)
+			return -1;
+	}
+	initial_offset += 4 * ra->size;
+
+	if ((!has_run) || (ra->size >= NO_OFFSET_THRESHOLD)) {
+		uint32_t nt_offset;
+		initial_offset += 4 * ra->size;
+		nt_offset = htonl(initial_offset);
+		// writing the containers offsets
+		for (int32_t k = 0; k < ra->size; k++) {
+			if (write_fn(data, &nt_offset, sizeof(int32_t)) != sizeof(int32_t))
+				return -1;
+			initial_offset += container_size_in_bytes(ra->containers[k], ra->typecodes[k]);
+		}
+	}
+	for (int32_t k = 0; k < ra->size; ++k) {
+		container_network_write(ra->containers[k], ra->typecodes[k], write_fn, data);
+	}
+
+	return 0;
+}
+
 // Quickly checks whether there is a serialized bitmap at the pointer,
 // not exceeding size "maxbytes" in bytes. This function does not allocate
 // memory dynamically.
@@ -7827,6 +7957,83 @@ size_t ra_portable_deserialize_size(const char *buf, const size_t maxbytes) {
     return bytestotal;
 }
 
+size_t ra_portable_network_deserialize_size(const char *buf, const size_t maxbytes) {
+	size_t bytestotal = sizeof(int32_t);// for cookie
+	uint32_t cookie;
+	int32_t size;
+	if(bytestotal > maxbytes)
+		return 0;
+	memcpy(&cookie, buf, sizeof(int32_t));
+	cookie = ntohl(cookie);
+	buf += sizeof(uint32_t);
+	if ((cookie & 0xFFFF) != SERIAL_COOKIE &&
+		(cookie & 0xFFFF) != SERIAL_COOKIE_NO_RUNCONTAINER) {
+		return 0;
+	}
+
+	size = (cookie >> 16) + 1;
+	if (size > (1<<16)) {
+		return 0; // logically impossible
+	}
+	else if (size == (1 << 16))
+		return bytestotal;
+	char *bitmapOfRunContainers = NULL;
+	bool hasrun = (cookie & 0xFFFF) == SERIAL_COOKIE;
+	if (hasrun) {
+		int32_t s = (size + 7) / 8;
+		bytestotal += s;
+		if(bytestotal > maxbytes) return 0;
+		bitmapOfRunContainers = (char *)buf;
+		buf += s;
+	}
+	bytestotal += size * 2 * sizeof(uint16_t);
+	if(bytestotal > maxbytes) return 0;
+	uint16_t *keyscards = (uint16_t *)buf;
+	buf += size * 2 * sizeof(uint16_t);
+	if ((!hasrun) || (size >= NO_OFFSET_THRESHOLD)) {
+		// skipping the offsets
+		bytestotal += size * 4;
+		if(bytestotal > maxbytes) return 0;
+		buf += size * 4;
+	}
+	// Reading the containers
+	for (int32_t k = 0; k < size; ++k) {
+		uint16_t tmp;
+		memcpy(&tmp, keyscards + 2*k+1, sizeof(tmp));
+		uint32_t thiscard = ntohs(tmp) + 1;
+		bool isbitmap = (thiscard > DEFAULT_MAX_SIZE);
+		bool isrun = false;
+		if(hasrun && (bitmapOfRunContainers[k / 8] & (1 << (k % 8))) != 0) {
+			isbitmap = false;
+			isrun = true;
+		}
+		if (isbitmap) {
+			size_t containersize = BITSET_CONTAINER_SIZE_IN_WORDS * sizeof(uint64_t);
+			bytestotal += containersize;
+			if(bytestotal > maxbytes)
+				return 0;
+			buf += containersize;
+		} else if (isrun) {
+			bytestotal += sizeof(uint16_t);
+			if(bytestotal > maxbytes) return 0;
+			uint16_t n_runs;
+			memcpy(&n_runs, buf, sizeof(uint16_t));
+			n_runs = ntohs(n_runs);
+			buf += sizeof(uint16_t);
+			size_t containersize = n_runs * sizeof(rle16_t);
+			bytestotal += containersize;
+			if(bytestotal > maxbytes) return 0;
+			buf += containersize;
+		} else {
+			size_t containersize = thiscard * sizeof(uint16_t);
+			bytestotal += containersize;
+			if(bytestotal > maxbytes)
+				return 0;
+			buf += containersize;
+		}
+	}
+	return bytestotal;
+}
 
 // this function populates answer from the content of buf (reading up to maxbytes bytes).
 // The function returns false if a properly serialized bitmap cannot be found.
@@ -8000,6 +8207,177 @@ bool ra_portable_deserialize(roaring_array_t *answer, const char *buf, const siz
     return true;
 }
 
+bool ra_portable_network_deserialize(roaring_array_t *answer, const char *buf, const size_t maxbytes, size_t *readbytes)
+{
+	uint32_t cookie;
+	int32_t size;
+	const char *bitmapOfRunContainers = NULL;
+	int hasrun = 0;
+	uint16_t *keyscards;
+
+	*readbytes = sizeof(int32_t);// for cookie
+	if(*readbytes > maxbytes) {
+	fprintf(stderr, "Ran out of bytes while reading first 4 bytes.\n");
+	return false;
+	}
+	memcpy(&cookie, buf, sizeof(int32_t));
+	cookie = ntohl(cookie);
+	buf += sizeof(uint32_t);
+	if ((cookie & 0xFFFF) != SERIAL_COOKIE &&
+		(cookie & 0xFFFF) != SERIAL_COOKIE_NO_RUNCONTAINER) {
+		fprintf(stderr, "I failed to find one of the right cookies. Found %" PRIu32 "\n",
+			cookie);
+		return false;
+	}
+
+	size = (cookie >> 16) + 1;
+	if (size < 0) {
+		fprintf(stderr, "You cannot have a negative number of containers, the data must be corrupted: %" PRId32 "\n",
+				size);
+		return false; // logically impossible
+	}
+	if (size > (1<<16)) {
+		fprintf(stderr, "You cannot have so many containers, the data must be corrupted: %" PRId32 "\n",
+				size);
+		return false; // logically impossible
+	}
+	else if (size == (1 << 16)) {
+		ra_init_with_capacity(answer, size);
+		return true;
+	}
+	hasrun = (cookie & 0xFFFF) == SERIAL_COOKIE;
+	if (hasrun) {
+		int32_t s = (size + 7) / 8;
+		*readbytes += s;
+		if(*readbytes > maxbytes) {// data is corrupted?
+		fprintf(stderr, "Ran out of bytes while reading run bitmap.\n");
+		return false;
+		}
+		bitmapOfRunContainers = buf;
+		buf += s;
+	}
+	keyscards = (uint16_t *)buf;
+
+	*readbytes += size * 2 * sizeof(uint16_t);
+	if(*readbytes > maxbytes) {
+		fprintf(stderr, "Ran out of bytes while reading key-cardinality array.\n");
+		return false;
+	}
+	buf += size * 2 * sizeof(uint16_t);
+
+	bool is_ok = ra_init_with_capacity(answer, size);
+	if (!is_ok) {
+		fprintf(stderr, "Failed to allocate memory for roaring array. Bailing out.\n");
+		return false;
+	}
+
+	for (int32_t k = 0; k < size; ++k) {
+		uint16_t tmp;
+		memcpy(&tmp, keyscards + 2*k, sizeof(tmp));
+		answer->keys[k] = ntohs(tmp);
+	}
+	if ((!hasrun) || (size >= NO_OFFSET_THRESHOLD)) {
+		*readbytes += size * 4;
+		if(*readbytes > maxbytes) {// data is corrupted?
+			fprintf(stderr, "Ran out of bytes while reading offsets.\n");
+			ra_clear(answer);// we need to clear the containers already allocated, and the roaring array
+			return false;
+		}
+
+		// skipping the offsets
+		buf += size * 4;
+	}
+	// Reading the containers
+	for (int32_t k = 0; k < size; ++k) {
+		uint16_t tmp;
+		uint32_t thiscard;
+		bool isbitmap;
+		bool isrun;
+
+		memcpy(&tmp, keyscards + 2*k+1, sizeof(tmp));
+		thiscard = ntohs(tmp) + 1;
+		isbitmap = (thiscard > DEFAULT_MAX_SIZE);
+		isrun = false;
+		if(hasrun && (bitmapOfRunContainers[k / 8] & (1 << (k % 8))) != 0) {
+			isbitmap = false;
+			isrun = true;
+		}
+		if (isbitmap) {
+			// we check that the read is allowed
+			size_t containersize = BITSET_CONTAINER_SIZE_IN_WORDS * sizeof(uint64_t);
+			*readbytes += containersize;
+			if(*readbytes > maxbytes) {
+				fprintf(stderr, "Running out of bytes while reading a bitset container.\n");
+				ra_clear(answer);// we need to clear the containers already allocated, and the roaring array
+				return false;
+			}
+			// it is now safe to read
+			bitset_container_t *c = bitset_container_create();
+			if(c == NULL) {// memory allocation failure
+				fprintf(stderr, "Failed to allocate memory for a bitset container.\n");
+				ra_clear(answer);// we need to clear the containers already allocated, and the roaring array
+				return false;
+			}
+			answer->size++;
+			buf += bitset_container_network_read(thiscard, c, buf);
+			answer->containers[k] = c;
+			answer->typecodes[k] = BITSET_CONTAINER_TYPE;
+		} else if (isrun) {
+			// we check that the read is allowed
+			*readbytes += sizeof(uint16_t);
+			if(*readbytes > maxbytes) {
+				fprintf(stderr, "Running out of bytes while reading a run container (header).\n");
+				ra_clear(answer);// we need to clear the containers already allocated, and the roaring array
+				return false;
+			}
+			uint16_t n_runs;
+			memcpy(&n_runs, buf, sizeof(uint16_t));
+			n_runs = ntohs(n_runs);
+			size_t containersize = n_runs * sizeof(rle16_t);
+			*readbytes += containersize;
+			if(*readbytes > maxbytes) {// data is corrupted?
+				fprintf(stderr, "Running out of bytes while reading a run container.\n");
+				ra_clear(answer);// we need to clear the containers already allocated, and the roaring array
+				return false;
+			}
+			// it is now safe to read
+
+			run_container_t *c = run_container_create();
+			if(c == NULL) {// memory allocation failure
+				fprintf(stderr, "Failed to allocate memory for a run container.\n");
+				ra_clear(answer);// we need to clear the containers already allocated, and the roaring array
+				return false;
+			}
+			answer->size++;
+			buf += run_container_network_read(thiscard, c, buf);
+			answer->containers[k] = c;
+			answer->typecodes[k] = RUN_CONTAINER_TYPE;
+		} else {
+			// we check that the read is allowed
+			size_t containersize = thiscard * sizeof(uint16_t);
+			*readbytes += containersize;
+			if(*readbytes > maxbytes) {// data is corrupted?
+				fprintf(stderr, "Running out of bytes while reading an array container.\n");
+				ra_clear(answer);// we need to clear the containers already allocated, and the roaring array
+				return false;
+			}
+			// it is now safe to read
+			array_container_t *c =
+				array_container_create_given_capacity(thiscard);
+			if(c == NULL) {// memory allocation failure
+				fprintf(stderr, "Failed to allocate memory for an array container.\n");
+				ra_clear(answer);// we need to clear the containers already allocated, and the roaring array
+				return false;
+			}
+			answer->size++;
+			buf += array_container_network_read(thiscard, c, buf);
+			answer->containers[k] = c;
+			answer->typecodes[k] = ARRAY_CONTAINER_TYPE;
+		}
+	}
+	return true;
+}
+
 #ifdef __cplusplus
 } } }  // extern "C" { namespace roaring { namespace internal {
 #endif
@@ -8603,16 +8981,16 @@ extern inline void roaring_bitmap_remove_range(roaring_bitmap_t *r, uint64_t min
 void roaring_bitmap_printf(const roaring_bitmap_t *r) {
     const roaring_array_t *ra = &r->high_low_container;
 
-    printf("{");
+    fprintf(stderr, "{");
     for (int i = 0; i < ra->size; ++i) {
         container_printf_as_uint32_array(ra->containers[i], ra->typecodes[i],
                                          ((uint32_t)ra->keys[i]) << 16);
 
         if (i + 1 < ra->size) {
-            printf(",");
+            fprintf(stderr, ",");
         }
     }
-    printf("}");
+    fprintf(stderr, "}");
 }
 
 void roaring_bitmap_printf_describe(const roaring_bitmap_t *r) {
@@ -8736,6 +9114,14 @@ void roaring_bitmap_free(const roaring_bitmap_t *r) {
     roaring_free((roaring_bitmap_t*)r);
 }
 
+void roaring_bitmap_free_safe(roaring_bitmap_t **r)
+{
+	if (*r) {
+		roaring_bitmap_free((const roaring_bitmap_t *)*r);
+		r = NULL;
+	}
+}
+
 void roaring_bitmap_clear(roaring_bitmap_t *r) {
   ra_reset(&r->high_low_container);
 }
@@ -9700,6 +10086,11 @@ size_t roaring_bitmap_portable_size_in_bytes(const roaring_bitmap_t *r) {
     return ra_portable_size_in_bytes(&r->high_low_container);
 }
 
+size_t roaring_bitmap_network_portable_size_in_bytes(const roaring_bitmap_t *r)
+{
+	return ra_portable_network_size_in_bytes(&r->high_low_container);
+}
+
 
 roaring_bitmap_t *roaring_bitmap_portable_deserialize_safe(const char *buf, size_t maxbytes) {
     roaring_bitmap_t *ans =
@@ -9718,21 +10109,50 @@ roaring_bitmap_t *roaring_bitmap_portable_deserialize_safe(const char *buf, size
     return ans;
 }
 
+roaring_bitmap_t *roaring_bitmap_portable_network_deserialize_safe(const char *buf, size_t maxbytes)
+{
+	roaring_bitmap_t *ans =
+		(roaring_bitmap_t *)roaring_malloc(sizeof(roaring_bitmap_t));
+	if (ans == NULL) {
+		return NULL;
+	}
+	size_t bytesread;
+	bool is_ok = ra_portable_network_deserialize(&ans->high_low_container, buf, maxbytes, &bytesread);
+	if(is_ok) assert(bytesread <= maxbytes);
+	roaring_bitmap_set_copy_on_write(ans, false);
+	if (!is_ok) {
+		roaring_free(ans);
+		return NULL;
+	}
+	return ans;
+}
+
 roaring_bitmap_t *roaring_bitmap_portable_deserialize(const char *buf) {
     return roaring_bitmap_portable_deserialize_safe(buf, SIZE_MAX);
 }
 
-
 size_t roaring_bitmap_portable_deserialize_size(const char *buf, size_t maxbytes) {
   return ra_portable_deserialize_size(buf, maxbytes);
 }
 
+size_t roaring_bitmap_portable_network_deserialize_size(const char *buf, size_t maxbytes) {
+	size_t size = ra_portable_network_deserialize_size(buf, maxbytes);
+	return size;
+}
+
 
 size_t roaring_bitmap_portable_serialize(const roaring_bitmap_t *r,
                                          char *buf) {
     return ra_portable_serialize(&r->high_low_container, buf);
 }
 
+int roaring_bitmap_portable_network_serialize(roaring_bitmap_t *rb,
+				     int (*write_fn) (void *, const void *, size_t),
+				     void *data)
+{
+	return ra_portable_network_serialize(&rb->high_low_container, write_fn, data);
+}
+
 roaring_bitmap_t *roaring_bitmap_deserialize(const void *buf) {
     const char *bufaschar = (const char *)buf;
     if (*(const unsigned char *)buf == CROARING_SERIALIZATION_ARRAY_UINT32) {
@@ -13827,9 +14247,9 @@ void array_container_printf_as_uint32_array(const array_container_t *v,
     if (v->cardinality == 0) {
         return;
     }
-    printf("%u", v->array[0] + base);
+    fprintf(stderr, "%u", v->array[0] + base);
     for (int i = 1; i < v->cardinality; ++i) {
-        printf(",%u", v->array[i] + base);
+        fprintf(stderr, ",%u", v->array[i] + base);
     }
 }
 
@@ -13856,6 +14276,20 @@ int32_t array_container_write(const array_container_t *container, char *buf) {
     return array_container_size_in_bytes(container);
 }
 
+int array_container_network_write(const array_container_t *container,
+				  int (*write_fn) (void *, const void *, size_t),
+				  void *data)
+{
+	int32_t i;
+	size_t size = container->cardinality * sizeof(uint16_t);
+	for (i = 0; i < container->cardinality; i++) {
+		uint16_t nt_elem = htons(container->array[i]);
+		if (write_fn(data, &nt_elem, sizeof(uint16_t)) != sizeof(uint16_t))
+			return -1;
+	}
+	return 0;
+}
+
 bool array_container_is_subset(const array_container_t *container1,
                                const array_container_t *container2) {
     if (container1->cardinality > container2->cardinality) {
@@ -13890,6 +14324,23 @@ int32_t array_container_read(int32_t cardinality, array_container_t *container,
     return array_container_size_in_bytes(container);
 }
 
+int32_t array_container_network_read(int32_t cardinality, array_container_t *container,
+                        	     const char *buf)
+{
+	uint32_t i;
+	if (container->capacity < cardinality) {
+		array_container_grow(container, cardinality, false);
+	}
+	container->cardinality = cardinality;
+	for (i = 0; i < container->cardinality; i++) {
+		uint16_t val;
+		memcpy(&val, buf + i * sizeof(uint16_t), sizeof(uint16_t));
+		val = ntohs(val);
+		container->array[i] = val;
+	}
+	return array_container_size_in_bytes(container);
+}
+
 bool array_container_iterate(const array_container_t *cont, uint32_t base,
                              roaring_iterator iterator, void *ptr) {
     for (int i = 0; i < cont->cardinality; i++)
@@ -15208,13 +15659,13 @@ void run_container_printf_as_uint32_array(const run_container_t *cont,
     {
         uint32_t run_start = base + cont->runs[0].value;
         uint16_t le = cont->runs[0].length;
-        printf("%u", run_start);
-        for (uint32_t j = 1; j <= le; ++j) printf(",%u", run_start + j);
+        fprintf(stderr, "%u", run_start);
+        for (uint32_t j = 1; j <= le; ++j) fprintf(stderr, ",%u", run_start + j);
     }
     for (int32_t i = 1; i < cont->n_runs; ++i) {
         uint32_t run_start = base + cont->runs[i].value;
         uint16_t le = cont->runs[i].length;
-        for (uint32_t j = 0; j <= le; ++j) printf(",%u", run_start + j);
+        for (uint32_t j = 0; j <= le; ++j) fprintf(stderr, ",%u", run_start + j);
     }
 }
 
@@ -15225,6 +15676,28 @@ int32_t run_container_write(const run_container_t *container, char *buf) {
     return run_container_size_in_bytes(container);
 }
 
+int run_container_network_write(const run_container_t *container,
+				int (*write_fn) (void *, const void *, size_t),
+				void *data)
+{
+	uint16_t i;
+	int32_t nt_nruns = htonl(container->n_runs);
+	if (write_fn(data, &nt_nruns, sizeof(uint16_t)))
+		return -1;
+
+	for (i = 0; i < container->n_runs; i++) {
+		rle16_t run = container->runs[i];
+		uint16_t nt_value = htons(run.value);
+		uint16_t nt_len = htons(run.length);
+		if (write_fn(data, &nt_value, sizeof(uint16_t)) != sizeof(uint16_t))
+			return -1;
+		if (write_fn(data, &nt_len, sizeof(uint16_t)) != sizeof(uint16_t))
+			return -1;
+	}
+
+	return 0;
+}
+
 int32_t run_container_read(int32_t cardinality, run_container_t *container,
                            const char *buf) {
     (void)cardinality;
@@ -15238,6 +15711,29 @@ int32_t run_container_read(int32_t cardinality, run_container_t *container,
     return run_container_size_in_bytes(container);
 }
 
+int32_t run_container_network_read(int32_t cardinality, run_container_t *container,
+                        	   const char *buf)
+{
+	int32_t n_runs;
+	memcpy(&n_runs, buf, sizeof(uint16_t));
+	n_runs = ntohs(n_runs);
+	container->n_runs = n_runs;
+	if (container->n_runs > container->capacity)
+        run_container_grow(container, container->n_runs, false);
+	if(container->n_runs > 0) {
+		uint32_t i;
+
+		for (i = 0; i < container->n_runs; i++) {
+			rle16_t run;
+			memcpy(&run, buf + sizeof(uint16_t) + i * sizeof(rle16_t), sizeof(rle16_t));
+			run.length = ntohs(run.length);
+			run.value = ntohs(run.value);
+			container->runs[i] = run;
+		}
+	}
+	return run_container_size_in_bytes(container);
+}
+
 bool run_container_iterate(const run_container_t *cont, uint32_t base,
                            roaring_iterator iterator, void *ptr) {
     for (int i = 0; i < cont->n_runs; ++i) {
@@ -17417,10 +17913,10 @@ void bitset_container_printf_as_uint32_array(const bitset_container_t * v, uint3
 			uint64_t t = w & (~w + 1);
 			int r = __builtin_ctzll(w);
 			if(iamfirst) {// predicted to be false
-				printf("%u", r + base);
+				fprintf(stderr, "%u", r + base);
 				iamfirst = false;
 			} else {
-				printf(",%u",r + base);
+				fprintf(stderr, ",%u",r + base);
 			}
 			w ^= t;
 		}
@@ -17454,6 +17950,18 @@ int32_t bitset_container_write(const bitset_container_t *container,
 	return bitset_container_size_in_bytes(container);
 }
 
+int bitset_container_network_write(const bitset_container_t *container,
+				   int (*write_fn) (void *, const void *, size_t),
+				   void *data)
+{
+	uint32_t i = 0;
+	for (i = 0; i < BITSET_CONTAINER_SIZE_IN_WORDS; i++) {
+		uint64_t nt_word = htonll(container->words[i]);
+		if (write_fn(data, &nt_word, sizeof(uint64_t)) != sizeof(uint64_t))
+			return -1;
+	}
+	return 0;
+}
 
 int32_t bitset_container_read(int32_t cardinality, bitset_container_t *container,
 		const char *buf)  {
@@ -17462,6 +17970,23 @@ int32_t bitset_container_read(int32_t cardinality, bitset_container_t *container
 	return bitset_container_size_in_bytes(container);
 }
 
+int32_t bitset_container_network_read(int32_t cardinality, bitset_container_t *container,
+				      const char *buf)
+{
+	uint32_t i = 0;
+	const char *mbuf = buf;
+	container->cardinality = cardinality;
+
+	for (i = 0; i < BITSET_CONTAINER_SIZE_IN_WORDS; i++) {
+		uint64_t nt_word;
+		memcpy(&nt_word, mbuf, sizeof(uint64_t));
+		mbuf += sizeof(uint64_t);
+
+		container->words[i] = ntohll(nt_word);
+	}
+	return bitset_container_size_in_bytes(container);
+}
+
 bool bitset_container_iterate(const bitset_container_t *cont, uint32_t base, roaring_iterator iterator, void *ptr) {
   for (int32_t i = 0; i < BITSET_CONTAINER_SIZE_IN_WORDS; ++i ) {
     uint64_t w = cont->words[i];
diff --git a/roaring/roaring.h b/roaring/roaring.h
index bd5e0a0fe1c..84489eaa260 100644
--- a/roaring/roaring.h
+++ b/roaring/roaring.h
@@ -409,6 +409,11 @@ void roaring_bitmap_andnot_inplace(roaring_bitmap_t *r1,
  */
 void roaring_bitmap_free(const roaring_bitmap_t *r);
 
+/**
+ * Frees the memory if exists
+ */
+void roaring_bitmap_free_safe(roaring_bitmap_t **r);
+
 /**
  * Add value n_args from pointer vals, faster than repeatedly calling
  * `roaring_bitmap_add()`
@@ -605,6 +610,9 @@ roaring_bitmap_t *roaring_bitmap_portable_deserialize(const char *buf);
 roaring_bitmap_t *roaring_bitmap_portable_deserialize_safe(const char *buf,
                                                            size_t maxbytes);
 
+roaring_bitmap_t *roaring_bitmap_portable_network_deserialize_safe(const char *buf,
+								   size_t maxbytes);
+
 /**
  * Check how many bytes would be read (up to maxbytes) at this pointer if there
  * is a bitmap, returns zero if there is no valid bitmap.
@@ -615,6 +623,9 @@ roaring_bitmap_t *roaring_bitmap_portable_deserialize_safe(const char *buf,
 size_t roaring_bitmap_portable_deserialize_size(const char *buf,
                                                 size_t maxbytes);
 
+size_t roaring_bitmap_portable_network_deserialize_size(const char *buf,
+							size_t maxbytes);
+
 /**
  * How many bytes are required to serialize this bitmap.
  *
@@ -623,6 +634,8 @@ size_t roaring_bitmap_portable_deserialize_size(const char *buf,
  */
 size_t roaring_bitmap_portable_size_in_bytes(const roaring_bitmap_t *r);
 
+size_t roaring_bitmap_network_portable_size_in_bytes(const roaring_bitmap_t *r);
+
 /**
  * Write a bitmap to a char buffer.  The output buffer should refer to at least
  * `roaring_bitmap_portable_size_in_bytes(r)` bytes of allocated memory.
@@ -635,6 +648,10 @@ size_t roaring_bitmap_portable_size_in_bytes(const roaring_bitmap_t *r);
  */
 size_t roaring_bitmap_portable_serialize(const roaring_bitmap_t *r, char *buf);
 
+int roaring_bitmap_portable_network_serialize(roaring_bitmap_t *rb,
+				     int (*write_fn) (void *, const void *, size_t),
+				     void *data);
+
 /*
  * "Frozen" serialization format imitates memory layout of roaring_bitmap_t.
  * Deserialized bitmap is a constant view of the underlying buffer.
-- 
gitgitgadget

