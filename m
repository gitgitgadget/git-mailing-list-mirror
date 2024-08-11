Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4E14885E
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723389620; cv=none; b=NoISG4vx77Utyx2y8vhAPmivab1wppYUm2W/0NAT2BJek60yQxj1ABUd30CysZxxOBIXIkFaxm4b8Qfxw753Mg7uk06clFDOGJQHdq02kBxIXt0qc5CPDq2JDztsh4UVF+O+VcV1WQgeIMB8kokGvebnU4WXz3nVTivrWD1HGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723389620; c=relaxed/simple;
	bh=Mv8LLa9xkGpJCZgQ/e/AkUJaF+eIqI+xO6XvxwA9PnE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=FSd0+Z14SILbU9TIkrs2bYcOvAGh6gKDFSI3d+I+0M9Ba/ZYMbfGiQZfHmGSxVOPPD/zuD7PXqftjAU2keusNr3qN9cBteUSs32zfv/FDg+qgdpJ3ovNOhETMdYC7wY7is9AyRTe8UwLzQmVc28h2gEm7mQ1v6M05wrPuA6cj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSXZtMwb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSXZtMwb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36fe10ec0d1so232317f8f.0
        for <git@vger.kernel.org>; Sun, 11 Aug 2024 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723389616; x=1723994416; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3yfZwv+8ZcVgNDDaInR/7/FpU9PE0mw/yk3fhW6wYs=;
        b=bSXZtMwb+KtCkEkPuWwguPhBATsreUVv2zSoz4EFp2OagNCETiG2s+5K/E4UiUQq7E
         BVXMpnMfGFx/bScdsjOBQdTlktwpnZDhcfk/2NyseHgx8JmV9BVFH/nx6s4NpVdfeTg7
         Xct8j32/D0OJ2bgZ7w4/KYRUr7x20lky3n52dFv+LOs8kOUlaeZ3PVGdXfw1y+3h2NGq
         pH7OUeRDcGp8LG4TA+6GttyIcQO3VWhsm02B+BjTZW89Mwno/1Cra8gy7y6oq9ICGZz8
         5beU7R2HT+946DyC35WQ2KVDLFrNiCPjI09wa92DM/4dRHolk07hmZUSnXFgPardCgmj
         GEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723389616; x=1723994416;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3yfZwv+8ZcVgNDDaInR/7/FpU9PE0mw/yk3fhW6wYs=;
        b=ELhkg1+OB0lThULVJMl//vqA8RBPV3VP0goBcjaZI1Do+vEm+BI8iJ6o7i2zDC/rKi
         EGARhPSNiwOPcFoYFGIQ2Ss0WPcwhRyqT57X+tIlB6pdWjTwK9zkMbhtluyomQnua6sf
         RC/iDeGbWlRuR0SrhFq0w/LvXAhKgZKKbtcvTLmcEmSsGFgpq6pBCiRkPH+bdy5womXD
         hg0JJ7wPhxaLMd+hi0RKjPt7cEEl2mR8TXt2PgGZF0nUE45toxVlP10EyMCFMOjmMJ4B
         EV5ZhQP64V/lRJmTqumHFGyWIjeMQrPc3oZ+xb/lrqLlwmRR/fnVdHInMRlqwPS2DvR8
         mc+Q==
X-Gm-Message-State: AOJu0YxJxUfnIZrjZZbVwa3V+/A9UIFFzI3bNYJxatGpxiWDi21qLrFI
	wtEECTvzWX30Rm0RRzHuJVjbJjMtZc0kKknrir2q95zlhRBrsMBW7gKzwg==
X-Google-Smtp-Source: AGHT+IEl6Mrs9CKZKk9xIsCx2UaCEAyTtLFH9u3aMn4M0qmOmVoPjZZKOum3rbXqJ9wl1bwzfaJiow==
X-Received: by 2002:adf:f60d:0:b0:368:7adc:fbf9 with SMTP id ffacd0b85a97d-36d5e1c737emr5433165f8f.21.1723389615882;
        Sun, 11 Aug 2024 08:20:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c936ed8sm5133374f8f.26.2024.08.11.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 08:20:15 -0700 (PDT)
Message-Id: <92f3121cf4e719d1bd6f85e3af454a3ea7547930.1723389612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
References: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
	<pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Aug 2024 15:20:11 +0000
Subject: [PATCH v3 2/3] doc: update the guidelines to reflect the current
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/CodingGuidelines | 54 ++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1d92b2da03e..1c2d2ecbea9 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -746,70 +746,72 @@ Markup:
    _<key-id>_
 
  When literal and placeholders are mixed, each markup is applied for
- each sub-entity. If they are stuck, a special markup, called
- unconstrained formatting is required.
- Unconstrained formating for placeholders is __<like-this>__
- Unconstrained formatting for literal formatting is ++like this++
-   `--jobs` _<n>_
-   ++--sort=++__<key>__
-   __<directory>__++/.git++
-   ++remote.++__<name>__++.mirror++
-
- caveat: ++ unconstrained format is not verbatim and may expand
- content. Use Asciidoc escapes inside them.
+ each sub-entity. If the formatting is becoming too hairy, you can use the
+ s:["foo"] formatting macro and let it format the groups for you.
+   `--jobs` _<n>_ or s:["--jobs <n>"]
+   s:["--sort=<key>
+   s:["<directory>/.git"]
+   s:["remote.<name>.mirror"]
+   s:["ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>"]
+
+Note that the double-quotes are required by the macro.
 
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

