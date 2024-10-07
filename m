Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224D74C08
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337769; cv=none; b=oVsFz4DKdua2wFihZP5InfxkNSG10IrYyRVpxnfzGsALszeFIJcsI6Ms7BIAB5H6LO1tlzfrkCikdIgWte8uvFFXMGhR45GhrsaCJgEuHuyESf51xkeeH5D02VzwsOpsbb9QU6KbJCgDa88i1bYrw8oqwLptsQg7h/EogvH8T4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337769; c=relaxed/simple;
	bh=5w4Q8NA/sIOOKeBYmv46dFWeTmdwZX71MAUCjMO6F3s=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=DvPD97VqKQC5PekI4iUGCe2paaRN9fPhexWIFTrsNauJmZ8ucGKGH8AELJFZiPZbqDO65GvpXE8d6ZD+M4Sj5xrOBaxEmtDN8Oaq7VKoRkhpeDXQfBZiFAo42EvUNeRHkTeYchWLGNV3+I/tHDOcet3bG3kFu5S9ZJ5xZnj6SqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaPohdJu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaPohdJu"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a843bef98so661559866b.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728337766; x=1728942566; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PLE8wbobKS8CQk+epf8k8msSD/wulM4NyIzntJr5CwU=;
        b=QaPohdJuVplQzIF8UJr8Fk5nyv1eTHYfnuhlQU9vrIyzH9qQYQpbMIdg61wTIj8AaH
         QYqrKreB1HyG8JuOiypcwn3xSZtMgFLaf6GCk8xHmNTt83CMIEGSewDtmAxcNf5oEcRu
         PfjXXKNriixCd4EY8IskKzZZevg7ZHIFTDFKlctmpny73C8RdWBo2bWNPkaIdqi4kvIW
         5O+gHlsGx7XZhNostvmkmw6vYIb8EXX8is/MeXgPnWMuDbCSxc4zfGZcCoICMsg8KAd6
         vU40W/2fvcRVvICabSnEtk7nsFD0m8YpMk7gwX6JKQ4N3lD8P6dEGuPHSK9GtmRcyE0k
         ZJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728337766; x=1728942566;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLE8wbobKS8CQk+epf8k8msSD/wulM4NyIzntJr5CwU=;
        b=e61zX+oStD8NT8FwC4sWja+jEVrtzeBxu414cgK9GJB0fre0unb2esRU30oUGMXcub
         r19mbqLu8/AeW+rVKzvBDkC3OCYdXpSTC9o2klmkXM1QV02gQ07Matbm60rCtuW41aOk
         B2oU+M4lJ3qXLsPNQaxodGMkDMqS+RCarcpB3Sa11RGYOzkEL4/GlEtziGXcGoFiMu3m
         qZTY5iOdT289Kwx1smgOPGMji69y9t2kvWuJRdvURJYFxTgy9+7nnOaifx72Es7R/CdU
         sT7ClGQzAnT2NosG5Aba1l3nG8kenYB1p7barwwwjW68cwtyXjA1q382t4Zaj+vCuApQ
         d7zQ==
X-Gm-Message-State: AOJu0YzClM5ZdxlucK7JZpA+fguN/SF6geKQOQlwg9f8FJ7s9u0tJzGX
	rCU2C7n0dK5qdTuOH4yYyfjHspbXoCimh7XhL5bNABh7J+Y/vLr6SKOY9Q==
X-Google-Smtp-Source: AGHT+IH6+7ibIdDCf5ts43qsmidTSJML/c1Bcaf5ZGdMoptq6IcbjFVCqosoOXv7cIO2ahc0wd6Nkg==
X-Received: by 2002:a17:907:3f87:b0:a99:4e2e:6f58 with SMTP id a640c23a62f3a-a994e2e76dfmr648892866b.35.1728337765867;
        Mon, 07 Oct 2024 14:49:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993729c4casm397497666b.149.2024.10.07.14.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 14:49:25 -0700 (PDT)
Message-Id: <pull.1812.git.1728337764963.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 21:49:24 +0000
Subject: [PATCH] docs: fix the `maintain-git` links in
 `technical/platform-support`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

These links should point to `.html` files, not to `.txt` ones.

Compare also to 4945f046c7f (api docs: link to html version of
api-trace2, 2022-09-16).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    docs: fix the maintain-git links in technical/platform-support
    
    Noticed while deploying to git-scm.com
    [https://github.com/git/git-scm.com/actions/runs/11219313103/job/31184984303].

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1812%2Fdscho%2Ffix-maintain-git-links-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1812/dscho/fix-maintain-git-links-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1812

 Documentation/technical/platform-support.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/platform-support.txt b/Documentation/technical/platform-support.txt
index a227c363d78..0a2fb28d627 100644
--- a/Documentation/technical/platform-support.txt
+++ b/Documentation/technical/platform-support.txt
@@ -49,7 +49,7 @@ will be fixed in a later release:
   notice problems before they are considered "done with review"; whereas
   watching `master` means the stable branch could break for your platform, but
   you have a decent chance of avoiding a tagged release breaking you. See "The
-  Policy" in link:../howto/maintain-git.txt["How to maintain Git"] for an
+  Policy" in link:../howto/maintain-git.html["How to maintain Git"] for an
   overview of which branches are used in the Git project, and how.
 
 * The bug report should include information about what platform you are using.
@@ -125,7 +125,7 @@ Compatible on `next`
 
 To avoid reactive debugging and fixing when changes hit a release or stable, you
 can aim to ensure `next` always works for your platform. (See "The Policy" in
-link:../howto/maintain-git.txt["How to maintain Git"] for an overview of how
+link:../howto/maintain-git.html["How to maintain Git"] for an overview of how
 `next` is used in the Git project.) To do that:
 
 * You should add a runner for your platform to the GitHub Actions or GitLab CI

base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
gitgitgadget
