Received: from mail-oo2-f34.google.com (mail-oo2-f34.google.com [74.125.231.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5741D100
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827909; cv=none; b=MCW5qcef6xEEl4JJyKpuussKnDAxLqQQnVHB3O1Hhvq/k3d+QzMEJnuSBzNM/iJ/ormKNjcJ1v+ZtlJImY9wjKCt2SjTqyyv/gHZkKb9UVmLDzruGGe4vJT3vDPu5+0BaDDtHPPFUgVlcE4wUv7x9+bpJ6CCr0u61yueR/38Lz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827909; c=relaxed/simple;
	bh=scVuZe0Ry38rmm3vQL/9SAc+4ZL9bzQh9XW8pQBGSec=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZDKcZABsg0OEMBnm/68H8LrGOy0MtDoTMoa5JCY+w/lXRor5R8Hws3U8a4InullQODPn1BxFaFQ3QR7UZAsBjt0yJ2pxtudCXNVMh3Jjw5KvuP3GGtDp1WK6DjC+Wwa1XC1NhRPST/wq9fnfhDXMMInqYPQxVJMQdbgEmYmDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=I938WrgQ; arc=none smtp.client-ip=74.125.231.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="I938WrgQ"
Received: by mail-oo2-f34.google.com with SMTP id 46e09a7af769-821c01c2fc5so54229a34.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790827907; x=1791432707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2K2urnJP2lKx4WkasiuhEhWngck2bZUpEK51AoG4O8c=;
        b=I938WrgQSD2V9cETfy+DpBp5TNpg1DTD8kfmDCGeO6kfkTo01g75lja3ds5Vtt0vzu
         IEJ7CPk/QM/dr+FDDaUn2ofVobv+ionXsnzWUTGBqFPOxVIepxsn81HZuOI4+ufsrwts
         +jtxmg/HhhTITzjVJyu8bhwrmRC5tBxkwys60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827907; x=1791432707;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2K2urnJP2lKx4WkasiuhEhWngck2bZUpEK51AoG4O8c=;
        b=woW30yPiS2j6biw/xzwSBrYIPGnxs94YUaLn0ss1ixoi4r+I2dupDwddc07VbvANeP
         q28wyDDOmkgXPKNd6vcw4Fdm/62xr4XSEmg7Hu77mZZ5L8P72ngbL9qnqI/DRY6f0iah
         0VqM9W+okZ6a21tgIPBMc5NtBbKu/XxDB7kE8I4ZbVD9fcLP/3ChMNC5vaZjf2MKO2DA
         mWkuMjW2zOLNhFlR3O27l62CmS++Wz1ZnCUOsiABsjudk7Di6yJOhGlBhQYs4LJrNhUJ
         xCS6VduWIxu3knEn667j1x7kVWKssIcAOHtRYxsuggpn+Ha24idhe6Uoib603NEuEGNO
         A7Iw==
X-Gm-Message-State: AFuF++mw1YHzOi6ji/r/zmqZMGTqwxVgtz6gBV6LQt5OPxGXS9TTd/DF
	celohePK3qfAdpmaueG5sGj2LiYwuNx1m5zLCY9YAE0jvEJM9s1xu78+YuuNMbUz9II9SMVWV9+
	fWjxlz2E=
X-Gm-Gg: AYBFou2JL+yK5a/frwdfU9Q/Dv3dpgvl2WQoJmigkeR95HEyy86zUQdegN5GwaWjGHA
	bVUl8NX3QobYKFAP8d35Tt+x7eM7QzPO/Y6C8FxuClE50IcZv196WHIGVqAZ+5RMr2Ky5l37fz0
	Um7jg+myJRFhXZ28We+V4Ze5th9UG3vTHGWiQDZj+Fe4E6Lr4/LskQfr4P7+6BnfDdc1+40wY8t
	xGJyGH3ijty1arEH35x8j4Q+CYqcE/ncoiGvVP7T3lbJWmDT4lFY6zf7V3NZJdAyjzLOmgKB87o
	GIPNFmdHr7hrfOC3jeFowjhbttM5N2ss9xFV+ShZLhg0TTcQCM1Ml6bMHoBBkX970TsR6a4WcjC
	xQxKwTj6ngrVJJ5bOvCc87XHgiWrdRXcvNYMcSvCkHPFNd11sIdZX3m57RbtG3P7sjT6qHIzFmv
	yLr1oShBo/y9yNaYFoeGjrhwy7X5jv4IWbu+R4P6alNmbMn3wO6rhTj9wX9Ls25jOOCpXHCipDU
	31GVzQ5qj0NspIeGUj+DnVEmLKW/Y8wfbfvht/lnX8YCMyYpCjh0iKLjwkVwODJY21ywM/8ckG1
	TONW2sLuirm69OBQokg=
X-Received: by 2002:a05:6830:3812:b0:805:cd51:568a with SMTP id 46e09a7af769-82046fb6052mr4053552a34.2.1790827906815;
        Wed, 30 Sep 2026 21:11:46 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b937bf2sm1694962a34.27.2026.09.30.21.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:11:46 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Wed, 30 Sep 2026 23:11:44 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH v2 3/8] repack: retain cruft packs in MIDXs after incremental
 repacks
Message-ID: <a244b26030ca2387e6feb768f849626540091624.1790827875.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790827875.git.me@ttaylorr.com>

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

This fixes ordinary '--write-midx'. The separate
'--write-midx=incremental' writer does not consult this flag and needs
its own handling.

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
2.56.0.8.ga42f775cbe2

