Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A579149001
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774687; cv=none; b=E6KvicXOgeg2EJ9aS6rSbqRfxK8R53nyHLs4lNPJoyyCK8bEhBx/TF/g69QGfHLSWgAAuzS5fHGYpYCDFynY5qFODz6AR0eUdlPXWIF9E4m/P6lcEDH/yNXiSuHGoc/BzwsDQ4KLNZq5fy82CkJjcD2GPPpA1DjDN1SE3jN3Hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774687; c=relaxed/simple;
	bh=HwOYyNlVu2KoITHjDAubGZsNBBWHEnttgc5RxGbeOQw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=CXHC6jUyPr9Ks/UrdmIZm0lPKMayAen+eZqbyMpd7LN9pArn/K33Q2jwQt7COCOkJoBuEJK52CtkYNLXvwt3mhM3G3fH0AAi6JgaX2GtDxlwHvw7Ne1LWgjAPDtwnspAo44QXQ01ufgrmThzAUzG9ob9IAx0snRJtXcJO7A0JDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ9Em/MK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ9Em/MK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-426717a2d12so1773145e9.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 15:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721774684; x=1722379484; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QsUVdBvGykL5WXisV3H8eJK0qTNDV9vrnAt/mwuyp4=;
        b=kJ9Em/MKarmvGnsKhrAWVC09o9KqULtf1YDplU2yLLFZ1QMOHWJOJRoNywfQGnqOuc
         5q7/MFjk5Ytv8UJtgcIK34OJlwn6qh5u4glRT/kUwvA3rPQi/vnTu5ALoFRWZ80ds3Pq
         KIz9uaX1/NjtfASVY7DlZwYnVutP0Bwky64DvExwBw5Sy3M0+IDTeYofEVGFG7YtzNYU
         SYa8+Ck9l5IoXnGog5ShVx0RTYY/u8RkzbuJf6UEQ8bxphhqfY0hrHuZy372gvYrcBAZ
         3ey++Pv2XAjCUS6II4L02i6ZerKwHK4XxZ30AxRBW64LEHNUwCuHgpaXDCz49RVylJF5
         Yspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721774684; x=1722379484;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QsUVdBvGykL5WXisV3H8eJK0qTNDV9vrnAt/mwuyp4=;
        b=EhgaQiolpD1H1FZPOPFROjokbgyn/mlKvXZai+iS+oouKJq1A0WgM2l6ir+VwLrVau
         5h9riuO3UUDQsH/uR2DuutxBSHFl0FdZx9sqfvviTjqdiROfFCdo8xwKyedk261H/XLp
         gTY1x35/FSVf2Uu268qiZp8R54jLvOkV0F1YnI7uqUSiEBMzDdykCq/+H+GMogAjYAAL
         cWDchr3uFLgP5cW9Fo0nBGeh9yoJocuqtmDNwfi+yZGr5XIFHpzoyHqraEbcV9IJ/mEZ
         plzIIy2K6sStJe2zm+Bo6rGono3TzdB07WFlkomuQRqtuUO83pG0uKymrJz5aZcGhJ2p
         RYMg==
X-Gm-Message-State: AOJu0Yxe1SKeqEfLKdfhkv4WNW4NtAF5rDudRdRdY74mtKYLYtd8cIkc
	camCjYroqpRGWwMhu1D3TRihmR0jqb1ABa6ATvO+JpFaPHlEz0D7j8AZ7w==
X-Google-Smtp-Source: AGHT+IHU5KI1sWZ/HgydSDq41evf4eSAVuaG19EY+DGiqhdJdELoW0qbA/v4gkKYKvUIVoWK1syN4Q==
X-Received: by 2002:a05:600c:3b8f:b0:426:65b0:3035 with SMTP id 5b1f17b1804b1-427f9a4b9e0mr479015e9.15.1721774683775;
        Tue, 23 Jul 2024 15:44:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f937348bsm3656145e9.18.2024.07.23.15.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 15:44:42 -0700 (PDT)
Message-Id: <b0547422e5cf31c1141f2b6078a43e5bc60cb652.1721774680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 22:44:39 +0000
Subject: [PATCH 2/3] doc: update the guidelines to reflect the current
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
 Documentation/CodingGuidelines | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1d92b2da03e8..4d59e8f89ec8 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -760,56 +760,60 @@ Markup:
 
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

