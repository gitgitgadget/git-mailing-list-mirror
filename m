Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72C20DD75
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286540; cv=none; b=p8Z+aFqge0+58NJ0RBKDLm4MoNdT3p58mX230pj4PNofNhGshohl4Qahf27+Hen2KlP9JpQXF7k9Zy+286md7xs5ksL56XffFePcCsLqwQ1P5dABrBqaLnbYRzRWf33tifdt971jJQ6gGfFM5krRWWTii336Qs2QMLF9r65OPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286540; c=relaxed/simple;
	bh=VCjSq+46d4pVw7wnPYlIe8dllBEHBjHvDehX0eig8t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjM8OZNFW8RrOZwi9ZF4BMrxjjp2cYPbcSJGC3GqLwS1W0MCG4MXOQBzHqoVa162GHOCTHs7CzeU2uL7RfYpFgcalhPVp5eOcgh7s0jUtyJimP2k/9Lc8iRk0xGDTph9W5+JIiJ60NQpBw6ncokHHYe0DhuM8bfLLrkGx9TExtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ozm8pEXu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ozm8pEXu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-353576abcfeso331950a91.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 02:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770286540; x=1770891340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKyyZfxyexjiUCxHJHkNgsY142YbbQ84EP7rM4Fipto=;
        b=Ozm8pEXuWPplG31mlPAIGx2KUYuklg0Lg5AvppLhlkVw3RJWsTVhBSTQce4W0+fmRu
         2ZcmrgbY4SsyQ7WLB+47jBgEYQDdXPPjuS39GAAKlC+VpRMITiSgT54e2GmHBnb0uzDl
         Urhp7d7z5WeswIhiiPWz3c48QhVsE9WOkINcCQt2V6dWLXEkLU2g7XAykjLHZ/jvXqyZ
         +qlBnIHoKkIoRpDl7/dk2zwUd9BP3U5t5grU4mYS48OQxYA8u8zdXNgmdOmaySX2bBxm
         ecZAxxoQKFafyE/paRP+ve9i5ZRkAkTMbpm7BGKiMI5sC9CCrIpaasuzZDRk7i1Pvij0
         qeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770286540; x=1770891340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JKyyZfxyexjiUCxHJHkNgsY142YbbQ84EP7rM4Fipto=;
        b=GpC6u9tE72pOl3y1tsHu8qrtyBRWtODL1nR7OoRLYRUwM7UE8I119aAdVzzpWsMKho
         oke0+YSylcpHYnIr3N7HeTvByIZXaGIW8V9sKZXFAhM+/WOu5cjlXyuWLcyboLB5LOu4
         OpPmHHk9IpbecFSkcsl7sg08ytodhQcutN927xWjyZi17jtR7DcufUimNL3Lb/j1sNka
         DVAhnrF7DP01Cs/PmJUJImp6a9hkhGPY3DGJXrOKwb89CSMwEfJ4cBYyCKypIS+KOZqz
         5+1DsMJzKNfp/6JVD5vVVcIrVQgJF7Z4Pse9O0/0BFSkAuHA9Sb1lrrGiIHA8xOzo34d
         Cekw==
X-Gm-Message-State: AOJu0YyRIfVrR19eq3Wb40ZbfT1bGufO6xzzjUL7tBFej2IYRK/qj988
	GZbG0PW5anTHtbVh9fh96+eqDO7SV5U/1i6kjnVjvSPwy62/V/xTWm3Iwlk4vA==
X-Gm-Gg: AZuq6aJq+Ti69MTXi1szXgKDk7ZhsGvpjYN94nnf1KdUpwJqmSZLhQ28eUZk/vPnXaP
	4mN3iSerJmbuW22kDsx5ohwqvsorFoOsINUJ0ZU9xXc7DOhQY0ZgD1ACRjjoJrdN38g3FD767LM
	M2IFEiGpFj0zZ3i/dzb6zaKH0dsZQ6wYptlOvwLq+nokha5V0Hw29M7GWNfUf3tDyJx8fQiURxc
	Tq7iqsV9iI+kWrPoEOAybf0epZM/XElaQ0eAVv5TPXhf8etPRGGjVKyH3CZRMwS9MaZn7IOPQWy
	gDN07uId83kYvumm2fW4WWRvMRubR27jG9wps7MLHahw+3OpaEovNUI65C8jD0Y3Y0kP5ar/HlE
	X4DhBXTE515fVgithacm5wsDY0FfaoAxxGejbOeXRSKOnawyc1d33M7RhAch5mMVsIRLSYatKOj
	B0MYZlFwlf51Nhm+uDRkIVZcOBPxKhgi+BXWkmUDMeJSgyKw==
X-Received: by 2002:a17:90b:2548:b0:354:999f:1b22 with SMTP id 98e67ed59e1d1-354999f1bc0mr2218656a91.32.1770286539576;
        Thu, 05 Feb 2026 02:15:39 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:1078:b5ff:8b66:3ef8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c09ff2fsm2071223a91.2.2026.02.05.02.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:15:39 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH V2 0/3] wt-status: reduce reliance on global state
Date: Thu,  5 Feb 2026 15:43:10 +0530
Message-ID: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In wt-status.c code still relies on some global variables, including
the_repository and the_hash_algo, even in cases where a repository
instance is already available via struct wt_status or struct worktree.

In patch 1/3, replace direct uses of the_repository with repository
instances already available in local structs.

In patch 2/3, update function parameters and calls to pass struct
repository or struct wt_status explicitly where no local repository
access was available.

In patch 3/3, replace remaining uses of the global the_hash_algo with the
hash algorithm stored in the respective repository instance.

These changes remove all direct uses of the_repository and
the_hash_algo from wt-status.c and reduce its dependence on global state.

The 'USE_THE_REPOSITORY_VARIABLE' macro cannot yet be removed, since these
patches only eliminate direct uses of the_repository and the_hash_algo,
while other global variables are still referenced.

In particular wt-status.c still relies on the following globals,

* core_apply_sparse_checkout, this is already being addressed in an
ongoing patch series [1].

* comment_line_str and DEFAULT_ABBREV, these both still are used in
wt-status.c but they dont have any equivalent local instances.

[1]- https://lore.kernel.org/git/5e56e1cc4172cfff9e917a068184e102aa70bf1d.1769256839.git.belkid98@gmail.com/t/#u

Shreyansh Paliwal (3):
  wt-status: replace uses of the_repository with local repository
    instances
  wt-status: pass struct repository and wt_status through function
    parameters
  wt-status: use hash_algo from local repository instead of global
    the_hash_algo

 branch.c    |  2 +-
 worktree.c  |  2 +-
 wt-status.c | 85 +++++++++++++++++++++++++++--------------------------
 wt-status.h |  5 ++--
 4 files changed, 48 insertions(+), 46 deletions(-)

-- 
2.52.0
