Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306113728A1
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240831; cv=none; b=vCALM9+FkGbpCF3dtqQGlK5DHG3aNfclaKDCTQusn0en7I97sqVWAnFCWyqdNYQeOFw1IkIiIHsHuiF7U4YGdUIVm6JGpUxcQyO762PZ6oFfaVy/l005vrEmHQupUng7CDnaKR0tJJ5mHKqkCMWuvcIs/QZnDz/ljblPUPsdYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240831; c=relaxed/simple;
	bh=CAPZo2pI0f/RlEL1dxATyfbS4HXRNHHXeBT2bjKNDJk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HF4AMRvJWvgAbSMfPwrcnUgfKeP92qiObgsOVWHozUBgQxIdr+nVwK6p4aXiJOqn5lLp3sW0M+Rl2QvYolOIYKhblMcpZBDZ/krIqznhY7mTMC+RCa++cGsSwN0o5uJXS7ubBVgz0+4yu2kCnk/vIUpPkHSReTZfAQ4Q57L0d5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev9RMvH2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev9RMvH2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso2668578f8f.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756240827; x=1756845627; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGA5lMitDBMNwbXkvX+nt6/dRoTduU3Db3klDvh3FV4=;
        b=ev9RMvH2mjY+cKjLzc4SN4wUtHrqCbqoB3qTtPMNEPHWvDT29Wlhs1pdi/Rsm1v3N+
         eRt38Ymn0MzQxGkdfkEdatqvBZixYUABOfcORT19XqvijbUmbgqh+W0pcgn46QI7XYsJ
         inPa++mJlC0v6sODTsgeJfhBoHQgOhdkiu5P1kypboFHKWgA693wL4dxoXVixyxGSz/K
         M09Z9M3O6ArDZ/y6pDnOEU8AWWsSF0oyzXUZfRUZ0kkZdDyLLjT3D8kpefG+JgcVqFAz
         1NGPvayT8H6pJadVM7S8VpnSv2OgcG/9ZTWZ0VafDuxjIl6nyZFmRx3xHsF80i6NEDTa
         ZIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240827; x=1756845627;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGA5lMitDBMNwbXkvX+nt6/dRoTduU3Db3klDvh3FV4=;
        b=DnFbr0Oc/oDZ857uOhZZstpD+1oHYT1OpaeUQH4QF6rMQCMPtkBUIuMCsN2UaF102a
         gsJHN0J6iioKPBFvI2LE8IF+KF97dB+Ium6FzhbK82qUtQOmq1GukYPQ8OOK8GP1AMR5
         J5sMSDqEbcdjrbErmhd84KaVNMrFUjqS8BnRzaDlHqQLkATyi5CWzLjIXaUH9LWMaJ1M
         KpuT3/flQoVFNBbqkHpLXQGqibWgRe8U2nHA1nHlZrtVoXXv8NaFzrcuIMKHsARu6KVg
         sCnixQrE1EUl4mhfyyGeTqM80U32SdjZ3cY5HJxjkKiSBsE6yvpbwXvBamDsP8eEenwZ
         yciw==
X-Gm-Message-State: AOJu0YwxEEIFtJMr/NiL0Ln4WTyeMY+KJfgCgyvQPHavmJP8jDPz6y65
	N3CJhLVxtg8/NVhRNfcnLdicrs9dYkyMgHCV2/FrzrrQDNT32JPQ+lZ/rEmWdg==
X-Gm-Gg: ASbGncsKGHHv8HVBye1EUu73ZoPx66JZNIkbC2GFUKztXlFp1sLIpejJypJocBlZEKE
	3lB0mKGRPu9tCqHvYxiYKUKna8VPDwFdDG+sAwTIZONNVnywx7H4U0HIoxQvwAW+8UW6j92SYja
	0EVEtKEAg9ufZTj8O7M7zahu8+GDs/4YtHlPiP/Hmh0z0/qnPN6NihK7oiCnle6vPuo5v2cNLjb
	KNwdQqyceCE3Y2+88szFWGyb6SibO1exJmLyOgXjtI6CVFx/P4ytKpyh9jQouLIaS1ESYvlKdjI
	lTj1hSJMkyIgHJNM07xPYGTUykK0MG/sIeYXV8/5+KiAvW08IfqBns5jp9ovDbc6ub+Z5URWTKC
	I15HzTaW/H2F4F8pi8uESxYGlLgNtoDv/Y2WiLg==
X-Google-Smtp-Source: AGHT+IEmiLprToWFHVc5T6UVFIiloslJ2ElrU76MeiskLphEUzm82B9WrhdB/E9Nc5hLu7bsiaq3Ew==
X-Received: by 2002:a5d:5886:0:b0:3c0:7e02:67b8 with SMTP id ffacd0b85a97d-3c5dcefe359mr12021526f8f.60.1756240826771;
        Tue, 26 Aug 2025 13:40:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc18f762b1sm1819035f8f.65.2025.08.26.13.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:40:26 -0700 (PDT)
Message-Id: <72114133aafc94354c8b7f3c8ac65456421ce34b.1756240823.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 20:40:22 +0000
Subject: [PATCH 4/4] doc: git-push: rewrite refspec specification
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

- Originally it said that a refspec was `+<src>:<dst>`, but then later
  contradicted itself by saying that the `:<dst>` is optional.
  Mention that `:<dst>` is optional much earlier.
- Put the complex sets of rules about different refspec forms
  in lists instead of in long paragraphs of prose
- Add examples for the various types of refspecs
  (negative, deletion, pattern, etc)
- Previously `*` and `^` were not mentioned, mention them
- Explain what `+` does earlier
- Remove "might be added in the future" (it's a given that software
  might change in the future)

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 164 ++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 0232195515c9..78d433c60c51 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -57,77 +57,74 @@ OPTIONS[[OPTIONS]]
 
 <refspec>...::
 	Specify what destination ref to update with what source object.
-	The format of a <refspec> parameter is an optional plus
-	`+`, followed by the source object <src>, followed
-	by a colon `:`, followed by the destination ref <dst>.
-+
-The <src> is often the name of the branch you would want to push, but
-it can be any arbitrary "SHA-1 expression", such as `master~4` or
-`HEAD` (see linkgit:gitrevisions[7]).
-+
-The <dst> tells which ref on the remote side is updated with this
-push. Arbitrary expressions cannot be used here, an actual ref must
-be named.
-If `git push [<repository>]` without any `<refspec>` argument is set to
-update some ref at the destination with `<src>` with
-`remote.<repository>.push` configuration variable, `:<dst>` part can
-be omitted--such a push will update a ref that `<src>` normally updates
-without any `<refspec>` on the command line.  Otherwise, missing
-`:<dst>` means to update the same ref as the `<src>`.
-+
-If <dst> doesn't start with `refs/` (e.g. `refs/heads/master`) we will
-try to infer where in `refs/*` on the destination <repository> it
-belongs based on the type of <src> being pushed and whether <dst>
-is ambiguous.
 +
---
-* If <dst> unambiguously refers to a ref on the <repository> remote,
-  then push to that ref.
-
-* If <src> resolves to a ref starting with refs/heads/ or refs/tags/,
-  then prepend that to <dst>.
-
-* Other ambiguity resolutions might be added in the future, but for
-  now any other cases will error out with an error indicating what we
-  tried, and depending on the `advice.pushUnqualifiedRefname`
-  configuration (see linkgit:git-config[1]) suggest what refs/
-  namespace you may have wanted to push to.
-
---
-+
-The object referenced by <src> is used to update the <dst> reference
-on the remote side. Whether this is allowed depends on where in
-`refs/*` the <dst> reference lives as described in detail below, in
-those sections "update" means any modifications except deletes, which
-as noted after the next few sections are treated differently.
-+
-The `refs/heads/*` namespace will only accept commit objects, and
-updates only if they can be fast-forwarded.
-+
-The `refs/tags/*` namespace will accept any kind of object (as
-commits, trees and blobs can be tagged), and any updates to them will
-be rejected.
-+
-It's possible to push any type of object to any namespace outside of
-`refs/{tags,heads}/*`. In the case of tags and commits, these will be
-treated as if they were the commits inside `refs/heads/*` for the
-purposes of whether the update is allowed.
-+
-I.e. a fast-forward of commits and tags outside `refs/{tags,heads}/*`
-is allowed, even in cases where what's being fast-forwarded is not a
-commit, but a tag object which happens to point to a new commit which
-is a fast-forward of the commit the last tag (or commit) it's
-replacing. Replacing a tag with an entirely different tag is also
-allowed, if it points to the same commit, as well as pushing a peeled
-tag, i.e. pushing the commit that existing tag object points to, or a
-new tag object which an existing commit points to.
-+
-Tree and blob objects outside of `refs/{tags,heads}/*` will be treated
-the same way as if they were inside `refs/tags/*`, any update of them
-will be rejected.
-+
-All of the rules described above about what's not allowed as an update
-can be overridden by adding an the optional leading `+` to a refspec
+The format for a refspec is [+]<src>[:<dst>], for example `main`,
+`main:other`, or `HEAD^:refs/heads/main`.
++
+The `<src>` is often the name of the local branch to push, but it can be
+any arbitrary "SHA-1 expression" (see linkgit:gitrevisions[7]).
++
+The `<dst>` determines what to update on the remote side. It must be the
+name of a branch, tag, or other ref, not an arbitrary expression.
+`:<dst>` is optional.
++
+`+` is optional and does the same thing as `--force`.
++
+You can write a refspec using the fully expanded form (for
+example `main:refs/heads/main`) which specifies the exact source
+and destination, or with a shorter form (for example `main` or
+`main:other`). Here are the rules for how refspecs are expanded,
+as well as various other special refspec forms:
++
+ 1. `<src>` without a `:<dst>` means to update the same ref as the
+	`<src>`, unless the `remote.<repository>.push` configuration specifies a
+	different <dst>. For example, if `main` is a branch, then the refspec
+    `main` expands to `main:refs/heads/main`.
+ 2. If <dst> unambiguously refers to a ref on the <repository> remote,
+    then expand it to that ref. For example, if `v1.0` is a tag on the
+    remote, then `HEAD:v1.0` expands to `HEAD:refs/tags/v1.0`.
+ 3. If <src> resolves to a ref starting with refs/heads/ or refs/tags/,
+    then prepend that to <dst>. For example, if `main` is a branch, then
+    `main:other` expands to `main:refs/heads/other`
+ 4. The special refspec `:` (or `+:` to allow non-fast-forward updates)
+    directs Git to push "matching" branches: for every branch that exists on
+    the local side, the remote side is updated if a branch of the same name
+    already exists on the remote side.
+ 5. `tag <tag>` expands to `refs/tags/<tag>:refs/tags/<tag>`.
+ 6. <src> may contain a * to indicate a simple pattern match.
+    This works like a glob that matches any ref matching the pattern.
+    There must be only one * in both the <src> and <dst>.
+    It will map refs to the destination by replacing the * with the
+    contents matched from the source. For example, `refs/heads/*:refs/heads/*`
+    will push all branches.
+ 7. A refspec starting with ^ is a negative refspec.
+    This specifies refs to exclude. A ref will be considered to
+    match if it matches at least one positive refspec, and does not
+    match any negative refspec. Negative refspecs can be pattern refspecs.
+    They must only contain a <src>.
+    Fully spelled out hex object names are also not supported.
+    For example, `git push origin 'refs/heads/*' '^refs/heads/dev-*'`
+    will push all branches except for those starting with `dev-`
+ 8. If `<src>` is empty, it deletes the <dst> ref from the remote
+    repository. For example, `git push origin :dev` will
+    delete the `dev` branch.
+    Deletions are always accepted without a leading `+` in the
+    refspec (or `--force`), except when forbidden by configuration or hooks.
+    See `receive.denyDeletes` in linkgit:git-config[1] and `pre-receive` and
+    `update` in linkgit:githooks[5].
+ 9. If the refspec can't be expanded unambiguously, error
+    out with an error indicating what was
+    tried, and depending on the `advice.pushUnqualifiedRefname`
+    configuration (see linkgit:git-config[1]) suggest what refs/
+    namespace you may have wanted to push to.
+
++
+Not all updates are allowed: it depends on what kind of destination
+you're pushing to. In the following rules "update" means any
+modifications except deletes, which as noted above are treated differently.
++
+All of these rules
+can be overridden by adding the optional leading `+` to a refspec
 (or using `--force` command line option). The only exception to this
 is that no amount of forcing will make the `refs/heads/*` namespace
 accept a non-commit object. Hooks and configuration can also override
@@ -135,18 +132,21 @@ or amend these rules, see e.g. `receive.denyNonFastForwards` in
 linkgit:git-config[1] and `pre-receive` and `update` in
 linkgit:githooks[5].
 +
-Pushing an empty <src> allows you to delete the <dst> ref from the
-remote repository. Deletions are always accepted without a leading `+`
-in the refspec (or `--force`), except when forbidden by configuration
-or hooks. See `receive.denyDeletes` in linkgit:git-config[1] and
-`pre-receive` and `update` in linkgit:githooks[5].
-+
-The special refspec `:` (or `+:` to allow non-fast-forward updates)
-directs Git to push "matching" branches: for every branch that exists on
-the local side, the remote side is updated if a branch of the same name
-already exists on the remote side.
-+
-`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
+1. If the destination is a **branch** (`refs/heads/*`): the source must
+   be a commit object, and only fast-forward updates are allowed.
+2. If the destination is a **tag** (`refs/tags/*`):  the source can
+   be any object (as commits, trees and blobs can be tagged), and any
+   updates to them will be rejected.
+3. For destinations outside of `refs/{tags,heads}/*`:
+   * If the source is a tree or blob object, any updates will be rejected
+   * If the source is a tag or commit object, any fast-forward update
+     is allowed, even in cases where what's being fast-forwarded is not a
+     commit, but a tag object which happens to point to a new commit which
+     is a fast-forward of the commit the last tag (or commit) it's
+     replacing. Replacing a tag with an entirely different tag is also
+     allowed, if it points to the same commit, as well as pushing a peeled
+     tag, i.e. pushing the commit that existing tag object points to, or a
+     new tag object which an existing commit points to.
 
 --all::
 --branches::
-- 
gitgitgadget
