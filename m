Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822772BE7B2
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414008; cv=none; b=PKEe7/BscStdl4XjBEhG8GfJ9ke36y6UxshPLqsuWY3VWHFg5Oyth31iGAI0aK4zB4tBdBj9H7bUQtoGHnIZ2oRnNzaOjA9rqI5LsfknioTwyhOfDMHMG7K36hMZUHyBuHvAT3J9Q1tfsU5aCcAVwKIOpVNXUzxOWtFPIo1Kx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414008; c=relaxed/simple;
	bh=iYTq8z4Do9InaaWs07s3vzJ15SHr+9gOn8aU8/2HXfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpZyEO/X08sKeh9v5WBJCEjTAqq9a9pBPaKWN/+E3bH0HWermQAXu0q3+0pkF0PsaWJfc1qoGXMNchGSXQlD34cWjc0cbBzwFNiX4Lzyni3yK1Os3kr3UiiDx8AmQbfbz+EieFE2jgrut7Azn5XvR7qS1lxQkurljcFu34smaDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hXLxEt2N; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hXLxEt2N"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5e2fe5f17so246472685a.3
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 16:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744414003; x=1745018803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUXVQ12qLeJU0lDR9nMEcVH0cv/grsLe1vQQ3MHfHs8=;
        b=hXLxEt2NylSUMuwGp8HmZOX9LzzrVOLJtU/g1X8P457OrMsub71w0WtMJvqBpYxxIa
         DJU0xur6vSY1MY2+VKH5/fHoxsPr2QV7Dlqr50nGwR9oEGGgVVVxcUEfrl2D9/JLCvxM
         a4dSYiNQrRRQ6vE+QA1O/6DMx3zdhGHm40QgForgHf5OO4A2lnZJFkWITh5NRFlfQaIE
         5OVhn8qpB5B/ghOSGRErJs8ZdaQBZ9GlvnRr2IgR/z268dqIBeXgA3jhTMx4eH16LoGe
         8kxCGpDGb+SyTqbbSt1j6YUo7K66TpylQ8XQK/2AvwQohwiI3OfnJQCFQn1hiwSJzE4d
         W7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744414003; x=1745018803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUXVQ12qLeJU0lDR9nMEcVH0cv/grsLe1vQQ3MHfHs8=;
        b=uqIWrDejeBaHKyttVdpF9C1UKt9LxsoWfHIM/HgSgH9Pvlz5rj0tKDyDemvULHgXX6
         v5hR8M/Aa7fHE8vmOgcNcBrEKPlvQ1RPCkr7vsOjkLOcHO+N1J6eyUcf2lY5hLhDldfM
         vjx4kfMggCbdF/9tW6FSpLwRV2k6DqLXuwKjv+mp6UZFjt6lUm9zL8hjbNZON2pjK3Du
         sECKoYKjkv2jOnJEvHLIdeDcwNeSZ0sQW9t06L4Myhe2Yaek/NgkHOYNzgi6Z+R4gUHk
         BI7dog7jiKtJNLh9w5J+gcc8QeeDwKo39tPjqEv2rfGlN/yCzpVNi1RrH7pQHJepEpv8
         94Qw==
X-Gm-Message-State: AOJu0YyNBm+a0QfE0AkoKlSIL4gnXivwSubLEceISDfgEUDO7KK9GWkk
	4giebeuPK5J4M1FgOsyIbBuKyNFSIS0iX+96t4vR/X4VIX/4r9VNDPK9kOlRhM0E6c7pfuHncEN
	zCF0=
X-Gm-Gg: ASbGncvlwBf1UFmKaxOCLpHLO/RexrrXolfOnDSNNA3kfWV2Zj8MU/6N+dw1S5vb/Wb
	2vyDsLi6ZzIYp6NXJkymhNuXW3zhx1ljPPH1MQIwV7hHtFxqiAALg1apdwRP8dDVg4PTGPmVlW4
	YZsLdJHUjapjuoxRxoYvj6wh9XFrApxVQ1EJEHCTDK9Cfvw5pKqM1SSoPLnzB3gSOemPVP4AQ1z
	QWPql0/4Ef1EcWdLM19yL4YSVxpd8SA4jZCnIXnyilnyWmIS160lfmrVxrhaOsQdnkT/ewfsurb
	b1Pwl8C04QaRx5lhZPhaKEANrtmu7zARet/6+X3qdYqHScAHis6vJukAjDQBmcf/eu4pJpN9fzP
	7fSHa/KsEYk9QG6rhmPyPSU8=
X-Google-Smtp-Source: AGHT+IFlIA5QnoipZ9sGYi3KjbbcwGlYX8WPoi6NkIc+b452Cb1U+KgrAPVuzVoXlGvQQxfKFqmSog==
X-Received: by 2002:a05:620a:444e:b0:7c7:a543:dcfe with SMTP id af79cd13be357-7c7af0e2360mr671924985a.32.1744414002714;
        Fri, 11 Apr 2025 16:26:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a89f95b3sm327498685a.84.2025.04.11.16.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:26:42 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:26:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 8/8] repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <19b69c124696c31c04a09f56ef03bf8ca9c61c4f.1744413969.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744413969.git.me@ttaylorr.com>

In ddee3703b3 (builtin/repack.c: add cruft packs to MIDX during
geometric repack, 2022-05-20), repack began adding cruft pack(s) to the
MIDX with '--write-midx' to ensure that the resulting MIDX was always
closed under reachability in order to generate reachability bitmaps.

Suppose you have a once-unreachable object packed in a cruft pack, which
later on becomes reachable from one or more objects in a geometrically
repacked pack. That once-unreachable object *won't* appear in the new
pack, since the cruft pack was specified as neither included nor
excluded to 'pack-objects --stdin-packs'. If the bitmap selection
process picks one or more commits which reach the once-unreachable
objects, commit ddee3703b3 ensures that the MIDX will be closed under
reachability. Without it, we would fail to generate a MIDX bitmap.

ddee3703b3 alludes to the fact that this is sub-optimal by saying

    [...] it's desirable to avoid including cruft packs in the MIDX
    because it causes the MIDX to store a bunch of objects which are
    likely to get thrown away.

, which is true, but hides an even larger problem. If repositories
rarely prune their unreachable objects and/or have many of them, the
MIDX must keep track of a large number of objects which bloats the MIDX
and slows down object lookup.

This is doubly unfortunate because the vast majority of objects in cruft
pack(s) are unlikely to be read, but object reads that go through the
MIDX have to search through them anyway.

This patch causes geometrically-repacked packs to contain a copy of any
once-unreachable object(s) with 'git pack-objects --stdin-packs=follow',
allowing us to avoid including any cruft packs in the MIDX. This is
because a sequence of geometrically-repacked packs that were all
generated with '--stdin-packs=follow' are guaranteed to have their union
be closed under reachability.

Note that you cannot guarantee that a collection of packs is closed
under reachability if not all of them were generated with following as
above. One tell-tale sign that not all geometrically-repacked packs in
the MIDX were generated with following is to see if there is a cruft
pack already in the MIDX.

If there is, then starting to generate packs with following during
geometric repacking won't work, since it's open to the same race as
described above.

But if you're starting from scratch (e.g., building the first MIDX after
an all-into-one '--cruft' repack), then you can guarantee that the union
of subsequently generated packs from geometric repacking *is* closed
under reachability.

Detect when this is the case and avoid including cruft packs in the MIDX
where possible.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c        | 78 ++++++++++++++++++++++++++++++++---------
 t/t7704-repack-cruft.sh | 70 ++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 17 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index bc47bede7b..d0b88f12f6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -167,6 +167,21 @@ static void pack_mark_in_midx(struct string_list_item *item)
 	item->util = (void*)((uintptr_t)item->util | PACK_IN_MIDX);
 }
 
+static int pack_is_in_midx(struct string_list_item *item)
+{
+	return (uintptr_t)item->util & PACK_IN_MIDX;
+}
+
+static int existing_has_cruft_in_midx(struct existing_packs *existing)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, &existing->cruft_packs) {
+		if (pack_is_in_midx(item))
+			return 1;
+	}
+	return 0;
+}
+
 static void mark_packs_for_deletion_1(struct string_list *names,
 				      struct string_list *list)
 {
@@ -821,26 +836,52 @@ static void midx_included_packs(struct string_list *include,
 		}
 	}
 
-	for_each_string_list_item(item, &existing->cruft_packs) {
+	if (existing_has_cruft_in_midx(existing)) {
 		/*
-		 * When doing a --geometric repack, there is no need to check
-		 * for deleted packs, since we're by definition not doing an
-		 * ALL_INTO_ONE repack (hence no packs will be deleted).
-		 * Otherwise we must check for and exclude any packs which are
-		 * enqueued for deletion.
+		 * If we had one or more cruft pack(s) present in the
+		 * MIDX before the repack, keep them as they may be
+		 * required to form a reachability closure if the MIDX
+		 * is bitmapped.
 		 *
-		 * So we could omit the conditional below in the --geometric
-		 * case, but doing so is unnecessary since no packs are marked
-		 * as pending deletion (since we only call
-		 * `mark_packs_for_deletion()` when doing an all-into-one
-		 * repack).
+		 * A cruft pack can be required to form a reachability
+		 * closure if the MIDX is bitmapped and one or more of
+		 * its selected commits reaches a once-cruft object that
+		 * was later made reachable.
 		 */
-		if (pack_is_marked_for_deletion(item))
-			continue;
+		for_each_string_list_item(item, &existing->cruft_packs) {
+			/*
+			 * When doing a --geometric repack, there is no
+			 * need to check for deleted packs, since we're
+			 * by definition not doing an ALL_INTO_ONE
+			 * repack (hence no packs will be deleted).
+			 * Otherwise we must check for and exclude any
+			 * packs which are enqueued for deletion.
+			 *
+			 * So we could omit the conditional below in the
+			 * --geometric case, but doing so is unnecessary
+			 *  since no packs are marked as pending
+			 *  deletion (since we only call
+			 *  `mark_packs_for_deletion()` when doing an
+			 *  all-into-one repack).
+			 */
+			if (pack_is_marked_for_deletion(item))
+				continue;
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s.idx", item->string);
-		string_list_insert(include, buf.buf);
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s.idx", item->string);
+			string_list_insert(include, buf.buf);
+		}
+	} else {
+		/*
+		 * Modern versions of Git will write new copies of
+		 * once-cruft objects when doing a --geometric repack.
+		 *
+		 * If the MIDX has no cruft pack, new packs written
+		 * during a --geometric repack will not rely on the
+		 * cruft pack to form a reachability closure, so we can
+		 * avoid including them in the MIDX in that case.
+		 */
+		;
 	}
 
 	strbuf_release(&buf);
@@ -1369,7 +1410,10 @@ int cmd_repack(int argc,
 		    !(pack_everything & PACK_CRUFT))
 			strvec_push(&cmd.args, "--pack-loose-unreachable");
 	} else if (geometry.split_factor) {
-		strvec_push(&cmd.args, "--stdin-packs");
+		if (existing_has_cruft_in_midx(&existing))
+			strvec_push(&cmd.args, "--stdin-packs");
+		else
+			strvec_push(&cmd.args, "--stdin-packs=follow");
 		strvec_push(&cmd.args, "--unpacked");
 	} else {
 		strvec_push(&cmd.args, "--unpacked");
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 8aebfb45f5..33ac58a3a5 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -724,4 +724,74 @@ test_expect_success 'cruft repack respects --quiet' '
 	)
 '
 
+test_expect_success 'repack --write-midx excludes cruft where possible' '
+	git init exclude-cruft-when-possible &&
+	(
+		cd exclude-cruft-when-possible &&
+
+		test_commit one &&
+
+		test_commit --no-tag two &&
+		two="$(git rev-parse HEAD)" &&
+		test_commit --no-tag three &&
+		three="$(git rev-parse HEAD)" &&
+		git reset --hard one &&
+
+		git reflog expire --all --expire=all &&
+
+		git repack --cruft -d &&
+		ls $packdir/pack-*.idx | sort >packs.before &&
+
+		git merge $two &&
+		test_commit four &&
+		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
+		ls $packdir/pack-*.idx | sort >packs.after &&
+
+		comm -13 packs.before packs.after >packs.new &&
+		test_line_count = 1 packs.new &&
+
+		git rev-list --objects --no-object-names one..four >expect.raw &&
+		sort expect.raw >expect &&
+
+		git show-index <$(cat packs.new) >actual.raw &&
+		cut -d" " -f2 actual.raw | sort >actual &&
+
+		test_cmp expect actual &&
+
+		test-tool read-midx --show-objects $objdir >actual.raw &&
+		grep "\.pack$" actual.raw | cut -d" " -f1 | sort >actual.objects &&
+		git rev-list --objects --no-object-names HEAD >expect.raw &&
+		sort expect.raw >expect.objects &&
+
+		test_cmp expect.objects actual.objects &&
+
+		cruft="$(basename $(ls $packdir/*.mtimes))" &&
+		grep "^pack-" actual.raw >actual.packs &&
+		! test_grep "${cruft%.mtimes}.idx" actual.packs
+	)
+'
+
+test_expect_success 'repack --write-midx includes cruft when necessary' '
+	(
+		cd exclude-cruft-when-possible &&
+
+		ls $packdir/pack-*.idx | sort >packs.all &&
+		grep -o "pack-.*\.idx$" packs.all >in &&
+
+		git multi-pack-index write --stdin-packs --bitmap <in &&
+
+		test_commit five &&
+		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
+
+		test-tool read-midx --show-objects $objdir >actual.raw &&
+		grep "\.pack$" actual.raw | cut -d" " -f1 | sort >actual.objects &&
+		git cat-file --batch-all-objects --batch-check="%(objectname)" \
+			>expect.objects &&
+		test_cmp expect.objects actual.objects &&
+
+		grep "^pack-" actual.raw >actual.packs &&
+		test_line_count = "$(($(wc -l <packs.all) + 1))" actual.packs
+	)
+'
+
 test_done
-- 
2.49.0.229.g19b69c1246
