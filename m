Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CBE3A6EF1
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902267; cv=none; b=BG8S1UssF5ULbEZak/VLNIX15jG19v2lBj5F4dU/fKcSjTUncsTJAWixVpukdYC29g8dbcqRnEzUNw87KpuOVO8tXx04nafUo2SYPuLXibaeoE0FLmn/9kAKXs0FxdG10YVK9DJMMZIkIvokcc/JC2zn4tWXrfyLW9bk0KSontA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902267; c=relaxed/simple;
	bh=WgxjyKtVH3N85vSuDvndUJp2J5OT7QyBbfMkOvCUeRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7tRLzu/hUtGyzWk77eFtgu0jg2ttwiXg9lLHU9pHbLDFXQf+HInPSPW+zpMzwNE+TfZZzQD1Q963BC2dWIE3JaJoLk8X0CeoS9PwB1Z/7ZEZenlN97yi+T3NypHBPl5bfdIN2tthLIKaTzrWWi38Bq7xPcEkjVDfOcGThJV9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Ogs194eo; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Ogs194eo"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ed000b507so5664227b3.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 20:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785902265; x=1786507065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MH7/NL09sZ40WhtolxbdHEr25GHyMSyYxicd3TV/F2I=;
        b=Ogs194eofc8bjH4fnsovWdFgHq4CVBWfgURqepYWb86Uhhu0h5llpIHqap81MpRNk3
         rWQ8KrszqzSYh+v3Tt2PZC4UC/0GhCJ2fyT/WR7s84jT1yXBqJ4UNyZWsrTYcLviWm/i
         WxCZigKt5elednEoGP3qx1LF7q1lNluN7DaEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785902265; x=1786507065;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MH7/NL09sZ40WhtolxbdHEr25GHyMSyYxicd3TV/F2I=;
        b=VbTpxSTQ5oXG8TnxRMke8Zr2Yhh/AZ+xbFRyo7dQvb1sjmwJVq/OjciVuAWjJQW7Q3
         VTIsJ+c8u/zQRUpCHVgJ+u1LOlKxiJyGU9UqRcVK7xaG/wz7RQDqEAGAM3szhCZ4J/hN
         H6ILI208CT8Lvh+JxEEu76+n09jv3Y6o8qML0T1b3w72vZJ6HT4Cg2GjAoYwrHMWnOMX
         +vXvUv8Achopv0WEWnc6PQWErO61LlMn3NPbHmKMGlnnb4GKpL6ZYbzWOdsfykJnzWlD
         ziIoXMV11coWK1eFlVgWZ/BnV/u2vMNi36LYZqPEp41wWA2iLxsI7MFIQlGocGX2JyIt
         zlMQ==
X-Gm-Message-State: AOJu0YyvGQSQHPuoe2THzOBGaL11mFUD7luq1muYBw6nSjf3wkG+yNhO
	4pg2Mo/A74hZnSiTTEChJDdUVGrODvUdV2PTMRvP8QUPOpOPYighrtJJbjc9k8V7yJgeBH2N7h6
	cWWsovYI=
X-Gm-Gg: AR+sD13amPxOcDru+skUUXMCotIUinzxIe7Tw8GaI7QgMX14SABgUD07q4dYt4XGQbS
	GmE0sjZDhJZo1Q8201MNUr5/DRPgDnYpGbfxBgIxyye0MzyT7pw8waC4IijMmIQoZEPuLFHGLOh
	ohQIGohFAnL6RMNWFLXo/xWhbbbcAY3AYq1IiAn9uz4AflF8Qhk8yt3SJ8UnKcsD3mlNSLAZuJL
	7pK9G4n6HjqWGuBAuepIXEdd/4ngO54zj26VWMCjZDMAAFxUqV9e30CxxZRhsMeFfgJy8chYIae
	40duKwxPPwKKFNdbWAUUYBO2FUhTBFbg5jAf56N9RUCGf1RVcn8g/4MKH+NXenQWjKwMTsiBQrh
	BJnWNgyOEI0GiX2vQpyCLbcC0MsgsIOJZhbmuI8DsEBB9PIqLwprXYeFwlYIZdLfbhvpBmKSlZZ
	AO/u4CH6cURN/DlT/LRNNOO2g1o1qkQH2s3XY7jWh/6oRlx9YbVseASMmYDig9BONHqcVuA6/FT
	ire3xPltup3dYKVHMyxxInuQ9gLklBiFEUyWqn0wXYK
X-Received: by 2002:a05:690c:b9e:b0:81e:89b2:93db with SMTP id 00721157ae682-82022440642mr22176817b3.15.1785902264974;
        Tue, 04 Aug 2026 20:57:44 -0700 (PDT)
Received: from com-79390 ([199.47.143.8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820131db36csm15392657b3.1.2026.08.04.20.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:57:44 -0700 (PDT)
Date: Tue, 4 Aug 2026 20:57:40 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, Ted Nyman <tnyman@openai.com>
Subject: [PATCH 1/2] maintenance: account for promisor pack geometry
Message-ID: <a9de123b43efb58c53c99c71eb7e34f29e075071.1785902237.git.ttaylorr@openai.com>
References: <cover.1785902237.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1785902237.git.ttaylorr@openai.com>

Commit 9bc151850c (builtin/maintenance: introduce
"geometric-repack" task, 2025-10-24) added a new maintenance task to
perform either a geometric repack, or an all-into-one repack if the
geometric repack would itself produce a single pack.

Some time later, commit dcc9c7ef47 (builtin/repack: handle promisor
packs with geometric repacking, 2026-01-05) taught the geometric
repacking machinery to separate promisor packs from ordinary ones, but
did not update the maintenance task accordingly.

As a consequence, the geometric-repack maintenance task only considers
the non-promisor pack progression. It falls back to all-into-one
whenever a geometric repack would roll up all non-promisor packs into a
single pack, even if the promisor progression would keep a large pack
and roll up only smaller ones.

Check both progressions before choosing the repack mode. If either
leaves a pack above its split, geometric repack still avoids rewriting
that pack, whereas the all-into-one fallback would rewrite it. Use the
fallback only when neither progression leaves a pack behind. That
preserves the reason for the fallback: let the all-into-one repack
handle unreachable objects when it is not rewriting more packs than the
geometric repack.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 builtin/gc.c           |  3 ++-
 t/t7900-maintenance.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 49c8474fad..ed75c12c43 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1593,7 +1593,8 @@ static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
 	child.odb_to_close = the_repository->objects;
 
 	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
-	if (geometry.split < geometry.pack_nr)
+	if (geometry.split < geometry.pack_nr ||
+	    geometry.promisor_split < geometry.promisor_pack_nr)
 		strvec_pushf(&child.args, "--geometric=%d",
 			     geometry.split_factor);
 	else
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index a8d691719d..ba5b359e77 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -659,6 +659,51 @@ test_expect_success 'geometric repacking task' '
 	)
 '
 
+objdir=.git/objects
+packdir=$objdir/pack
+
+pack_promisor () {
+	p="$(echo "$@" | git pack-objects --revs $packdir/pack)" &&
+	touch "$packdir/pack-$p.promisor" &&
+	echo "$p"
+}
+
+test_expect_success 'geometric repacking task handles promisor packs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+		git remote add promisor garbage &&
+		git config set remote.promisor.promisor true &&
+
+		for n in $(test_seq 6)
+		do
+			test_commit $n || return 1
+		done &&
+
+		A="$(pack_promisor 1)" &&
+		B="$(pack_promisor 1..2)" &&
+		C="$(pack_promisor 2..6)" &&
+		git prune-packed &&
+
+		ls $packdir/pack-*.promisor | sort >promisors.before &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+			git maintenance run --quiet --task=geometric-repack &&
+		ls $packdir/pack-*.promisor | sort >promisors.after &&
+
+		test_subcommand git repack -d -l --geometric=2 \
+			--quiet --write-midx <trace2.txt &&
+
+		test_line_count = 2 promisors.after &&
+
+		printf "$packdir/pack-%s.promisor\n" "$A" "$B" | sort >expect &&
+		comm -23 promisors.before promisors.after >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 test_geometric_repack_needed () {
 	NEEDED="$1"
 	GEOMETRIC_CONFIG="$2" &&
-- 
2.55.0.483.gdc2fffc37c

