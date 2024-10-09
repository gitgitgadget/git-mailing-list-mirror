Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F591714A4
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505862; cv=none; b=q5aEkhGsDfKjFJ5/Kq6mUG8arKORpv3G+UduC2dWOujHeUjrNJuD1SbBLvLo9G4FWKaWXtco9cQlnPgv0uwzqENxEnrasMoa2nDIw23TJvL7BjDQtyZKM53mEzoOBfDJrdwrt3WRYMe1rJ5bGAEx8kEQ7iuDefTxRmak1JISc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505862; c=relaxed/simple;
	bh=CFHOgzhEZ9InelkvhrRnfeuZK8ZkS/qoWE/JJ8qrDWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ePhBR4mRVxjtvDbbWBcyEAEuAVylGqwodpfNoYN/Mn9f/gNvAwGNtVlAuH1cKpWnmgz1dXvXsVjY+wVZMuRTP3TlY0I4oy0zfAWxgUWGi85ERKpNvTUieSS5LSw1kgBq809hRORTJZu++CoD1Xx9dgbMkcNFT1v8tWt0BSBeK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Cboqxeza; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Cboqxeza"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6dfff346a83so2642747b3.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505859; x=1729110659; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xghHaNfZvUj9sv2AdGzkU8pALWBLhDxT7nFYkUu1Ytk=;
        b=Cboqxeza2kyBKUdSRzzMv7uOjuTrN/dIowf/VNfQJ8gT801FyFL53m5/FqpXyuL130
         QBd5PK11H6+cCuUz7F3GsFzJ9W4vWZDq8MNtPF0q0577H6jh5REMHfwPz5CsDtw8hbXe
         tDzAqsMCcrjAbFAh1rkNn822HHnLH0LemYUxaExykpMN8BhhqmZgUXqBGIv4L01gslJZ
         wbgaPKQyHX31kfxmmBSiA/XlD/4Efp5uTTb3opzX1h03z4DmDZghDJS0qTD9SD36H5Ly
         NgoRucEza65jNsw8tdNXH6inkpwOYDsyjseYXG+fz96eBFFK7IjqXPQHZunUZioUzMar
         2Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505859; x=1729110659;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xghHaNfZvUj9sv2AdGzkU8pALWBLhDxT7nFYkUu1Ytk=;
        b=ExC8Z7fUrs11OAWxyuODqSigK/IWhlO4bJXy8/Qiv3z9R4TzrXn8aHsKt9cfFmwAVH
         mzMLsgtN5d0HKC8rdwJ+zbf/pzuEXiYuJeJGLT3yf5y4l3JsBT520ZLJLQeE/aG3N5Xk
         gALvoL5ldYVLzd5o+KJzVzNj8lZKWKxCh7766usxNiNSm0x1m2r10V8H+vRDPdu3pB4I
         z/Dh/RtXpokTv4lMvYIMFKMFWzqBvIfB1inFGp/A+bCy/OWk7ik8JFMhZ6C/arSj8HNy
         PrllPRsXKvj89rF/VWQE5oWQQ8Wor/NJXOI5CO6GbFj7w9wZQYP6/zeaH7AyKVgefjn3
         ZRcw==
X-Gm-Message-State: AOJu0YzNB6lF7kjPHD6iIX/Bt9WJOa6Cvua6C6e/jo+LXqCq6nluM1hU
	2uowtUlc0OLPn6ragQNWCLwtTIG8NSWSgbN2k+CpVCwW6M+OfmtsXtdtKzOsmZortx6O+DXNHYO
	T8k4=
X-Google-Smtp-Source: AGHT+IGisSlOWhy/SBrJ4lBStgTcIWFSodqOaK0FX4wdECTRNf4nZ1oNNJIkiQmvLslDn02tll9MzA==
X-Received: by 2002:a05:690c:f12:b0:6e2:9c2:5c5c with SMTP id 00721157ae682-6e3221867damr46658687b3.1.1728505859375;
        Wed, 09 Oct 2024 13:30:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d926db78sm19721707b3.25.2024.10.09.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:30:58 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:30:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
Message-ID: <cover.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This patch series enables more objects to be candidates for verbatim
reuse when generating a pack with the aide of reachability bitmaps.

By the end of this series, two new classes of objects are now reuse
candidates which were not before. They are:

  - Cross-pack deltas. In multi-pack bitmaps, if the delta and base
    were selected from different packs, the delta was not reusable.

  - Thin deltas. In both single- and multi-pack bitmaps, we did not
    consider reusing deltas whose base object appears in the 'haves'
    bitmap.

This series teaches the pack-objects machinery to convert cross-pack
and thin deltas to reference deltas so that they may be reused.

The series started off as a couple of patches, each addressing one of
the two classes from the above. But as I started refining these
patches, the series grew longer, as there were a handful of
opportunities to clean up some of the existing pack-reuse bitmap code.

The series is organized as follows:

  - The first seven patches are various cleanups that make the
    pack-reuse code more readable and prepare us to enable delta reuse
    in more situation as above.

      pack-bitmap.c: do not pass `pack_pos` to `try_partial_reuse()`
      pack-bitmap.c: avoid unnecessary `offset_to_pack_pos()`
      pack-bitmap.c: delay calling 'offset_to_pack_pos()'
      pack-bitmap.c: compare `base_offset` to `delta_obj_offset`
      pack-bitmap.c: extract `find_base_bitmap_pos()`
      pack-bitmap: drop `from_midx` field from `bitmapped_pack`
      write_reused_pack_one(): translate bit positions directly

  - The next patch is a test fixup:

      t5332: enable OFS_DELTAs via test_pack_objects_reused

  - The next patch after that enables us to reuse deltas whose base
    appears in another pack:

      pack-bitmap: enable cross-pack delta reuse

  - The final two patches enable the "thin deltas" optimization
    above:

      pack-bitmap.c: record whether the result was filtered
      pack-bitmap: enable reusing deltas with base objects in 'haves' bitmap

I think that the first seven patches are worthwhile on their own. I
considered splitting those out into their own series, but decided
against it to so that we could realize their benefit more readily.

The first optimization (cross-pack deltas) should help clones and
fetches, but the second optimization (thin deltas) will only help
fetches, since the 'haves' bitmap will necessarily be empty for
clones.

Of course, REF_DELTAs have a less compact representation than
OFS_DELTAs, so the resulting packs will trade off some CPU time for a
slightly larger pack. But we're only talking about a handful of extra
bytes, and network bandwidth is pretty cheap, so I think the
optimization is worthwhile here too.

Thanks in advance for your review!

Taylor Blau (11):
  pack-bitmap.c: do not pass `pack_pos` to `try_partial_reuse()`
  pack-bitmap.c: avoid unnecessary `offset_to_pack_pos()`
  pack-bitmap.c: delay calling 'offset_to_pack_pos()'
  pack-bitmap.c: compare `base_offset` to `delta_obj_offset`
  pack-bitmap.c: extract `find_base_bitmap_pos()`
  pack-bitmap: drop `from_midx` field from `bitmapped_pack`
  write_reused_pack_one(): translate bit positions directly
  t5332: enable OFS_DELTAs via test_pack_objects_reused
  pack-bitmap: enable cross-pack delta reuse
  pack-bitmap.c: record whether the result was filtered
  pack-bitmap: enable reusing deltas with base objects in 'haves' bitmap

 builtin/pack-objects.c      | 110 ++++++++++++--------
 midx.c                      |   1 -
 pack-bitmap.c               | 198 ++++++++++++++++++++++++------------
 pack-bitmap.h               |   6 +-
 t/t5332-multi-pack-reuse.sh |  72 ++++++++++++-
 5 files changed, 275 insertions(+), 112 deletions(-)


base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
2.47.0.11.g487258bca34
