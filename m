Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A07A41D4F7
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153736; cv=none; b=Ebfi8X87m49O2tBp0ak1I6JKvsxryxx90jweKthcpkf5JUe5p+bm2Q1mmaYhrsMWNZOhOgOme9qpre7nNfQbm3Qt14pWHPXnL/sEuEz/JzqYIj+XsN+ep0hVZV0zQKlJLFuvhtbCHW2DT45jS3SaOEOttpxsu2ikWbChBev3owo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153736; c=relaxed/simple;
	bh=KT/uYZQ58p54mJV8F/VkTD+WXxpBfeV/DAT048Z5kLs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nTopX+Rj/VTmJ56RKwiu0Apn89w8krLvjSKiJDFwEgcjKW2VHtQXWvmzIZewAqq5iXJ+IgbqMMH2RlRx92q//jr98q1672Gerx4OLOSt3wbkE/2kQ5wvuPF3S7mbh04xKZa2Q7LMMOyV4RRpd1iRPPUlW8unhVFsBkdeqAyEU+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLSCj3z5; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLSCj3z5"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92edb12cdf2so89403485a.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789153732; x=1789758532; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3bIgJLJ1wgpAZGeLEd6YWfudUml48ZAWLPFKXdQRKMQ=;
        b=aLSCj3z5ZculAbufp/xmCwZVDN088L4RqGGfsaiSdYQTxvU34a9onSHnDyWpfVgTgD
         4E2MERCkYH3NjSvL4pi8Gmw9KUUyHYU/U7ogJSnQA3hMLDiqSebBM2kfg0YoLJu2cLr8
         SVxcWOXTgG/5AWKwGMVcrNX08x2lVTGIAki4eDAQyLE85C8UeohKrRt1AwDYSr7/5OJm
         omUx2EAg84Noy+G70/pjPgoDsukZBt9idgoZ1tf9/86BFsnELTIokcZXLZo7NuJ5sNy/
         5ineN248U0guLbeu6fLVxcXxWgkzA2d/g6qiWDEaGwXghJMKPIGhT6cwUL90hkE4DC9M
         kILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153732; x=1789758532;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3bIgJLJ1wgpAZGeLEd6YWfudUml48ZAWLPFKXdQRKMQ=;
        b=a6PXQ0yI7w4rgT6iKOYDhUIn7XTzrvHB9oZGGAskMtT9m9de+UHYVkq3nVVfNIhYM5
         Tr9utK33dqZkrK+rfLBm84BM6peK/CsfpxEHvPCfA9A1KZOesUt0QjzYZzqwr8W50957
         I4RFzZ6ikOuxSh0tDjXioIVbunC4/WPVKj/TN1JRws39CttzFgHgZEf9NLxFQqfLKHex
         YDYRzDQhjPYx2cXQO8Hcnq1rYy/Vbc/ISOQcaaFKgH8xMuy2L0TxsLEeb+06/lxWbHhl
         dfuUMc9lyNgt1+h/HuJMMhIiTr0oh5moqpXo52wseLtmmaN/CCaajKwEa23DcKf62/ir
         jNmw==
X-Gm-Message-State: AFuF++kiTPSqLoSu9C0HLpfPOmQ9zZvGe3lNpvAsuBZUuwhNVOC0WNN9
	Ln4qX/vTUhZg15IY2NODUrg9RRtJUKIl3Dov/w7dU1QzILDAq7mnGQGZn2FDQw==
X-Gm-Gg: AYBFou3SuEMHSKNJXR2LTsmGpLPzBN353L6xAjHjclpv4/j8ZNs+Ct7nIATvjlyQDjN
	gevKaIM4uqpVEbfXSBcpniHXbCyA7vYmxPJPwOAMj2wll5NWr9pECvU6a4suZVzQFjSq48UL9nF
	lgqg8/S9J+naA2AEeAdnTK8BOSmcYguDVLjcSzBJdj4HXV5H4GAYaWAhKRIrdp8poap1dvTrsUX
	oier0MQLgVFdEWLFmJkSLkY3Y9uw5GwWHLdoclhRB8B4YSHRtkgr34OFqw1U0HFFRk7i1aWRcEq
	oS6x64hsVHi7Iz2Adt6f3zrjpcc2hyoFSyMxrno7JKbXIZkPtjxVRy7r5628vryYOszMHLm2UyT
	UwwYkvri71zCTKolfd1G1qaTNDbVmPJexkV+yLGj3bY73VaMEBGuFtPAkoVIVYrTDgL+USquNSs
	ce7CqndneBx8uDf3F4BYtm9h88PCNehYEiGcQ4/Z/yGC8/SQsS680EyHt1AX4nEcMMucMJgOcl
X-Received: by 2002:a05:620a:198d:b0:939:6de7:8768 with SMTP id af79cd13be357-939ea2a769bmr719024085a.47.1789153731673;
        Fri, 11 Sep 2026 12:08:51 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.38.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f19291sm323311085a.10.2026.09.11.12.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 12:08:51 -0700 (PDT)
Message-Id: <pull.2213.v2.git.1789153730.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 11 Sep 2026 19:08:48 +0000
Subject: [PATCH v2 0/2] Use Rust in the Windows CI jobs
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

Changes since v1:

 * The inconsistency pointed out by Junio, that UCRT64 was once marked as
   using clang and once as using gcc was fixed by clarifying that UCRT64
   uses GCC.

Johannes Schindelin (2):
  rust: pick a GCC-compatible Cargo target under MSYS2/MinGW
  ci(windows): build with Rust

 .github/workflows/main.yml | 24 ++++++++++++++++++++++++
 Makefile                   |  3 ++-
 ci/lib.sh                  |  3 ---
 config.mak.uname           | 24 +++++++++++++++++++++++-
 4 files changed, 49 insertions(+), 5 deletions(-)


base-commit: f4742f3165d096130c39a71feb26374da37620f2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2213%2Fdscho%2Fuse-rust-in-windows-ci-builds-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2213/dscho/use-rust-in-windows-ci-builds-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2213

Range-diff vs v1:

 1:  2b7f58a037 = 1:  6567eceb32 rust: pick a GCC-compatible Cargo target under MSYS2/MinGW
 2:  7a24630fb9 ! 2:  07415393e5 ci(windows): build with Rust
     @@ Commit message
          linker) need to be installed; `rustup target add` alone is sufficient.
      
          Assisted-by: Claude Opus 4.7
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
      +        CLANGARM64) target=aarch64-pc-windows-gnullvm ;;
      +        CLANG64)    target=x86_64-pc-windows-gnullvm  ;;
      +        CLANG32)    target=i686-pc-windows-gnullvm    ;;
     -+        UCRT64)     target=x86_64-pc-windows-gnullvm  ;;
     ++        UCRT64)     target=x86_64-pc-windows-gnu      ;;
      +        MINGW64)    target=x86_64-pc-windows-gnu      ;;
      +        MINGW32)    target=i686-pc-windows-gnu        ;;
      +        *) echo "::error::Unsupported MSYSTEM: $MSYSTEM"; exit 1 ;;

-- 
gitgitgadget
