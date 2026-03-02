Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197DA387584
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481659; cv=none; b=m0z6pN0GOc5zBTJT8Css1B6n5UMDGy3pFWUK/q7WM03h2G7X2DVHzFb9F3eQXsantT3zlyqvkHXELivvPj9mrwQInWUPh1IpS7AazGx33xjHOfv9RBQ+2crr5IpvvYX21Y+d8Kie+J+SYh2Z+ukn6Suj0khjc/p6Ksq08LfLbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481659; c=relaxed/simple;
	bh=jEtNScX61IR+kllc9QdiK2CEwNExmlcOaMGPALFkQ9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3dUCs5otYNI3KiC3F+M8uDGQfJzXywEaTJ7Oy8fivVJ0iK+CKYD71ICRvUlNF8Ajt5FpTVtbjDtwvZZmiu6Z5YzzaX3B6hBMpw/5ZK19zq4O9gkIebTlgVymJWW1tLA+sPAYVr0FdIUVVqvMIZd5gDvu6Xb/7//31/kPJ9n+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1xlwR3b; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1xlwR3b"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48336a6e932so30551285e9.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 12:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772481656; x=1773086456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4Q4jxbkEu6Q4EfZ52Hc5lPEnRCwxVG2FPZoZ8BBnwE=;
        b=Q1xlwR3bZLijWcU0mqFSKOlqakNaCAD1PkzTJ+z7gsKyPwDGCC55291VAlmVdBbPUr
         fCE3hsyq0jWKBkJ1fHb7svSyKvGzesIiwKDTgLCpKO6ysTjzGOr9prelLTi7dYOIGHbW
         lhL5eEwH+vLxsnnRWAICKHcAAYilt/4FjsJ1HMvYZRaQ8piwHxT4/CAZnpPZeCKAoOQu
         Gwm10LoCx0QABDY7AcOWWxF1THCJsIlMT/XmSjRIQF7vCWGqbybyxLgMw6VxFfbYRjp5
         qQ+EDIER8r0Tvr7ZkctbSWPltdS0e5jIqrNWOj8MPk4wWivpaDnVaaVv6eTYonclWKv7
         FWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481656; x=1773086456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4Q4jxbkEu6Q4EfZ52Hc5lPEnRCwxVG2FPZoZ8BBnwE=;
        b=Ll+dZsRuREdZb9O3HVIXXp4M4SYhiRu6apbtrL0gXGEteV9qgShn4aBZwruFbnATqb
         Gz9auaTFlVjLRVeLE0gJ8IOrLVQi60cY9VP0+Zb2MLxm93oTPwev7gk132/1gBfwWwMK
         I0oa99erFKIbao8TyPCYHeR4nFD+lONvYVjcAGmQffAzWdC3KErdkCK7b2CYjURKYxpI
         3Y2SyrPgzz+oSPNJosqQ68nUkSN2SB2Oh7lsrNAI2dFM0oAydFUDc0XLjGNGIiJypD17
         D4ymFpEhnrC3B+4b1EQBwMg1OXn4Xm4U1suwV4LVnr3h0B2L/0t5uHI6sgms8NpcXIN2
         6XIA==
X-Gm-Message-State: AOJu0YyBi8O+mBYr5DgHSKStHTw21at2D+rzxSgxfvm/3sPkXUim9ewb
	KFFNqOqWGwdIj8LSCswQT374ZVpBCJG4LkHzjH9ZFw+U2ymMQYnXJmWJp2ZfG3/1
X-Gm-Gg: ATEYQzxp97nRckDFWtOHHjKNpRPVDYDTkQknWFE+pUCStLptjHuUWn5FZ7D4W9ak0QE
	5THPOt9lE6W1QnDr0m2rt73M/1/3CmgbNTuLK1I1ktjAf9BN//95tC9rr4/yc6YzNFtCCTMvdfb
	aYSEscKCMH5MIQd0PvQgYnFp1j3c7C8V/jWc0TuM9EXW/nj7Fq43U2Mddc/ZZQ9T93gtaXXwssx
	PEK++SfOc+c10MfG/SBh0SYDdyn/I5ziNZ6mdlsA/Y/fMZmqge07sZHgiM+POOX5o9vk37pCUNc
	p0HNk6FG+erLStegKiWYVA7CykAdrQM9/AaKgEwQcpDzaGIsaEXQKji8tUNuSQJcdLy3OQK3g7g
	pBljkrsDpYMIJJcyZvnJWP42o1kKAvqyBf6ldh93BfRupnPJ/O+pDGQCggj80cpdjcNl4Ss1y1e
	u/M82yJ7pEyHMYJVMK17HZeARY+3Ri7LmO/0KQb6F0TDNUSmI1OFW8T4WVPWfW6ElxTRD0KLs=
X-Received: by 2002:a05:600c:3507:b0:47e:e946:3a72 with SMTP id 5b1f17b1804b1-483c9bc576fmr236377195e9.27.1772481655593;
        Mon, 02 Mar 2026 12:00:55 -0800 (PST)
Received: from localhost.localdomain ([105.113.67.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126547absm446875e9.7.2026.03.02.12.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:00:55 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 0/5] oidmap: migrate cleanup to oidmap_clear_with_free()
Date: Mon,  2 Mar 2026 21:00:12 +0100
Message-ID: <20260302200018.75731-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227234213.17633-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series replaces oidmap_clear(map, 1) with
oidmap_clear_with_free() and introduces explicit free callbacks
at the remaining call sites.

The old boolean-based API implicitly assumed plain free(),
which obscures ownership semantics and does not work well
when oidmap_entry is embedded inside larger structures.
The callback-based API makes cleanup explicit and type-safe,
and avoids relying on hidden assumptions about allocation.

This is used in subsequent commits to adequately cleanup all
usage site.

Changes in v2:
 - fix missing .path cleanup
 - modified commit message to be more accurate

Thanks
Seyi

Seyi Kufoiji (5):
  oidmap: make entry cleanup explicit in oidmap_clear
  builtin/rev-list: migrate missing_objects cleanup to
    oidmap_clear_with_free()
  list-objects-filter: use oidmap_clear_with_free() for cleanup
  odb: use oidmap_clear_with_free() to release replace_map entries
  sequencer: use oidmap_clear_with_free() for string_entry cleanup

 builtin/rev-list.c      | 15 ++++++++++++---
 list-objects-filter.c   |  9 ++++++++-
 odb.c                   | 11 ++++++++++-
 oidmap.c                | 23 ++++++++++++++++++++---
 oidmap.h                | 15 +++++++++++++++
 sequencer.c             | 10 ++++++++--
 t/unit-tests/u-oidmap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 114 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  a0ab068630 < -:  ---------- sparse-checkout: use string_list_sort_u
2:  b2c0ee2593 < -:  ---------- The 7th batch
3:  6af69c2c49 = 1:  1d544ef7d2 oidmap: make entry cleanup explicit in oidmap_clear
4:  452f5d8edb ! 2:  f2c3a699bd builtin/rev-list: migrate missing_objects cleanup to oidmap_clear_with_free()
    @@ Metadata
     Author: Seyi Kufoiji <kuforiji98@gmail.com>
     
      ## Commit message ##
    -    builtin/rev-list: migrate missing_objects cleanup to oidmap_clear_with_free()
    +    builtin/rev-list: migrate missing_objects cleanup to
    +    oidmap_clear_with_free()
     
         As part of the conversion away from oidmap_clear(), switch the
         missing_objects map to use oidmap_clear_with_free().
    @@ Commit message
     
         Introduce a dedicated free callback and pass it to
         oidmap_clear_with_free(), consolidating entry teardown into a
    -    single place and making cleanup semantics explicit. This improves
    -    clarity and maintainability.
    +    single place and making cleanup semantics explicit.
     
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
     
    @@ builtin/rev-list.c: static int arg_print_omitted; /* print objects omitted by fi
     +{
     +	struct missing_objects_map_entry *entry =
     +		container_of(e, struct missing_objects_map_entry, entry);
    ++
    ++	free(entry->path);
     +	free(entry);
     +}
     +
5:  cbfcc4e9cc = 3:  a4e426bcca list-objects-filter: use oidmap_clear_with_free() for cleanup
6:  bfbdb51d84 = 4:  4116e5491d odb: use oidmap_clear_with_free() to release replace_map entries
7:  4fc6e71f4c = 5:  ad1f776a19 sequencer: use oidmap_clear_with_free() for string_entry cleanup
-- 
2.43.0

