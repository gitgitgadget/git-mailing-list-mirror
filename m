Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07A1D90DF
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972637; cv=none; b=W1DItHSU+MJQac6/fxZzJ9kVCXrNjkPvB8HYL/64SC9Fln7IODSpU/kNclmo2QZQ6z4RmeOQPEZW9OaclHkAHP1lmuGtcV6vmfM7NQFOdhlVSCPiYLnC7wAzcFLi2NUtXM/EU8r9puC0KpzUzz9GqVf/0opAC1Id/biJBGKHs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972637; c=relaxed/simple;
	bh=1+qaz7P0KKY6t735LAfh7R0uHij4tAU09pyFKt5z/1o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=HSkcIRlUiY26qyZj+5SmU6iOKIjBGQWeJjXNaZ8THN67sDl8/2dxjflco+2qDroweAgFXoD0ZPGRI2AqGRXVjSAvfmBd0Q1swEpbwjX0ttzfiIQ4uynP5fS6qRdbqoScZOh/bsDBufU4Bwq4T6BG3h3cljz4OI5Hp2OkvuOFGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMiHOrjc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMiHOrjc"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so136114f8f.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736972634; x=1737577434; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs3JHoYTc48IEYhkKsU1dsQt8VPmP4m4L4qPvQZiUFg=;
        b=YMiHOrjcvBwj3gmdEeDqC/czwOQNXrbT5BEF+Y0qwuq/RbwsGBAg1k9pbSM9bbqEso
         Bc0YSfZj1CFgJo7epOv9Mx4NldyOzwap1TYdVLZtKtyiK710ZDW8jLzddPNOqja8/7Ro
         nbNeMl11WYBY4rHqyCN+Y1vIzYarwH+G5s/UzDaYWsixM1BxCNLYiq8XIp0/0B8M01++
         i7vxN0m9Z7OZMMijtVwTkVCp8MQe0OUkb0veRp54TaIfsoO3iIVdCAS44Qvd2M/gGXAF
         lw4ItywE6gpEym7gQD8Ud9ND3rlUeyjYEJ6Gcab/G2XSKfbn0UnoE1XzBBcfPBxNeH6a
         19mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972634; x=1737577434;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs3JHoYTc48IEYhkKsU1dsQt8VPmP4m4L4qPvQZiUFg=;
        b=iCTEQwiVcuHYlk1oaz/DwZGYC8ECHXWA0PElfxXbdJeYyWLSo13msiQuIfWIQtgZv9
         SCS24bvCiTc3GnpnbrCPpLtZnxaDF50wAojimFlJQ6a/IeclOVMRFmBXTadPQRx0k5SJ
         Vqe6Taqshc4ev2Gfn92RJwAIcoVgQU7u33LimOT2PRT1wTtNgXXVTd+B+t6wbaB+mqIm
         7eCd58/U1HAqihqR+4EvG8A9LzFAy+EaZTjS29+kdgi4gKf0l+fLFY1GrBzPISjG8xHC
         jXbAea4w1/FTQLd4CMmNuRzXR8iyVHmcxXjm8GhRxAUxts4XLukclNjxK9phlfNzIekt
         vkDA==
X-Gm-Message-State: AOJu0Yz+b91Dz9QE3bmSOFl2NfPyTr1QmWvLRtbmyr/0T3JnKfXh9RGC
	sBzuuH3SlvtQd7Ll2Nqd+8sfsfjZIgq7CIgkTpbeBQV0ZFbK62g8PvjlEA==
X-Gm-Gg: ASbGncuUmlZO4yY/JAqjezUUrAxlv+/CNpavP5tAeuvDSbIwXENZzvcfg47D4aDihYM
	hyb/0TsVRPOiP2eLdzqCFS8hyV590w/yMlE3EyWKMqCa4q2PkK/cZnsAyyXLPwUoRRQPwKUD0Bc
	L9BxThP2B6oNk3oULyz/6cZ9DcyIpiVKLon7WxTlSCYkUJG2yyIpQthrarp8Dzn+ISEC61SJWDs
	bd/50WTTxHPbmYxs2wW//CvGXXi2tKtRABPCI7hqll3Vd7vjqHCJADKOA==
X-Google-Smtp-Source: AGHT+IGRA84I3Tj17CLfklQYSmSx5empc3fBrfd6hqpxhsjnzLYsVIrP925iEHcYtN04DMycpEhr7A==
X-Received: by 2002:a5d:47c4:0:b0:38a:41f8:8abf with SMTP id ffacd0b85a97d-38a87312917mr29245269f8f.31.1736972633427;
        Wed, 15 Jan 2025 12:23:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74ac5f9sm34010105e9.11.2025.01.15.12.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:23:52 -0800 (PST)
Message-Id: <39db87ff906744f45ef83d9d66fb914417c350a9.1736972628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
	<pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jan 2025 20:23:46 +0000
Subject: [PATCH v2 3/5] doc: make more direct explanations in git commit
 options
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
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Use imperative mood
- make use of the placeholder format to simplify style

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-commit.txt | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f5d702205d2..602e2f1200b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -66,7 +66,7 @@ OPTIONS
 -------
 `-a`::
 `--all`::
-	Tell the command to automatically stage files that have
+	Automatically stage files that have
 	been modified and deleted, but new files you have not
 	told Git about are not affected.
 
@@ -166,7 +166,7 @@ See linkgit:git-rebase[1] for details.
 
 `-F <file>`::
 `--file=<file>`::
-	Take the commit message from the given file.  Use '-' to
+	Take the commit message from _<file>_.  Use '-' to
 	read the message from the standard input.
 
 `--author=<author>`::
@@ -181,7 +181,7 @@ See linkgit:git-rebase[1] for details.
 
 `-m <msg>`::
 `--message=<msg>`::
-	Use the given <msg> as the commit message.
+	Use _<msg>_ as the commit message.
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
 +
@@ -190,7 +190,7 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 `-t <file>`::
 `--template=<file>`::
 	When editing the commit message, start the editor with the
-	contents in the given file.  The `commit.template` configuration
+	contents in _<file>_.  The `commit.template` configuration
 	variable is often used to give this option implicitly to the
 	command.  This mechanism can be used by projects that want to
 	guide participants with some hints on what to write in the message
@@ -213,8 +213,7 @@ include::signoff-option.txt[]
 
 `-n`::
 `--[no-]verify`::
-	By default, the pre-commit and commit-msg hooks are run.
-	When any of `--no-verify` or `-n` is given, these are bypassed.
+	Bypass the `pre-commit` and `commit-msg` hooks.
 	See also linkgit:githooks[5].
 
 `--allow-empty`::
@@ -224,13 +223,12 @@ include::signoff-option.txt[]
 	is primarily for use by foreign SCM interface scripts.
 
 `--allow-empty-message`::
-       Like `--allow-empty` this command is primarily for use by foreign
-       SCM interface scripts. It allows you to create a commit with an
-       empty commit message without using plumbing commands like
-       linkgit:git-commit-tree[1].
+	Create a commit with an empty commit message without using plumbing
+	commands like linkgit:git-commit-tree[1]. Like `--allow-empty`, this
+	command is primarily for use by foreign SCM interface scripts.
 
 `--cleanup=<mode>`::
-	This option determines how the supplied commit message should be
+	Determine how the supplied commit message should be
 	cleaned up before committing.  The '<mode>' can be `strip`,
 	`whitespace`, `verbatim`, `scissors` or `default`.
 +
@@ -259,10 +257,9 @@ variable (see linkgit:git-config[1]).
 
 `-e`::
 `--edit`::
-	The message taken from file with `-F`, command line with
-	`-m`, and from commit object with `-C` are usually used as
-	the commit log message unmodified. This option lets you
-	further edit the message taken from these sources.
+	Let the user further edit the message taken from _<file>_
+	with `-F <file>`, command line with `-m <message>`, and
+	from _<commit>_ with `-C <commit>`.
 
 `--no-edit`::
 	Use the selected commit message without launching an editor.
@@ -320,7 +317,7 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	paths are also not required, and an empty commit will be created.
 
 `--pathspec-from-file=<file>`::
-	Pathspec is passed in _<file>_ instead of commandline args. If
+	Pass pathspec in _<file>_ instead of commandline args. If
 	_<file>_ is exactly `-` then standard input is used. Pathspec
 	elements are separated by _LF_ or _CR_/_LF_. Pathspec elements can be
 	quoted as explained for the configuration variable `core.quotePath`
-- 
gitgitgadget

