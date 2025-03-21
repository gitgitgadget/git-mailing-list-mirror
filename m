Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849C1F1516
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599236; cv=none; b=qpzEriqH1JQteTGpuQYojiYA3z9r2aE28GOqX5W+QoCfv1fUSJKXhJBCKll1fFgepAmatzQq6kY//X2/v9Nny6QnCyrEtivG+YhSLk7dvmEJnSpxarl3zmKq6aoqeSIP9OWmsnLSY/c2wLwC5EbxbjJFC2rO+VQZcyixOxdETjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599236; c=relaxed/simple;
	bh=SOXen/TaUKOInJ5HhEvIZAD7XQb8xkccNVZV/FcEFUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnTHxNXUT73AROGtqxg0NlYKJPY7ZPyzUMG7Kv5MmiI1E2YoBMatoXphs2o7/p8QERmfXXbLr4vHh6RVYbErDR8bP6L4ckycPJBgI5TT14qP8jMeAL6OxxQwBxIq/5UB1N7QNX0m02pnngIPp9YvEa3baS1O40sn/YqbAElbuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3ppSPdj; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3ppSPdj"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-601a8b6c133so1556959eaf.1
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742599232; x=1743204032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rfsd6vU/4lhbSHoXG+mE3pCWSaJmQr0XF0ASJYHie+A=;
        b=M3ppSPdjg04uLkW12DWp3HxoP02+Rng/pluHC9oJ2M0NCJfMlSPBz8AIaqXgo+uLqU
         DWk2g1EIRxZUVNsw/n8wQYMm5S8+UY5Sm6aL469GV/eOtvF2AguKaqDWG0Dt6t2Px7fv
         Rgrr7oeac8Qi/PCRoaEsLaksiCMWB3ZZS6zrIhzl6a9K5W0fKDExSjblxWjKWtpLuebC
         OkS1u6Wdz5yTz1ydWckEutPGfniifCh/pPbbK10tjMy3oCSxDUT+HosNdsUDDqWfeVob
         jj2ECvDetigHWMlTyFMkoRaSIncvtcsJGFhJLcuN3mYM3UZJGKanF73648qUlwDR/jaN
         6u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742599232; x=1743204032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rfsd6vU/4lhbSHoXG+mE3pCWSaJmQr0XF0ASJYHie+A=;
        b=MbTywb9iuGwTxTJf6aLqEGF5ayA5pjZtUr1OWgDOSVsLJrGgC66MNWeoZUhiWh0VPc
         wC8bsEBNdJqqoiE6FF4+KzV/vfbZkHW2ve7fEZ6REknRkBooZlM8NP/ZOdc+Y/OluCnh
         1hqNrkPJcLaZUrVUmOUJQOiII0ZKJFekrgOIc8VJC8bbbermoRaUIXRIpqV5sty0UIUd
         AQzSGF4k9fH2Rh+r7OtozHyqwyGKWlWZclA1zixNotlVadohI+5Fh39b4f6ZPAe3A/j5
         kfO0wW5GErHJF3AQQC0e54GNask3oqzDOUrAJv2Fzav2SteFjZwhGrFXAro1AEvGVK7P
         hXsQ==
X-Gm-Message-State: AOJu0YywHksEQwF3LBtqHfm1vnKT0n5mOduTKkjp4rfD1ixinLGhkNH5
	EGYIW7DhNYTYTF9DEwddoAJN301vFwax5WhviAWpa7F8ANKwgBZl1Q2/hA==
X-Gm-Gg: ASbGncvdMe33EPDK13JSU9uZ86IbFWrToxwIEmMot3iFFbfFujpmaMm3K2TN/LJyRyj
	4LQDKAG8T3wHwgcMKMdJc3xzTTt4HEZTVWiRTFwfoKFdtNGPBixxhBp5bAyfydXOWl3dXzhDqoE
	0fRScs1c3WyIB9HCjHEMfOruOA/sc1P8xJw7m7yALlA4oi+sAeDd2Xc0xFLTpeF+6wgNxZrvwLP
	sZ71NJrI7yy60bQYmFIxp/JrsbYOyI1IIY32NRWfIm5e8TnVzNqXLS4t7k14RYaeYXFdr+uK58l
	djwmuT1U8Bqm/Xp8OcrpFZgP5GTcx1BwRXNFALzz/yyLCS3weqGN
X-Google-Smtp-Source: AGHT+IFLfSwzzaw31+OYd12coxLnkU7ncxhZJu82009ox47PvAEODATLmFj9Gmtcf6dwuf+gu2S2VQ==
X-Received: by 2002:a05:6871:200a:b0:2c1:539a:6071 with SMTP id 586e51a60fabf-2c7803002fbmr3548141fac.10.1742599232080;
        Fri, 21 Mar 2025 16:20:32 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0ed8easm715097fac.46.2025.03.21.16.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 16:20:31 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	alan@norbauer.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/3] clone: suppress unexpected advice message during clone
Date: Fri, 21 Mar 2025 18:16:36 -0500
Message-ID: <20250321231639.180762-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320014646.2899791-1-jltobler@gmail.com>
References: <20250320014646.2899791-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been reported[1] that starting in Git v2.45.0, cloning from a bundle
results in the default branch name advice message always being displayed
when it was previously not. It can be reproduced by the following:

        git init bundle-repo &&
        git -C bundle-repo --allow-empty -m init &&
        git -C bundle-repo bundle create ../repo.bundle --all &&
        git clone repo.bundle bundle-clone

This issue bisects to 199f44cb2ead (builtin/clone: allow remote helpers
to detect repo, 2024-02-27) where the refdb is partially initialized
during clones before remote helpers are executed. This partial
initilization creates the HEAD file and "refs/" directory.

A side-effect of this change is that the location of the first
`git_default_branch_name()` gets deferred to a later point of execution.
This matters because `git_default_branch_name()` only computes the
default branch name once and returns a cached value for subsequent
invocations. After this change, the `git_default_branch_name()` call
site that actually computes the value becomes `guess_remote_head()` and
is configured to always show the advice message.

Also, `guess_remote_head()` only invokes `git_default_branch_name()` in
cases where the transport is unable to figure out the remote HEAD and
must guess. This explains why the advice message gets printed for bundle
clones, but not all clones.

This series addresses the issue by adapting `guess_remote_head()` to
support configuring the underlying `git_default_branch_name()`, which
has since been renamed to `repo_default_branch_name()`, to be quiet and
suppress the advice message.

Changes since V1:

        - Instead of adding an additional boolean to
          `guess_remote_head()` to suppress the advice message, the
          function is adapted to accepts flags that accoplish the same
          thing.

        - Added a test to validate that the advice message is not being
          printed.

        - While we are here, added another patch to allow the default
          branch name advice message to be suppressrd by the
          `--no-advice` option.

Thanks,
-Justin

[1]: <7EC98E2F-144D-4974-94F6-FC24B443651D@norbauer.com>

Justin Tobler (3):
  remote: allow `guess_remote_head()` to suppress advice
  builtin/clone: suppress unexpected default branch advice
  advice: allow disabling default branch name advice

 advice.c                |  1 +
 advice.h                |  1 +
 builtin/clone.c         |  3 ++-
 builtin/fetch.c         |  2 +-
 builtin/remote.c        |  2 +-
 refs.c                  |  3 ++-
 remote.c                | 10 ++++++----
 remote.h                | 11 +++++++----
 t/t0001-init.sh         |  8 ++++++++
 t/t5607-clone-bundle.sh | 12 ++++++++++++
 10 files changed, 41 insertions(+), 12 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0

