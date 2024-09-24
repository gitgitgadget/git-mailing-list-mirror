Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4AD12C544
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161738; cv=none; b=sNdUPBrLQ/Xz7+tGi9OWDwTCjV58/7vtQzsVWjCD73Vu4VVpW/Dk5Hltq6SZ31fzRnzsebVJrKJnzIg6dF+GrCM85NxIh6pswGhMM6LAxM6dwSO8nFkiWzXpo1aqUVUbJlRLfgq8D0dTpxp9JoCihDcKBKKYhZFhi7qr0JR6qoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161738; c=relaxed/simple;
	bh=Sw5Zoox1wS11AVda86kU7lPpxL1cDrsRx5Lzxf0anNQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=R2lNpwrbDWfY0CJAX1agemNrGCKf+CyGQUBVgmPd2GDdRGpTotwpprUBhAIb7m0d/7e1u2LW+uFSbEWds4zNbn+dFDHkouP3zoL1QWw3X1hXA42V24c2OVb+FzBGoJ9CvrYgNj1lLodNZi9DUdXVSYy6P0L0AkzQbvOqCQ4VSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVPVsWoK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVPVsWoK"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so161014366b.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 00:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727161735; x=1727766535; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD/05PhIVrHN/74im8C/+sMenNig6tZVrRnSWf10004=;
        b=EVPVsWoKTz3WAzY51aU3D50wJHXjTv7/cbMZ547Lkph1UzyS6peWf+CB9+goGrqIaf
         XwesJ12Q2r371dacMnmXkbvO6PxYUjk17h1R1sgWu60SC3RqXDK89UlCTeviBU+sNtqP
         XS02cSe5uEGQIAvMchtJvxq2Baj7bQDxc/p7bqUd9YSno/BCgeX7L8XqiGYc2864U9Qx
         jA53JDr9EVKMNeGlYDqxbIjvZQTDnDZa2LfNKXstOcrd5xVndWy7CLWTqOwVs6wiAZe/
         Zk7Wm5q7NKOD2Zq9gSEIiq7vHheb7n1ZaO9f48JE+/SfbQrNclxjU05Z0FQ5t40J+xvF
         p6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727161735; x=1727766535;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD/05PhIVrHN/74im8C/+sMenNig6tZVrRnSWf10004=;
        b=hpmilV/s9YCQFfl8vUBBK/tJjuqtWh4j5jJtHVqzO7wyOjLXdI3A6GeEqNY5CHCqz1
         iJVDvuBIMfUL59xOrb1LqlCEZv3UTgrSO2U+9yUebGxSzSpxjWpmdtFKtV2ahtxQzSeC
         Ir1I2wwl10JCoMMmtLRjFFnjNdsFk4x1JxBqBfgIDu0ti5ZcxZ0xvrKAB8PFu62Y9Fuy
         sjKCsmWmfq/AA5uun36YQxGy3Kv2QvIwSfcdn6Mb12hpP6n/Ei+sJCZCfypS/l7pFZe/
         N2bkMZ4VSh5HApsrVizxKHYy+MU8aUtL6gL206E3S9sb7mxF23OqznsNT2ToxmrwJUz8
         eH9Q==
X-Gm-Message-State: AOJu0YxrWwTEQGCf/l5l7c1jIK2TVqRjc11lSMvZvDWMdUz1PWh14WDY
	YnqK8tgFp8ZGFZtuq+Z2v707NS0r7M0kx2m5yG0eqgJ8kQiMfIH7nT0dSA==
X-Google-Smtp-Source: AGHT+IGrX2oP1eUN2AZVU/l7EcqagIWOrZnFUM1tKseOThrWAYJOCg7qUFJgf+JoGLrPid/Ll7pPMw==
X-Received: by 2002:a17:907:7da6:b0:a91:1592:f5c5 with SMTP id a640c23a62f3a-a92c4810e00mr235762066b.10.1727161734436;
        Tue, 24 Sep 2024 00:08:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930caf50sm47906166b.106.2024.09.24.00.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:08:53 -0700 (PDT)
Message-Id: <06b8fff6a57642aa0f6853528c00b8c30896842d.1727161730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>
References: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
	<pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 07:08:49 +0000
Subject: [PATCH v5 2/3] doc: update the guidelines to reflect the current
 formatting rules
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Josh Steadmon <steadmon@google.com>,
    Chris Torek <chris.torek@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/CodingGuidelines | 58 ++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index ccaea39752c..13cbcf1d7a5 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -820,78 +820,80 @@ Markup:
    _<new-branch-name>_
    _<template-directory>_
 
- A placeholder is not enclosed in backticks, as it is not a literal.
-
  When needed, use a distinctive identifier for placeholders, usually
  made of a qualification and a type:
    _<git-dir>_
    _<key-id>_
 
- When literal and placeholders are mixed, each markup is applied for
- each sub-entity. If they are stuck, a special markup, called
- unconstrained formatting is required.
- Unconstrained formating for placeholders is __<like-this>__
- Unconstrained formatting for literal formatting is ++like this++
-   `--jobs` _<n>_
-   ++--sort=++__<key>__
-   __<directory>__++/.git++
-   ++remote.++__<name>__++.mirror++
+ Git's Asciidoc processor has been tailored to treat backticked text
+ as complex synopsis. When literal and placeholders are mixed, you can
+ use the backtick notation which will take care of correctly typesetting
+ the content.
+   `--jobs <n>`
+   `--sort=<key>`
+   `<directory>/.git`
+   `remote.<name>.mirror`
+   `ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>`
 
- caveat: ++ unconstrained format is not verbatim and may expand
- content. Use Asciidoc escapes inside them.
+As a side effect, backquoted placeholders are correctly typeset, but
+this style is not recommended.
 
 Synopsis Syntax
 
- Syntax grammar is formatted neither as literal nor as placeholder.
+ The synopsis (a paragraph with [synopsis] attribute) is automatically
+ formatted by the toolchain and does not need typesetting.
 
  A few commented examples follow to provide reference when writing or
  modifying command usage strings and synopsis sections in the manual
  pages:
 
  Possibility of multiple occurrences is indicated by three dots:
-   _<file>_...
+   <file>...
    (One or more of <file>.)
 
  Optional parts are enclosed in square brackets:
-   [_<file>_...]
+   [<file>...]
    (Zero or more of <file>.)
 
-   ++--exec-path++[++=++__<path>__]
+ An optional parameter needs to be typeset with unconstrained pairs
+   [<repository>]
+
+   --exec-path[=<path>]
    (Option with an optional argument.  Note that the "=" is inside the
    brackets.)
 
-   [_<patch>_...]
+   [<patch>...]
    (Zero or more of <patch>.  Note that the dots are inside, not
    outside the brackets.)
 
  Multiple alternatives are indicated with vertical bars:
-   [`-q` | `--quiet`]
-   [`--utf8` | `--no-utf8`]
+   [-q | --quiet]
+   [--utf8 | --no-utf8]
 
  Use spacing around "|" token(s), but not immediately after opening or
  before closing a [] or () pair:
-   Do: [`-q` | `--quiet`]
-   Don't: [`-q`|`--quiet`]
+   Do: [-q | --quiet]
+   Don't: [-q|--quiet]
 
  Don't use spacing around "|" tokens when they're used to separate the
  alternate arguments of an option:
-    Do: ++--track++[++=++(`direct`|`inherit`)]`
-    Don't: ++--track++[++=++(`direct` | `inherit`)]
+    Do: --track[=(direct|inherit)]
+    Don't: --track[=(direct | inherit)]
 
  Parentheses are used for grouping:
-   [(_<rev>_ | _<range>_)...]
+   [(<rev>|<range>)...]
    (Any number of either <rev> or <range>.  Parens are needed to make
    it clear that "..." pertains to both <rev> and <range>.)
 
-   [(`-p` _<parent>_)...]
+   [(-p <parent>)...]
    (Any number of option -p, each with one <parent> argument.)
 
-   `git remote set-head` _<name>_ (`-a` | `-d` | _<branch>_)
+   git remote set-head <name> (-a|-d|<branch>)
    (One and only one of "-a", "-d" or "<branch>" _must_ (no square
    brackets) be provided.)
 
  And a somewhat more contrived example:
-   `--diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]`
+   --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]
    Here "=" is outside the brackets, because "--diff-filter=" is a
    valid usage.  "*" has its own pair of brackets, because it can
    (optionally) be specified only when one or more of the letters is
-- 
gitgitgadget

