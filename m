Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7088D2DBF69
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949081; cv=none; b=rhaMFXDmmLYvzRckMOhehXopElAhk68Wsx8tud6F6Inup9gOGhiajAI5JwNyrMHnXlFQ+BEh7n6ygluVQwota/1raiKWB6G510KWjT8rMe2vQdYK11SHPTlIBEnMHMI5S5AR473W1dAFjxqhVbWKF+WxsGFXXpg4W9rkuBVlnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949081; c=relaxed/simple;
	bh=2nou1eF3x98xorzj20iI/Vfo0Oxj0NNMT0fuLB5ledc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ohNQz2BK2obEWKufU7QGOARSytjyFNqNU55WLctVT1zdAgljFmRSvltaguCtVlDdN5slkRVg4rTmXPJHZ3tWvQ3tdOpuWPfdqwFt+Sb8XqnqNp4UD9mm6crvI30RO+AkoJYssfGfkpqaTpn22yDTWppCAp1uEXKehSUGF2nlHAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvI7oLKX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvI7oLKX"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b8de6f7556so2690236f8f.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949077; x=1755553877; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8Uy5xkKeZHQboz9o9eQhUFYno9uVx4do//Vy4WLXYA=;
        b=bvI7oLKX3kQFAY5pZ38NG725hyyFhYP1lJpNAjp7X7oBh4uC98R+2cbIkG0OR9q1rX
         +2JIN8Udp5xuX1bau0STRj2AG5xB8u5H9ypEyEDSw4+3TkkzYXuVosC+acQcoHzfO0Gl
         qYVoRr0gZ/xtASg5fblPSqptBY230hGdY1kOvIGHhVNpxabXKKoG5snsO6S2BmiD+4Te
         t8V1o8nYe8V+dVPmoVp7Z6JPRUrFz1GCwRzhWwIx6kQMV90pF/j1rJKpkaHsr2rr8No7
         IzxyMCzOMo6mvA6ca84kuJhLaAqk5eMtlS4UdtlFGiotAgRMXzSuH5FjO9UL762GZ/ZS
         4L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949077; x=1755553877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8Uy5xkKeZHQboz9o9eQhUFYno9uVx4do//Vy4WLXYA=;
        b=VQPXb2RBUnAF4T8WVtHOwlfFlh76awrjUX+mzQq4krmaUhEf4z3z87lr8h2PF6ZKgL
         7RpdibrM0KIk9JdLwHgmeuM4d56179U/x7Gngm7hZB+KAqWoOvjj/fh800ZtqUnFXuts
         Cb5bbfz36V5YbLrDtpx6OYOe9XUnvXIgXbJTVyjaACuuBBBW56wrfkmDc6PhTr/mQZz6
         lHzG3Go3A6ONR6RbSlJGqS2joPTV0YBumUBDzDqHUm2VzSuv7aYAOTdxTaWGARJtdqQz
         PB7FH2zEUGfKfS+qhKx7rlbG8b/YU+5qk4NAvrjPRt8xbFgawX4+wIf4vV4IlY3JHomM
         6yLQ==
X-Gm-Message-State: AOJu0Yy3zDlDuvqj257KCzWfCreQndvh9tanSxHmgjKlDJa7FP3doahx
	2uqskvs2sKo/kmcyEXbHX6i7h7HTol2hXNMgrRxzYFB8aApoA2Bv7zmzgq9ROA==
X-Gm-Gg: ASbGncuvXqL4FKNP6/ejTc2TxivqTtmLJU0rdCCPwo18pSOBhPb46RbRPqb4vXTG4Ak
	yqYZP5emmOs+qM9AGdynQas/gMuQvGysuNGZC4Qf+5UNeL1ve+6p4xSDM13BOuexIJMJ/NjQc3B
	oOLCf9uK7UxQLRKOn+Sc/WwB31rZtXdj8GWsLi7aKecKuSQaymTe9OD64ApPERAj8yugxyJwEaW
	Y/71gZy7iXPO4iHoDEHS5RDjnLxbMjpz738lUMXZLCgwNki/EVnRMzNLIdJGPHOEOkJZegnLTjT
	6DGQPFO9pk0fRutwW9AJtFDsGfM4QUQ6uPFIELXO5TpAYjPK53bDTGFSA3OeV8TAw4ZJ27bGhzc
	zt9PAArr3ZslopMqOPl3t/pw=
X-Google-Smtp-Source: AGHT+IHk0gn09SCodOFi+tvhGdxVzYufw4u4YuKVzlfDCee2N5m9gCNPVK4jIMHbdl7OHfDvUDG6FA==
X-Received: by 2002:a05:6000:2406:b0:3b7:8f49:9514 with SMTP id ffacd0b85a97d-3b910fe431emr843869f8f.18.1754949077174;
        Mon, 11 Aug 2025 14:51:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dd85f423sm333836165e9.18.2025.08.11.14.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:51:16 -0700 (PDT)
Message-Id: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 21:51:10 +0000
Subject: [PATCH v6 0/5] doc: git-rebase: clarify DESCRIPTION section
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>

 * move "You can also use git rebase to reorder or combine commits:" to the
   beginning
 * replace "detailed description" with "simplified description" -- I thought
   that I could write something that was relatively readable and also
   accurate, but as usual Git has proven me wrong :). I tried to leave in
   the details that I think seem relevant to using git: for example git
   checkout --detach is relevant because it explains why git reflog works
   well after a rebase.
 * replace the git switch with git checkout that I'd missed previously

I didn't use the git log --cherry-pick option in the explanation because I
had personally never heard of that option before today, and I don't want
people to have to read the git log man page to be able to understand the
explanation. I also left out --reapply-cherry-picks just because I don't
understand the use case so I couldn't evaluate how likely it is to be
relevant to the person reading.

Julia Evans (5):
  doc: git-rebase: start with an example
  doc: git rebase: dedup merge conflict discussion
  doc: git rebase: clarify arguments syntax
  doc: git-rebase: move --onto explanation down
  doc: git-rebase: update discussion of internals

 Documentation/git-rebase.adoc | 302 +++++++++++++++-------------------
 1 file changed, 136 insertions(+), 166 deletions(-)


base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1949

Range-diff vs v5:

 1:  c2f2e05078f ! 1:  e7a8fbbe53c doc: git-rebase: start with an example
     @@ Documentation/git-rebase.adoc: SYNOPSIS
       DESCRIPTION
       -----------
      +Transplant a series of commits onto a different starting point.
     ++You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
     ++MODE below for how to do that.
      +
      +For example, imagine that you have been working on the `topic` branch in this
      +history, and you want to "catch up" to the work done on the `master` branch.
     @@ Documentation/git-rebase.adoc: SYNOPSIS
      +    D---E---F---G master
      +------------
      +
     -+You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
     -+MODE below for how to do that.
      +
       If `<branch>` is specified, `git rebase` will perform an automatic
       `git switch <branch>` before doing anything else.  Otherwise
 2:  5459b7ff560 ! 2:  ad63f69918d doc: git rebase: dedup merge conflict discussion
     @@ Commit message
      
       ## Documentation/git-rebase.adoc ##
      @@ Documentation/git-rebase.adoc: shortcut for `git checkout topic && git rebase master`.
     - You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
     - MODE below for how to do that.
     + ------------
     + 
       
      +If there is a merge conflict during this process, `git rebase` will stop at the
      +first problematic commit and leave conflict markers. If this happens, you can do
 3:  948c205f1e6 = 3:  7ee6b0afe88 doc: git rebase: clarify arguments syntax
 4:  e229b9fccb2 = 4:  4686417b28e doc: git-rebase: move --onto explanation down
 5:  5ab235b067b ! 5:  9c7f2716bc8 doc: git-rebase: update discussion of internals
     @@ Documentation/git-rebase.adoc: linkgit:git-config[1] for details) and the `--for
      -`--onto` option was supplied.  This has the exact same effect as
      -`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
      -to point at the tip of the branch before the reset.
     -+Here is a more detailed description of what `git rebase <upstream>` does:
     ++Here is a simplified description of what `git rebase <upstream>` does:
      +
     -+1. Make a list of all commits in the current branch that are not in
     -+   `<upstream>`. This is the same set of commits that would be shown by `git log
     -+   <upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
     -+   list of commits is constructed.
     ++1. Make a list of all new commits on your current branch since it branched
     ++   off from `<upstream>`. This is the same set of commits that would be shown
     ++   by `git log  <upstream>..HEAD`. You can use `--fork-point` or  `--root` to
     ++   change how this list of commits is constructed.
      +2. Check whether any of those commits are duplicates of commits already
     -+   in `<upstream>`, remove them from the list, and print out a warning about
     -+   each removed commit. You can use `--reapply-cherry-picks` to include
     -+   duplicate commits.
     -+3. Check out `<upstream>` (or `<newbase>` if the `--onto` option was
     -+   supplied) with the equivalent of `git checkout --detach <upstream>`.
     ++   in `<upstream>` and remove them from the list.
     ++3. Check out `<upstream>` with the equivalent of `git checkout --detach <upstream>`.
      +4. Replay the commits, one by one, in order. This is similar to running
      +   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
      +   are handled.
      +5. Update your branch to point to the final commit with the equivalent
     -+   of `git switch -C <branch>`.
     ++   of `git checkout -C <branch>`.
       
       [NOTE]
      -`ORIG_HEAD` is not guaranteed to still point to the previous branch tip

-- 
gitgitgadget
