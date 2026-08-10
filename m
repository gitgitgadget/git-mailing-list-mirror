Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00453431A5C
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383708; cv=none; b=OCT2OV0tf1MFqa1boh2Bj1nGCdk/wIN0dSl3rLsgqDZuYha4poDgg/U/wwGA3kTricrJ6mUPiAuwWG+FdNz9QpAelgbaCTsCO2hhkOekQAk5+TNVPnTej9uGrkhiPgJvd9hJGYN3LvlPcTcvHiIGOnmwKkP8WqVVPplQExNrXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383708; c=relaxed/simple;
	bh=UyB2fV5Nr6z4fQi5vLLQ97Wtxf0IAySVBgjYdpHzb6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs23xoHtEx/IDjG+6pc9OxgFYUyEjCsRb3ELy0Ezq3ScbEdnggdAMO+Wyf15cKMZuWDLXYE71Xd/1CfpVpqhWfITPFXFqZI02noIQ3xkz2YcHKOeLDnBclnCu2fw7m65us3MmlzNXhoc10L4IAjmw7tZK3ueLV4JCXlNn0Gfbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8XYEPg8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8XYEPg8"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2260937a91.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786383706; x=1786988506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60BgxIYJ9Vv04BejjAcADp/34/M+w474krhaB6xJu6s=;
        b=G8XYEPg88A9x9Sa5Kj58NRIIA+g1IgCujLv43cMrP5h9dTnervwTBhzkrBlDb6tkXi
         qk6b+gLIPasmwUkvAB2IiflUZuClE15BOTVorSfODsf/Skvg0dlVp8P1maJBuIEEGGfU
         YEuZn9bEgl/5zUw+/EzB8OPLAXG3n/FvUFef8Man2HdAOf02hqJrJMJbENj/j71dII3o
         CRGaGew1DLII5cz6uS5ff0ScqZzDy3mYd9h1RAzw0uFQIrjgMEiVbEKsQpZ7V44QOgZW
         iktaRX9fTJ0fC8AWadPNxFFJkAh1a7M5ogmFc2E8jfEOq4wAan7L+hH/7tNQ+mPeFWnY
         roqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786383706; x=1786988506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=60BgxIYJ9Vv04BejjAcADp/34/M+w474krhaB6xJu6s=;
        b=rQOwT44fPZhfaLKWJs8zce4Kz8cvKcG5PB+gyR6WRy+Pk9dc9sd2vzMyAQH2llTzJp
         vQ/CWatta1BgCzgUDA0o2Oy5mc2x2Xl+Rcm0IX94wxWl8lLjndl+N4en57y17SZjTqyb
         sI9f/xdZ8Etcj+4UELRtNq6xV0wF86s/uKXw21plIBFoawVRrY3Oorunz6KKKQYGQNXY
         OGoqPYdxMXUe+Btb70DH5q1n4tb+TPLURGKZqwk1NxhOUVT2JXcfByXI0w2QkRtkXfSV
         /vidnHctHvoUnmIKFnBf+0qhHIEiyXXizAYz6JkD82zQLojtzMBxVhi+KN+kFnghWsJa
         Tmyg==
X-Gm-Message-State: AOJu0YxRlskJZ4+ko8RfZgeO5qe79cpXrBvDE3/1EXXAzs1/z5CfhDwW
	bYBiiL8DBE5MYp7Wo5QUREv/mGOIrVqANo2/gG+lkMNFSYvdA8D0M+OSVW9vqgvJ
X-Gm-Gg: AR+sD13bg1MSv5+4p66t+xG9ay4zC+rh6L/NSwWRsDdm05jAHE9t6MjV0XgzVSrmgdO
	cqZeATqxZSZ8fkrEihgBQE+9xPK8mvCdsLRJ0/UiepW522Pds5A86fPy/GbS8sQ6rmWdanr8Lwq
	AQ4wot2XPJuquJ9uPCi6OtjjXnoUzq80FFbY1gsLH8Xfi1johuYT266on82IVbIuC1dtcYS93V0
	7Wy0GUI/OjvAKmoSUyP6gXHSH0CF5JRzQrYoaaj/wC9G5CpFfGi8HKuGy6Agi2Co9iLVtyv/XXk
	xE7zGrTLbkkn/XJeRQ/zEODQFrseOmiQI+Av2gwnCOfcY+VdQGpWweeD6BsFFuluzkdV0mDB8H1
	V7dmR7Kly9iWr9TGPX79mf7xz7FHgLo8BZ+L9uypfRFdXCgktjwjobBV8F1kZ69ayoQVA4GBhmJ
	SFQzddoQVoCqTUss+WkfBc5PpI+QU+D3RvnOOKkodWXenfRPNoeoscPR/Lwb+wxLbkbooNtEHym
	wrDzQOEt/ERVGvE35e+jj1WOkbnav+PYLHXcQ7W3GV7zG8OD/dV1etBjs9jjuKaFl9rEpkiXgDr
	ltvg14wOKskXSfsDLzbagw==
X-Received: by 2002:a17:90b:264c:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3903c59936cmr47574389a91.8.1786383706163;
        Mon, 10 Aug 2026 10:41:46 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5026:8db8:20aa:c615:9a47:206a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm36865585c88.14.2026.08.10.10.41.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 10:41:45 -0700 (PDT)
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
Subject: [GSoC PATCH v4 7/7] Documentation/git-repack: document --drop-filtered and --dry-run
Date: Mon, 10 Aug 2026 23:10:47 +0530
Message-ID: <20260810174047.6524-8-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
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
index 72c42015e2..63943b078c 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -12,6 +12,7 @@ SYNOPSIS
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
 	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
 	[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
+	[--filter=<filter-spec>] [--drop-filtered [--dry-run]]
 
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

