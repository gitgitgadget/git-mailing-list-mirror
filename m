Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B2245006
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370236; cv=none; b=WVBLOy951UR005Aal4L1VwNs/Jvc74eh143xGbgVViaFRlVA/VraR8AXIiqZ0XRLPPtLm8mMgdDh45MhhCBmwcaCzkmH/Vh4M/ujQEny2EgL1pMxRS+eCtYIO6SKBRDC28VDhV2Ac30gTr/LZ3GnVuBD9w7zKwqvLM7QK/+jSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370236; c=relaxed/simple;
	bh=c7zHYS0aPxOwcgULMEQGFRVzR7TuPNzce7/usx3rKiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+fxfgF8Bgq5+9SMaTx/z3XyFW5l+lrcs6h8AMTMneFBDN7AOyMUWUALUOzXB8AQIIaweoip+2ZI859lqHVKvuhGV2z1GmzaTQgwkHR5aPtMK6eMeNgfIN5r87CZ6rxEHDdzEo/MJxvR+cr3T6CZTaxbY/qnFHaERTMTgFFHaGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXXuMj3l; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXXuMj3l"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3407f385dd0so183024a91.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 11:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762370233; x=1762975033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2BmJibt7RuBp7ck9CaYLcxRtdyx0DYj4AxYn8lPYbw=;
        b=kXXuMj3l96R3X7YyzF3dseumeqoIObz8LVKX3VTIY63xIMIEnb6wSSNNogLHdo+JEK
         FQps8bXWQdaYLB42vNKVeAfqp6FbCrW3ow82dKbkYDbv30JSX9KUgsiPrSzcaiFMtx1u
         V+YHoYS35gh/RrxnWfHdCOGSRs+JclnO7Io9Hftc4A9gj1mSjqF4kd5SNGKNsDln3rei
         hRUxc6Re/BuI7mDHUwrfJboSEt3M1K0y148O1CEw0Ai6GLBVMLjhMfgIDoRyHrJ1Rfo7
         HxiXuiAkA0hg8P2AD7sFDSi5S7Az+nwkoBRNlMomur73hBnGvhU3x3gW7Kg+xPFSU7by
         +UTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370233; x=1762975033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2BmJibt7RuBp7ck9CaYLcxRtdyx0DYj4AxYn8lPYbw=;
        b=obzrbhfpC6ACm9Oc76vbSEuz82Zd+VYUP3wm7PdMv/8QmTUoZEOye1WSJC9smYTgPX
         b+OIhLpqkK/b+7X4zX3bj3VoG2ddcVat9ThIDRipWqA1loWN4Whqm0RsHUeg4IwrSM4c
         t0ijvsRfgr9g7/+3jz7KV+ukOjoIUMrJ4gKZNToxBl65G0ezcA+pBHYCa0uf84Y6Opy8
         k7KqWW2B9xMI18vab6ef7tem+QMwozUqX/XZeA9ta6gnfGcsySVsQ+xY3V8DqUBDfHLm
         ae3x6hxPOcihjgjDBTEdydoHJS+y7FLkPiSXDFB/k28STcZe0DFmtkTcgAFGsZZuJ+hH
         1LLw==
X-Gm-Message-State: AOJu0YyAKiB8R5CBlWAtI7eT4d7PqFz+x0aghy3L0pud2r7oyfW5kOvc
	X0NecOSkmiOKJjYuK30JpxzImmGTdeho9mDn9KxamvEIZ1HpPs91DMyuINw3/vS8
X-Gm-Gg: ASbGncu28QEeCREQmbXeVFVZKpl5TwkTrf3nDQwoY+YScB8c9U06FjrOv+2LcfDFTjY
	HSVPdBoC02I9iKKnmqc2Lr4biqbhwZD7XO0iVX6J3udYv6LKVCAYh9vF8pWjIYBDLhEUbApBu+B
	Zkdv3uSEnDSZK9ir+iNlKZVyF2pzI4Cw1DxjCgopITk30bPoOiz7mff/318uRWhbohwL5n9tTUe
	Ci02E3jixnP5TtAvVRLPSBCEKaKe9np5Bm0LrQQDisUgNyzeb5MiCYuNevLCAFveIuRfVAgV0OK
	GdiljCdKRGfSgvx4WzPArM6aC0apcwYtSWS5CRtBGSE2OMsCEDU5V/PSVD7GRNOBqEX5FqrEPcf
	CwnygE7Tgy3wp78juioXFGioW78zVK870xd20bpibfkRTAgMN5bthJm9zzdhGhioDy5dNEemu39
	Ao1U5kcIqU7Q/jpQCaXqnb7mEjUFv9zeewu9fl+uPjKvyA6GXg9QqK3PH8VU1ML5XvUqIWvJSh7
	VSQnTWNw8Pj47O0cK3e+GWD+VfpqrTZBehNmHSVeLiy
X-Google-Smtp-Source: AGHT+IEKO7yv6WbVVcm7gDx5mrq2Usp46H/a8RZtukFmI9reu4gqHQ/CGP98KUJNH8zOy9MqqfemRQ==
X-Received: by 2002:a17:90b:5824:b0:340:2f48:b51a with SMTP id 98e67ed59e1d1-341a6c491f1mr5462260a91.15.1762370233294;
        Wed, 05 Nov 2025 11:17:13 -0800 (PST)
Received: from localhost.localdomain ([2409:40e3:177:42ef:11ba:85fd:f5fe:a9a5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417bc8e9b7sm3056687a91.2.2025.11.05.11.17.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Nov 2025 11:17:12 -0800 (PST)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v7 1/3] replay: use die_for_incompatible_opt2() for option validation
Date: Thu,  6 Nov 2025 00:45:59 +0530
Message-ID: <20251105191650.89975-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105191650.89975-1-siddharthasthana31@gmail.com>
References: <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251105191650.89975-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding the --ref-action option, convert option
validation to use die_for_incompatible_opt2(). This helper provides
standardized error messages for mutually exclusive options.

The following commit introduces --ref-action which will be incompatible
with certain other options. Using die_for_incompatible_opt2() now means
that commit can cleanly add its validation using the same pattern,
keeping the validation logic consistent and maintainable.

This also aligns git-replay's option handling with how other Git commands
manage option conflicts, using the established die_for_incompatible_opt*()
helper family.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 builtin/replay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc..b64fc72063 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -330,9 +330,9 @@ int cmd_replay(int argc,
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (advance_name_opt && contained)
-		die(_("options '%s' and '%s' cannot be used together"),
-		    "--advance", "--contained");
+	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
+				  contained, "--contained");
+
 	advance_name = xstrdup_or_null(advance_name_opt);
 
 	repo_init_revisions(repo, &revs, prefix);
-- 
2.51.0

