Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB3E2F0666
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029255; cv=none; b=lcyFFm4Uh9/+D7MN7OnxfpLOm/aqXy5h8qlhbqpojEqeI/0KOq6gBC+en7dMNcA7iSMExTUfNZi/yloBh224GQ/HPdwMdDSd5F1Qloid6qD8iJoh5WhAr5j+oqE8ORugyVdb486OBn/ObVJuFeImhaLuWRMedYbmpnpe5rPwRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029255; c=relaxed/simple;
	bh=1ENM7zrrkWCf9W9YO5A+Nb2taAo3O77D2qBctc2+42g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VCNEHGp+TvDIHuOd4bTarNJsIzGGtXOJemZuRYR+DeXYF6gR7P9e8vmt+aNCbxnp0hZlYXYmmpiOO46/RrbkXFDZSFYwPzQo/NHxKeAl4+QGKdqKhU/fraydgydofy/yuLnNnt3SsKARcNXLMtkD7Q5ee8fjp+mW2p4mQ7If0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkfuxrP3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkfuxrP3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459e794b331so34888765e9.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755029252; x=1755634052; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEhFhAdna4HeY0bpzH4p31RZoVINlcuGTD8ZnT83Q3E=;
        b=UkfuxrP3ov52JQyW5TBIQUjuzbkZDULalGhsf2ryASiH+HUVCm7s+mdYQRUJxlFLyn
         kjbwhbysq6XexAg7Qs1bdNDnHXYnOapJJozZcb23nupN5qtS4mMp5LeBeOnibazB/Wfp
         QdGsQPe6imbwQcWiyp9J6tB9V8184aT1z+eydkL/E1XDYkH9QAHLPtADhtzMeEiuhFxN
         H7ZuKIklp3bZgQohYRDKMVwB8J31U77Zn0vB4BKo0CkQxVH9i92s51+MBQPMsWcIIcPQ
         +eirlshF6sr1d5h3UOJmXh9nCVpKD9x/NdHSmWh0ZMM9XWPgyz1poEybJ9HlCO5WK0c0
         TYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755029252; x=1755634052;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEhFhAdna4HeY0bpzH4p31RZoVINlcuGTD8ZnT83Q3E=;
        b=L48jwOkhTHE5QkRpLjORzY8qYuqjF/saXaCTSuFQa0f/UMaSjiLznnZfE9f+hGnS9F
         ec8mUykmnoR6mQseodqYae2cNP7qU44iXNEn6Rf2/zs0/Xw03oPqik02vtZXpyO9rZgd
         MXzCV1mYJNv1PabGnylPZi49yI0a2+zIU/30KKMs5Xd1HdhMLZ7mVVaW3NaVAwdjtnX1
         SJ/h9++Sck15Um6JpJYkbYTLWkT7xqJj/JDMm+7X1vV99ahDn5UYij5pUSVesQ9kRVN7
         8SWSrEKqdNlXmw57FuOcu9AoedDi9HBDnen0UxSf70vROvFrHwl/pJeOrTBnCt7B2sEY
         34hQ==
X-Gm-Message-State: AOJu0YyeCDKyeVibY6sbS4xvHDT03pUbqSLCEBHVxlt8kNxQ7akUCBVA
	KIcIK0DMXEotrv3f1+YVgdkuVgz3FUcca0dwKqZ78TWUCajXsp9eRh22aZm2mw==
X-Gm-Gg: ASbGncsf79cSahXG84ODF7CEe5ESAaZG1Ncgx7e04s4KTDy7Lkm+11lARPSXrVIV5eR
	rINQ09zvNEPSTGBghi5PKldq5kd1cc98wm6g7G4Umh7bU8+gnj0MH3BGz5DK6R3CDZE5XbTdK/D
	yTJcMy8wvwxSt3ZXJ8gAYBAlz5PFPAPPHySG4FLyN+EPOZzBU2jzByAqOgrbKJ1J0sSuhISlJX7
	dFKqXLiBCBPRL9NTRieZdTVIfrsu8u4pocyp/9a15GyHtENjoicoblwLpbTI/eXQ4yN9Q/v501k
	hqkfPvcAU3g/xL18o7f1oJlRnHUKy6gUndoykxJvjwR7ohgdV7mpVd0YXJqOynJ13g8QFkLt3VB
	7T+YBdS46+6QMiPE4EdA2ATMJDEbu+XbZ8w==
X-Google-Smtp-Source: AGHT+IFgqEibmTGkPbkGqsdNW6UyfPL3VUVBoGZCl0IXhl2VU65BCxyhib9mCasxCN4YeH4IOJcnHA==
X-Received: by 2002:a05:600c:35ca:b0:459:e094:92cb with SMTP id 5b1f17b1804b1-45a165b37e6mr3169355e9.12.1755029251784;
        Tue, 12 Aug 2025 13:07:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16d3e4c3sm727765e9.0.2025.08.12.13.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:07:31 -0700 (PDT)
Message-Id: <310d2c1d8f7f68ae52ddd29f0ccb0a0364aba1a2.1755029249.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 20:07:26 +0000
Subject: [PATCH 2/5] doc: git-add: start man page with an example
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Replace the intro paragraph of the `git-add` man page with an
  example to try to clarify it for new users. The goal here is use less
  jargon but communicate essentially the same information.
- Give an example of how to add only part of the changes to the file
- Remove the snapshot-based explanation of the index and replace it with
  a diff-based explanation because I don't feel that it's useful in this
  context to emphasize  that git uses a snapshot-based model: the main
  way most git users interact with the index is through `git diff` or
  `git status`, which is a completely diff-based view of the index.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 12afeead6637..99ca2d0f7e21 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -3,7 +3,7 @@ git-add(1)
 
 NAME
 ----
-git-add - Add file contents to the index
+git-add - Add new or changed files to the index
 
 SYNOPSIS
 --------
@@ -12,18 +12,19 @@ git add [<options>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
-This command updates the index using the current content found in
-the working tree, to prepare the content staged for the next commit.
-It typically adds the current content of existing paths as a whole,
-but with some options it can also be used to add content with
-only part of the changes made to the working tree files applied, or
-remove paths that do not exist in the working tree anymore.
-
-The "index" holds a snapshot of the content of the working tree, and it
-is this snapshot that is taken as the contents of the next commit.  Thus
-after making any changes to the working tree, and before running
-the commit command, you must use the `add` command to add any new or
-modified files to the index.
+Add new or changed files to the index (also known as "staging area") to
+prepare for a commit.
+
+By default, `git commit` only commits changes that you've added to the
+index. For example, if you've edited `file.c` and want to commit your
+changes, you can run:
+
+   git add file.c
+   git commit
+
+You can also add only part of your changes to a file with `git add -p`.
+Please see linkgit:git-commit[1] for alternative ways to add content to
+a commit.
 
 This command can be performed multiple times before a commit.  It only
 adds the content of the specified file(s) at the time the add command is
@@ -40,10 +41,6 @@ directory recursion or filename globbing performed by Git (quote your
 globs before the shell) will be silently ignored.  The `git add` command can
 be used to add ignored files with the `-f` (force) option.
 
-Please see linkgit:git-commit[1] for alternative ways to add content to a
-commit.
-
-
 OPTIONS
 -------
 `<pathspec>...`::
-- 
gitgitgadget

