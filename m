Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0125F975
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197796; cv=none; b=IYhn1w4Rs8upA+hyqSfCfW3qEU/YQ2U8GPb5RtA+etxudxy2qN9D8Zbf8zQ4ok6y/c+bALC6dCwRpVfgLYamUC5UvhMlHsgqRhmb7uBwGLcyJlUXNHqzNKf7LTFl3iIH/KQtlm7APDXCH96FGhg9Vlb2vk/ApTDoaAy/tQ1fRfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197796; c=relaxed/simple;
	bh=BoHa9RYFONDeHjkhXIUtS91tQY50sSf3oPkGwc/fQHI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=nTw5ToXwmEZsy3PxE31Yjsksh9YX7J/H8UqhQX8FhQCriFpy+bLZyEF3pY7tTBRyUjulBirfLk4l3YZDJJiX3n1WLZIayNR6zaHeZY8qoNwsPizfiLH0gCxssyt837YK3JXSNfTpGKk7tMhd2I2mUzasho7Huaa80B5aGd4JccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqkTpdvx; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqkTpdvx"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso3653382f8f.3
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753197793; x=1753802593; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5fuM/OjH6/TLxJ6Yo/2GAwsqrfCBmYG8Qwpq2SFiaXw=;
        b=gqkTpdvxxqeuqTliCfBf454FqCz+XMoqBoLdK3M9z8csiJu5tnE1nLR3mhF1sMMTaM
         IsBsLW89K7sjr4Z9jIwnsXtx5D1iL4AffjuO2U526JQa9l3ePwUHqYtZG/g1Lmmy6eCg
         sXJxmHJP4TxNelMzg48YDhPN+MZVymqhEv3ADceLzgjoAB34s76Dw4D9TrzPtmQjh9nW
         7RnoxaHb4eGJ7Qrxa6mOplu7PSj7a47MAdoXX2Ubx6H3Lib03aimIU9o8Dfq797JkyUT
         ClllTzKB67I6iGveqZSsfJ+Rs3IAeylOOw0zuD7g37Vxj3yW3fTuYTAE/gwYkhzrxpMC
         J6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197793; x=1753802593;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fuM/OjH6/TLxJ6Yo/2GAwsqrfCBmYG8Qwpq2SFiaXw=;
        b=JiwGFfjmbRbvlCRFVtBkhgf0Tu+hlDW2XopA/or87WRJDpKhFwCqGNcaKdBuzxX3K6
         yjTNiYQIr4B22G/ljLY1+oG8zoFlLaSdKq35BTKPdGhe1iL0VTpKywLEi7YZiNfDA2i0
         wrijpRafL5QY5Y8HR1nzeyJB8lA1Ou1w9rAYZuyP6yo8Fhe6K5xA3JptwdsvJ2cW6Nqk
         UU5Pr84YOgA6YKo9jGC2vdM6u2rMd7tbPclsfqhq/W224Ld1ox4irq9LPdDKwDNshf+Y
         4Ik9eVOO4IuFdiIoEb19ZFi1PVywBFZo50rHRIRgZGysZ6TRXbL0Y8KIXJ153XR2nRaa
         mRSA==
X-Gm-Message-State: AOJu0YztKM4ndmOlKXAxbUaIS6Akdgf49FE88Z1t4NbKcqT0Vz4C79QP
	D0adJ6Xt82ikU5fTVBX6oUYR4VQr8R+evdEeKylZKwboMSMS9fRYXqqvHpF0pQ==
X-Gm-Gg: ASbGncsRbyXGVTVr4cbvedCicH4ePRSvHomYBlCufXpsAB9I0k4MCqI4vPHtoWlZ3Yo
	Aty4rnEicW3+jVAmqPhyj8N2BKN61bCet2EkESx7pwvSynVPoz/odUAajtO4A3NeLjFSOP9YadX
	L7bG8+r6jbu2OHJ8i6BBzzjv5nFuyBFFxsEEBOUnqla81/e7uIKjpsh1ofldv68es5S1osyOhvi
	zBiUEquc4fUuBw5sQFq4KY7fghHC9HaIIM9ZnWEoDmDf76BIqnEMM8iuoaVq6CqZ5HDGQBS/YbY
	Ihmd9PvJ8uhPgHr1APgyh4W34q7Uwt//28FoJbAja6eQ2pf/dmaOCj53YIV4gOOOIkH1DBFWfW2
	10vDmtgHy2+j7jre38eleo68=
X-Google-Smtp-Source: AGHT+IFeVkKxJVuvr+VB75fNpsrHiTuOGopXwAXMAh9/lDv7OkyRb+tzDl5fZoQP1MuFPqQp+uPKhQ==
X-Received: by 2002:a05:6000:25f6:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3b613e77736mr17754441f8f.25.1753197792568;
        Tue, 22 Jul 2025 08:23:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2548fsm13836589f8f.7.2025.07.22.08.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 08:23:12 -0700 (PDT)
Message-Id: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Jul 2025 15:23:05 +0000
Subject: [PATCH 0/6] Fix various rename corner cases
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
Cc: Elijah Newren <newren@gmail.com>

At GitHub, we've got a real-world repository that has been triggering
failures of the form:

git: merge-ort.c:3007: process_renames: Assertion `newinfo && !newinfo->merged.clean' failed.


Digging in, this particular corner case requires multiple things to trigger:
(1) a rename/delete of one file, and (2) a directory rename modifying an
unrelated rename such that this unrelated rename's target becomes the source
of the rename/delete from (1).

Unfortunately, looking around, it's not the only bug in the area. Plus, some
of our testcases in tangential situations were not checked closely enough or
were weird or buggy in various ways. Adding to the challenge was the fact
that the relevant renames optimization was sometimes triggering making
renames look like delete-and-add, and overlooking this meant I sometimes
wasn't triggering what I thought I was triggering.

The combination of challenges sometimes made me think my fixes were breaking
things when sometimes I was just unaware of other bugs. I went in circles a
few times and took a rather non-linear path to finding and fixing these
issues. While I think I've turned it into a nice linear progression of
patches, I might be a bit too deep in the mud and it might not be as linear
or clear as I think. Let me know and I'll try to clarify anything needed.

Elijah Newren (6):
  merge-ort: update comments to modern testfile location
  merge-ort: drop unnecessary temporary in check_for_directory_rename()
  t6423: document two bugs with rename-to-self testcases
  t6423: fix missed staging of file in testcases 12i,12j,12k
  merge-ort: fix incorrect file handling
  merge-ort: fix directory rename on top of source of other
    rename/delete

 merge-ort.c                         |  41 ++-
 t/t6423-merge-rename-directories.sh | 520 +++++++++++++++++++++++++++-
 2 files changed, 534 insertions(+), 27 deletions(-)


base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1943%2Fnewren%2Ffix-rename-corner-cases-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1943/newren/fix-rename-corner-cases-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1943
-- 
gitgitgadget
