Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F123FB1B
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717934; cv=none; b=ATkKsZ4CHe9tlf+qFCf+IulCW7N9djiZoq786nrl3UUKel9cFO+QI+ccRi8iQPC2/Ta0an5u7mn1UJ/8PmwYnvX6eez8L2Vods6OFqlt+j08OI5R3qhGq77e0UnqE0/q7Kp2iK8aIsLp9jyBL6MvkyyG6abDo16zJrbzpJBNiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717934; c=relaxed/simple;
	bh=LnlUPh/KBzZSOrLA99IduY51q0hm6e0wguukv5+VExI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg6uxjwpZzyFxPX+UXkUW7TaXJgSZlAg++2/ntZx3LWyCm/M9ITve8OPE/Gzgh4Y5s79PML47XnnaDmq6Fz1biEadE+Mz1sPpM2Xw+G+mYIyeOmdLEFLjdl8DGWMEurjdpl5oqaKYISXPYZ5dA3IbsbYW4mGc0v8yPs8gjTSbPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OsXoQmjt; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OsXoQmjt"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e4043c5b7so46699147b3.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750717931; x=1751322731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke9V8CxVUTBoCKxY8xuflzmQKkx8XDzEF3CVOZhrEmY=;
        b=OsXoQmjtG54676gTvU3gMZNxp2ccCvus0VS6sX4+jNcvQVTYunWoY+DkZLewQg8pE0
         CuFFI3HU0dcSoe1aSP60/EGt7jp3CzFms1Gvr36Hl9WculJLTh87YmvG+UfzV706oPOW
         p02vE734WTWns3KYVPwqvdNNgXM4ZxHfHIagfrFZ6ChouuDREWTSFBiVts7BL+aLBl8C
         1GOefAehjxiTxPgJwLpTXStQu/GXAW0XEWZhllJMO/cvMQyD1qyXoICfgt+mHjHc8nrX
         kVpfIFCfFVB5iFxrX69I/PMNQ7uxhX3CL1M4yvDk6uSpYk/Eyn9ZWQrCiXVMj4LEQptw
         SPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717931; x=1751322731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke9V8CxVUTBoCKxY8xuflzmQKkx8XDzEF3CVOZhrEmY=;
        b=gUiDtoXQGCOPSI4tMYQ5mADr7Xqqd56taCAI+2TdgjHeWoXYB6VBHnyKkNnCAnpjdP
         KwPbyukRHkj99F8EdWnq6EXj+fOZJgEPA1kJ4puHxCy5kFqMKN+ZfAPWOhTd5DbQ8TKj
         hLJMqJkrZV/PE2eln/wuPFZkIfiijx1pMVbYmvEAhO6e9hzIzDP8jjnoli1KjcfpneVl
         Gv/CF9N5RtFg9IKNsO6leNUwEK+1ixmDv5tz8o6OewrrcKP9gtSWpJvzGrTthr5yxqS/
         U3y2HDOeH9ns64WMpkk/y9kz5lRLKWnexJyVUjJGPtMI2mTMnzKN+3ryZsKgrjRwp+h/
         lN2w==
X-Gm-Message-State: AOJu0YyaAVOqDZcJXjMTaxG9PbF4Ok0dT7Qr/AvdPGSrPiXM5Hyac2yJ
	UEdMM6V1bvn03g9MZCVnsbVh3pHHiDnNnDZztX01sPsZ1ZNmYmTpaXfDo4La0aLE/mXkOsk5CwA
	QdfVF
X-Gm-Gg: ASbGncu7CzdWAJKtFntwoKVTk13RoSGgPcEKRoWdlJMgjPdnyKFxyZoNyCWWois/ceE
	94Sfs6EfGTs8HbpAedIKcvBdTb4CbVWwtPXQa55RJJwDS97I1hT2mPAW4Y7qJCJMkapcjoMTFkj
	RXuraB1krHpYKoP1SYIaMBH1pYqVtCfII852VCnS9HezuDL8TF1t6DqeeD9XOUpg39yN+aVrVY+
	aq7YRtkpbEmH5lgQez9GZeIqBm4Ahp2UjZhPqyFqYu5S1rjsxZiU0PTcIWNPaF8yUyDZAK89XI4
	4aAQ4Zjh0MneGOsQEmUWUHB7OSm44JMFUi7yXmxq91hYLHoeIrOKeG/Qf+oa4KdCeJNVOq9DBxg
	hDSE/qQB08MXA/ghKyXQT7Xw0u9K9b4wS8g==
X-Google-Smtp-Source: AGHT+IF2ekdx02HQVLrlJTDwzpEqnLnKwL8pOGgaFfSkfzWkufANUh207zRWyjOWkBW0JJV+ooY5Cg==
X-Received: by 2002:a05:690c:690b:b0:70c:b882:2e9 with SMTP id 00721157ae682-712c6397952mr204622677b3.3.1750717931299;
        Mon, 23 Jun 2025 15:32:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c49b9aefsm17694637b3.18.2025.06.23.15.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:32:11 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:32:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 1/9] pack-objects: use standard option incompatibility
 functions
Message-ID: <8e7b2dacc77623ada5ee938de7a610ae15f49d8e.1750717921.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750717921.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750717921.git.me@ttaylorr.com>

pack-objects has a handful of explicit checks for pairs of command-line
options which are mutually incompatible. Many of these pre-date
a699367bb8 (i18n: factorize more 'incompatible options' messages,
2022-01-31).

Convert the explicit checks into die_for_incompatible_opt2() calls,
which simplifies the implementation and standardizes pack-objects'
output when given incompatible options (e.g., --stdin-packs with
--filter gives different output than --keep-unreachable with
--unpack-unreachable).

There is one minor piece of test fallout in t5331 that expects the old
format, which has been corrected.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c        | 20 +++++++++++---------
 t/t5331-pack-objects-stdin.sh |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 67941c8a60..e7274e0e00 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5010,9 +5010,10 @@ int cmd_pack_objects(int argc,
 		strvec_push(&rp, "--unpacked");
 	}
 
-	if (exclude_promisor_objects && exclude_promisor_objects_best_effort)
-		die(_("options '%s' and '%s' cannot be used together"),
-		    "--exclude-promisor-objects", "--exclude-promisor-objects-best-effort");
+	die_for_incompatible_opt2(exclude_promisor_objects,
+				  "--exclude-promisor-objects",
+				  exclude_promisor_objects_best_effort,
+				  "--exclude-promisor-objects-best-effort");
 	if (exclude_promisor_objects) {
 		use_internal_rev_list = 1;
 		fetch_if_missing = 0;
@@ -5050,13 +5051,14 @@ int cmd_pack_objects(int argc,
 	if (!pack_to_stdout && thin)
 		die(_("--thin cannot be used to build an indexable pack"));
 
-	if (keep_unreachable && unpack_unreachable)
-		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "--unpack-unreachable");
+	die_for_incompatible_opt2(keep_unreachable, "--keep-unreachable",
+				  unpack_unreachable, "--unpack-unreachable");
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (stdin_packs && filter_options.choice)
-		die(_("cannot use --filter with --stdin-packs"));
+	die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
+				  filter_options.choice, "--filter");
+
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
@@ -5064,8 +5066,8 @@ int cmd_pack_objects(int argc,
 	if (cruft) {
 		if (use_internal_rev_list)
 			die(_("cannot use internal rev list with --cruft"));
-		if (stdin_packs)
-			die(_("cannot use --stdin-packs with --cruft"));
+		die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
+					  cruft, "--cruft");
 	}
 
 	/*
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index b48c0cbe8f..8fd07deb8d 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -64,7 +64,7 @@ test_expect_success '--stdin-packs is incompatible with --filter' '
 		cd stdin-packs &&
 		test_must_fail git pack-objects --stdin-packs --stdout \
 			--filter=blob:none </dev/null 2>err &&
-		test_grep "cannot use --filter with --stdin-packs" err
+		test_grep "options .--stdin-packs. and .--filter. cannot be used together" err
 	)
 '
 
-- 
2.50.0.61.g1981e40f2d

