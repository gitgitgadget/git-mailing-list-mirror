Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E343A1D8
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711189; cv=none; b=LzISLS0RyODt9OHfh0cBTq/cXO+omcUfiIBPLaXpFixaFhnrJ4U7Rtecx2Gytg1mImEp3ffBQ3SldGlvOCIr29XlR6dUMRx+bmsZ+CxkLIjghaO/h8fJ+Sugt4rYoSZbzRDEP3R/cbHT6X+M0b1SfTYuO7EEBgb9UpAEH32hyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711189; c=relaxed/simple;
	bh=XrtSr/3URoiUtyELhJi9jCK+oBPCwbt9AUgR7MRE+2o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=hZLGZvIXmiuR/Kdc2m82z2hpv4sVeRTGORIAYN36doATyvN/L8FcUiC/5RH7q5gCJy/PWOS1JXSNk8A10nXJW//OlN3zzdvCgUrHtQ2qxNLWB2ij1Ve/c4e1GIrMkCFRvMZXykrJhUIiXpRCf8eIvT1vDLCNBTVDl9lV8GlTHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8dL1jHg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8dL1jHg"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-341d730bdfcso1643897f8f.1
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711711185; x=1712315985; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdNi7Qbi3ymn5utM1NA35sC9eXP07A6eygj9yMCfALA=;
        b=f8dL1jHg4jbTMPQ1LG6LEdwsdCNhGZ3izT3MNtefewT/etRrY7XJwFho5iAowxFfuz
         ahFIAOWbkHJ+kfWIhmt449T6Yo/SW37h3K8a1lPBKMghFybl+WbP9FhsI7cS718t2xkg
         DcU8EjRB46ilJaQOumaDRwO63JU8F3XwQ0+Rn8A8RlVgxtCgG5yfEP472zbx1Mtpe/PO
         9Gbd/pKbuoC8DfayRVwjSOtzAH63tvlNnBeV7PldLqm96yPCUE2N1JLplm6VRRk7ouwe
         tViNmrMEviGfxrg05Mgu6j/jKbvkVEHfOpXkQiwORUEK4bV9AgihxxqAb5okxYPx1zBC
         epaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711185; x=1712315985;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdNi7Qbi3ymn5utM1NA35sC9eXP07A6eygj9yMCfALA=;
        b=XuwK2Wx3WqN8Ruzh6PKxLFhKTR4ptKkAzpF9txVi9CDY1Zou9kAA/4d/+znWY/D1E4
         AF6QwnSAkHgrxPz+/pHV6kzZArfy/VV/wlP7sdKhLvCDt/a/WvBmyDCS1P68dnqC8AP7
         vHFVgYGduTZKBtIrvzpq7ItZ9aQE06n6WArH0srAW1Llkl+w3S0ywJtRIMnx7rewLDfa
         k+MhhkxyUl1hIL+A8gekGAV7pnse6xbeMwqoqmLdmzl6zE2jdMPMC+U3CC6MJAdYUXBR
         QWB1GaOOAfIx8WhIPJj8dkKlqov9H01H6z3b01LNnJCtTEiDTzcHHWcbrl0NAWrUFvS4
         nTKA==
X-Gm-Message-State: AOJu0YyrgJwqU9XRgPIYLCg0ARbsFI5PEDh+x9EIkeMdjkp3wiLV4/mc
	nJlf2Ln/1z/rcQyPWNr96Dw5V5/bK6soJFPCrK7r+5pPHcvl81bW1TvzSwK2
X-Google-Smtp-Source: AGHT+IH9YQ6sjCEY4jjgvT4fPzENIIxyV4wOcLdbzu5YfeQ2tnrgrykDqVk29sl8yW8bvaC719so6A==
X-Received: by 2002:adf:f48a:0:b0:33e:6833:8fa9 with SMTP id l10-20020adff48a000000b0033e68338fa9mr1499137wro.44.1711711184781;
        Fri, 29 Mar 2024 04:19:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id by4-20020a056000098400b00341babb8af0sm4011790wrb.7.2024.03.29.04.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:19:44 -0700 (PDT)
Message-Id: <8a25ab1c3b61ebea9942fe106d4e0547a81743a4.1711711181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
	<pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 11:19:37 +0000
Subject: [PATCH v2 1/5] doc: rework CodingGuidelines with new formatting rules
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
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    Jeff King <peff@peff.net>,
    Eric Sunshine <sunshine@sunshineco.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Literal and placeholder formatting is more heavily enforced, with some
asciidoc magic. Basically, the markup is preserved everywhere.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/CodingGuidelines | 153 ++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 68 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 32e69f798ee..ab39509d59d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -641,15 +641,15 @@ Writing Documentation:
   - Prefer succinctness and matter-of-factly describing functionality
     in the abstract.  E.g.
 
-     --short:: Emit output in the short-format.
+     `--short`:: Emit output in the short-format.
 
     and avoid something like these overly verbose alternatives:
 
-     --short:: Use this to emit output in the short-format.
-     --short:: You can use this to get output in the short-format.
-     --short:: A user who prefers shorter output could....
-     --short:: Should a person and/or program want shorter output, he
-               she/they/it can...
+     `--short`:: Use this to emit output in the short-format.
+     `--short`:: You can use this to get output in the short-format.
+     `--short`:: A user who prefers shorter output could....
+     `--short`:: Should a person and/or program want shorter output, he
+                 she/they/it can...
 
     This practice often eliminates the need to involve human actors in
     your description, but it is a good practice regardless of the
@@ -659,12 +659,12 @@ Writing Documentation:
     addressing the hypothetical user, and possibly "we" when
     discussing how the program might react to the user.  E.g.
 
-      You can use this option instead of --xyz, but we might remove
+      You can use this option instead of `--xyz`, but we might remove
       support for it in future versions.
 
     while keeping in mind that you can probably be less verbose, e.g.
 
-      Use this instead of --xyz. This option might be removed in future
+      Use this instead of `--xyz`. This option might be removed in future
       versions.
 
   - If you still need to refer to an example person that is
@@ -682,68 +682,118 @@ Writing Documentation:
  The same general rule as for code applies -- imitate the existing
  conventions.
 
- A few commented examples follow to provide reference when writing or
- modifying command usage strings and synopsis sections in the manual
- pages:
 
- Placeholders are spelled in lowercase and enclosed in angle brackets:
-   <file>
-   --sort=<key>
-   --abbrev[=<n>]
+Markup:
+
+ Literal parts (e.g. use of command-line options, command names,
+ branch names, URLs, pathnames (files and directories), configuration and
+ environment variables) must be typeset as verbatim (i.e. wrapped with
+ backticks):
+   `--pretty=oneline`
+   `git rev-list`
+   `remote.pushDefault`
+   `http://git.example.com`
+   `.git/config`
+   `GIT_DIR`
+   `HEAD`
+   `umask`(2)
+
+ An environment variable must be prefixed with "$" only when referring to its
+ value and not when referring to the variable itself, in this case there is
+ nothing to add except the backticks:
+   `GIT_DIR` is specified
+   `$GIT_DIR/hooks/pre-receive`
+
+ Word phrases enclosed in `backtick characters` are rendered literally
+ and will not be further expanded. The use of `backticks` to achieve the
+ previous rule means that literal examples should not use AsciiDoc
+ escapes.
+   Correct:
+      `--pretty=oneline`
+   Incorrect:
+      `\--pretty=oneline`
+
+ Placeholders are spelled in lowercase and enclosed in
+ angle brackets surrounded by underscores:
+   _<file>_
+   _<commit>_
 
  If a placeholder has multiple words, they are separated by dashes:
-   <new-branch-name>
-   --template=<template-directory>
+   _<new-branch-name>_
+   _<template-directory>_
+
+ A placeholder is not enclosed in backticks, as it is not a literal.
+
+ When needed, use a distinctive identifier for placeholders, usually
+ made of a qualification and a type:
+   _<git-dir>_
+   _<key-id>_
+
+ When literal and placeholders are mixed, each markup is applied for
+ each sub-entity. If they are stuck, a special markup, called
+ unconstrained formatting is required.
+ Unconstrained formating for placeholders is __<like-this>__
+ Unconstrained formatting for literal formatting is ++like this++
+   `--jobs` _<n>_
+   ++--sort=++__<key>__
+   __<directory>__++/.git++
+   ++remote.++__<name>__++.mirror++
+
+ caveat: ++ unconstrained format is not verbatim and may expand
+ content. Use Asciidoc escapes inside them.
 
- When a placeholder is cited in text paragraph, it is enclosed in angle
- brackets to remind the reader the reference in the synopsis section.
- For better visibility, the placeholder is typeset in italics:
-   The _<file>_ to be added.
+Synopsis Syntax
+
+ Syntax grammar is formatted neither as literal nor as placeholder.
+
+ A few commented examples follow to provide reference when writing or
+ modifying command usage strings and synopsis sections in the manual
+ pages:
 
  Possibility of multiple occurrences is indicated by three dots:
-   <file>...
+   _<file>_...
    (One or more of <file>.)
 
  Optional parts are enclosed in square brackets:
-   [<file>...]
+   [_<file>_...]
    (Zero or more of <file>.)
 
-   --exec-path[=<path>]
+   ++--exec-path++[++=++__<path>__]
    (Option with an optional argument.  Note that the "=" is inside the
    brackets.)
 
-   [<patch>...]
+   [_<patch>_...]
    (Zero or more of <patch>.  Note that the dots are inside, not
    outside the brackets.)
 
  Multiple alternatives are indicated with vertical bars:
-   [-q | --quiet]
-   [--utf8 | --no-utf8]
+   [`-q` | `--quiet`]
+   [`--utf8` | `--no-utf8`]
 
  Use spacing around "|" token(s), but not immediately after opening or
  before closing a [] or () pair:
-   Do: [-q | --quiet]
-   Don't: [-q|--quiet]
+   Do: [`-q` | `--quiet`]
+   Don't: [`-q`|`--quiet`]
 
  Don't use spacing around "|" tokens when they're used to separate the
  alternate arguments of an option:
-    Do: --track[=(direct|inherit)]
-    Don't: --track[=(direct | inherit)]
+    Do: ++--track++[++=++(`direct`|`inherit`)]`
+    Don't: ++--track++[++=++(`direct` | `inherit`)]
 
  Parentheses are used for grouping:
-   [(<rev> | <range>)...]
+   [(_<rev>_ | _<range>_)...]
    (Any number of either <rev> or <range>.  Parens are needed to make
    it clear that "..." pertains to both <rev> and <range>.)
 
-   [(-p <parent>)...]
+   [(`-p` _<parent>_)...]
    (Any number of option -p, each with one <parent> argument.)
 
-   git remote set-head <name> (-a | -d | <branch>)
+   `git remote set-head` _<name>_ (`-a` | `-d` | _<branch>_)
    (One and only one of "-a", "-d" or "<branch>" _must_ (no square
    brackets) be provided.)
 
  And a somewhat more contrived example:
-   --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]
+   `--diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]`
    Here "=" is outside the brackets, because "--diff-filter=" is a
    valid usage.  "*" has its own pair of brackets, because it can
    (optionally) be specified only when one or more of the letters is
@@ -754,39 +804,6 @@ Writing Documentation:
    the user would type into a shell and use 'Git' (uppercase first letter)
    when talking about the version control system and its properties.
 
- A few commented examples follow to provide reference when writing or
- modifying paragraphs or option/command explanations that contain options
- or commands:
-
- Literal examples (e.g. use of command-line options, command names,
- branch names, URLs, pathnames (files and directories), configuration and
- environment variables) must be typeset in monospace (i.e. wrapped with
- backticks):
-   `--pretty=oneline`
-   `git rev-list`
-   `remote.pushDefault`
-   `http://git.example.com`
-   `.git/config`
-   `GIT_DIR`
-   `HEAD`
-
- An environment variable must be prefixed with "$" only when referring to its
- value and not when referring to the variable itself, in this case there is
- nothing to add except the backticks:
-   `GIT_DIR` is specified
-   `$GIT_DIR/hooks/pre-receive`
-
- Word phrases enclosed in `backtick characters` are rendered literally
- and will not be further expanded. The use of `backticks` to achieve the
- previous rule means that literal examples should not use AsciiDoc
- escapes.
-   Correct:
-      `--pretty=oneline`
-   Incorrect:
-      `\--pretty=oneline`
-
-A placeholder is not enclosed in backticks, as it is not a literal.
-
  If some place in the documentation needs to typeset a command usage
  example with inline substitutions, it is fine to use +monospaced and
  inline substituted text+ instead of `monospaced literal text`, and with
-- 
gitgitgadget

