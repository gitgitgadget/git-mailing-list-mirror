Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A344191F6A
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164276; cv=none; b=NvIGGeirA+AN2YSXuAptrobMK6Z8RuzcsO9ZZssdFaf/V+mwORJVaBkhFTrMOtJC1V2pbxXt5Rk260Hdz4ShiwBiwmklq4cdi6G2XnKyUGCDbfjsgAKnX2yej8FV166w440DOPmkZxjnthboJrMoJbQHVBtKoIaT72wypoquiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164276; c=relaxed/simple;
	bh=nbs9Lz0NdlzvWqhFBmxy39Y/z636FTSfjSB1Ka30Zcc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Fud55JTS7dvtaIDzno1YtQkcS8rgNs9rny7drWI1XWazwZRE3twlisys6bfVpfOTwpg5L+iOq5rXYnixS95FUMpKtw/NnnA5m1rsOSjphix+BY+XAFXvA4psQ+yQ50wuTyoijpB69VobQkkQkJi+maL+4jYt0wOYKtK7MzJaJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Unc94IBV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unc94IBV"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so2229409a12.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724164273; x=1724769073; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBfoUEe5WjNfh8JYZAc9iyrh9amS4CWAFIuHQk9og8A=;
        b=Unc94IBVdmgX+KiQamwByaTt/Y/X9RhqZT/WE60i1pmFAQ3GjJzSjbFnG5HtlHxGQh
         7s8GAuqBQ6U4vVR/ep84kBXSbZApOuekOnbmvUnOO5Nh7YUyYCpEXuXW+5X3FzDgDFgT
         ydthH2QPYb5D+XZ+qgKCv9OFpcERmwedlj/gfxDGpGzazBCfkl1EoKUpGrHsKxyjkWH+
         0xK6PlRPyFG+RiFHIewXrEgekAiMI6fN9Rlh2dJl6OOsQ4oQho7uTOW3VWP3tlwXG1pe
         HMHs2nIsQjT6xiWRrXZPACy7+Lm3HN1ioq5WHc9AFh4uJ2etPSBUiWVjx0rFwtqe7ncx
         eg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164273; x=1724769073;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBfoUEe5WjNfh8JYZAc9iyrh9amS4CWAFIuHQk9og8A=;
        b=J/7qPT7sCNvRneAXeRjsI20vtV8kmlNzxJF8fpuwOCe8RgE+LH6NpmKSclGAA7Prun
         SzVUP25VQVcliBov8/10Py0bBO9OJUPJJitCK/By0Yg9zCJWAon7m6JM4wA3Ex9vnPb3
         aC7J0XepzKOfcq6wtVe9NyW/qY4znq0mwd6RBJ967JeTpH5dG1rw67lQKhakZ0g7Jmbw
         9Kjp3Ve3aTyHVi+8/+8ynzmt8osJyWJNe0SvFAjWE+zanAhIt0/e+Yj5GomtOItF7du6
         w014agSaKc2RKaadMe/CBllfsm9q/zVKhvZRFiDs/BVcoZgOEkXrbt16NbKaIPIqKXvM
         UGNA==
X-Gm-Message-State: AOJu0Yw3IlA1uEKWpqB8sejEXMgq6X0PZW8TPxe78VLCi3ukmqKLAkjF
	3r040y6G7saAV4xQ3UV+LF3dH+88dyt/lyY5nDZw2SbzFAgGdnokH1R9hA==
X-Google-Smtp-Source: AGHT+IGThS0pqYISe5lY2ydRNda0h+Vlnr2JxM0pzxjWaAE4jCSYpr3S3OG+80YcV8kgMFSvm+P4Wg==
X-Received: by 2002:a05:6402:5246:b0:5b9:fe2f:48e4 with SMTP id 4fb4d7f45d1cf-5bf0ac28229mr3335771a12.6.1724164273056;
        Tue, 20 Aug 2024 07:31:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe80024sm6876793a12.77.2024.08.20.07.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:31:11 -0700 (PDT)
Message-Id: <51eeafc713ca5a83499ceca3602e77c15dbfcab9.1724164270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1775.git.1724164270.gitgitgadget@gmail.com>
References: <pull.1775.git.1724164270.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 14:31:09 +0000
Subject: [PATCH 1/2] ci: bump microsoft/setup-msbuild from v1 to v2
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
    Johannes Schindelin <Johannes.Schindelin@gmx.de>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

The main benefit: The new version uses a node.js version that is not yet
deprecated.

Links:
- [Release notes](https://github.com/microsoft/setup-msbuild/releases)
- [Changelog](https://github.com/microsoft/setup-msbuild/blob/main/building-release.md)
- [Commits](https://github.com/microsoft/setup-msbuild/compare/v1...v2)

This patch was originally by GitHub's Dependabot, but I cannot attribute
that bot properly because it has no dedicated email address. Probably
because it hasn't reached legal age yet, or something.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 13cc0fe8077..85e5767aae6 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -190,7 +190,7 @@ jobs:
         Expand-Archive compat.zip -DestinationPath . -Force
         Remove-Item compat.zip
     - name: add msbuild to PATH
-      uses: microsoft/setup-msbuild@v1
+      uses: microsoft/setup-msbuild@v2
     - name: copy dlls to root
       shell: cmd
       run: compat\vcbuild\vcpkg_copy_dlls.bat release
-- 
gitgitgadget

