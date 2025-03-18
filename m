Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334EE14B08E
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308834; cv=none; b=EES4OodfzofdGjfmYf0NpYbC12dJmyz+gzdBDgVOOrJuMI/VheINRLszOhmnFP8CPny9fOTxUKAU5v+hjvbFtZzt6dceUerQo3RCml/zY/nFhgEWdmkViT9nUGQ8FaBYTjwksZrwIECZkumFjJBPNW3gaxa3tUNkv6iAE7Xmuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308834; c=relaxed/simple;
	bh=U/axvTfhJZga2Ta6CnuNfJjpYWadaJ/PxJOKehzUPyM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GEsCdhmhfvwsyjuGTk6k/bIxneyaj0rJ3B5kpObEiJ9S8pHd3PpJWA1ZqtYQLp7kMSPp2cjh5riMeDVXjA6YTqLSjwmICd6s3wZv4r1AvLNs+68O+3iQBwCMp3BqkA1Y0OEDQKoYp0cMIDwNou6AWxbyiC1AgkYg/vMOoj9Tz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuA026FP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuA026FP"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-391342fc0b5so4728511f8f.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742308830; x=1742913630; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gCEOTARTAEzSjVmZbHwYVSJXxqr8ghjQnMpP8m+aNWE=;
        b=ZuA026FP5wZEAOXpu65KJIutqusqTbl+wVZ1tg/a7AzEhG61ZEr98N+Y978DnK2Hgw
         VQ2TR5nSdCOLC6nMArQb0N5PoahIe2g/2V4v1c3/9e4P6aL0m+ZxZu+HUqeDJXonGtow
         IpSG054CyBj7Y/D4KU792p/uugbZOVpid0XRGjc9Og5Xo5yFBKKFNxFqc9QKb4Lwfo95
         7V3S4c/pg/gY9ybONhIQ9YTK/YAXILTVeOmUMb0rNF/qRiHrDba0z29EXP8/FHBjcSk1
         vturk6qqCoxvUqJeDvaU1ALI3vwGeMLpwxQQ9IiNpz8IAsRdNVXDVe/6FFwirLjiYn/W
         4ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308830; x=1742913630;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCEOTARTAEzSjVmZbHwYVSJXxqr8ghjQnMpP8m+aNWE=;
        b=kRLlS0/7RJngtbvB/ZUnXi14ahyyif4q4TIptT00h8nryF5LWaj/Lfba/irIUSHDY8
         U9Z1xhuzQ8Y1Zj/zUmlC9lGWkz2WjS/bOw0tRVOVhRirHCB26ySeW30JIpeNIQFIjncf
         HpiBilWwkaeagkz1Lnl6nsBsHeS7SZeej2oqXTIeHRcpnM3FvlNjRF+/TbucO5f9/h9E
         nQ46d1z+RuN7XhTGWhOGhPkSBfrpOtO5KoqDx4xM834mg2eRHKz7ffMatrFFeSm9v5Ln
         q3osLbo2XFjEFPBncirr9SUpdk42IIeQYJ9OgPKNJHUkquKd37QwzRPIuKQ8uNT9EJX6
         hQUA==
X-Gm-Message-State: AOJu0YwDhSPl+pis0l4kwol25lpjWnZwbJxQSESo/+L1xU/ZED+/bKrN
	etLzMZVoGhmAPZIoMOAROuXT3fcaTWLAq88ZfLQsm+SOB+A+e6WhO+cS9g==
X-Gm-Gg: ASbGncvTkzuXtkroPF0HdcEFtuqOAS8yfkXw8Qchx8AyfBRVEmRQ5U/X0zUBpGf4Yhf
	WJY++rRy5W85tiIdpNbXJNDkP7RcyyMSwdAylCOxXNRGpDu3yaTja4xNEVoG+s/zukGjcq5B2J7
	5tLMKlW8x5H+Uk/YQC0rwo6cQaEnQDOd9gB5gnArvLhnPJmWuZ+ffR992TNkMY4qJQ4VhlhIIfG
	cwKaG0gvofFwxh4OjzsWAiOlRD2ebl/pU1+IyPhaO3wVDvvEUYql83QNKJJf+Man2fu9mXQA+/5
	i3GG3K8bVXcsRciOdqwQk2HbchfRq19g7A43Y4pQX+aXpA==
X-Google-Smtp-Source: AGHT+IHpmEj2GeOSq7sbyLpeJM5Er4c1r8UmzHCG+EaVX03WQTFUnRp5z0fICKCOTvJpDtQW1dVdGQ==
X-Received: by 2002:a05:6000:18a8:b0:38d:d9e4:9ba6 with SMTP id ffacd0b85a97d-3971ddd4af9mr14620706f8f.3.1742308829214;
        Tue, 18 Mar 2025 07:40:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35bdsm17856035f8f.5.2025.03.18.07.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:40:28 -0700 (PDT)
Message-Id: <pull.1920.git.git.1742308828163.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Mar 2025 14:40:28 +0000
Subject: [PATCH] pack-refs doc: fix indentation for --exclude
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
Cc: John Cai <johncai86@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Separate the paragraphs in the description of `--exclude` with a `+`
rather than an empty line to indent the whole description rather than
just the first paragraph.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    pack-refs doc: fix indentation for --exclude

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1920%2Fphillipwood%2Fpack-refs-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1920/phillipwood/pack-refs-docs-v1
Pull-Request: https://github.com/git/git/pull/1920

 Documentation/git-pack-refs.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
index 2dcabaf74ce..652c5497715 100644
--- a/Documentation/git-pack-refs.adoc
+++ b/Documentation/git-pack-refs.adoc
@@ -88,10 +88,10 @@ Do not pack refs matching the given `glob(7)` pattern. Repetitions of this optio
 accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
 patterns. If a ref is already packed, including it with `--exclude` will not
 unpack it.
-
++
 When used with `--all`, pack only loose refs which do not match any of
 the provided `--exclude` patterns.
-
++
 When used with `--include`, refs provided to `--include`, minus refs that are
 provided to `--exclude` will be packed.
 

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget
