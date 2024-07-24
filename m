Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2413B29F
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855187; cv=none; b=Q9UO/SogNlO6WLpCj4qERSLwIRCgB5BtDJSEmt7bmzD6fVxVQpfn3npqCBSTri+5aqamWOHTL8ZfjuCnbTfUPsx93pDD3mY64uvFEkWLLIM0mWowG0Hes3vpkLwICnc6+UuExYwVecrwRyqIzzs6xA0ZXUHy3XmTpmRQDVLPiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855187; c=relaxed/simple;
	bh=HwOYyNlVu2KoITHjDAubGZsNBBWHEnttgc5RxGbeOQw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=NsJPy+qA6ejnYIhLx+h1zfqtYvI0MzaNvLjdhMPNLgqmq8FESisAAR5TrSJU+lhzec0vFJtqYjmsPZbuAkPlpjKlZCFBjhy1t2UwhnIetvl7t2kLvihA4yIrogURsJq4mNv0+j5rYKc5s5n9K+wDNWcEdUqaUS18TKWLx9tdGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHCqtalH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHCqtalH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4267345e746so1571015e9.0
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721855182; x=1722459982; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QsUVdBvGykL5WXisV3H8eJK0qTNDV9vrnAt/mwuyp4=;
        b=QHCqtalHUxIpS7x/hrZ7tjs96vMImZtpxcnwpknWLLaFj0sKaV66szN27TFG0Lg0VA
         KY2DMfmYNpb2Mm/83HK1IGqbuVKWWk7i6lDnOQ8kX8UB1dLbGpi7xDqi0uhvOSeOTLQo
         K6R1wyPvT0Sgvj/g2UqPUHW1peDroU7YGEDIQaS1qfDq8cyXrCtfG8AIvB4WwtJMAUa9
         hMMi8YLDZCmqaXM4kIV5FLKBJ5JoEEgqUhWo4LQu+NcDjUMVLGsrjyUp3YIt8ZNb5lr4
         8VO5WmIrZCBgHh1P3kOzyDEgiWhT6Qd6vmXZYXKk+nx69l/OPrma5mx/LGBrFTFYNVp/
         gfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721855182; x=1722459982;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QsUVdBvGykL5WXisV3H8eJK0qTNDV9vrnAt/mwuyp4=;
        b=TlDd9IUzJCzIWvYn3Tkw79smSEDtIF+0Wnf85jm5OVGh0r52DzeqrmPb64Wf82tx8i
         XKpMQ6WPwPNEBkeY+RvGe/vPYjXFx+jICPOZdboySa3TZPkIisRlD7cmffWcXF7X8b3r
         haPWoelsaEjlEjRM/aQqkW5HY9lZEgHm7trkonc6Tg6h5GHbSR4Eu2g1wnbng2ea5FnL
         GnERdF+bWQPNSeEHW7ScGldF9mCSVWweQFSMOtM07w8ySDWmzmE3C1D6JYKNkPFq5Ulx
         9xs+wphfMW1a3ige9OBh7h+QqtUt11NSpK6xK8fQ1lJA0OuHwoYgXXMHl4hpcpVOVzSP
         FtYQ==
X-Gm-Message-State: AOJu0YzvcmSC0LaKII2WhtNZRXcFXfroZyeRz1QNUJ3wTPi+L/KTwGhy
	uxP2nJQtF5EnqOLmEP/2PicQaUzJMb5QaH/SDByGk5IWRpI0nKiyK4pbCA==
X-Google-Smtp-Source: AGHT+IEpkONvmm49Q5QNSlsX2AFIzT981kfF4oi4Q3w4BOsVGCyGNP2KNr4I/CK0HHcxjPUiqVZDGg==
X-Received: by 2002:a5d:4b83:0:b0:368:319c:9a77 with SMTP id ffacd0b85a97d-36b319e82e9mr545460f8f.29.1721855182536;
        Wed, 24 Jul 2024 14:06:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9386b87sm42820995e9.19.2024.07.24.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:06:22 -0700 (PDT)
Message-Id: <b6387bef40d08395313bb826a6f7cdf459f4c5f4.1721855179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
	<pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jul 2024 21:06:18 +0000
Subject: [PATCH v2 2/3] doc: update the guidelines to reflect the current
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

