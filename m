Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056C1411EF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423383; cv=none; b=I+1+pKuTQW6cxWjbgtj25J2a1o3l/p/6lzADXl7p8NE/u0Sbz81GrF2SQC5Gfd0CxuBIoDicm66hoGPukgqK7TfnxUy5mzRVhtO2bZUc+Oohg2zFcjwPH1tJWGTvf/bAmgSNZGxH/xcVApROSuoh8N2F+OOUeDfakKfckVWl+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423383; c=relaxed/simple;
	bh=FhrbzvpkYPe6y0O5Vs2lu3x1MJBxuZGjovT/vj5Lh/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXvfJvFuUy0Bz7TZYCdbx62kTwUSH5GsuQ+hNGzFmDqJ0UyuJahsmzgZwTWxIupdnfwabFZHa3iznEGVFVjs9905j/DrlIHayBPEQC18L1QoTO7/eabl0eL+d39rYgsfvcdMTWEwTW9aKQ5apwSJrJ/76XQvupK2epfQvN8E7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qr/waku0; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qr/waku0"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-479de65e08fso1539540137.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423380; x=1715028180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+NaR9kCt/Kq//9Oihu8b/Gg78CxhHgWvbJ3lr3JH/8=;
        b=qr/waku0ypUY8+AHQWwZ35jIjMbppAD9WWoASzjW+uKOfWV6hRyHASwXwehKkSCpk9
         uE5zIqVJ+14ppARu1PEcKET0MS7m0yfHtA5z+BhsiyoKDNhki+ELzpZz7y9s8GjBc/S9
         ozyDws1goq8N+9NHDqLkQ+vSK3yXDvvyQw7EDpTY/6YShZs43wKzLcZmO8Ujw0ElLsCw
         Lvd42z6QobFgnmjEHzRoE8m8jDLLNbhA/cn5PeoMBXKctbvL9hxWryv5Zo5+E7WmyfHT
         v35nUbNJy4F9lFiI66Bp3D4FonKy2n2kyDKQdPQ2dR7fmSaYItoHjHMX1OsKLTUTGI6O
         s/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423380; x=1715028180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+NaR9kCt/Kq//9Oihu8b/Gg78CxhHgWvbJ3lr3JH/8=;
        b=XKkArnYEZ49+C4/h9UWH6PT/RD/NscOgZArMTRl12rGC9K0YFWfeLn7T0WO5dGNOJ7
         zYWhlxlXf3wlVFqftreN3kV5SUQG9NK19/VZBVZE7MBzJ6GIjQmvXH3XjmVxvvaW/CPw
         wG1cFi46yF+TZwdXgrKWkIz2uKUBmWTDVsnl9NL2M6BdjgzOZ3MluPyc1hbO8oYacNOa
         OTVOMPEpjuRIMtRu23oQYhrrRy7DCyFA9NTOD7hcnr+NDqYTzmbOkg1+z/lPiiJBR++n
         9VEm/bJ7W5/YHIbRmfR7innTlqvE/qd6WQxeD8xQsLAfwB9BRqLm1g33ghfGWK1gqubH
         o8Vg==
X-Gm-Message-State: AOJu0YyG0Qrq+3ZCzXoCsHyl1O5/6R8XUKP2H3wtnaG2rakkpgAFpLx4
	jXZtMLZ5+wCQYJPSNg0I+ile/7cTlYOsUCBMlPBzhgjxZMwhRw0qDWJdMnDI/jLnDNLAESkzScP
	7OnI=
X-Google-Smtp-Source: AGHT+IEYkpiKzqSc3vHlVquN90payGfqwA1OTKi50YkcN3vyzWbnq0238lOxMTVYy4B5eLaL1CKJnA==
X-Received: by 2002:a05:6102:b11:b0:47c:2a61:ec9 with SMTP id b17-20020a0561020b1100b0047c2a610ec9mr11193291vst.25.1714423379873;
        Mon, 29 Apr 2024 13:42:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o16-20020a0cfa90000000b006a0c3547211sm2161849qvn.37.2024.04.29.13.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:42:59 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:42:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/23] pack-bitmap: pseudo-merge reachability bitmaps
Message-ID: <cover.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Here is a reroll my topic to introduce pseudo-merge bitmaps. Much is
unchanged since last time, but notable changes (in response to Peff's
review of the first five or so patches of this topic) include:

  - Rebased onto 2.45, so this is now based on 'master', which is at
    786a3e4b8d (Git 2.45, 2024-04-29) at the time of writing.

  - Dropped patch 2/24 from the first round as it is no longer
    necessary.

  - Introduced some documentation and fixed a couple of comments
    around ewah_bitmap_is_subset() and bitmap_is_subset() to clarify
    which argument is supposed to be a subset of the other.

Otherwise, a range-diff is included below for convenience. Thanks in
advance for your review!

Taylor Blau (23):
  Documentation/technical: describe pseudo-merge bitmaps format
  ewah: implement `ewah_bitmap_is_subset()`
  pack-bitmap: drop unused `max_bitmaps` parameter
  pack-bitmap: move some initialization to `bitmap_writer_init()`
  pseudo-merge.ch: initial commit
  pack-bitmap-write: support storing pseudo-merge commits
  pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
  pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
  pseudo-merge: implement support for selecting pseudo-merge commits
  pack-bitmap-write.c: select pseudo-merge commits
  pack-bitmap-write.c: write pseudo-merge table
  pack-bitmap: extract `read_bitmap()` function
  pseudo-merge: scaffolding for reads
  pack-bitmap.c: read pseudo-merge extension
  pseudo-merge: implement support for reading pseudo-merge commits
  ewah: implement `ewah_bitmap_popcount()`
  pack-bitmap: implement test helpers for pseudo-merge
  t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
  pack-bitmap.c: use pseudo-merges during traversal
  pack-bitmap: extra trace2 information
  ewah: `bitmap_equals_ewah()`
  pseudo-merge: implement support for finding existing merges
  t/perf: implement performace tests for pseudo-merge bitmaps

 Documentation/config.txt                     |   2 +
 Documentation/config/bitmap-pseudo-merge.txt |  75 ++
 Documentation/technical/bitmap-format.txt    | 205 +++++
 Makefile                                     |   1 +
 builtin/pack-objects.c                       |   3 +-
 ewah/bitmap.c                                |  76 ++
 ewah/ewok.h                                  |   8 +
 midx-write.c                                 |   3 +-
 pack-bitmap-write.c                          | 275 ++++++-
 pack-bitmap.c                                | 359 ++++++++-
 pack-bitmap.h                                |  16 +-
 pseudo-merge.c                               | 739 +++++++++++++++++++
 pseudo-merge.h                               | 218 ++++++
 t/helper/test-bitmap.c                       |  34 +-
 t/perf/p5333-pseudo-merge-bitmaps.sh         |  32 +
 t/t5333-pseudo-merge-bitmaps.sh              | 389 ++++++++++
 t/test-lib-functions.sh                      |  12 +-
 17 files changed, 2386 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/config/bitmap-pseudo-merge.txt
 create mode 100644 pseudo-merge.c
 create mode 100644 pseudo-merge.h
 create mode 100755 t/perf/p5333-pseudo-merge-bitmaps.sh
 create mode 100755 t/t5333-pseudo-merge-bitmaps.sh

Range-diff against v1:
 1:  76e7e3b9cca =  1:  43fd5e35971 Documentation/technical: describe pseudo-merge bitmaps format
 2:  21d8f9dc2b4 <  -:  ----------- config: repo_config_get_expiry()
 3:  1347571ef4c !  2:  290d928325d ewah: implement `ewah_bitmap_is_subset()`
    @@ ewah/bitmap.c: void bitmap_or(struct bitmap *self, const struct bitmap *other)
     +			 * Otherwise, compare the next two pairs of
     +			 * words. If the word from `self` has bit(s) not
     +			 * in the word from `other`, `self` is not a
    -+			 * proper subset of `other`.
    ++			 * subset of `other`.
     +			 */
     +			return 0;
     +		}
    @@ ewah/bitmap.c: void bitmap_or(struct bitmap *self, const struct bitmap *other)
     +	 * If we got to this point, there may be zero or more words
     +	 * remaining in `self`, with no remaining words left in `other`.
     +	 * If there are any bits set in the remaining word(s) in `self`,
    -+	 * then `self` is not a proper subset of `other`.
    ++	 * then `self` is not a subset of `other`.
     +	 */
     +	while (ewah_iterator_next(&word, &it))
     +		if (word)
    @@ ewah/bitmap.c: void bitmap_or(struct bitmap *self, const struct bitmap *other)
      	size_t original_size = self->word_alloc;
     
      ## ewah/ewok.h ##
    -@@ ewah/ewok.h: int bitmap_get(struct bitmap *self, size_t pos);
    +@@ ewah/ewok.h: void bitmap_unset(struct bitmap *self, size_t pos);
    + int bitmap_get(struct bitmap *self, size_t pos);
      void bitmap_free(struct bitmap *self);
      int bitmap_equals(struct bitmap *self, struct bitmap *other);
    ++
    ++/*
    ++ * Both `bitmap_is_subset()` and `ewah_bitmap_is_subset()` return 1 if the set
    ++ * of bits in 'self' are a subset of the bits in 'other'. Returns 0 otherwise.
    ++ */
      int bitmap_is_subset(struct bitmap *self, struct bitmap *other);
     +int ewah_bitmap_is_subset(struct ewah_bitmap *self, struct bitmap *other);
      
 4:  c6a08dae037 !  3:  5160859f7f3 pack-bitmap: drop unused `max_bitmaps` parameter
    @@ builtin/pack-objects.c: static void write_pack_file(void)
      					die(_("failed to write bitmap index"));
      				bitmap_writer_finish(written_list, nr_written,
     
    - ## midx.c ##
    -@@ midx.c: static int write_midx_bitmap(const char *midx_name,
    + ## midx-write.c ##
    +@@ midx-write.c: static int write_midx_bitmap(const char *midx_name,
      	for (i = 0; i < pdata->nr_objects; i++)
      		index[pack_order[i]] = &pdata->objects[i].idx;
      
 5:  a6531656739 !  4:  3d7d930b1c5 pack-bitmap: move some initialization to `bitmap_writer_init()`
    @@ builtin/pack-objects.c: static void write_pack_file(void)
      				bitmap_writer_build_type_index(
      					&to_pack, written_list, nr_written);
     
    - ## midx.c ##
    -@@ midx.c: static int write_midx_bitmap(const char *midx_name,
    + ## midx-write.c ##
    +@@ midx-write.c: static int write_midx_bitmap(const char *midx_name,
      	for (i = 0; i < pdata->nr_objects; i++)
      		index[i] = &pdata->objects[i].idx;
      
 6:  c6f9170af0f =  5:  e7a87cf7d4e pseudo-merge.ch: initial commit
 7:  7acdee2b5f2 =  6:  ee33a703245 pack-bitmap-write: support storing pseudo-merge commits
 8:  4fdd7dda274 =  7:  9c6d09bf874 pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 9:  d74cf3e484d =  8:  dfd4b73d12e pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
10:  323e1250b24 =  9:  86a1e4b8b9b pseudo-merge: implement support for selecting pseudo-merge commits
11:  bf6b0d8601e = 10:  12b432e3a8a pack-bitmap-write.c: select pseudo-merge commits
12:  4c594f3faa8 = 11:  6ce805d061e pack-bitmap-write.c: write pseudo-merge table
13:  7a31a932ab3 = 12:  60f6b310213 pack-bitmap: extract `read_bitmap()` function
14:  7e4d051f37a = 13:  9465313691b pseudo-merge: scaffolding for reads
15:  7bb644b2b0c = 14:  5894f3d5369 pack-bitmap.c: read pseudo-merge extension
16:  792cc863154 = 15:  7dbee8bcbdf pseudo-merge: implement support for reading pseudo-merge commits
17:  8fb7f7ab37b = 16:  09650aa53e9 ewah: implement `ewah_bitmap_popcount()`
18:  c839e1fed15 = 17:  7b5ea56d053 pack-bitmap: implement test helpers for pseudo-merge
19:  7d3b88e6fd6 = 18:  006abdd1698 t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
20:  c18694ade2a = 19:  3f85e5b90f5 pack-bitmap.c: use pseudo-merges during traversal
21:  d38ebeba419 = 20:  5fac186df64 pack-bitmap: extra trace2 information
22:  1eb10c190ba ! 21:  b5aea8e57f8 ewah: `bitmap_equals_ewah()`
    @@ ewah/ewok.h: void bitmap_unset(struct bitmap *self, size_t pos);
      void bitmap_free(struct bitmap *self);
      int bitmap_equals(struct bitmap *self, struct bitmap *other);
     +int bitmap_equals_ewah(struct bitmap *self, struct ewah_bitmap *other);
    - int bitmap_is_subset(struct bitmap *self, struct bitmap *other);
    - int ewah_bitmap_is_subset(struct ewah_bitmap *self, struct bitmap *other);
      
    + /*
    +  * Both `bitmap_is_subset()` and `ewah_bitmap_is_subset()` return 1 if the set
23:  4ae4f0eaae5 = 22:  61ddb574285 pseudo-merge: implement support for finding existing merges
24:  a05ad42202d = 23:  2bd830d35dd t/perf: implement performace tests for pseudo-merge bitmaps

base-commit: 786a3e4b8d754d2b14b1208b98eeb0a554ef19a8
-- 
2.45.0.23.gc6f94b99219
