Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71473170
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705709308; cv=none; b=md7LGutZO0RnEDO/z1b3RGHo4uWFFTJV3JUF3G9fO+UdRFUz+BlcxPESE4jW1wNkyK1IEPQmp1MbfArEQMA1ehY50uDaTUmQ057ZX5LbSd4HAm6IUIOF1cCP53oL7iDr/xIqDhjdFzp1+VbA0zvRt7fnhNl5ZJyvuT41jidyzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705709308; c=relaxed/simple;
	bh=B80ofsmR8k0Zv20wWopho3/ecxhk9yNpRfccLVi7DjU=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Dqj3yZI0zfuxY1v5Jg8MITRGJlnD2tMknYjF9ZEKGX20LpUg+VswnFFbz523h+K1Ncf9hflbf6zvEl4K1VJE1uRuOrfCc+i0ePazgKkrcV/+OBboQMO29jRi/hwZo6GcnZZVsgha+DK/bYb1O3hOHgb2ay434vZ3nc1Fv8795NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLZeEC+v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLZeEC+v"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e884ac5c8so14619715e9.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 16:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705709304; x=1706314104; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QE/+kNkKGtOeEkTl+tNnpgwk6Uzs6SSzBMsCCxAocVY=;
        b=mLZeEC+vBi/kq4vQ3+vdrqDFXMHAwiMrVOuA4Y7XxB+7MQnTLsUmUoN3XWMmU06e8e
         lcYXcTknDXXA/1vSiWrD/wQnGetvv7dFj8xOPTpupOyJiYUwgcZVcv6/N+a5g8u/z1C/
         wedKXs+6GOD25+1hWgKQNJcRBuIdOY71EGS33vbxeH0jcm2Oy9PaVRiPE4bfhR8DyJNM
         5thoS+joOyRsL5sUBNz5BE1MinDyonoxZVMpVpkfLfThphVdqelk3DlFWL1JEVeC91+H
         8xWDU6yPaQcRn6/h/NXkeAb23VMBE2eKfP03sEC4J65rbvvJppmCKnwPsWyQQatXrDNp
         EkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705709304; x=1706314104;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QE/+kNkKGtOeEkTl+tNnpgwk6Uzs6SSzBMsCCxAocVY=;
        b=I6ypi2jl5alsFIr/DidbdWpz5VGo81xfrOPxKc5KTYAaiBk9F5jwaGGLj1iKv5TE/K
         CaXpRttYfP+y365od14ASEhlu9Imk/6d9mMBVgwTU01yZdONNmKs7gt/NLB6lMsubFBN
         Uz7+lHIceHhuUkmXSi8YfU6W7u+wlJDXEcPp53Cql/qSpUCB5fPBoMwt2Yq7Tt6O8ozm
         Spa50Llw90IEbPThiv7IA4R5h3VTccLyfxtDlUZJcl5RuTvZzq8egVCRYR807VfB06B/
         7hDS21tk7bSdb9GXzGpOGAKtxhfMm6aP4YQc+48UOntR/4EL+uLRRkcU7Jpk3vMF49AL
         r8AA==
X-Gm-Message-State: AOJu0YwVu8lx1ItZk4pW3Q/MUnaDLlghHOLC34i7VjEvggePAExztak+
	OH2zMD+JYlU0Y3L7L+EmFCZjkjdWSYn4DwgxfnXGCf3L2WFn3gkmWreBiaAZ
X-Google-Smtp-Source: AGHT+IEqZmkdrh7gVDmrSaDRWXFlRn7pKa+ktGzxUoAEtFjpRBEoLODHr6gIGI8rbMkkmjQAS/osiQ==
X-Received: by 2002:a05:6000:230:b0:337:c4d8:a570 with SMTP id l16-20020a056000023000b00337c4d8a570mr109473wrz.11.1705709304272;
        Fri, 19 Jan 2024 16:08:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12-20020adfe88c000000b00337be3b02aasm7591062wrm.100.2024.01.19.16.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 16:08:24 -0800 (PST)
Message-ID: <pull.1645.git.1705709303098.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jan 2024 00:08:22 +0000
Subject: [PATCH] setup: allow cwd=.git w/ bareRepository=explicit
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
Cc: Kyle Lippincott <spectral@google.com>,
    Kyle Lippincott <spectral@google.com>

From: Kyle Lippincott <spectral@google.com>

The safe.bareRepository setting can be set to 'explicit' to disallow
implicit uses of bare repositories, preventing an attack [1] where an
artificial and malicious bare repository is embedded in another git
repository. Unfortunately, some tooling uses myrepo/.git/ as the cwd
when executing commands, and this is blocked when
safe.bareRepository=explicit. Blocking is unnecessary, as git already
prevents nested .git directories.

Teach git to not reject uses of git inside of the .git directory: check
if cwd is .git (or a subdirectory of it) and allow it even if
safe.bareRepository=explicit.

[1] https://github.com/justinsteven/advisories/blob/main/2022_git_buried_bare_repos_and_fsmonitor_various_abuses.md

Signed-off-by: Kyle Lippincott <spectral@google.com>
---
    setup: allow cwd=.git w/ bareRepository=explicit
    
    Please be aware that I'm a new contributor (this is my first patch to
    git's code), so any style nits, suggestions about how to make this more
    idiomatic, or any other suggestions are strongly encouraged.
    
    My primary concern with this patch is that I'm unsure if we need to
    worry about case-insensitive filesystems (ex: cwd=my_repo/.GIT instead
    of my_repo/.git, it might not trigger this logic and end up allowed).
    I'm assuming this isn't a significant concern, for two reasons:
    
     * most filesystems/OSes in use today (by number of users) are at least
       case-preserving, so users/tools will have had to type out .GIT
       instead of getting it from readdir/wherever.
     * this is primarily a "quality of life" change to the feature, and if
       we get it wrong we still fail closed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1645%2Fspectral54%2Fbare-repo-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1645/spectral54/bare-repo-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1645

 setup.c                         | 3 ++-
 t/t0035-safe-bare-repository.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index b38702718fb..b095e284979 100644
--- a/setup.c
+++ b/setup.c
@@ -1371,7 +1371,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 
 		if (is_git_directory(dir->buf)) {
 			trace2_data_string("setup", NULL, "implicit-bare-repository", dir->buf);
-			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT)
+			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT &&
+			    !ends_with_path_components(dir->buf, ".git"))
 				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
 				return GIT_DIR_INVALID_OWNERSHIP;
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index 038b8b788d7..80488563795 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -78,4 +78,12 @@ test_expect_success 'no trace when GIT_DIR is explicitly provided' '
 	expect_accepted_explicit "$pwd/outer-repo/bare-repo"
 '
 
+test_expect_success 'no trace when "bare repository" is .git' '
+	expect_accepted_implicit -C outer-repo/.git
+'
+
+test_expect_success 'no trace when "bare repository" is a subdir of .git' '
+	expect_accepted_implicit -C outer-repo/.git/objects
+'
+
 test_done

base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
-- 
gitgitgadget
