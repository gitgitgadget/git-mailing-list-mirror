Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39218FC9D
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785774; cv=none; b=ijwr+MGZZsO6x9fYryZmvgSru2Q5sdoDdH4OT1uth/U+TG1XayVGq2W9OkWCzBcwZivpP/TA7ia7TI47FEu8RO0TuDc3EKlv0Wzi125zTfJmvrY1j7fwH+0dWeCzJx/YdkWPpjkgOLgXIaJQ/uKs4Ate9MtiSt7IOUTXSnQS3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785774; c=relaxed/simple;
	bh=f9/ZTqNuzfgrZMl3PB450KwG4ETU4PCeZ07C/4ad5UA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=DBOAwwCimxbwUEYcLmL1B+nxh2DqmFT/HlP28gmmUz+kFz1bmP38M/6r9ihFevxxVRHeJ21Mn6GoVJEiSwWZVCidn4UmqrXDeKnMnTttmqGRXs9nvSU3gnpz0MCfqc+X1tl9h/XvsUNzAEYa5SdE0+EBNhrzw1Q0s8etqMux9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9gc06//; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9gc06//"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43169902057so24223795e9.0
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 11:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731785771; x=1732390571; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01ooXZz2jBW4EzxAEXx1zPXUmeQ6Bjza8YgkPYXx8LE=;
        b=K9gc06//Ug6c4hmvXw1axgqGLewz5Iw/9KJBY+tLVeKWY46WReu5gaBsbMRkMOvmpi
         Wutn6QWTxKRU9pOA9mdqbC9ciSRkIWG9JmUGWqamMUj7dvoHX2WdYzMg8rwwkXkgZ5c4
         0CB4zi8p6EleBbxKr98tlcfnn7YQuo7XN/X9S4Icwlp5GQexbvf+59ztGNlJJIOxYlHa
         kGxWfHhWyUw2tRTxRWF/wzh6R4qS+kVABKzSRtnpANdwvNNHIHjWw4M6bF+a2JbSUsES
         6jwT1USFIsnPYcoPxn87/xXVV3DUghqCP+WlBGNW5TTOk2HAgD/NdFsxMcYSqIWOS/VO
         ysFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731785771; x=1732390571;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01ooXZz2jBW4EzxAEXx1zPXUmeQ6Bjza8YgkPYXx8LE=;
        b=V6fz+B1X+gPghlGV3mp9Dow+FZYudVOT0X63wWhptFS1HaYjm4rJjYxIOjI/E1uSMa
         7ySSo1umH31HtFMdN5wRz9UMGA6ZCX+xKzGqi46mR/EY7tfZpfqvRY0W4DqUV1BVTHiY
         sUjS9tHfAYKLApJTqjWh7T8MS9UQQ9A6wZ9wpp6Z2bbrbZBMzdgYI5HIqvk/mHBqx2Df
         tzZodK+vEOE0I90xDpsAOC/3T8+DCaA1WgnOT1GpT2W1OYheRxsXUCNfnU/e4JLSCf5p
         cB26HGnupJUe1Hv2rqe96HInAgI8Ha7nl3z2p11G79gW4nW4N2WWxRB6un4sDrNI/Qio
         A7bA==
X-Gm-Message-State: AOJu0Yzh+NHnsu2Tg2BLHj9YyGcCEm+MjmZhwuGrz204CKGscuzGviFv
	pS+QxtZerdjpMs+ZNH+efdBzV8svXRglj/RTjfbJ1P6KAFR2kHUl5GMFzg==
X-Google-Smtp-Source: AGHT+IHQGY+z7EfNNctd8jMChRehGbIYS7qs2cqSib6BhKidSq7EvyVFOPHLGlj9RiGTkxL/iL8SRQ==
X-Received: by 2002:a05:600c:524a:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-432df791db1mr49192745e9.22.1731785770528;
        Sat, 16 Nov 2024 11:36:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3822a3ec6d4sm4363215f8f.96.2024.11.16.11.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 11:36:09 -0800 (PST)
Message-Id: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
References: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Nov 2024 19:36:03 +0000
Subject: [PATCH v3 0/5] doc: git diff reformatting
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This is the continuation of the editing of the manpages to reflect the new
formatting rules.

Changes since V1:

 * restate the formatting rules in the message of the first commit
 * fix typos
 * convert more parts to backticked
 * filter out most annoying self-referencing links
 * propose to separate with 'or' the -1 --ours options and the likes

Jean-Noël Avila (5):
  doc: git-diff: apply new documentation guidelines
  doc: git-diff: apply format changes to diff-options
  doc: git-diff: apply format changes to diff-format
  doc: git-diff: apply format changes to diff-generate-patch
  doc: git-diff: apply format changes to config part

 Documentation/config/diff.txt         | 204 +++++++------
 Documentation/diff-format.txt         |  42 +--
 Documentation/diff-generate-patch.txt |  44 +--
 Documentation/diff-options.txt        | 423 +++++++++++++-------------
 Documentation/git-diff.txt            | 108 +++----
 5 files changed, 424 insertions(+), 397 deletions(-)


base-commit: facbe4f633e4ad31e641f64617bc88074c659959
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1769%2Fjnavila%2Fgit_diff_new-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1769/jnavila/git_diff_new-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1769

Range-diff vs v2:

 1:  c104bd50b64 ! 1:  6841bd5825b doc: git-diff: apply new documentation guidelines
     @@ Metadata
       ## Commit message ##
          doc: git-diff: apply new documentation guidelines
      
     +    The documentation for git-diff has been updated to follow the new
     +    documentation guidelines. The following changes have been applied to
     +    the series of patches:
     +
     +    - switching the synopsis to a synopsis block which will automatically
     +      format placeholders in italics and keywords in monospace
     +    - use _<placeholder>_ instead of <placeholder> in the description
     +    - use `backticks for keywords and more complex option
     +    descriptions`. The new rendering engine will apply synopsis rules to
     +    these spans.
     +    - prevent git-diff from self-referencing itself via gitlink macro when
     +    the generated link would point to the same page.
     +
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/git-diff.txt ##
     @@ Documentation/git-diff.txt: OPTIONS
      --1 --base::
      --2 --ours::
      --3 --theirs::
     -+`-1` `--base`::
     -+`-2` `--ours`::
     -+`-3` `--theirs`::
     ++`-1`::
     ++`--base`::
     ++
     ++or `-2`::
     ++`--ours`::
     ++
     ++or `-3`::
     ++`--theirs`::
       	Compare the working tree with the "base" version (stage #1),
       	"our branch" (stage #2) or "their branch" (stage #3).  The
       	index contains these stages only for unmerged entries i.e.
     @@ Documentation/git-diff.txt: OPTIONS
       
      -<path>...::
      -	The <paths> parameters, when given, are used to limit
     -+_<path>_...::
     ++`<path>...`::
      +	The _<path>_ parameters, when given, are used to limit
       	the diff to the named paths (you can give directory
       	names and get diff for all files under them).
 2:  129763c2aae = 2:  07df397741b doc: git-diff: apply format changes to diff-options
 3:  8fec37ee174 = 3:  698628e076b doc: git-diff: apply format changes to diff-format
 4:  daed146639d = 4:  1154462f8be doc: git-diff: apply format changes to diff-generate-patch
 5:  17a2f028d59 ! 5:  4ec2fd9c3c6 doc: git-diff: apply format changes to config part
     @@ Metadata
       ## Commit message ##
          doc: git-diff: apply format changes to config part
      
     +    By the way, we also change the sentences where git-diff would refer to
     +    itself, so that no link is created in the HTML output.
     +
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/config/diff.txt ##
     @@ Documentation/config/diff.txt
       	Instead, silently run `git update-index --refresh` to
       	update the cached stat information for paths whose
       	contents in the work tree match the contents in the
     - 	index.  This option defaults to true.  Note that this
     +-	index.  This option defaults to true.  Note that this
      -	affects only 'git diff' Porcelain, and not lower level
      -	'diff' commands such as 'git diff-files'.
     ++	index.  This option defaults to `true`.  Note that this
      +	affects only `git diff` Porcelain, and not lower level
     -+	`diff` commands such as '`git diff-files`.
     ++	`diff` commands such as `git diff-files`.
       
      -diff.dirstat::
      +`diff.dirstat`::
     ++ifdef::git-diff[]
     ++	A comma separated list of `--dirstat` parameters specifying the
     ++	default behavior of the `--dirstat` option to `git diff` and friends.
     ++endif::git-diff[]
     ++ifndef::git-diff[]
       	A comma separated list of `--dirstat` parameters specifying the
       	default behavior of the `--dirstat` option to linkgit:git-diff[1]
     - 	and friends. The defaults can be overridden on the command line
     +-	and friends. The defaults can be overridden on the command line
      -	(using `--dirstat=<param1,param2,...>`). The fallback defaults
     ++	and friends.
     ++endif::git-diff[]
     ++	The defaults can be overridden on the command line
      +	(using `--dirstat=<param>,...`). The fallback defaults
       	(when not changed by `diff.dirstat`) are `changes,noncumulative,3`.
       	The following parameters are available:
     @@ Documentation/config/diff.txt: directories with less than 10% of the total amoun
       
      -diff.mnemonicPrefix::
      -	If set, 'git diff' uses a prefix pair that is different from the
     +-	standard "a/" and "b/" depending on what is being compared.  When
      +`diff.mnemonicPrefix`::
      +	If set, `git diff` uses a prefix pair that is different from the
     - 	standard "a/" and "b/" depending on what is being compared.  When
     ++	standard `a/` and `b/` depending on what is being compared.  When
       	this configuration is in effect, reverse diff output also swaps
       	the order of the prefixes:
     + `git diff`;;
      @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
       	 compares a (c)ommit and the (w)ork tree;
       `git diff --cached`;;
     @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
      -`git diff HEAD:file1 file2`;;
      +`git diff HEAD:<file1> <file2>`;;
       	compares an (o)bject and a (w)ork tree entity;
     - `git diff --no-index a b`;;
     - 	compares two non-git things (1) and (2).
     +-`git diff --no-index a b`;;
     +-	compares two non-git things (1) and (2).
     ++`git diff --no-index <a> <b>`;;
     ++	compares two non-git things _<a>_ and _<b>_.
       
      -diff.noPrefix::
      -	If set, 'git diff' does not show any source or destination prefix.
     @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
      -diff.srcPrefix::
      -	If set, 'git diff' uses this source prefix. Defaults to "a/".
      +`diff.srcPrefix`::
     -+	If set, `git diff` uses this source prefix. Defaults to "a/".
     ++	If set, `git diff` uses this source prefix. Defaults to `a/`.
       
      -diff.dstPrefix::
      -	If set, 'git diff' uses this destination prefix. Defaults to "b/".
      +`diff.dstPrefix`::
     -+	If set, `git diff` uses this destination prefix. Defaults to "b/".
     ++	If set, `git diff` uses this destination prefix. Defaults to `b/`.
       
      -diff.relative::
      -	If set to 'true', 'git diff' does not show changes outside of the directory
     @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
      +`diff.orderFile`::
       	File indicating how to order files within a diff.
      -	See the '-O' option to linkgit:git-diff[1] for details.
     ++ifdef::git-diff[]
     ++	See the `-O` option for details.
     ++endif::git-diff[]
     ++ifndef::git-diff[]
      +	See the `-O` option to linkgit:git-diff[1] for details.
     ++endif::git-diff[]
       	If `diff.orderFile` is a relative pathname, it is treated as
       	relative to the top of the working tree.
       
     @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
      -	Whether and how Git detects renames.  If set to "false",
      -	rename detection is disabled. If set to "true", basic rename
      -	detection is enabled.  If set to "copies" or "copy", Git will
     +-	detect copies, as well.  Defaults to true.  Note that this
     +-	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
      +`diff.renames`::
      +	Whether and how Git detects renames.  If set to `false`,
      +	rename detection is disabled. If set to `true`, basic rename
      +	detection is enabled.  If set to `copies` or `copy`, Git will
     - 	detect copies, as well.  Defaults to true.  Note that this
     --	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
     ++	detect copies, as well.  Defaults to `true`.  Note that this
      +	affects only `git diff` Porcelain like linkgit:git-diff[1] and
       	linkgit:git-log[1], and not lower level commands such as
       	linkgit:git-diff-files[1].
     @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
       	for details.
       
      -diff.<driver>.trustExitCode::
     +-	If this boolean value is set to true then the
      +`diff.<driver>.trustExitCode`::
     - 	If this boolean value is set to true then the
     ++	If this boolean value is set to `true` then the
       	`diff.<driver>.command` command is expected to return exit code
       	0 if it considers the input files to be equal or 1 if it
      -	considers them to be different, like `diff(1)`.
     +-	If it is set to false, which is the default, then the command
      +	considers them to be different, like `diff`(1).
     - 	If it is set to false, which is the default, then the command
     ++	If it is set to `false`, which is the default, then the command
       	is expected to return exit code 0 regardless of equality.
       	Any other exit code causes Git to report a fatal error.
       
     @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
       	details.
       
      -diff.<driver>.cachetextconv::
     +-	Set this option to true to make the diff driver cache the text
      +`diff.<driver>.cachetextconv`::
     - 	Set this option to true to make the diff driver cache the text
     ++	Set this option to `true` to make the diff driver cache the text
       	conversion outputs.  See linkgit:gitattributes[5] for details.
       
       include::../mergetools-diff.txt[]
     @@ Documentation/config/diff.txt: diff.wsErrorHighlight::
       
      -diff.colorMoved::
      -	If set to either a valid `<mode>` or a true value, moved lines
     -+`diff.colorMoved`::
     -+	If set to either a valid _<mode>_ or a true value, moved lines
     - 	in a diff are colored differently, for details of valid modes
     +-	in a diff are colored differently, for details of valid modes
      -	see '--color-moved' in linkgit:git-diff[1]. If simply set to
      -	true the default color mode will be used. When set to false,
     -+	see `--color-moved` in linkgit:git-diff[1]. If simply set to
     -+	`true` the default color mode will be used. When set to `false`,
     - 	moved lines are not colored.
     - 
     +-	moved lines are not colored.
     +-
      -diff.colorMovedWS::
     ++`diff.colorMoved`::
     ++	If set to either a valid _<mode>_ or a `true` value, moved lines
     ++	in a diff are colored differently.
     ++ifdef::git-diff[]
     ++	For details of valid modes see `--color-moved`.
     ++endif::git-diff[]
     ++ifndef::git-diff[]
     ++	For details of valid modes see `--color-moved` in linkgit:git-diff[1].
     ++endif::git-diff[]
     ++	If simply set to `true` the default color mode will be used. When
     ++	set to `false`, moved lines are not colored.
     ++
      +`diff.colorMovedWS`::
       	When moved lines are colored using e.g. the `diff.colorMoved` setting,
      -	this option controls the `<mode>` how spaces are treated.

-- 
gitgitgadget
