Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583828E0F
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815173; cv=none; b=iPTlO7SNJUX4Zo3h6WLPjIHdlPh6S9EYIFV9mpx0e3+vH5FyU4tG9ePRly6r+Pm1VueUTi22ohbK6VTNGwpoESoic/9H4fjViLluE6MtMFeJzaql6dvfsb063Mpb+q7y3dk6SOFZQQYbTEUat6mriIobV25ZgQj+BfeIwb11pX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815173; c=relaxed/simple;
	bh=ROW9jie4dmELYtjLlNVI4xBaELX2fY7U+ctX8cfsw2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eh998PoObTbE7oME2nOxsFAp8onUM8LwhUoUbFNjgu6hDWHl7oGCn/ENjMth2lC00MzOMe1yDYTrMIYt+SWH6xjrS87WHlH/MiDJCTGnIDvqiGjCQrvnRI6t84k1F5zSoaXCwRzJAfaYen0Nq50GcdbdwQcE7kOM4xIGLNmscXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcaUHr/P; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcaUHr/P"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e951bbc14c5so467304276.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755815170; x=1756419970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i+rbPlBF+7pIu9ohyV/8WIXX9eoVxVQWQwJtZUDWeTE=;
        b=KcaUHr/PJjMX5g198Nyqq7vSEgoOns188rosqzL2/mgzdhkLf+z3wlC4mk43HijlO9
         qpYgxprAQXcQkSw3JZLAAsocBXuys8goPNc0zd8QEitX/+xSy69hSLAzmIz1Xm7cdgCs
         KBcdPLlRsl7YX0dcHunIIDsN9zWKxNGkumL+F+Z/PPnd+GrLjfk8EYOxL+yptficr5+0
         SuV3KLzpLFH5WKZuCSRMHHxvxcmMvc+NnUEUl/glmzn6/g3X8k9HVgntEAG+KTGzHSnO
         sJr6UtTLhXlra2CvIB8VraGSZ1g3t3IP9Wl8MPDbaopDNXvO/Q26y33LH7yRQfbGTFcL
         QEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755815170; x=1756419970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+rbPlBF+7pIu9ohyV/8WIXX9eoVxVQWQwJtZUDWeTE=;
        b=EZuM4HWWUJxb5R2fpVKbUJ2r/etZH6fG+Ha5j4h0qe51C7wZpSerGC4heLxXHykrxt
         6WFe++FY+sg37N9TV/mi6/FWSYDzs68WtC6c/nI4rRaZLS0jNM5np+40ua2pcuiFKADR
         lc4PfJWy+8tsuFOf1GpdFew4AH4InnR4Vpd+uCEsaQsYf+VJXHjnCSceaB5YMRIHBv/D
         Sk5pYIKvDBHmqipa8ihBLNfwuoe38UqvssifA4ifQ47hWey62n2u6fxlGveZO6MmhxNG
         N80byAcOb6iz/kqmiWaZSMAM76NThJXU9nMV3BvC7oxlm5QI0VMVnpvnN3H3WSdQ8xP9
         yEJA==
X-Gm-Message-State: AOJu0Yz3Cds4MLdr6Yd3Lu1BU3Gj6dyKTwPfW9jQLlW3Ahzt1W1IQc33
	CV0M0LAZ11qN8rYxdJWIcCMPCtzIJYM8XLra6zjZnGwSAnVihNQel83G42tZ7A==
X-Gm-Gg: ASbGnct8Q79rBGL5fEkcBHfCWRlZERbq6NRZawtrWUWD2qrvV2hhAVSgqaauHe9TvAp
	sbx3eP/OxQcyhm1wg4D/P3/GtoxrVoaS38lpxthvE7rDDRkArP/aFxU4pakk8CwpCSxs0vRzR+d
	YhQR2VAriMvuBi0N6M277dfP52HhK606e3+fxFeMoyZz8hbwVq4iBd8imVL0FckrdslfV2Cf10E
	GiWXo27Y6VbGRokjr/KtzX8dO91P/IyjV8VBA812cIOnC6RgoDlRfMonInDc1aKb+woX9V9fmCs
	llXdnGxDfeiBWRT2etMktC+yTtORH1FEObqKgto4dKHpKpDcw81XRbaCnmMkCnlImALsxSJBmLO
	4O0rzRlm8DIyxURmBOqAUMBpdYgEPvU6sOiSCFtFYieZ3mGCP00u0/YHo2VXhdCq+lAfSgLKmbH
	26KdKPMHFfiqK2mjV5RV5u
X-Google-Smtp-Source: AGHT+IE12+tZYy8fmkX01pLrCKs9ViyY5llYP6ol/XfIg7Hs7ab7dIFVmTM9nni+eYdJJIKiA4Yahg==
X-Received: by 2002:a05:690c:4988:b0:71f:ab32:20b with SMTP id 00721157ae682-71fdc31540fmr11165497b3.23.1755815169970;
        Thu, 21 Aug 2025 15:26:09 -0700 (PDT)
Received: from USROMMRAPPAZZ01.infor.com (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e068a37sm46693067b3.41.2025.08.21.15.26.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Aug 2025 15:26:09 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2] gitk: add README with usage, build, and contributing details
Date: Thu, 21 Aug 2025 18:25:49 -0400
Message-ID: <20250821222605.3993-1-rappazzo@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
Changes from v1:
 - Added Usage section with basic gitk command examples
 - Simplified Contributing section by removing detailed patch workflow instructions
 - Removed repository status and integration details

 README.md | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 README.md

diff --git a/README.md b/README.md
new file mode 100644
index 0000000000..fd249bc24d
--- /dev/null
+++ b/README.md
@@ -0,0 +1,61 @@
+# gitk - The Git Repository Browser
+
+gitk is a graphical Git repository browser. It displays the commit history of a Git repository as a graph, showing the relationships between commits, branches, and tags.
+
+## Usage
+
+To view the history of the current repository:
+```bash
+gitk
+```
+
+To view the history of specific files or directories:
+```bash
+gitk path/to/file
+gitk path/to/directory
+```
+
+To view a specific branch or range of commits:
+```bash
+gitk branch-name
+gitk v1.0..v2.0
+```
+
+For more usage examples and options, see the [gitk manual](https://git-scm.com/docs/gitk).
+
+## Building
+
+gitk is a Tcl/Tk application. It requires Tcl/Tk to be installed on your system.
+
+### Running directly
+```bash
+./gitk
+```
+
+### Installation
+To install system-wide, you can use either `make` or `meson`:
+
+```bash
+# Using Make
+make install
+
+# Using Meson
+meson setup builddir
+meson compile -C builddir
+meson install -C builddir
+```
+
+Both build systems will handle setting the correct Tcl/Tk interpreter path and installing translation files.
+
+## Contributing
+
+Contributions are welcome! The preferred method for submitting patches is via email to the Git mailing list, as this allows for more thorough review and broader community feedback. However, GitHub pull requests are also accepted.
+
+All commits must be signed off (use `git commit --signoff`) and should have commit messages prefixed with `gitk:`.
+
+#### Email Patches
+Send patches to git@vger.kernel.org and CC j6t@kdbg.org. See the Git project's [patch submission guidelines](https://git-scm.com/docs/SubmittingPatches) for detailed instructions on creating and sending patches.
+
+## License
+
+gitk is distributed under the GNU General Public License, either version 2, or (at your option) any later version.
-- 
2.51.0

