Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B930F555
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351150; cv=none; b=Ba29p+FrK7C58XxQelY6yVM7SPfK7+1DWnMEAogvbTQvVkKtr1ullBbotk7euzWME4SoNw0jAJ1fdpOYqd+dNGkhaT6cQ/Gj6JqUWDAdJFWNQugTNh0U/KdyPCjELsSSQ4kczUAXYbbUzAvyyDSl4qlcoRx+Sxxl6muduuitVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351150; c=relaxed/simple;
	bh=bx4zbV+/zbuLKojN3cIhCKY6w4K9a80otYvqZ/xOptQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=RJEEFAdqLXz5SVc+aBFXrPHtt6Li6E/4zWTZTkjrneNi6J7Lq95C2OdqoBaf5WdlapKLAI/DcvOxpz9YrF16Hse3Bqz2cfdDHci8Ae9j2TZ826mHfDtevumXqQmHJVpMlgiZpAb6+qxzl2aCvzNUz5gY0BumgrmbpCGQN4saOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkWrWu43; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkWrWu43"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b8397e3e09so2182703eec.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 20:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770351149; x=1770955949; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuAAyabzPVCJGMyLCYA+3MC5tuGIytu7EcZgkpqc1go=;
        b=KkWrWu43LTh/5lsGMl+oJcVfY5092V3hS0CR81A5SSliALrnW05PgP9gb6iQbgg0mH
         bM/9uBniYr+EjiZFCH5dVEYqeyQ4hWHkb9o7lWEabUqHLxCHL2JtnyYY4KXFsm20qc0C
         nWKeISQGAfUjkZoP1HFIKOS+ge2YzOp6VlMGKU0uX0eF5m950Dpxb4ePVBSXYUfcPrbQ
         x9LfSzi/YXmybGvnF3QzX60eywSDgwDOJXxEr9yh+ORezy8bJzp/VF0ZVkzB1GeXDmOV
         tV43yG6P/aPdFOXfmgJBcbTa6t5uRE52chsJyIowICwzwqTGY3BP2r5nH0Lq8l5qYgUL
         I7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351149; x=1770955949;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vuAAyabzPVCJGMyLCYA+3MC5tuGIytu7EcZgkpqc1go=;
        b=I1PONQ/pW68op29dxZ14WD3TYVZfgS6Z1bkcWFIr44DBSPqhhJIDRUskJmXa0YzE/j
         Up4BwrkZPRWOBjZq9R4unBWYStU5J6PWIrhqD4d6UfNTRVJkCbeYy3Kuy1ASxmr75KRH
         AGGkvOpSQggVBlw2G44G0SL7DbJnW+uao840zHS1VIv4DukuMFaAtmt5Vea20+Aajv7h
         qrzls8G2yEZQkzJt1ptBbhDbQFiF9H8NgNcnrrB3VUI/cGgv+FUAL8QjlFmiUNEmk2qF
         AlVtdktK6c/UWordeJmHMw3JLTf4JpEQzBeZQxghLE2Dc76hUYjvddkIggaHQLIZayRe
         uSQQ==
X-Gm-Message-State: AOJu0Yx3jt4cMAe+Ecywz1tk+Tx99ftA1c+pkbNtbpPDZWPUT3+7LUy9
	1ZqJDuZVpxtfVuoi1NacPuOgwKiea/6ZLM4ZqDYyQbxZ7/nw+D487Gye7iTwmA==
X-Gm-Gg: AZuq6aJmh/0vherp/zENESDkydqS/HvXyZOtndxhZTtopiWI812K3aoqEsq8QIuWEvK
	kD0H3VTUqS8xJaMMQii1J9BKM6rWhUYuDj37BzOyZTPcOqxQSIDZ+BUpFecbEqWESxz8ylrnZIS
	vCuwGvLT/NS534ucjYQozjrLT8i3peQe9YO13Fr1gC86Jl4PvJeWdmjprHiuiNDtyKA8RqNPjrT
	CPQOYnY8reG82wqcJubPUPfuIoXmsRQ1Acq45flpTNY18prYu0uVIQiwVJMlefyIFSePSmNqy/J
	S6eu2YJpDAm1qaQb18uWvQr/cm5ozIFVIULU/Eivi1/8w5QChCcrNiRERMmXpJPrDCjr/u9wubC
	Qu2nfSC1VxJj4/eZqaQCiLEqU/uVYW/VpI78PSNOvGwJ249cskNjRkiPlt8KCED7Aj2n5YXMqds
	ZZ8BilsFjwXSU=
X-Received: by 2002:a05:7301:1293:b0:2b4:7c92:3f7c with SMTP id 5a478bee46e88-2b85645ef66mr758479eec.6.1770351148596;
        Thu, 05 Feb 2026 20:12:28 -0800 (PST)
Received: from [127.0.0.1] ([52.225.25.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041d9a67sm1111898c88.4.2026.02.05.20.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 20:12:27 -0800 (PST)
Message-Id: <pull.2036.v4.git.1770351146.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
References: <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 04:12:22 +0000
Subject: [PATCH v4 0/4] doc: some more synopsis conversions and fixes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This time, git-show and git-submodule are converted. Some mistakes on
previous work were also spotted and fixed.

Changes since V1:

 * fix mistakes spotted by Kristoffer Haugsbakk Changes since V2:
 * more fixes Changes since V3:
 * again more fixes, origin and HEAD

Jean-Noël Avila (4):
  doc: convert git-submodule to synopsis style
  doc: finalize git-clone documentation conversion to synopsis style
  doc: fix some style issues in git-clone and for-each-ref-options
  doc: convert git-show to synopsis style

 Documentation/asciidoc.conf.in          |   6 +
 Documentation/for-each-ref-options.adoc |   4 +-
 Documentation/git-clone.adoc            |  54 ++--
 Documentation/git-show.adoc             |  16 +-
 Documentation/git-submodule.adoc        | 395 ++++++++++++------------
 Documentation/pretty-formats.adoc       | 169 +++++-----
 Documentation/ref-storage-format.adoc   |   4 +-
 7 files changed, 341 insertions(+), 307 deletions(-)


base-commit: d8af7cadaa79d5837d73ec949e10b57dedb43e9b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2036%2Fjnavila%2Fgit_submodule-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2036/jnavila/git_submodule-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2036

Range-diff vs v3:

 1:  8d22e6952a ! 1:  7798802b59 doc: convert git-submodule to synopsis style
     @@ Commit message
           * convert inline lists into proper definition lists
           * minor formatting fixes
      
     -    Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
          Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
     +    Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/git-submodule.adoc ##
      @@ Documentation/git-submodule.adoc: git-submodule - Initialize, update or inspect submodules
     @@ Documentation/git-submodule.adoc: COMMANDS
       have to use `../foo.git` instead of `./foo.git` - as one might expect
       when following the rules for relative URLs - because the evaluation
       of relative URLs in Git is identical to that of relative directories).
     -@@ Documentation/git-submodule.adoc: If the superproject doesn't have a default remote configured
     + +
     + The default remote is the remote of the remote-tracking branch
     + of the current branch. If no such remote-tracking branch exists or
     +-the HEAD is detached, "origin" is assumed to be the default remote.
     ++the `HEAD` is detached, `origin` is assumed to be the default remote.
     + If the superproject doesn't have a default remote configured
       the superproject is its own authoritative upstream and the current
       working directory is used instead.
       +
     @@ Documentation/git-submodule.adoc: URL in `.gitmodules`.
       	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule is
       	not initialized, `+` if the currently checked out submodule commit
       	does not match the SHA-1 found in the index of the containing
     -@@ Documentation/git-submodule.adoc: submodules with respect to the commit recorded in the index or the HEAD,
     +@@ Documentation/git-submodule.adoc: If `--recursive` is specified, this command will recurse into nested
     + submodules, and show their status as well.
     + +
     + If you are only interested in changes of the currently initialized
     +-submodules with respect to the commit recorded in the index or the HEAD,
     ++submodules with respect to the commit recorded in the index or the `HEAD`,
       linkgit:git-status[1] and linkgit:git-diff[1] will provide that information
       too (and can also report changes to a submodule's work tree).
       
     @@ Documentation/git-submodule.adoc: in submodules and updating the working tree of
      -	checkout;; the commit recorded in the superproject will be
      -	    checked out in the submodule on a detached HEAD.
      +`checkout`;; the commit recorded in the superproject will be
     -+checked out in the submodule on a detached HEAD.
     ++checked out in the submodule on a detached `HEAD`.
       +
       If `--force` is specified, the submodule will be checked out (using
       `git checkout --force`), even if the commit specified
     @@ Documentation/git-submodule.adoc: to distribute the default upstream branch with
      -	superproject. If this option is given, the submodule's HEAD will not
      +`--rebase`::
      +	Rebase the current branch onto the commit recorded in the superproject.
     -+	This option is only valid for the update command. The submodule's HEAD will not
     ++	This option is only valid for the `update` command. The submodule's `HEAD` will not
       	be detached. If a merge failure prevents this process, you will have
       	to resolve these failures with linkgit:git-rebase[1].
      -	If the key `submodule.$name.update` is set to `rebase`, this option is
     @@ Documentation/git-submodule.adoc: to distribute the default upstream branch with
      ---name::
      -	This option is only valid for the add command. It sets the submodule's
      -	name to the given string instead of defaulting to its path. The name
     +-	must be valid as a directory name and may not end with a '/'.
      +`--name=<name>`::
      +	Set the submodule's name to the given string instead of defaulting to its path. _<name>_
     - 	must be valid as a directory name and may not end with a '/'.
     ++	must be valid as a directory name and may not end with a `/`.
       
      ---reference <repository>::
      -	This option is only valid for add and update commands.  These
 2:  5fd9f6d41a ! 2:  41aefe8147 doc: finalize git-clone documentation conversion to synopsis style
     @@ Commit message
      
          Use backticks where appropriate for command-line options
      
     -    Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
          Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
     +    Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/git-clone.adoc ##
      @@ Documentation/git-clone.adoc: objects from the source repository into a pack in the cloned repository.
 3:  d097065303 ! 3:  fe928fe0ed doc: fix some style issues in git-clone and for-each-ref-options
     @@ Commit message
           * Use asciidoc NOTE macro
           * fix markups
      
     -    Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
          Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
     +    Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/for-each-ref-options.adoc ##
      @@ Documentation/for-each-ref-options.adoc: TAB %(refname)`.
 4:  d179137d81 ! 4:  6a2b94e720 doc: convert git-show to synopsis style
     @@ Commit message
           * use _<placeholder>_ for arguments
           * minor formatting fixes
      
     -    Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
          Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
     +    Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/asciidoc.conf.in ##
      @@ Documentation/asciidoc.conf.in: endif::backend-xhtml11[]

-- 
gitgitgadget
