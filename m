Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B53D72
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343467; cv=none; b=ZBFabb2ciKqz5FgGNTSESiIrC1n2FKUAZCQOg0HHpyOgJRYAo411FYCcIK7pSX9Hrum3mgmBlNMXY1k6OtDQyF3LxiXLrpjGR4b6F9ZfqskdEGeCnc+ecHab2iovUsF8lwhOOwMjnd+B9Ey09NCnLwmXvwXmkHmeKWcHt4rqoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343467; c=relaxed/simple;
	bh=oLZsuezFBVXVcbye3rLZNzk+MiQIxkqDz/GYg5VIReY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ex4RAmj9g3bTJJe4tYsswVlnbV3xi0kC0p67ElI4iBCFwusNnmVhBlQWJy4PHfrTuV9PA21XnGI5YlGM9N21v6VZOiSG93wbMduxpPRL7FoUCAIqWThm0Ppd5KM4JKsfCcUoYtJepbcl0yerU3IBLDJSUBrwEn7z5GGENjNb+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwUMcj+f; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwUMcj+f"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso22534005e9.3
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343463; x=1714948263; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s1fU6BozQ3C7N3wR2lXRBpkuXt4vAvxlp1vCZzu5LfM=;
        b=BwUMcj+fxojCV/GuegDoxLpQcvNa7PKyOEYkktuyT0TZbumRWMFULn1VeZI4kEMEuS
         oZ8NzLErPEG3z8qt4WO+FbA7CmICyLQLLF5S4wGUAOo6ZS2P8LyuLC98m99MFmBj/LAb
         +fX2r5waIoN3Gp/yJ7P3iTAYRrnZUyTbuWvi5+wvk0gKWCOuaGmRiiYc2sVBZ6z2atN8
         6DRGWuPtE4dUL2UgZy/WUE3ReVTQ17Gq8ORvSwt1UxomPtnsJxNbitCrCj+VJHVQIIsl
         bh0/fGajqGtizh9pzDvHkTp+mnA1Z1pVkHN1l5xMHMCdUY07nkPnYrkc4rEQlEU0+666
         H6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343463; x=1714948263;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1fU6BozQ3C7N3wR2lXRBpkuXt4vAvxlp1vCZzu5LfM=;
        b=Wv9cOA7u4cPTmBTDAOa+p381He5ll/MqQSmtg/JSGXlLs1KeAgy9hRtx0zS+KDAPEJ
         cAMc9CP4NfjTe01LWr4CP17Cp2KQkVLwN43s8Y1vQJu/Y4CTTZMtGJNkiqzK1nKtYgGw
         DkonkXQIob2Ge0myNlhJlRX3yLXrFA6hwhq+Li1n3JJ+S59pVKaFu6UKI7kNu4F1okCj
         XF1fA7qN6F/mxCLTsBl6sP5fFVAgSUgB5HImJazhaDMYdeAHnTLYsYiAczFQP6VJJ2sN
         hlzYX3JWTG7ywE/2Z+hdPKUaUkTycPDoSUkY4ogtbm2Q6s1DygyDJYiWKxuiRqG2PvYb
         X5cQ==
X-Gm-Message-State: AOJu0YzRODO25dE6yazvsbt5K5XO61SK5kQWPpZMJRnn+3NBkK9Wq4Sb
	bdNFB2LEDrntSuWyORjwnXstx3nr9BfiQrL/2QxkQJTpeOr6yen7fmM+zQ==
X-Google-Smtp-Source: AGHT+IFIX/akwNors5U8VMJB5ExGK7YH+AGrT+pBNLUegZ6soCwzzkCsq9pWR8Of1GtQkvltoxW9zg==
X-Received: by 2002:a05:600c:3ca3:b0:418:427e:21f0 with SMTP id bg35-20020a05600c3ca300b00418427e21f0mr6640802wmb.8.1714343463190;
        Sun, 28 Apr 2024 15:31:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0041a1fee2854sm28364082wmq.17.2024.04.28.15.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:02 -0700 (PDT)
Message-Id: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:48 +0000
Subject: [PATCH 00/13] builtin: implement, document and test url-parse
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
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>

Git commands accept a wide variety of URLs syntaxes, not just standard URLs.
This can make parsing git URLs difficult since standard URL parsers cannot
be used. Even if an external parser were implemented, it would have to track
git's development closely in case support for any new URL schemes are added.

These patches introduce a new url-parse builtin command that exposes git's
native URL parsing algorithms as a plumbing command, allowing other programs
to then call upon git itself to parse the git URLs and their components.

This should be quite useful for scripts. For example, a script might want to
add remotes to repositories, naming them according to the domain name where
the repository is hosted. This new builtin allows it to parse the git URL
and extract its host name which can then be used as input for other
operations. This would be difficult to implement otherwise due to git's
support for scp style URLs.

Signed-off-by: Matheus Afonso Martins Moreira matheus@matheusmoreira.com

Matheus Afonso Martins Moreira (13):
  url: move helper function to URL header and source
  urlmatch: define url_parse function
  builtin: create url-parse command
  url-parse: add URL parsing helper function
  url-parse: enumerate possible URL components
  url-parse: define component extraction helper fn
  url-parse: define string to component converter fn
  url-parse: define usage and options
  url-parse: parse options given on the command line
  url-parse: validate all given git URLs
  url-parse: output URL components selected by user
  Documentation: describe the url-parse builtin
  tests: add tests for the new url-parse builtin

 .gitignore                      |   1 +
 Documentation/git-url-parse.txt |  59 ++++++++++
 Makefile                        |   1 +
 builtin.h                       |   1 +
 builtin/url-parse.c             | 132 ++++++++++++++++++++++
 command-list.txt                |   1 +
 connect.c                       |   8 --
 connect.h                       |   1 -
 git.c                           |   1 +
 remote.c                        |   1 +
 t/t9904-url-parse.sh            | 194 ++++++++++++++++++++++++++++++++
 url.c                           |   8 ++
 url.h                           |   2 +
 urlmatch.c                      |  90 +++++++++++++++
 urlmatch.h                      |   1 +
 15 files changed, 492 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/git-url-parse.txt
 create mode 100644 builtin/url-parse.c
 create mode 100755 t/t9904-url-parse.sh


base-commit: e326e520101dcf43a0499c3adc2df7eca30add2d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1715%2Fmatheusmoreira%2Furl-parse-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1715/matheusmoreira/url-parse-v1
Pull-Request: https://github.com/git/git/pull/1715
-- 
gitgitgadget
