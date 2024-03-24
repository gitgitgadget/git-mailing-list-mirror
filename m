Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A121CD10
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711318746; cv=none; b=QHX/gC6h64w0y/FAjOD1UTn+zM7tKvfrmxU/edZIqtOzsLud/il5ScNk8j0l1CRyf5uEgULrPajB52XH89S626F739elvfF3D2pRUmHNYdp1Z92u7pQd7kbQq8LBMc6Mv7+BBYqJL5WDLsDfOaxF7MZxEvsCr1bSZSQtCOp6bSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711318746; c=relaxed/simple;
	bh=NGN158k92hRt2Kl37HDc+kHDesQlbt82pY92wbroQmI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=ej/yGnsimMp8CBZAAsEzTlXHkiDRtpl6X7jXsUg1h+rNAjxABloBwHtYGglDctm0rIQTU2yz7l0o3S+mkidJvwzLuA2/7Y2K9DQwILk5gG6V3d5TYCL9x+D3ke1dSgXP3sF647Xjfct0uexhKq3D3+gYuRz3Ty1zUk8FRGQbICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1fqh+zs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1fqh+zs"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso2014904f8f.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711318742; x=1711923542; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/PbPxtGJxH+6i9UCvkpYtZlUaH8lXExLAS4SZJsfFE=;
        b=Y1fqh+zs7G8NA/lAXc0hX57Fftq3Kk8nSYTI3ZCPGw9BVLpt4pS9wNgjhdnzpOxBVM
         fGLfecJdK/SRVrr2wJc/274NB8l6UnQs9kMBtjMe4ob4k0RhobQIcJX6GRtLXHQcT+fg
         DDOAkNiR8ui83zw/aIibxDRY/eNYY1RQQXvnyJpbiY/7oGTL2qpgY4f39R9Q8XGMly3u
         SArWyjI693fNCD/Jy1G6V77/B1TW7ZqNh6ntjOzxUbRD/pglSBn8NrwtcsfBQf/gXwpF
         oG0LMvqgXmW+5QLZdWRTBtZq/sluC2SiojaMNy98KaM11aEx0Hc0UclhuFvU/T/Yq7aj
         if4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711318742; x=1711923542;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/PbPxtGJxH+6i9UCvkpYtZlUaH8lXExLAS4SZJsfFE=;
        b=jCHDopJkUTOUavxJrQ62IswsKfB6Yab+qUFrrJIlcMiaY9lD9RAPPQhpPCUhHL4Xkv
         YkTRBdc4nlEKMlSqUDSmbPfX2S/wQ91LzHO9hI8o69CN7to2zHqQDyyJld/U9uaCeWve
         0ZihjOd+MVs9/93XUTaygPL9v1cgReFxPhbj1zgUitkyeabYbMWVxyI5RRwUD8TuLVKX
         t5PfCVwQwMSROcns0NVCLtqutwnv83sh97+ozisLjuahqgMGspzSx5U8Oh+wYXrIiXcD
         hlKfRcrbYhCsrjjIR3ae/mXcUvEEpHj4ZYrV11rXo1yEi6jWjbDLFIz3w6DXWnliLg9g
         jsVQ==
X-Gm-Message-State: AOJu0Yx4DzCck79HrF4wGm9TGm9onk42TIIpRbIbeac5ZEnvpTWtaNso
	jbYAtWFub1i6X83G1zUSZvt8tg/pwBNPXA/EjubtWJxvljLpgSnbj2BKwcV7
X-Google-Smtp-Source: AGHT+IGbXS57aFsUHJat3VEZnLUna5m1zAPdJIic2H9GlkZIUM/kIBCzGc4K8Rpb0vp/J1rSye5xIQ==
X-Received: by 2002:a5d:664c:0:b0:33e:6faf:7740 with SMTP id f12-20020a5d664c000000b0033e6faf7740mr3685409wrw.13.1711318741816;
        Sun, 24 Mar 2024 15:19:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id du4-20020a0560000d4400b00341bdbf0b07sm5575302wrb.50.2024.03.24.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:19:01 -0700 (PDT)
Message-Id: <d08e8bfd9bc548793f8fd403f12fd8126cec1f5d.1711318739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 Mar 2024 22:18:56 +0000
Subject: [PATCH 1/4] doc: rework CodingGuidelines with new formatting rules
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

Literal and placeholder formatting is more heavily enforced, with some
asciidoc magic. Basically, the markup is preserved everywhere.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/CodingGuidelines | 147 ++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 68 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 32e69f798ee..b9e4c7cc19d 100644
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
@@ -682,68 +682,112 @@ Writing Documentation:
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
+ each sub-entity. If they are stuck, a special markup, with an {empty}
+ entity is needed:
+   `--jobs` _<n>_
+   `--sort=`{empty}__<key>__
+   __<directory>__{empty}`/.git`
+   `remote.`{empty}__<name>__{empty}`.mirror`
+
+Synopsis Syntax
 
- When a placeholder is cited in text paragraph, it is enclosed in angle
- brackets to remind the reader the reference in the synopsis section.
- For better visibility, the placeholder is typeset in italics:
-   The _<file>_ to be added.
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
+   `--exec-path`[`=`{empty}__<path>__]
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
+    Do: `--track`[`=`(`direct`|`inherit`)]`
+    Don't: `--track`[`=`(`direct` | `inherit`)]
 
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
@@ -754,39 +798,6 @@ Writing Documentation:
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

