Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A01DF244
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181689; cv=none; b=oCKQR1webjuQnFC8A0dqILHD1WTfmOV7lQ43jPWIJ1+59ZKpd1n/bJTK/XpDilo/FrooQWpKggWzXTtVlt/DopeMXxENfrXOkzzvb5lcAZ13rs2IrFdc7Vwmezt9GZ0qq1uE364qVizdVO4iRTjXR5FP7F+ZdIjdbXSZaj2E8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181689; c=relaxed/simple;
	bh=FV4ZnohdKFbmnXQ9Zz2KEsxyErdSl0QgzALLPOV0+Us=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BMldRwh3egEn1t5isZX+S+PAroNhgkR5tq58741JVNsj17sVxwfJl3indNGh0DxXP0JCZwLqtDmP+nNIS+sGVvV1ys127RG0njupetK1FvmXzHqmfdli7HAnCoSyLDMvPKrl26o5EBuIceptV/tvlp8oXo1VWYAb6+zOSdYsoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bmjb1igg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmjb1igg"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa5ec8d6f64so42753966b.2
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 15:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733181686; x=1733786486; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uI/il6XRAhXWBkQjv5DkiNIe+xTnqh7xa8edagHJTY=;
        b=Bmjb1iggBBkcTjPrOewy+QxLt2dcwFCNSPr+ty7Pa0QaNkz8O6zOhADwcuWdUOrWIT
         LFAJAgctIS00muKMGstYP3Km2TI4opiaRYHSMWzGYz6Bg0/pb53coyOoP1yIg8btucBz
         Kzu2tOC7bmNH3fiEpEBGjUdbazrlKc1Dq/C0j+BlKAviZWblFvLhUjjwpWwBIz/rUGUH
         kvh+sQUETzau0spwfsznPi1YLdFBnzMHvCjQZan79+Q1ALmfjgyu1I1IpgScP+K3eI5G
         Wqh4YjUy5OrCxz4ffJs+qGeSMMEvgVyJ4Df/ksbxp/T8w/3b7Ds9JBXZ+Gkg08VBuZJP
         5ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733181686; x=1733786486;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uI/il6XRAhXWBkQjv5DkiNIe+xTnqh7xa8edagHJTY=;
        b=QmwA8cXCJFSLLtKon2S4h48jrg4BU37elGuogu/VxLYNoYgkCa7aqVOfZaw7531qkD
         hY46EPFlyiZnQw8WYkfGhVJ9nZxiVHgRvwEQvryFVEVJbd/v2+FW6dMA/mI7NtDWAG0M
         tXXZ2phgB+tHFb7QyuWodhFnUOsu2at7a2gPmf9I58iMa+ZyBbDxOXigz1dW2rrdOmC9
         nUYUcjJZ/zMIoekDPsWqpjRJJP6tAzaihp0F5VvPJtPEj0N7DhZEIWXFiPWnRfp6tdLb
         SBVqzlYByqa71ICqvpJ+RCO7OHQSf8B/jv6PCYkfC+nZpMSReISZPywaitBERkIYa0Tu
         75sQ==
X-Gm-Message-State: AOJu0YyxvCUdpvLomUaM+px4Jvkoq9zJOtmPRhyFShZCRMhf9ooFBkwB
	PyMAVsnMpaWn48X1SzAmlxaoraqxIsly+PdHuuDdk+yf3NUKwmHKMx87bQ==
X-Gm-Gg: ASbGncsBe7gsC6Pmck/2DU8tLT03mH4QsYSa6Vf5lzI/w6DDR6Ako8wTyr1u/PhC5kr
	zvv7iKEsws2Nfm/EC/8awY4Q3F0c7cS1IaACQzDSC2Szgm4V98l/vs2FKSxSbGbnLKPFzqf80vY
	ZdnZyPnXXVnbrafTWi1KtHEg4+rkiNzPy6BNxEuB6YsFru2vhTdYryeNQu7nM9ar3oIcNA59uD3
	SjKRd/dIRi3a6R4TgsGx036/Ke8XvKCSPV2YNMAbm01Rl+G6vE=
X-Google-Smtp-Source: AGHT+IEkxrilmblGCNVQEUKOVxJE5wG/EoyKq5SVoXSgjg9Saxfzpe5BDS9Oy7WOSn4Jac3EoLAxrQ==
X-Received: by 2002:a05:6402:4301:b0:5d0:cfad:f76 with SMTP id 4fb4d7f45d1cf-5d10cb5c1c1mr111119a12.16.1733181685738;
        Mon, 02 Dec 2024 15:21:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8dcefsm5688714a12.55.2024.12.02.15.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 15:21:25 -0800 (PST)
Message-Id: <454b070d5bb0f64e11cab993b126ef5d37a3615b.1733181682.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
From: "Jonathan Tan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Dec 2024 23:21:15 +0000
Subject: [PATCH v2 1/8] pack-objects: create new name-hash function version
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
index b9898a4e64b..15be8368d21 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -207,6 +207,34 @@ static inline uint32_t pack_name_hash(const char *name)
 	return hash;
 }
 
+static inline uint32_t pack_name_hash_v2(const char *name)
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

