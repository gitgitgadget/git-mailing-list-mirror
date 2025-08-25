Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3472AE8D
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148939; cv=none; b=qoxWogpei25cGVBiOvYkrUj6Axu8ioeci6/EYjkxOPGWyew7j+AFlHW+QuXrQ8qDS6XEelfhuMCwozKnuBhdcYjndLXXb/Qxm9zAv0xYJ6wzBOWjFiyFqc7LyLuMjBqXtmF/PDPZeddVl38FIn0ixyQwmYhaaUn2afgyQzvdOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148939; c=relaxed/simple;
	bh=X+E5iK5Gy19req5A7dpXs+jtc6F5UkqUw2aRT+gg7s8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p7sdUaoUBofPrF6m+lWeq1L6X+fzqYZC0AJ7xXZFaQ92MwUpHje1i1zCGmabxYX7Tkxj/yG1GDypK12xgFzXPOBYhfDLGhgitpcCUI4BSNMJkzviBIhPj7QUcafZKQ06M2Pb/bAvo8wFYZbiWFX7W0r9ffvPa7UuoCeV376SkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5jGOggb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5jGOggb"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso40947905e9.3
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756148936; x=1756753736; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADpA7/sVycUvWdaDCbgScE3ziKsuv2qSidUp5i9wTxU=;
        b=L5jGOggbV5SMmP3rpy6K8fNytHSsR7sDbfodqDGFzukUr6i1hkR90+6eOLk8nEFyY7
         GqSK70LKs0+k6ZH/atYfxgQpM0nmej2TjzyKCAkUkbPnDEb7hFzPUfS3yn7Gy1FqtRy9
         5vBR2sN2J0R3u7szInspZ+oVKhvmaWWef1c9Zz5CTSN3zOa18BO7mUBabbP9COQUa5hH
         FHY/MvFZl9FfJ+O9Uxiz4Hkhw2cYA6s4pBvdQUXSmFgWW3lSQWPAObW3py/D2f/f74MS
         MYHb6KLDhk1VZg+ZZJB04feijzKd1jltVMQ5z5oiUT1p0dGwXAHAfCrXiqRW1ZY3gqqM
         DNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148936; x=1756753736;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADpA7/sVycUvWdaDCbgScE3ziKsuv2qSidUp5i9wTxU=;
        b=VsFbWILzcjGK9RIneYQHzgJAy89Qhm9sOucaIsDRJkQIZsnPdFE7fVn2O/hMzwVkof
         G4L7VaYl2Pcnla3DqEQ1g1C/AtS/0zO++zwjy8HteMXUJmedkgBX8qiB2gTJKn8iHsEz
         JCViXrB0gPJdLRCUWzJD9eo7jhpRTOxgsA6BRPiPJavO8DYZdVBETiqFwFlvcYdhHvCq
         2rWaEAhDRDULBxBE8sHBE1NxR+xKsEprZk2gLHgCKKVhoWoFce40bB5fnzlq5VROYmAt
         TosQwicNFd2cH0LEah4kVCGm9GNslmotBrcTzYZHDAzcGUiC1PT/R9/Z/grlVCZmwvQI
         YKzw==
X-Gm-Message-State: AOJu0YyjNdNfIYcNLR5i7xGnqddrjaCtol7+/ejJAkUkliytBCs4O/+N
	PYpe63sqdy5F/3vgGriWx2nUg2OBNSCkAollbIlIR8ZqOmGxTFA6hx8rgCKngQ==
X-Gm-Gg: ASbGncuzQWC32Px45+o+rho2HJe8lwTWbgGSHKPOIm2n3i0q0KTgiFhZkLN/YJwZBAK
	FT87Thb6eiyGNIBdMllfnFjaoJecetv3/1XVXoLdma7qdrBvQZrOBg7KMNL0nHhrxgJ3o16O0YW
	a0THe9U6/uOgAVv+sOqbS3jQFLuEj1NJkHwqtHylnUoghx4Snj0zGvyhb+9IbwPrNIGJTE58kMy
	EBx/ynRMHUTItx2dl35ktceaUdlilFoLT1S46rTLvA0aQ6f1iwf0apFAaomqxT9VGhmlscPgWj1
	fUrgGfljQwRkhwMNJAhPFSLZ6xAW+LgOQbdRFE1c5PH2VMBmvYhULRW3NUs4hSKi7MH1J2ISAZG
	z96gdC+zQ5jaAR62cAAzvtd/7KkY=
X-Google-Smtp-Source: AGHT+IHs6GR2fy9x8+R5u+mps3B/m2w8vTz0FNMtx2035m8wmNHGuYEoPFj2/njSrO4EBDBLXvUf8A==
X-Received: by 2002:a05:600c:4853:b0:458:bb0e:8cda with SMTP id 5b1f17b1804b1-45b5974de01mr61098135e9.17.1756148936019;
        Mon, 25 Aug 2025 12:08:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5f28da75sm59748665e9.24.2025.08.25.12.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:08:55 -0700 (PDT)
Message-Id: <b8873c4529caeddc85879efd122e5a57278352f0.1756148933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Aug 2025 19:08:50 +0000
Subject: [PATCH 2/5] doc: git-checkout: clarify `git checkout <branch>`
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

- "To prepare for working on _<branch>_..." is confusing to some users:
  it makes it sound like these are steps that the user has to do, not
  steps that Git itself will do. Reword it.
- Use "changes" instead of "modifications" (which Git normally does)
- Mention that `git checkout` will fail if there's a merge conflict
- The current explanation of `You could omit <branch>`... is confusing
  to users (what are the "expensive side effects"? what's a better way
  of getting the same info?). Be more direct and mention that `git
  status` is likely a better option.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index ddda891c0ff7..a3edb95973a2 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -30,11 +30,12 @@ See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
 Here's a description of all of the modes:
 
 `git checkout [<branch>]`::
-	To prepare for working on _<branch>_, switch to it by updating
-	the index and the files in the working tree, and by pointing
-	`HEAD` at the branch. Local modifications to the files in the
-	working tree are kept, so that they can be committed to the
-	_<branch>_.
+	Switch to _<branch>_. This will update the files in the working tree,
+	point `HEAD` at the branch, and update the index. Local changes to
+	the files in the working tree are kept, so that they can be committed
+	to the _<branch>_. If the local changes conflict with the changes on
+	_<branch>_, no changes will be made and the checkout operation will
+	fail.
 +
 If _<branch>_ is not found but there does exist a tracking branch in
 exactly one remote (call it _<remote>_) with a matching name and
@@ -44,10 +45,9 @@ exactly one remote (call it _<remote>_) with a matching name and
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
-You could omit _<branch>_, in which case the command degenerates to
-"check out the current branch", which is a glorified no-op with
-rather expensive side-effects to show only the tracking information,
-if it exists, for the current branch.
+Running `git checkout` without specifying a branch will output the
+tracking information, if it exists, for the current branch, but it's
+slower than getting the same information from `git status`.
 
 `git checkout (-b|-B) <new-branch> [<start-point>]`::
 
-- 
gitgitgadget

