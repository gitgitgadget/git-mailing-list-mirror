Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C9391825
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272516; cv=none; b=iCAUqg0ctJvP5S5+3ulNnNJ6rIVoBN0Wcx1+Xfhf69K7QO34NVauN9gIXKGvSvxVopOWzVozsEjauPCb8ObJYz+pxQhbjxSvuaWqIkLLCnSF3wftz5GjWvshr1r7lSYe6AbBjayiytObu6B9W2ZjXTbRahGBZ/vxpgYz7JiX4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272516; c=relaxed/simple;
	bh=JpPLybBo8n8bOcxoY36bsPBC2UoCNxrLu8h2K6mHCv8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=nklOHe5db4qXw0dTFI2QqVlSCR5C/OkySAmsSH1xOnTxuXk8IztInvhdonPKjUBpj/e/qHxpFReky34hMI6PwiFUf43owLJP28J5LfzAdDJilG0SZn/m9KuCaxkkDV1LXkq8g9ZjR+edEO/DMqjfR2zvVUeT9Fc/3OY7w75vWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix8f4CQe; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix8f4CQe"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93906e8a5feso486154185a.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788272513; x=1788877313; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ux8+LC7jDJJAKQWGxQqYnx5I8lVBUh31K7QOtyFRh/A=;
        b=ix8f4CQev3NkjYWQg63ojkLfvYUoltT/FeSvPMRDLvC/uKTwIlelQKWZDe1t9+QqVW
         NyksYTW9QlIABbHRAPU7mkuzYTq5YhD43hSMFYdSu4QjqVf+G1bmdxXkhjFuckpTNO4d
         bZgt4hhqNJpdZ3vTNJo0frSKH4TJJDKvWA+Oa75AnA1fayrtCQ9gN0Qg6EsXYxkv/BEV
         5yGuN7oL+RkMTg3BqSwjWAs39/MeIXiqEl1GjW9dxbyRjqBM8O2zXAWb2hDBHIGw9ixt
         dTKfvp/nHOUTDdnF4YhY+f0NtNzln3AvaBKoghuwC4p61T0iUkx5DYfmjpGweKGCH8Rn
         wrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272513; x=1788877313;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ux8+LC7jDJJAKQWGxQqYnx5I8lVBUh31K7QOtyFRh/A=;
        b=rP9RABQwyBT5mgQuCF8Gis6r0Yn6p/hEENkSOh+Qy/nIwQEIqI5uV/jSe6LADLsJIL
         IsiQe8iWIcTuAt+rgigXPAvRXhh0oyRrHdxkybs+3MY2WnVzxAuQ2qzN+VXdPSQ0mUNV
         fgw0dWal+L1a32sQc1Vv0IVw4CqbZT9FQnbMYsG3t2W6l2jhvytPXpXxUAlQs+7vdB0Y
         0L7lAVvAervg3kjyWQt6CGO6iQjo8W50tNsWrNJSyHAD7PRLKR6dcuSJtSk38PJ0dKVk
         w9EcDCdtjxNyF6dtqMaPVCO0VcOzYbrNaoDJO1UevHGYjzwZ4OqgYj/bu07SqDclPvGS
         91KA==
X-Gm-Message-State: AFuF++nO0+aX6TqT9M9xXgBzuUnZ447HDaFkzWLdxUnV7VWo3HS7NMBx
	JfMx+AbN2/lwiu4F1WfKr75OLf5ZncZfYMlm9XoPlZHa8yXnM2rRPE8prduCCb+h
X-Gm-Gg: AR+sD10x1YEzStbgRzibgcWyAx2miR4VuLSwDhd4tWv4DOM8n75fjxsewDQl8A4gRZz
	B6WNnfoRPjLsEfyrnjDTa8vXvBKbHXiqdhfIDD0xw9a3TZwriJcvY07H2Am1WPU2u9YoBErBYw7
	M8R+53PCmn91aPj+bEYI2FgSNuvCFizmz/wPCqAA/vWJiQBBR3AnOIq0vmTFEprB8US0m3AJ7YI
	df/UtRxXp3P4NvZsnej/+6YIxxLCZFQjrHUM8VyWQb4xejWjohYIN4A9Wz6Lp9j41/xDrZk8nl9
	K3ytLmTeUUeT6FkaZwuxcErXsuBfl6FZho/QFrB0p9g6wsTq1wSoSikeCG/diK/7qREpOxFhGQY
	MpZNz0uTGcOG7+z0v+YjSgzNCP3qWhTDK57nkj0zYRtDu6Ue+EFj1yBCBhHdiwiJj0n+bzfpegD
	Oz34alJRYS0Z7R/vuvBllvoW/Zs5Zg6eKbvebAgHZ5RKUIN1Vlm9kXTevsqxW3SiU=
X-Received: by 2002:a05:620a:44c4:b0:933:a17:c0c4 with SMTP id af79cd13be357-9391378416emr3519671485a.9.1788272511910;
        Tue, 01 Sep 2026 07:21:51 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.218.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391725670dsm1059070385a.19.2026.09.01.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:21:50 -0700 (PDT)
Message-Id: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 14:21:47 +0000
Subject: [PATCH 0/2] Use Rust in the Windows CI jobs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

With v2.55.0, Git requires Rust by default, with an opt-out that is intended
to be dropped in one of the next versions.

Due to the special circumstances in the Windows part of the CI builds, each
Windows build job first downloads a "minimal Git for Windows SDK" that
contains the GCC toolchain required to build and test Git. As a consequence,
brian m. carlson opted out of Rust in Git's CI definition in 32d5b905909e
(Enable Rust by default, 2026-04-09).

So: How could we stop opting out? Notably, Rust is not part of that minimal
Git for Windows SDK, and including it would more than double that payload,
which I consider prohibitive. Yet including Rust in the minimal Git for
Windows SDK is not actually necessary, at least not for the GitHub workflow:
The runners on which this workflow is defined to run come with Rust
pre-installed.

Granted, this Rust installation is configured to target the Windows-native C
compiler, Visual C. To accommodate for the Windows CI job building with GCC,
this patch series adds a step to the workflow that ensures that the needed
Rust bits are installed and configured.

RFH: I haven't been able to confirm that GitLab's Windows runners come with
Rust preinstalled,
https://docs.gitlab.com/ci/runners/hosted_runners/windows/#available-runtimes
did not clarify that for me. Patrick (or anyone else with access to GitLab
CI), could you see whether this patch series builds on
saas-windows-medium-amd64 without need for further changes?

Johannes Schindelin (2):
  rust: pick a GCC-compatible Cargo target under MSYS2/MinGW
  ci(windows): build with Rust

 .github/workflows/main.yml | 24 ++++++++++++++++++++++++
 Makefile                   |  3 ++-
 ci/lib.sh                  |  3 ---
 config.mak.uname           | 24 +++++++++++++++++++++++-
 4 files changed, 49 insertions(+), 5 deletions(-)


base-commit: 8cd717011ba08f30f451ec802047df275fe2980d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2213%2Fdscho%2Fuse-rust-in-windows-ci-builds-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2213/dscho/use-rust-in-windows-ci-builds-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2213
-- 
gitgitgadget
