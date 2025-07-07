Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2B26658F
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914424; cv=none; b=Q+aD3en7GVH6ng2ZSjyMPE8X5yVMQkH1CHgWTC/1c+pV8zyMB7fDyVtU/kOfEWHE5npzAxF3903lsMjypsHeIbvXG3hnXqJQhy0wIvHAByvkcbJ1y5l+SLBuryxFsGPkb/ICrn0a9H2pv0xrmMAIprwEj6h5en1ACYnLiuDh06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914424; c=relaxed/simple;
	bh=z1jTnp47JYDfhk6Zysr7GbCjVH0It4QxTAfTp2vyJes=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=OR6x8AQxWtvYbtOL4hqIzZ0KXTmNi6qSQqPZnhCIswogHbNt0YOLpIZR0YagqKjBCVYOg4gCD5I2yxuEv8f3+r83M4ffj6Rb4wV3nPR6H/Sik+Ne3CNazXQ9XpDDQB0MYjMLxnn4yfe8qtnyi7su5p6FxFGnpkWq5e5atLuMjZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOWSihVD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOWSihVD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso3430902f8f.3
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751914421; x=1752519221; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kDAea3AxfvxLUeMcQRI7Yju0kw/Gtuy5ixe4kJjhgE=;
        b=JOWSihVDnGzZ8STQbV5gudZ9vm1XWOKB5S4VoV9xrLeao8EH2Jsreb1/Wu9WkOBehu
         LJuPQRUxmsyxGjIBqibpTtOwuDIPOJ8mO5eMU52+A4FulHJt4tsMCHP0jMRsgE8dv6de
         G74sKa9dsBoKaXF9c4rfwwNmljskx+IIGf+S+t7ZaSxVDiFMOTADK2XwxFVZqX2PJsrq
         pftecvQCQyBm/97m+jJrO5dJT8jLXCxA1jfuTT9TBLQT8HLZ+Z1aR3kXZuxUwsalNtS+
         1p4MCZ8ZIMFEwpRD4kAweOdULAI+GP3CLr1Xapm9sju5IrJchlYwwGRK7RftQ+jIZ2EW
         EQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914421; x=1752519221;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kDAea3AxfvxLUeMcQRI7Yju0kw/Gtuy5ixe4kJjhgE=;
        b=aBKaHn8plElFoNk8yLAlk3orUJSOJOODYoXRSwG6SekqGpO6PWb8d+dLfhL1YrwWpk
         ofP72r7GL6I7eWe1WztGkmHY07PryJ/FloDLxL+Qe3hvLDHDQwhJRx1Ca2CkcKe0e8zm
         C+TqllnSRma+Uh9o6tUtfgoIytNnLq6FUvmT66H4hZFCRV5+sWzt63cZyH6Ql3K8+uY4
         w8SFW8N0e2sNGIXUaGL15liYQLyPUmYG1Ou5fMvP8KQdMfESNiU+PMUYf7289s+kkpU9
         uGPOYgEEtQuHvtZSVrfao93YQFuPZ4ZeJohdl0BRbLTtYHYrRXc385hPpF4nRa6x3t8F
         fchw==
X-Gm-Message-State: AOJu0YxjVLFX//qP3j/GSV7OoZZ3hM4pip2uunMt9pscr5DQVtDU9igu
	3r8S4Tc03jzYbx/kJFLiezHEeNbO+I0/4QlvUQlZZPzvJPPBDqPKQLLlxNNBVw==
X-Gm-Gg: ASbGncudVPRWeG3JFzsNWkrmCseqL2IRa727yfbwbZrj/D79MkbLDvRP4kDWBpvxrgW
	i1dQaDRsR5M3H85zjFOEVC1VT4Rq/MBGLaFUg08j5bBb8Yf3UJ93V38PQxnuYEdID85YDYR93qB
	oJYpmQJjrRgSSQtO+VPfnwI3noJPnVe4UEkhxND8E+nn7EjeWBg1GRAqphghPxZh3OryOqM2hz9
	aV4HR0gUrZP0KHiBhbhUgtFBNmevcV8bZpHTCeDVDJWjjMvSzbQE9Zh7flYCCPWkUYtVxhZd3Y6
	EOdqkB5zmGvrRqDJTJsLfPo9M97ebg3zW8vTtzBJp8fCeHc8ym7QCknlRkBQsBg=
X-Google-Smtp-Source: AGHT+IEQi+ik8w5qLJVxU1zeSziWNrmujI9u1nEFSY6qfqEvs1mcArYFl1eJNYiVS+b3GuJnEoAYog==
X-Received: by 2002:a5d:5888:0:b0:3a4:d722:5278 with SMTP id ffacd0b85a97d-3b49aa7aa5emr9173788f8f.39.1751914420449;
        Mon, 07 Jul 2025 11:53:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97732sm11258437f8f.59.2025.07.07.11.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:53:40 -0700 (PDT)
Message-Id: <b860561069dfaad419ba36d375f54018638df859.1751914412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
References: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
	<pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Jul 2025 18:53:29 +0000
Subject: [PATCH v3 6/9] doc: git-log: convert pretty options to new doc format
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

- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/pretty-options.adoc | 71 ++++++++++++++++---------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/Documentation/pretty-options.adoc b/Documentation/pretty-options.adoc
index b36e96abe28a..8aac51dbe7e9 100644
--- a/Documentation/pretty-options.adoc
+++ b/Documentation/pretty-options.adoc
@@ -1,38 +1,38 @@
---pretty[=<format>]::
---format=<format>::
+`--pretty[=<format>]`::
+`--format=<format>`::
 
 	Pretty-print the contents of the commit logs in a given format,
-	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'reference', 'email', 'raw', 'format:<string>'
-	and 'tformat:<string>'.  When '<format>' is none of the above,
-	and has '%placeholder' in it, it acts as if
-	'--pretty=tformat:<format>' were given.
+	where '<format>' can be one of `oneline`, `short`, `medium`,
+	`full`, `fuller`, `reference`, `email`, `raw`, `format:<string>`
+	and `tformat:<string>`.  When _<format>_ is none of the above,
+	and has `%<placeholder>` in it, it acts as if
+	`--pretty=tformat:<format>` were given.
 +
 See the "PRETTY FORMATS" section for some additional details for each
-format.  When '=<format>' part is omitted, it defaults to 'medium'.
+format.  When `=<format>` part is omitted, it defaults to `medium`.
 +
-Note: you can specify the default pretty format in the repository
+NOTE: you can specify the default pretty format in the repository
 configuration (see linkgit:git-config[1]).
 
---abbrev-commit::
+`--abbrev-commit`::
 	Instead of showing the full 40-byte hexadecimal commit object
 	name, show a prefix that names the object uniquely.
-	"--abbrev=<n>" (which also modifies diff output, if it is displayed)
+	`--abbrev=<n>` (which also modifies diff output, if it is displayed)
 	option can be used to specify the minimum length of the prefix.
 +
-This should make "--pretty=oneline" a whole lot more readable for
+This should make `--pretty=oneline` a whole lot more readable for
 people using 80-column terminals.
 
---no-abbrev-commit::
+`--no-abbrev-commit`::
 	Show the full 40-byte hexadecimal commit object name. This negates
 	`--abbrev-commit`, either explicit or implied by other options such
-	as "--oneline". It also overrides the `log.abbrevCommit` variable.
+	as `--oneline`. It also overrides the `log.abbrevCommit` variable.
 
---oneline::
-	This is a shorthand for "--pretty=oneline --abbrev-commit"
+`--oneline`::
+	This is a shorthand for `--pretty=oneline --abbrev-commit`
 	used together.
 
---encoding=<encoding>::
+`--encoding=<encoding>`::
 	Commit objects record the character encoding used for the log message
 	in their encoding header; this option can be used to tell the
 	command to re-code the commit log message in the encoding
@@ -44,22 +44,22 @@ people using 80-column terminals.
 	to convert the commit, we will quietly output the original
 	object verbatim.
 
---expand-tabs=<n>::
---expand-tabs::
---no-expand-tabs::
+`--expand-tabs=<n>`::
+`--expand-tabs`::
+`--no-expand-tabs`::
 	Perform a tab expansion (replace each tab with enough spaces
-	to fill to the next display column that is a multiple of '<n>')
+	to fill to the next display column that is a multiple of _<n>_)
 	in the log message before showing it in the output.
 	`--expand-tabs` is a short-hand for `--expand-tabs=8`, and
 	`--no-expand-tabs` is a short-hand for `--expand-tabs=0`,
 	which disables tab expansion.
 +
 By default, tabs are expanded in pretty formats that indent the log
-message by 4 spaces (i.e.  'medium', which is the default, 'full',
-and 'fuller').
+message by 4 spaces (i.e.  `medium`, which is the default, `full`,
+and `fuller`).
 
 ifndef::git-rev-list[]
---notes[=<ref>]::
+`--notes[=<ref>]`::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
 ifndef::with-breaking-changes[]
@@ -80,28 +80,29 @@ to display.  The ref can specify the full refname when it begins
 with `refs/notes/`; when it begins with `notes/`, `refs/` and otherwise
 `refs/notes/` is prefixed to form the full name of the ref.
 +
-Multiple --notes options can be combined to control which notes are
-being displayed. Examples: "--notes=foo" will show only notes from
-"refs/notes/foo"; "--notes=foo --notes" will show both notes from
+Multiple `--notes` options can be combined to control which notes are
+being displayed. Examples: "`--notes=foo`" will show only notes from
+`refs/notes/foo`; "`--notes=foo --notes`" will show both notes from
 "refs/notes/foo" and from the default notes ref(s).
 
---no-notes::
+`--no-notes`::
 	Do not show notes. This negates the above `--notes` option, by
 	resetting the list of notes refs from which notes are shown.
 	Options are parsed in the order given on the command line, so e.g.
-	"--notes --notes=foo --no-notes --notes=bar" will only show notes
-	from "refs/notes/bar".
+	"`--notes --notes=foo --no-notes --notes=bar`" will only show notes
+	from `refs/notes/bar`.
 
---show-notes-by-default::
+`--show-notes-by-default`::
 	Show the default notes unless options for displaying specific
 	notes are given.
 
---show-notes[=<ref>]::
---[no-]standard-notes::
-	These options are deprecated. Use the above --notes/--no-notes
+`--show-notes[=<ref>]`::
+`--standard-notes`::
+`--no-standard-notes`::
+	These options are deprecated. Use the above `--notes`/`--no-notes`
 	options instead.
 endif::git-rev-list[]
 
---show-signature::
+`--show-signature`::
 	Check the validity of a signed commit object by passing the signature
 	to `gpg --verify` and show the output.
-- 
gitgitgadget

