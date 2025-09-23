Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8982FAC0B
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651058; cv=none; b=cpfNiJDy35UXNmU5jw4FIXCTi+0sZAEkR+Y9OcCAQuc/fP8dyATol93TtaXD7914QnLdWkRCVoFK8wdUAXN8I8k1g7ZtUbiDCQtEUphplNv7j3TEey+zxAMZUCjcehHwatFEOKgrUyHuh4yP3YXlQmUjPGxT0hO/H4CWNJrKYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651058; c=relaxed/simple;
	bh=tu5taQe2w1niwmuLhaNhfls85U7IPSgpce3OwvPt1NQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ui4Ipi87IWAz3jMuc9DELca5zIBxvswChPbNJVflm8/X0xfZ5kD/GGAmGipa1ETWhXi9OU/a0IWF5GNNqepFCpfSiFUao0X2HsqRA9CLhZMu7m+aWduD8q+Eh63TmTRaaVAyMfFHBfD08JhFotKcmvMSvREuSqCoxejMC495uqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOoahUcY; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOoahUcY"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-424d3c1256fso1080775ab.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758651055; x=1759255855; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcA5qBJAKjiNIUXoCjLNh8FVo29gog8HZMptqna4YIs=;
        b=EOoahUcYwnL3ht0eh4pBim7l984Ul4l4qfKsRicnnp6uUClbNuAyPzwdR2kvaqq2bi
         EXQHTqgUQVVBxL+FnU9a0Kp/WMCE/baZIJeb/ZudzRnyTOrI0MBh1Xpi2MqtU95flZSq
         xOqzARqG4Hj9MTDpEFgqp3BXiOKL/PjzVYt8DFrRUn9eFXjl6Jp+2yV6LW8bT3HHkh8M
         cnwSMal3PkMk0Ra9PiAKY8fsQuinnqwtQdXBe2QsNSVGJ/bXiJXIg5VvrHkUfnHkbwp+
         sqK+Mml+bQlpu+OM3DdiEiodcIpTckHD1kgSNwyI8Cidr9Oxy0NeNKelAUzqk4FKxjiE
         nfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758651055; x=1759255855;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcA5qBJAKjiNIUXoCjLNh8FVo29gog8HZMptqna4YIs=;
        b=eYxi9UqclvegG/KC8fZq5gK57IFWma4kY2An8LVM0jK4ERTLJJw7vsWgFvTZ6NkFI+
         kEDWzkR6Ujv9JizGO/gevXvWXgRVrojZj6oz3t3+49O0xZvJnqvEFwspmAD/936GOoh7
         BjEP6WS5losg7Bdks+CcwrBuD7beJIdgrYpNA0hscrw2SSDBtg5Ke+eUC4oNPafxb2iW
         H2sSiRk5+GKhJoijt73sX5tBFDSYJ3Tek7jZzPOcv0BdE5veTSFROnfOSsw2ygxDzXGJ
         l4CE76TV+jTH9XVl/Y6Yh/Z1eF3Uf7MTGysUB1mVzQoz2Irw9nH7USzuLbgqx6ob2RsB
         m6hQ==
X-Gm-Message-State: AOJu0YxtU/fzHdeJZrh0bIF9Msrg2ixbR8h+caNytmJR1AKVpNCPQAlO
	KBNPjX6IPbZpVafp9g8RHMeSp2OXXQ/YPeikcHiLB5QnXTboMdyFxCh1J/nFRg==
X-Gm-Gg: ASbGncsHoQ1KePtUsNia/WRrJAnXww91wLl5HMqjagyPmZat/X73X449q95uIXqzVJ3
	+Sl5yoSHRV+Vi6PTSvhGpUAMxhe/v7T5k/quCX6pzpWjY+w2exryqNEeFv2YQ/Tb9IQdGs5zHIE
	GdMGcwdlNEc0rVnp6qSrEwexy8N9DZoR8sgxez6dRurzpzqdLY7TgqC6LoHSE3X5VmoJEhhfRLx
	eSI+WIyX6I4o+iqVu4H5hdbR+0+utCKjVhVyc4JYospgH3kjV/n4qvScU2p/ExN/99pasTMzCPU
	4UI+UcKcZ3KCWzbiMdO0pNZgHAU5Yomm5E+LqVzvYcERCrppz+urUFW45sLkeCucWpa3/I+OMsx
	mOcI/dZHiDwbuU2/2LFxJRUw00Q==
X-Google-Smtp-Source: AGHT+IEkFkdlPwc9Pd2PYPhNs0hbNB2ga49NZkkhK7W+HHMb0tGP9KW8Zyv+aawBhwHsRcUQWYzdhg==
X-Received: by 2002:a05:6e02:1985:b0:424:7128:a06a with SMTP id e9e14a558f8ab-425822cb275mr49726315ab.7.1758651054557;
        Tue, 23 Sep 2025 11:10:54 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.121])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afae874sm73897765ab.24.2025.09.23.11.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:10:54 -0700 (PDT)
Message-Id: <8be0554d02e147ddf8a033e8bb7b30417bf4d501.1758651049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1973.v2.git.1758651049.gitgitgadget@gmail.com>
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
	<pull.1973.v2.git.1758651049.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 18:10:48 +0000
Subject: [PATCH v2 1/2] doc: git-push: create PUSH RULES section
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Right now the rules for when a `git push` is allowed are buried at the
bottom of the description of `<refspec>`. Put them in their own section
so that we can reference them from `--force` and give some context for
why they exist.

Having the "PUSH RULES" section also lets us be a little bit more
specific with the rule in `--force`: we can just focus on the rule
for pushing for a branch (which is likely the one that's most relevant)
and leave the details about what happens when you push to a tag or a ref
that isn't a branch to the later section.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 94 ++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index d1978650d6..4faf915f94 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -91,48 +91,6 @@ is ambiguous.
   configuration (see linkgit:git-config[1]) suggest what refs/
   namespace you may have wanted to push to.
 
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
-(or using `--force` command line option). The only exception to this
-is that no amount of forcing will make the `refs/heads/*` namespace
-accept a non-commit object. Hooks and configuration can also override
-or amend these rules, see e.g. `receive.denyNonFastForwards` in
-linkgit:git-config[1] and `pre-receive` and `update` in
-linkgit:githooks[5].
-+
 Pushing an empty <src> allows you to delete the <dst> ref from the
 remote repository. Deletions are always accepted without a leading `+`
 in the refspec (or `--force`), except when forbidden by configuration
@@ -145,6 +103,7 @@ the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
+Not all updates are allowed: see PUSH RULES below for the details.
 
 --all::
 --branches::
@@ -332,14 +291,12 @@ allowing a forced update.
 
 -f::
 --force::
-	Usually, the command refuses to update a remote ref that is
-	not an ancestor of the local ref used to overwrite it.
-	Also, when `--force-with-lease` option is used, the command refuses
-	to update a remote ref whose current value does not match
-	what is expected.
+	Usually, `git push` will refuse to update a branch that is not an
+	ancestor of the commit being pushed.
 +
-This flag disables these checks, and can cause the remote repository
-to lose commits; use it with care.
+This flag disables that check, the other safety checks in PUSH RULES
+below, and the checks in --force-with-lease. It can cause the remote
+repository to lose commits; use it with care.
 +
 Note that `--force` applies to all the refs that are pushed, hence
 using it with `push.default` set to `matching` or with multiple push
@@ -508,6 +465,45 @@ reason::
 	refs, no explanation is needed. For a failed ref, the reason for
 	failure is described.
 
+PUSH RULES
+----------
+
+As a safety feature, the `git push` command only allows certain kinds of
+updates to prevent you from accidentally losing data on the remote.
+
+Because branches and tags are intended to be used differently, the
+safety rules for pushing to a branch are different from the rules
+for pushing to a tag. In the following rules "update" means any
+modifications except deletions and creations. Deletions and creations
+are always allowed, except when forbidden by configuration or hooks.
+
+1. If the push destination is a **branch** (`refs/heads/*`): only
+   fast-forward updates are allowed, which means the destination must be
+   an ancestor of the source commit. The source must be a commit.
+2. If the push destination is a **tag** (`refs/tags/*`): all updates will
+   be rejected. The source can be any object.
+3. If the push destination is not a branch or tag:
+   * If the source is a tree or blob object, any updates will be rejected
+   * If the source is a tag or commit object, any fast-forward update
+     is allowed, even in cases where what's being fast-forwarded is not a
+     commit, but a tag object which happens to point to a new commit which
+     is a fast-forward of the commit the last tag (or commit) it's
+     replacing. Replacing a tag with an entirely different tag is also
+     allowed, if it points to the same commit, as well as pushing a peeled
+     tag, i.e. pushing the commit that existing tag object points to, or a
+     new tag object which an existing commit points to.
+
+You can override these rules by passing `--force` or by adding the
+optional leading `+` to a refspec. The only exceptions are that no
+amount of forcing will make a branch accept a non-commit object,
+and forcing won't make the remote repository accept a push that it's
+configured to deny.
+
+Hooks and configuration can also override or amend these rules,
+see e.g. `receive.denyNonFastForwards` and `receive.denyDeletes`
+in linkgit:git-config[1] and `pre-receive` and `update` in
+linkgit:githooks[5].
+
 NOTE ABOUT FAST-FORWARDS
 ------------------------
 
-- 
gitgitgadget

