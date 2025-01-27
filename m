Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1718F2EF
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004563; cv=none; b=usLOsM8Mo8AeaKsxBXW4ZfrVzBMt72jc9AxuJmkgufoNlACT0/zi1PaVIJlxQ+yWgKMUe6df4h0p3KvqnKTeAB5LuyGEP89zoxO1nXZE25XjxfyEJ0ofYV5iVEr/Eai/H1Z8zhOgDWoqYN9n1mkBKDfe+qb3XbSHkQjbAbrh05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004563; c=relaxed/simple;
	bh=k8MQC+N2aVbjxI5hoHkypI0UkbjCFdXsq4kXmVJXDr0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aP27rmt2OIt3R1c3NyMDGwpPBJFoq+RQgj6AJjwVPNUMkgrlP//QxIbt8FF4uCmZEQPvsQ2BvwErHNDuteTH2H60pmAlH6xhenqt4W0ZgECgNNBEM2RztgVelvCrdkuuuT/FIUzOm2PwcFu9BpFPoJ7hqONso0d7x2VFI8Sbcvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9mAf9oz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9mAf9oz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436281c8a38so33924085e9.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 11:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738004559; x=1738609359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZMEj2Cgkx4xj43UqaYcdHWu3cPiAf8tko9NUF8PKIQ=;
        b=E9mAf9ozM6FFBNIKxFI7/3OCLTiqqXcpcFarf2Rh5+b0OivH2WGSilKrmnt7jIAzBQ
         TyLQJ5GnfaHqlVbPf/iD/yds6ySEV+eg/PU2ukx++DURLCMcORE42wRscPxUHCvfyvrK
         XOpoXsY7H1IAqcXKKEce75gZYthCUMx4WsxVwaDj6P1uZo578BR+zo04QdaB0HmlMhWw
         wKZHkItLKAGFm95sfnP8qDGXE/2sx966E8ouDjEr4lVdQcfFuF8eocgU6VZ1hS5cMXJN
         xXjzKZPv9p/8jBSR6Odfs3RcnzIcGrXRzI/qgTDmfabNggluxQWs5Nc6fRaEN9o0T8Pm
         QxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004559; x=1738609359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZMEj2Cgkx4xj43UqaYcdHWu3cPiAf8tko9NUF8PKIQ=;
        b=nKQVh54rXExpNdowAwwYvwRqZYv3fUuLbmuRJB82WGFMrxreRKmA7njrkHXjtG41Bp
         FqpkKd1+Hbbj7hWyWCbacCg5chI4OH2zEhfNbx2Nn/sSZ+VSkSGIveo6oT6fZ6K4IXOm
         EI9VtXIOfTu3HhBFs1OZ7M/W/mDkkizVCSOvUaWOr6iC4Ny9tufxN7N6MElBlSVCxlQu
         gnkmRYRnFKezxVTSWwPBLCZkMVAxR9xt9SBXe+vwVBVTGwG98/h8uv8vPZi3D8IwPv9K
         LKymQIr5Xt4vj7RzuWktYMIMFXotxnd6xx0eWmlymI+n+qWaMNJjoALcHJVhwHBGNYdP
         m2Pw==
X-Gm-Message-State: AOJu0Yyj89Hb+Gb6qSdhnNKwg0EHjgXK5eOpByFYiqgNxFeTV3HFX53o
	59vbwVYLV99AQbQRcTI35q/LTys3AxVmbK6Mnfp++VPmEkprSwWJ1Uft3Q==
X-Gm-Gg: ASbGncu9/u9/473oZCMJSH9ycWxt3IvcD7KD/9GA4p/0/oUIfGZfLkeAdmnv97CX3Zy
	PUnn/VP+OTBwMP0zJiDLcY8c0vrVarr/D4SlVrJ480+gh67yNMlBW43+65Tfuro1hLOELKbIAFz
	D1ra0tylFU87ka2DnVb2wzfkI9kNh84htB5i45EZEFA8kbGg1VUD0H+2JtOXHunlGbZr1KW+nVj
	ioFAODWiCNdgK86qwPmV1XzUNjeSIv1bY6jIm0agzS8PMhNzZbp61PSdmRwp9rcovRbGZaq3AbK
	7RVRjw==
X-Google-Smtp-Source: AGHT+IGxRmNPVy/o39MKjK17cFSLF2FYkfgNmYHrdmf2qMMzTp9D7c/g+LyJQMi+2wrYiYi7Je+BcQ==
X-Received: by 2002:a5d:6da1:0:b0:385:e411:c894 with SMTP id ffacd0b85a97d-38bf57a6844mr39771733f8f.43.1738004558542;
        Mon, 27 Jan 2025 11:02:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a176434sm12001936f8f.13.2025.01.27.11.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:02:38 -0800 (PST)
Message-Id: <68b4127580e2d475bec0d7cd0f6a9ae5e626b3c9.1738004555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
References: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
	<pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
From: "Jonathan Tan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Jan 2025 19:02:28 +0000
Subject: [PATCH v4 1/7] pack-objects: create new name-hash function version
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

