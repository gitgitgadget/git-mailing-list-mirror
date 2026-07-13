Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826313B5B3
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905113; cv=none; b=C5NdyTeUskSlyY8YNlxv2Ucj/EvooWEe2FINElfB/MiPHTzx3DhZNDjYnpNm9Oqhyorc/yQwebW5TdhjiweBVCLFj5jOST+ckuJmAKl3de9Q1fwX+qcNG4X5f3b0kIIsiCjO0hVtQcHYUMn/pswKO+2jwt7S9sVZxuM2mOrQ0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905113; c=relaxed/simple;
	bh=aT19HDlk/Nh86gaaSOuwCOxsb14QJ3vSlLZ1DWOTV14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MxjYdcq6o7bIOhrGTw5EmS9hP+/7AY49kIUgzZsKOJW6ua9gHHXvzaAtBcgsfWmsSFlxc1BWwH/giI9gg6CMQy8miaqN13SZJvjy9BY72tRhwAtPA9JFPBCKCrgbNM4b2++jVT4K/AE/k7kg53CRIz2Vc/rjAtqEn2sIIsL9NpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=SlEMRB1x; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="SlEMRB1x"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81062fdeaf5so56182897b3.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783905111; x=1784509911; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K48V7iaZ+zLszoIbFidEJqSmPV7PBbcCv/kcn2aoEpg=;
        b=SlEMRB1xdVpzktuO35HnvCN/X2vfCdkjrk+6JMpgcGxtTE+pKiP0h1a6WZfYBJzao8
         XqI3CN0QdxD+O06oSF3aCXImY2vdHJJbQ5gK9cz4p4H6gEjuvVOOi+U0u0nKjdi4g27J
         +WrDkXcyyXYusOK5sGU+U9asZpzHwWZH2KsFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783905111; x=1784509911;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K48V7iaZ+zLszoIbFidEJqSmPV7PBbcCv/kcn2aoEpg=;
        b=OhCx/Aknn4+KmaNZJCPC0voWA3RDMDa/k0p5ySEoqJ//Bqm8yyYxFbxaYbmSb8koCB
         RvqT9tKt8IvQGow1BjV1H6Xs5KhWA0GCFrzPgwH6Lh6fc4WScdKLXwz9R8NOhk+LRi6z
         +fSQRb/+xURr1WX+vuDLCiIPfAEemh8AxSZRKiKHrhpt4DDzpJw/xnfuf/gL3VxkUZS8
         UC1uP1K4N/Hgds5Ab5taodGyZKOavw2Cytgk/bzTVgyVjz2DbqA+GeTLBQijivvJ1qUY
         YyaKTw17ECOpJ4bTQFT1ClYlU79xQHmiNln+ff7uOYjGAHeHwu1sVtvFFJff0XpwgeV9
         MNhw==
X-Gm-Message-State: AOJu0YyVUQseZguRMJh0tP3qnnioJFoz1HYpJ4IPAXVUS+USKpQfWYH6
	3iYTz+Lv10MBEn76A8IM9zILVwgS1xpQBSZlZO+4oyqnse/gBfk7Mo6HvbkCXKUdW7DmYUeRPCi
	K60D5eIC9Mw==
X-Gm-Gg: AfdE7cloxojBSaXn+CIF3E/SOLGgyn7M+F0sRHEtzRwGeNdDJZhagO9YlR7NMLEDY04
	FF5xAjAmP9DZLFj8p5o5KkDQYGmzRnt6KES8su5m/gQBhG3jQGPCp8DhAchqjXCgbeJD3CtuG1l
	3rWhI6+FO7b3kC8G3OfqaYxMt+Io56iLXMjouVX8jIRkSIhGGr3TSY6Ce+PfYQnNbH1z1pYjXRb
	rnrtT4FrVrdAt6Y9dinzDLBLbWm5s7SGmZdCn4rIpR75S6UpIuRhf9nHDtqUX1hRKTk3AZINSwu
	Dn/2eyAVeG4V6+kSOGvFO4Q3Hhod8fmbdT6QzaDAuWzPhil31/NhYEWPa4YgjznXjl2PFbMBBLx
	v5vk0PRUiRjRzW7OHASqeDwtylwqRHFAQHHKybUvTRxe3jYdp2VE5RkfepamTqCLsR0rD/o3i0z
	l/pY+Cw3y0dRwWyYa0Hwzmhw==
X-Received: by 2002:a05:690c:c507:b0:80b:b76d:650 with SMTP id 00721157ae682-81e7bcc3679mr89235757b3.31.1783905111225;
        Sun, 12 Jul 2026 18:11:51 -0700 (PDT)
Received: from com-79390 ([12.187.141.7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1a44e1sm103902127b3.29.2026.07.12.18.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:11:50 -0700 (PDT)
Date: Sun, 12 Jul 2026 18:11:47 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] send-pack: introduce a `no-ref-delta` capability
Message-ID: <alQ7U8TOWjhasaWk@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series teaches 'send-pack' to avoid writing `REF_DELTA` entries
when the receiving end asks it to.

Some 'receive-pack' implementations may wish to retain the incoming pack
without first building an object ID index, in which case requiring delta
bases to appear earlier in the same pack makes them easier to locate.

The new `no-ref-delta` capability is deliberately independent of
`ofs-delta`, and thus asking the sender not to write `REF_DELTA` entries
does not by itself mean that the receiver understands `OFS_DELTA`
entries. The corresponding `pack-objects` option therefore controls
`REF_DELTA` without changing whether `OFS_DELTA` is allowed.

The main complication is reuse. Ordinary delta reuse reuses the
compressed delta instructions, but rewrites the entry header and base
reference. It can therefore write an existing `REF_DELTA` as an
`OFS_DELTA` when `--delta-base-offset` is in effect and the base has
already been written in the output pack. Deltas against preferred or
external thin-pack bases cannot be reused in this way, since those bases
do not appear in the output at all.

Bitmap pack reuse is different, since it copies entries directly from
an existing pack. Under `--no-ref-delta`, it must inspect candidate
objects individually, omit `REF_DELTA` entries from direct pack reuse,
and leave them to the normal object-writing path.

The patches are organized as follows:

 - The first patch teaches 'test-tool pack-deltas' to list each delta's
   representation and base. I originally wrote the series without this,
   but found that writing tests demonstrating which specific *kind* of
   delta representation was chosen to be awkward without having a
   dedicated test helper.

 - The second patch introduces the `--no-ref-delta` option in
   'pack-objects', though initially with delta- and bitmap-reuse
   disabled for the sake of simplicity.

 - The third patch re-enables ordinary delta- and bitmap-reuse where it
   is safe to do so.

 - The final patch advertises and consumes the new `no-ref-delta`
   capability.

Thanks in advance for your review!

Taylor Blau (4):
  t/helper: teach pack-deltas to list delta entries
  pack-objects: introduce `--no-ref-delta`
  pack-objects: support reuse with `--no-ref-delta`
  send-pack: honor `no-ref-delta` capability

 Documentation/git-pack-objects.adoc         |  8 ++-
 Documentation/gitprotocol-capabilities.adoc | 17 ++++-
 builtin/pack-objects.c                      | 29 ++++++--
 builtin/receive-pack.c                      |  5 ++
 pack-bitmap.c                               | 30 +++++---
 pack-bitmap.h                               |  3 +-
 send-pack.c                                 |  4 ++
 send-pack.h                                 |  1 +
 t/helper/test-pack-deltas.c                 | 69 ++++++++++++++++++
 t/t5300-pack-object.sh                      | 79 ++++++++++++++++++++-
 t/t5332-multi-pack-reuse.sh                 | 16 +++++
 t/t5516-fetch-push.sh                       | 14 ++++
 12 files changed, 252 insertions(+), 23 deletions(-)

-- 
2.55.0
