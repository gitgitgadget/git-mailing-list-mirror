Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39A1DA3D
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754693558; cv=none; b=qqe67kT8MVaiacICN5zzfSPaMVxslbV7H+wtzChuZhmGpP5EAuutrtFPuha5Z0Z8x+RwGPrApPLalUTk8AHtqYGlIcgac92EfBQfCke62HVPxPmTZseXSvRFIoviC2UIW3wIMLdF15rzqfcJv+h4GnS0bMHyQGmSqoPFnmVtQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754693558; c=relaxed/simple;
	bh=m70rbhhws+Lnoixlmi+weDvKvYjqBUFlndfU7cvhV6M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FYkF90FSCBJ8m2Z0ZuR22jqrot96TPTnnuRa3WJTr5eNXQRqt3m+4bxwZbDGaGZgOf0mLrCyvVhn3CoJB2yoxO576qV8yDTD9jEZshoHldqEIET3M4xmbWUZJh+yjZ9ZbtGGK9loCBtqOX1ZtvGLNs5CIwzswpCDfVWZqITOzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g41QQQ4c; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g41QQQ4c"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459d7726ee6so13175505e9.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754693554; x=1755298354; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/krLae0qUdp2/ybc7r8a1OWFKQMkXtZz6tYmJ3lV2s=;
        b=g41QQQ4c/eq4vHH6GYoXmb9XSoyozrMhrXGGQEez/zx51dyWs3eLjpUg4/sCvklEjW
         o3g34L6iP3eNyVcUvNIlaUHJsrhZcHwdTqthVJ/XhxFMZWcKHsS+k3dSs1HkItxh0ssA
         dDxd/3e+kTXq47uadbRnwqBddVvGTJuoyPHJlCPkXFkDJBo9eJJuXhHOQmvDH0R9E18b
         qgSNbXuw3i/KopFYpHTCT+ZGdTy7JAauacyIRVZ/GDvPdIgn6c3QHNPsk5RqcUNklh5H
         cIzBDiklGZrlPiJt1ozAodNnysg10mx99kl0FellNnjouZR5fPhFcreEozWbJGPrfSTN
         k6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754693554; x=1755298354;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/krLae0qUdp2/ybc7r8a1OWFKQMkXtZz6tYmJ3lV2s=;
        b=asgCGnaqPO3tG8Asro7Bh9hi+M0BlZA8DQpo9lBBQ9kLwxjLFDb129ZfodYsC7LyrH
         LFEqUf+PhMaNSrF5blHozF/SuyQxicsEgtcTK5w/k6yl8icAWlsD7zemQJlV09gDulHC
         QHpHTw/d4Js47kxOWJy6jZU4YMUJMaX/qQUMa+T8yMEljkykZAsa5pUIGgq+qmT0pYhx
         I6K/ehgHSREBAlxGP6FIIZBxgnibm5nO5GD9gDGpCK9wtn1ymNalQdymoEO7nTGpFOmV
         Xf8Q9pUvi/3to3tLd+b2w1k1sTBWl5yd6efue8l0Dr4sJ4sI3MZl6RrbyR99obZVOSxz
         Mfig==
X-Gm-Message-State: AOJu0YyY2AIJQXGK/e2JiSzdzauyPvfXOsFpOC6MRaCbaQq5D5YqQDK/
	sgWwnidNRPjcyfLmq5TTEnOMsh6XnV0IcwY8xlkVYKSWZ7j1SqPA/oXtUlxUdA==
X-Gm-Gg: ASbGncsbpy0hl3Uzf8/9EjUiler7tKq1v2C8Ggzu70A1MTHAirziH1ueW+aCyQA7hP+
	d92GTp3/jxsEzHlYKLuAbUVDIDMjXq2jVX12th8jvrq3frPFwHwZy9N3Ezkt6cpzi+6N4FeOoVt
	JFjqmbSv5k/MhcS8XXtPIcmLAUJmTABdREafcVKLPGu6UbM+W76Y0Eds+4q4RT50smDUqraymu1
	RBrskRUHn30iHPBeNcavgLe1aB6c/PqY9tw1Hd2K2G4wNLPX0Ea2jBh22EdbEsgbK+VYb94xxGS
	waD50+g0VzLRC/WzMsB82JdGv5PPPm5Psr/D1wT9bfRufvwNGWxftvw2eI4UvsIlBsjRdsuT6Go
	hjGMMCD1TDuryFKRMzRI7nzc=
X-Google-Smtp-Source: AGHT+IHsxwruRlGG8HZbcuMsNN3Rcb4avA5v7gcsqdm9WlGi0OhxGjDrJrbDDstqerQXbxXKkqavvQ==
X-Received: by 2002:a05:600c:1c18:b0:459:443e:b180 with SMTP id 5b1f17b1804b1-459f4f3e153mr44523965e9.8.1754693553950;
        Fri, 08 Aug 2025 15:52:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583f9fcsm148666205e9.4.2025.08.08.15.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 15:52:33 -0700 (PDT)
Message-Id: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
References: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 22:52:27 +0000
Subject: [PATCH v3 0/5] doc: git-rebase: clarify DESCRIPTION section
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
Cc: Julia Evans <julia@jvns.ca>

I liked the idea of trying a more ambitious rewrite of the "here's how git
rebase works internally" section, so here's an attempt at it.

My idea is to give an accurate technical description of how the merge
backend works while deferring some of the details (like how exactly
--fork-point works or what happens when you rebase a merge) to later in the
man page. I've also tried to use a minimum of git jargon, for example saying
"Then it checks out <upstream>" instead of mentioning anything about a
"detached HEAD" since I know that term can jarring for folks who aren't used
to that term.

I hedged a bit by saying that rebase is "similar to" running git cherry-pick
repeatedly since I think of a rebase as being like doing a bunch of
cherry-picks (and very often hear people describing it that way), but I'm
sure that there are differences that I'm not aware of.

I've also updated the "clarify arguments syntax" commit message.

Julia Evans (5):
  doc: git-rebase: start with an example
  doc: git rebase: dedup merge conflict discussion
  doc: git rebase: clarify arguments syntax
  doc: git-rebase: move --onto explanation down
  doc: git-rebase: update discussion of internals

 Documentation/git-rebase.adoc | 300 ++++++++++++++++------------------
 1 file changed, 145 insertions(+), 155 deletions(-)


base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1949

Range-diff vs v2:

 1:  26b742eb49f = 1:  26b742eb49f doc: git-rebase: start with an example
 2:  249a5127904 = 2:  249a5127904 doc: git rebase: dedup merge conflict discussion
 3:  ce7ab74ea0f ! 3:  013a5044ef3 doc: git rebase: clarify arguments syntax
     @@ Metadata
       ## Commit message ##
          doc: git rebase: clarify arguments syntax
      
     -    This removes the explanation of `git rebase <upstream> <branch>`, since
     -    it was already explained above that it's shorthand for `git switch
     -    <branch> && git rebase <upstream>`
     +    Remove duplicate explanation of `git rebase <upstream> <branch>` which
     +    is already explained above.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
 4:  590d7486d3d = 4:  c574a27412d doc: git-rebase: move --onto explanation down
 5:  ad97cd9e671 ! 5:  eabacd3c159 doc: git-rebase: update discussion of internals
     @@ Metadata
       ## Commit message ##
          doc: git-rebase: update discussion of internals
      
     -    - make it clearer that we're talking about three steps of a process
     +    - make it clearer that we're talking about a multistep process
     +    - give a more technically accurate description how rebase works with the
     +      merge backend.
          - delete a duplicate explanation of how git rebase skips commits with
            the same textual changes (it's explained in more detail a few lines
            further down)
     -    - move the `ORIG_HEAD` note down so that it doesn't interrupt the
     -      discussion of the mechanics.
     +    - remove the explanation of how exactly `--fork-point` and `--root`
     +      work since that information is in the OPTIONS section
     +    - put all discussion of `ORIG_HEAD` inside the note
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-rebase.adoc: linkgit:git-config[1] for details) and the `--for
       branch does not have a configured upstream, the rebase will abort.
       
      -All changes made by commits in the current branch but that are not
     +-in `<upstream>` are saved to a temporary area.  This is the same set
     +-of commits that would be shown by `git log <upstream>..HEAD`; or by
     +-`git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
     +-description on `--fork-point` below); or by `git log HEAD`, if the
     +-`--root` option is specified.
     +-
     +-The current branch is reset to `<upstream>` or `<newbase>` if the
     +-`--onto` option was supplied.  This has the exact same effect as
     +-`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
     +-to point at the tip of the branch before the reset.
      +Here is a more detailed description of what `git rebase <upstream>` does:
      +
     -+First, all changes made by commits in the current branch but that are not
     - in `<upstream>` are saved to a temporary area.  This is the same set
     - of commits that would be shown by `git log <upstream>..HEAD`; or by
     - `git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
     - description on `--fork-point` below); or by `git log HEAD`, if the
     - `--root` option is specified.
     - 
     --The current branch is reset to `<upstream>` or `<newbase>` if the
     -+Then the current branch is reset to `<upstream>` or `<newbase>` if the
     - `--onto` option was supplied.  This has the exact same effect as
     - `git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
     - to point at the tip of the branch before the reset.
     - 
     -+Then the commits that were previously saved into the temporary area are
     -+reapplied to the current branch, one by one, in order.
     ++First, it makes a list of all commits in the current branch that are not in
     ++`<upstream>`. This is the same set of commits that would be shown by `git log
     ++<upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
     ++list of commits is constructed.
     ++
     ++Then it checks out `<upstream>` (or `<newbase>` if the `--onto` option was
     ++supplied) with the equivalent of `git switch --detach <upstream>`.
      +
     ++Then it replays the commits, one by one, in order. This is similar to running
     ++`git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
     ++are handled.
     ++
     ++Finally, it updates your branch to point to the final commit with the equivalent
     ++of `git switch -C <branch>`.
     + 
       [NOTE]
     ++`ORIG_HEAD` is set to point at the tip of the branch before the rebase.
       `ORIG_HEAD` is not guaranteed to still point to the previous branch tip
       at the end of the rebase if other commands that write that pseudo-ref
     -@@ Documentation/git-rebase.adoc: at the end of the rebase if other commands that write that pseudo-ref
     + (e.g. `git reset`) are used during the rebase. The previous branch tip,
       however, is accessible using the reflog of the current branch
       (i.e. `@{1}`, see linkgit:gitrevisions[7]).
       

-- 
gitgitgadget
