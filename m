Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F021CC5F
	for <git@vger.kernel.org>; Tue,  6 May 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574194; cv=none; b=sgG/4RQtIX2z6dDpd3S4AdJ7cga/yTMNbkYG4svIsA2BaOCJLPgy1VteiFzZFrXz/vybX1xMXUJWFKwZmxj4c5N6/v2vkrB031uMqTe/moRVxyzj8SVld5DCQcU6jv0qWUNgek9DrbrUl69oTTfQP2Kkl4u8XJolOg+JlSb/y1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574194; c=relaxed/simple;
	bh=PMb7vM8bFQYP4CDMhRmE+FW1UdTMjYSjc3PffLyGo+E=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=q0fu43KOZ8x1C/lrfeuiZpz4/flRsA37B/hOH4SXh7a0lnApVVXpERlR2SSlW/2vAQUsiK5VsqrrRjha9lodlWHCJkcb2Wh2Gdvm2m38k3qas+knGyEyln89HaVWCrRJqKzxKbZ3nlwKRhU13IEfLYkkfX+L9EX60S2x36kBkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANsLhaPb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANsLhaPb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441c99459e9so22845095e9.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746574190; x=1747178990; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O2a+goulv19V9Q+rny3M76bSvIXtkb1rXDjzo8Jt5DI=;
        b=ANsLhaPbNmbS7xmrQAXFvP9k8i11dBcadcVnWdtP6ilNJ0eiXZ0Qq5vgxM8qUPOlYD
         ppExYDFkBlRewRtmDxyYoieMLNzCccMHZaRh5yCSnmr7zBgkvp42dcjg5dOZ68Glt+ps
         756zkZayBftUVlwfJm7npOzVmKhlk4Q6pYM5M8c84s3p4HqT23egFECQMcKeidy+OgL7
         OVAqc4ztuBWRI1pPKvtZTyJuMfxGrJ/hRGoTBKmTFKncD9AMv888mZtx23OB2fMxMwCf
         owzmVTU2p/d+4AJac1e+n7KdxXWJB6MQUab/d8xTdxoqFtp91qes1sKFgPvIDLhvdU5i
         kj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746574190; x=1747178990;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2a+goulv19V9Q+rny3M76bSvIXtkb1rXDjzo8Jt5DI=;
        b=XVYYtW2B0uctwOHjW23GAMc5x4sQzuK4kNDfpYVcCPfgXTxj78Vc2YrH1jrEzCoq1j
         v1X5tMzCsrod3SZwhRyE/tWhKr+JUu9TIbmhUBA18g6VyGQopnLQS3rFpTEnA8iw2SGB
         /wyoGHpDSxJJ9SW+aowb0XI1VwbkgbdUMi24Ij4W80MG2zw1v8NkAEbBo9CWwvVRFzqu
         6j5c8f3qVQPeGzDP7i56K5Mvd+U68uf02LRb+AcVRhVZT5EcZvPrSif1DrJ6gYQh1bxy
         UMbXTSZIssBbk7iWmplvFjLkVd0qNWeOO60QPA/rKhV2eB0ItO/r/ItQy78KKKvxcS8L
         b/Sg==
X-Gm-Message-State: AOJu0YyPQk+LaOUyc/8rcPx7W84on9L4h9nJR1E3T/+lST1RKIVKU2j2
	DpZzrEWEP7Sb+fp21tbySzp4rBnXtIS9+rrLNsk29mqEm0XZqCjyT7vYQw==
X-Gm-Gg: ASbGnctiGfAIgnhU7z6coX+q8N/PVk/HniG1dmyjVOYYG8SA5kAodzzyH25aE4exFlf
	mzgCFX2FKtBTRBznc4A0nfn6kev2JP282Q61cqJr8iZQ8nL4EPuu7Jvaegg9uSrO8nNwCXoDNdU
	cYwn3GD1fDRaJodofB25knksX7PQAZvwapUdoTO8Vm/PB7fOWIxcEE98MbRuZc7n+eF+DdiXFsi
	KGcTKQnUXSTYM7GY2Agt5KxH1tO9rYNj3ijN3oQtuKhGdfd9JlKDbUMDb/HnIvPBzFnsuDPdFrh
	EX9anUc3TTPZRGxIa/LZ7eDQW63OQj7ZZlPAXZTI/Q==
X-Google-Smtp-Source: AGHT+IHKKnbfNORmecKacAitPkcd98pNN05GNKXinGzfVo2dEidXqnWiugnrsG22UUG1GAhF4Tkzhw==
X-Received: by 2002:a05:600c:6749:b0:43d:2313:7b49 with SMTP id 5b1f17b1804b1-441d44c4547mr6035305e9.12.1746574190182;
        Tue, 06 May 2025 16:29:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d43a7523sm9392735e9.33.2025.05.06.16.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 16:29:49 -0700 (PDT)
Message-Id: <pull.1917.git.1746574189008.gitgitgadget@gmail.com>
From: "Scott Guest via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 May 2025 23:29:48 +0000
Subject: [PATCH] git-p4: preserve executable bit in LFS pointers
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
Cc: Scott Guest <scottguest02@gmail.com>,
    Scott Guest <sguest@nvidia.com>

From: Scott Guest <sguest@nvidia.com>

git-p4.py currently marks all Git LFS pointers non-executable,
when it should instead match the executable bit of the stored file.

The LFS spec made this change nearly a decade ago, see
https://github.com/git-lfs/git-lfs/commit/8d075a8

Signed-off-by: Scott Guest <sguest@nvidia.com>
---
    git-p4: preserve executable bit in LFS pointers

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1917%2FScott-Guest%2Fp4-lfs-exec-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1917/Scott-Guest/p4-lfs-exec-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1917

 git-p4.py | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c0ca7becaf4..adfb5988492 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1463,7 +1463,7 @@ class LargeFileSystem(object):
         self.largeFiles = set()
         self.writeToGitStream = writeToGitStream
 
-    def generatePointer(self, cloneDestination, contentFile):
+    def generatePointer(self, contentFile):
         """Return the content of a pointer file that is stored in Git instead
            of the actual content.
            """
@@ -1517,20 +1517,14 @@ class LargeFileSystem(object):
     def isLargeFile(self, relPath):
         return relPath in self.largeFiles
 
-    def processContent(self, git_mode, relPath, contents):
+    def processContent(self, relPath, contents):
         """Processes the content of git fast import. This method decides if a
            file is stored in the large file system and handles all necessary
            steps.
            """
-        # symlinks aren't processed by smudge/clean filters
-        if git_mode == "120000":
-            return (git_mode, contents)
-
         if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
             contentTempFile = self.generateTempFile(contents)
-            pointer_git_mode, contents, localLargeFile = self.generatePointer(contentTempFile)
-            if pointer_git_mode:
-                git_mode = pointer_git_mode
+            contents, localLargeFile = self.generatePointer(contentTempFile)
             if localLargeFile:
                 # Move temp file to final location in large file system
                 largeFileDir = os.path.dirname(localLargeFile)
@@ -1542,7 +1536,7 @@ class LargeFileSystem(object):
                     self.pushFile(localLargeFile)
                 if verbose:
                     sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, localLargeFile))
-        return (git_mode, contents)
+        return contents
 
 
 class MockLFS(LargeFileSystem):
@@ -1555,10 +1549,9 @@ class MockLFS(LargeFileSystem):
            """
         with open(contentFile, 'r') as f:
             content = next(f)
-            gitMode = '100644'
             pointerContents = 'pointer-' + content
             localLargeFile = os.path.join(os.getcwd(), '.git', 'mock-storage', 'local', content[:-1])
-            return (gitMode, pointerContents, localLargeFile)
+            return (pointerContents, localLargeFile)
 
     def pushFile(self, localLargeFile):
         """The remote filename of the large file storage is the same as the
@@ -1586,7 +1579,7 @@ class GitLFS(LargeFileSystem):
            content.
            """
         if os.path.getsize(contentFile) == 0:
-            return (None, '', None)
+            return ('', None)
 
         pointerProcess = subprocess.Popen(
             ['git', 'lfs', 'pointer', '--file=' + contentFile],
@@ -1616,9 +1609,7 @@ class GitLFS(LargeFileSystem):
             'objects', oid[:2], oid[2:4],
             oid,
         )
-        # LFS Spec states that pointer files should not have the executable bit set.
-        gitMode = '100644'
-        return (gitMode, pointerFile, localLargeFile)
+        return (pointerFile, localLargeFile)
 
     def pushFile(self, localLargeFile):
         uploadProcess = subprocess.Popen(
@@ -1652,12 +1643,12 @@ class GitLFS(LargeFileSystem):
         LargeFileSystem.removeLargeFile(self, relPath)
         self.writeToGitStream('100644', '.gitattributes', self.generateGitAttributes())
 
-    def processContent(self, git_mode, relPath, contents):
+    def processContent(self, relPath, contents):
         if relPath == '.gitattributes':
             self.baseGitAttributes = contents
-            return (git_mode, self.generateGitAttributes())
+            return self.generateGitAttributes()
         else:
-            return LargeFileSystem.processContent(self, git_mode, relPath, contents)
+            return LargeFileSystem.processContent(self, relPath, contents)
 
 
 class Command:
@@ -3217,8 +3208,9 @@ class P4Sync(Command, P4UserMap):
         if regexp:
             contents = [regexp.sub(br'$\1$', c) for c in contents]
 
-        if self.largeFileSystem:
-            git_mode, contents = self.largeFileSystem.processContent(git_mode, relPath, contents)
+        # symlinks aren't processed by smudge/clean filters
+        if git_mode != '120000' and self.largeFileSystem:
+            contents = self.largeFileSystem.processContent(relPath, contents)
 
         self.writeToGitStream(git_mode, relPath, contents)
 

base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
-- 
gitgitgadget
