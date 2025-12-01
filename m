Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F30D33557F
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607859; cv=none; b=Y1n7bzFnulxBqKbajoLu8i3485w9zq6GSM3OAJKol1qIekaYILuA3+sbResP919/fEnNGzVL1B3AJIRQTJKfQ7tLaxDUZuBRxukWcoVioO4F+EDxQ4szYtkjd1zCtVp5C3TknYGt5bglPRCDeqygkv2l/qbtqENhUxpHhwkb5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607859; c=relaxed/simple;
	bh=qhPzjudu3IT0hUKbSCQPgAkWzD1V1EIdfqJu97RAJO4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CB1Akdk4pwnML6Apf9vqmB4gRLo3ma1zSu0OFtZ18N3RSPRYFlfnUlWkB7PayB+zRvTTedfPHuRC2C4OKgi0mCtYoQ17HIhzVw4qzGnPOVBB6onA+eJscY/bZv5e4WR5ULvMsqKW2IfvAmI27VvIQe0FD+sOuT55ZADHLzVqd2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1SoBNgf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1SoBNgf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-298039e00c2so63223185ad.3
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 08:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764607857; x=1765212657; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPTdkVtBaevbkzIB27SG7A2mZ4Bobbe+7GVVOKf9BJo=;
        b=M1SoBNgfvh2bvQ7fSLUehlFkNMCZjPXnqcjcCRDuBctGq262V+9yxTpBThqAN1GVLF
         +PTn7dKD06lBZbtB68Fb1JxJOsrJXoRPfjN/DDPT70tKYFKI78SNVIimgDRsfIa4qiav
         rzMw71h0opuJKohQNJFuM2Wpqg73G7PlQBjNfSnlJBHJ8pODvZDtBZgXOLcTv/fo2tTi
         VGxKfWjuBV2caq1ocWczWv0n+UicOtNcA6yEfaWTkHCsKhyuttrAOSgf54aFnOG87LrV
         omikR4afThVCkZC4rpSJL5OmC876/gICwaox10amWIpD7VmV9ITVakC9Zr720atsxI6Q
         7eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607857; x=1765212657;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPTdkVtBaevbkzIB27SG7A2mZ4Bobbe+7GVVOKf9BJo=;
        b=WRwndHNgg1r4vPFY4/WnD8uPKdYy5T1sMuUhheukDYMT/sXwdufa8nvHiniWcw1+9V
         mTWd15tD7mEtWJs/eMEbfY41eUTM9ChOCwvfePVMq7cCJOLaX+UYHYWKxD5Ao1xBMvAO
         zyzeq+PF/jhR2UweNAB1OnwPMiqD4y4ay5tiCL4VQrh8KEY+zGhbDcAYtOS/z2kFsn/4
         deTjLU3sETVgCUCmxXiYxDb96F409N1mKjy4OU0u4iIX1lu1h3NetOqhhXnIoNDlYbYH
         a6NbJQzj8bAPASKWhju8A7ecyOGwuOs0Iow1UZRFS3aFZceNGBVXeGtE1YVc/nym2b4F
         GAHg==
X-Gm-Message-State: AOJu0Yy9WLG2Vi42y4lAH4Hrt6j5U5r3B2ffY3Mmr4b6LfUP/d4s8Tyh
	RnERwG74M7MCqX6soGSoDFuQIiUXOZt7tclN9/aImy6GXD+Op//ybh7ojqi8WSy2
X-Gm-Gg: ASbGncvwrku+SkN6lhMoXGyOdH9E/lRpAr0SUhInRU5ICO7VOrfLm/j0feIFv0N7klA
	lDH3PeZz46hIH+wwtI26Cd94OudhlsPu/i/9aETZdhW6rYrBvrM9PaRE11KeS6Y9veKzVaoZBVt
	zM22YopQjDAOA6B7z3gI2QXzyfJ8WWp2KTPn9kXXIXZReQTCKojvmdtyg1BVY3HlFwwTnJ2IEy4
	NQvVItQzr550om7MYqJVrJ2voxymAvmmFHvn7XXcqE/y8L2YhQSBMI6OSWqBoQj1NDOKWRiSVks
	0jzA1XM4zrJ3fxWAR2yYPWA/oCBe2ZNjOZ5wmGycfbv2pJYnMDASSOfzO/5+Xrl0jxKldpBQerB
	iUbfvY5b4u/eoeNxCgyEzgMk+J0Rvo6Ihzszzd+ghbiaeY4H2aOmLwdgaCVrXmZeNp8eWu5q6lj
	BKQ1qaNtYf+7MW4w==
X-Google-Smtp-Source: AGHT+IEWi5m+Ghg5thqpP6Tbwv3QfzbHXoxuM3Nt7npOwXERVYBGsaLrSueX4N5zazzg+EOVFrNx0w==
X-Received: by 2002:a17:902:d48f:b0:295:24c3:8b49 with SMTP id d9443c01a7336-29b6bf5d77dmr426097975ad.46.1764607856591;
        Mon, 01 Dec 2025 08:50:56 -0800 (PST)
Received: from [127.0.0.1] ([20.168.106.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fb2490bcsm12753638a12.2.2025.12.01.08.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:50:56 -0800 (PST)
Message-Id: <ac1627dbd94e3330117fbaeac2e2373104aef531.1764607847.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 01 Dec 2025 16:50:47 +0000
Subject: [PATCH v2 5/5] scalar: document config settings
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add user-facing documentation that justifies the values being set by
'scalar clone', 'scalar register', and 'scalar reconfigure'.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/scalar.adoc | 158 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index f81b2832f8..f1d776ae0b 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -197,6 +197,164 @@ delete <enlistment>::
 	This subcommand lets you delete an existing Scalar enlistment from your
 	local file system, unregistering the repository.
 
+REQUIRED AND RECOMMENDED CONFIG
+-------------------------------
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
+	when reading the index due to the default value of `core.preloadIndex`,
+	which enables parallel index reads.
+
+index.version=4::
+	This index version adds compression to the path names, reducing the size
+	of the index in a significant way for large repos. This is an important
+	performance boost.
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
-- 
gitgitgadget
