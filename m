Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB392F290A
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127225; cv=none; b=mwGXk8lvgUysskin2q0fScC9kkbVb85CZbZTkarA7cwn2UhRBoqtQQvLABDulMVGSDUSsIjxyRgF3CE1BvTO4d2ThezzlMNFnwskYflc3AQaebIQbk7OV0qUYQBgCI2/3wkpi4OVgB36tYv9s1+zIXsv2lWSb5TSS/kz1OKgLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127225; c=relaxed/simple;
	bh=1dZ4K/Aw7c6h1QmDMzteHYj/CAHcH5qsW0Mi7pqcidE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qVcTCZ4BGbYzWAUJaAAk+AAOcGnFwQBCW67EzXryaD0HtOXOKgKD01TppAmRi4fhpuV7cni+8Q03Pm5WkWJUSCZD71TlR15yAn2ppWkc/2brLTUqXCnPHKIOA+HNL2KtALIMJFnfRu+06Xrt3oNmNMN3LK4fxfsNTDJZdvnUzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQbDW8Fn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQbDW8Fn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0b2d21so1302605e9.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127222; x=1755732022; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xN2HojYWIPyFlbd+zVoKghpo7YgvgU88yQciuge504=;
        b=GQbDW8FnlzqyYGMhI9nMgEQB898m3Z3/RO1RObhakAuI40Id/+z3pcR4b9yH2dm28O
         frTVZPux4Vttw4Mpl85TubAilMpBPXIObh8jyS/uIC0+UToNqwx1lY+QkoI2ae2ixYYG
         8PozGMZvCB2Lta+6JW1S9etzV7MwC2AbqAu1nipLdQzeF+Eit6GI/lXcK+RXKW/0b4mh
         lp7zGt8/AgP5YxkuA25G+gGwMnpA+Nokj6uYRdnpys7PHLGfk3iU04nyXsmATTSLLZ/E
         /3GkoWWb3y9r87u4BB4TWKktm4CUSNfnG2iV/BjiEGcWuJUEPx2lQPkaF/hT0Pt1Yj/b
         iHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127222; x=1755732022;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xN2HojYWIPyFlbd+zVoKghpo7YgvgU88yQciuge504=;
        b=JPJAlyZi+WHcPZc/QDxJ8edp3kIsNnbgduXLOzCZgcx+J15SQLfMU9jU53u287bE0o
         oRGhEIzcK1GEStkOz4VBWbGKAOdWV1gVVxlTAnl2+43dnCGheoxsWGuhOUqQrPOqM0pH
         Ge2TREJphuoMFotuZMVly8ge5O2+ML1+RgLIEyQeInKf8jm5RtUC4/CG4QdNLYglAEvk
         oPublq1VQrsq2rLAnHKHjssLfDZ/JzqE3w07/Z/agiIC0ZK5RMKOPbP3eC2nMixkEXp/
         3gE+lGAn1ZUP402H+Wr9iCNNRA7tYBPVhi5XIdQqq9EP3sQCv7Kn7vJVahI7nVYJj6Dd
         zPvQ==
X-Gm-Message-State: AOJu0YzSa0pdlghZQSpnkLb0Ch1cxFkVrskFB4P70JkjJX0TkuI4R20r
	GQQ0ztidkOQYEfikzZNwz+fV3a5V2ABH6Xk2SJgRV0tLkmb8W6Hc5hCM+lJrcw==
X-Gm-Gg: ASbGncvaNcRn1/cx5T0ekPMA5yuTHMbhaR9LotWUx1EvdbIOTOV4syNKGnPmLxKfQuE
	LBqll1qnVzaXZW5RMoORT9XMOLuDdm8HLus0zCMRaCyVoKHlMGtOKae/3M2e0gx0yYiPdGH++ku
	OsO3Au9ycs7BIncmHIfGetHkXZ/XsW+4tZHzttgfhVdzO1tab/h/8G7TT3j3+XGSXJ/nKisG+ig
	NOqQqoSMtzkxhQ0/KkNsM9enE0xYtRooJ12ICplHvTq3H/5ngytnm2J8rRX/Vbx0G6ev0+DNEdU
	Q5Y4m4m/o9+gXoyBND1wmSCUGWLy6kXi0DE7eQtlTIc8XYrDFq2W5a/kAd11Mocr+LkIPG1dm9H
	FGUkAdNzPkI4GIHN38BjOI+YVuC+QHpHpZQ==
X-Google-Smtp-Source: AGHT+IHkePkscx0fr75ctYYci5UUHsMi42iOdyQJddur4NdK1N9X1qcd/NugrXeHOQt8YC6HSOkiPw==
X-Received: by 2002:a05:600c:45cd:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-45a1b644bc6mr3613085e9.21.1755127221687;
        Wed, 13 Aug 2025 16:20:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a517d2dsm18260655e9.9.2025.08.13.16.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:20:21 -0700 (PDT)
Message-Id: <63c9e0361dc02c15afeea3cad1656e1631637f60.1755127218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Aug 2025 23:20:16 +0000
Subject: [PATCH v2 2/4] doc: git-add: simplify discussion of ignored files
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

- Mention the --force option earlier
- Remove the explanation of shell globbing vs git's internal glob
  system, it's a common gotcha but I don't think this is an appropriate
  place to explain that concept. There's some discussion of the gotchas
  around globbing and `git add` in the EXAMPLES section which I think
  is clearer.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 949b016e6fa2..75e223f6b1ea 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -39,12 +39,11 @@ you must run `git add` again to add the new content to the index.
 The `git status` command can be used to obtain a summary of which
 files have changes that are staged for the next commit.
 
-The `git add` command will not add ignored files by default.  If any
-ignored files were explicitly specified on the command line, `git add`
-will fail with a list of ignored files.  Ignored files reached by
-directory recursion or filename globbing performed by Git (quote your
-globs before the shell) will be silently ignored.  The `git add` command can
-be used to add ignored files with the `-f` (force) option.
+`git add` will not add ignored files by default. You can use the
+`--force` option to add ignored files. If you explicitly specify the
+exact filename of an ignored file (e.g. `git add ignored.txt`), `git
+add` will fail with a list of ignored files. Otherwise it will silently
+ignore the file.
 
 OPTIONS
 -------
-- 
gitgitgadget

