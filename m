Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB4446078
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433345; cv=none; b=stSmQRwKMSLomhwmbK1YR1fqEV+2SnSqupN6OTlUYdqGP7wbUQFgJ5eK3ZLE/k98O+WQjeSo0rib/K9J8ZJ7Kv3xMnT7EevmsPaOBZPJZngEnCLY2xztMTwCTRCN1+MvT2F+VFc4i0sobza3tWdzxaoPr3Mmn2lA/cpZiHcgDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433345; c=relaxed/simple;
	bh=fznAuerBE6MrfkuwpJqv5P0xQ3ic37razD4Fgkb5l7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7rZhZqmovoHvK9YLJG/2yxV1swve/tgTuGqDoYwf8mBk7vR2kHP8ru6YLjbPFACGm9ULv5OpwYdUHSks7W4YKgxGJlKbrAQ+MhKhIN2MvgOucgiGZKfRoGPY6Vl27wfuNrKkq3cVF1YWfPyK3+e0FcCHTTS4uLaB/8eNhUz/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8PAOXFN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8PAOXFN"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so36800a12.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433342; x=1786038142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHT0yvibd8BWmokYs4PZN9QNJbE/CR3At7CPU8vv/LE=;
        b=c8PAOXFNrmKVl+jxrQExbngzY7GwL/CTtkT3ZX2z0a23/xWMGtNC87vGz5dnnxuv+y
         tLDIfWZXKx+ZUjCDTzfne/sN4i657YaIjcWMpv0ehIly0nJUmJJlMqecIf2e2YBfa9OQ
         rVdBNLGziNNIZWd6DCQOu8ikk1OIEjuowv+LVOuKM34N8XLal57BKxV9bMhUOKasiD3B
         pLiOTP/4N1H0s2otkMSIajBjok7JhJCN8bvVQrzFgwqhhFzpvvb0sx1OEXuqESWJuj1E
         MndCtKZ6LAT5T6hJeqIk3QQDxL3IX4Fifqw4gG2bZEcQGnK1LsmVGWpwN5G7eC2wp2Mh
         Imiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433342; x=1786038142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VHT0yvibd8BWmokYs4PZN9QNJbE/CR3At7CPU8vv/LE=;
        b=AvXCgR47bWjw32qtEj5vVOv+NJN02gGwYoscwmXuNUe12cKXI8EKkAafPC2mK9SEVC
         VoMIvTC29p5VNJAnf/7EImO+ZaKbznlaJ8Bm6cgw6l3MSt47Fq+Jts+J1ZndaJvMPXqu
         3y22HQGUK24wvgdEpOoZnN9ipHzSngH8+IBueZ/oHlh3aoQFaRn1JM4xv5gBIHSWwXT7
         IZyXNChFibJ+dSrXD8+OXAG0xgYtJPg7J0EpTlfCxYJxn0FxvH14Pe2I81aukiYVsv3+
         hS7UT/mlCI3iQ67BqtJLsc6TulDobqYJzVXWo5Vvxo78h3pYYr4LwwF+QRgKMnG2rvVY
         a0eQ==
X-Gm-Message-State: AOJu0Yx7EkVuRQmo1Q66YiwoiSI7kxv81zOMmsZReuMzyuqOkoHEcYSt
	Jr8aa5iS4uEUlmYYJ86WU9576Qj6IC6UHwrLhUTZEtfuZSmUhSSyQZv/nbXMWA==
X-Gm-Gg: AR+sD10ZGDJZr0WUp1p+Y9tmLVnuLkFXP3xfNkFgDsZoZAJnMY6AgRqIdAOSc9AqS8n
	Rx4/gNk6pfCi7Kcruz+Y5aVR0WI85+PAbH0Ghmz9Uf+VfEP/kNJ7cE2vo5qXL79c703mvt0YLV5
	oY4+Isl4iHsie2Vg10g5ME4jKswC/77STRrIC7orsi6XM7HE2/NVBrbtT1WpLUn/aWuTSj6IY4o
	crbaJ63eLygOdbmhYdDApBKLvnB81gMFNcoCLuH6r53N+OtOiH7nI29MS/BO1uLnsZYqIcjfld1
	JpnaVEdSV++iuVC/g/WHCOb7vN2BNbBdQyUHatY9jmfZNnh4STdAR/FeDKJe1dVYpgRd5PoULPa
	1MaPy9uVFDZOkvHwNN3PyOcdLB9D79LbNg4pIWxzK1vNOHwCKT1Z47TTiTz+kbZ0fyW869wP87W
	OV5gUGrCLrd3I93hPAp2BZi51DCEvIaOHMl8FYZKax6lRzwA+veIw4LiCrpb0/PA7AR/WRPWTuG
	QUpSJQT9DWj7c2h1X1aGaFDTVE+Knzlf2sngEn1ITMpSr0NZZ6qJuMMnz6AbKH5+q8j2TWpq00B
	fJsbG/OszZNxxDZcSSbw5FUMqjEbktNmfhYKlA==
X-Received: by 2002:a05:6a20:428b:b0:3bf:7498:9cd1 with SMTP id adf61e73a8af0-3c90085d18emr3619279637.45.1785433341675;
        Thu, 30 Jul 2026 10:42:21 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5622:d88b:20c4:5444:d41a:b6c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm25163964eec.14.2026.07.30.10.42.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 10:42:21 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v2 0/7] repack: add --drop-filtered to reclaim space in partial clones
Date: Thu, 30 Jul 2026 23:11:46 +0530
Message-ID: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the series adding "git repack --drop-filtered" to reclaim
disk space in partial clones by dropping large, locally-held promisor
blobs that remain recoverable from the promisor remote. v1 was sent as
an RFC [1].

Partial clones let you work with large repositories without downloading
every blob up front. Mising blobs are lazily fetched from the promisor
remote on demand. Over time these accumulate locally and there is
currently no safe, built-in way to reclaim that space short of
re-cloning. This series adds that reverse direction: enumerate promisor
blobs over a size threshold, drop them locally, and rely on the existing
lazy-fetch machinery to bring them back transparently when needed.

How it works:
  * Enumerate promisor objects directly (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)
    and select the blobs exceeding the filter threshold. Every enumerated
    object is a promisor object by construction, so it is guaranteed
    recoverable and locally-created objects are never candidates.
  * Rebuild the promisor pack without the selected blobs, reusing the
    existing repack machinery, so the drop is crash-safe (write, fsync,
    install, then delete the old pack).
  * --dry-run lists the candidates and changes nothing.

Safety guards refuse to run while a merge, rebase, am, cherry-pick,
revert, or bisect is in progress, and refuse to drop a blob referenced
by the current index (it would only be lazily re-fetched by the next
worktree command). Both are skipped for bare repositories.

Changes since v1:
  * distinguish an explicit -b/--write-bitmap-index on the command line
    (reported as a conflict) from a repack.writeBitmaps config value
    (silently disabled for the command). This addresses Junio's review
    that the previous check could not tell the two apart
  * documented the choice to keep --dry-run as a separate option rather
    than --drop-filtered=<mode>
  * implemented the safety guards
  * Added git-repack documentation for --drop-filtered and --dry-run
  * Reorganised so enumerate_promisor_blobs() is introduced in its final
    signature
  * Distributed the tests into the commits that introduce each behavior,
    instead of a single standalone test commit.
  * Dropped the drop-log commit from this series

To do:
  * Remote verification: verifying against the remote awaits the "remote-object-info"
    cat-file protocol command.
  * Drop log: introduce with the error-path change that reads it.
  * --verbose: space-reclaimed reporting.

[1] https://lore.kernel.org/git/20260716132848.95982-1-r.siddharth.shrimali@gmail.com/

Siddharth Shrimali (7):
  builtin/repack.c: add --drop-filtered and --dry-run options
  list-objects-filter: add list_objects_filter__filter_oidset()
  repack-promisor: allow excluding objects from the rebuilt promisor
    pack
  builtin/repack: enumerate promisor blobs for --drop-filtered
  builtin/repack: actually drop filtered promisor blobs
  builtin/repack: add safety guards for --drop-filtered
  Documentation/git-repack: document --drop-filtered and --dry-run

 Documentation/git-repack.adoc   |  35 +++++++
 builtin/repack.c                | 135 +++++++++++++++++++++++-
 list-objects-filter.c           |  45 ++++++++
 list-objects-filter.h           |  16 +++
 repack-filtered.c               |  81 +++++++++++++++
 repack-promisor.c               |  15 ++-
 repack.h                        |   8 +-
 t/meson.build                   |   1 +
 t/t7706-repack-drop-filtered.sh | 179 ++++++++++++++++++++++++++++++++
 9 files changed, 511 insertions(+), 4 deletions(-)
 create mode 100755 t/t7706-repack-drop-filtered.sh

-- 
2.54.0

