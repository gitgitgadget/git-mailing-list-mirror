Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E6820B808
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373797; cv=none; b=tHwXHw9XuxW/vMEMI//MiokKz5X6sVfxYjnGHowJ+aAjsVmWYB7iDozmQwQgLK0gFmxh1zQEgFuUHHGnQtXk+an1AhlMW5dUGHBfLEZU9BJqr8K87WXwrbszO72q03c7UT4gVbp8V8oBOq3uXZaKO0qBKiYm2gcyRJAA2AGbz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373797; c=relaxed/simple;
	bh=J+TwI5tDbYwHeK2A0xCKm4Pvj/DfnC6iS8LfliSFnNI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=YHnfjwBRAY7Pp/AxvpGm7xnjzwgbi8SofstDHwB26GwhRCUJArqMWtGiQyK2G1SJhVZ0ARkh59ruXnNCqnZSMBNEjN0m/g3viaMg15DgjK4ugjin4IoDSqAy0oMSwRyNX0mZFxCnwriFPb0OnKOrYIkzphlT3YnldiJU5UuDiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6vH0xjN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6vH0xjN"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d6ade159so28775285e9.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373794; x=1749978594; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnhpyUjyDQE0OcCdmJj/nun6eZs7+oRCT3ZOV1lGdfY=;
        b=O6vH0xjNH5wlmAeBuo8chzrPgbgdm7T6W9aQy10g0ip3yl6I4O0PkymiBaa/oRmsQ1
         OLVQ70jqLuN3f8AiALW51qeHTO4pGl7e15xP057updXHkgwi/R6lW9plMhig/R3PHISY
         nWBY4RTLf3Z/4btUUd54oz3nXqAXIqOKHIMOUcdQL1SfZIyBk11FKsJkuNm90+p6RWgF
         DcmOWgjPyRlPWXeFiBMOm/KBbldzGN66W5GR4CNJprIu1sK6DuC/NDUNdHxE2K2K8kdC
         WP9oHnL6gRvVhKVJkFHVyRAqWZKDuuSm9TBdbm7NyKo/eEBt1SVPMgedcxvG6h5U5VaE
         Yclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373794; x=1749978594;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnhpyUjyDQE0OcCdmJj/nun6eZs7+oRCT3ZOV1lGdfY=;
        b=PJO9crOndTrpSjMOCqdTq5JlNi5lsn5wusMp/jTHYERv8COTsUT1LKA/mrof/9MtRP
         G0oZwJz5Cvsw54eot7EKNup+CNDOTbgak+xFNok2FZWwKDWUmNz4IZgjOjD302p6tsXu
         Z3cfAodtoLDuoNybAZUycgYPL5EMrCdDukDTZ6qGfhCtGnZnx3qHga1t4AzGAqnsfAq0
         hqFx35VtUnfzCKCyCl20Ya+moERinYW8MNxofyGyIAU4YClWhfCogFnGa514RbLmT+a3
         fgwVlmYak6iXqFxkiQi/+6BMnI2lv35Uc4LPzJbopva05+6D5bpFi1z8CC6gigZd7W5c
         yxoQ==
X-Gm-Message-State: AOJu0Yz0NzjZNzBEDiL83z2B5LWPgyvzj9H5ztSV+1CGuXxREPi9ScdD
	q0WzZoOw4EzScvPZpMrxO816D86CewUkuTs0jIkCk1wMnHww4aZ/JhwxuzWcDw==
X-Gm-Gg: ASbGncs6LpzUS9nyPebus/XM+dT1rwQDge2BZCb1Mfb2ivQ1o1zjEkAR4Or3HBGZGBb
	S/979wnZH6AosEyiENwixwwgBIpkJiJptCqPk1Q+iHFouvU+4TXVGC73ZMMnGoOPQfs+C02FhPG
	5554AN8GpPTzmyPojF9S12x1UbM7tkoI4oQwQQKzOB+tpr7B+XIlwLsyNnRbgjrvLRpgtxoCNqy
	v3X9/SwUgqQ5Lnz09obtaEEuSh5uCdbPMwjZwYQGQg6UY8CO+WxR4K+eXbNkiuE1y4YKWuTyHF7
	f+FATftSUqSkjVCxhZyAXtfKTqguq4LiCdqoasDgx6hg5HI4ZR3LSiIguFvNd8s=
X-Google-Smtp-Source: AGHT+IHIILh9BpBP4kiGy8zpq1BlSO9Lck+vDat+N9lHxsA36OOcww84c+wtFiOWX9ko0wsXvh0DQA==
X-Received: by 2002:a05:600c:3504:b0:453:1058:f8aa with SMTP id 5b1f17b1804b1-45311481a39mr2744345e9.15.1749373793478;
        Sun, 08 Jun 2025 02:09:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45306b01d77sm31936365e9.31.2025.06.08.02.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:09:53 -0700 (PDT)
Message-Id: <5004a622c3f492dd1de8b2952ba24bf5e82f6f3c.1749373787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 09:09:43 +0000
Subject: [PATCH 6/9] doc: git-log: convert pretty options to new doc format
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

- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/pretty-options.adoc | 71 ++++++++++++++++---------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/Documentation/pretty-options.adoc b/Documentation/pretty-options.adoc
index 23888cd612c9..061e7b97f17a 100644
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
+format.  When `=<format>` part is omitted, it defaults to `medium.
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
 	for `git log`, `git show` and `git whatchanged` commands when
@@ -75,28 +75,29 @@ to display.  The ref can specify the full refname when it begins
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

