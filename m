Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7313CE4A3
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927155; cv=none; b=UZhqMKJm62/G00UPLjP45/8+bJk1wDVsOw8npXTsKyJV1giOL9Ujc9fTxjRt2jhgOYZ2ihMVoUdi/bi/+TgMxiYDj87ymiPNCD7Es7xJzWHKUeEkw1rEBO0IOcO3xi7+3NWZxgarxuOOsL7xlAWIjHoL0ZJF5CdUYyNoUOWWwqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927155; c=relaxed/simple;
	bh=H+EiYhHJPEfx18JWfOjkW4hLlkhnNcM0jHocPokDpsg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IWfSUvY1L5ZHr3FXXEfqvFHZDglf2Nm/L7tnJ+U7vKys68jn4K7cP5Tw+BfcTz+vtJ5hMbOXVzTkOXWc4Ct4uJA5kw9yCibyxTaHXIJO8LLQh4Sx1tJE81gOkhty+gui7t/8JYKGz5ooIYVDpH0+SPQFPhvahDSaJHdLlkamR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=HesxmqRj; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="HesxmqRj"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7ff05e5d009so7110417b3.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784927148; x=1785531948; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4X79eGpC7JyrbPOX8b0oQqku7VADV4iZGcLtSWkqLMg=;
        b=HesxmqRj6Gav3Yc/ba6eeg5IkUqe+UeENzN0vA+NMMmpvBRClKinR2iG1vOS2xibk1
         AdZOw+19010Upn7+oEUbfCbL7y79JKGAx5lGf7q1rTtu/1/W5Ce19ZKDCI/cdaQFbHim
         Ckzogwm9c9NH+CEVCr1Lp+AU2g3qa8uEVyj+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927148; x=1785531948;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4X79eGpC7JyrbPOX8b0oQqku7VADV4iZGcLtSWkqLMg=;
        b=cKY5DBibgqPbtK4nGbd9jFtE+2aATtHoEHDqLqbTuHTIAnKrFBe6+BCklTbIc+i/rq
         tOIcFVOuWOhrHp+7qZX8vhw8u2dB1AAepgFjwwGUCUQ5OQ75npayO02aoJsXYOgkwsH0
         abqB/soGM/SIAVNQRDVdYQ605sNf42/BsRpNISWfodlrHY4QlaJxtJzgHSZ831Dca0MK
         Kav1bF4R6lwAPFEYCZcWJbCdXPNE4GPjDCmKcwRVlI3cP06OZ/4K60iv34WzQ3ldWXa/
         V+0ASZtXPAPmaq7UJCWAe0CM9+FT+8RI6V73XOQ/SULGkToZy1TMbWi8mgHbomA/uYLN
         3PHQ==
X-Gm-Message-State: AOJu0YyStOoY1d3nh8zH50UF5gc5iIpoJv+jVKT1ciqwxbqezxTUOJ74
	TfbnbcFoOvL+sJzz6s2WPE5/Cgvh5Rosl2hZxMdOr1q1UT32Jvk07PciGR+UGjT5rAGVUL9tNXp
	Tp/7oTbw=
X-Gm-Gg: AR+sD13i7E3iwygkZILXg858LhWp9PozNMwc1IpWMUO0BSu4y3lXOPboGIUDIvTTPJW
	dyuX5bHKfO1DgNOzm5afpTqs/qawd0g3u8p78HCDwBT8fZh0YK0R7VCYA0ZAPSMwkV6Z6heGUC5
	KYO6xG9MUtO1kKuLvH7aBeDQgauMxniE/yuBKXbkQKq4mpELuPz8ki/t7YMHSKiPApTFSST65A3
	OzojXDQ9spaHeiHW0oCoJ+guvsK2fCFxJkZB1Lt0FcnNS6cVtMHWB8oZlq83/oI8t6nYr4Ax/dx
	ecSJRAOHO9iqiBBXGXJLpE5RGK0s96fjv7sfG/SX05fXvwWZVzD39BmyZce1sF4zDOOW1Xofp+n
	bYUIB6ocT/vyH3DOsrItMxM5t+hRwow2A5PjCICtqtsIxMjdvbt946bNcp4n6rZghYE7z21mXUZ
	2zqhDCcHaBU4/fXoMV41a3bNLZJ+8zOSuu5nWmcOuaSmoKsxoKalgbEllahJ52yO+xTmWZHsC8q
	gd6j0YdVUwgSlE6CpagKacxzmA9O1HzDk5OAA7VGZaqIZbuJLICGYc=
X-Received: by 2002:a05:690c:620d:b0:809:fd83:a88b with SMTP id 00721157ae682-81f69ccf38amr369117b3.3.1784927147791;
        Fri, 24 Jul 2026 14:05:47 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657cf02dsm5801517b3.22.2026.07.24.14.05.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:05:47 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:05:44 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [PATCH 0/5] packfile: harden handling of packs with duplicate entries
Message-ID: <cover.1784927134.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Packfiles containing duplicate object entries are unusual, but Git
already accepts them outside of strict indexing. Both pack indexes and
reverse indexes maintain a 1-to-1 mapping between themselves and the
physical layout of objects in the pack (including duplicate).

While testing packs containing duplicate objects with MIDXs and MIDX
bitmaps, I found various bugs which are addressed by this series. It is
organized as follows:

- The first patch establishes that reverse indexes already do the right
  thing: they retain duplicate .idx rows. So asking cat-file to produce
  the on-disk size of some object with '%(objectsize:disk)' produces the
  right answer (even in cases like asking for the on-disk size of object
  'B' in a pack layout like [A, B, A, C]).

- The second fixes a bug exposed when ordinary 'REF_DELTA' lookup
  chooses a duplicate representation of some object that creates a
  cycle, even when a different copy of that same object could resolve
  the delta chain without cycles.

  Importantly, we only take the more expensive path after the usual
  lookup encounters a cycle, which should hopefully be rare.

The remaining patches deal with miscellaneous MIDX and bitmap consumers
which are sensitive to packs containing duplicate objects:

 - MIDX verification can now accept any copy of a duplicate object
   (keyed by its OID *only*, as opposed to an (OID, offset) pair).

 - The 'bitmap' test helper now cleanly die()s when trying to write a
   bitmap for packs containing duplicate objects, since the bitmap
   writer cannot tolerate single pack bitmaps with duplicate objects.

 - Finally, multi-pack reuse stops treating pseudo-pack[^1] positions as
   physical pack positions when a pack contains duplicate entries. It
   disables optional fast paths when their mapping cannot be proven and
   uses the existing per-object path otherwise.

This does not change index-pack's duplicate policy or make duplicate
entries a preferred pack format. It makes existing non-strict packs
readable, verifiable, and safe for bitmap-assisted packing while keeping
ordinary packs on their current paths.

Thanks,
Taylor

[^1]: This is a good example of the types of problems this series
  addresses. We currently assume that all objects in a MIDX's preferred
  pack have a unique bit position, which is the same as their
  pack-relative position. That assumption is safe as a consequence of
  how the pseudo-pack ordering is defined, but *only* when the pack in
  question contains no duplicate object entries.

Taylor Blau (5):
  t5308: test reverse indexes with duplicate objects
  packfile: recover delta cycles through duplicate entries
  midx: verify duplicate pack entries by OID and offset
  test-tool bitmap: reject packs with duplicate objects
  pack-bitmap: handle duplicate pack entries during MIDX reuse

 builtin/pack-objects.c            |  24 ++--
 midx.c                            |  59 +++++++--
 pack-bitmap.c                     |  27 +++-
 packfile.c                        | 199 ++++++++++++++++++++++++++++++
 t/helper/test-bitmap.c            |   3 +
 t/helper/test-find-pack.c         |  18 ++-
 t/t5308-pack-detect-duplicates.sh |  60 +++++++++
 t/t5309-pack-delta-cycles.sh      | 148 +++++++++++++++++++++-
 t/t5332-multi-pack-reuse.sh       |  89 +++++++++++++
 9 files changed, 595 insertions(+), 32 deletions(-)


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
-- 
2.55.0.383.gde07827a19
