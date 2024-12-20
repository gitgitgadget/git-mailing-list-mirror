Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44322653E
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715201; cv=none; b=psqOwEkfvgz0yk+EGvjCEoDmrr0QjElPI4h1VGV2qWQ3ittAa6zwfDCkjLA1f91JCezTFAR6FjgE2z8E9kCQpB92OusPc/3NRcS34fL3hLpmo70VpiqFrKDOWARsaRdgO5SK5/sO1+xuIzPG6ib+vB6fqPpJtL1ObsSmBJ8iAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715201; c=relaxed/simple;
	bh=k8MQC+N2aVbjxI5hoHkypI0UkbjCFdXsq4kXmVJXDr0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fCdmvPcWF+j3Wc5zZNZ8aoZsOLpdOKSkx3G+nMVBSZBSxJpFYDcH4A9ZGkn2okZoQkgRjf6AwyxThI51R7nLNpqkZy7iqyonXva/OxnPltByzujXCcIWzLyQ8oOtuuYMAHiJ8LsrgVGjthLqLRyKfUtagPHnWxH+I+XSkcQlxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9PffYdQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9PffYdQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so23468275e9.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734715198; x=1735319998; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZMEj2Cgkx4xj43UqaYcdHWu3cPiAf8tko9NUF8PKIQ=;
        b=I9PffYdQp4qA97+bybeQ2NblRTNOWCIdfZq6hzh2TRFESUuh0m9NpKv8mA5yHKQggU
         El/G18iWO7cAMzWln+afjFPQ6mhRlyOCUpgpXDuoONdfngv13uvSCI5rEUShd11vjATB
         xK++i4NPlIXgAp2Mlj4MKTencEpq3jxBxYrzztq+BgOI0g11tsh6us7ZoI+zKqbBmcD7
         16zrXX9RDOoKyltlA6JAJEGjYcfUJlyNANFDAS3QkDGLLRsEeaIuW3CUWoDMAIuVNeF8
         rQqeloHBQY+MgybBSa6ouxp25/8MfFvPW/xWuxPG0WGWcglicZOwcjbVXG6YfgWNzAEf
         j5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715198; x=1735319998;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZMEj2Cgkx4xj43UqaYcdHWu3cPiAf8tko9NUF8PKIQ=;
        b=JjVuDeGOH7euPu4Pk/ekajTOMfRO+AW7s18pMVRWw8iQwD1Ag5ZzcyvFKfaLaigGjM
         NGlpPEgtiT4rlHcuYvQIyHZL04P9X7jPDUF08M0QKyecifmLGxCQ5lI4Yk5+EuLGOGU8
         kx3FuFDtSj0+qz9wxITQjZ9bi8Llpdivea6xQ/WBVFOAX6t+hdbwdcaG3OVDhhAdrt+U
         O8zsOnys+OcCNwDttjopP4+hTAkYIkZxO4fzKFbvBsX2JQzH5GJy3QKJTQVDXAHm5u09
         4+h3x/gbABYBlUhSB/yhRf2Uiaki507UNkV7K51GTwHIcU8MTuToIsyItyvXvJ1N3AUQ
         7BbQ==
X-Gm-Message-State: AOJu0YzrImWhEsLwsgocH8h1FDDgDW7ODaMjY5pgBU6gsBeuXbgJn+82
	XZb2oYKpiUP38NvyS8utUvrDtSYqJNjbQul9PQS9dJqel4gJQ1P9xJyhwA==
X-Gm-Gg: ASbGncvx+gJ0rb1jDM9RqsYJDaLv4+7uJH3W3qUPAHfH3GEn9Araoi/5KE96/wkT6Ct
	TEM7u+S/WK1UZNq2Gebb6VvUZ5hX4OI1FO54osNcmapoTY8Z6lMZZNe7T9szAWuBMYbiJXOHqB+
	8MY1x4uGJR/ZXBLjc3RnXQudg0uQJ1s/iXVnJtMBOKShBgKie+0uGVNqcFIdJiiL68Anz3ZUqgn
	iajdpA9iTnmI/5yO+N55VcwyJd8zrKlIS8yZDFyIqSv6+Jv1/apYneqBg==
X-Google-Smtp-Source: AGHT+IFByzXaLoQ1L1bqYf/vwszYgHuHgUG0kllXfiP2H1o1lwQ6VPoVfHBTLK86O0IqLkGeXCqkAg==
X-Received: by 2002:a05:600c:4509:b0:436:1971:2a4 with SMTP id 5b1f17b1804b1-4366864722emr35326795e9.17.1734715197688;
        Fri, 20 Dec 2024 09:19:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612008bcsm50650585e9.16.2024.12.20.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:19:57 -0800 (PST)
Message-Id: <68b4127580e2d475bec0d7cd0f6a9ae5e626b3c9.1734715194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
	<pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
From: "Jonathan Tan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 17:19:47 +0000
Subject: [PATCH v3 1/8] pack-objects: create new name-hash function version
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Jonathan Tan <jonathantanmy@google.com>

From: Jonathan Tan <jonathantanmy@google.com>

As we will explore in later changes, the default name-hash function used
in 'git pack-objects' has a tendency to cause collisions and cause poor
delta selection. This change creates an alternative that avoids some
collisions while preserving some amount of hash locality.

The pack_name_hash() method has not been materially changed since it was
introduced in ce0bd64 (pack-objects: improve path grouping
heuristics., 2006-06-05). The intention here is to group objects by path
name, but also attempt to group similar file types together by making
the most-significant digits of the hash be focused on the final
characters.

Here's the crux of the implementation:

	/*
	 * This effectively just creates a sortable number from the
	 * last sixteen non-whitespace characters. Last characters
	 * count "most", so things that end in ".c" sort together.
	 */
	while ((c = *name++) != 0) {
		if (isspace(c))
			continue;
		hash = (hash >> 2) + (c << 24);
	}

As the comment mentions, this only cares about the last sixteen
non-whitespace characters. This cause some filenames to collide more than
others. This collision is somewhat by design in order to promote hash
locality for files that have similar types (.c, .h, .json) or could be the
same file across a directory rename (a/foo.txt to b/foo.txt). This leads to
decent cross-path deltas in cases like shallow clones or packing a
repository with very few historical versions of files that share common data
with other similarly-named files.

However, when the name-hash instead leads to a large number of name-hash
collisions for otherwise unrelated files, this can lead to confusing the
delta calculation to prefer cross-path deltas over previous versions of the
same file.

The new pack_name_hash_v2() function attempts to fix this issue by
taking more of the directory path into account through its hash
function. Its naming implies that we will later wire up details for
choosing a name-hash function by version.

The first change is to be more careful about paths using non-ASCII
characters. With these characters in mind, reverse the bits in the byte
as the least-significant bits have the highest entropy and we want to
maximize their influence. This is done with some bit manipulation that
swaps the two halves, then the quarters within those halves, and then
the bits within those quarters.

The second change is to perform hash composition operations at every
level of the path. This is done by storing a 'base' hash value that
contains the hash of the parent directory. When reaching a directory
boundary, we XOR the current level's name-hash value with a downshift of
the previous level's hash. This perturbation intends to create low-bit
distinctions for paths with the same final 16 bytes but distinct parent
directory structures.

The collision rate and effectiveness of this hash function will be
explored in later changes as the function is integrated with 'git
pack-objects' and 'git repack'.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 pack-objects.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/pack-objects.h b/pack-objects.h
index b9898a4e64b..681c1116486 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -207,6 +207,34 @@ static inline uint32_t pack_name_hash(const char *name)
 	return hash;
 }
 
+static inline uint32_t pack_name_hash_v2(const unsigned char *name)
+{
+	uint32_t hash = 0, base = 0, c;
+
+	if (!name)
+		return 0;
+
+	while ((c = *name++)) {
+		if (isspace(c))
+			continue;
+		if (c == '/') {
+			base = (base >> 6) ^ hash;
+			hash = 0;
+		} else {
+			/*
+			 * 'c' is only a single byte. Reverse it and move
+			 * it to the top of the hash, moving the rest to
+			 * less-significant bits.
+			 */
+			c = (c & 0xF0) >> 4 | (c & 0x0F) << 4;
+			c = (c & 0xCC) >> 2 | (c & 0x33) << 2;
+			c = (c & 0xAA) >> 1 | (c & 0x55) << 1;
+			hash = (hash >> 2) + (c << 24);
+		}
+	}
+	return (base >> 6) ^ hash;
+}
+
 static inline enum object_type oe_type(const struct object_entry *e)
 {
 	return e->type_valid ? e->type_ : OBJ_BAD;
-- 
gitgitgadget

