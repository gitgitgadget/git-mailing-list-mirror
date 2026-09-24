Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7C4BE446
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280131; cv=none; b=mcIZDjoSRC6j3RwV+omihQuXIBQgwyO8CSwBSSFw1g53YZ36iIb4+PXwf0ISLp6hPzsnOFKBs9pzmUBrgmjsOFqEbZ1hbEgQUlseVDhgHGlOdXhCfMc+nME84uB+7PES9CTXrSatqdhTB2pYDaV5v0SN5kDJkx2hzFg8Lcxk5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280131; c=relaxed/simple;
	bh=9K1nw8dOZwGPVOJ7df7rXGGCioFK7bLSljvJ68BzytE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J95Gr2pjCeWGZcbi6td1blOLAZT4TPnJNpU9qobZuQFvM7R1Fetrw8GWilkmmtR/I8zgCbCp1OP7rB0bMeE19alK4N44Was2GkQv9crMlFOVof0+LLI5veqJP/GeyryOT3KO46+aD/qLSWJE9g6TTVXcbe/46ZAs6D42Frh3OaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNJhygbQ; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNJhygbQ"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso137678eec.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790280126; x=1790884926; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rKW3mHHgXJ0fAdo4d05vWExFQBsFToGqnbNEzd+PffQ=;
        b=LNJhygbQvgbrUN88nxMkj7oRwREFk6XGF8Rud4Xs2VKYWGi/odpiPK/qoAyf/2RRGD
         TbF37xNPxOudIJ4PmJTselIh1ILFi8HKL0H+agK6uM+fve+CChcJKxMd4IfcVZzOB2fv
         r61rMqFSd4ULmNhT1NuJwNu+wFvhOEk2OjeZJrH+qyIfsg/AVagWBKL/lesE0Ur9jZDc
         c1DWjehy6Cs2s4IQYEbTfRN1hYlIrEv8Jv6VAYQ0MBayODYhAHaukN23iCB98h/mnfSV
         A59OFQXgo4RJVe0pj5WA/DdHKLQmqvisNvGOoYq1/bLA19RNvqtduAFJ8GTit9mcPOgu
         2vwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280126; x=1790884926;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKW3mHHgXJ0fAdo4d05vWExFQBsFToGqnbNEzd+PffQ=;
        b=y4SwZGmYQHlEwOEmLAJHXHNcTt8YjjEMDoQ87tdyfl3JqNWSmmJTqlOdezCicFJEdQ
         F0nYoADVVSk46ynkKRFsgs2p4HUXb4XG7ZTMwdJf4dRgepTVQwShKX9FkhLaTDfSCBrC
         nArVywR+kk0m7g3hIUo21CbMvSXAR7bgly56NJ7sVkshfqWmYNwJ9jfCosvBLK8khxKo
         4alocKa3zsktBliGeV4lCtzznX4uoEpiCe6TAGCKyFFFTgM3zEWJ6bMUdoT7O+SycY5a
         h3z8XKk/+TT60e/W2fjbmP5XymGyaVw5WQNw4j8+bd9D4M4NcX8ywFPGxhObnfDwij3u
         FL8w==
X-Gm-Message-State: AFuF++k55LRfqy6yPFd+A2dKnQB0yIEl9hDJOvV/E/nP56pi8ei86HBV
	9gKZcBmHnBlx2dtd/+cGRdKi9fLMnIVoI0rYaQYgAy3ZCxXOJ32JXv00u5QdEZca
X-Gm-Gg: AYBFou1RV1+JBvMH0+jeNHudhYClnhEtlb4ku6X20lD+vah1DV+7dDabe6zOH+eYn0Z
	OaovXV7spd6jy8szgvK81XZcy0q+VS0T2YhpOwykb1GTpSP+l4MwXfRneVB9x36vJETB1f8j5EU
	GMbJgBDvpSiY22XkCac0Bzfh76jtlKYUP26m4zcnfyhTomar/6QDCVj1EriQ/9HYIvs8SW8/oHA
	MFwKi+5qdPcB8mLwq5kiYApEQqZqIbWQ4keB8QmNqm4LoZEo0Yi4fdmjt7ebSTCaNKjGKXZQfn3
	2ReKBtUzs6bUj+Cbu38tSITYGdmMVN7HEloVpR4NuSF9pJNtXAtSQh727jGEoN2Y7hnqUxOEpZL
	wq8uNSiXVY5xaZtFBq3pIscBOiI7GTQuqlgkFcp4zyaGLxJ7yBtP3wu5J3xBaWpLRW4ijeZuCAG
	zJ0Zsk7i8OUbdQVAKS/CSej/LSqkjw0l4n/1Dil+mxB6ZO+SDV53IuK3X9FZnKAto2lDA8zqSAF
	s0=
X-Received: by 2002:a05:7301:df47:b0:339:7675:18e with SMTP id 5a478bee46e88-3400161f87amr2942164eec.9.1790280124721;
        Thu, 24 Sep 2026 13:02:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414504fae2sm815978eec.20.2026.09.24.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:02:04 -0700 (PDT)
Message-Id: <5310afcdf9d8ae461532cff439ec056f91053ef0.1790280113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
	<pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 20:01:53 +0000
Subject: [PATCH v2 4/4] ci(gitlab,windows): provide GNU Rust's host-linker
 support
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

GitLab's MinGW job cannot find `x86_64-w64-mingw32-gcc` when linking
gitcore's build script:
https://gitlab.com/dscho/git1/-/jobs/16593470275

Although gitcore is a static library, Cargo first links `build.rs`
as a host executable. We omitted the Rust MSI's `Gcc` feature, which
supplies the required linker and platform libraries:
https://github.com/rust-lang/rust/blob/1.96.0/src/etc/installer/msi/rust.wxs

Assisted-by: GPT-6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.ps1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
index f6868dc670..9b833b9370 100755
--- a/ci/install-dependencies.ps1
+++ b/ci/install-dependencies.ps1
@@ -49,7 +49,7 @@ $rustMsi = Get-Installer "rust-$rustTarget.msi" (
     "https://static.rust-lang.org/dist/" +
     "rust-$RustVersion-x86_64-pc-windows-$rustTarget.msi")
 Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust',
-    'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')
+    "ADDLOCAL=Rustc,Cargo,Std$(if ($Mingw) { ',Gcc' })", '/quiet', '/norestart')
 
 if ($Mingw) {
     return
-- 
gitgitgadget
