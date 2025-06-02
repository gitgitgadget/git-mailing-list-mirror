Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B121CC6D
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870978; cv=none; b=nC5mA0oeCFol05Bqd34bO0jjBqEAFwrRrVJoNakHGPzwjH7wtWCBxfGMc4dJcE0PHDNkz1GcWNq9kByzlUiPwiZTCSDcCYNiDGIv9kUADD8Vs6sWtcEjKalRm0mP/oDFV3A6zri0AB3x5k0cFkusamXsTrajmg+CDb+O/jfss2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870978; c=relaxed/simple;
	bh=TOeoL1aqZVF3T0lh8/e6NIMpRJRGLHiw7kTRs/OA3t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alqB6eO/wcG8XDxi/y5GIvcyhuF2EZPVZuqIP058utXsG9hsb+2T/oZXqsWTmpnUDvZyGTT4phB7l7YUdwGKR0Fjbx3s+gVUtzpJJa1D/oMtJT46hxDg30jKB8lLig8ySh0qDn16Ochr5lBJOAsxHR5Lfc/SEw53NaMcWV5nM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieqdK+/k; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieqdK+/k"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c9907967so4497615b3a.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748870976; x=1749475776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dTdR8ekaPi+ho/nz7+/m7HtqD/FDePRjvip+6j/X07g=;
        b=ieqdK+/k8oj0ibB0N5kRJbt0c8DjPpPyeDZzTfaoQnKbVHMxIGBIAdTP0cm+PS2u0j
         ccmnNmNc3Wqyjz+11r1QMQlEUcYEbo4PWIbpn1bAnbMwcmeGleP9MrVovhnKIrtqnVl5
         MBJHL2L67IyJLxiuMAEXpFIYnuX/2l+7hEzX8RMDPWKTTfJhE0l6ev8MdZAE2bxhdLgM
         4PE/e8ULV2LYTKD3SJ5POOwaq3AFjIx3XDBulbi1+5CpFalnNfNIuZHvqyQJ7kx7/KiX
         xOjNO8D8i6aLjPtFKVFSMVyGG5Co18WilbETaznaQbFoFisrI7AdaR3xTjbvhoDZLjrV
         tFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748870976; x=1749475776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTdR8ekaPi+ho/nz7+/m7HtqD/FDePRjvip+6j/X07g=;
        b=kit5ZcKIGCbX15g1WLoTBKgSJXd+Le0KaYb/8PSH1MgvF/PS99sf5dQATpLoCg4+tV
         2TESMawY1jdvoAYhEv7NgYDyVqkHS1BNTS9GBF3CPjNKw/HLygqTzQxfomQwMSiF30pe
         tosrM65xyimQw9c3s+hIZ0u3HgoLgunxPOPiTBDp0hUUT/U3iWTdAbVBblxnitSLZY1W
         Gif5FH40zkyTBSfT8ETic4KoEFw2K4+oTjwKwnjyZzOvCcrPV/e3yVBBs57jDpO/mNWA
         ounKzJ2ctjFVOAf+Xj0PLmStPrptt7f7pv0z2zt0DWR+smVij/EJqS4DRcLI39dKwgjP
         ye7A==
X-Gm-Message-State: AOJu0Yye+7Vb/JeLWOoSmcSbJzBBJvl+UHOCqdVGTFdsrtBexsLgjTc0
	58RQ2mAV08P31kX3EDc8BCtdLvQXtrG/3Fp6a/Nq6Z6ZDPoW+i+NOegG03MVSAe6
X-Gm-Gg: ASbGncuIYvxDfhdClTWjfZMwXJhC/AlxJ1/+uQ8Tu3eEWTZXAQCCN8wHdGr75/IF9K1
	IbezUSt/umq2Q1Td/EYFtOGdyCTHN2h1+UM7CvontGfJpFV9R9xZofEqxb3vTJL+1gYN3V+KJ8i
	CXEVpT4TCUnXobL2st+gTYtkAjjDnF4OiPqQDqlM2C847i+4ViY64ZZjuVvCk7ZDDE6erORpkRz
	3GMr9KWW6Oon1MijLf3jNX6lPtl32XjX/L76t4ok3Q0U/cDAN6XjexCIST8iu7aYPCKlx7gBIyq
	McUKIzAC+ckZci+fbpCOQeJivqWNkgS2+NQiaergM1IcT18=
X-Google-Smtp-Source: AGHT+IGc5k5jB+COi5Ph4fPViQYys+RXLfpYHJ1oEXFP0vqFaRqlX/z/O56ekby3dVpoBH+Bt4LAbw==
X-Received: by 2002:a05:6a20:e607:b0:216:60bc:2ca9 with SMTP id adf61e73a8af0-21bad1eda78mr14744330637.40.1748870976116;
        Mon, 02 Jun 2025 06:29:36 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-747afeadbadsm7851991b3a.58.2025.06.02.06.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 06:29:35 -0700 (PDT)
Date: Mon, 2 Jun 2025 21:29:33 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/1] fsck: ignore missing "refs" directory for linked
 worktrees
Message-ID: <aD2nPXIXugVXfIpg@ArchLinux>
References: <aD2mhOlwl1LSYnpe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD2mhOlwl1LSYnpe@ArchLinux>

"git refs verify" doesn't work if there are worktrees created on Git
v2.43.0 or older versions. These versions don't automatically create the
"refs" directory, causing the error:

    error: cannot open directory .git/worktrees/<worktree name>/refs:
    No such file or directory

Since 8f4c00de95 (builtin/worktree: create refdb via ref backend,
2024-01-08), we automatically create the "refs" directory for new
worktrees. And in 7c78d819e6 (ref: support multiple worktrees check for
refs, 2024-11-20), we assume that all linked worktrees have this
directory and would wrongly report an error to the user, thus
introducing compatibility issue.

Check for ENOENT errno before reporting directory access errors for
linked worktrees to maintain backward compatibility.

Reported-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     |  3 +++
 t/t0602-reffiles-fsck.sh | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4d1f65a57a..bf6f89b1d1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3762,6 +3762,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 
 	iter = dir_iterator_begin(sb.buf, 0);
 	if (!iter) {
+		if (errno == ENOENT && !is_main_worktree(wt))
+			goto out;
+
 		ret = error_errno(_("cannot open directory %s"), sb.buf);
 		goto out;
 	}
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index f671ac4d3a..9ff91d1a2b 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -110,6 +110,23 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	)
 '
 
+test_expect_success 'no refs directory of worktree should not cause problems' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git worktree add --detach ./worktree &&
+
+		cd worktree &&
+		worktree_refdir="$(git rev-parse --git-dir)/refs" &&
+		# Simulate old directory layout
+		rmdir "$worktree_refdir" &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_expect_success 'ref name check should work for multiple worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.49.0

