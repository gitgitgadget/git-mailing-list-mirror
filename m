Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681C3B27D8
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667561; cv=none; b=YqF/E9uZsb+8EDTokeZ5I9sAwffJGMEci0YY+5BHqpadE4kvknyqIfFMww7wW63A4fmfHO4Pa2Ym8I22upiwC9nt7e3RGfS/gZc2/cU97Q8eccPMCYyhP2utyxFSOLVrZuS4VvorDq5JMmILfHvl2s1QygFqVfFo9wYTOk2nyXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667561; c=relaxed/simple;
	bh=tHD60axgqcUPCoynlKDikNcgCejc0sgPMDeEEGugI/Y=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=URFJSFLOZ0uGI4Bu6KrNuQefDIdXvuRGdrDmdclmz15exxojaIyYW1lYCv9GnnWd/6WjkHGhVvC0TgQZPfUeQzNzaKVdU3NTIlcEdLj76Hd8y3333kHtKhy85NRH3dD9UY1vmJ36Onkmh8Wv5U5/7v5gyuD1ztOhJN02KIt34gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXCW4vss; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXCW4vss"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b35611so801000b3a.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667559; x=1790272359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p/nMRrpLD6OmkstITiSdoV5zarGZ7RLMoxRHdAkqtlk=;
        b=gXCW4vssuEF0MOShKfheOY8QZ9wiL6ccbU36ATn5sS8zP1VtMPqg4q7Dfb0VYJHzf8
         YUQ2Rxb2gzGn2of8miyho6Z9ppg7e9HgtF+3je3/qiNT3LOvT8lNRR7gK8CYBKEgL+Ly
         591/VR7uE7FiSbs+8VNtBtKNI85E7ZyPxq0j1ZcsApI/F+7DCbmkbwUV5mez7HnqKbBq
         xJoMb/46b5yspzGInxHGQG1VYb/2eNh1hxd1olOKRgsLMej1dgw0q/g/v7omqcrc9BFh
         xxNl7MdkSVyZ1sR0i6BFrikDYwfNMKAEZn3nd3ACotoFPwOr4fsaavE0o4MXnJAGGMEy
         084Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667559; x=1790272359;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p/nMRrpLD6OmkstITiSdoV5zarGZ7RLMoxRHdAkqtlk=;
        b=Mj/mIzWtCWRmxq44UADnSVZrFh9VoxY+qslPdckq/vQkuvNbyIqD27xhv+VXjEG/HI
         byfk8OtWXJ7MdE9ApROXrPHnRN2aypN5oBitfZfYkizbQbb01BZfb/bTDMpSCj5PRt2c
         wqVhfEaNV2CsDPY1o7Uu5OlvHiPpZEl3ycVDARbReimt/iNZV+EuqAdBq1hYerVx/j7Q
         DocMsa6ejsDyzTKz9lncFRmnU7/+zNjX8FezofbhEjbBE5hFKObqCgwVhFsasmbfsmp0
         M6K3ZRc1n6MRDs/syD64XT6jMsAipqVGg6UdKt2NkfcyAoaueH1c4bsWaU0xToK4Hk/s
         krMA==
X-Gm-Message-State: AFuF++mqdJHQC0KIBCnI0GBxEyjeGxgUqu9Tc34rJSs9tQaGs3wnveQf
	swDXp5wuO/Hsa+KHdL/sn0OJzI1KS61IfUBKC85ANv1PNAu6WTuIjLNpfBAaYg==
X-Gm-Gg: AYBFou3blNLEgOfjlu7br50GlBrVueoOoSD/ZZzdgEDRHzT+1cmYWbNznK8N+e4PN0n
	NX1Sa8QuKFAscmFT/sZD+xddBxx6LrSendQzqoa0+/EkSfqUWwvqCxCZDV+ohhsaWBq4QnkZ5Rp
	FgFgKngk71MBc3w8+XjZZ8ouyUNO8sy+Hn2A/47CWPz1BMq4X7mF5UC5wzo2rKO5Xj0HDZhL/hO
	D6ZkM7pFe9a4EBYnAzuJfImbTkKv8tD6JyMiQjNDk5S9hu8mjlg4oSp4eOljN1V3gpL2DJzjtxj
	JCR4Qx+/RKJX3ySVqdREaGLaCfP9JGUiPQM68wG4fh/eP/rXOduS5WDNmV6rIemnaxTyV6tW6T4
	Fr2HUxyGN+LMfwBgnJCn/6t+Cu88iN2MolN9rvJ1V1k5ToRrmj+qxmgrGHb0UpX4wUnU2fvEzsR
	lw+QrO9BqTVgScRFLS/MnUn5BWCjblnaU5SEruobvkjXUfdTLZefVB9UNbVIQSVNOfdf3SUwEn
X-Received: by 2002:a05:6a00:4f91:b0:871:41fa:d1d3 with SMTP id d2e1a72fcca58-87236ae800cmr14885717b3a.3.1789667558517;
        Thu, 17 Sep 2026 10:52:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87200d4e021sm3185402b3a.9.2026.09.17.10.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:52:37 -0700 (PDT)
Message-Id: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 17:52:29 +0000
Subject: [PATCH 0/7] Fix issues pointed out in Git for Windows by Coverity after merging
 v2.56.0-rc0
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

These Coverity reports are new as of this -rc cycle; Apart from the writev
one, I don't think any of these are pressing, in most cases I am still
puzzled why they were reported only now.

Johannes Schindelin (7):
  wrapper: guard writev_in_full() against signed overflow
  gpg-interface: make signature-prefix matching length-aware
  midx: validate incremental MIDX pack IDs
  rerere: do not record failed conflict resolution data
  t/unit-tests: check reftable iterator initialization
  oss-fuzz: handle reftable iterator initialization failures
  test-read-midx: check midx_fill_entry() result

 gpg-interface.c                 | 10 +++++-----
 midx.c                          | 12 +++++++++---
 oss-fuzz/fuzz-reftable.c        | 18 ++++++++++--------
 rerere.c                        | 30 ++++++++++++++++++++++++++----
 t/helper/test-read-midx.c       |  6 +++++-
 t/unit-tests/u-reftable-table.c |  2 +-
 wrapper.c                       |  4 ++++
 7 files changed, 60 insertions(+), 22 deletions(-)


base-commit: 12cb6293d6288865c1a133cf22accbaf99d13eb6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2231%2Fdscho%2Ffix-coverity-high-severity-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2231/dscho/fix-coverity-high-severity-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2231
-- 
gitgitgadget
