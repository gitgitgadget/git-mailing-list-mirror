Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B39DDD2
	for <git@vger.kernel.org>; Wed, 21 May 2025 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747854315; cv=none; b=PeacIUf0Wu/6Ehxi9ex+yOQYpRgIS9v6LM4NqQYtVOI2hsuGAXdvvw9AxIp0bsqeQWUSh/FjvYrsJiMbgLn++GZPHt3AK6jAB91N61r35rZ3DNi2OP0qYUIVxuN5OE/H5GDlsnNi5apLIihFcDMHlo4l6nGCvNA1nr4ZdV6DZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747854315; c=relaxed/simple;
	bh=3TYEI/xO8hfOZyoNEiTtfKjgaCpuTOTvQWrULHRKKuk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=eCw3zaUIZXjEw2sFVS3NGzKnxO+WCvWXw5PYgXnUq3OYwlDj3xsz4MpbbrwhoJsQLsxaK831YKlx4Cg1f9B2GXdLtDECyAf6vYJmBVlmLajApEUA5tYRWOKUIFnCsOj4UYcN8LRG1J3LZc3fWLyPKA14QvyyO6PXFpPtgAqQ1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK4D69sq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK4D69sq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-441c99459e9so47176915e9.3
        for <git@vger.kernel.org>; Wed, 21 May 2025 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747854312; x=1748459112; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hifqgyEYyTrf9aPY8dfNGHmJAZkscotv+RNYnxiZn5k=;
        b=dK4D69sqgV9bjtzU/9umaMWYG0hhJcxKCdrOsvPyocT0F1h+BP+C4O7QJs3cqSTBtM
         sCgj3Q8bZ17qC4KPuiL0R0IgPzT1jURFHmp+8XUVl+KnkjGuc2fNnjxNxUes3KPGGvjA
         PEHoQeJ7o3X/HIThl7DLYNgxUaHUocKp2EmtR096RlgvoVCCTfm+EYOqHsc1n1CyWPow
         xRttaCXqM9vrVmckF+cr4FHOcRmZIWL+/Xizncz4JMRFyMBoq8pfss7tnch6lDqJLbCC
         94f2KNte3aWyUJWH7rjHOgxKaGxVlxV7kZuCzgzL55ZYazRHhteLEnMRgtoiJjXmBEIS
         GtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747854312; x=1748459112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hifqgyEYyTrf9aPY8dfNGHmJAZkscotv+RNYnxiZn5k=;
        b=N4AHawppA9XHSBJ4sSLnDZVBO/E6C2SMMoXgoal2HgE+/5FA4ePQeqd3EuxRRc4ggZ
         OUPXQ1Tpg/RQc+TzJhyrf0O+FFdJ+BHGnD30GmOGRBiHyKGeiIaR6w1kUHThMPScHM8O
         L+X5LIzGqqiucoGaNglMyggQOfHkZ6NevobbvFuiCRmvbgFj5F2k8pxEzegqudgYrbPg
         NMVg/sTO3SkQFRAKn2Fetlzy0hlH6NTgxbWtZubXwO/0LUfNk55kEAK/1b+SsMKGbz3/
         dTK519+vDgwV5WV7E/EyAUw+CnDbfOlGS1R/ySnujJE1iv15PnFW3Cd2ZmqkHeOwrS/n
         V2/Q==
X-Gm-Message-State: AOJu0Yxrkydg/Ludlt85uNKdx9GOeB9lECsIfGNK3zbSyxs/oNFiN9kB
	V9EFWRw8+/J33fIWUzV5BMYEeszsDpuBBHSwMxaPMqkOhjeXpw8L5BVUm8UxXw==
X-Gm-Gg: ASbGncvCo8aNwcirErlYdUCMrCBIRC0NL7EU8nXYD1SS5CMtna9q40BgsHvorfTQ6c3
	GteSgHFylmpLCMo2NimZc833qFnUtVeJV67h5+foikbSoxRRNNmuRbda8xEzdk4VouC6Yl+deGp
	SrVCnIqn52Acd37oqkHspjknA2xIaTpTv07Pk5JFwJ1+52ShH4R3YnvOVtpPvi+noyq8JWDw2Pf
	X4N283U9L3FmFNXFps4Clg4uHM3MdO/OhxAwcPf6vbNCZf1g7oBDO8P9IXG0vJ+vvRJgqhFF9Ml
	iDHAZP5Uk/+1wq5Creu55FMq3F7BgHHEMcpVkL2VRJZZi8z3iwlE
X-Google-Smtp-Source: AGHT+IG8Idw3CjzFUqaRTob+Jof+cpkDYRE52jaZc6kgNVX3rFoGpwKn2VKPDLW5oiO36fpPOkbg5Q==
X-Received: by 2002:a05:600c:a369:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-442fd678b83mr248749035e9.30.1747854311704;
        Wed, 21 May 2025 12:05:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebdc362fsm216705905e9.1.2025.05.21.12.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 12:05:11 -0700 (PDT)
Message-Id: <pull.1971.git.git.1747854310479.gitgitgadget@gmail.com>
From: "Jouke Witteveen via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 19:05:10 +0000
Subject: [PATCH] doc: update references to renamed AsciiDoc files
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
Cc: Jouke Witteveen <j.witteveen@gmail.com>,
    Jouke Witteveen <j.witteveen@gmail.com>

From: Jouke Witteveen <j.witteveen@gmail.com>

The .txt extensions were changed to .adoc in 1f010d6 (doc: use .adoc
extension for AsciiDoc files, 2025-01-20). References to the renamed
files were not updated yet.

Signed-off-by: Jouke Witteveen <j.witteveen@gmail.com>
---
    doc: update references to renamed AsciiDoc files

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1971%2Fjoukewitteveen%2Frenamed-files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1971/joukewitteveen/renamed-files-v1
Pull-Request: https://github.com/git/git/pull/1971

 Documentation/gitprotocol-v2.adoc          | 4 ++--
 Documentation/technical/build-systems.adoc | 2 +-
 contrib/subtree/README                     | 2 +-
 mergetools/vimdiff                         | 4 ++--
 sub-process.h                              | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 5598c93e67c3..abc42efcc774 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -54,7 +54,7 @@ In general a client can request to speak protocol v2 by sending
 `version=2` through the respective side-channel for the transport being
 used which inevitably sets `GIT_PROTOCOL`.  More information can be
 found in linkgit:gitprotocol-pack[5] and linkgit:gitprotocol-http[5], as well as the
-`GIT_PROTOCOL` definition in `git.txt`. In all cases the
+`GIT_PROTOCOL` definition in `git.adoc`. In all cases the
 response from the server is the capability advertisement.
 
 Git Transport
@@ -99,7 +99,7 @@ Uses the `--http-backend-info-refs` option to
 linkgit:git-upload-pack[1].
 
 The server may need to be configured to pass this header's contents via
-the `GIT_PROTOCOL` variable. See the discussion in `git-http-backend.txt`.
+the `GIT_PROTOCOL` variable. See the discussion in `git-http-backend.adoc`.
 
 Capability Advertisement
 ------------------------
diff --git a/Documentation/technical/build-systems.adoc b/Documentation/technical/build-systems.adoc
index d9dafb407c40..1ae2a5292f3b 100644
--- a/Documentation/technical/build-systems.adoc
+++ b/Documentation/technical/build-systems.adoc
@@ -32,7 +32,7 @@ that generally have somebody running test pipelines against regularly:
   - OpenBSD
 
 The platforms which must be supported by the tool should be aligned with our
-[platform support policy](platform-support.txt).
+xref:platform-support.adoc[platform support policy].
 
 === Auto-detection of supported features
 
diff --git a/contrib/subtree/README b/contrib/subtree/README
index c686b4a69b12..65d167b678c8 100644
--- a/contrib/subtree/README
+++ b/contrib/subtree/README
@@ -1,5 +1,5 @@
 
-Please read git-subtree.txt for documentation.
+Please read git-subtree.adoc for documentation.
 
 Please don't contact me using github mail; it's slow, ugly, and worst of
 all, redundant. Email me instead at apenwarr@gmail.com and I'll be happy to
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index ffc9be86c83d..8fca3a2a2fda 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -274,8 +274,8 @@ gen_cmd () {
 	# definition.
 	#
 	# The syntax of the "layout definitions" is explained in "Documentation/
-	# mergetools/vimdiff.txt" but you can already intuitively understand how
-	# it works by knowing that...
+	# mergetools/vimdiff.adoc" but you can already intuitively understand
+	# how it works by knowing that...
 	#
 	#   * "+" means "a new vim tab"
 	#   * "/" means "a new vim horizontal split"
diff --git a/sub-process.h b/sub-process.h
index 6a61638a8ace..bfc3959a1b48 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -73,7 +73,7 @@ static inline struct child_process *subprocess_get_child_process(
 
 /*
  * Perform the version and capability negotiation as described in the
- * "Handshake" section of long-running-process-protocol.txt using the
+ * "Handshake" section of long-running-process-protocol.adoc using the
  * given requested versions and capabilities. The "versions" and "capabilities"
  * parameters are arrays terminated by a 0 or blank struct.
  *

base-commit: d50a5e8939abfc07c2ff97ae72e9330939b36ee0
-- 
gitgitgadget
