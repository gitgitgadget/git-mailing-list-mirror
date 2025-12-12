Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E31917F0
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552541; cv=none; b=TtNlW1UD8z5B2ubhSrY0TDYiI5eoASoYn6luQr5CL+zhXK0BYH8ZMjnaSzwndmB7QRGscIAUIsiS1IW6k7KprphMxCWYlw7vSTqOWG6ShuEBYwSicVeyo2wqDGhpIWAsz+O5SzKPVi4Tl8KBRvvkvjooVpmtT8vZNwhREeJQqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552541; c=relaxed/simple;
	bh=GmyTqpSzPNFKshfy9D09orlfX9sblXKWNfDAlJfwrgQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nVEqnJXMhEbiwXA/AMHW+K2b8OQaHUgIKy56NPNl/MinFgJN0TDfxG2rLUXJ9U2iC+Vt8KcHmgf4m7kUowlAEVkJ7u8OQU8iwO7KDN7vUImZ76nARlTRb001OTcQjbl0b3NtT65w/bFQgEq0v9cr7A+F+1hC/47iWMX//4KjVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6J1D9CU; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6J1D9CU"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so1393740b3a.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 07:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765552538; x=1766157338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puBaLasn9s8x+VS9nC02Dp4HUXPTS7YxfqVIN5zy19U=;
        b=N6J1D9CUI/NxkmtagUpppaHsUVpEdau+r4GuOYXQYMsXDkG+VQzNXA89Hl+nuwimJ2
         JceW67tTbXxVpN4yvEebnYGPf8ZCCzrLg/FIfb7G40Ezj8/+v5t5qH/TIxspZbS5WhP2
         CUaDmxtx6aqHMKAGD9lwdzhAU+BlKI0almTK5PRgpZR0njPYln0+HxV+l40zqSLLa3RJ
         Bb3aKsuOr0zHIxk8DK4GVE+Fw+6dG6timlPeQD4MdmMzv8mhCpNwipQmxM87Q1ypW8ai
         9mNbFuCMi7Ot7KHd4u4lulfjT+aC6ZC859rSkLl+9R24ql6pEeKgi0W7ob0gafm+T11+
         dBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552538; x=1766157338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=puBaLasn9s8x+VS9nC02Dp4HUXPTS7YxfqVIN5zy19U=;
        b=xNZIteBJrTWheMcaQPXgJv8jV5IKBfXbNBCLTfsdeMdYsWJNgcInBzi/u8/K7W8W/f
         torNahrAdANY7nVlr8HgENwdJ10ZBbpO3MSURcN/od45zoqiHvkhyj0imcuNfKI53RHG
         LzcOQDt7lOhYEA2E6hptse2rvsQMmObvv8OWOfUEZRK8o746/EQ+QbWuUzDYDoB8FKBF
         j//xjxSQh+iuilCGQxViPS+PIAiwWvIyNWF4QTkk48pK+2bkKVS5BAMJAVHOLXmni06t
         SiHEFBM2p1lJI3WvqYdkeESh/dvPx/YnHjedP1AAoFMKqB8xBLP3PPjUtLYFeWjCWeup
         p52g==
X-Gm-Message-State: AOJu0YxukXpg0IviLhmDLxuDEi1RJmy1srdGQ+/8EuVYmLqpaPI47pZ8
	fU7veC6SoTeDsSXabrq0AwYPd9F7Ez3aGhrqcCuXuK1L71Eg0lVjdD6uZATEGUQY6WM=
X-Gm-Gg: AY/fxX6y0r1oUROejTepQfRNPp/O3CCPlhi4lBBWXvK070CRfeCdEnBu9GZQCWqjiGm
	CYdyRRKGLwSwT3LQVogF2oG4fdDONyPY3oajfltX1s94PveotuuVJG3vyaXu52K8LNCsr4l4sUX
	UZ7EhlCgHz/n7fuUJUJK/aDqwUiEC/gk2rIbYQNnd0Mf2UpYFBAW3P9sVFwSR9G+iZhOy38fwoM
	lyw6THEg7tUf8MNy9mJFCvIYy3CHSTQ25cCYb/5S+G/CSURX95gXEuoJYJ7+r/9r5pEIRp9wZ6W
	yREonRTFDpAy3D7AT0TXAg58IsZH4H5OGlKHNgObNr5bnU5iYcD7ui8UlOkPHEnkS0wd5iwAG+h
	cJE+3otVkm1HBluasrd+ZCBlPcfa4vDmXjmMdMPTpSspl3oB3njIfkcPDOM9Ajw2JCR/fdHHOCt
	EL5VrJtOaI40GApQ==
X-Google-Smtp-Source: AGHT+IGG43wYEOv7y4GXC+fZfB2HmWeGvkC3ovz7ZgE4y6B/tg00jFomWbo5SmnK+GKUHRQ9018Idg==
X-Received: by 2002:a05:701b:2719:b0:11b:79f1:850 with SMTP id a92af1059eb24-11f35486f3dmr1191555c88.14.1765552537361;
        Fri, 12 Dec 2025 07:15:37 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2b4867sm18154536c88.6.2025.12.12.07.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:15:36 -0800 (PST)
Message-Id: <f062b0e0773b9d168c031bb1f35538665394a077.1765552528.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
References: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
	<pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Dec 2025 15:15:28 +0000
Subject: [PATCH v3 5/5] scalar: document config settings
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
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Matthew Hughes <matthewhughes934@gmail.com>,
    Henrique Ferreiro <hferreiro@igalia.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add user-facing documentation that justifies the values being set by
'scalar clone', 'scalar register', and 'scalar reconfigure'.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/scalar.adoc | 164 ++++++++++++++++++++++++++++++++++++++
 scalar.c                  |   4 +
 2 files changed, 168 insertions(+)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index f81b2832f8..ee9fc0ac0c 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -197,6 +197,170 @@ delete <enlistment>::
 	This subcommand lets you delete an existing Scalar enlistment from your
 	local file system, unregistering the repository.
 
+RECOMMENDED CONFIG VALUES
+-------------------------
+
+As part of both `scalar clone` and `scalar register`, certain Git config
+values are set to optimize for large repositories or cross-platform support.
+These options are updated in new Git versions according to the best known
+advice for large repositories, and users can get the latest recommendations
+by running `scalar reconfigure [--all]`.
+
+This section lists justifications for the config values that are set in the
+latest version.
+
+am.keepCR=true::
+	This setting is important for cross-platform development across Windows
+	and non-Windows platforms and keeping carriage return (`\r`) characters
+	in certain workflows.
+
+commitGraph.changedPaths=true::
+	This setting helps the background maintenance steps that compute the
+	serialized commit-graph to also store changed-path Bloom filters. This
+	accelerates file history commands and allows users to automatically
+	benefit without running a foreground command.
+
+commitGraph.generationVersion=1::
+	While the preferred version is 2 for performance reasons, existing users
+	that had version 1 by default will need special care in upgrading to
+	version 2. This is likely to change in the future as the upgrade story
+	solidifies.
+
+core.autoCRLF=false::
+	This removes the transformation of worktree files to add CRLF line
+	endings when only LF line endings exist. This is removed for performance
+	reasons. Repositories that use tools that care about CRLF line endings
+	should commit the necessary files with those line endings instead.
+
+core.logAllRefUpdates=true::
+	This enables the reflog on all branches. While this is a performance
+	cost for large repositories, it is frequently an important data source
+	for users to get out of bad situations or to seek support from experts.
+
+core.safeCRLF=false::
+	Similar to `core.autoCRLF=false`, this disables checks around whether
+	the CRLF conversion is reversible. This is a performance improvement,
+	but can be dangerous if `core.autoCRLF` is reenabled by the user.
+
+credential.https://dev.azure.com.useHttpPath=true::
+	This setting enables the `credential.useHttpPath` feature only for web
+	URLs for Azure DevOps. This is important for users interacting with that
+	service using multiple organizations and thus multiple credential
+	tokens.
+
+feature.experimental=false::
+	This disables the "experimental" optimizations grouped under this
+	feature config. The expectation is that all valuable optimizations are
+	also set explicitly by Scalar config, and any differences are
+	intentional. Notable differences include several bitmap-related config
+	options which are disabled for client-focused Scalar repos.
+
+feature.manyFiles=false::
+	This disables the "many files" optimizations grouped under this feature
+	config. The expectation is that all valuable optimizations are also set
+	explicitly by Scalar config, and any differences are intentional.
+
+fetch.showForcedUpdates=false::
+	This disables the check at the end of `git fetch` that notifies the user
+	if the ref update was a forced update (one where the previous position
+	is not reachable from the latest position). This check can be very
+	expensive in large repositories, so is disabled and replaced with an
+	advice message. Set `advice.fetchShowForcedUpdates=false` to disable
+	this advice message.
+
+fetch.unpackLimit=1::
+	This setting prevents Git from unpacking packfiles into loose objects
+	as they are downloaded from the server. The default limit of 100 was
+	intended as a way to prevent performance issues from too many packfiles,
+	but Scalar uses background maintenance to group packfiles and cover them
+	with a multi-pack-index, removing this issue.
+
+fetch.writeCommitGraph=false::
+	This config setting was created to help users automatically update their
+	commit-graph files as they perform fetches. However, this takes time
+	from foreground fetches and pulls and Scalar uses background maintenance
+	for this function instead.
+
+gc.auto=0::
+	This disables automatic garbage collection, since Scalar uses background
+	maintenance to keep the repository data in good shape.
+
+gui.GCWarning=false::
+	Since Scalar disables garbage collection by setting `gc.auto=0`, the
+	`git-gui` tool may start to warn about this setting. Disable this
+	warning as Scalar's background maintenance configuration makes the
+	warning irrelevant.
+
+index.skipHash=true::
+	Disable computing the hash of the index contents as it is being written.
+	This assists with performance, especially for large index files.
+
+index.threads=true::
+	This tells Git to automatically detect how many threads it should use
+	when reading the index due the default value of	`core.preloadIndex`,
+	which enables parallel index reads. This explicit setting also enables
+	`index.recordOffsetTable=true` to speed up parallel index reads.
+
+index.version=4::
+	This index version adds compression to the path names, reducing the size
+	of the index in a significant way for large repos. This is an important
+	performance boost.
+
+log.excludeDecoration=refs/prefetch/*::
+	Since Scalar enables background maintenance with the `incremental`
+	strategy, this setting avoids polluting `git log` output with refs
+	stored by the background prefetch operations.
+
+merge.renames=true::
+	When computing merges in large repos, it is particularly important to
+	detect renames to maximize the potential for a result that will validate
+	correctly. Users performing merges locally are more likely to be doing
+	so because a server-side merge (via pull request or similar) resulted in
+	conflicts. While this is the default setting, it is set specifically to
+	override a potential change to `diff.renames` which a user may set for
+	performance reasons.
+
+merge.stat=false::
+	This disables a diff output after computing a merge. This improves
+	performance of `git merge` for large repos while reducing noisy output.
+
+pack.useBitmaps=false::
+	This disables the use of `.bitmap` files attached to packfiles. Bitmap
+	files are optimized for server-side use, not client-side use. Scalar
+	disables this to avoid some performance issues that can occur if a user
+	accidentally creates `.bitmap` files.
+
+pack.usePathWalk=true::
+	This enables the `--path-walk` option to `git pack-objects` by default.
+	This can accelerate the computation and compression of packfiles created
+	by `git push` and other repack operations.
+
+receive.autoGC=false::
+	Similar to `gc.auto`, this setting is disabled in preference of
+	background maintenance.
+
+status.aheadBehind=false::
+	This disables the ahead/behind calculation that would normally happen
+	during a `git status` command. This information is frequently ignored by
+	users but can be expensive to calculate in large repos that receive
+	thousands of commits per day. The calculation is replaced with an advice
+	message that can be disabled by disabling the `advice.statusAheadBehind`
+	config.
+
+The following settings are different based on which platform is in use:
+
+core.untrackedCache=(true|false)::
+	The untracked cache feature is important for performance benefits on
+	large repositories, but has demonstrated some bugs on Windows
+	filesystems. Thus, this is set for other platforms but disabled on
+	Windows.
+
+http.sslBackend=schannel::
+	On Windows, the `openssl` backend has some issues with certain types of
+	remote providers and certificate types. Override the default setting to
+	avoid these common problems.
+
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/scalar.c b/scalar.c
index 3b25fd3f35..21ab1dba89 100644
--- a/scalar.c
+++ b/scalar.c
@@ -132,6 +132,10 @@ static int have_fsmonitor_support(void)
 
 static int set_recommended_config(int reconfigure)
 {
+	/*
+	 * Be sure to update Documentation/scalar.adoc if you add, update,
+	 * or remove any of these recommended settings.
+	 */
 	struct scalar_config config[] = {
 		{ "am.keepCR", "true" },
 		{ "commitGraph.changedPaths", "true" },
-- 
gitgitgadget
