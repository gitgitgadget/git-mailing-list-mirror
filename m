Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581A387566
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453146; cv=none; b=WVgF9CMunQxhebK7LdD+eYWjhZkGJVkVv+81gmgQKTUcA/Srhb0JW2+nq1QZdqzwZtUaa6LFjglX+ZXiw03R4tnNPXGx6Oed3K1fLpsFBlQtSAc8EXw9DhYjR2vqP/QigC2i7rt/dy5Iif95w6CnRSkBujHng4f61uyHTqTUwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453146; c=relaxed/simple;
	bh=7FQAv0xilKM7BMUM0aO7Fp0DEYdLipfXCdSd2TSOJxc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Gknmm9OrEVn40yvMmRpSoO5R0MxMQUBujwVaXGCsQygMIn4tUCgO6cpVzFiYDVu4LVK6ZAPP/uXMYZWy96OycSGbxe9o131AkkuFHQ3Fp4/+oo8GrcqToa6yEpj3umPgWiirIexpx+YPjWqUnQg8qx7Pvs7gEagu4HNkBW3do6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb5xxCml; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb5xxCml"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a865731ee4so2509736a91.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453144; x=1792057944; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s0kLvt0TiJhwJWZ30oqJfPT3F0Eu8GP8xiOBtyQM3TU=;
        b=bb5xxCmlH0TbFV7f+eO1J85EQCGYiK6zA1htfNuI9eXebbXYLrVsm5J3cKgzgSlv1V
         fq2XkriTKjaZc4QCJPlWyAJkml3hPmFmRe9nEbx0aWUSAAvZ03/uNqdyFu/mTuhL8f0D
         kdxPNg2yhIS2NCQNxmvujeJYVEYRI5BOBinZNor0XFVD/xuTDofXJtimN8Pt6XW460CS
         3dlsyz1FQPtqyCezmaVWpCaiwHk7QgYweQamZUVXh4eNf9HlL3Xjv9DgeePuWUPq/AWK
         jT0e+zO/niqoOzvUlHTBgOZskwUBmevAiogfHxLXRtBIsBB9wle+cae0a+xLc3vfeiZB
         U5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453144; x=1792057944;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0kLvt0TiJhwJWZ30oqJfPT3F0Eu8GP8xiOBtyQM3TU=;
        b=wIWkLHVnPA+t/AZ0S+guN+QSB11OE+c6PfwLvykVaGxu3k1aRGOS3dULU8MgldC3tG
         vf0UlC0aL1whFLnz8Ew+dgjhWySRgdaniNE6sJp4XaobirGifamfN/BAU8lltRCWrbFP
         mW6t2qwnOsQ8WPd9OYUgXRqd53TeH0ioecZ1UNnqhEKrN7aisaUOcJfGgzAoxY0y/Xib
         kkFxPI4n2iKwcETCZjfQ4cBw7YmqHEyJ3F/SA8mklGzqNmXCFKmb1/4kYI+1uWlScsAR
         57k6BNKg19UivsemkCyfHcR1Va9G9/b+3oJst3zUieqyt1zbP0BCTak1NzXgZkjijcd2
         tc9w==
X-Gm-Message-State: AFq9FYJb0VacNwb+zD29Q63WcsxxFdY0/Q9U6npVww4BEFmEA3PPrcLQ
	ZdV/SmG+7SKBH6jvcBD26Bbw7u9JI5Nm19dhuTxmh4O422Ww3dC/rRMs/5mw7w==
X-Gm-Gg: AYBFou2m9zjSq8LHbvtooyySIOtH64QP4sLE01GvCP5L3FGMEnEUSmq1+cQrbVEABzP
	zB+VC62VvI+pzTNalK8gOH2ECKdO78Kwfc8dhZ8/Jriv1wSxbqnEjhYn9sQl/1x+6R6r1J0aOQ0
	cD6gRii9LIUatByAN32/WTcmt8/bFiZJeBi5Wiqhralqg27idS5oXzAB69u7u/omWsXAJi3suHM
	B0aLOFLaGmBmLQpwr96oOmKyVpqOTuKAswui9djWqiFz/V6MJg8x5Z806jbsavGqzbzEjPtZItP
	i/7lzqkwjlmHBzxTih7U83v5Z2M10ItP81vggpXdUrzp5+1qFf5hdQAr5sRM03WFarcxZu7G8R3
	GuOSW+iqDB30kHJ/EAs2Ot4nAE6Pg/203e7IOkOUokimRsBcrFhhkrzKDwUxiGX7B0Z/wXh7R/z
	EbJvQ+e1jmCteSJ5QnEVgmvZ8w+1e9X9nQ1DM3Hfr5zL9gm8+l57gSkWsmLQxqlQbGUJXAtT4Oy
	w==
X-Received: by 2002:a17:90b:288c:b0:3a4:f75d:d1a3 with SMTP id 98e67ed59e1d1-3a8a19b1e5amr4498143a91.32.1791453144085;
        Thu, 08 Oct 2026 02:52:24 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.246.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aaee881786sm1397191a91.0.2026.10.08.02.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:52:23 -0700 (PDT)
Message-Id: <8cf72312c5e0c2a11166a7024c521c53d9b7a1ec.1791453141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 09:52:17 +0000
Subject: [PATCH v3 1/5] pack-objects: keep --keep-pack open when following
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
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

"--stdin-packs=follow" distinguishes excluded packs that are closed
under reachability ("^") from those that are not ("!"). The traversal
stops at objects in the former, and goes on through the latter to
rescue whatever they depend on that would otherwise be left out.

A pack named with "--keep-pack" gets the same in-core flag as a "^"
pack, so the traversal stops at it too. Nothing warrants that: the
caller said not to repack it, not that it is self-contained. When it
holds a commit but not that commit's tree, the tree is never rescued,
and writing a bitmap over the result fails for lack of closure.

In follow mode, mark such a pack as kept-open instead, the way repack
already lists the packs it cannot vouch for as "!" on stdin. Its
objects stay out of the result, and the traversal can go through it.

This matters more once repack names its ".keep" packs this way instead
of passing "--honor-pack-keep": on-disk kept packs never were a
boundary, and they should not become one.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/pack-objects.c        | 20 +++++++++++++----
 t/t5331-pack-objects-stdin.sh | 41 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 708b719f40..6f579173b0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4999,7 +4999,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	oid_array_clear(&recent_objects);
 }
 
-static void add_extra_kept_packs(const struct string_list *names)
+static void add_extra_kept_packs(const struct string_list *names,
+				 enum stdin_packs_mode stdin_packs)
 {
 	struct packed_git *p;
 
@@ -5018,8 +5019,19 @@ static void add_extra_kept_packs(const struct string_list *names)
 				break;
 
 		if (i < names->nr) {
-			p->pack_keep_in_core = 1;
-			ignore_packed_keep_in_core = 1;
+			/*
+			 * When following, treat the pack like a "!" pack, not
+			 * a "^" one: nobody said it is closed under
+			 * reachability, so the traversal must be able to go
+			 * through it.
+			 */
+			if (stdin_packs == STDIN_PACKS_MODE_FOLLOW) {
+				p->pack_keep_in_core_open = 1;
+				ignore_packed_keep_in_core_open = 1;
+			} else {
+				p->pack_keep_in_core = 1;
+				ignore_packed_keep_in_core = 1;
+			}
 			continue;
 		}
 	}
@@ -5443,7 +5455,7 @@ int cmd_pack_objects(int argc,
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	add_extra_kept_packs(&keep_pack_list);
+	add_extra_kept_packs(&keep_pack_list, stdin_packs);
 	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
 
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index c74b5861af..4e1fde1b08 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -483,6 +483,47 @@ test_expect_success '--stdin-packs=follow with open-excluded packs' '
 	)
 '
 
+test_expect_success '--stdin-packs=follow walks through a --keep-pack pack' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+		B_ONLY="$(git rev-parse B | git pack-objects $packdir/pack)" &&
+		git prune-packed &&
+
+		# Pack C is included and pack A is excluded and closed. The
+		# commit B is in the kept pack B_ONLY, but its tree and blob
+		# are only in pack B, which pack-objects is not told about.
+		# The kept pack keeps B out of the result, and the walk has
+		# to go through it to rescue the tree and the blob.
+		P=$(git pack-objects --stdin-packs=follow \
+			--keep-pack=pack-$B_ONLY.pack $packdir/pack <<-EOF
+		pack-$C.pack
+		^pack-$A.pack
+		EOF
+		) &&
+
+		{
+			objects_in_packs $C &&
+			git rev-parse "B^{tree}" B:B.t
+		} >expect.raw &&
+		sort expect.raw >expect &&
+
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success '--stdin-packs with !-delimited pack without follow' '
 	test_when_finished "rm -fr repo" &&
 
-- 
gitgitgadget

