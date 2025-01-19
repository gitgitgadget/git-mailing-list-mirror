Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F32905
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737285578; cv=none; b=CQqjSqBgHlkxMjHRfylazCle72KaxP0edbvI+Z0sSkHh4nmZ9UhWeL7RSRwulFlpupp3+UfI//DpQBE14/4a0FZmGXAf+jlpr4DoJvWIniEFt7YMe7yeGAsEgbM6R0y6KVMH/6sWXYARpmvtea6rqpE7tOMid019CFe37xOoOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737285578; c=relaxed/simple;
	bh=hksWwzi2dvXXEoci+jhlQjfKuO3PuQ6bZ4kz/uhBTy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=EMoxPEZ338RqoN7K/Vdf1SBy/akL9UFcIrqX42si1f6EiGcjTXiqs37a2kq0zCL7N+VjfmL3tU3xJJ7RsBedcQvrmyDG/aJKI0UEWHtKdLOo1cc9VuLjX1Uizdxw4ePQzSLjvdprVwt5Ktx6E0JnAvrB2yrRBzKRrvF0kEVCDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJAu4Jk3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJAu4Jk3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2167141dfa1so62156895ad.1
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 03:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737285576; x=1737890376; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTPkYXHTCb/unZcEkdhMtMlQum1ZUhLgkGnk2aW1E6Y=;
        b=fJAu4Jk3EWunRYIF0A3Yr6Q8oMQtNZCCjfEfa0IORjkKTdBPSdsnuERzeknuhP+kwY
         3suvGL92/4RosiJ9tklsRUQVsn3oWC65HBV5xd+W0eGgG4GFYzCzEULqfNnCFuVRioAg
         TMNDPzuosDo6fEg31/f2ekUqJC4z1k7eaBpj/LgyPpXFz4faHsz/Yg2Wv8vV9tUh46x0
         F5uM77bJksoPYWdQF4foVV1sMmu2A0UfKh0DzfEYdD/gVneP9zJFJXvSsn2cPDkUDqVv
         Jr0/6aEgMdZ2JzItM5B+6wXtaJfHxbRcdmnCrxV7CKBwia3JjyVOFYBzzwC473pt4GdH
         1+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737285576; x=1737890376;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jTPkYXHTCb/unZcEkdhMtMlQum1ZUhLgkGnk2aW1E6Y=;
        b=gs6MlIOPQ9dTbjaz5FI1I3h9WzZRxoyOa+HFwl2EPDZgNUMh4AE5v0bS1GrhLtVo7w
         XJrrBeV0QdkzVQj1JZVwPteikD+od0FsXJzY80anHhgtwYdy23yutdBwTpTwuyIiR6op
         IlJjS4ap0V+Kzur9mAMPgiTFonYnC5Ay2xa5+etB3V5Flegx6zewMlfYt7MzTz12daK/
         pM1WJmFDdM5gjBNXQtTEdD/L4ixnEblhDr27fGVB7l3pDD3cCfYeYszi0kVAfhxOm+n5
         lfsfPVjrEywFaNsCBuX0P7sZT+Jk3Ky90OQGBK+Li5mbJpY2BPeAoM80kSuM4q7xAYfz
         b22Q==
X-Gm-Message-State: AOJu0YyvA2/fiux/aU5T6Pb0K/ePTLDx9lVFPfOo5CEOrQr5+3L8PrVD
	NEZ1pHRbFmYEkRNvt5G+nqe10MMJWccukY0tKEqplqaXMv+bT/4nVS4CMxKE
X-Gm-Gg: ASbGncvC6lgoFKEdD8fyLthUmuFxHu9y4Y0ikWDReLWGKE7w2Y6XBT3uFf8Wf2tur+Z
	3ADh7c4fiTpQ8iGqw1Eke6Wo9/V93SrlQ0cWjpFmVhyKLhkEcZjwKMy2GfmjvxXI4fDiBEdKnvd
	wzOBXyqvEY74bAcPnGsXdqOUR2HVBctjwFnmQ0+2YGdTMOGOvPePQt+bgsre0aVr3Rwii8+J2nu
	SYvhQkl7rIPcbQ6X+aL9FGi1fljF/61zouOfJum0Rhr0L11VmZMq4SlusYmVOzIt60l7wvj
X-Google-Smtp-Source: AGHT+IHDcIalOINg7bmL2KO5sxFd3ehK67nOTXoUcqm3HJJX7fqNMJCHOF6rQe6+ufZ4xpmErbH9BQ==
X-Received: by 2002:a17:903:238e:b0:216:311e:b1c4 with SMTP id d9443c01a7336-21bf029e049mr233426295ad.4.1737285576281;
        Sun, 19 Jan 2025 03:19:36 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cfbd01fsm43031415ad.104.2025.01.19.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 03:19:35 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/5] pack-write: cleanup usage of global variables
Date: Sun, 19 Jan 2025 12:19:25 +0100
Message-Id: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL7fjGcC/23NTQqDMBCG4atI1p2SxPjTrnqP0kUYJxpqjSQ2t
 Ih3bxQKLly+H8wzMwvkLQV2zWbmKdpg3ZAiP2UMOz20BLZJzSSXBReCw3OAqSPwNDrAnvTwHkE
 poZTRSjaYs3Q5ejL2s6n3R+rOhsn57/YkinX9e+WhFwVw0NIorEmgwvzWvrTtz+hebPWi3BvVs
 SFXozINiktZ16bYG8uy/AB1AX9D+gAAAA==
X-Change-ID: 20250110-kn-the-repo-cleanup-44144fa42dc3
In-Reply-To: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 toon@iotcl.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6885; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=hksWwzi2dvXXEoci+jhlQjfKuO3PuQ6bZ4kz/uhBTy0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeM38R407CZhQtaGyzeoPrcQnxCSEsjTIr0P
 pQ7AX4nr01ueIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnjN/EAAoJED7VnySO
 Rox/JPoL/RDnxyRe8V9pdULudHqlfZ9QgxllwlZYjvIfwx5GKHUW9Uf/31m/kBGnivmQ3UhTpOL
 +kXs31dKP/72pwrXcJKVZBKRFOvZi8uvfXAN+1QS7sSF5oVMAMHoPZUlgznVLIega9IN4Y7sFcY
 0VBi1vSgp2KrnzTFtnWnct+z8FVVGg3bWVJeR36ZFFctRl03biAJXMMkVh5sC5oqBVg6qk6GzJO
 397aJJlMcRbtKvu6YQdkhQjEhecXLH6c7bgusT1MNyPqgrH4mGkvQDF74Vo7orHhQSz9eLo0XYt
 xCUxL7PAeKuMiMDWDOViEx+n/hv/k8hLvM3FWozGasPkfVvxLg4LpVC4AOSm3LZkYj3eOB3NPgh
 CvUOeYqiKjzXF/olGjx/f6+Lvy+ttzv4LnBE7APw16dAX5I6T+QWKpr9W7PRJU4LTu32MsOJVFc
 HC+YSDBL6f7iKRnP+6HuzLvYxAZba8ys2/h9ZKoZDKFeIcphhpJpTeyJhWlY80Mlp8DiSR6g/I9
 Kg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This is a small series to remove global variable usage from
`pack-write.c`. Mostly it bubble's up the usage of global variables to
upper layers. The only exception is in `write-midx.c`, which was cleaned
of global variable usage, so there, we use the repo that is in available
in the context.

This series is based on fbe8d3079d (Git 2.48, 2025-01-10) with
'ps/more-sign-compare' and 'ps/the-repository' merged in.

There are no conflicts with topics in 'next', however there is a
conflict with 'tb/incremental-midx-part-2' in 'seen', the fix is simple
but happy to merge that in too if necessary.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v3:
- Fix the ambiguous commit message in the last commit.
- Link to v2: https://lore.kernel.org/r/20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com

Changes in v2:
- Fixes to the commit messages to:
  - Fix copy-paste error s/the_hash_algo/the_repository
  - Mention why certain functions are modified
  - Small cleanups
- Link to v1: https://lore.kernel.org/r/20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com

---
Karthik Nayak (5):
      pack-write: pass hash_algo to `fixup_pack_header_footer()`
      pack-write: pass repository to `index_pack_lockfile()`
      pack-write: pass hash_algo to `write_idx_file()`
      pack-write: pass hash_algo to `write_rev_file()`
      pack-write: pass hash_algo to internal functions

 builtin/fast-import.c  | 11 +++---
 builtin/index-pack.c   | 11 +++---
 builtin/pack-objects.c | 12 +++---
 builtin/receive-pack.c |  2 +-
 bulk-checkin.c         |  7 ++--
 fetch-pack.c           |  4 +-
 midx-write.c           |  4 +-
 pack-write.c           | 99 +++++++++++++++++++++++++++-----------------------
 pack.h                 | 30 ++++++++++++---
 9 files changed, 106 insertions(+), 74 deletions(-)
---

Range-diff versus v2:

1:  d3812f88e6 ! 1:  5f646111d0 pack-write: pass hash_algo to `fixup_pack_header_footer()`
    @@ Commit message
     
         The `fixup_pack_header_footer()` function uses the global
         `the_hash_algo` variable to access the repository's hash function. To
    -    avoid global variable usage, pass the hash function from the layers
    -    above.
    +    avoid global variable usage, pass a hash_algo from the layers above.
     
    -    Altough the layers above could have access to the hash function
    -    internally, simply pass in `the_hash_algo`. This avoids any
    -    compatibility issues and bubbles up global variable usage to upper
    -    layers which can be eventually resolved.
    +    Altough the layers above could have access to the hash_algo internally,
    +    simply pass in `the_hash_algo`. This avoids any compatibility issues and
    +    bubbles up global variable usage to upper layers which can be eventually
    +    resolved.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
2:  89255a4822 = 2:  696e991823 pack-write: pass repository to `index_pack_lockfile()`
3:  5ccf220732 ! 3:  21fefb8279 pack-write: pass hash_algo to `write_idx_file()`
    @@ Commit message
         pack-write: pass hash_algo to `write_idx_file()`
     
         The `write_idx_file()` function uses the global `the_hash_algo` variable
    -    to access the repository's hash function. To avoid global variable
    -    usage, pass the hash function from the layers above.
    +    to access the repository's hash_algo. To avoid global variable usage,
    +    pass a hash_algo from the layers above.
     
         Since `stage_tmp_packfiles()` also resides in 'pack-write.c' and calls
    -    `write_idx_file()`, update it to accept `the_hash_algo` as a parameter
    -    and pass it through to the callee.
    +    `write_idx_file()`, update it to accept a `struct git_hash_algo` as a
    +    parameter and pass it through to the callee.
     
    -    Altough the layers above could have access to the hash function
    -    internally, simply pass in `the_hash_algo`. This avoids any
    -    compatibility issues and bubbles up global variable usage to upper
    -    layers which can be eventually resolved.
    +    Altough the layers above could have access to the hash_algo internally,
    +    simply pass in `the_hash_algo`. This avoids any compatibility issues and
    +    bubbles up global variable usage to upper layers which can be eventually
    +    resolved.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
4:  95b1f784e2 ! 4:  3f730b26d1 pack-write: pass hash_algo to `write_rev_file()`
    @@ Commit message
         pack-write: pass hash_algo to `write_rev_file()`
     
         The `write_rev_file()` function uses the global `the_hash_algo` variable
    -    to access the repository's hash function. To avoid global variable
    -    usage, let's pass the hash function from the layers above. Also modify
    -    children functions `write_rev_file_order()` and `write_rev_header()` to
    -    accept 'the_hash_algo'.
    +    to access the repository's hash_algo. To avoid global variable usage,
    +    pass a hash_algo from the layers above. Also modify children functions
    +    `write_rev_file_order()` and `write_rev_header()` to accept
    +    'the_hash_algo'.
     
    -    Altough the layers above could have access to the hash function
    -    internally, simply pass in `the_hash_algo`. This avoids any
    -    compatibility issues and bubbles up global variable usage to upper
    -    layers which can be eventually resolved.
    +    Altough the layers above could have access to the hash_algo internally,
    +    simply pass in `the_hash_algo`. This avoids any compatibility issues and
    +    bubbles up global variable usage to upper layers which can be eventually
    +    resolved.
     
         However, in `midx-write.c`, since all usage of global variables is
         removed, don't reintroduce them and instead use the `repo` available in
5:  50da9bf405 ! 5:  7d1d42ca67 pack-write: pass hash_algo to internal functions
    @@ Commit message
         The internal functions `write_rev_trailer()`, `write_rev_trailer()`,
         `write_mtimes_header()` and write_mtimes_trailer()` use the global
         `the_hash_algo` variable to access the repository's hash function. Pass
    -    the hash from down as we've added made them available in the previous
    -    few commits.
    +    the hash_algo down from callers, all of which already have access to the
    +    variable.
     
         This removes all global variables from the 'pack-write.c' file, so
         remove the 'USE_THE_REPOSITORY_VARIABLE' macro.


---

base-commit: 8b2efc058aaa3d1437678616bccf7c5f7ce1f92b
change-id: 20250110-kn-the-repo-cleanup-44144fa42dc3

Thanks
- Karthik

