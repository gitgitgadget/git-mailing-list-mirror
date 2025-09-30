Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189B238C03
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262319; cv=none; b=MRKdvRCo9T2IzVwALw5fiUgtGoVBmo+jK2qvw4KFAgG7YIiaZ47I31qDY0EpNqk4AQSjlrAHbZs3mjiGnqkNqX1QcD6zbsfq00pI4vhVPffTbQX4dzHgi482qRXWHoDQsFcs6FI3e772OpqE/kFDR/sLzJA5U4Vk8o0pITbBmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262319; c=relaxed/simple;
	bh=bRDql50PG9nZdVM7el6v4n+ad2UnNjjVh7sVt3MB15g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nkHbAOxEqoN+l0JNPhLhJ7u6uEnYD5siC0AA5Riu8YyDOxwb3WG+SMAgodL/Xh+NNECCQSESM13CqB9sjAJ70dmGN4NGLdhdWIHHjprsGGOg4lDL8kU1Psgi7DJ4zll+fkfahc3vOWrCaFhKiU8lutXVKNgfbuygU26ylMfveQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSlBKeD5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSlBKeD5"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so221000b3a.2
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759262316; x=1759867116; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL+RfK3fkrkmdBHx/YDsSs0ZA2UDKawgqCYbNEu0jAs=;
        b=lSlBKeD5Q/VwTIhMbVRMK0vAS09SQzMl9RYYgJB/EzHswV/TQ+sV/5vR/5WI/3/jz2
         CUVr0+OaVEY4jn1eGu8iBtPyaGST93qzDZhA7oZbGvUjPWBaLc1qVGjXawfdyj5Vrq3J
         4t7G1ShL2gU+keJS5rMknMs2iAI4NJN+xeWpt9rWnnaFUKYzbtJYsUm7f4Bb9AnByK9T
         +NI0fibenKgBwxS4h0Nwomnh2g90Y5GtgjE3dgQXq7olqVfLk/uYIxNgWJn3naJMOObF
         7ZmAwcjt+fXkby6APsKheFHpRRd031O/L1RKSC3R2Nk1hyPH2uUGcxzGUPuXRwSzgCs8
         mBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262316; x=1759867116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL+RfK3fkrkmdBHx/YDsSs0ZA2UDKawgqCYbNEu0jAs=;
        b=jyBgvIfQD1pXSwwV65vipSOu99Z88JavcESQV6tw/KvTv0JQl/RaU1c8ltWw2JIRiN
         bIR8iTae23Yt64NVoOAbjIwhG54ZfgSKWW0Za6J1HgFYicJ30AfNlWCDfZ6DA98WJ/8c
         uIMdVSnJ9v5LNQkDfzTgCcxy/lpD3FY6BmKsQBQrNWzTSSZssEZD7EJfOEnnj1bOzzWQ
         e7TL6tFXXSifxnr6Jf99r3EuKIm7RkFwZHxAbNpva71OjOjEVaRTBOzdhXiVB+WpZf3s
         y/pfu7m8ij1NdVxPpItmxIVPNRZ542bWPbBWz2/8XlpyMVrYBHgjBJxe2QnDbf+tAPSz
         yrjQ==
X-Gm-Message-State: AOJu0Yy8T7jsc6/Q98omVgd1CU1iJ9DbGM10DYaLogfdCEYKBjIHXPoQ
	O7THVhQxfpmcL7+nsRmtVAnmO02aH65fkq1U5+JDoW3jziNs0SFgCcZYETSYXA==
X-Gm-Gg: ASbGncsPDo0CboykDMxeLpHJ2jMPo0P8X7YegUZx8pZGmau37tuylm5/qXEjwEZpnty
	zFGJKBtX+atcHQYIWVYVhuY/NXLVH1KXJXOD2L+Pkdp5JDpc72gucpG7lG8wCpHjQvTqWPWnwXL
	UefEKdehLVP2bUpifpeHsrgyb4Fw1axzchtbtQ4Crsr0x0BpttzYoGQ4tS5jLBaKzZlx2/aXfhz
	WGck7mZrlOqieCYXnX6yYWU/oCaqPtlZFNmphvLn94vyZ+AgYJyVicPfi4AkcgIaw01oQW5HD90
	igG2wjHcPnXeSSeNFQIO/lMK9Og0jdzbb6f1MaVmXd6vK5b1HtY6MhUfslNdJDjgAsW+7nrGU+K
	vI6MPYXBfmloQp6tCXO9NX76VMw7S0vhEBtF22G5KI29KihKueQ==
X-Google-Smtp-Source: AGHT+IFJUW7rtBKMSAujeVqicJgIgZKPkHHX5Oe9En28KJCuWicw2Nd2+J+6HsdnTQ3FaMoGrx41WQ==
X-Received: by 2002:a05:6a00:17a9:b0:77f:472b:bc73 with SMTP id d2e1a72fcca58-78af41420cdmr762899b3a.6.1759262316043;
        Tue, 30 Sep 2025 12:58:36 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.210.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-783acc3eb0fsm7224721b3a.2.2025.09.30.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:58:35 -0700 (PDT)
Message-Id: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Sep 2025 19:58:29 +0000
Subject: [PATCH v4 0/5] doc: git-push: clarify DESCRIPTION section
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>

I surveyed 16 Git users about the git push man page. Here's a rewrite of the
DESCRIPTION section and the definition of <refspec> based on the feedback.
The goal is to clarify it while communicating the same information. The most
common piece of feedback was that folks didn't understand what the term
"ref" means. Most of the users who said they did not understand the term
"ref" have been using Git for 10+ years.

changes in v2:

 * The biggest change is to add a new UPSTREAM BRANCHES section to explain
   what an upstream is
 * Drop the "refspec" changes from this patch series, I've made revisions to
   them based on the comments here but I felt like this was getting too big.
 * Added some backticks `` that I'd missed, from Ben's review
 * From Junio's review, "The current branch must have a configured upstream
   with the same name, so this will fail when pushing a new branch" was not
   true, so replace it with a less detailed but hopefully true statement.
   After a very long conversation with Ben I realized that actually
   push.default=simple's behaviour is not really that simple (perhaps I
   should think of it as more "safe" than "simple", since "current" seems
   simpler), so it's more realistic to refer any questions to the
   CONFIGURATION section which describes the behaviour in more detail.
 * Rewrite all the commits to explain the problem they're trying to solve &
   thinking behind them in more detail. Let me know if I added too much /
   not enough detail.

changes in v3:

 * mention that git push also needs to send data in addition to updating the
   branch, from Junio's review
 * fix a newline, from Junio's review
 * un-rename urls-remotes.adoc, from Junio's review
 * mention pushRemote and git checkout in the UPSTREAM BRANCHES section and
   be clearer about what's meant by "the relationship between the current
   branch and the upstream", from Junio's review
 * fix AsciiDoc formatting issue, from Junio's review

changes in v4:

 * Add "the simplest way to push is git push <remote> <branch>" at the
   beginning since (as discussed) this is the form of git push that's
   easiest to explain.
 * Remove "as a safety measure" since (as discussed with Junio) the reason
   that git push sometimes requires you to set an upstream is very
   confusing, and "as a safety measure..." makes it sound more principled
   than it is. Also update the commit message to say that the previous
   explanation was not describing push.default=simple's behaviour
   accurately.
 * Reword "To decide which repository to push to..." because I felt like it
   was still phrased in a clunky way.
 * Make UPSTREAM BRANCHES and CONFIGURATION into actual links in the HTML
   docs
 * Fix formatting in UPSTREAM BRANCHES section, from Junio's review
 * Fix some commit message mistakes, from Junio's review

Julia Evans (5):
  doc: git-push: clarify intro
  doc: add an UPSTREAM BRANCHES section to pull/push/fetch
  doc: git-push: clarify "where to push"
  doc: git-push: clarify "what to push"
  doc: git-push: Add explanation of `git push origin main`

 Documentation/git-push.adoc     | 47 ++++++++++++++++++---------------
 Documentation/urls-remotes.adoc | 43 ++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 23 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1964%2Fjvns%2Fclarify-push-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1964/jvns/clarify-push-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1964

Range-diff vs v3:

 1:  2870c77e80 = 1:  d3160fb0af doc: git-push: clarify intro
 2:  3ecfb5c3a6 ! 2:  69825d4634 doc: add an UPSTREAM BRANCHES section to pull/push/fetch
     @@ Commit message
      
          Since the `git pull`, `git push`, and `git fetch` man pages already
          include sections on REMOTES and the syntax for URLs, add a section on
     -    UPSTREAM BRANCHES to `urls-remotes.adoc` and rename it to
     -    `urls-remotes-upstreams.adoc`. That's an awkward name but at least it's
     -    clear what's in the file.
     +    UPSTREAM BRANCHES to `urls-remotes.adoc`.
      
          In the new UPSTREAM BRANCHES section, cover the various ways that
          upstreams branches are automatically set in Git, since users may
     @@ Commit message
      
          A terminology note: Git uses two terms for this concept:
      
     -    - "tracking" as in "the current branch is _tracking_ some remote"
     +    - "tracking" as in "the tracking information for the 'foo' branch"
            or the `--track` option to `git branch`
          - "upstream" or "upstream branch", as in `git push --set-upstream`.
            This term is also used in the `git rebase` man page to refer to the
     @@ Commit message
      
       ## Documentation/urls-remotes.adoc ##
      @@ Documentation/urls-remotes.adoc: git push uses:
     - 	HEAD:refs/heads/<head>
       ------------
       
     --
     + 
      -
      -
      +UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
     @@ Documentation/urls-remotes.adoc: git push uses:
      +Branches in Git can optionally have an upstream remote branch.
      +Git defaults to using the upstream branch for remote operations, for example:
      +
     -+* It's the default for `git pull` or `git fetch` with no arguments
     ++* It's the default for `git pull` or `git fetch` with no arguments.
      +* It's the default for `git push` with no arguments, with some exceptions.
      +  For example, you can use the `branch.<name>.pushRemote` option to push
      +  to a different remote than you pull from, and by default with
     @@ Documentation/urls-remotes.adoc: git push uses:
      +  show you how many commits have been added to your current branch and
      +  the upstream since you forked from it, for example "Your branch and
      +  'origin/main' have diverged, and have 2 and 3 different commits each
     -+  respectively"
     ++  respectively".
      +
      +The upstream is stored in `.git/config`, in the "remote" and "merge"
      +fields. For example, if `main`'s upstream is `origin/main`:
 3:  bfd6072983 ! 3:  244c35ef2b doc: git-push: clarify "where to push"
     @@ Metadata
       ## Commit message ##
          doc: git-push: clarify "where to push"
      
     -    Be clearer about what we're describing ("which repository" instead of
     -    "where to push"), and start with a positive "try X, then Y, then Z"
     -    instead of a negative ("if X is not specified..").
     +    It's not obvious that "`branch.*.remote` configuration"` refers to the
     +    upstream, so say "upstream" instead.
     +
     +    The sentence is also quite hard to parse right now, use "defaults to" to
     +    simplify it.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-push.adoc: Updates one or more branches, tags, or other refere
      -`<repository>` argument, `branch.*.remote` configuration for the
      -current branch is consulted to determine where to push.  If the
      -configuration is missing, it defaults to 'origin'.
     -+To decide which repository to push to, Git uses the `<repository>`
     -+argument (for example `git push dev`), then if that's not specified the
     -+upstream configuration for the current branch, and then defaults
     -+to `origin`.
     ++The `<repository>` argument defaults to the upstream for the current branch,
     ++or `origin` if there's no configured upstream.
       
       When the command line does not specify what to push with `<refspec>...`
       arguments or `--all`, `--mirror`, `--tags` options, the command finds
 4:  be6453d010 ! 4:  c1d4ea8d27 doc: git-push: clarify "what to push"
     @@ Commit message
          * not understanding what the term "upstream" means in Git
            ("are branches tracked by some system besides their names?"")
      
     -    Address all of these by using a numbered "in order of precedence" list
     -    (similar to the previous commit), by giving a little bit of context
     -    around "upstream branch": it's something that you may have to set
     -    explicitly, and referring to the new UPSTREAM BRANCHES section.
     +    Also, the current explanation of `push.default=simple` ("the
     +    current branch is pushed to the corresponding upstream branch, but
     +    as a safety measure, the push is aborted if the upstream branch
     +    does not have the same  name as the local one.") is not accurate:
     +    `push.default=simple` does not always require you to set a corresponding
     +    upstream branch.
     +
     +    Address all of these by
     +
     +    * using a numbered "in order of precedence" list
     +    * giving a more accurate explanation of how `push.default=simple` works
     +    * giving a little bit of context around "upstream branch": it's
     +      something that you may have to set explicitly
     +    * referring to the new UPSTREAM BRANCHES section
      
          The default behaviour is still discussed pretty late but it should be
          easier to skim now to get to the relevant information.
      
     +    In "`git push` may fail if...",  I'm intentionally being vague about
     +    what exactly `git push` does, because (as discussed on the mailing list)
     +    the behaviour of `push.default=simple` is very confusing, perhaps broken,
     +    and certainly not worth trying to explain in an introductory context.
     +    `push.default.simple` sometimes requires you to set an upstream and
     +    sometimes doesn't and the exact conditions under which it does/doesn't
     +    are hard to describe.
     +
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-push.adoc ##
     -@@ Documentation/git-push.adoc: argument (for example `git push dev`), then if that's not specified the
     - upstream configuration for the current branch, and then defaults
     - to `origin`.
     +@@ Documentation/git-push.adoc: that isn't already on the remote.
     + The `<repository>` argument defaults to the upstream for the current branch,
     + or `origin` if there's no configured upstream.
       
      -When the command line does not specify what to push with `<refspec>...`
      -arguments or `--all`, `--mirror`, `--tags` options, the command finds
     @@ Documentation/git-push.adoc: argument (for example `git push dev`), then if that
      +2. The `remote.*.push` configuration for the repository being pushed to
      +3. The `push.default` configuration. The default is `push.default=simple`,
      +   which will push to a branch with the same name as the current branch.
     -+   See the CONFIGURATION section below for more on `push.default`.
     ++   See the <<CONFIGURATION,CONFIGURATION>> section below for more on `push.default`.
      +
     -+As a safety measure, `git push` may fail if you haven't set an upstream
     -+for the current branch, depending on what `push.default` is set to.
     -+See the UPSTREAM BRANCHES section below for more on how to set and
     -+use upstreams.
     ++`git push` may fail if you haven't set an upstream for the current branch,
     ++depending on what `push.default` is set to.
     ++See the <<UPSTREAM-BRANCHES,UPSTREAM BRANCHES>> section below for more
     ++on how to set and use upstreams.
       
       You can make interesting things happen to a repository
       every time you push into it, by setting up 'hooks' there.  See
     +@@ Documentation/git-push.adoc: a `git gc` command on the origin repository.
     + 
     + include::transfer-data-leaks.adoc[]
     + 
     +-CONFIGURATION
     ++CONFIGURATION[[CONFIGURATION]]
     + -------------
     + 
     + include::includes/cmd-config-section-all.adoc[]
 -:  ---------- > 5:  9435f0ce8d doc: git-push: Add explanation of `git push origin main`

-- 
gitgitgadget
