Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB05284B26
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771187020; cv=none; b=KRD+vqjjc778vc0SakxQjs/3HxCT/fV13CmIWAax1M/6lgZzXMF3mSz66NQDQALhGdkFOs4XmVndlUk1yYTbvk4F0e08H2GL9oXgTzHKLMHfxOZmgi1rFsvZnyu7lrB/2JeNxhFgpIk7h7DUL4eRP01RW2WWrhOhHlI2bampHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771187020; c=relaxed/simple;
	bh=6Kdf2BpURaqzJ5tPqh5y/Rwi3SsJvPkRPwGxkuShcQA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=DKfr/DwN3tN2edjyLjUP5FHRsmflkawkXFXlD8yV/1VacKYXIcV//hZCgOHwW0T2VIc14GWmaI/4tjWz2pxhA3FFJiblNsnO4iI5xsqHGHK0iQLZYGBoyXo+Vp+gCCbYu24hUZF4p0wftS/25OnpMJk+o+s65+eabRKJOVMSzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdMj9jSL; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdMj9jSL"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12732165d1eso2804477c88.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 12:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771187018; x=1771791818; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GdXbvYjBDFK8uMsUnrSc0ML5bPJ2cPyb5G+pgkpYy58=;
        b=FdMj9jSLB3Nmyps18IH8XMvDNTSEk6fBhI9xrkYVEy1i25jhQHiMV7vLI9WsZH6zOQ
         plLIKKGpbXxRKsLss33W4KBf06aF/0U0xblSZVV/e++CgYWUMfMky1riM4XkZVxepDLP
         gkK4smHZGfDWyiZtJ44rYNNlgHmgOmU8pWLY2lITN+bEqWku8m/rkpj3t88J8HOqAKEn
         WqSaQk0rV5feU5GCH9J3LuhFqsAABF15wz6Wb21EtZAN/iEZlzALauIrOZahZPFOqBjU
         NFv9DdRj+jwP0uqVFRk5aMlOPY4KY599V83gHwFIMuJCGUqBRG6uQphif1qkiAEGaeJY
         UAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771187018; x=1771791818;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdXbvYjBDFK8uMsUnrSc0ML5bPJ2cPyb5G+pgkpYy58=;
        b=fmBRl2Z8SPZGJq1GsMKiWNE4UgDpY6m8ygorDiggrVtnVRKOS8qqShESSZxVl5q1uu
         NijU32cN8iDYMLzCmMi3Pdi0Qa8Pqmj9Mn0SbVI0Iw4Pi7bXi89ABLmZ5NKO13buEQqS
         v2Z8SCTQrarDjBzszr8ScR7ieh1yLaU5MaONfep1UVqKKR4lh9QuM+F2yfaRLWnVF7Q2
         9AWVzh+ENGAYPofZtj0PSCwZKqlpJGbujb0XLydWjHvY75KaHKeuy1L19yGoqHFILY3I
         acqpxBo8nPvTfUDo2f+zeMOWprLGUk+KJ5HChAP6LbfHZGAeYu4juvwq7etBnSKknFLH
         v7Sg==
X-Gm-Message-State: AOJu0YyYgiqkqM5C9i0ng53B3vqXWrYJqK9vli5RJp3R9nm3Gl5n8X28
	Q4ZRaLN9Iof3sDSgQoU3/Z4aOpzJbZ1EsBx4YjUIpej1X7G81vSMawI86rmrEw==
X-Gm-Gg: AZuq6aKKjWfBG5nBA4UFg0BvGRoSvL684ThZi3UHeKy4SPkNsjYWgYG6Ld3zO+3WP6U
	LWTiGeUELhksQ0Gk1bznIh20zDHbO2XzM/6sYkXEq2+i9O1T2x6PYpZgsZfWmz64ChOgDL16yF6
	t6Sl4HyzrL3N69dfl5kVVE/UIgpWnJf29e2MgSFIf6mVYwaCm7aIGIuisJlg/mMvw9XTB2g+ibZ
	VKnm+qfRzg4i8vX2/yPzRvP3athI1vh9d9pZ3GhL/bnzNoBDZKcnSPt/nNU4elO73FFDoaeSeZ5
	awHHNOW3IGKy1cEopsyZBmNhFeKuXE75+LqUxN9RDSFiE2H6SSYZ+3rJTfXoGidGxGPqpgoLiTu
	kW0UDkqS7zvJXSiYeQnCTsmqKilG6WLanwgYHC4OF/c/qBnZ5HqtOXoXQ4AteU4Ce5j3w22DNyq
	cNkwp6rVaFHISsQ2chXXMoREtLRBI=
X-Received: by 2002:a05:7022:660d:b0:122:a2:ffcd with SMTP id a92af1059eb24-1273ae695c9mr3360344c88.23.1771187017664;
        Sun, 15 Feb 2026 12:23:37 -0800 (PST)
Received: from [127.0.0.1] ([172.182.226.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742aff32asm7865289c88.0.2026.02.15.12.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 12:23:37 -0800 (PST)
Message-Id: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
From: "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Feb 2026 20:23:34 +0000
Subject: [PATCH 0/2] fetch: clobber existing tags with --prune-tags
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
Cc: Orgad Shaneh <orgads@gmail.com>

This was documented but not implemented.

In the flag description: prune local tags no longer on remote and clobber
changed tags

In the documentation: ... to prune local tags that don't exist on the
remote, and force-update those tags that differ.

Orgad Shaneh (2):
  fetch: add a test for --force flag
  fetch: clobber existing tags with --prune-tags

 builtin/fetch.c       |  2 +-
 t/t5516-fetch-push.sh | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)


base-commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2200%2Forgads%2Ffetch-prune-clobber-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2200/orgads/fetch-prune-clobber-v1
Pull-Request: https://github.com/git/git/pull/2200
-- 
gitgitgadget
