Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC84C78685
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734161; cv=none; b=C5oZBIPCaUVuNTavwSSUVBoZCAG9PE5CPyvXw2ZWMWLENl2RgysX4iM/oMzPPTr1EwWTV0QzDOaBMtjN4pvOACIn5Dr30d6BbcmgxTxXkNVR/jrrZ024QPdcr/WHapxu0a3Bu6RAZ+7/L34c9BSyvm6HAW1bE+TRY55klQ2aeTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734161; c=relaxed/simple;
	bh=7+5uWZiuB5wyYaBVyMijVh8jdRewuGFoujx/v1/BjLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPaY9IlQVq4u8M2rNiM4dtQW07rJ4z654fo6h0MOF2w0edMMBQ28sX1buIo4FpbW8c/rwazzfXLiIF/S6B+kx9gjdSGLSsjZQoiiu6MeczaHqSg2yM2cU40P+YJf97RgP+qqfbBNYUGod0Yao8f+JKOStvB3umPi2dtB9NVpevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ot8nISbV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ot8nISbV"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea8419a57eso15776627b3.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 07:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730734159; x=1731338959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHr2PYjUMWXEAmXOSs6PJ+jOsnvA9JFBZym10qvploc=;
        b=Ot8nISbV4OccDtaBpwDvVHr3SU4IJ/XipN7NnXOBZowMaX+Fjkplj3P9MwvINj1Wtu
         qnsovNOZMarTUIsrdmzXCnbexhbvDPLuUGMfFQ3gn1w4q9kFvHCiGZSYhTdjdvcq09B7
         9XELcu8igHQvgYcwKRSwiKL3VrsAdG0o7IY9fjNrrOvn0LRL77sjb+FpbJbdBcJooHfb
         /C2xPky79/rKeDbipwp/AT9rjinlmIZifDT+WvP28k6SAikZ2MEBJ4ausyXkv0BkV+Jf
         R4sJkcffRuwrVVqQeFvh8A/OKCUorTMYK5YtARxeOe4+iDNPlHiTsG3r2dsQ3xEeHFB/
         U8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730734159; x=1731338959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHr2PYjUMWXEAmXOSs6PJ+jOsnvA9JFBZym10qvploc=;
        b=aw6SPTHDaPuM5c2GZZW5wRyXyGJZwNGZMHmI2jycxdPyPOGkA5MM/u2KB8k7g8CCMI
         4PcUX/6xXad2Z4vEx/rZ73BDe0dkLi2LFOpPUXNCYpN2TDpzcgPeeeDkAz0g0wOw9K7j
         glScdoItgeCl6Bs5Wg6aDSuZAeIanEOE1i1bsHnluAV0xU7GnRpdtFv5V++7EUNkcavg
         3j5w6JS8L5x1YDWHP7nIxHRh1/8RuANZn/JVjGBjciwbSoIeFKKN6ydojwneuDOztrtj
         jVPgMF6TxqA0RyXBK2zY7QdBEcUK6zh+nRBQBq+S8+vsHJ37ox//3H1lfuIbgvQLqLV1
         cLBQ==
X-Gm-Message-State: AOJu0YxsTv/jdB8cH8zt5a45zfjTkoAqOCOcPGreVUeL7ttBLLdfV09f
	kZSGzBi0VF+GpeaIwN3v1IP/Tm/VY6nI9fb5Cz91ry5SAPg0IeX9E0nzgtTV/U6L6P1AaXclHNP
	fQEU=
X-Google-Smtp-Source: AGHT+IHxykYxf4VOm5KmmuiKQ2MQVsbzWq60fle9EKYXZ7RC+/uKWI8SZ6U9feAUb5INca+VJTp9Qw==
X-Received: by 2002:a05:690c:c15:b0:6e3:1781:1e2b with SMTP id 00721157ae682-6e9d893fb2dmr334667547b3.16.1730734158810;
        Mon, 04 Nov 2024 07:29:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c83723sm18090007b3.106.2024.11.04.07.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:29:18 -0800 (PST)
Date: Mon, 4 Nov 2024 10:29:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #02; Fri, 1)
Message-ID: <ZyjoTVhP0xn/Qcvx@nand.local>
References: <xmqqr07rwsmd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr07rwsmd.fsf@gitster.g>

On Sun, Nov 03, 2024 at 08:05:46PM -0800, Junio C Hamano wrote:
> Thanks everybody, especially Taylor, for keeping things going while
> I was away.  Unfortunately, we seem to have acquired way too many
> topics that were posted and picked up without getting reviewed.  As
> we discussed a few months ago in <xmqqployf6z5.fsf@gitster.g>, I'll
> start discarding topics that have seen no activities for 3 or more
> weeks.  Interested parties can of course revive these topics.

Welcome back, and thanks for trusting me to keep the patches moving
between integration branches while you were gone.

> With all the integration branches and topics broken out:
>
> 	https://github.com/gitster/git/

Now that we are no longer referring to my tree here to list the
broken-out topics, I have cleaned out topics besides my own that would
ordinarily reside in this tree.

> [Graduated to 'master']
>
> * ds/path-walk-1 (2024-10-31) 6 commits
>  - path-walk: mark trees and blobs as UNINTERESTING
>  - path-walk: visit tags and cached objects
>  - path-walk: allow consumer to specify object types
>  - t6601: add helper for testing path-walk API
>  - test-lib-functions: add test_cmp_sorted
>  - path-walk: introduce an object walk by path
>
>  Introduce a new API to visit objects in batches based on a common
>  path, or by type.
>
>  Under discussion.
>  cf. <ZyUqr/wb5K4Og9j9@nand.local>
>  source: <pull.1818.git.1730356023.gitgitgadget@gmail.com>

This is marked as "Graduated to 'master'", although I suspect it isn't.
I thought that it would have been because the topic went away, although
I still see this in 'jch' via your 3503a15e17 (Merge branch
'kh/bundle-docs' into jch, 2024-11-03).

Perhaps this WC report was generated before moving the topic back into
'jch'? In either event, as noted by <ZyUqr/wb5K4Og9j9@nand.local>, this
topic is still under discussion and is not ready to be merged (yet).

> * tb/cross-pack-delta-reuse (2024-10-11) 11 commits
>  . pack-bitmap: enable reusing deltas with base objects in 'haves' bitmap
>  . pack-bitmap.c: record whether the result was filtered
>  . pack-bitmap: enable cross-pack delta reuse
>  . t5332: enable OFS_DELTAs via test_pack_objects_reused
>  . write_reused_pack_one(): translate bit positions directly
>  . pack-bitmap: drop `from_midx` field from `bitmapped_pack`
>  . pack-bitmap.c: extract `find_base_bitmap_pos()`
>  . pack-bitmap.c: compare `base_offset` to `delta_obj_offset`
>  . pack-bitmap.c: delay calling 'offset_to_pack_pos()'
>  . pack-bitmap.c: avoid unnecessary `offset_to_pack_pos()`
>  . pack-bitmap.c: do not pass `pack_pos` to `try_partial_reuse()`
>
>  Allow pack-objects to reuse an existing delta in a packfile, when
>  it ends up sending the base object from a different packfile.
>
>  Needs review.
>  source: <cover.1728505840.git.me@ttaylorr.com>

This topic was ejected, which is fine since it hasn't seen any review in
a few weeks. It's on my list of things to resend.

> * tb/incremental-midx-part-2 (2024-10-04) 17 commits
>  . fixup! pack-bitmap.c: open and store incremental bitmap layers
>  . fixup! midx: implement writing incremental MIDX bitmaps
>  . midx: implement writing incremental MIDX bitmaps
>  . pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
>  . pack-bitmap.c: keep track of each layer's type bitmaps
>  . ewah: implement `struct ewah_or_iterator`
>  . pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
>  . pack-bitmap.c: compute disk-usage with incremental MIDXs
>  . pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
>  . pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
>  . pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
>  . pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
>  . pack-bitmap.c: open and store incremental bitmap layers
>  . pack-revindex: prepare for incremental MIDX bitmaps
>  . Documentation: describe incremental MIDX bitmaps
>  . Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
>  . Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2
>
>  Incremental updates of multi-pack index files.
>
>  Needs review.
>  source: <cover.1723760847.git.me@ttaylorr.com>
>  source: <ZwBsbW5jsFw0mxKk@nand.local>

Ditto.

Thanks,
Taylor
