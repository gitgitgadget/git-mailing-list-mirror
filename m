Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D052472AE
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951542; cv=none; b=EDkEGBKXQ+sQ7zfSbvcQgXZsf+KXwK1cBNA58ITIWO8BeIL4n/0Zj6s1HmZI3i3Q4Ugnvx34sz6fth6QWW8De91sHAGVXtlY2Y9ZSD+XrcDtWKWQegk/F1eBz+uJ29k5h2t/MufKa1NWghxepBV5hDnZk9pZqvoPavS1yiaL0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951542; c=relaxed/simple;
	bh=xI/oaUFJ87OCGoAV6qKxz46gd5Mj/kifGGtoQH2TLUE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AZsqoQ1ud8/SfVkUuhCNlZ85DEz6v5RchxnFfJ8lMLqUKsnICEaBTiK5EDJKGnS8SbEn6TZvN4pWXE9xIJAIZwcc3/uFDbwkF90fK3OqmMjMbwsA1jz8jwG3ymJoaQpmoBlvM0t8djL3qAb9Iz33aLLWEPu7pOa3+3olEqYkMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK++1ub5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK++1ub5"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so225501b3a.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 12:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759951540; x=1760556340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoeMdqOpMiw1Qo41OfVH4D0qVkj6qtbPQAmjHv9WnNA=;
        b=dK++1ub5oqiWe2xrGAMa8ISqAdANXf4PDGnwIM21dy5d4lZriqJVCbkPmXAEHqAjdO
         mtJ0AmbOgyhCeiuRRM98QNMwef2TnhCXrQggK+OZqSyj2ibuimd9DS6LCwDHFgxCKp0h
         1bb+yWpMYga4tnch8bmxroaZ+pUYl1mdGT9sdvOVQxMrI7/sPIU39uesnCfNEqcuZgg9
         NmFe7R2lrhlHnkEBAwvXoSIhg0qhVyHFEaSOU59ZwOwycCcmLanLciJcNtcu3IMq6RXp
         PuliPAw+ptaerFbqAkw49jxWghAHw02WpNVtP5qj6Mfh3nGhzJB0WxDeyp0pD9gjNjcN
         LtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759951540; x=1760556340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoeMdqOpMiw1Qo41OfVH4D0qVkj6qtbPQAmjHv9WnNA=;
        b=JjXRtEkMaKYsuTybrCT2lmuDFmtbdhFdePX32bhEzMy5vytwdoou3JXRTHYZ/HlTzq
         PE6ifw/i7eGVV5F80SsgcXDH2cnOon63D6HCPdWS7BbakWsOE+TnbB2kVLdCuwDV9zKl
         /TgGPVYpPLIKefJ7is9EZ22m+Mq5zikUc2VhygG+pGV5fz0B2hKiSMSSDkgO9gMAMj0b
         GxCgJrItrkZ9c334A35gYh8JUVv4KV//ZB6stqSwc/YB8QSaP6fkEyN/3stQyzsz1igt
         mXWC4mNQdQHptY/3gBPslq0/6dK27n6BrABkbAKROJGzilofYVy0otADHUPYWjR0gN13
         jPPQ==
X-Gm-Message-State: AOJu0YzZdYRw0fC6WJObB2tzw9hXbw2ZCHui1KV4yB3hF1osV9JeY0+w
	PrPA8jzCHr1lCd7c5W+0FkfTC7O073cWw8uhf9hii1SYLi8IheaUiaRSblooGg==
X-Gm-Gg: ASbGncshV9X7ZZUMn6VoxdSF3P8qB0Ugj6Ds7zEGVekUevxGEkpN7NM4tk/UfawD4EE
	hX1nGutyYEPCO+FcJsrQtAMEkpl9HdBX3Gu1hHe3hvEbbWAPtUgChW0VfKfpq8uqzekx2kFxoGs
	54GrZfV9ujrG0rcC+aLh9XiylmjTwRLvN1u0cxmIMImoSSxQLQDmf9wUBjwF3QNiXwbczmBmdqV
	wcSLMIpVxizBUMh8i574eQyoL2HMz7O3zOQW6Hvfd3KI9FvSDh2MwfEOFDuCc4hzzRTYoQYkHQB
	wR9DmrL9+GAYZ3rOSJkO5P9vPfN3C3V/4AsFlhq0dHT+//ldKXOwccJf2uTtTeMQaGmJV+whzYS
	baN7s7LWTrZ5M8xfJoaPIfD4EXtA833pfuUxKKMDRiV6H/CCTzkM=
X-Google-Smtp-Source: AGHT+IF4Rc5ldPTxV2TiHd+Hza4YuZaOkHw8HvMhXjC4CtLAraj+K+adD3sl/LiPruOeE19PElr/0Q==
X-Received: by 2002:a05:6a20:918b:b0:262:cbbc:3125 with SMTP id adf61e73a8af0-32da8139533mr6477229637.20.1759951540157;
        Wed, 08 Oct 2025 12:25:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d510f628sm510307b3a.29.2025.10.08.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:25:39 -0700 (PDT)
Message-Id: <122774d4cc8fa4e9184a0f82e9b6e562363ea433.1759951536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
	<pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Oct 2025 19:25:34 +0000
Subject: [PATCH v2 2/4] doc: git-pull: clarify options for integrating remote
 branch
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback:

- One user is confused about the current default ("I was convinced that
  the git default was still to merge on pull")
- One user is confused about why "git fetch" isn't mentioned earlier
- One user says they always forget what the arguments to `git pull` are
  and that it's not immediately obvious that `--no-rebase` means "merge"
- One user wants `--ff-only` to be mentioned

Resolve this by listing the options for integrating the the remote
branch. This should help users figure out at a glance which one they
want to do, and make it clearer that --ff-only is the default.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index a3d248dd1d..6e9fa14967 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -15,17 +15,25 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Incorporates changes from a remote repository into the current branch.
-If the current branch is behind the remote, then by default it will
-fast-forward the current branch to match the remote.  If the current
-branch and the remote have diverged, the user needs to specify how to
-reconcile the divergent branches with `--rebase` or `--no-rebase` (or
-the corresponding configuration option in `pull.rebase`).
-
-More precisely, `git pull` runs `git fetch` with the given parameters
-and then depending on configuration options or command line flags,
-will call either `git rebase` or `git merge` to reconcile diverging
-branches.
+Integrate changes from a remote repository into the current branch.
+
+First, `git pull` runs `git fetch` with the same arguments
+(excluding merge options) to fetch remote branch(es).
+Then it decides which remote branch to integrate: if you run `git pull`
+with no arguments this defaults to the <<UPSTREAM-BRANCHES,upstream>>
+for the current branch.
+Then it integrates that branch into the current branch.
+
+There are 4 main options for integrating the remote branch:
+
+1. `git pull --ff-only` will only do "fast-forward" updates: it
+   fails if the remote branch has diverged. This is the default.
+2. `git pull --rebase` runs `git rebase`
+3. `git pull --no-rebase` runs `git merge`.
+4. `git pull --squash` runs `git merge --squash`
+
+You can also set the configuration options `pull.rebase`, `pull.squash`,
+or `pull.ff` with your preferred behaviour.
 
 Assume the following history exists and the current branch is
 "`master`":
-- 
gitgitgadget

