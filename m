Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA931B12CD
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573134; cv=none; b=hnxEvuDNado7sNc7z3LOzhm0DxtRUQdO9r/IwlvwCnrE6R+zI+ZP5eZj6J/p15ptpUnLrhAR4Ly+KPaG4zPCSsr9Gq+NP+Mmj2xSPlNBkbtXd2oH4xq4Wb9ffo/98SAGnuh289Fgk246ctKspLkrQXF6dtUJVTHwIykqpdJ0NT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573134; c=relaxed/simple;
	bh=Sw5Zoox1wS11AVda86kU7lPpxL1cDrsRx5Lzxf0anNQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=FBFG8/YdxXD7R+RHwipgHZY7MexW6fwogabVtr3qR0LphVQ2UgC82Au+8OP9R3L5aOsjTfSnjfThqvxstlrHLTXwM2gHmg3hYBb5j3akW3qcEc4cMDYdhG3LF1TyrIPEY1vuqPDDRaae8wXfXcWNzqdqZ9XG6BfCQ+t3TIutiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+CnZ/vm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+CnZ/vm"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3f0bdbcd9so14985281fa.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725573130; x=1726177930; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD/05PhIVrHN/74im8C/+sMenNig6tZVrRnSWf10004=;
        b=c+CnZ/vmwaINE6En1lhCB6z/tXT/2flni19JjOq6Qm1KAxj7jCZ2C8NAQhoHMElzer
         yyD1Lv+2pIovKLjjWzzh9E8Yi//oFTCqP+J7nO4m/cIV7JLDUefRfl2ZtOGZH68iQq6w
         X7zlNVr6Q8lCydMfUWQtrnbERRi85cz1XUuPHYbJNSWqlhh9/PIbvwm1l8kUfBlCBQjJ
         L1z28yrZHBDz9Oou6YeAyHQxhoYsP/28aGuRoidDQeA9B2PjyfpALFdJVXB7U6it6wd6
         hHlkdSbw0rPn6IlGyutJc1iTqoiQcZ8qTlZoDGv+ES5akM6GPEsb8W/tJjr6LHNSjBYP
         faYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573130; x=1726177930;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD/05PhIVrHN/74im8C/+sMenNig6tZVrRnSWf10004=;
        b=hhhubuzQZGEh6sdzcA17vsviCrWKrl5C8rD0+hJjcgzL6iRV8GHKzy1ZecFBONMoOZ
         7oyx3EU1MR9DklaAenknkqVS3WF4lcpxw6MrICEwAjSTIGREeIvB+A2rezNJYNU8SKfv
         qffdp3nmLjKuxbTWjI5YTQX9QBxUliAeAfkmnH5mT9ANGrvcviuAcWtpmFQhNYxa7K/Z
         N1aE2dtT58flqdSdFEOYg9irWxBhniX3uuNythWYb9wYHHgJdEi8JE383BQYbLZcPAQM
         8FtW8VNFvG3KL75NDQQ1rVHWHAc3SnJqpsOWxne7Ys4DlfJfqE8vVl/iuTrZQFVulT4W
         Zd8g==
X-Gm-Message-State: AOJu0YwbmylggcRFj4LQcUrsV8aj6gmSGafKFyjRcjNOpjwSaWkzLDld
	GgWFAXl595mHZl5atxDO0fpkbPqUuoJMHAJQ96Wp9EeWmLUsuOav+3be6w==
X-Google-Smtp-Source: AGHT+IHlJelj7RAbF/xal/6ohy9G9c4xMiYYwxSIoBRGMTm4Ch/Vim3HNDlkOQeObJqbpVJvk8HPZg==
X-Received: by 2002:a2e:4609:0:b0:2f7:51a2:96f2 with SMTP id 38308e7fff4ca-2f751eb2584mr2125651fa.8.1725573129373;
        Thu, 05 Sep 2024 14:52:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc528ecasm1692611a12.1.2024.09.05.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:52:08 -0700 (PDT)
Message-Id: <c48649ccd63bf8388c548f18bca545beca9bb41e.1725573126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
	<pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 21:52:05 +0000
Subject: [PATCH v4 2/3] doc: update the guidelines to reflect the current
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

