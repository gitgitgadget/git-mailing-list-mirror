Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142B3BBFD4
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385487; cv=none; b=a1batzfeYzTLEqFZi8mudi4CJKHBDT2X3rgKqpnGzZm2XDpKrSx1XM8ZvKrszNRcWf6PH2rBaFDruL1k247hDqyXvMLfm0fnQTTFELjphg5WfFrgDJ0+VTzNJyiotEflZqscYsHIua8+W6ddpLYg4AjnpHuhXhEQ7h0JZQrYDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385487; c=relaxed/simple;
	bh=Vv0uWPxJ9ZHy0G8nO3N+4R4MCuRZhqwulSYpBQoxT90=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=tLKhSICfI7nNRvWIQWQzvKNHmmfTPGpeaFtAbeV+ETlOdbiu6NXSeK9WvWTvZ73EEUmbdc9XfhiXpX/1ESMMEAhA5hGVZXOTN4xS7jUBE3hgrt7yTtESW31bBxYyMK3Im5YSA5pCQQoua9Iv5wmvnDraPwCj8Kq0b3FHEEGMevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIIfy6fQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIIfy6fQ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-86a25369f16so2415760b3a.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385486; x=1789990286; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yHxB6x6ZX/Tcg9GcNB1BrUvgyQvIRhDKTgN66uP/v1U=;
        b=ZIIfy6fQPqGBRIpufjQuPLs2c3QtetUbyEbrzC2ZdZqshvOdfRs5+SE+CJkUZ1Vtmw
         8CMuDGRlQOk4d9qO9/tZNeN9TXk7GyyfEg6vtNQYivbgN6xxjBVo3c+WLFb+3tOBLTin
         pApNUN9MHVVeEPFIM4axrlmzexPIhwaa4PogOzL0ST6xPRvqXM5yhhYN2FkWDmn0gZCP
         dJPyozihfcX0oiNXcU5k3JtQr1qePG/IR/QmYdYWZmScORTz6LfFjNEMYoPHVJuyl0UM
         MjjQ/5JhCtHQXy1prE7lyqEti3M+7P7OfBjWGSpqU3kiaS3nxdKeT6FrQYjPQ2xTh9K7
         oeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385486; x=1789990286;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yHxB6x6ZX/Tcg9GcNB1BrUvgyQvIRhDKTgN66uP/v1U=;
        b=jhPgywDc0SURWjJ4OyIlBwnTHmoJDq18Xux2CFyfv7X6VIjEmWVsuYuXbjNveS6RwY
         +3S8hwQPZ0mcGxAoqgY5s39aHVoo4CmPArptw+7YCBy+GI5pBTgVxHIsHs+R0+VRAw00
         2RjhKVLPQXJ4H5Lm7e646gDO+0oHXoQgv9fGTOQsOOlcoRJYy7o+3/1m4a2ji+BIorYO
         nwDg3PT6328+GWMpa5hvF9eU9DQHvxAdh51wvzlzq4Nwy3ECm0oXWvg7+hEjFCZFfsX3
         B3MpwHSYg+PvDc+mYEtRrB2ZeSW6B2ao3lImwGhr7C91dmfO7Jm9pnbK2zFmGa+8y0PT
         /sJw==
X-Gm-Message-State: AFuF++nPHt04hS/MzCDr611xX+0ND09rDOYqRU5JmrTv0XTEvqfk5N7o
	6vE/iNoIpcz0IMe3+kSirTikQBvyNXtG1eeRtaCh0AFqsb5F8VTry+pRUIyM6w==
X-Gm-Gg: AYBFou3mjje3eDtJL7Usp3ZnI24jE6cic1US7MZRxkSJICcNZhH5y5p8dhAvBTB7ENn
	RN7jcnG7bIa2TBTVeZq3fGry2Y4Tnbzeovhv06MJAxvsCIYETFnfo25Q+/tTF/uoC+U8JnK4zEJ
	iLdgKoG03R1XDh0jGXFqHhUSYEObVWvMGaa8JtGzTVZ8VwAskDuIPMf9fJQ+LAphaFzRn2DB2y5
	39yUmCpUxa003AbW7PgxwoJvLYKfAr20AyEQZfwG0wf/7GXWrjgHJG0NFM0iJr7ySBY4ak8yVRY
	vP2NM/FNwGWy48GMnyG2STcbCC9VVOUo4u46N1CCYj+TbLNIlFhBA6THvyumneQqDRH4gt6h4bK
	NNZ8lHPuWwt2EulDTfHXRs8/LZ5bXaxt2pbQIKw2JhBMI53qYnXrl7+n5kjPyrW/zDilmNJDL/M
	8m3x5/+ufDMit0hnP+hxwlPrz9FG9yYLrPG/GoRO9RLnPm0q3fiX2x+4KoOPFggJrCyloSQ2YnV
	1mkIA==
X-Received: by 2002:a05:6a00:1c90:b0:868:7a65:d92d with SMTP id d2e1a72fcca58-86f867baaaemr4249175b3a.26.1789385485458;
        Mon, 14 Sep 2026 04:31:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29cbb0d3sm4384905b3a.42.2026.09.14.04.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:31:24 -0700 (PDT)
Message-Id: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
From: "qeesung via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 11:31:17 +0000
Subject: [PATCH 0/6] repack: don't lose objects to a ".keep" that appears mid-run
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>

A concurrent push can make "git repack -d" delete a pack whose objects were
never copied anywhere, and exit 0. We hit this in production: a ref pointing
at a commit that no longer exists, on git 2.43, and it reproduces on master.

What happens:

 * repack scans for ".keep" files and decides which packs to delete, then
   spawns pack-objects with --honor-pack-keep, which scans again;
 * in between, a push of content identical to an earlier one finishes
   migrating its quarantine. Its pack is a duplicate and is dropped, but its
   ".keep" is linked into place, onto the old pack;
 * pack-objects sees that ".keep" and leaves the pack's objects out; repack
   deletes the pack by its earlier list, with force_delete.

Two things are wrong, and each is fixed on its own:

 * 1/6: receive-pack removes a ".keep" it never installed -- the one it
   linked onto somebody else's pack, or a foreign one when its own push was
   rejected before any migration. Only remove a ".keep" that carries our own
   message.
 * 6/6: repack and pack-objects each scan for ".keep" files. Hand
   pack-objects the snapshot repack took at startup instead.

Patches 2-5 are what 6/6 needs to be safe:

 * 2/6: under --stdin-packs=follow, a --keep-pack pack stops the traversal
   like a "^" pack; on-disk ".keep" packs never did.
 * 3/6: the cruft walk goes by a stale kept-pack cache, which
   --honor-pack-keep happened to mask. Pre-existing, reproducible today.
 * 4/6: look --keep-pack names up in a sorted list; it gets long.
 * 5/6: --keep-pack-from-file, since a repository can have more kept packs
   than fit on a command line (32K characters on Windows).

Every fix comes with a test that fails without it; the race itself is
reproduced in t7703 by having a ".keep" appear as pack-objects starts. The
full suite passes, and the series merges cleanly into next and seen.

Qin ShiCheng (6):
  odb: don't remove a ".keep" we never installed
  pack-objects: keep --keep-pack open when following
  pack-objects: reset kept-pack cache for cruft walk
  pack-objects: sort --keep-pack list for lookup
  pack-objects: add --keep-pack-from-file
  repack: tell pack-objects which packs are kept

 Documentation/git-pack-objects.adoc |  8 +++
 builtin/pack-objects.c              | 71 +++++++++++++++++----
 builtin/repack.c                    | 15 +++++
 object-file.c                       | 95 ++++++++++++++++++++++-------
 odb/source-packed.h                 |  3 +-
 packfile.c                          |  9 ++-
 packfile.h                          |  7 +++
 repack-filtered.c                   |  3 -
 repack.c                            | 34 ++++++++++-
 repack.h                            | 17 +++++-
 t/t5329-pack-objects-cruft.sh       | 40 ++++++++++++
 t/t5331-pack-objects-stdin.sh       | 87 ++++++++++++++++++++++++++
 t/t5547-push-quarantine.sh          | 52 ++++++++++++++++
 t/t7700-repack.sh                   | 43 +++++++++++++
 t/t7703-repack-geometric.sh         | 72 ++++++++++++++++++++++
 tempfile.c                          | 12 ++++
 tempfile.h                          |  9 +++
 17 files changed, 533 insertions(+), 44 deletions(-)


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2219%2Fqeesung%2Frepack-kept-packs-snapshot-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2219/qeesung/repack-kept-packs-snapshot-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2219
-- 
gitgitgadget
