Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F439658D
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855832; cv=pass; b=QH7OXsgah6lv3YwEfyMmWWX2GvX1XSk+xXcVq46ETO342Eg+uYCCdSN7pDGwusWLt6PSN9oICxX8ox9j/9+77ym8H4PRvGAvSAh+h9vGgB7v9ECT/UhKZkOTvbste6DbtIbetCX3wW2GaFB/9Jh3baf8Fw17+VTbZc0zeKT4Tu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855832; c=relaxed/simple;
	bh=PvH4hpkmnepACov8A+ll8PBfxuL0hXe7IRHgafr3l48=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oJOgeM+Dbn93Eo70MXQDOQh/FJytVgR39XL38dKkyGXUC+FQMDeEUQfkljNf9JWy9eM4pqdGp6AmA/nPf4YgrpCmEPPaNltbIYOt1bpUw2u+0Sy0Nzq7nU2iC2iwrla1yWmtIYNG6p+0Hqgv66z7Zg/M0NgwtKLM/C939siD8qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=databricks.com; spf=pass smtp.mailfrom=databricks.com; dkim=pass (2048-bit key) header.d=databricks.com header.i=@databricks.com header.b=Aanagt8T; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=databricks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=databricks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=databricks.com header.i=@databricks.com header.b="Aanagt8T"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b28d7c729fso2761784b6e.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 01:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788855829; cv=none;
        d=google.com; s=arc-20260327;
        b=kYY41lRz8FtkAt8BfFLM6Acrb9d2BG0EqrSYqIQxHHrvuwew+UjoZf8cS2vIzh+/Yz
         gN+P7zYjYCweIKCvVh5p+PRBHrQ1m04J++Gcqp8eXhrO/40TUO+FmoB1uMd12uEi9Rrl
         DYnYx+hSlqZab5Pe+Tkh6lifDMmrLCJSlOR8B0QpmfqsJFJbkII4VqVdxshTaBzv3IlO
         87IJX57/SID5r3icZhkX9CNqHaQkN8QeEOw8cPl7brjCs3bD0znDfVc1X/efnH8IVlbo
         j3vE08Rzv6mj+z+mauJJlW2NaCXcjU8NCd6HR5V41P/aJVt+2PeXBvDouk3m+Z2Oj8DB
         oU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nX0ltAdLfEU9pZlc8wUFOC6C8QsxRzozae9GjMkNC2c=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=K7Qd4m9QS9LGsZs2ZwkBKH1yqKr4y2cjopqDYeTA2jc+GI+BROgXnfaMN8LYvZpLIm
         MDbKBIYjbtDhVqrai3bBpapRyCVZo4w3KdbOS9DpwZmxbocg4hedgcb8I3q1++pJAE/f
         071cy/QwappieyToOHX20rMh4zyDxhXR7LfRCNH7cfM7e4O1v0ms8NgdlDcF1sHIfddX
         GgaCOp3/HVAhXhJ6enbTBFSUa653G7IDtMfV0E1LTVHJgxCygMosaaPno/VH5OTKLSrH
         W8uOrecskGMN5lX9uTdllMvkTBEfPPOjGx1K58hQTQDTA1aRb+1DATkSDrZpK37g/Hy7
         bdRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=databricks.com; s=google; t=1788855829; x=1789460629; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nX0ltAdLfEU9pZlc8wUFOC6C8QsxRzozae9GjMkNC2c=;
        b=Aanagt8Th/4o0JgSmov9DqR9jY8JWUBprFEbnGGKbZ7ZDsprvsL7eoNTTWZHOgxqaM
         G3k6FMCSVzMnElZDd4WYTsuX0aeiseFNIz0p7I+T+r0kSdeocDm+XIWUKAx7KIJ9qzXQ
         XPZCEgKaCmyj37rnFv83a/0eByPR3liXbATVSAl94/jMx+OG6wkh3B81UIfVLU4iNLdQ
         RTbxrQsKjA1SHH6PmHdFi6ej1Kt6xoRMvJpxmstzbaW73QqHVnu8p3LeTwDbPEyTne0u
         8GmqC8SiM/i05kGN6wwlpn+/K/DjHi+QUNWjjQ2VogSssD4u2xmDphEpa651LZo7w6p6
         5lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788855829; x=1789460629;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nX0ltAdLfEU9pZlc8wUFOC6C8QsxRzozae9GjMkNC2c=;
        b=dMdnkrBa0AqnMjil95JNwUBlRV4S6JftUiK5Zog30nQHDsZhJViIEG9kQlFeZ9m9/o
         rljMuArp2cr1P86I4iVNPVG/8pvZd2ycJ6Gnhm3sLGthE+qSZIWSOXJJe+Iyt1YqaVg6
         Q2t6azB5j96jQq7+Cqek5Zqgh7V7zlKqidIsLAXYMOWfeb9zV2hyYCl5CeJpKJE08nfS
         TNI5SbwnxUeQ7SBVul7073/AZ7jL6wYNkobB/f5PYsccIiI3xUpTDTxoUvymCHEPly4M
         JC8pfufbuaKepavw5YuWZ0mE42X7hUtMXkhOkgBwKNco3zDOxYPTg1nEPSRMxxydtrmR
         3gBg==
X-Gm-Message-State: AFuF++ldN4At6XsDSEtMYICa1n35HZMB/KG00/U2Zp+BZy4xn+aYCiB0
	wnKjZML843jFuhYhwvsBivmYzSZZKNoFKzwcREZvEbPJuSLdOgnxxcvVC5lPDXAhylVU5umHU4B
	39NZVawi5SvTMyOqh+Wgj88BPSLN9+NXNVd4t0Niq5DMK68oX32pd/iRJaA==
X-Gm-Gg: AYBFou36SmsbJdPkBy1+0C5C3kyCZaRRBjq1PcFKZROfJzTws7zsKFEe46jMwgom16o
	P84D+LuB/Ot1cfrd1jISyGQ3uP841Fs0TpzryKtqe+rdUUviO4G1WuwmZZXvlecYIRPgr3XIlqs
	Ct2H454KF3LzZe+MxBpUhCS0lFZptWZqmuev500U3wvou/AlmhMWxzyMUP9GBtRpFYlnYd6ZKI0
	r5Vdro6r2H3RrCjBXkMd4osuQ9hXsGCnAYHtUz0Ym/8VnYsrao+VBDrnmk6eRARQBPKXL7XAPq5
	pgg6BVIe8ewEHmwWkel+XJ83Jp7FFKv1Sf6BzRM92xHKgg==
X-Received: by 2002:a05:6808:1a20:b0:4b5:5bfd:518e with SMTP id
 5614622812f47-4b964a27b4emr15913328b6e.20.1788855828720; Tue, 08 Sep 2026
 01:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Peter Elmers <peter.elmers@databricks.com>
Date: Tue, 8 Sep 2026 10:23:37 +0200
X-Gm-Features: AcwNN1UshcuZ67j60WjPO9AnH-wzKGRE-avj7qylOxB9QXsNpA8AWlaA2fD7fwU
Message-ID: <CALY5j-0K-LfowAavH8X3UfZ24eAsoX=xew=KTt=4uCfZrdwXQw@mail.gmail.com>
Subject: [BUG] git bundle create with bitmaps omits tree required by
 advertised ref
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

I created two sibling commits with the same root tree, stored one at a local
branch and the other at a remote-tracking ref, wrote a pack bitmap, and created
a bundle that included the local branch while excluding the remote-tracking
ref.

Adding `-c pack.useBitmaps=false` appears to fix the issue.

The following script reproduces the issue:

#!/bin/sh
set -eu

repro_dir=$(mktemp -d)
source_repo="$repro_dir/source.git"
recipient_repo="$repro_dir/recipient.git"

git init -q --bare -b main "$source_repo"
git -C "$source_repo" config user.name A
git -C "$source_repo" config user.email a@example.com

empty_tree=$(git -C "$source_repo" mktree </dev/null)
base=$(printf 'base\n' | git -C "$source_repo" commit-tree "$empty_tree")
git -C "$source_repo" update-ref refs/heads/main "$base"
git clone -q --bare "$source_repo" "$recipient_repo"

blob=$(printf 'change\n' | git -C "$source_repo" hash-object -w --stdin)
shared_tree=$(printf '100644 blob %s\tfile\n' "$blob" |
  git -C "$source_repo" mktree)
remote_tip=$(printf 'original\n' |
  git -C "$source_repo" commit-tree "$shared_tree" -p "$base")
local_tip=$(printf 'rewritten\n' |
  git -C "$source_repo" commit-tree "$shared_tree" -p "$base")

git -C "$source_repo" update-ref refs/heads/feature "$local_tip"
git -C "$source_repo" update-ref refs/remotes/origin/feature "$remote_tip"
git -C "$source_repo" repack -q -ad --write-bitmap-index
git -C "$source_repo" bundle create "$repro_dir/broken.bundle" \
  feature ^refs/remotes/origin/feature

git -C "$recipient_repo" bundle verify "$repro_dir/broken.bundle"
git -C "$recipient_repo" bundle unbundle "$repro_dir/broken.bundle"
git -C "$recipient_repo" cat-file -e "$local_tip^{tree}"

The resulting commit and object topology is:

                         refs/remotes/origin/feature (excluded)
                                         |
                                     remote_tip
                                    /          \
                            parent /            \ tree
                                  /              \
                              base                shared_tree
                                  \              /
                            parent \            / tree
                                    \          /
                                     local_tip
                                         |
                              refs/heads/feature (advertised)

Both tip commits have `base` as their parent and `shared_tree` as their root
tree. The bundle advertises `local_tip` and excludes `remote_tip`.

What did you expect to happen? (Expected behavior)

After `git bundle verify` confirms that the recipient has every declared
prerequisite and `git bundle unbundle` succeeds, every object required by the
advertised `feature` commit should be available. The final `git cat-file`
command should exit successfully.

What happened instead? (Actual behavior)

`git bundle verify` reports that the bundle is okay and `git bundle unbundle`
succeeds, but the final command (cat-file) exits 128:

fatal: Not a valid object name <local-tip>^{tree}

The advertised local commit object is present, but its root tree is absent.

What's different between what you expected and what actually happened?

The bitmap-backed bundle omits an object required by an advertised ref without
declaring the excluded sibling commit as a prerequisite. A recipient containing
all declared prerequisites can therefore accept the bundle but cannot traverse
or check out the advertised commit.

Anything else you want to add:

Adding `-c pack.useBitmaps=false` to `git bundle create` makes the final
`git cat-file` command succeed.

`pack.useBitmapBoundaryTraversal=true` did not prevent the omission in a
separate run of the same commit topology.

So it looks like a bitmap format bug.

Relevant documentation:

https://git-scm.com/docs/git-config#Documentation/git-config.txt-packuseBitmaps
https://git-scm.com/docs/git-config#Documentation/git-config.txt-packuseBitmapBoundaryTraversal
https://git-scm.com/docs/git-bundle#_object_prerequisites

[System Info]
git version:
git version 2.54.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.0.0-1012-aws #12~24.04.1-Ubuntu SMP PREEMPT Wed Aug 12
14:00:57 UTC 2026 x86_64
compiler info: gnuc: 9.4
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /usr/bin/zsh
