Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304073D1CCC
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138224; cv=none; b=VxFTObhZFfBeQIGR9wgoDFxL+emo0jBk0dsi25izUN08rHNwUqsdbAXrr+QPCqxLEC5xXY7i4DDOErEy4l+VwPqdfK+0DWNs6LculLqgmI7uRBgpe1q8vw2xbaOA7c1/vcqOPgEfnR4D7/s6jiqoSzals/QYwqa39H+XQCEqMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138224; c=relaxed/simple;
	bh=+UuEXLrRTfrpaY9DMJFqVDb9VMO5eUS4H1CBZ0vpqmU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=bfsX9ZW3t2IGRtp0/u1DyRz+oTbIOKTwROBHZEBMvXs735GllMPANDODIeQ7ugGo6Qs143k4lEIVihseFl3a74DXJkPkPwH1VX/38NvaW1ygvR2QzxhngxsNBwP8Ja7uF7XNS/dGvrAokpj0Az28yKj8n3PHy90kO8a7yC+dneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFv18eJe; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFv18eJe"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1248d27f2b9so7224683c88.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138219; x=1770743019; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psf3hfX7/Nl98z5U+jt6huNoLX7WdNV330mgHaYnP+s=;
        b=HFv18eJe6hHzxdOJf/tszIiAEVidLqzEMO48HbX347eUyQBTdU5vp+S9lGqmVmIybR
         hKZn9DDLR0yOA3sz859IesgLr4TyTd9mlCLvHc2gNWgy0xsvcsk1ntTdVNdLz36s3MDc
         q97JQ24OBXXrD7eaDU7VQn8U9TcWAanPctMMglGSgWu2mgVnW4XRAJFbJVRWtXujvDVe
         X0CHNimIcQKQ0Cku/ykKUT6qzRop430O1lJ6PwFVkgHBUe9Y419+oJrrLm4hvoxycg5t
         j0pS6gIKUTODbylATyRj2gs4mJIgS82BXxa59peIX5/nIJHRG60fLZH+JkDJPdA1jyou
         5ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138219; x=1770743019;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=psf3hfX7/Nl98z5U+jt6huNoLX7WdNV330mgHaYnP+s=;
        b=Kjz24HVgb3Gqef1n3ZjUUE5dvzUNceEK895RyjNmAKhXJjVtCas1tCPjEsEGPQD9YI
         9oraCF8fzhE7cjqzHt4gS1qR23nioFsxmslMsJBUiXukWiGlwqN1qWKRD6WxG3Me+WaC
         DQkl5aKE4ix/ksRoWt4ldf063zfJztL1rxiFjaFNbYDROQSjkbVvERjpuPIBRCUiKJ/i
         3n7fIZv3PfbEuDnUq+f70mOTaM+s8xfTeq2eoroJlR6r8ajl+XpkirSvYX2nKKyL9o2l
         OSfmltseU93PmGhVAitIvQPuqkrvCRBKg0fbgQ2+FR5UTozDWVHiv1YaMKR36XLaqvUt
         FKhg==
X-Gm-Message-State: AOJu0YzutSQKdznVv7YP9scdiLuuZ1FjTdgZMfro1Z0r6GGWN/Eh8AVh
	GEGmB8JdZnqW676M3MYHO0cBW9Bi0j7ED4f5XfYnAjvGM+EVnMEgl6gmn9ijFYCT
X-Gm-Gg: AZuq6aJXe23UgzfBJzdGPSkNvh06Uj8Cx81sWKLz+JBDo4L8xnrlHY4Ig5dMf2QYv42
	Qrh6ohY2J6mR4OuwH1Wnzbdzd9IsnJ8m/DPKPFr6qnfBK6DB3bCyQP4l0fJ09vB6zZhLL+Kqz+p
	FkfvCJJVkhD9nCqNEPUSdu3bGFb9uasMRgpq2W41FkxcunXArlVKqPaH3UZ8VQ/w4aKm6ZJpPXh
	REMQHSha7QQ7/La3crLSINoTgxyXmpBeTHno/ZSX1HsKgzwgFpt0EFso69l0eK5IKKhmDYSBHg7
	rlz4vUwyj04/SymDcFQb/88pEAvgWAX1zHhA0WuAuKtDV2vAd0xwBPMRasuxiWcicAAzsMq4ZiN
	O6Bb1Zp9huy3mDcC1ED5xFvJN66i3S6v+XjFvc6SiMVzHTvnCbkCFo1uDuanna2kvgyLVOQqA/H
	HQhC1b7P6HIgne+cOrM51+/SY=
X-Received: by 2002:a05:693c:3282:b0:2b7:4157:9afc with SMTP id 5a478bee46e88-2b83296dd6emr80410eec.19.1770138217233;
        Tue, 03 Feb 2026 09:03:37 -0800 (PST)
Received: from [127.0.0.1] ([20.169.75.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832c28168sm76248eec.0.2026.02.03.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:03:36 -0800 (PST)
Message-Id: <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 17:03:31 +0000
Subject: [PATCH v3 0/4] doc: some more synopsis conversions and fixes
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

 * fix mistakes spotted by Kristoffer Haugsbakk

Jean-Noël Avila (4):
  doc: convert git-submodule to synopsis style
  doc: finalize git-clone documentation conversion to synopsis style
  doc: fix some style issues in git-clone and for-each-ref-options
  doc: convert git-show to synopsis style

 Documentation/asciidoc.conf.in          |   6 +
 Documentation/for-each-ref-options.adoc |   4 +-
 Documentation/git-clone.adoc            |  54 ++--
 Documentation/git-show.adoc             |  16 +-
 Documentation/git-submodule.adoc        | 389 ++++++++++++------------
 Documentation/pretty-formats.adoc       | 169 +++++-----
 Documentation/ref-storage-format.adoc   |   4 +-
 7 files changed, 338 insertions(+), 304 deletions(-)


base-commit: d8af7cadaa79d5837d73ec949e10b57dedb43e9b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2036%2Fjnavila%2Fgit_submodule-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2036/jnavila/git_submodule-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2036

Range-diff vs v2:

 1:  05e68e2825 ! 1:  8d22e6952a convert git-submodule doc to synopsis style
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    convert git-submodule doc to synopsis style
     +    doc: convert git-submodule to synopsis style
      
           * convert commands to synopsis style
           * use _<placeholder>_ for arguments
     @@ Commit message
           * minor formatting fixes
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
     +    Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
      
       ## Documentation/git-submodule.adoc ##
      @@ Documentation/git-submodule.adoc: git-submodule - Initialize, update or inspect submodules
     @@ Documentation/git-submodule.adoc: COMMANDS
      -or ../), the location relative to the superproject's default remote
      -repository (Please note that to specify a repository 'foo.git'
      -which is located right next to a superproject 'bar.git', you'll
     -+_<repository>_ is the URL of the new submodule's origin repository.
     ++_<repository>_ is the URL of the new submodule's `origin` repository.
      +This may be either an absolute URL, or (if it begins with `./`
      +or `../`), the location relative to the superproject's default remote
      +repository (Please note that to specify a repository `foo.git`
     @@ Documentation/git-submodule.adoc: URL in `.gitmodules`.
       	Show the status of the submodules. This will print the SHA-1 of the
       	currently checked out commit for each submodule, along with the
      -	submodule path and the output of 'git describe' for the
     -+	submodule path and the output of `git describe` for the
     ++	submodule path and the output of linkgit:git-describe[1] for the
       	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule is
       	not initialized, `+` if the currently checked out submodule commit
       	does not match the SHA-1 found in the index of the containing
     @@ Documentation/git-submodule.adoc: If you really want to remove a submodule from
       options.
       
      -update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--ref-format <format>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter-spec>] [--] [<path>...]::
     -+`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference <repository>] [--ref-format <format>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter-spec>] [--] [<path>...]`::
     ++`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
       +
       --
       Update the registered submodules to match what the superproject
     @@ Documentation/git-submodule.adoc: checked out commit for each submodule:
       	case when they are initialized or freshly added). This is useful when
       	submodule URLs change upstream and you need to update your local
       	repositories accordingly.
     -@@ Documentation/git-submodule.adoc: sync [--recursive] [--] [<path>...]::
     + +
     + `git submodule sync` synchronizes all submodules while
     +-`git submodule sync -- A` synchronizes submodule "A" only.
     ++`git submodule sync -- A` synchronizes submodule `A` only.
     + +
       If `--recursive` is specified, this command will recurse into the
       registered submodules, and sync any nested submodules within.
       
     @@ Documentation/git-submodule.adoc: This command is recursive by default.
       
      --b <branch>::
      ---branch <branch>::
     -+`-b <branch>`::
     -+`--branch <branch>`::
     ++`-b<branch>`::
     ++`--branch=<branch>`::
       	Branch of repository to add as submodule.
       	The name of the branch is recorded as `submodule.<name>.branch` in
       	`.gitmodules` for `update --remote`.  A special value of `.` is used to
     @@ Documentation/git-submodule.adoc: This command is recursive by default.
      +	Make the `summary` command compare the commit in the index with that in
      +	the submodule `HEAD`.
      +
     -+`-n <n>`::
     -+`--summary-limit <n>`::
     ++`-n<n>`::
     ++`--summary-limit=<n>`::
      +	Limit the `summary` size (number of commits shown in total) to _<n>_.
       	Giving 0 will disable the summary; a negative number means unlimited
       	(the default). This limit only applies to modified submodules. The
     @@ Documentation/git-submodule.adoc: to distribute the default upstream branch with
      ---checkout::
      -	This option is only valid for the update command.
      -	Checkout the commit recorded in the superproject on a detached HEAD
     +-	in the submodule. This is the default behavior, the main use of
     +-	this option is to override `submodule.$name.update` when set to
      +`--checkout`::
     -+	This option is only valid for the `update` command.
      +	Checkout the commit recorded in the superproject on a detached `HEAD`
     - 	in the submodule. This is the default behavior, the main use of
     --	this option is to override `submodule.$name.update` when set to
     ++	in the submodule. This option is only valid for the `update` command.
     ++	This is the default behavior, the main use of
      +	this option is to override `submodule.<name>.update` when set to
       	a value other than `checkout`.
      -	If the key `submodule.$name.update` is either not explicitly set or
     @@ Documentation/git-submodule.adoc: to distribute the default upstream branch with
       	implicit.
       
      ---rebase::
     +-	This option is only valid for the update command.
     +-	Rebase the current branch onto the commit recorded in the
     +-	superproject. If this option is given, the submodule's HEAD will not
      +`--rebase`::
     - 	This option is only valid for the update command.
     - 	Rebase the current branch onto the commit recorded in the
     - 	superproject. If this option is given, the submodule's HEAD will not
     ++	Rebase the current branch onto the commit recorded in the superproject.
     ++	This option is only valid for the update command. The submodule's HEAD will not
       	be detached. If a merge failure prevents this process, you will have
       	to resolve these failures with linkgit:git-rebase[1].
      -	If the key `submodule.$name.update` is set to `rebase`, this option is
     @@ Documentation/git-submodule.adoc: to distribute the default upstream branch with
      ---name::
      -	This option is only valid for the add command. It sets the submodule's
      -	name to the given string instead of defaulting to its path. The name
     -+`--name <name>`::
     ++`--name=<name>`::
      +	Set the submodule's name to the given string instead of defaulting to its path. _<name>_
       	must be valid as a directory name and may not end with a '/'.
       
      ---reference <repository>::
      -	This option is only valid for add and update commands.  These
     -+`--reference <repository>`::
     -+	This option is only valid for `add` and `update` commands.  These
     - 	commands sometimes need to clone a remote repository. In this case,
     +-	commands sometimes need to clone a remote repository. In this case,
     ++`--reference=<repository>`::
     ++	Pass the local _<repository>_ as a reference when cloning the submodule.
     ++	This option is only valid for `add` and `update` commands.
     ++	These commands sometimes need to clone a remote repository. In this case,
       	this option will be passed to the linkgit:git-clone[1] command.
       +
     -@@ Documentation/git-submodule.adoc: the submodule itself.
     +-*NOTE*: Do *not* use this option unless you have read the note
     ++NOTE: Do *not* use this option unless you have read the note
       for linkgit:git-clone[1]'s `--reference`, `--shared`, and `--dissociate`
       options carefully.
       
      ---dissociate::
     +-	This option is only valid for add and update commands.  These
     +-	commands sometimes need to clone a remote repository. In this case,
      +`--dissociate`::
     - 	This option is only valid for add and update commands.  These
     - 	commands sometimes need to clone a remote repository. In this case,
     ++	After using a reference repository to clone from, do not rely on it anymore.
     ++	This option is only valid for `add` and `update` commands.
     ++	These commands sometimes need to clone a remote repository. In this case,
       	this option will be passed to the linkgit:git-clone[1] command.
       +
      -*NOTE*: see the NOTE for the `--reference` option.
     -+*NOTE*: see the NOTE above for the `--reference` option.
     ++NOTE: See the NOTE above for the `--reference` option.
       
      ---recursive::
      -	This option is only valid for foreach, update, status and sync commands.
     @@ Documentation/git-submodule.adoc: the submodule itself.
      -	This option is valid for add and update commands. Create a 'shallow'
      -	clone with a history truncated to the specified number of revisions.
      -	See linkgit:git-clone[1]
     -+`--depth <depth>`::
     ++`--depth=<depth>`::
      +	Create a 'shallow' clone with a history truncated to the _<depth>_ revisions.
      +	This option is valid for `add` and `update` commands. See linkgit:git-clone[1]
       
     @@ Documentation/git-submodule.adoc: the submodule itself.
      -	This option is only valid for the update command.
      +`--recommend-shallow`::
      +`--no-recommend-shallow`::
     ++	Recommend or not shallow cloning of submodules.
      +	This option is only valid for the `update` command.
       	The initial clone of a submodule will use the recommended
       	`submodule.<name>.shallow` as provided by the `.gitmodules` file
     @@ Documentation/git-submodule.adoc: the submodule itself.
      ---jobs <n>::
      -	This option is only valid for the update command.
      -	Clone new submodules in parallel with as many jobs.
     -+`-j <n>`::
     -+`--jobs <n>`::
     ++`-j<n>`::
     ++`--jobs=<n>`::
      +	Clone new submodules in parallel with _<n>_ jobs.
      +	This option is only valid for the `update` command.
       	Defaults to the `submodule.fetchJobs` option.
 2:  3a5b642d05 ! 2:  5fd9f6d41a doc: finalize git-clone documentation conversion to synopsis style
     @@ Commit message
          Use backticks where appropriate for command-line options
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
     +    Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
      
       ## Documentation/git-clone.adoc ##
      @@ Documentation/git-clone.adoc: objects from the source repository into a pack in the cloned repository.
 3:  bcd6fcd119 ! 3:  d097065303 doc: fix some style issues in git-clone and for-each-ref-options
     @@ Commit message
           * fix markups
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
     +    Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
      
       ## Documentation/for-each-ref-options.adoc ##
      @@ Documentation/for-each-ref-options.adoc: TAB %(refname)`.
     @@ Documentation/git-clone.adoc: If you want to break the dependency of a repositor
       objects from the source repository into a pack in the cloned repository.
       
      -`--reference[-if-able] <repository>`::
     -+`--reference <repository>`::
     -+`--reference-if-able <repository>`::
     ++`--reference=<repository>`::
     ++`--reference-if-able=<repository>`::
       	If the reference _<repository>_ is on the local machine,
       	automatically setup `.git/objects/info/alternates` to
       	obtain objects from the reference _<repository>_.  Using
     @@ Documentation/git-clone.adoc: objects from the source repository into a pack in
       	The `clone.rejectShallow` configuration variable can be used to
       	specify the default.
      @@ Documentation/git-clone.adoc: objects from the source repository into a pack in the cloned repository.
     + 	that all these refs are overwritten by a `git remote update` in the
     + 	target repository.
       
     - `-b <name>`::
     - `--branch <name>`::
     +-`-o <name>`::
     +-`--origin <name>`::
     ++`-o<name>`::
     ++`--origin=<name>`::
     + 	Instead of using the remote name `origin` to keep track of the upstream
     + 	repository, use _<name>_.  Overrides `clone.defaultRemoteName` from the
     + 	config.
     + 
     +-`-b <name>`::
     +-`--branch <name>`::
      -	Instead of pointing the newly created `HEAD` to the branch pointed
      -	to by the cloned repository's `HEAD`, point to _<name>_ branch
      -	instead. In a non-bare repository, this is the branch that will
      -	be checked out.
     ++`-b<name>`::
     ++`--branch=<name>`::
      +	Point the newly created `HEAD` to _<name>_ branch instead of the branch
      +	pointed to by the cloned repository's `HEAD`. In a non-bare repository,
      +	this is the branch that will be checked out.
     @@ Documentation/git-clone.adoc: objects from the source repository into a pack in
       	in the resulting repository.
       
      @@ Documentation/git-clone.adoc: objects from the source repository into a pack in the cloned repository.
     + 	name.
     + 	This option is incompatible with `--branch` and `--mirror`.
       
     - `-u <upload-pack>`::
     - `--upload-pack <upload-pack>`::
     +-`-u <upload-pack>`::
     +-`--upload-pack <upload-pack>`::
      -	When given, and the repository to clone from is accessed
      -	via ssh, this specifies a non-default path for the command
      -	run on the other end.
     ++`-u<upload-pack>`::
     ++`--upload-pack=<upload-pack>`::
      +	Specify a non-default path for the command run on the other end when the
      +	repository to clone from is accessed via ssh.
       
       `--template=<template-directory>`::
       	Specify the directory from which templates will be used;
     + 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
     + 
     +-`-c <key>=<value>`::
     +-`--config <key>=<value>`::
     ++`-c<key>=<value>`::
     ++`--config=<key>=<value>`::
     + 	Set a configuration variable in the newly-created repository;
     + 	this takes effect immediately after the repository is
     + 	initialized, but before the remote history is fetched or any
     +@@ Documentation/git-clone.adoc: Configuration variables known to not take effect are:
     + `remote.<name>.mirror` and `remote.<name>.tagOpt`.  Use the
     + corresponding `--mirror` and `--no-tags` options instead.
     + 
     +-`--depth <depth>`::
     ++`--depth=<depth>`::
     + 	Create a 'shallow' clone with a history truncated to the
     + 	specified number of commits. Implies `--single-branch` unless
     + 	`--no-single-branch` is given to fetch the histories near the
     +@@ Documentation/git-clone.adoc: Specify the given ref storage format for the repository. The valid values are:
     + +
     + include::ref-storage-format.adoc[]
     + 
     +-`-j <n>`::
     +-`--jobs <n>`::
     ++`-j<n>`::
     ++`--jobs=<n>`::
     + 	The number of submodules fetched at the same time.
     + 	Defaults to the `submodule.fetchJobs` option.
     + 
     +
     + ## Documentation/ref-storage-format.adoc ##
     +@@
     +-* `files` for loose files with packed-refs. This is the default.
     +-* `reftable` for the reftable format. This format is experimental and its
     ++`files`;; for loose files with packed-refs. This is the default.
     ++`reftable`;; for the reftable format. This format is experimental and its
     +   internals are subject to change.
 4:  f6314e580d ! 4:  d179137d81 doc: convert git-show to synopsis style
     @@ Commit message
           * minor formatting fixes
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
     +    Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
      
       ## Documentation/asciidoc.conf.in ##
      @@ Documentation/asciidoc.conf.in: endif::backend-xhtml11[]
     @@ Documentation/pretty-formats.adoc: colon and zero or more comma-separated option
      +`suffix=<value>`;; Shown after the list of ref names.  Defaults to "+)+".
      +`separator=<value>`;; Shown between ref names.  Defaults to "+,+{nbsp}".
      +`pointer=<value>`;; Shown between HEAD and the branch it points to, if any.
     -+	      Defaults to "{nbsp}++->++{nbsp}".
     ++	      Defaults to "{nbsp}->{nbsp}".
      +`tag=<value>`;; Shown before tag names. Defaults to "`tag:`{nbsp}".
       
       +
     @@ Documentation/pretty-formats.adoc: colon and zero or more comma-separated option
       For example, to produce decorations with no wrapping
       or tag annotations, and spaces as separators:
      -
     -++
     - ++%(decorate:prefix=,suffix=,tag=,separator= )++
     +-++%(decorate:prefix=,suffix=,tag=,separator= )++
      ---
     ++---------------------
     ++    %(decorate:prefix=,suffix=,tag=,separator= )
     ++---------------------
       
       ++%(describe++`[:<option>,...]`++)++::
       human-readable name, like linkgit:git-describe[1]; empty string for
     @@ Documentation/pretty-formats.adoc: undescribable commits.  The `describe` string
      -** `abbrev=<number>`: Instead of using the default number of hexadecimal digits
      +`abbrev=<number>`;; Instead of using the default number of hexadecimal digits
          (which will vary according to the number of objects in the repository with a
     -    default of 7) of the abbreviated object name, use <number> digits, or as many
     +-   default of 7) of the abbreviated object name, use <number> digits, or as many
     ++   default of 7) of the abbreviated object name, use _<number>_ digits, or as many
          digits as needed to form a unique object name.
      -** `match=<pattern>`: Only consider tags matching the given
      +`match=<pattern>`;; Only consider tags matching the given

-- 
gitgitgadget
