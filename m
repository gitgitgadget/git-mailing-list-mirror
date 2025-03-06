Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0920C46A
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275034; cv=none; b=u0l3QLyDvJoA8eO1lVO/OBcibQHyZ7Z63mbyCf1k8HZbKABEumAR9K6yNGO5AwXs5I2dnrLdnOBB6BTYPjC0IJgxz0vaF4C4YFisMfVoDEUiDU4+j8i6WQKyMzc6bma90J3bFjvgMSLXpRp2ujU3BvHDBcbEZYgwVaE2en+u+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275034; c=relaxed/simple;
	bh=mC7VXrydvQpvZsrJ4H0TAf3ZLyU0EpDIOkTvcU2ZLnM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=MUx7K1H6cB5GVCtPvwBOsj4LeRlAsIf7ymc+viT4faxc8yHriaQTP6RSvA2l6nRaCh2yMpGv331PGiigdtWS8TYMCxnH2ip6Z2XdUQAz42vfBezV+R1QF17hFoL1ZD/v8GT+2AdSZFHsnuP87IOCPw5wWgwQDH35tkQLrv5eczU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOzQcaZ2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOzQcaZ2"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e4ce6e3b8cso1386725a12.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 07:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741275031; x=1741879831; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pnVE5T7dMbCpoR3/dyy5h4yRWRCU+sUz95YcDZdqJzY=;
        b=VOzQcaZ2Yfz73d6lBOWXxlYOQ4tEcoN7Q4IIIW6aVeVsasYKT/9S8VIOdVqLHC0ACo
         omABqqCszBQ6VB3CKo2i6oSpO2ySGt7J9u3bj6cFm0/M/CS85B55u6QDO2Bg+q609CZW
         Hq89XI+FweeQ+KndK8B7X655cnSwPokGVsLY/5S0oJHlIXKR6SBESRlCWxxlFtyoE+pG
         sxLockRl9RC2rfMkopDql7sC/cI6+wVWuyLKXdeQpt6Y1knTPatrMOoqeydqUAfX8MKr
         5hlWT+ryE/fVrASCAIiECtvVm29RwSEUNtg0BjcYfS/UnGvrbhxLl6fPCHM5+JD4eHJd
         m+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275031; x=1741879831;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnVE5T7dMbCpoR3/dyy5h4yRWRCU+sUz95YcDZdqJzY=;
        b=pYqVAezI+PCIiLHwHXGtgM/VRmfrSqKWj2npFocYvNLS2w6FFgwQex6mtC6zCwoBra
         R9fSBdDI4K5VdfnxbUUCV2lzwhoPaWLqDi7KFkg4PGoe2+Cx7OP1cAFjGEc3Loo5Kqgx
         W60lNP6OAzvUkaEG7c11+IFv0eCFdJHGvbYgPJaFEwWyTwT20PJfsHa+T/Hcl2ba6Kno
         JkpU5k/cPpHGTxeEGBPxlSIY49DfTfFTSY2HsZiph1OuYqpll3gggPIPFYBvfXvfQxUK
         y/fkhNuC2PpYIYE67riBXrTCVnXIY2jYEKXqPs3eIQqYBvsVVHzofZyIxI/kXzy6K/Y0
         Vg1g==
X-Gm-Message-State: AOJu0YxBRnfpEmoz86nv3M8sJrUkvePKi6PuMUoT6klzCV2MnENSwsWT
	GhK/RDTEftHBFWxurt5eWM26TVDApRxoZVP62o+mirnE6MYnkZh3llSAuA==
X-Gm-Gg: ASbGncv499L/qpSYrVXkrJihv1sTjjCyX7Y2ovOslYSpDdFRLeSCHfXGI0sJ6g4EXRZ
	j00S7Ty5WivqI0XDpX0NnDkp1YHxX9cl6FMNUL9PjfPVqgGlMDG8zVPXbvDYfiJha8CckAxkbRL
	PNd0VmPXCl023ZPyUq1UIoKZKSdKnck2LUVjKbd/MRV8IN319epG8tULEaoB1RkhMrkMlUql2GT
	J16s6mLHnvv5bH55r18fyr2gTs2pmz2yYZKyd102jYizUC9B4fchQ0H/hWXeWjrxg8iAXQEPpVe
	JSjM9T0FNBfMl+QLfUoyQ9XYr0Cj+f3ZbO3T/WyIbZ++HA==
X-Google-Smtp-Source: AGHT+IHcepefveb6GY3pn0zT6HKyJSLR/+YzKyguwENM6lsAFobesPl/rbfuirXS2jU8UdvM3X7eZg==
X-Received: by 2002:a05:6402:3514:b0:5de:572c:72cf with SMTP id 4fb4d7f45d1cf-5e5c1b8ae47mr3437830a12.10.1741275028802;
        Thu, 06 Mar 2025 07:30:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745d5cfsm1093516a12.19.2025.03.06.07.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:30:28 -0800 (PST)
Message-Id: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 15:30:25 +0000
Subject: [PATCH 0/2] merge-ort: fix a crash in process_renames for a file transitively renamed to
 itself
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
Cc: Dmitry Goncharov <dgoncharov@users.sf.net>,
    Elijah Newren <newren@gmail.com>

Maintainer note: this is not a recent regression; it need not be included in
v2.49.0.

This is a follow-up to Dmitry's report of a case where both merge-ort and
merge-recursive fail to properly handle a very specific type of conflict.
See
https://lore.kernel.org/git/20240921024533.15249-2-dgoncharov@users.sf.net/
for the earlier thread; the first patch is an adaptation of his
demonstrating the issue, and the second patch is my fix for it.

Dmitry Goncharov (1):
  t6423: add a testcase causing a failed assertion in process_renames

Elijah Newren (1):
  merge-ort: fix slightly overzealous assertion for rename-to-self

 merge-ort.c                         |  3 ++-
 t/t6423-merge-rename-directories.sh | 41 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)


base-commit: f93ff170b93a1782659637824b25923245ac9dd1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1873%2Fnewren%2Fendit-fix-funny-rename-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1873/newren/endit-fix-funny-rename-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1873
-- 
gitgitgadget
