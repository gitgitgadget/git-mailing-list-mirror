Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B73A1E7F
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766258192; cv=none; b=gTV0AJ0WWEv2E1Ykz52tGeuOYSswsx/V+9RAJzm3rFjl9vDd3ZfaNUrXhGAF9afL30GlUxUu8USk5FSgekfdDWO40voZSLeSz0nYaz+ouyZr7Sd72hM9emCboGiE9UWe+V1IDdGjt+zOfLXyqIUv+mYk289DvAM+FnGaFpLoTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766258192; c=relaxed/simple;
	bh=O5CHHlnc7CyT2M6eQ+yNgiyj3BX3kHGiVUMZFp6HN30=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=O6mWDzz7pyzWP9R1LQB2tqSRvO5vvOHMHjxat7jO0DCPIQBuI12i+ZAFSV3I0AbMT95Te54K7Hy/rXjT8A88tS3sgCDE1ZPiPF3NGnNJpgoqjMVMqskj7qYFvJ51WucZSlm7Cc69i/zcZenO7fhwAOflHQlrkEGnVuNKY8w4zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToXBSwqX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToXBSwqX"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a35a00502so28400526d6.0
        for <git@vger.kernel.org>; Sat, 20 Dec 2025 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766258189; x=1766862989; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mPfZXOCqCNezBk9QQ1QyGXZ9zwxcT5XjhsYE84K+MkY=;
        b=ToXBSwqXprINIReCPpD3KMFhmJdDG+7GOhXzP0isimonHPMxMJukAX8MbRy2cn3aro
         vyXJLNMAUo3/fI8//DUGISUq/GMkIlZwIbaHb/ElBDlWP+SV2Am91T8uMYk3EwThqJge
         wEii9upxBmCAXz6zCzf3wKblEEY1szO1bw9ydKyEXlHvw65p4P5VOeqLGajdGjvcbveF
         5EUiUoU8aHOD/+HTIz+qMm/KzOslt6HoSRDmrkGuagV5VnsAtDrHwNIxJMSrQoN/k9BQ
         I5XidxRIR391kGpzuG7r04YFoZNP5+EyaEd1bvpTOuE6KvOZ32wYOOlqOJ7UI08Vptsk
         1HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766258189; x=1766862989;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPfZXOCqCNezBk9QQ1QyGXZ9zwxcT5XjhsYE84K+MkY=;
        b=HoO5DI5NKdpyuSSPvRpm5xwCYqwA5qc2SaEh1EBzswmhjanw2bw0DM/mudjpF67FeF
         TR2tRShJw75g+EqYVcJrtbM4U7LI7rWk0+4RsbN1ei+FHqjzV6nV1i1hGVr6djtaJ0Na
         7OVME6jQAJV6biEcPGYKLa3x01/1EqpPvI7STF5qSdU2Aht4oJ8tyorhf/rzOFMbuFy0
         dbEfHXjz+NJTa2/0YyWnzhRu9zCX19J/oetY8rwWqTNMwX3PsM/SoXOJTTSUvVB/HgKW
         x46XVLImXnZltBtK9kC7ia3IDv/kZeor9AzkJ1MD4R2hC0SbWHedFkiAUhGul2xFjk/x
         IjuQ==
X-Gm-Message-State: AOJu0Yz2jNpK7p1qxCuwQNsiruvYKdnkBhWzxUwRNUVywCnkz/QwHBPy
	S0ms1Axv7F4B3I4cyHMdovwD0+l7d5kI81sYMFGUzVtf6zBABatqw3JivbNPaQ==
X-Gm-Gg: AY/fxX5Q2eVp0OGWn3H6PxiPCr3NTur1MMD17jMsduHLuFEvbIZ+t66oLXgRtYht4yK
	FEsoWIdODCAn446lnBJGpWBVqUbA5trLG0wa7VM0Sp6Wy88SPwzsp8Xrb2KFf78gY4f0hZ1k5xv
	khaOMfxSkGMSlZcf/W7SEGQoa3Z9F3uUea1KePdYBNW0YhTqTo9TLeQdpOiMBB7sX6IG1+3LvAo
	AcLQUcPOId6Pc5o2hxVkTU/eVkDLVSJFXLtjNtQQ5D+QfM0R951MGBqgjvPoAq1siH4L0erjAnW
	SqckolnhNXv90Hr+WegouU2tEkYWXTe4OasL4WJsG7uVvdfLNKo8jumUqoBJ/E9Xgo+/O/50iEA
	q5OMwcqzn8FDxq1CTvWFkF0p0h/q8cE14oFkhKxmkZyqu34TL6isVNW3/aj9LeLALFalzeKb1yC
	/ZAX/X++HeX0JNug==
X-Google-Smtp-Source: AGHT+IHUAe64k8IHvusuCUSu3iym/bgIuHjTIzWPlox8uQ+G9vnnzoAutI9RMfR0PNGWTWKkoL4E+Q==
X-Received: by 2002:a05:6214:8d0:b0:880:5edf:d177 with SMTP id 6a1803df08f44-88d8166ab16mr75829146d6.11.1766258188969;
        Sat, 20 Dec 2025 11:16:28 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fd14sm46045796d6.8.2025.12.20.11.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 11:16:28 -0800 (PST)
Message-Id: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Dec 2025 19:16:22 +0000
Subject: [PATCH 0/5] doc: convert git-status, git remote and git stage to synopsis style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

The changes are basically the expected stuff for synopsis conversion, and a
few cases of "imperative mood" style.

Additionally, this series has two special commits

 * fix to the comparison of synopsis and help, to allow using synopsis
   paragraph elsewhere in manpages
 * the "ascii art" tables in git-status are converted to plain asciidoc
   tables. The alignment output is managed by the asciidoc processor.

The second patch is a RFC as to whether we should convert our tables or not.
For the translations of the manual pages, this setup simplifies the
maintenance, because we are able to export each table cell as a separate
segment.

Jean-Noël Avila (5):
  doc: fix t0450-txt-doc-vs-help to select only first synopsis block
  doc: convert git-status to synopsis style
  doc: convert git-status tables to AsciiDoc format
  doc: convert git stage to use synopsis block
  doc: convert git-remote to synopsis style

 Documentation/git-remote.adoc | 106 +++++-----
 Documentation/git-stage.adoc  |   4 +-
 Documentation/git-status.adoc | 356 +++++++++++++++++-----------------
 t/t0450-txt-doc-vs-help.sh    |   2 +-
 4 files changed, 238 insertions(+), 230 deletions(-)


base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2020%2Fjnavila%2Fdoc_git_status-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2020/jnavila/doc_git_status-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2020
-- 
gitgitgadget
