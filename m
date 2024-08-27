Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D431D365B
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793217; cv=none; b=IowVy2Ykhd1NRmwlOYrx8EqbBhckFXwR4F13R+kqDNbURESSA1zwQFYFN3pXXKNO95gDTBTXVT9h32u+JZvLxzL5Y4S8fwseeoK2ownJhGwkYxPimjegGO4ND+o76OF6jik20RHNuJtOAA6g8L2lodXh0GR1j2iYv6puHnqcglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793217; c=relaxed/simple;
	bh=4qyL/Wj6mDaEHJ+llZ96c0sX7Cy2gXTqLFvTuAG7nbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNHLUCMi28qW59VPC5TfgOGxDVUf4lCUQREjI4MYrxQ8YaOAVimR+DdHwpjCOWA7KGq66/6k/uGJtOgzoPsfzQ+Mx/z9vkzZF/Hz032l0XJf5bWeZ+a4d9wjA/U/2t9t1l/7VgGjrLPRitae+2u4SIybEuO9gQuRXOXBC/KfhMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ky2ZlVQE; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ky2ZlVQE"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e115ef5740dso6081049276.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 14:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724793215; x=1725398015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gU4sZzyXS6OlqFeiu/y41CEIAQL5OwzMfLsvQbh9krU=;
        b=Ky2ZlVQEJ6fWrS3vbdHwX9Goc0IlmLhJBs/1DbnCHGQlKjHKMxy9T9mjGzxE0gKGAn
         KTIjSJ6/ramncDSP/+J5q6T2Hy5ijMOKiG9SddMcaNsaf+RqK9Wce+aVYW1HEDtpvKZ6
         ZqDOcKkkekWk1x9pxoKjsLr/JytYTuTNBKyw4Mn7zSJ2Tzb1YAyXd4H2YdAjZQmVibnk
         9sSebXFz50M8J2wruem5ic4aZe0Qexg4L/IunEbjcZUHgSecddp+Qml7l/qQpOxR/BO4
         gCYcoFT3G4qcHLKTJaKEPO5DsPVIFZ9rb/QcOyy3QQ2R8S7Ca7DRnI9+XZ5dEHfsN57a
         hDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724793215; x=1725398015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU4sZzyXS6OlqFeiu/y41CEIAQL5OwzMfLsvQbh9krU=;
        b=Z6axR79uc+FFHPW3QCL6mFAiQSrcuVAEnJffinZIPWuVELGxKCUdWHUBhw/Liql7Qy
         iI7uiTXa7ytpFhrxURC46GsXBlkiCsu/mZcvajvDvtwuCfyvpxLoojy1HKRFvOfQ5GhN
         1waXTYGk5X4LooSw1sQ9BjB+PJ8gElXnYCxTN9G33DJyAbBNTBWamq2mgDTT7vlVFsku
         YvngdK9v8cZwH0UVHFbWaF9UHjkbYzIs/INX6gKRb0DibS/EjK7IwqJFJg5gSAoTw4C4
         q7tgd2zR/mD27Pt1x1qHcN9h3WyRI8/tdj2YvmyD37X60M9HkXaNBoRFVvtaRyvUYYLx
         2wLw==
X-Gm-Message-State: AOJu0Yw+0OV70weP77W1KnzfbBNrCKOqbVFKI6IH+dYxQKvPPKAt2X4L
	QKi/mu9tPHYwKZGsyyKoIzVfrOEiEEweVrNb4Npv7gl1SWqxJcuABOxYwBUwXJGB10zjfNISVty
	L
X-Google-Smtp-Source: AGHT+IEPy6XC9cYapqfAcI9WBj7YcXyBdu/zH3p39JOE3bdf0c3Ysu9vuLaUM4qYCiEoGBjuHeSQJQ==
X-Received: by 2002:a05:690c:4583:b0:6b0:407a:e3af with SMTP id 00721157ae682-6c6286b9264mr138411587b3.34.1724793214917;
        Tue, 27 Aug 2024 14:13:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39dd47604sm20672587b3.125.2024.08.27.14.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:13:34 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:13:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] builtin/pack-objects.c: translate bit positions during
 pack-reuse
Message-ID: <8998e51135e76061e603304a6b7bbe19893fc067.1724793201.git.me@ttaylorr.com>
References: <cover.1724793201.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1724793201.git.me@ttaylorr.com>

When reusing chunks verbatim from an existing source pack, the function
write_reused_pack() first attempts to reuse whole words (via the
function `write_reused_pack_verbatim()`), and then individual bits (via
`write_reused_pack_one()`).

In the non-MIDX case, all of this code works fine. Likewise, in the MIDX
case, processing bits individually from the first (preferred) pack works
fine. However, processing subsequent packs in the MIDX case is broken
when there are duplicate objects among the set of MIDX'd packs.

This is because we treat the individual bit positions as valid pack
positions within the source pack(s), which does not account for gaps in
the source pack, like we see when the MIDX must break ties between
duplicate objects which appear in multiple packs.

The broken code looks like:

    for (; i < reuse_packfile_bitmap->word_alloc; i++) {
            for (offset = 0; offset < BITS_IN_EWORD, offset++) {
                    /* ... */

                    write_reused_pack_one(reuse_packfile->p,
                                          pos + offset - reuse_packfile->bitmap_pos,
                                          f, pack_start, &w_curs);
            }
    }

, where the second argument is incorrect and does not account for gaps.

Instead, make sure that we translate bit positions in the MIDX's
pseudo-pack order to pack positions in the respective source packs by:

  - Translating the bit position (pseudo-pack order) to a MIDX position
    (lexical order).

  - Use the MIDX position to obtain the offset at which the given object
    occurs in the source pack.

  - Then translate that offset back into a pack relative position within
    the source pack by calling offset_to_pack_pos().

After doing this, then we can safely use the result as a pack position.
Note that when doing single-pack reuse, as well as reusing objects from
the MIDX's preferred pack, such translation is not necessary, since
either ties are broken in favor of the preferred pack, or there are no
ties to break at all (in the case of non-MIDX bitmaps).

Failing to do this can result in strange failure modes. One example that
can occur when misinterpreting bits in the above fashion is that Git
thinks it's supposed to send a delta that the caller does not want.
Under this (incorrect) assumption, we try to look up the delta's base
(so that we can patch any OFS_DELTAs if necessary). We do this using
find_reused_offset().

But if we try and call that function for an offset belonging to an
object we did not send, we'll get back garbage. This can result in us
computing a negative fixup value, which results in memory corruption
when trying to write the (patched) OFS_DELTA header.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c      | 44 ++++++++++++++++++++++++++++++-------
 t/t5332-multi-pack-reuse.sh | 31 ++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 778be80f56..700adfb5a8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1191,6 +1191,7 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 		size_t pos = (i * BITS_IN_EWORD);
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
+			uint32_t pack_pos;
 			if ((word >> offset) == 0)
 				break;
 
@@ -1199,14 +1200,41 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 				continue;
 			if (pos + offset >= reuse_packfile->bitmap_pos + reuse_packfile->bitmap_nr)
 				goto done;
-			/*
-			 * Can use bit positions directly, even for MIDX
-			 * bitmaps. See comment in try_partial_reuse()
-			 * for why.
-			 */
-			write_reused_pack_one(reuse_packfile->p,
-					      pos + offset - reuse_packfile->bitmap_pos,
-					      f, pack_start, &w_curs);
+
+			if (reuse_packfile->bitmap_pos) {
+				/*
+				 * When doing multi-pack reuse on a
+				 * non-preferred pack, translate bit positions
+				 * from the MIDX pseudo-pack order back to their
+				 * pack-relative positions before attempting
+				 * reuse.
+				 */
+				struct multi_pack_index *m = reuse_packfile->from_midx;
+				uint32_t midx_pos;
+				off_t pack_ofs;
+
+				if (!m)
+					BUG("non-zero bitmap position without MIDX");
+
+				midx_pos = pack_pos_to_midx(m, pos + offset);
+				pack_ofs = nth_midxed_offset(m, midx_pos);
+
+				if (offset_to_pack_pos(reuse_packfile->p,
+						       pack_ofs, &pack_pos) < 0)
+					BUG("could not find expected object at offset %"PRIuMAX" in pack %s",
+					    (uintmax_t)pack_ofs,
+					    pack_basename(reuse_packfile->p));
+			} else {
+				/*
+				 * Can use bit positions directly, even for MIDX
+				 * bitmaps. See comment in try_partial_reuse()
+				 * for why.
+				 */
+				pack_pos = pos + offset;
+			}
+
+			write_reused_pack_one(reuse_packfile->p, pack_pos, f,
+					      pack_start, &w_curs);
 			display_progress(progress_state, ++written);
 		}
 	}
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index ba888a83d5..955ea42769 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -69,7 +69,7 @@ test_expect_success 'multi-pack reuse is disabled by default' '
 	test_pack_objects_reused_all 3 1
 '
 
-test_expect_failure 'feature.experimental implies multi-pack reuse' '
+test_expect_success 'feature.experimental implies multi-pack reuse' '
 	test_config feature.experimental true &&
 
 	test_pack_objects_reused_all 6 2
@@ -86,7 +86,7 @@ test_expect_success 'enable multi-pack reuse' '
 	git config pack.allowPackReuse multi
 '
 
-test_expect_failure 'reuse all objects from subset of bitmapped packs' '
+test_expect_success 'reuse all objects from subset of bitmapped packs' '
 	test_commit C &&
 	git repack -d &&
 
@@ -100,7 +100,7 @@ test_expect_failure 'reuse all objects from subset of bitmapped packs' '
 	test_pack_objects_reused 6 2 <in
 '
 
-test_expect_failure 'reuse all objects from all packs' '
+test_expect_success 'reuse all objects from all packs' '
 	test_pack_objects_reused_all 9 3
 '
 
@@ -194,7 +194,7 @@ test_expect_success 'omit delta with uninteresting base (same pack)' '
 	test_pack_objects_reused 3 1 <in
 '
 
-test_expect_failure 'omit delta from uninteresting base (cross pack)' '
+test_expect_success 'omit delta from uninteresting base (cross pack)' '
 	cat >in <<-EOF &&
 	$(git rev-parse $base)
 	^$(git rev-parse $delta)
@@ -236,4 +236,27 @@ test_expect_success 'non-omitted delta in MIDX preferred pack' '
 	test_pack_objects_reused_all $(wc -l <expect) 1
 '
 
+test_expect_success 'duplicate objects' '
+	git init duplicate-objects &&
+	(
+		cd duplicate-objects &&
+
+		git config pack.allowPackReuse multi &&
+
+		test_commit base &&
+
+		git repack -a &&
+
+		git rev-parse HEAD^{tree} >in &&
+		p="$(git pack-objects $packdir/pack <in)" &&
+
+		git multi-pack-index write --bitmap --preferred-pack=pack-$p.idx &&
+
+		objects_nr="$(git rev-list --count --all --objects)" &&
+		packs_nr="$(find $packdir -type f -name "pack-*.pack" | wc -l)" &&
+
+		test_pack_objects_reused_all $objects_nr $packs_nr
+	)
+'
+
 test_done
-- 
2.46.0.426.g82754d92509

