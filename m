Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0D32D0F3
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764335786; cv=none; b=QAlqLIgouVTbHsRea1Lr7OBqHumXj3oQqKzxfvoIJg+AS5Fr/hJyakO6X98TrtUQPs4ZsdqdInGvjWNoxD3BHheBtqALGYSeyIm9gPjYKO7j9SLarzf3Qjdsj6xn9r8FVSJjznRhbQUOtGXVZMFoLBVhyMSi34V8pbX6hcV3EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764335786; c=relaxed/simple;
	bh=xFX+MB9jqFvIOj5fEyfBau13U0nXPOR4LyKOVMa03qU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=C7sp7RcSHiJMOVzTZunAPC/x4lUu/sajG08zHR+kwa7l44xUy28aV2Vb59/sJhVv3y9HduGkIn863DYfycVKqY7kHDTahsQ4SDbc4wVn2Axxpaxzj8HmX6kURg8CJQn5OASIIO1obmErnJzqhZs+9K2XwZMpEAitY6dIuD0y8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyQ3sGRi; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyQ3sGRi"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-948f9b5987dso58241439f.0
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764335783; x=1764940583; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4rN4TBgVPcB8TnUowKX/Bxj03TqUxEpKDVM5SKnmfz0=;
        b=VyQ3sGRia8sz1NXj4a830BMH+1zqq5zb3G5uTR0NmPZJMNHwaylmRxHTy3pBSRTdif
         aEYfKuQxGU4go5P/gRl67aOeRraCRoevtZTzJMt1rm2bYxomArr2XSGx+PWDsW4Xa4jk
         KiAwTrUERCyFb3NDqTMHSPOaPQnEv0OQe+DYz1zmsNgW7YHTXEpVQYw5tyz5QRUsY8c5
         QbF1GRZ4Ra1nk9a9RS7p8xv6GnIIWlLjStrK2lTH3bn5QEv9Z6xU0zHpMAdQ07+8K1Zv
         8uWqNkbnnVa4t6kcVdJXwjC36pmAxjgm3UsdGyZv7Ruf43Ls0Wm7kQx58Gr5Cgd2T/aK
         2IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764335783; x=1764940583;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rN4TBgVPcB8TnUowKX/Bxj03TqUxEpKDVM5SKnmfz0=;
        b=om2sEpZF1D4iqLPlsPRx8zutirWXCAPx6CYH7ng2rfm3H6qyDSGGLfdNlsGhEMPCp9
         I/IqoBBedDoj/dGSHlTxCdsn9wJZbr/aucpECqYAotarmrkFDtRY4NCibJZjRY9lZDDt
         hMDJFqMK/x4zRg6T/dcvPSz8enowMnKsj9rWtQNrXLFLmtvJ5tCcPvR6H0xAGKeiPQrs
         JAlhmcxrolQeDE0ExkIDlabd9N2pGwdOtb3tr7uAlvDHXzxQAYydt7dMJe3rk2SdlLNl
         VW0MRSFfEghEmwbTRPcqVP1MhFzEUGbuqaxdV9Pc+L/YY7DTFjpjIu7puU3i8ANTZFON
         yTjQ==
X-Gm-Message-State: AOJu0YwmYBZOOkJJXmxyPvRxwugOn/Jce2nThDkP4hZKdwA9yhxu6azB
	sC1SM8atu1wZV3kHwZHbw1YdlILp39S/O9KyIAxqpzHLMw34NGieI03YhLrt5w==
X-Gm-Gg: ASbGncuaCGcpjjBoO8PSlYWVE5JxCtm9XWeMriKeJ0X9TJjOPqi1jRzpq2ebTLrHINx
	CsOi0gsEE/tB6OGSfu9t207MGSALkQCRIT8SKl7KHH92DY3UKNrFejsDneCa7sPm1h4JqN29m2V
	1aVROvI8NCCxuJ7G0X8cougHHtFo+2qgtjEl+l5c2azDRWQPC4Fbl/0Zs4K+J/IOxHLNDXRdNF9
	tfmVxPV/g1IqjKUC+qD9yD2uU5WUaEyfJ7+2WQ5xdgAER10V9iHiAfpOnqodbQA94gnMAk/186h
	umr48yPVwpiGCBAZmL5SKrvSKGsyOLqqXVqUrv3Y0SpVUnOPF/SQUo7qFfI+kuWrrXiTIcuJ2jb
	bnR+65SHR9bmrNF4e7D2+m4p5IuP+JVwQnJ9KooCzh4a8oxkokk+sw+OsiEy6L5l+MDo3XXbqeu
	kAWCZuZLsrUb41aw==
X-Google-Smtp-Source: AGHT+IHe1SPYN/69ozjzfjpwzEoBQqTMyj+NozSljgU6CMZBGLwR14mjxkzVU2QElpwYWErtpgHHig==
X-Received: by 2002:a05:6e02:18c5:b0:433:6aa2:f6aa with SMTP id e9e14a558f8ab-435b8e620e9mr271240185ab.29.1764335783114;
        Fri, 28 Nov 2025 05:16:23 -0800 (PST)
Received: from [127.0.0.1] ([52.173.219.145])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9498fbc3f10sm215979639f.4.2025.11.28.05.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:16:21 -0800 (PST)
Message-Id: <pull.2111.git.git.1764335780515.gitgitgadget@gmail.com>
From: "Stefan Rieche via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Nov 2025 13:16:20 +0000
Subject: [PATCH] docs(git-pull.adoc): fix man page typo
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
Cc: Stefan Rieche <stefanrieche@gmail.com>,
    snowdroppe <stefanrieche@gmail.com>

From: snowdroppe <stefanrieche@gmail.com>

Fix typo in man page from "git --rebase abort"
to "git rebase --abort"

Signed-off-by: Stefan Rieche <stefanrieche@gmail.com>
---
    docs(git-pull.adoc): fix man page typo

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2111%2Fsnowdroppe%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2111/snowdroppe/master-v1
Pull-Request: https://github.com/git/git/pull/2111

 Documentation/git-pull.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index cd3bbc90e3..d3006359ed 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -38,7 +38,7 @@ or `pull.ff` with your preferred behaviour.
 
 If there's a merge conflict during the merge or rebase that you don't
 want to handle, you can safely abort it with `git merge --abort` or `git
---rebase abort`.
+rebase --abort`.
 
 OPTIONS
 -------

base-commit: b31ab939fe8e3cbe8be48dddd1c6ac0265991f45
-- 
gitgitgadget
