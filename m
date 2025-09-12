Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE813009F0
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703314; cv=none; b=BmeMsn0XsfjJNDUloDN/mMqbo+qha4g7cuU9IYJJCI7U0hRGfdcTbGpB2cNyelkvMrBe6FnJuRU6Onyd++gklDhTji6XPYkp/VZo+drDotR8xYZqXRwC8yHUyfJcI2bJMaiaTI/aRmJ+cIOwIewqjN61g0uq8V/5giWYdNQW32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703314; c=relaxed/simple;
	bh=SwIdjcXg14hEQjj3xqSjGeZGmm9eu4SoHMmGQ2onVcs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MYXfF8IXPZ3EH4+chSZJUEbIbHgKKHhjxLcPI71Ze7mTVhw5DwFUQ7Bj4QecRgo/IMZp3sODENZna2N9LSft4EO7b7K7MPUcLWQkPjXOZD1Ye57B4N8PgHs8D7vFQtAIw/qKjv03gJzOShJU76cbjbssVCP9FL5v9tksVjwokRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONPhEIk7; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONPhEIk7"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8876462a34aso81429039f.2
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757703311; x=1758308111; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptpdbNYwBIPmqa/imaEga1EtliTnR6uKLiSuuP7MF/k=;
        b=ONPhEIk7oej/uuiKLFAq3b9JhJ6ByShCYQQq5vV9fyYj4x83Yw0cTLhCMDcNPHsrD9
         E6K5RvDUVFGqzr3e0vfxg3KRW7NnETgaAXmzw94B5DvkV5BVCeAImUDnB+oknwSI4XIm
         IdyVfElrcn1KXHy2A6c/gKDxjTYdKzBYPZvZmQamXaDohfJf1KWLwmualvCdGvDbgIgH
         rZuzZaCM60rWdGnABS1tUAfIqJoNsMrEHI/ejjW6A/U9m3L5wPA1wgdFRhp4VaRMM1nl
         eCnYpb2AQVLe8/J05Ho2noreNomuJLpcSKwa9ktnygBgLc53BGiJUK5C5c6UknZVWat5
         S61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757703311; x=1758308111;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptpdbNYwBIPmqa/imaEga1EtliTnR6uKLiSuuP7MF/k=;
        b=hnZ7pWfelNSBGBKqpaD2NrWEH/cLNVxh1sJT9g17nZx7JHn4Gr6Tdc10e5tFjUYini
         oqvlYIQ4kEIz7NzBqfb2EPPCrFjHwQGY9ySwWRWOUeGo8K34dFt+/FMPEdjZ4UtnpyiW
         b7akiV2xe4cUGpobDU9wopS8Aks3jIHaJOKzuAPxypAd0lp0wdtkL/8qZ0YnHYv1P7ga
         O34lbCBl5t039BOPZXPkRKjw3L11OWbOZuxSapLepw1Q/mONcYS5jaaFvxIijhG8czwy
         O6xetYr/7wd9mCygnYcvEVhqvpk2W88zu3nNZ21eHtNL2oSNDfuqUAI7kEH2RIIS159L
         2yDw==
X-Gm-Message-State: AOJu0YxzaJ/yT/KkvpYSXXHQ0buRQwkemOMYigcD2lt/qG1tyntwQAua
	KgzyknGR1yAU0Q6bZwYLZBXyWKFRy+jO+P56RYzxUHMtOS5zMjFBWH7wxri6AQ==
X-Gm-Gg: ASbGncuEb8EuDkt5P6Q7KzhY7OanPqJKOEY73aKxCVKjjOEkgM5xrQNeTlEYaNrLKhw
	taQgm70sy0qBUlqwe3eMnAz+rQwEKp8CXBvb9j+VjSVnbGC9eVcxFnowlIqWhbtFlH18YP8hSae
	DBfVk2onhy+p56AzcujhAyaBscJv45oyQDcbVM8Szlyx1LgaKHh5ZPepYcTao/xtLvY/4vRDSxV
	TsAhjUD7ze9dDIRI1Ykfro+/makK+ek/mFotSrkNc4uihqbU9bkK0auUO4P/lhVQLrNA4Eidxxl
	g+bU9uUQNt1cQIfATZC6vPQMQRm6rZ0ff4AeEtgn/NgDPxaB/6dL47GJtyH+414HPO9/9Bwj5Nm
	H7Q2Y1E8QzQHoAhzDqgJCJG8KjDK7BhHftgkHYQ==
X-Google-Smtp-Source: AGHT+IFvie44yLe1Eie9fz4pJ/kf5imB97hscii5Ql7EnVFeF40Sqh4x83ztpMlPnQZIirtZTk2n3A==
X-Received: by 2002:a05:6e02:1fee:b0:3ec:d2db:9381 with SMTP id e9e14a558f8ab-4209e834243mr70304435ab.11.1757703311035;
        Fri, 12 Sep 2025 11:55:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.157.180])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f2f6a2d3sm1900011173.35.2025.09.12.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:55:10 -0700 (PDT)
Message-Id: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 18:55:05 +0000
Subject: [PATCH v2 0/4] doc: git-push: clarify DESCRIPTION section & refspec definition
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

The rewrite of the <refspec> section is more invasive than I usually prefer:
I've tried to keep as much of the original text as possible, but if there
are too many issues with it then I'll drop that patch from this series.

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

Julia Evans (4):
  doc: git-push: clarify intro
  doc: add an UPSTREAM BRANCHES section to pull/push/fetch
  doc: git-push: clarify "where to push"
  doc: git-push: clarify "what to push"

 Documentation/git-fetch.adoc                  |  2 +-
 Documentation/git-pull.adoc                   |  2 +-
 Documentation/git-push.adoc                   | 43 ++++++++++---------
 ...motes.adoc => urls-remotes-upstreams.adoc} | 41 ++++++++++++++++--
 4 files changed, 62 insertions(+), 26 deletions(-)
 rename Documentation/{urls-remotes.adoc => urls-remotes-upstreams.adoc} (63%)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1964%2Fjvns%2Fclarify-push-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1964/jvns/clarify-push-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1964

Range-diff vs v1:

 1:  2fa98fb5ca ! 1:  270edd2b00 doc: git-push: update intro
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    doc: git-push: update intro
     +    doc: git-push: clarify intro
      
     -    - Users don't understand what a "ref" is, expand it
     -    - Remove "complete the given refs" (that phrase is confusing to many
     -      users, and it's obvious that pushing a branch involves sending the
     -      new code)
     -    - Move down the reference to hooks, it's less important than the
     -      command's basic usage
     +    From user feedback, 5 users are unsure what "ref" and/or "objects" means
     +    in this context. 3 users said they don't know what "complete the refs"
     +    means.
     +
     +    Many users also commented that receive hooks do not seem like the most
     +    important thing to know about `git push`, and that this information
     +    should not be the second sentence in the man page.
     +
     +    Use more familiar language to make it more accessible to users who do
     +    not know what a "ref" is and move the "hooks" comment to the end.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
 -:  ---------- > 2:  0ec629d403 doc: add an UPSTREAM BRANCHES section to pull/push/fetch
 2:  36112c30bc ! 3:  374740c678 doc: git-push: clarify "where to push"
     @@ Metadata
       ## Commit message ##
          doc: git-push: clarify "where to push"
      
     -    Signed-off-by: Julia Evans <julia@jvns.ca>
     -
          Be clearer about what we're describing ("which repository" instead of
          "what to push"), and start with a positive "try X, then Y, then Z"
          instead of a negative ("if X is not specified..").
     @@ Documentation/git-push.adoc: DESCRIPTION
      -configuration is missing, it defaults to 'origin'.
      +To decide which repository to push to, Git uses the `<repository>`
      +argument (for example `git push dev`), then if that's not specified the
     -+`branch.*.remote` configuration for the current branch, and then defaults
     ++upstream configuration for the current branch, and then defaults
      +to `origin`.
       
       When the command line does not specify what to push with `<refspec>...`
 3:  ac554cbe75 ! 4:  59732f1e47 doc: git-push: clarify "what to push"
     @@ Metadata
       ## Commit message ##
          doc: git-push: clarify "what to push"
      
     -    - Be more explicit about what we're describing ("which branches" instead
     -      of "what to push")
     -    - Split out the ways to specify which branches into a numbered list,
     -      since there are 5 different ways to specify it and it's a lot to parse
     -      in paragraph form
     -    - The explanation of "push.default=simple" is confusing to some users,
     -      use an explanation more similar to the one in `man git-config`
     -    - Mention the most common case where push.default=simple is likely to
     -      fail, and how to handle it
     +    From user feedback: 6 users says they found the "what to push"
     +    paragraphs confusing, for many different reasons, including:
     +
     +    * what does "..." in <refspec>... mean?
     +    * "consult XXX configuration" is hard to parse
     +    * it refers to the `git-config` man page even though the config
     +      information for `git push` is included in this man page under
     +      CONFIGURATION
     +    * the default ("push to a branch with the same name") is what they use
     +      99% of the time, they would have expected it to appear earlier instead
     +      of at the very end
     +    * not understanding what the term "upstream" means in Git
     +      ("are branches tracked by some system besides their names?"")
     +
     +    Address all of these by using a numbered "in order of precedence" list
     +    (similar to the previous commit), by giving a little bit of context
     +    around "upstream branch": it's something that you may have to set
     +    explicitly, and referring to the new UPSTREAM BRANCHES section.
     +
     +    The default behaviour is still discussed pretty late but it should be
     +    easier to skim now to get to the relevant information.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-push.adoc ##
      @@ Documentation/git-push.adoc: argument (for example `git push dev`), then if that's not specified the
     - `branch.*.remote` configuration for the current branch, and then defaults
     + upstream configuration for the current branch, and then defaults
       to `origin`.
       
      -When the command line does not specify what to push with `<refspec>...`
     @@ Documentation/git-push.adoc: argument (for example `git push dev`), then if that
      -the default `<refspec>` by consulting `remote.*.push` configuration,
      -and if it is not found, honors `push.default` configuration to decide
      -what to push (See linkgit:git-config[1] for the meaning of `push.default`).
     -+To decide which branches, tags, or other refs to push, Git uses
     -+(in order of precedence):
     -+
     -+1. The <refspec> argument(s) (for example `main` in `git push origin main`)
     -+   or the `--all`, `--mirror`, or `--tags` options
     -+2. The `remote.*.push` configuration for the current branch
     -+3. The `push.default` configuration (See linkgit:git-config[1] for
     -+   the meaning of `push.default`).
     - 
     - When neither the command-line nor the configuration specifies what to
     +-
     +-When neither the command-line nor the configuration specifies what to
      -push, the default behavior is used, which corresponds to the `simple`
      -value for `push.default`: the current branch is pushed to the
      -corresponding upstream branch, but as a safety measure, the push is
      -aborted if the upstream branch does not have the same name as the
      -local one.
     -+push, the current branch is pushed to the branch with the same name
     -+on the remote. The current branch must have a configured upstream with
     -+the same name, so this will fail when pushing a new branch.
     -+You can run `git push -u <repository> <current-branch>`
     -+to configure the upstream.
     ++To decide which branches, tags, or other refs to push, Git uses
     ++(in order of precedence):
     ++
     ++1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
     ++   or the `--all`, `--mirror`, or `--tags` options
     ++2. The `remote.*.push` configuration for the repository being pushed to
     ++3. The `push.default` configuration. The default is `push.default=simple`,
     ++   which will push to a branch with the same name as the current branch.
     ++   See the CONFIGURATION section below for more on `push.default`.
     ++
     ++As a safety measure, `git push` may fail if you haven't set an upstream
     ++for the current branch, depending on what `push.default` is set to.
     ++See the UPSTREAM BRANCHES section below for more on how to set and
     ++use upstreams.
       
       You can make interesting things happen to a repository
       every time you push into it, by setting up 'hooks' there.  See
 4:  72114133aa < -:  ---------- doc: git-push: rewrite refspec specification

-- 
gitgitgadget
