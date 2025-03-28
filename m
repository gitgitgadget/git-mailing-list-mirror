Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C761D8DF6
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181676; cv=none; b=T9xAw+eLTEgsplZ13p7zAWznPDWH3kIxzMNd9PhU6rEJTaWVXBWfMPo4PXwso9sfqHYeqN5+M2scMgeYjk/t6ycpJofZMS7YcSK4SEkp37pQcpaLhOlvKP42B0M2tZx9+DQ8lmo7IOZU8mQdbZekEzepnbTCtTtolevDxnX9QYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181676; c=relaxed/simple;
	bh=Xhf/4Yd1Hr7rW4SJ0uHt7uCkUueGdgHvynERbZbv924=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PkEiJVFrDFzacGgM114IYQ55S3tDCxcLV5bmT1TfQMyCXm58yszH19RtI4uVJGtSuKXejbvRUDAdh5Qj02ocKdbwqraXRo/u8koWqkKlIVSjMmMHYpHe4+3TcofcwK99KeLn+1ZShhySOCMHDG2LrFRMt5O5hhLaT5F+4b2ibC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dydzieEd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dydzieEd"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913d45a148so2015063f8f.3
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181672; x=1743786472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpYYYu//7ksnbdIvkahK7A2Pv8s2++Rw4BnYXpKHzY0=;
        b=dydzieEdUrs+ifwcx1YEsYEoEBSk1ojVV617UmlGFoZ3VNDbwiQECri7rdJ0yFpF/1
         DQAvOt3DCl5oIuBROckps7UvqssZG4+e7vPOPqzmuLQxaiHd+zugTBLrJGXoVBbXvMY5
         vw8tfG0lkSDTuE5NVszi9kTDG+nwmKerA8CPbO3q0RqcftJejEmo3w1XKcIco7pMAlBh
         6db6Cto1C4BwJsuCO2/FLQ7+o/g6rw88IiP+6gN7T0PzN0uTg4PdBrZE9wwB5PtQhjay
         Pdb4ktHOyk1Ik8G3WVKdLJGtwxPlGtr8AVaESJRWOQKGltQ2MjGZZO4EjtzFpwrBhP9G
         Bd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181672; x=1743786472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpYYYu//7ksnbdIvkahK7A2Pv8s2++Rw4BnYXpKHzY0=;
        b=YQuSEeu4v0ZuFNq/rih0DMJgcEU1GD9AzfCSrTOGxh0ukEqhRuHNT0LCJB7WVWgQJV
         pPOCdcLI1jVcBkB7TzXOHMe42zHIuaSM9WQtCLX+B9MOT4pioxPrVf7Yf7XHTeCU1dcP
         uZ7CdoB/lEj+vXYIVpfDu5+yb+SBeXytAYnakVroHZT7vEM1hAFzY+a3phGmgmyLYopV
         9pWt8UeZ9K/+6QX3Heb1zbPCZ60pj+o+hgpTcDD65JCy+InLoefQr7RKbVnEPB9CR8ep
         yCJoXDwwekBWJnd0XxKgAXOYr3ocU69aiggk8sUTz4pn2ZA+TEx7z/4DGV3kcwrCV8bV
         sXxg==
X-Gm-Message-State: AOJu0YzlJDPk4tPguXanoqBvV5Zl5mYMDO2tj2H7aoOp4y207Yeu+Ysj
	CbR8QhfV/M42dJ8mkuvIODlu85kdCkzIjAp1Y+3ytxer3RgdgNOX/3BvaQ==
X-Gm-Gg: ASbGncuXPkOuFD8Kr/LXhENizEdPdYNIU8s1y2EX+DeTC2171zqoFRihrjsppBoyqV/
	yt0ISmMLN4VLnxCS8Vfz232fv99H98j+SSa2b2hKdUfI9hK2PNspSaCt4nBlLbWG/6+GhqUSCAT
	KJXDacSbIrrdZl97mJGQEY+gH6Rv8PdWbiEsS4l0sbDhQeOsFBXWh2+dabVnQUkwoEK7xF+WeQf
	0YTBVyX5Z+urBh1WrM8dA6v9tLlGTpqv1WNN1DoTFhTK7grPZuH+8pGStMKiVw+M2yM3hfRL7uk
	vRHuTapg2swVuyIAEJr2sbHv0sQPEzFbvy7JgaqdcjkfVA==
X-Google-Smtp-Source: AGHT+IGcVE2SdYU2g0wx82CNrPQNiY/xJlmxZjcXv0s+UcHtN/wZWUQ3NFWyqOA/Ms5NOJlgBrMRyg==
X-Received: by 2002:a5d:6d0c:0:b0:390:f9f9:3e9c with SMTP id ffacd0b85a97d-39ad1749098mr7419179f8f.25.1743181672325;
        Fri, 28 Mar 2025 10:07:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e1b0sm3105891f8f.75.2025.03.28.10.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:07:51 -0700 (PDT)
Message-Id: <1092c32609f249839453052ca802cb10256cb48f.1743181669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Mar 2025 17:07:49 +0000
Subject: [PATCH 2/2] p9210: fix 'scalar clone' when running from a detached
 HEAD
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
Cc: Victoria Dye <vdye@github.com>,
    Neeraj Singh <neerajsi@microsoft.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In p9210-scalar-clone.sh, we test using 'scalar clone' to clone
$GIT_PERF_LARGE_REPO (copied locally as 'to-clone'), which defaults to
the git.git checkout we are running the test from.

When --branch is not specified (as in this test), 'scalar clone' tries
to get the default branch of the remote repository by parsing the output
of 'git ls-remote --symref $URL HEAD', as implemented in
scalar.c:remote_default_branch. When the git.git checkout we are running
the test from is in detached HEAD, this fails and we fall back to using
the name of the currently checked out branch in the newly initialized
repository, which in this case is the value returned earlier in
cmd_clone by repo_default_branch_name.

We then invoke 'git checkout -t origin/$branch', with $branch being the
name we got from remote_default_branch. This invocation fails if
'$branch' does not exist as a branch in the current git.git checkout.

Fix this by creating a local branch in 'to-clone' in the setup test
"enable server-side partial clone", making sure to use '-B' in case a
branch named 'test-branch' already exists.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/perf/p9210-scalar.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/p9210-scalar.sh b/t/perf/p9210-scalar.sh
index 265f7cd1fe2..56b075e906e 100755
--- a/t/perf/p9210-scalar.sh
+++ b/t/perf/p9210-scalar.sh
@@ -7,7 +7,8 @@ test_perf_large_repo "$TRASH_DIRECTORY/to-clone"
 
 test_expect_success 'enable server-side partial clone' '
 	git -C to-clone config uploadpack.allowFilter true &&
-	git -C to-clone config uploadpack.allowAnySHA1InWant true
+	git -C to-clone config uploadpack.allowAnySHA1InWant true &&
+	git -C to-clone checkout -B test-branch
 '
 
 test_perf 'scalar clone' '
-- 
gitgitgadget
