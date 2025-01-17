Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629E35960
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105679; cv=none; b=f+cip6zWmEyWF7QF2EXx7r/k3H/op4BWhPW3hrcLAUKodKTWHNWmP7F+g/xjzN5YJdAytqXa1Jf9BOb9nucPiAVsOkZrZOWUzx1Gtao2dfOhCxAgUzATf4IgZvrjwBGEsEATVXEqqTLr5TE4PmTltXOhUC67pwtzH54mk273Rvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105679; c=relaxed/simple;
	bh=jkZZ7IFfVeJdcQLYtnEx2tb2+OGWcVIo2VdxyTbfzbI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=hjdhxMxS+A2r6tbL7Mkk4zJZP5W+OyfUm3j4mdOOcp4O6/KmivYA+V4U1vHfXXRTq9JQN8i9ISQ6jPnGPqmcUn7Vgyqd3ax5IX15cTEKST8P5JAMpvh19rwLBj4OYeIDIQRDsEsu4z+c6qFxAgPMLDMI3cTgf5LrWxOHh8E19B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmmKJ662; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmmKJ662"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2163b0c09afso34835275ad.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 01:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105675; x=1737710475; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/ei+Y9vkI120XS40gnOnzTy1lp27ZhG/0F7FhxY498=;
        b=dmmKJ662mFdSwULmPpUI3DgI2uQdjzMGilTlbVYtgBMV3slAM8hUkCepitUfx8ZF9q
         A6giFmRn9hSvYNF9XlGVTNJz8W3IyILqH9dRv284d3OCX789QxfONQdGAg3dE43h05E1
         anT1BNytFof3PVI//0zHWa1XVCHrPWCLdmuQ5pLaajQv1fTV2m7t31XFg4SnVYWSnM/T
         lQ3luL90LBpPZqyZCIkPjAosWEhclGw/BqmMo9wH4FunJqcXXd2N5N0rXI4mimAOd/S3
         g2gW9REevBHHlcDRGhIV97itbF2ZvVNrRAb2Pte76u1nRN9bf0DpEKTwTWtUgw+XoADy
         TJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105675; x=1737710475;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q/ei+Y9vkI120XS40gnOnzTy1lp27ZhG/0F7FhxY498=;
        b=BfrU2UFTB4fEyjD0yqGsYsu6bzgT6l/Nu3TX5bd6Ew8Pn8ULmiJnqOSG/M0VtO81lq
         c9UtqZ7+pTWo1livd7X0KmG2MAaI5G1/Y+CPWLMOvNSaXC4tKetOnHWqc3mf8nNCzWIi
         vxxk9kEm4mM0Y2jSzsBHmWJZW9SwcW1grBHFE8VcxRYkbdNkm8gNGr528b0uucD8REe3
         qUVXnGjP4fhQ5UK08IPU2p6fCDLSQqvR5ptI4dYleL4o2Kwzbl2nmoxhYAHW8BTVHdAR
         +0jnrZxMYZTIG+EJ/NXyMi9gTAnYsKJd9uM4WSH4yN0gf5gtFgpb6uSu1d+jlFwxbvjS
         cF7w==
X-Gm-Message-State: AOJu0Yy8CARGI77oXd72sG5GFae+uGkdGZja+Fa/I3Myq5SMflqohDDA
	tM+HItDChGMv6eww+QPEOEIMYpkzUWtOMWzVu7giYWGvB1gy28m/I8l8PKbQ
X-Gm-Gg: ASbGncvZxmjhsSqpWHiK2pXUshzEWReJiV1kPU+OzRI0lzoGjvYOFgIAc7+hVrJ2lc5
	CEzHlP68H71Fa6dlWxDMcbdYxYqmyoM2r8sfJYOTPQQVVz/PSVcHXzmYa0xZYWoMkN/QYgaqLmi
	+kQKoRXloOJzGTS4taPbft5DIt3688FNAF0RMCek/vKWGrlyM263kQJGCFy6wiW/0N28MSHvwAL
	uT3Gr0FlMACD/7k99j5zigKBoD0aOdppzdJwmNcZV3AaRCOVxm5RfRAuIU=
X-Google-Smtp-Source: AGHT+IExQ/xDoTBVPRacqSO2i5+swMt1en8rYtKvf9Yh9KE7mzTssPAryLDYxIqYtjZxWpT5W8cQDg==
X-Received: by 2002:a17:903:41c3:b0:216:4883:fb43 with SMTP id d9443c01a7336-21c35594385mr31429595ad.32.1737105675234;
        Fri, 17 Jan 2025 01:21:15 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e088bsm11714065ad.173.2025.01.17.01.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:21:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/5] pack-write: cleanup usage of global variables
Date: Fri, 17 Jan 2025 10:20:47 +0100
Message-Id: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO8gimcC/22NQQrCMBBFr1Jm7UiSjiKuvId0EdJpO9gmJalFK
 bm7seDO5Xvw398gcRROcK02iLxKkuALmEMFbrC+Z5S2MBhlTkprhQ+Py8AYeQ7oRrb+OSORJuo
 smdbVUJZz5E5ee/XeFB4kLSG+95NVf+2vd/7bWzUqtKYjd2HtyNW3frIyHl2YoMk5fwBsiR0vt
 gAAAA==
X-Change-ID: 20250110-kn-the-repo-cleanup-44144fa42dc3
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5300; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jkZZ7IFfVeJdcQLYtnEx2tb2+OGWcVIo2VdxyTbfzbI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeKIQftvciFL3NlBlXGz/uCX7GYI19a+6KQe
 uf0iI/GT1j71YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniiEHAAoJED7VnySO
 Rox/PQML/2Et4E+onfP+PHY7QCEO2aWdj2S+/NoNamvohoe4LVCTISkdyYfGnY1ETRgEr4xwZQp
 SXz9zIBTSlMmacvA7R1/m54Dyc9MykEsfIIczzmP1gvqg9V49ZvjV6sVDGJc1j0RcsfgThRoP3z
 rjgqtXljFtEEUs/46iJ0YXBp1DEciNW3XqA3n9Hbg72O6533y3x2pExts41QUvveBdR3v/hqWjD
 LI+Wa3gmfVfvt4x2vgK+eWNX7n+xqihVVxWrZxpIWJxChER1V6fbG4ixyZvlr25mx4dpirou8EW
 xTNPr+Tu5Ym2g/mjSBcNx/jORFqhjYLRi8XItupAVWfkS4kHmOH6Z08RD7yG8TLgWojENXGka1B
 IVF3WjwQYIyE/TcgidqUW7j1EI7KnzsvVAovsRfHBjNgDa6iBR4KJhuPV8iFRL87/zNuZs2uhYD
 eUarFZ3yTsIheWlRCOhsTT5W+TYd2BYNo0xx/PCRqzcmnTNPecZ9J0kWccMVuBGKnVP3FCZyYN7
 JY=
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

Range-diff versus v1:

1:  4e365523a5 = 1:  ed4ba01c95 pack-write: pass hash_algo to `fixup_pack_header_footer()`
2:  efa224f83b ! 2:  10aeaa5afc pack-write: pass repository to `index_pack_lockfile()`
    @@ Commit message
         variable to access the repository. To avoid global variable usage, pass
         the repository from the layers above.
     
    -    Altough the layers above could have access to the hash function
    -    internally, simply pass in `the_hash_algo`. This avoids any
    -    compatibility issues and bubbles up global variable usage to upper
    -    layers which can be eventually resolved.
    +    Altough the layers above could have access to the repository internally,
    +    simply pass in `the_repository`. This avoids any compatibility issues
    +    and bubbles up global variable usage to upper layers which can be
    +    eventually resolved.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
3:  6cca689d32 ! 3:  a4dbc3906d pack-write: pass hash_algo to `write_idx_file()`
    @@ Commit message
         to access the repository's hash function. To avoid global variable
         usage, pass the hash function from the layers above.
     
    +    Since `stage_tmp_packfiles()` also resides in 'pack-write.c' and calls
    +    `write_idx_file()`, update it to accept `the_hash_algo` as a parameter
    +    and pass it through to the callee.
    +
         Altough the layers above could have access to the hash function
         internally, simply pass in `the_hash_algo`. This avoids any
         compatibility issues and bubbles up global variable usage to upper
4:  b29eb6a305 ! 4:  d06d8ee962 pack-write: pass hash_algo to `write_rev_file()`
    @@ Commit message
     
         The `write_rev_file()` function uses the global `the_hash_algo` variable
         to access the repository's hash function. To avoid global variable
    -    usage, let's pass the hash function from the layers above.
    +    usage, let's pass the hash function from the layers above. Also modify
    +    children functions `write_rev_file_order()` and `write_rev_header()` to
    +    accept 'the_hash_algo'.
     
         Altough the layers above could have access to the hash function
         internally, simply pass in `the_hash_algo`. This avoids any
5:  438bfec4de ! 5:  1e34f5a70c pack-write: pass hash_algo to `write_rev_*()`
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    pack-write: pass hash_algo to `write_rev_*()`
    +    pack-write: pass hash_algo to internal functions
     
    -    The `write_rev_*()` functions use the global `the_hash_algo` variable to
    -    access the repository's hash function. Pass the hash from down as we've
    -    added made them available in the previous few commits.
    +    The internal functions `write_rev_trailer()`, `write_rev_trailer()`,
    +    `write_mtimes_header()` and write_mtimes_trailer()` use the global
    +    `the_hash_algo` variable to access the repository's hash function. Pass
    +    the hash from down as we've added made them available in the previous
    +    few commits.
    +
    +    This removes all global variables from the 'pack-write.c' file, so
    +    remove the 'USE_THE_REPOSITORY_VARIABLE' macro.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     


---

base-commit: 8b2efc058aaa3d1437678616bccf7c5f7ce1f92b
change-id: 20250110-kn-the-repo-cleanup-44144fa42dc3

Thanks
- Karthik

