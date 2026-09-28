Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE71E260C
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627578; cv=none; b=PFzqmfkNnSdGdroiTO2olEos4LRNaCCO35IfuQXe/6hjwS02ZMIJtShcin8ocwHW2Q39oeTvp62M7OY98pXsIDoYVSKiSLyGC3F1sADmz8KhbwHqkNb77zPCJQiuMDJKhKIF7TvzOzEkeiof8g+blKMMBfrywNxc4GUTS4RAhW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627578; c=relaxed/simple;
	bh=SF6MK1CiEfAr1Gho2nzCqsjLUDZVWQ3kc/ysRMg5Wk0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Nwixy/9npW0BROrQyJhu96tV5UTglJc1Zdew0aooWZ895QXgn0tanHbm1dgN8q+CJEUv0Gj6ckYtJpYSUUqHY6vJrv8gnUx7DwB3MZHOhZ6IdkRXDkX+reLEddBJFxJb2Dxs8PkbJlTwkeeFSJF5Posvuwk7/AziQSgRNALeY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvV7i4ro; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvV7i4ro"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f7915355so3019399c88.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790627576; x=1791232376; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N0/nc4mq934OaXIV7pR5YS7FQYX/rXq/YBSdT57cxuQ=;
        b=mvV7i4rob7Du00j6fFPjSH3bpU7KKE7y+p9yJs/KUmXE3X5iuyANKmw0Wqw26kVNzx
         I6DpxJZIzzrho0O+kcpA0tOLq+BuQQo5PKYvU4Esi3n1UHQo6m9csOKb8avrN++SHtPp
         AjBluure3GsqmPOCK6DohUzWqriqyFhxeUCp0iUax6obUV67bNtcMF0shXI2W7u7xDdp
         LGmMlJ9WMMHwxeCrROaGvybct/AlmgfCY9qngLR/NVOtdOp+hKK22/kbMYs9zWARCoEx
         NLNgCjjOEj+7oTiws71YW+zdvK1+B1UCN0Hfke7ILn4SzQbDJN9mPby9s833daO+NoJ6
         Emuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627576; x=1791232376;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N0/nc4mq934OaXIV7pR5YS7FQYX/rXq/YBSdT57cxuQ=;
        b=aDru0k3GqyIe1Hav76du35HQbtKhFaFJmbkaySUVxrg7nvtwwbn376t9hzL8b+C7Wr
         iPw8FnjbkGl/Gv5cV/70Rg57UKPLMztgV6fhJ5Z0zokRNs/576yUo0FUn5Cok50pWuwM
         P5Zz6nZkempwn3Rgl2NgecQEjEvOH9v0W9wT06F5OSR3Ay2iGaiXBWn1ZiynqyPqo5iR
         k3YoJ7S2VGKyBJ1rJ6ufSQNr9QS8U7bgUDwl0O1mwYELqwA4b67m0HKH8Uon5WyP0K24
         xRIgdnz4n9yYy2pVucGEinzFH4sI178EPhZLvacv3gZfg6u7DJEWFQiXFEyXhOCqq8YU
         O52A==
X-Gm-Message-State: AFuF++kG96G2g6dT+xz157zDqF1rusf0dt1dgaHIdQfPStNg8NvEpCg4
	mueDSpMsDFmV6sjmDmQ+RnaPZTKcFn+RaBB3zgjd3o2gJJj1JIxUIUcVP5NRFg==
X-Gm-Gg: AYBFou0rOh6OINy+3qRQJ9QbHEro0t6DTQ1eRK1KLFuVracFICwHhIY1CoiaNtqkDAx
	7/buyoBa0Duab5pxMwzFT6YUmoOyuvBrdclTCbO7kFmhmvccTIRuAcGiA6HKrS3uZU43t0lUOvW
	BJ1ED+qoUeiBa4Mg0u7aQ8Tu+fiYe/ZcZPBuTrqjX9FU6hvRYcW+fA1GcTK74OhVecnz5ikPHji
	YUZEKZxLwews1cK783ehOGjucaFmQDK/6T7dIKOUxDbPNXlTW0MTYy15Qc83YXOCWGLyloRbTDP
	9oiiJrW0Yx+qnaI2ygXbNrxPlewYX/WKSqeagTXqr9JwI7mnsZi/pAbVWeMtwCIHIZ2suEerfn6
	7BQMm/O+FiKnV5Um2jSgqCpUQ8yque4SucuAyVq3wUzCGqXBCLVd/l7FfgmN5VloxJY/l5MmFwU
	wRMJ4YIODyvICB201HtqSRfs9SRbTWdspPcQdlxEVIzRiAn289mRx04Z1dZau+UZfPLGhPLoe3+
	wY=
X-Received: by 2002:a05:7022:43a9:b0:143:4710:a869 with SMTP id a92af1059eb24-146cdfbecc6mr16888897c88.2.1790627575742;
        Mon, 28 Sep 2026 13:32:55 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm25673834c88.0.2026.09.28.13.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:32:55 -0700 (PDT)
Message-Id: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 20:32:54 +0000
Subject: [PATCH] [doc] Use `man git` to teach users how to navigate the docs
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Many existing users of Git don't know how Git's documentation is
structured, and a lot of folks have expressed frustration that `man git`
doesn't make it easy to find out how to get help with using Git.

Explain how Git's help system works in `man git`
(`git push -h` gives a short help, `git push --help` is the full docs),
since it's a slightly unusual approach.

Remove the references to gittutorial and giteveryday since they're
unlikely to help new users learn Git. Currently they feel very
aspirational (it would be nice to have a tutorial and a guide to
everyday Git commands!), but we should give users a realistic view of
what the documentation actually provides.

Mention `git help` instead of `giteveryday` for now, which does a better
job of giving an overview of everyday commands.

Also mention `git help --guides` and `git help --user-interfaces`,
since those parts of the documentation are useful and hard to discover.

Do not mention `git help --developer-interfaces` since it's not relevant
to users.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    [doc] Use man git to teach users how to navigate the docs
    
    Here's a list of things I'm still considering in the hopes that it'll
    help with the discussion:
    
    I'm not totally satisfied with the description of git help
    --user-interfaces here. It might be clearer to give examples of topics
    those guides cover, like "hooks, .gitignore, and more".
    
    I thought about mentioning git help push and/or man git-push, but (from
    a Mastodon survey I did) git push --help is the one users are most
    familiar with, it's most similar to how other Unix tools work, and it
    makes the description really clear and concise (-h for short help,
    --help for long help).
    
    We just added gitdatamodel here but I took it out because I couldn't
    find a place to put it in the new explanation that felt natural. I do
    think that discoverability of that guide is still an issue and it's
    something that's on my mind. One option in the future to make the guides
    more discoverable would be to feature them more often in Git's advice,
    for example see 'git help mergeconflicts' for a guide to handling merge
    conflicts. Users definitely do read the advice.
    
    Related to the discussion here
    https://lore.kernel.org/git/7004c3b1-2100-4a90-9815-2a679ceb25b2@app.fastmail.com/T/#mf600063180d6239916e3fa6e9d33da86969547ec
    
    ccing Kristoffer who edited this most recently.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2242%2Fjvns%2Fupdate-git-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2242/jvns/update-git-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2242

 Documentation/git.adoc | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 6f0075f918..3e886d3e1d 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -22,16 +22,18 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
-See linkgit:gittutorial[7] to get started, then see
-linkgit:giteveryday[7] for a useful minimum set of
-commands.  The link:user-manual.html[Git User's Manual] has a more
-in-depth introduction.  See linkgit:gitdatamodel[7] if you want to
-learn about the data model and important terminology.
-
-After you mastered the basic concepts, you can come back to this
-page to learn what commands Git offers.  You can learn more about
-individual Git commands with "git help command".  linkgit:gitcli[7]
-manual page gives you an overview of the command-line command syntax.
+There are two ways to get help on any Git subcommand (replace "push"
+with the command you want help with):
+
+- `git push -h` for a short help
+- `git push --help` for the full documentation
+
+There are also guides explaining Git's concepts and more:
+
+- `git help` shows the most frequently used Git subcommands
+- `git help --guides` lists Git's concept guides
+- `git help --user-interfaces` lists guides for various
+  special files you can use to change Git's behaviour
 
 A formatted and hyperlinked copy of the latest Git documentation
 can be viewed at https://git.github.io/htmldocs/git.html

base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
-- 
gitgitgadget
