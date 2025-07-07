Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7685D2641E3
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914427; cv=none; b=C8LUwYZeTv67VYb337zP7TiyxhxR0glYUXKvrBTuG9psTsLlDcmELTxaPsxfZGxdJsiWOcJ8wbxnkC7RYGmEZxvc1nSZhgZDI7Z6Kzru1HIt2r39C5b7p2EjU94ZSycNlC6UnZLafNsSt0RoSxCW7LmA5TRtxjf2UNfXR58n5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914427; c=relaxed/simple;
	bh=8V/TV82R3vzowqqWhFTC3QvI1vCIjg08tNJxiV9iAaE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=aD9lZAn39A7K9CRvN7XzazWjwbMwY/wI3nwqLsKILGGsBzhqEtisYhme4WPIOqzixFtXDYoPfeN7pBQT87PrsF1lLwXOP/QTxmN3gmdznwQiefi8VFexAYxceyPkF0YxcmXbTqbj/zch2wpZG7XWtRqZet5W5ZU7RZu9y6renvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amkaL8Qk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amkaL8Qk"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso3430930f8f.3
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751914423; x=1752519223; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2llW7Yo3mxNnZNQtjT3vU4dVBN7TwQb9rDmq9eIPMkQ=;
        b=amkaL8QkYcUKqqD42apHAeu7sRkOKhpR0bGdSyzjpb/rg4DbXExic9usBqtvRq5HwD
         P44AQlxyxEMVwh/5fOJFpsZNJeSos7/FGNA70mcsDiOG0q6B6DQO+/+weE3mhMpIcWEF
         oUc0zx3l+dSs7ls8jdL0jX3FMda7uXGr4S3IsAq5Sxw/64Ce5bgRH7ZH4JfJrelVh/nZ
         cmu2IQ7hfYDfOLPruEmglgGxJpor1WFHOSOCGqHD/qraVg5Z9qcAcDTeON4++Nlg4Tam
         yzTb631PT5DtdAAgoZ8IPxJIpbIAWfy9bPBCGGbswOK8EILkr8GFqVXRYLoLSPKQ+NyB
         Ca0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914423; x=1752519223;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2llW7Yo3mxNnZNQtjT3vU4dVBN7TwQb9rDmq9eIPMkQ=;
        b=PQgkp4ha/6gabKVzznQjW3L80XJCLpMtgWlacYqf85LWbr1IjiPHI7b+qlcy8tK0Vu
         xzFEHPN1rDLe/HMiveBDwiL0V8UsQfbPkUa2/Jp3WxnSNMxGFSfAJOubFOZQQ8uoBOIc
         5xMz/sM81fS4Nr7kCuwbyWMUiAcU18ZZwcjTBAz6BBjiX7p83Daj+4/2VHx31mp/nNs/
         WbqsLDv1xdOgK1ltYWM1cOJChKwcErQXdp5NZTkbgqIFS3wMdP5KyyKz4SvYaVm3GiXF
         31A9xR6lPS3t1nIgTKs+FGEoPf+cKoXOuTYhjZbXVNWK/FZnnHcOu5RvB80Y/tPV77dS
         Ne8A==
X-Gm-Message-State: AOJu0Yyl2izA47BTW81o1t2CyX1lZSfCYvqv3WlE+basTaQaxoCfFx+o
	dZOWfRinolcrYSsJ4nLVZyZisJ/X1eakDbXJnRC+hE6ySs4kH88wwpBBi8VlLA==
X-Gm-Gg: ASbGncvMS5U4uYdIypMH9eoO5fMF7RCeM/16qkFslZTn+Lk+TchhqxPB2kJKeMiPkPN
	hqBDUjf9ip7yUFQ4SDnv5juONW8pF0rnBYGP/XMY6406gqWtI35JIdMehuUOZ8qWqwYEmYn2OEI
	mheTfDiLzAriGVduQP6hlTjqUqWP7vHUNPIJ5Yj8WLlugUf+T/Gv2KO1nFCjUBH5DcGyCxU4Md5
	QL4rzlKqGMDZ9ff2wTp7mtLUXPRbpTGq+W+OrMkKj74MrRzU4RtY2Dkl+briZSRShhV8lR7W2by
	2XkOQyKkV3M3sYmgyDIlV2Xg+eEMfkeCd+b6LYES7FdcXSacfH3zNHLUPUsf6yM=
X-Google-Smtp-Source: AGHT+IHW8NJY6cYXyGAd9puyUWJhz9aW+prLs5p7pcsRPbWVtNY+hrsoDEGvf4f+9T68REb8qjq+Nw==
X-Received: by 2002:a05:6000:18a9:b0:3a4:f7af:db9c with SMTP id ffacd0b85a97d-3b49aa8c164mr7324387f8f.59.1751914423193;
        Mon, 07 Jul 2025 11:53:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3a2a93sm327585e9.9.2025.07.07.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:53:42 -0700 (PDT)
Message-Id: <b51d362196458d18394579207bbdf8a01ea56ac3.1751914412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
References: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
	<pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Jul 2025 18:53:32 +0000
Subject: [PATCH v3 9/9] doc: git-log: convert log config to new doc format
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
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.
- Explain possible options in description list instead of in a paragraph.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/log.adoc | 47 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index a9b160e7dee4..16e00e8d296a 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -1,5 +1,5 @@
-log.abbrevCommit::
-	If true, makes
+`log.abbrevCommit`::
+	If `true`, make
 ifndef::with-breaking-changes[]
 	linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1]
@@ -10,62 +10,67 @@ endif::with-breaking-changes[]
 	assume `--abbrev-commit`. You may
 	override this option with `--no-abbrev-commit`.
 
-log.date::
-	Set the default date-time mode for the 'log' command.
-	Setting a value for log.date is similar to using 'git log''s
+`log.date`::
+	Set the default date-time mode for the `log` command.
+	Setting a value for log.date is similar to using `git log`'s
 	`--date` option.  See linkgit:git-log[1] for details.
 +
 If the format is set to "auto:foo" and the pager is in use, format
 "foo" will be used for the date format. Otherwise, "default" will
 be used.
 
-log.decorate::
+`log.decorate`::
 	Print out the ref names of any commits that are shown by the log
-	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
-	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
-	specified, the full ref name (including prefix) will be printed.
-	If 'auto' is specified, then if the output is going to a terminal,
-	the ref names are shown as if 'short' were given, otherwise no ref
-	names are shown. This is the same as the `--decorate` option
-	of the `git log`.
+	command. Possible values are:
++
+----
+`short`;; the ref name prefixes `refs/heads/`, `refs/tags/` and
+	`refs/remotes/` are not printed.
+`full`;; the full ref name (including prefix) are printed.
+`auto`;; if the output is going to a terminal,
+	the ref names are shown as if `short` were given, otherwise no ref
+	names are shown.
+----
++
+This is the same as the `--decorate` option of the `git log`.
 
-log.initialDecorationSet::
+`log.initialDecorationSet`::
 	By default, `git log` only shows decorations for certain known ref
 	namespaces. If 'all' is specified, then show all refs as
 	decorations.
 
-log.excludeDecoration::
+`log.excludeDecoration`::
 	Exclude the specified patterns from the log decorations. This is
 	similar to the `--decorate-refs-exclude` command-line option, but
 	the config option can be overridden by the `--decorate-refs`
 	option.
 
-log.diffMerges::
+`log.diffMerges`::
 	Set diff format to be used when `--diff-merges=on` is
 	specified, see `--diff-merges` in linkgit:git-log[1] for
 	details. Defaults to `separate`.
 
-log.follow::
+`log.follow`::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
 	i.e. it cannot be used to follow multiple files and does not work well
 	on non-linear history.
 
-log.graphColors::
+`log.graphColors`::
 	A list of colors, separated by commas, that can be used to draw
 	history lines in `git log --graph`.
 
-log.showRoot::
+`log.showRoot`::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
-log.showSignature::
+`log.showSignature`::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--show-signature`.
 
-log.mailmap::
+`log.mailmap`::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
 	assume `--no-use-mailmap`. True by default.
-- 
gitgitgadget
