Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D752FC866
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127226; cv=none; b=D7XsKKbauotgMwtQQTLUuHnDasEYmFiQ3OGoVMzLaN1bJmx4mfzqZOlotREXNN1MHYEqy4T0lSzaJEdZB0kqF5124yAZGxphWWkniiuOgu99NdUtvL75gVgDQC+ovCoa1g9xmGIKq2swQ4VU7VWUgiq+PVW0vKFVbXqChJaQCgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127226; c=relaxed/simple;
	bh=DBMDM6XOq0VObkotscA64wAjc99v9/mX0YPvLJGCsRA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bgcymwxU0dYjISNQpFAmNxw0iJxAz5gaav8dnJ6A1Buzkk5HQzMkh+AZTUuIN9jiPnIs6TkFqo15actY0sjV8PSYH+CvjzQEJ2FGeXtqE/ibYcJV6V/wY0lpxkE69seEsVOf3aS4xlOhqBxrN3Y2SDufdAJO42H2roSG+8PSGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lf+FKj7M; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf+FKj7M"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9e415a68fso270140f8f.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127223; x=1755732023; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stotVwarsyuxDYN/1fZGFSS3g3fXLc6cDAyC3eJ7Hvg=;
        b=lf+FKj7MvjUN3BY8CTycso03SMkrhp1/59nZbHfie1lC/3kBnSu3cd86w6/NyCzMO5
         /4q7gU2b9t+KhXeYF7uXrruzFrDcrSt7l1WYpp5DHXJ1rLpE+OA++8KB9g7Mn1WtrRA/
         xmG9k7rMSpq0usiC/R7cz49wUT6Oz7V8c37VPEnaZOIyipljKeQK1R1XMu0JEr9Gipcb
         NhztKEI8iC6AKPjAAsHa98T3YhSFbrT7fMbb8ayqZZBm6melDSJ24Hhp/beMnom5DXtQ
         7WExnAd4wqCmIXSVgr2Z+miqZakc2c3OOY7gAsV2R4Zoxwacoy7J7mdeWkA5isKPmH4m
         yTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127223; x=1755732023;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stotVwarsyuxDYN/1fZGFSS3g3fXLc6cDAyC3eJ7Hvg=;
        b=YnJV57Y7nCkBni8RNcl/mhkC/uhm2kC1igOWCWd1c4LzljR8QzjZ/3nirHomt16hRn
         yrstNWJ/2EpPpxM6q4oOZLmqwXLJiy8/PPYTY+vYnLi4GNkj7g8B6gEwZO6gQjjARU+y
         zOGxdPmgEsjt7imAGSXx7643Thh1kUALuNjGmrSQHt76vs7Tyr8lP9etczKWQjZeOQpY
         ZL0Bx1i/vyfbCNdUa3k4A+N5xVPAE+xO+uui+stZS57pUUXxvGQ61rZJhL22ND2N4u7u
         /regA3GK6SLqVIRNofjZxK8muutnFJerd3m4Us0dXEsLrT1OKUsGJ4zqbsXklwdVxvoS
         yW9w==
X-Gm-Message-State: AOJu0YxhrYWptQ/Jl3UdSSc1COBHXPgyLjSsk+b7grHFV06ES1YC3am5
	CL5WsJ3Mjhqw/dKqbWp2BJn+5BaBrNwuKr7joWxJjgZk7gV0q68/Uv8bajGcfQ==
X-Gm-Gg: ASbGnctP4+xbrHs+Dn1jwCtSGl5VitoXdbDycQ+ShdibtaXl4C2Y832dY6RSPjSWqnt
	/dvk6fbpUM9d89hCNogzitCLP+1xu3ueXNXbC0oNxLs1iKO3V5oE5IOlRmANOhUKb6S1UjEeNT9
	JDkZupmtSEhl9Kz6ugW3hPr2wOQ/pxnKllNs1UCOhAgFDhjEFPIajWQJ8JHVTXJ3EWFiMFIq9p6
	dtS35J2vX81IaxSCkML4PSYVzq8BDJBjiWB7PQYjJ55CouSk1pbMGnIv6cSREOlFoWrgjh8YWMi
	SR54uVI3YT36Fk0kTbRl7fZJG///v+akjy1izhX+ucEm+SNGq2iVmeOKZW0BTCUxJfhobhWWoNL
	sjh792nm/Vf3fzzcR2n+8qyYGBHYveO5qvw==
X-Google-Smtp-Source: AGHT+IGnqJZpq+M19+wDikJhFPftNWRtooo0ZQEEg+vmFfz4sK/veiIfG+Bje7fm/2GCwP7iRsCbZg==
X-Received: by 2002:a05:6000:2508:b0:3b7:78c8:9392 with SMTP id ffacd0b85a97d-3b9efa99e59mr623830f8f.19.1755127222724;
        Wed, 13 Aug 2025 16:20:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b91330bf7dsm6818535f8f.28.2025.08.13.16.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:20:22 -0700 (PDT)
Message-Id: <ce1eafb02860b390da9359f92fcf098b7cdd3a94.1755127218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Aug 2025 23:20:17 +0000
Subject: [PATCH v2 3/4] doc: git-add: make explanation less dry
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
Cc: Chris Torek <chris.torek@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- use examples
- mention `git diff --staged`
- link to git diff man page

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 75e223f6b1ea..6a6f5223419f 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -31,13 +31,13 @@ You can also add only part of your changes to a file with `git add -p`.
 Please see linkgit:git-commit[1] for alternative ways to add content to
 a commit.
 
-This command can be performed multiple times before a commit.  It only
-adds the content of the specified file(s) at the time the add command is
-run; if you want subsequent changes included in the next commit, then
-you must run `git add` again to add the new content to the index.
+The `git add` command only adds the changes at the time that you run it.
+If you edit `file.c` after adding it, you need to run `git add file.c`
+again before committing.
 
-The `git status` command can be used to obtain a summary of which
-files have changes that are staged for the next commit.
+If you want to check which changes have been added, you can run
+`git status` to print out a summary of the changes that will be committed
+or run `git diff --staged` to see the full diff.
 
 `git add` will not add ignored files by default. You can use the
 `--force` option to add ignored files. If you explicitly specify the
@@ -448,6 +448,7 @@ linkgit:git-rm[1]
 linkgit:git-reset[1]
 linkgit:git-mv[1]
 linkgit:git-commit[1]
+linkgit:git-diff[1]
 linkgit:git-update-index[1]
 
 GIT
-- 
gitgitgadget

