Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C83A1DA
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097841; cv=none; b=j8mBnYS2MaBEjwpg1S4x7Eyus9EKiVlYGUcwFetWERZZf+0z47x8Rwbx8NkNzlF41byPm/Qz/qKbklJdAf9VnzhLPVkRdAaqtfBvuY0lprlwVjHb3dSKvG1wBqEQV1+nbN2RW0EqbDaTITVo//Hdx5Bz4ZQkaEzJWtUbEGnGDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097841; c=relaxed/simple;
	bh=wFu0Hcfi2qpKiCNUSZbRzV2hirCOUEflPdZJX4yfh7M=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=WPiU2tKwHOyKKQQMxlXWgIfRXA5N+zCJkzeQXfzzBTYZP+Dd7PJ5W+Gn/VlIiubGNW22tKKKBcEaslEGqLMr3RrndooUbLzvVsIJdiYJW+lmKzTuvWWlr7wbEuxMbLCCRWPkdmK6Zd2KkyCaQFJEc+JG4YiU7Ow3p0zDVmyWQjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHOYbAQa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHOYbAQa"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e17342ea7so1267117f8f.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710097837; x=1710702637; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9o8yU3FSfbdOlNhDd5jaRhClYbLhMj1eyaJqcYqQeA=;
        b=RHOYbAQa0sc+EiLPB9Xdl0dsb83ouiAj1RoITG3tYTa2fYawc5fxaLLWgBiuA1PiUg
         YypaGIDT1jxNz2as4zM/nZh1HKr9oV+Vx/qDsUAwFlM/Ql1bMJumpMmijFULcdRqewQ/
         GYLL7NX+7Aq/X8is14OQv+9tFEtE0WiUzujcSimX09arRQsaslJzoCrI81kv5ttphr9n
         HNgrXDZZipYegd8KJVUQDJ3uZBj/Ygxw75hjRpBeUucNn7X1c/x/v19g5faZj9kKTDPA
         6uGCJDvphnFsod1uUBjSZlmX+X6YD7H2SChBHuzANnLJkEtjbwxjdnrHNAtFgwacMQVY
         px/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710097837; x=1710702637;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9o8yU3FSfbdOlNhDd5jaRhClYbLhMj1eyaJqcYqQeA=;
        b=Zj8nzMJlMrpPeFEP9WpYbTTUKJy8Sg2CoGY777zvQIzSj3UMjg8Nwa+alIFB3ahtJb
         xnTV5FAjSD5xj7ZB+AaCuUmNCvDcx3FHqPhaHYLhvMq4jQPTiX/CK5WnCllWGkJVFwBR
         Ahvx/X5Qe5/y+xKa/zI3ss8uUWQKsObMcoMD+U3wxvX5WrrPYJBL/Hw/XOEvJMhalSG0
         Ld+9QQk6Df/VkzND0YYZMdDL2kF/oZJ0u6wrHLmop+84DjrGQ0gyu8e7jEv49ZHBPfQz
         sZVRQNZhb+cFqcjMjWfMlgSK7H2Md6PCRN39/kuRGrbr0pFsxibbqIi3ee9magC/T6L2
         jTfg==
X-Gm-Message-State: AOJu0YwDW+VPKvGPOPDm6STXJZowlsFYCgQmsu2pjqf5dlS8LrdfY7ue
	0D1COvx1sZxec0Qi0JYCwpuek2bKOV7B2bCMLzBifKsS+0b4Nngf2pb8TUqS
X-Google-Smtp-Source: AGHT+IHW0RzoYDjsssvrs37BoyRcFIjxZnE9GSHNKhsRu5nknoKIXz2RVPGsTGTR04oXmFPPFj6yog==
X-Received: by 2002:a5d:6909:0:b0:33e:3d71:445f with SMTP id t9-20020a5d6909000000b0033e3d71445fmr3080847wru.32.1710097837565;
        Sun, 10 Mar 2024 12:10:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13-20020adfe40d000000b0033e756ed840sm4531245wrm.47.2024.03.10.12.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:10:36 -0700 (PDT)
Message-ID: <9a949d98a3ec8b7730b5a6b66e8ef8bb62cd06aa.1710097830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
References: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 19:10:30 +0000
Subject: [PATCH 6/6] doc: git-clone: format placeholders
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

With the new formatting rules, we use _<placeholders>_.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-clone.txt | 26 +++++++++++++-------------
 Documentation/urls.txt      |  4 ++--
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6bad5641151..f90977a8519 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -102,9 +102,9 @@ its source repository, you can simply run `git repack -a` to copy all
 objects from the source repository into a pack in the cloned repository.
 
 --reference[-if-able] <repository>::
-	If the reference repository is on the local machine,
+	If the reference _<repository>_ is on the local machine,
 	automatically setup `.git/objects/info/alternates` to
-	obtain objects from the reference repository.  Using
+	obtain objects from the reference _<repository>_.  Using
 	an already existing repository as an alternate will
 	require fewer objects to be copied from the repository
 	being cloned, reducing network and local storage costs.
@@ -161,8 +161,8 @@ objects from the source repository into a pack in the cloned repository.
 
 --bare::
 	Make a 'bare' Git repository.  That is, instead of
-	creating `<directory>` and placing the administrative
-	files in `<directory>/.git`, make the `<directory>`
+	creating _<directory>_ and placing the administrative
+	files in `<directory>/.git`, make the _<directory>_
 	itself the `$GIT_DIR`. This obviously implies the `--no-checkout`
 	because there is nowhere to check out the working tree.
 	Also the branch heads at the remote are copied directly
@@ -180,11 +180,11 @@ objects from the source repository into a pack in the cloned repository.
 --filter=<filter-spec>::
 	Use the partial clone feature and request that the server sends
 	a subset of reachable objects according to a given object filter.
-	When using `--filter`, the supplied `<filter-spec>` is used for
+	When using `--filter`, the supplied _<filter-spec>_ is used for
 	the partial clone filter. For example, `--filter=blob:none` will
 	filter out all blobs (file contents) until needed by Git. Also,
 	`--filter=blob:limit=<size>` will filter out all blobs of size
-	at least `<size>`. For more details on filter specifications, see
+	at least _<size>_. For more details on filter specifications, see
 	the `--filter` option in linkgit:git-rev-list[1].
 
 --also-filter-submodules::
@@ -203,13 +203,13 @@ objects from the source repository into a pack in the cloned repository.
 -o <name>::
 --origin <name>::
 	Instead of using the remote name `origin` to keep track of the upstream
-	repository, use `<name>`.  Overrides `clone.defaultRemoteName` from the
+	repository, use _<name>_.  Overrides `clone.defaultRemoteName` from the
 	config.
 
 -b <name>::
 --branch <name>::
 	Instead of pointing the newly created HEAD to the branch pointed
-	to by the cloned repository's HEAD, point to `<name>` branch
+	to by the cloned repository's HEAD, point to _<name>_ branch
 	instead. In a non-bare repository, this is the branch that will
 	be checked out.
 	`--branch` can also take tags and detaches the HEAD at that commit
@@ -230,7 +230,7 @@ objects from the source repository into a pack in the cloned repository.
 	Set a configuration variable in the newly-created repository;
 	this takes effect immediately after the repository is
 	initialized, but before the remote history is fetched or any
-	files checked out.  The key is in the same format as expected by
+	files checked out.  The _<key>_ is in the same format as expected by
 	linkgit:git-config[1] (e.g., `core.eol=true`). If multiple
 	values are given for the same key, each value will be written to
 	the config file. This makes it safe, for example, to add
@@ -281,7 +281,7 @@ branch of some repository for search indexing.
 
 --recurse-submodules[=<pathspec>]::
 	After the clone is created, initialize and clone submodules
-	within based on the provided pathspec.  If no pathspec is
+	within based on the provided _<pathspec>_.  If no _=<pathspec>_ is
 	provided, all submodules are initialized and cloned.
 	This option can be given multiple times for pathspecs consisting
 	of multiple entries.  The resulting clone has `submodule.active` set to
@@ -323,20 +323,20 @@ include::ref-storage-format.txt[]
 	Defaults to the `submodule.fetchJobs` option.
 
 <repository>::
-	The (possibly remote) repository to clone from.  See the
+	The (possibly remote) _<repository>_ to clone from.  See the
 	<<URLS,GIT URLS>> section below for more information on specifying
 	repositories.
 
 <directory>::
 	The name of a new directory to clone into.  The "humanish"
-	part of the source repository is used if no directory is
+	part of the source repository is used if no _<directory>_ is
 	explicitly given (`repo` for `/path/to/repo.git` and `foo`
 	for `host.xz:foo/.git`).  Cloning into an existing directory
 	is only allowed if the directory is empty.
 
 --bundle-uri=<uri>::
 	Before fetching from the remote, fetch a bundle from the given
-	`<uri>` and unbundle the data into the local repository. The refs
+	_<uri>_ and unbundle the data into the local repository. The refs
 	in the bundle will be stored under the hidden `refs/bundle/*`
 	namespace. This option is incompatible with `--depth`,
 	`--shallow-since`, and `--shallow-exclude`.
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 9af19be2075..0b9e0c4302d 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -61,9 +61,9 @@ attempts to use the `remote-<transport>` remote helper, if one
 exists. To explicitly request a remote helper, the following syntax
 may be used:
 
-- <transport>::<address>
+- _<transport>_::_<address>_
 
-where <address> may be a path, a server and path, or an arbitrary
+where _<address>_ may be a path, a server and path, or an arbitrary
 URL-like string recognized by the specific remote helper being
 invoked. See linkgit:gitremote-helpers[7] for details.
 
-- 
gitgitgadget
