Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C17304BDC
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775150070; cv=none; b=HxooKnw6hEOFTLslo4Z5zv/toS065mLpNtdNyy+ggjUKmP1y0JOaBRDuswUAEsnd7l6Fye9AGTVHcBMNuxYzAtzfRPURWKJ2QhISxDVAby+LZVmCsWRKy0Trenro6k+tgCbiZ2hajRi2/VNlwdXZbl13u7lQDbYpBy8VjnZYBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775150070; c=relaxed/simple;
	bh=jNf8Qssge6XhbrGZcSmCQk9VtNKJndDer5lXqE9Pvgs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=HqziB/C8RgCGYxPxKhspXSd2zh1PE6IzIUyN4VzIr9+iPNOBFrVg1tlw0EaO1eKEnnUDkNqxGOpaLJWFLrLRSLRQ29RfTihus3JxUKyioDymH84GLhSMIqu4g+OptKhMtHw5DZ1rBarlJBBAYmK1EMeX8evJgRLRqvQaAL2V9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+wvJCHf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+wvJCHf"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509061dab77so9705191cf.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 10:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775150063; x=1775754863; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S/AJnLbBrEGGeZ1lbfPCS9Qbq4bjVS9X+Jn+zJlt8gU=;
        b=n+wvJCHfDwDGRcpgGIlJgiakAu9/v5cWrBL7X1pNUrT3YaRLwJVf2wt8ujnpl2Rw0T
         4T6PzXowKUgnw/S+joGI4JTM6otDVSokwAvqhfoB6FXlfm4FiaxjDjuHUFvmVMsvfPoo
         3YiZcK/pg3hLH8tSrRRo7if8Ew0Gz5y2+qqlBw0YFuDMDdm41qJtnKWU4hlLua57h+/o
         tVlclZ89u8ZqMAK06syztyGj+p6XhW9HrQxhZexFuxZH3gLdsoXJ0NUI25xoAiuaPyuo
         cS8Lx8YbhSgqO0CwKQ80wiS6W8Jfxhr0HvjpVmATpq16TNS8JuYmX47jmBMkPNkpQ3Nz
         R0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775150063; x=1775754863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/AJnLbBrEGGeZ1lbfPCS9Qbq4bjVS9X+Jn+zJlt8gU=;
        b=qvDmMzzbuNRUNGKcICi05C3bXJs6CYxAYjw8DMMpDpgL3H+QymKkkja0OQsvYyeIhF
         aJri4duItbCNJ9IYk8BrqwthkfG06EFUx4nbGr2O3BAqOXxohqvd5P0EEpMC4njG137l
         KPLp5fwKcDWK33VeZTF4pHtmtJis3yTzZk7nW6cmy39tQeOViDIS22MT1V3fZymR3Hl/
         CXA3vtcPsLx6aRlivBAPSj+7jnFKRCrK2wxSgUS0hRoK2phQLVW3Xlv95rGvD5tL/8oC
         sHuSxNKVOOGRjCxQLHvb82lLSm/vd6Wa1W3jHzSJMQWOkt20hjm1jZeZQYD3SoMKDerj
         LOhQ==
X-Gm-Message-State: AOJu0YxtvlvVARD+cBFtuv1hxgEZhcJZCJjtMNea/tTE4k0eNPvH0G0I
	sHGaF0wSbPEBMFv8RpK9vJ4K/7+xzQ3ABpT+v+4D3c7tOJzfUn41vaz+2DMZXQ==
X-Gm-Gg: ATEYQzyYWaZ+aGHDMpwQDQt4ctiubtd/aGxeIPXIy6cBLDUdlf3JSulTGYyTDG/lvNU
	xdbPPJRcWdeC8tPoWU+Iflsi8J5xJ+J1heGcOzd1syTH4o5NGjO9P0KxjD0smHc7A8+N43GKAvD
	PIHeb1lFN1KViDgdPcWIawxnzUY+/54uC1SAlpU/yg7Ui2QUia53FqbSu7LEAwMOZ1L6nOg3hll
	kUWCoPSEPlJ1PAj5yLafobcpW+LgGzBUsIu7OO9lJiOYGT9nGHb4uOy/ICCZm0WcAFE+cfG/nd5
	c3tJJVFqve7zcpN4BAGvG3j/xT3Nfb28loanOLFufJos04dDRIsp9PlGkSYV4TdVVA8vFvdTHJq
	bRfWh09X1NQSp9XHNg7XqEUku+SstuixNW++nr13BCx8yGBWPPSFf2/HjMXDJRcYrSIdmCaAShj
	Clk8CmneqdvnHHbo6eLWTwe/he
X-Received: by 2002:a05:622a:4819:b0:509:3141:312c with SMTP id d75a77b69052e-50d62cc15efmr1044501cf.40.1775150063307;
        Thu, 02 Apr 2026 10:14:23 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.135.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d53c00654sm14774401cf.18.2026.04.02.10.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:14:22 -0700 (PDT)
Message-Id: <pull.2264.git.git.1775150062407.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 17:14:22 +0000
Subject: [PATCH] repo: add paths.toplevel to repo info
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

From: Jayesh Daga <jayeshdaga99@gmail.com>

Expose the working tree root via `git repo info` as
paths.toplevel, matching the semantics of
`git rev-parse --show-toplevel`.

For bare repositories, this value is empty, consistent
with other non-applicable fields.

This allows scripts to retrieve the repository root
through a structured interface without invoking
rev-parse.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
    repo: add paths.toplevel to repo info
    
    repo info currently does not expose the repository's working tree root,
    even though this information is available via repo_get_work_tree().
    
    This makes it harder for scripts to retrieve the repository root through
    a structured interface, often requiring the use of git rev-parse
    --show-toplevel.
    
    Add a new field paths.toplevel to git repo info that returns the working
    tree root. For bare repositories, this value is empty, consistent with
    other non-applicable fields.
    
    This provides a consistent and script-friendly way to query repository
    paths without invoking additional commands.
    
    Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2264%2Fjayesh0104%2Frepo-toplevel-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2264/jayesh0104/repo-toplevel-v1
Pull-Request: https://github.com/git/git/pull/2264

 builtin/repo.c       | 12 ++++++++++++
 t/t1900-repo-info.sh | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index 71a5c1c29c..d0491f6c66 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -62,6 +62,17 @@ static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
 	return 0;
 }
 
+static int get_paths_toplevel(struct repository *repo, struct strbuf *buf)
+{
+    const char *wt = repo_get_work_tree(repo);
+
+    if (!wt)
+	return -1; /* match existing error style */
+
+    strbuf_addstr(buf, wt);
+    return 0;
+}
+
 static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -87,6 +98,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "paths.toplevel", get_paths_toplevel },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 39bb77dda0..470e06e8c2 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -155,4 +155,20 @@ test_expect_success 'git repo info -h shows only repo info usage' '
 	test_grep ! "git repo structure" actual
 '
 
+test_expect_success 'repo info paths.toplevel' '
+    git repo info paths.toplevel >actual &&
+    echo "paths.toplevel=$(git rev-parse --show-toplevel)" >expected &&
+    test_cmp expected actual
+'
+
+test_expect_success 'repo info paths.toplevel (bare repo)' '
+    git init --bare bare.git &&
+    (
+	cd bare.git &&
+	git repo info paths.toplevel >actual &&
+	echo "paths.toplevel=" >expected &&
+	test_cmp expected actual
+    )
+'
+
 test_done

base-commit: 256554692df0685b45e60778b08802b720880c50
-- 
gitgitgadget
