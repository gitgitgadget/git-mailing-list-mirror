Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D252342C85
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636375; cv=none; b=LBJrUs6DU4ABaLEUhuura6lE5XIbIgBXy1XYlPVg3WYbpMntrPAaxDpRf+DtJjsKQ9GxGjKJfAtOXkfYx62NmKO7XddQObbj6J0O7jSl3KZ51mnlfbWOj34XrVtQSQK2ZGxn6t45eEWogMlWtXsAQxU4YxeBKZB4fGfEDPJb/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636375; c=relaxed/simple;
	bh=RQXFf52VsylZthZhGE59W/ZK9Ikv+oJGlaYMS7bMQJ8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K6Jr9O3qmDqZt6sZBDU7+UcIcv/1Av/8OIV7qLqFIz1z+Y59gqQVL3HAjviiJq/k4qrycdobv8uDH3qRrPjAJvUQ/6e6a7DU6AEmmRktmqyaIAdS7VmXfJvoJfHsGBwj2kuJOceCFw8Q68c2Qse7r6STynOTqC4um2tBLS5Yh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeDKJJtu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeDKJJtu"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so3816232f8f.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636372; x=1756241172; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwRs996w0wkBsitxH+FmTi+qgvT0AYK+BVWufduFOLc=;
        b=XeDKJJtuBPAB7tj1XAOfSf8A4KKQ+24fWttGqSlnb4Wq0QitnrLHW3vBR7WPS0+kap
         HtKJOynD49JxPMF3oJ9qnrFql7QADVh9soos8GVrJGX8z28K/kfD0uUUcwvEljKYPVkS
         e+OcimZhIaApxRPz6Sw/OObC2pVw0lQYd03nOghLPQ1HemDNrY1LJO+6FepTrP0qCXLR
         /T/HNcEwroIjLxY9zPNy7ETpbFbxYxoodc2/jrGJY1OqXu8KuPe8mP2EbKGAAGHKf0s+
         0Z7bC9rY5Y/vNIagmT/BLFk1jgClnGkkGmtKX2sOV94/NFnjw5cHx+adJGj2gKPcjr5D
         G1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636372; x=1756241172;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwRs996w0wkBsitxH+FmTi+qgvT0AYK+BVWufduFOLc=;
        b=aU4aQZ0CJHvW8T8P7TKtYInsKNWRO2Ui+0XilUYDmRqdPsCcSFXqne5FgHQgwYZqa/
         bBePjZDbD63bYRGWoomTZt2vbPQyDGQLVGp3DsVnYXGmCqEA988xPiKmGu7iOQmsoHUw
         6zzcBOslX+cWZdwmcgtKSIBZF4zAu5ecDgDHRRW3+DtDeiAy8Ul5+Mmy3nprfOqdlyd7
         S/dewX2Ls83xeoX9qBDtzoWKj/uVOK4VXHRy7aDMJWoAkU7LsPdnMfmBTPG3GMXwih56
         t8qOGUJAT3++yTYeggsvVRiPjXaBUeQcHGczvmyXARaNKBgXfHhyvi1H6g+GzPuFFWCl
         ySiQ==
X-Gm-Message-State: AOJu0Yyk7bmKUKH2Jd7otSCzWW+h++s5p/r7RvqMRWUqq90scMvanNgM
	mKom09sC8dfURF9Un43U+f1OSb/r5j2v7Fb5CDEmE/a6D3zITQcilVfB9PdSBjxq
X-Gm-Gg: ASbGncsAklFbwvpSS8xAMOVGaTksc1HS9w28YJnQ1/656f/9SK4/V6K4YUd9U/Lb7C+
	czjfMnWSS8AwIAr8d6wcjAYdDQpW7Zrl7bgDKR0FVwFhXJ61SyatdhiZ3H+xCuaMO2eWd9ogfyJ
	s18swbXFUCrPMTPULXjQIucxtIPHcJjszzSn7ChjQlrwKu2694dKhfAoUQrbC+r4TB5iXfSZ/BA
	kkYoDyAwsjapLvDbeqPlgCt66ocnFuJX4B5ZpVXlcarLzQITdf4A2TP6WQKrF45whNl2Rr/2HQB
	R1mdCGeXA5c9rY/qQX2g/BjTcRlLRrNrClUhAjc/2FgKCgw2a54Hh5hh3pjeVlJIKGaNCUgWmOp
	mKflRf5PmmmiGHZh9++QFeiPYVJVgeZf0Nw==
X-Google-Smtp-Source: AGHT+IFtiaHT0B/m+/zqZO9DpYf109qSse/+xRoVzz/+YbaCR6d7wmwlIyJvIVQORt0vmORiaV66KA==
X-Received: by 2002:a05:6000:40cc:b0:3c0:2f7c:faae with SMTP id ffacd0b85a97d-3c32d59d75bmr269156f8f.12.1755636371648;
        Tue, 19 Aug 2025 13:46:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c07487a009sm4938266f8f.11.2025.08.19.13.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:46:11 -0700 (PDT)
Message-Id: <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Aug 2025 20:46:07 +0000
Subject: [PATCH v3 0/3] doc: git-add: clarify DESCRIPTION section
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
Cc: Chris Torek <chris.torek@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>

 * Emphasize "contents" more than "files" in the introduction
 * Delete the terminology note, and just keep a single parenthetical "(also
   known as "staging area")"
 * Be more explicit about what "By default" means
 * Don't mention git diff --cached, mentioning more and more related
   commands felt like it was starting to get messy (what about git diff?
   what about git reset? what about git rm?).
 * Leave the "This command can be performed multiple times before a
   commit"... paragraph alone since the only 2 users who commented on it
   said it was clear and helpful already.
 * Move "Please see linkgit:git-commit[1].." back to the end, where it used
   to be

Julia Evans (2):
  doc: git-add: clarify intro & add an example
  doc: git-add: simplify discussion of ignored files

Junio C Hamano (1):
  Git 2.51

 Documentation/git-add.adoc | 34 ++++++++++++++++------------------
 GIT-VERSION-GEN            |  2 +-
 2 files changed, 17 insertions(+), 19 deletions(-)


base-commit: e5ab6b3e5a3f0a94a429526e0fe6f491955ac053
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1952%2Fjvns%2Fclarify-add-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1952/jvns/clarify-add-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1952

Range-diff vs v2:

 -:  ----------- > 1:  c44beea485f Git 2.51
 1:  d041d09589b ! 2:  080720c0599 doc: git-add: start man page with an example
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    doc: git-add: start man page with an example
     +    doc: git-add: clarify intro & add an example
      
     -    - Replace the intro paragraph of the `git-add` man page with an
     -      example to try to clarify it for new users. The goal here is use less
     -      jargon but communicate essentially the same information.
     -    - Give an example of how to add only part of the changes to the file
     -    - Remove the snapshot-based explanation of the index and replace it with
     -      a diff-based explanation because I don't feel that it's useful in this
     -      context to emphasize  that git uses a snapshot-based model: the main
     -      way most git users interact with the index is through `git diff` or
     -      `git status`, which is a completely diff-based view of the index.
     +    - Add a basic example of how "git add" is normally used
     +    - It's not technically true that you *must* use the `add` command to
     +      add changes before running `git commit`, because `git commit -a`
     +      exists. Instead say that you *can* use the `add` command.
     +    - Mention early on that "index" is another word for "staging area",
     +      since Git very rarely uses the word "index" in its output
     +      (`git status`) uses the term "staged", and many Git users are
     +      unfamiliar with the term "index"
     +    - Remove "It typically adds" (it's not clear what "typically" means),
     +      and instead mention that `git add -p` can be used to add
     +      partial contents
     +    - Currently the introduction is somewhat repetitive ("to prepare the
     +      content staged for the next commit" ... "this snapshot that is taken
     +      as the contents of the next commit."), replace with a single sentence
     +      ("The "index" [...] is where Git stores the contents of the next
     +      commit.")
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-add.adoc ##
     -@@ Documentation/git-add.adoc: git-add(1)
     - 
     - NAME
     - ----
     --git-add - Add file contents to the index
     -+git-add - Add new or changed files to the index
     - 
     - SYNOPSIS
     - --------
      @@ Documentation/git-add.adoc: git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [-
       
       DESCRIPTION
     @@ Documentation/git-add.adoc: git add [--verbose | -v] [--dry-run | -n] [--force |
      -after making any changes to the working tree, and before running
      -the commit command, you must use the `add` command to add any new or
      -modified files to the index.
     -+Add new or changed files to the index to prepare for a commit. The
     -+"index" (also known as "staging area") is where Git stores the changes
     -+that will be in the next commit.
     ++Add contents of new or changed files to the index. The "index" (also
     ++known as "staging area") is where Git stores the contents of the next
     ++commit.
      +
     -+By default, `git commit` only commits changes that you've added to the
     -+index. For example, if you've edited `file.c` and want to commit your
     -+changes, you can run:
     ++When you run `git commit` without any other arguments, it will only
     ++commit staged changes. For example, if you've edited `file.c` and want
     ++to commit your changes to that file, you can run:
      +
      +   git add file.c
      +   git commit
      +
      +You can also add only part of your changes to a file with `git add -p`.
     -+Please see linkgit:git-commit[1] for alternative ways to add content to
     -+a commit.
       
       This command can be performed multiple times before a commit.  It only
       adds the content of the specified file(s) at the time the add command is
     -@@ Documentation/git-add.adoc: directory recursion or filename globbing performed by Git (quote your
     - globs before the shell) will be silently ignored.  The `git add` command can
     - be used to add ignored files with the `-f` (force) option.
     - 
     --Please see linkgit:git-commit[1] for alternative ways to add content to a
     --commit.
     --
     --
     - OPTIONS
     - -------
     - `<pathspec>...`::
 2:  63c9e0361dc ! 3:  fc2ec305a9e doc: git-add: simplify discussion of ignored files
     @@ Commit message
      
          - Mention the --force option earlier
          - Remove the explanation of shell globbing vs git's internal glob
     -      system, it's a common gotcha but I don't think this is an appropriate
     -      place to explain that concept. There's some discussion of the gotchas
     -      around globbing and `git add` in the EXAMPLES section which I think
     -      is clearer.
     +      system, since users are confused by it and there's a clearer
     +      discussion in the EXAMPLES section.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-add.adoc: you must run `git add` again to add the new content
      -directory recursion or filename globbing performed by Git (quote your
      -globs before the shell) will be silently ignored.  The `git add` command can
      -be used to add ignored files with the `-f` (force) option.
     -+`git add` will not add ignored files by default. You can use the
     -+`--force` option to add ignored files. If you explicitly specify the
     -+exact filename of an ignored file (e.g. `git add ignored.txt`), `git
     -+add` will fail with a list of ignored files. Otherwise it will silently
     -+ignore the file.
     ++The `git add` command will not add ignored files by default. You can
     ++use the `--force` option to add ignored files. If you specify the exact
     ++filename of an ignored file, `git add` will fail with a list of ignored
     ++files. Otherwise it will silently ignore the file.
       
     - OPTIONS
     - -------
     + Please see linkgit:git-commit[1] for alternative ways to add content to a
     + commit.
 3:  ce1eafb0286 < -:  ----------- doc: git-add: make explanation less dry
 4:  9e595f9ad59 < -:  ----------- doc: git-add: explain inconsistent terminology

-- 
gitgitgadget
