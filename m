Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B82F3C01
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336483; cv=none; b=AIwcR0AiGtxWfX2GeX4D33vSCXOMs9bNy1CMSvQHq2xwF42+ZS8V8aJReJaig6bhqSB8FcqXCP6SklpjYuoVPP1aill9HsLPpEkR6fLxSgjmBLuo2LnAJxGuDJMDxpWCVhJ6dmRu+WgpIDesP74qyBJDf0c1C0lFuvQkBsxtEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336483; c=relaxed/simple;
	bh=B0wJim1TWbVPpjM5uQwJl1ACwujVtTbukRW4riFkNnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oh9TMmX/ZggFukTZ77M5G5kXI7WoJU9rSO+ODhG0fxdKpOZWkgLxUl+MKK+80shqNfrXZdd/1/tn6EUUYPxgJrVNoVe+NEMXgU1nI8pgb4/M/STJY7J3BNxt1Jq1zy6Fceln/JQ21dNg7NYu1zOg3C5qvlCmK9JmadEkTzGMYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqeP/twG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqeP/twG"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d60504bf8so3162737b3.2
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756336480; x=1756941280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFpPP/Gb6CHwnXpB50ox3Vr2M3cYDvIjNVF0iKwFzAw=;
        b=CqeP/twGszdghaKqqq6Bc7QSV2dNMrKt6wtSpPH0Cw4nY2TfS7NexKY2pTm5INq9C/
         k4dMiJRYVDjnE4IRw4Q+z4y6cq5iAXwzjkw3qqsHLMbuBurzZEX7QIRRGqRvphgK+fCk
         N24KUjItReClV918/AJTUbJHJQlooXfchTRHWCnhT/6cWQ1KRbVoL8jIkfdlmZ1PjHAB
         It8MXNqSHNQpMkk+6MvW+ycjhoZ96oFTGwgqFpR8N3fAgudByg9yEmjsxibsm7Xocl2k
         YTYJrVwQNzHWNrkhsBltvXJfSQFNcWurgogOnmI+GcZUp5ZRMPoRbUAlAaA+pKwOv2kN
         jkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336480; x=1756941280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFpPP/Gb6CHwnXpB50ox3Vr2M3cYDvIjNVF0iKwFzAw=;
        b=le3APwOUIFSu5R8McKDvdEH2m7yum9FMVIls0Poqa+grxbj00wnOwLl7/rgJz3T3uh
         M/DR2fnX+0ZPAfFqatI2O0qQJaAQM0tLBNV6ow5vafvenp3/bCc+21QUC8M+YQX0sCHD
         XRJT0LmOdBCOlVqPPwUGkBFFYwXJ+O7W8cAn6U7sYBK7aSY91NrZZqIPHqrGPhy7FtLH
         aAjE7TQYZVA8O9ZrP8UrIBvv8toGdje3ucWMF48kAiye3CeT9ZBbyak2tlvUeUQJPnU5
         p+XmJKgIv8PYtgQksFi3ibCq9yVDtUv3wPE9gijGQkT46aqkHn3DTjGGE5Tynh8/n0HD
         a/qQ==
X-Gm-Message-State: AOJu0Yze0jNj/AoH0iLxrZfuJLQhCVgIebFMozuEx9E7GaGTcy0uVK45
	+x+qAKlO3Ih1ivkGP9tyG/vd8l6EDp3vODKEtwkJUzxXuBmNV3ydrFYkRVt7ng==
X-Gm-Gg: ASbGncsdIWlgWEG/iSlgkdSaX6HvZo9FAC4eBOBDhMOYtLyQMKOLE4KzCd31TRG5g4L
	p0+1LGjCBZav/8s0q7isD54vjGOnaLqx72NcFlZGT2MRRm6VZXRPFvJ9VOL93xZD2AjR+OSsL1H
	fUo4S0K98Z/i5cg7LOFYbgNp4+erg/k0873K5glsFl0SxAP83+rTePRJsSgEAiuxCzr43suUNOY
	rGFacAunNrWLSHJhGsr8R/PPLw+c9rTHWMPVDNGotQcf9lKppyznlTYLMwkgz9vKy/a4azLsuWI
	GAtOVQ3HlGpGIlgckspLMLIqKHQJvMRhrgkIK83KTU8Cv32xjSJhMErFSMzeoR0JeNqsAHOaYoE
	0FUByAQ4nFzC/pawHZfa/HATVsE28iCkCkvaIhh+CZBMLv8sJdWj6j4aQamCAauLRdfj06e38he
	5vJoqgd2eLFYpSQ5Wk27Rt
X-Google-Smtp-Source: AGHT+IGtFhwS2MN3PgyRUM2CrTTZeyb6qCBq+Be7ZhrKw2hjS6BC3oD/cvHOjeT1nVNb8Wc7AMO2Wg==
X-Received: by 2002:a05:690c:6c0d:b0:71f:efa8:587a with SMTP id 00721157ae682-71fefa85cb8mr202909497b3.44.1756336479743;
        Wed, 27 Aug 2025 16:14:39 -0700 (PDT)
Received: from USROMMRAPPAZZ01.infor.com (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721243ea829sm17323767b3.68.2025.08.27.16.14.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 16:14:39 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3] gitk: add README with usage, build, and contribution details
Date: Wed, 27 Aug 2025 18:59:56 -0400
Message-ID: <20250827231417.12449-1-rappazzo@gmail.com>
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
Changes from v2:
 - use 'Gitk' to refer to the software, and 'gitk' to refer to the
   command
 - change the markdown section format to use underlines
 - wrap lines at 70-ish characters
 - add more details and examples in the `make` details

 README.md | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 README.md

diff --git a/README.md b/README.md
new file mode 100644
index 0000000000..bd3e9a6481
--- /dev/null
+++ b/README.md
@@ -0,0 +1,93 @@
+Gitk - The Git Repository Browser
+=================================
+
+Gitk is a graphical Git repository browser. It displays the commit
+history of a Git repository as a graph, showing the relationships
+between commits, branches, and tags.
+
+Usage
+=====
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
+Building
+========
+
+Gitk is a Tcl/Tk application. It requires Tcl/Tk to be installed on
+your system.
+
+Running directly
+----------------
+
+Gitk can be run from the source directory without installation:
+
+```bash
+./gitk
+```
+
+This allows for quick testing of changes.
+
+Installation
+------------
+
+To install system-wide, you can use either `make` or `meson`:
+
+```bash
+# Install to default location ($HOME/bin)
+make install
+
+# Install to system-wide location
+sudo make install prefix=/usr/local
+
+# Install to custom location
+make install prefix=/opt/gitk
+
+# Using Meson
+meson setup builddir
+meson compile -C builddir
+meson install -C builddir
+```
+
+Both build systems will handle setting the correct Tcl/Tk interpreter
+path and installing translation files.
+
+Contributing
+============
+
+Contributions are welcome! The preferred method for submitting patches
+is via email to the Git mailing list, as this allows for more thorough
+review and broader community feedback. However, GitHub pull requests
+are also accepted.
+
+All commits must be signed off (use `git commit --signoff`) and should
+have commit messages prefixed with `gitk:`.
+
+Email Patches
+-------------
+
+Send patches to git@vger.kernel.org and CC j6t@kdbg.org. See the Git
+project's [patch submission guidelines](https://git-scm.com/docs/SubmittingPatches)
+for detailed instructions on creating and sending patches.
+
+License
+=======
+
+Gitk is distributed under the GNU General Public License, either
+version 2, or (at your option) any later version.
\ No newline at end of file
-- 
2.51.0

