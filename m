Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D43CE4B5
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015371; cv=none; b=iSif983tjCP5JQ4Mi/APJX+oG8/vPSPGNe4rGYMvRiHwizqynPnyIKDTTN6ORJtsfy3HEVvClgEBhcpqkzC24/E9+madooBU3SOVZqk6q221SNyu8jNfoOe3xQygxlro046/wLkUKwpjJNUiPV+zve/yST+bsu9Ece4e5tg89hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015371; c=relaxed/simple;
	bh=Zy0vfz1f/vKHvCrN7df56l5NuTdeXJ9LlhZILfFTt2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djMtBDe0opqF0dzlKdYdE6kaisdQZRw0r1wWNyxTkaw0wO7BQVH+6fyQI/d5OtF57hiYKzuI6ZFA6aT81A3Y6DStHYoye0hnXi91Wo/Xs7NFNUJP7imreE8OiiQksPkaZ2EaZieKT6AEJJILcir+58bdJp8gBl3sDliHNFZx3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ08kTxF; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ08kTxF"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb85186d43so1131983a12.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015369; x=1786620169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zj8swXHXYN5tdB50hGDY7rS2LYMif3iFt5Dods41cWk=;
        b=jQ08kTxF5UIDkDHq4Rw1oAEJgcVGYRSb0jBLRECRItzTWGunA8RfJ/ECGPydrllh1c
         1KdgE6RGtq4LnTDiiy8iQapiG2t3jwanaTl/nGUihKjB8mnwHtka3r9nNbH03bqe/qVl
         aKRsNiYAF9Z+4/88G6wjgoBtavlTHQl2MFvLgY0UY2WbUmEiL/t2fw4H5xXZZjAy1LE/
         BLIV3TqC12OG4UlqSVcOCKjk3dQSt3vDFEv7GIP8UOrxExqts9ci5MHqqT64vU3T7nIg
         SOYokYPzPaIasVDeHWGmVuLjhvkZ3i1TrbBOSa03AeIgqM8bpOGbK1lYldEfWgtD3sTb
         eyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015369; x=1786620169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zj8swXHXYN5tdB50hGDY7rS2LYMif3iFt5Dods41cWk=;
        b=kry+PGdxLp46wCWE3ota2jlX44WIgVrrmBUOj37R0ta8thvm8geDPSgHMUDFQ6gc4B
         v00TnXIf6gN6idYOPnw++DWq5J8NUIdr614BIAooH6Ntp+76gEUIZmP39B5NQxQp6FlY
         ZEHsLh8SHRpmHP8sNkNEGzrhuDLIdlpbjmq/jAxEQ0OADQ9YMNZvD6w6icudDQ7+LF5k
         6F6KDQ6B8/M15fJM7LJ5Jm+pgJaMvePe3K+k4TgMrScxcwLtugk/RBbhh2xKJxil6hpJ
         Je5xzW9PikKHn/ToJK6CkVQxiPQ2Os5H7ZSeTK5zp2V2FSy7fzfNxXX/Lfej/QOLznc6
         pbSA==
X-Gm-Message-State: AOJu0YwDOt7VKMwvN0g9SoDlMsB8RX5P0DbHgSuqUiOFZFp3AyZeveQa
	7bs/XYQacmmipQ2z1Th1DmGt4FuKRmunDHZByobhPcsAHefEflLk8T21bTNDMxcI
X-Gm-Gg: AR+sD10HLOMwepoBoapjHASCooM2/4HMCv2Nain1kVxZLQNYL3+ZI92LV6s7f1g7rOl
	63cNhzGPMSDOhzMSohm+nM/Al9YGX7k/foc0pTmuwCxAtZ7BtuZtusyug9pS8DQwskPuuBREUU1
	nj4DTatb9rXjPrUKUu6v5RmskDuBT2CGeqx3jK47cq2SUfcNNlDFYESbNFzRg4JNYx0q/qakeQ7
	F+59dwgSDEKRPkLvPCp63aJaMOFvzbVtnJm1G5qRW+6b50Hsfn/F1/pCyyMnP1aaz+Vw5DkaQMY
	HdF6dfpJePns/VgKE49AnQ2/81fLb2eIONDgVYyrOM6EtbUP/PCmWv5NFxsRxwX7CiF7psvPvRL
	zf2RXuF/P7doRsiN1Hl8a4/gpHibkwjJCSAFUDPKhAZ2wy6U6ZzzELoBdAkq2I3XYQ0CYuku/uo
	E5CEq5Z8S5o9S6VedUFCZzi+NH+wl/K8cmFyEQYd3rV+UCg7XYQTbglrUhs9v7yjFp4bGD2JEd6
	j+UKl6N2Tf1iwPcFziRyfKBOiLGFURPCwnxPTQVG+1zIIw8CNxfsR/dfuPr8aZtUUTTeiaUoghH
	O36SvWc6hRdm
X-Received: by 2002:a05:6a20:4314:b0:3c3:6928:8b25 with SMTP id adf61e73a8af0-3cb85e62cd2mr16110973637.17.1786015369238;
        Thu, 06 Aug 2026 04:22:49 -0700 (PDT)
Received: from localhost.localdomain ([123.252.204.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df89asm42490376c88.9.2026.08.06.04.22.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 04:22:48 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v3 7/7] Documentation/git-repack: document --drop-filtered and --dry-run
Date: Thu,  6 Aug 2026 16:52:02 +0530
Message-ID: <20260806112202.75067-8-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
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
 Documentation/git-repack.adoc | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 72c42015e2..4c6aa3bc18 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -12,6 +12,7 @@ SYNOPSIS
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
 	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
 	[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
+	[--filter=<filter-spec>] [--drop-filtered [--dry-run]]]
 
 DESCRIPTION
 -----------
@@ -182,6 +183,42 @@ depth is 4095.
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
+As a convenience since dropped objects remain recoverable by lazy fetch,
+`--drop-filtered` refuses to run while another operation
+(merge, rebase, am, cherry-pick, revert, or bisect) is in progress, to
+avoid a surprising network fetch mid-operation, and refuses to drop any
+blob that the current index references, since such a blob would only be
+lazily re-fetched by the next command that inspects the working tree.
+These checks are skipped in bare repositories, which have neither a
+working tree nor an index.
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

