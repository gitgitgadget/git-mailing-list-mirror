Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7152EEE9D
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651733; cv=none; b=ub1H1Nr+jLA4u0ZdUHnYdjfg5GhY4tfEIYNYIb/qkcsYdhCkeBtt2CHzaf4SR45H8egdbObyEsiaEThbAMqQBiu7f9I1nEFOHaPWC9YGjcGhDhVqnWup3lv1Xxcm5b0X4NGSCWFyCgkSz6WOCiFSsCKWOQnxmHuc2EYr1L9Fp2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651733; c=relaxed/simple;
	bh=txTzeT85IW8LTOsNEy8uNmwLTovtImTtZsbX3pH4zOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psH87im2uLl3RwZQApircF+sa4abWmnkPNKWtAV8LKbjF1c3+SFZ3q+gX0remj9vDNBVGoB73E5XOgYI9PGVBpLJOjfCl/zOXV19DcaZzMCuQSleOrlK5n2WR4iHJ9tUMlZfIBKqHOMXC/rb/93Zf98fHc33ZKC13VPMObUpOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtyuRt/l; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtyuRt/l"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84830c774a0so176186b3a.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651731; x=1787256531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+DOkgd9F/GLgwkthLMCtFckJi4nPXtEQqsYpueSwJU=;
        b=rtyuRt/lQCmO+otcFovKYduvrNC3A5ienBv7tXQtyojWs4tt47/DpCM5WbLSTIc9ma
         jx33TpN9RM/pa+UG4U5mvJYnS7NS5MEcS9zDeLjBPGNPScfYWtEcQWwqIMRPn2bg2Kiw
         UfPD67rfiwqvcHztdJKYAnNTwMyt7bf2xzOQncvzb0KwqBX0AmH9cRkuYj8uleZ9srG5
         S5roD05gKBRG5mcUTUhPJDgNRvvpxVpPHyyoB+9JPyLpl5iumBwzgpDDNbggDVByARsX
         puS4dHhhD2hS9p4VdsigFOZYSPbI8atZtuGMN5sc2g3pkoJvp7jBvmPStPtWAxP4okVu
         fSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651731; x=1787256531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+DOkgd9F/GLgwkthLMCtFckJi4nPXtEQqsYpueSwJU=;
        b=RmGRpCYHn0XmWfEnv10aSTav8Q6XSiFgISeilaU9NkH4JypS4oP0S/iy6dyaqnO08A
         zVF7H1JPBH5ViBpw2E76bpLJr0u5vfnEOUL/FQC1KyKEkX1IERu3eAfeGi15WZQoQshe
         Y0HS0jc5AykFwmeYE8KU0UQizRAUui26RydXtsMdUIDjPnKv/AsBsKFsM6qo/oi9wYlv
         DhSoB8AJzyW/rqA8ijVp6H8/03bKu6RY/t26EnjqEPtcFDuJONwcVw3eOXDsfQKVIsos
         cNDthujlqQgigzk7cOQuxHqZE0ckkjppphY/D0vM7zxRn2kndn/K6GXPbvL3nhw3VEhs
         L2MQ==
X-Gm-Message-State: AOJu0Yy0lOaLncxYhNMgUUQcNZDMSOcjM5yLiumWXvaYHVKJUknGSCms
	DG9FyDnreVBox9QHfWQPc3CyoKFb4KwYRlaVkphig95CDcHxW0FrCBK/L97C8O0o
X-Gm-Gg: AR+sD10cnK4KgjBkScSYrgN/GZvXmlfisjF9T9qDpVipSrfYWmRSnTphAXzOZnwYT9x
	XHWM2zfMeUGGxYr2w9m3lRbKJZMlziKU5FiOOu90UTPf6l0vM7Da+8NoM1tvSfX9FujM6bEo3rj
	9ODJTXBeO/7zJ6Of9gBUNb1Oz2oM+ua+PvEJfZ7Q6u90KGcp6QwCgQiFQ11uIkrIL9j+9E5lnDK
	k+bPVncibExTvSO+QdlyAAQQKWLxQ/tvt3lF6bR/u1n/EiNe9xfO2racRIMhNvpp9qxleK9GW0X
	rLx4YhMGZsQk20MPrqcCQIM9V1T/9E+EV4Jh9TZYBwfxrcPjXey5vnYaNnly0IJlNuRDFgUn+gj
	SK3Ynse5J7Hb6S0htk7bGcxuEmk9PWghtauHAj8Zs2dzZcoIaDQvA0wTPlOBHaJz9hx7nck4QQI
	NWe4cBlKXXCpeWYbtwNiBdeurJ6MeIEvH2DNprKqTQIgZQXFyUFn1Y6dv6i2rqTb2FGbY64b+Sa
	Km0jPcrYyzPVNc4G5OZFuzgvV1lshfP9MIfXPjNXS8+vFchl0UUsxM8uMxcIKDQm/mSfqWrR6iX
	8g0TqIemz1KHNzb0IX1zjw==
X-Received: by 2002:a05:6300:6708:b0:3b4:6026:6c5d with SMTP id adf61e73a8af0-3cc7196e726mr413624637.5.1786651730599;
        Thu, 13 Aug 2026 13:08:50 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:ad47:4055:841d:89ad:96b0:2f73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm1533440c88.6.2026.08.13.13.08.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 13:08:50 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v5 0/6] repack: add --drop-filtered to reclaim space in partial clones
Date: Fri, 14 Aug 2026 01:38:24 +0530
Message-ID: <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v5. v4 was at [1].

Partial clones let you work with large repositories without downloading
every blob up front. Missing blobs are lazily fetched from the promisor
remote on demand. Over time these accumulate locally and there is
currently no safe, built-in way to reclaim that space short of
re-cloning. This series adds that reverse direction: enumerate promisor
blobs over a size threshold, drop them locally, and rely on the existing
lazy-fetch machinery to bring them back transparently when needed.

How it works:
  * Enumerate promisor objects directly (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)
    and select the blobs exceeding the filter threshold. Every enumerated
    object is a promisor object, so it is recoverable from the promisor
    remote as long as the remote still has it, the same assumption the
    rest of partial clone relies on.
  * Rebuild the promisor pack without the selected blobs, reusing the
    existing repack machinery, so the drop is crash-safe (write, fsync,
    install, then delete the old pack).
  * --dry-run lists the candidates and changes nothing.

The guards refuse to run while a merge, rebase, am, cherry-pick, revert,
or bisect is in progress, and refuse to drop a blob referenced by the
current index. Dropped objects stay recoverable via lazy fetch, so these
are a convenience (avoid pointless re-fetch and a surprising
mid-operation fetch) rather than a correctness measure. Both are skipped
for bare repositories.

Changes since v4:
  * list-objects-filter: fixed the object-size local from "unsigned
    long" to "size_t" to match object_info.sizep - caught by Junio
  * list-objects-filter: made the filter options parameter const and
    dropped the now-unnecessary cast at the call site - caught by Christian
  * repack-filtered: comment fixes
  * squashed the documentation into the patches it describes: the option
    description now lands with "actually drop filtered promisor blobs"
    and the guards paragraph with "add guards for --drop-filtered",
    dropping the separate documentation patch, so the series is now 6
    patches - Suggested by Christian
  * improved the "operation in progress" error message to name the
    operations (merge, rebase, am, cherry-pick, revert, or bisect)
  * swept test comments to be proper sentences and fixed tab or space
    indentation

To do:
  * remote verification: verifying against the remote awaits the
    "remote-object-info" cat-file protocol command
  * recency: a "don't cull recently-fetched objects" rule as another
    selection criterion alongside size
  * drop log: introduce with the error-path change that reads it

[1] https://lore.kernel.org/git/20260810174047.6524-1-r.siddharth.shrimali@gmail.com/

Siddharth Shrimali (6):
  builtin/repack: add --drop-filtered and --dry-run options
  list-objects-filter: add list_objects_filter__filter_oidset()
  repack-promisor: allow excluding objects from the rebuilt promisor
    pack
  builtin/repack: enumerate promisor blobs for --drop-filtered
  builtin/repack: actually drop filtered promisor blobs
  builtin/repack: add guards for --drop-filtered

 Documentation/git-repack.adoc   |  37 +++++++
 builtin/repack.c                | 154 +++++++++++++++++++++++++-
 list-objects-filter.c           |  45 ++++++++
 list-objects-filter.h           |  16 +++
 repack-filtered.c               |  82 ++++++++++++++
 repack-promisor.c               |  15 ++-
 repack.h                        |   8 +-
 t/meson.build                   |   1 +
 t/t7706-repack-drop-filtered.sh | 185 ++++++++++++++++++++++++++++++++
 9 files changed, 536 insertions(+), 7 deletions(-)
 create mode 100755 t/t7706-repack-drop-filtered.sh

-- 
2.54.0

