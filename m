Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6625B08E
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433384; cv=none; b=U/3x47NlD66shZtwDJQYNl2MDkdOTmBV5uBqI0VZ11FepsK+Jo82B9e9z+YqPjed06y0LiOQBGJNJK6wU68O6x2qCFa8sHvufmEFgiO2Ha8RDGxwttX2icPL/kQlyOOeWJ7ggfQNfeuN7k3rXurkgIOYUctdpNpLlhGhUnsEDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433384; c=relaxed/simple;
	bh=xLPjPJSnuY1pcE76irq1UoR85lvs5aZYYPPvNwSyjQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm+DsMIqmQ5TSZDGYx3nYBiAuVGQVoY4I27crZifvG77IQVeuSomvP8sgRgpLW1x8AFJNGiM1LR1Xanti0nFofT92kDDSXCMm95sVDHn9o3+W1RrngnNzfUwmtE0bSc5LvxjLOFh3DowGc5Sq79lEoAYbjpAa+KMmaH4DFAwhiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BETRvlwi; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BETRvlwi"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso770500a12.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433381; x=1786038181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=si2Dt7qg5b2OaUwqgsU+7x9nE0xNwl9JF/vPlxvdYSE=;
        b=BETRvlwixBjoOVbjx0JKwAp4b/L2aaDT6a0920Zau08VALjGunpviZ7dTSIvJ84d8q
         ApqTFGKas4iLu86C6bBDScyuiGd6/fP+gCvVJ80UIjw1PVaGBa0LRam24pGH1+5ZoBUG
         fAh02hdSHmQHh07WcFKp2eRnwZGvpEhKVNCWViihbjXd6RzyAhTidDqh3pnIy5rg6+z0
         474m0zrjoXTQ/AWKYncOWjk0UIo3dpi7jPgxL9VYj+c9TgCH9DfeBiTT6QWKdOx2dpqb
         ksBoYzvjOqiCvr3sGy8+jS7Npj1nBkf659JVKd9FC0QapQxezkrNMOhWLACiOOmJESx7
         hEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433381; x=1786038181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=si2Dt7qg5b2OaUwqgsU+7x9nE0xNwl9JF/vPlxvdYSE=;
        b=snYMY5Vt6poI/UzMqi9DOV1S3JVtYuodpHQxuwGjAamERpM9lQ/gMnAhHO3OtilZ8w
         rQ+cbw0LGijwkhTRS8wcT0IXPLEzXoaWlWidLs7Q1O9a54kBOIwgILYKNB7Uqktl4xSz
         32zZ8MAk/hebewAPie3asleglnRtHl5Je8VJZtdGS05x6R0LHXmN4gKTOUyuyh/HfVTT
         CLSNah16pvex8pIrUJUQuRvLs2E18/c0xIuUPD6MD0QB6pJP4ydqCOtYQpZ/wj7d/VRC
         1QguSepGDhtAszfFsifWwybZY71v/pZQWqZ1EbBfPLXv0gCn1su/A2FjqpTKr2LqU1cr
         GexA==
X-Gm-Message-State: AOJu0YyksP+QhvH3TDZFxpmfuntDMK8VrsRnpELoL3M5PF/gEpbWyvHj
	vtTtOwFisUCj9n0sK74NJFG+awlD7w3JtOOIUYapgQLa5Kcf+QrKd+xba7o0Ng==
X-Gm-Gg: AR+sD10PLUrqE04jzssieyKFP94EwsevYT6Fbgl9kc5K8cJ2nrzEFvHOWaU8AdKSC9c
	sw5zJ++IEYR+b50E/ZCg0pJW/ZPBslYV0mkiEQO792fnltQDmuzGN4fGRmE6Ik4VAbQwqjY6tIP
	yWTnaXNgSKypdXZo8qhQNsJTy6Ev9Ry2etLiXGCYb7sSVe/Z6peb8d+ZQvygN10TYYPTK+5Qqeq
	v2Vr0eK+Vrz0e9qjDvkp3Y2OYnbi6ACfBn+BnP2mz6aKv1a9NoXOKtNkDx43st7CeqxbEC+MNdp
	LNGwmxkm8nKGLsqPUj0JhNWheC+rVyJ/zh+RhktJMrQHIIEpnCXiVgnRha/4r9VbjkRWtu4fVgI
	+iyfjCLnH4kLPOxY3ADejrpFMg/b70XYjQh8neU3x7sgvfwpOGuxGRHg0iuTBE9aMyjjNvKGs5H
	srtzfgAP4VwBz4F7+FSP9Xkjhu24/+gHgMt6CbCZ8W0tMfRzZYvE5cDLTNaiqB7jHVNcoeRM/sw
	VWwPLnQLLiKuTuUN3vuMrBytz1jdUdCIde9NfvCDnSVOFUr8qknnyKf4z6MGEzzFRxYhVYEVQZT
	0+WgmEuU+NhjeF6teP4uVzUU9gE=
X-Received: by 2002:a05:6a20:1615:b0:3b5:6b5a:4f31 with SMTP id adf61e73a8af0-3c90d9c3d72mr1149766637.27.1785433380904;
        Thu, 30 Jul 2026 10:43:00 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5622:d88b:20c4:5444:d41a:b6c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm25163964eec.14.2026.07.30.10.42.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 10:43:00 -0700 (PDT)
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
Subject: [GSoC PATCH v2 7/7] Documentation/git-repack: document --drop-filtered and --dry-run
Date: Thu, 30 Jul 2026 23:11:53 +0530
Message-ID: <20260730174153.9949-8-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the new --drop-filtered and --dry-run options: what they do,
only blob:limit filters are supported for now, a promisor remote is
required, --drop-filtered requires -a and implies -d so the redundant
packs are actually removed, its incompatibilities with --filter-to and
bitmap writing, and the safety guards that refuse to run mid-operation
or to drop index-referenced blobs.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 Documentation/git-repack.adoc | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 72c42015e2..9efff838f2 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -12,6 +12,7 @@ SYNOPSIS
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
 	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
 	[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
+	[--filter=<filter-spec>] [--drop-filtered [--dry-run]]]
 
 DESCRIPTION
 -----------
@@ -182,6 +183,40 @@ depth is 4095.
 	`objects` and `objects/info/alternates` sections of
 	linkgit:gitrepository-layout[5].
 
+--drop-filtered::
+	Delete the local objects that match the `--filter` specification
+	instead of keeping them in a separate packfile, reclaiming the
+	disk space they occupy. This is intended for partial clones,
+	where the filtered objects are promisor objects that remain
+	recoverable from the promisor remote and are lazily re-fetched
+	on demand when they are next needed.
++
+Only large blobs are supported for now, so `--filter=blob:limit=<n>`
+is currently the only accepted filter. Because dropped objects must be
+recoverable, this option requires a promisor remote to be configured
+and refuses to run otherwise.
++
+This option requires `-a`, and implies `-d`: the objects are dropped by
+rebuilding the promisor pack without them and then removing the now
+redundant old packs, so the redundant packs must be deleted for the
+space to actually be reclaimed. It is incompatible with `--filter-to`
+and with bitmap writing (`-b`/`--write-bitmap-index`), since filtering
+breaks the single-pack closure that bitmaps require. A bitmap setting
+coming from configuration is silently disabled for the duration of the
+command.
++
+As a safety measure, `--drop-filtered` refuses to run while another
+operation (merge, rebase, am, cherry-pick, revert, or bisect) is in
+progress, and refuses to drop any blob that the current index
+references, since such a blob would only be lazily re-fetched by the
+next command that inspects the working tree. These checks are skipped
+in bare repositories, which have neither a working tree nor an index.
+
+--dry-run::
+	Only meaningful with `--drop-filtered`. List the objects that
+	would be dropped, one object ID per line, without rebuilding any
+	pack or deleting anything.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
-- 
2.54.0

