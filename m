Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BCF3451A6
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731742; cv=none; b=Lnt8R5DXBgkpmTUkN0/bj4Z9qbZLDDr5upa+4NJ+QgrYCNROeOPJhTLtGIceLtkTqri5qCt/trWrjwCXpu4nGeHylBMpLPnhNHS8hJDejRTtYDgI3ZPxcGoRmWdyWZNimY4BX1pa/UOZUlbITeGJs86CGU1Lwd5QkQKr9/N/BZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731742; c=relaxed/simple;
	bh=QbSkZfEio+tl5KNLiYwcHRwz+yJ85I5BGxtl/LkNaDQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL7XofeqfkbL5enINnWYrh2aeRdq9yC1eYH5ITYSuBVCW1xcn3Ub24GVJxMypiFVjfnjR8HyZPq38joff7SSVNb3/csCG1ooU3qCnaXG6Rh5U3T2cN8h4v0j2W3kjdbbUJhVTULu57+mNOhlVYGyX/5yHSxadgDp0YqjUpVpj0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=OX32UoOQ; arc=none smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="OX32UoOQ"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4e849c5fe49so2942168b6e.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790731737; x=1791336537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W0GhIHa1ZCvNG9ewAnEi6iC+9mJ6E1oxv5WS1f3F2mI=;
        b=OX32UoOQaf/wTVuRGSARsKhfUQaHp2tmbpU6eJvLbb4emcPYR8wiABVV13yXujAImg
         ll3DGu9tLaQ3wUmD9eJ2cAfbCeKVPDavpcbfR8ZS6nLzKK/PjJ8i+nH9fXn8DE4gNkyK
         1r+6VRQCbVXwcZuoybI+/yVYX3vsmRKwsSI78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790731737; x=1791336537;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0GhIHa1ZCvNG9ewAnEi6iC+9mJ6E1oxv5WS1f3F2mI=;
        b=Zm8WUajxuUBvn5/x174u75G4jCgx1YGUdPGl3HvIkannb31m4QAUNhd1rcimd1CwYL
         knermg8wxVL1uTY3OvLHIlA9QsSyiqEXANLdtH/N3UDyd00Te4GF+dfpaomXDrm4z/ry
         8BxGEWBjhR3BI86JeyE9cciJ+dlcK9YFjJ3okizr6o2qAoDODK9yBl8yYr2N2XDGraaF
         /MRSzZrJMWPL1sADVDQig3mcY9L8YMqKEFVI+SMEiEOfRzG42gyId2SbaZ4HBAgz0OXX
         l9gDj+Q/Ye1BPV/AqAXOn7PheU6hHm+r+v6dIYqm435I7Z9/0clvv8fLzLB9p4b2bLLL
         MoQA==
X-Gm-Message-State: AFuF++kDsjcb2yQNvhy1DnUrsW9uvUsDNhE3geEFu32y1yxezHbF7En5
	oarw4HWUtRH3Tnk3Tcpz1hcEeQ4H+44Pq06G0DUU6ik3NVojuLuRXELCszv0DftAlFt1dwdydnj
	tB1i2Uio=
X-Gm-Gg: AYBFou01lj9J1FoXIukQFeC+e7CtCKW311pLsBO9BG6e8W1eF/Lr/8M0YVhmIf614V8
	ZM7LExXC1fnxvIyqpQlSJ5D0WQ+jCItT3mSGa+LyTDilmBVhI79OJYiiqJa1MQ8Eh4sFqQ8OQ1U
	j2b1BClY6AGRJ2XPdQJMNnXX96Q8hbOCirYlHocp3PN7uBkVUuvaWpnZ2TgIKk6NnAHaAnaeCCa
	0qF8OlMAGORcS4uN3ptenhWWVzir7FlznmC7JSb/IcMScb2O0eR6E0elKuGqDSvYh8GGD2RA3u4
	EpYdAZbM/43W6d0OVCJ61rZIaIIeXF8toNy0B3BUV4pONZDfQcuuy9KwfH8nbwQS6j/IutDPewZ
	QUMozo+edI4ckI9G1VhLwovMkYy50iaYuR9U9tqz0zQVsd20FIFhJBJkbqdDQSen4u3EfMevEHu
	NLkv9QMFieFo+Tr03p4/g9xMAq7plHS2PTE70Fz4sapfpCNLvnbZTEBmxBHaJJBOBObfKxXWs1v
	FSwNv8Sp75twxiEa1LfVX/ydqEmtCWz0YQUILNAI2VLSb+kldaLMx1le56xEkqNl0nrUOzA8WnU
	GiiROETC
X-Received: by 2002:a05:6808:6609:b0:4b2:8d7b:390b with SMTP id 5614622812f47-4f0691ddaf8mr1482208b6e.19.1790731737351;
        Tue, 29 Sep 2026 18:28:57 -0700 (PDT)
Received: from com-79390 (vpn-centralus-01.tradc-corp.com. [172.169.249.3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f0ade01337sm1233976b6e.8.2026.09.29.18.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 18:28:56 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Tue, 29 Sep 2026 20:28:53 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH 3/4] repack: retain cruft packs in MIDXs after incremental
 repacks
Message-ID: <1774fed77be11b37ce9eb4b7806f5f14539503fb.1790731662.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790731662.git.me@ttaylorr.com>

An incremental repack can write a commit and tree into a new pack while
leaving objects they reach in an existing cruft pack. For example, a
commit can make a previously unreachable blob reachable again. Since
'repack' will invoke 'pack-objects' with '--incremental', it will not
copy the blob out of its cruft pack.

When the 'repack.midxMustContainCruft' configuration is set to "false",
writing the first MIDX after such a repack may omit that cruft pack. The
new pack bypasses the `!names.nr` fallback, and there are no previous
MIDX packs for `midx_has_unknown_packs()` to check. Selecting the new
commit for bitmap coverage then fails because its reachable objects are
not all in the MIDX.

The omission dates all the way back to 5ee86c273bf (repack: exclude
cruft pack(s) from the MIDX where possible, 2025-06-23). It relies on
geometric repacking to copy once-cruft objects with
'--stdin-packs=follow'. However, an ordinary incremental repack makes no
such guarantee. Require the MIDX to include cruft packs in that case,
even when a new pack was written.

Exercise this with the existing fixture that makes a cruft commit
reachable again and adds a new (unpacked) commit on top, and ensure that
the incremental repack is able to successfully write a reachability
bitmap.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 builtin/repack.c        |  6 ++++++
 t/t7704-repack-cruft.sh | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index c4360382c1f..b7596d488da 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -539,6 +539,12 @@ int cmd_repack(int argc,
 			strvec_push(&cmd.args, "--stdin-packs=follow");
 		strvec_push(&cmd.args, "--unpacked");
 	} else {
+		/*
+		 * Incremental repacks do not copy already-packed objects,
+		 * so cruft packs may be required to form a reachability
+		 * closure for the MIDX.
+		 */
+		midx_must_contain_cruft = 1;
 		strvec_push(&cmd.args, "--unpacked");
 		strvec_push(&cmd.args, "--incremental");
 	}
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index b49f22878f7..f7f83e70ffe 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -787,6 +787,17 @@ test_expect_success 'geometric repack rescues descendants of loose trees' '
 	)
 '
 
+test_expect_success 'incremental repack includes cruft for MIDX bitmaps' '
+	setup_cruft_exclude_tests incremental-cruft &&
+	(
+		cd incremental-cruft &&
+
+		GIT_TEST_MULTI_PACK_INDEX=0 \
+		git repack -d --write-midx --write-bitmap-index &&
+		git rev-list --test-bitmap HEAD
+	)
+'
+
 test_expect_success 'repack --write-midx includes cruft when instructed' '
 	setup_cruft_exclude_tests exclude-cruft-when-instructed &&
 	(
-- 
2.56.0.4.gbee41d2fc68

