Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EA149012
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774688; cv=none; b=cZX8Sq6HVaEIjG0GS4TV04UWPiPhu81V8Unnd8KAcHMjWyF5CBa46F4kKUnXMlTxfMU6J4ferf+Fv35rouDMFRNYYlUxOEYw0Ore8cAM5YIty0kf3CXfAkwW8r3vNl7tRQyc2VIcczFJklv0W2IDJiBTVifIlV90SdDjatkaWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774688; c=relaxed/simple;
	bh=DcOPy74AcWFND7KpVJzavQAsCJ8AmIsWjxksQb3raDM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=JYk7mEsLHLv9ENwNSTY0KMB+wZqCgtJpRCFamvnx4tGkoLDhsGewmpLMe7vLWHtWEnybphO5jRDjXsFdR0kkqfnD+HiCilvHPYxSWAkbXwZCMwjtWT4nfxcqdqaZ1+nbRFpxPwM9v2Jpsk/AxDxV1TMSMsnNrIMcluSMukmLQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgdYq326; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgdYq326"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-368440b073bso187682f8f.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721774684; x=1722379484; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ng4EBqyPWNw1TCj7uyWqCohuSZ87bfEfiW6ZOkDq0jw=;
        b=lgdYq326Y2eq672DuHSRLo8w52H7aiEAYCDqTZH7hRPem66jDHiPgJO8VlW+khOiAu
         fT+tPzaEFw7JvENPlzDCdHb5SP+1jCgwHyeVEdrLSBjrF4mdDSuaBsG4Ejpu7C184OgR
         r8C1l88o9v8ETBF7l+f4EJEkNYab/mWblN0vSPpVG4EwVUJvuIEQ/zR+4T637YSdTrCa
         Pz2X6p/iAUyz7Zo1Fvra+9l4Qve9ifheiO/1Bi2VewVY/YGg+o2CkZbUQfRrR8qay8J3
         4ceWtCC4Zp942+tegxwos2hQma92Xo4hWJteYfNzzh3VOCr5YQuV74XUtgnBn6ZaTfyQ
         mGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721774684; x=1722379484;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ng4EBqyPWNw1TCj7uyWqCohuSZ87bfEfiW6ZOkDq0jw=;
        b=HniqmwbpFrqiwR6d9L7A8pp3N15pqHd0ouA9O12zyD+DnX9FDFNxfWU84dBz0uPwTZ
         cYJCV861gp7/AJPStaot1GDpLVpJagwAouj3yODRUfZOp0qU0Alu+tOIH86Q7oyOYQVp
         As3csfZS6Wo72QU7oXIbfuYjFVFHkuzshTutPoV064KcBYshkuxxt4hnRERaABDT9SpO
         r6w00XLFbRZfvGKkVtAYrDK0Ys+QvY2yJ/HLBLuJ4Fb4DnFvLbnBTr8ZpC9ZgwZX7v5W
         chSxdlI02ISNloCHqeDVT4X7+fAG1kNFk5MGsvizXIF73JGdxhzc76rAWJ9bJhlVK2u9
         aTyg==
X-Gm-Message-State: AOJu0YwJLIQfTFAF46qtvGw+bAG3QS0HnEwQsJpj1LqPJTZsawOWdCM9
	L2xzXrh5thM/JQoME/NJ4sozCKLz+wzgGl8YT24LPlsmIwZ6NhdKAhTL7g==
X-Google-Smtp-Source: AGHT+IEcHn8ZJvsCooRAM2ALmPfQ8sB4REpRB9COJJuS11TS/rBl8xBMJVMN83sDFtIKNPdEEq7E3A==
X-Received: by 2002:adf:ee8c:0:b0:365:aec0:e191 with SMTP id ffacd0b85a97d-369f66f0961mr44214f8f.21.1721774684697;
        Tue, 23 Jul 2024 15:44:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93594e7sm3686985e9.8.2024.07.23.15.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 15:44:44 -0700 (PDT)
Message-Id: <3bcbe455747f19621f150b2f692194c7012b019e.1721774680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 22:44:40 +0000
Subject: [PATCH 3/3] doc: apply synopsis simplification on git-clone and
 git-init
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

With the new synopsis formatting backend, no special asciidoc markup
is needed.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-clone.txt | 20 ++++++++++----------
 Documentation/git-init.txt  | 12 ++++++------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 70a3f0331f83..53b1c3e23f75 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -8,16 +8,16 @@ git-clone - Clone a repository into a new directory
 
 SYNOPSIS
 --------
-[verse]
-`git clone` [++--template=++__<template-directory>__]
-	  [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`--mirror`]
-	  [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--reference` _<repository>_]
-	  [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
-	  [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-tags`]
-	  [++--recurse-submodules++[++=++__<pathspec>__]] [`--`[`no-`]`shallow-submodules`]
-	  [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--`[`no-`]`reject-shallow`]
-	  [++--filter=++__<filter-spec>__] [`--also-filter-submodules`]] [`--`] _<repository>_
-	  [__<directory>__]
+[synopsis]
+git clone [--template=<template-directory>]
+	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
+	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
+	  [--dissociate] [--separate-git-dir <git-dir>]
+	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
+	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
+	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
+	  [<directory>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 7cdc693e1c68..eba67fdde83f 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -8,12 +8,12 @@ git-init - Create an empty Git repository or reinitialize an existing one
 
 SYNOPSIS
 --------
-[verse]
-`git init` [`-q` | `--quiet`] [`--bare`] [++--template=++__<template-directory>__]
-	  [`--separate-git-dir` _<git-dir>_] [++--object-format=++__<format>__]
-	  [++--ref-format=++__<format>__]
-	  [`-b` _<branch-name>_ | ++--initial-branch=++__<branch-name>__]
-	  [`--shared`[++=++__<permissions>__]] [__<directory>__]
+[synopsis]
+git init [-q | --quiet] [--bare] [--template=<template-directory>]
+	 [--separate-git-dir <git-dir>] [--object-format=<format>]
+	 [--ref-format=<format>]
+	 [-b <branch-name> | --initial-branch=<branch-name>]
+	 [--shared[=<permissions>]] [<directory>]
 
 
 DESCRIPTION
-- 
gitgitgadget
