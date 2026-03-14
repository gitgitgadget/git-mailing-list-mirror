Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1E37B012
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773499117; cv=none; b=MxUhKbjkg/vMRrLWGzZAbyXaCXunFpSVA+NXKRr3qYPj0u2ZIhm9ZBEaUOPNf9uIsMVC8FGLM+vLIJo9ig5xq/i7XzcmWjacnBgERZXz1MkwOfY/oMZk/7uMP+SPUg03XKGnnHVW6djB8gbBk2dGBSfwIKsiIpRZbNOphNqepB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773499117; c=relaxed/simple;
	bh=q+m2d0jX1pMMCtlaU1tTBP6vS4XPkXoiOljKW5L1ESM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZhc2mO6bGD95+9jREpUmkqShR/iH8fuUWCTpRuQsoh2exJOdZ74YtLNj7wzhSNgKIGL5tHlC/50Ewv6BAKdJSS0OMew7/0xBo3E8l4aMZwjvwKShwMFQM4b0sQzAEZ4QcOHcJndbab6wYRSRmstpnZfYakgCZAloabEfBcq3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMIFV3dL; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMIFV3dL"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64cb577e79cso3467283d50.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773499115; x=1774103915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJRUFugpgm3O9WBS4rVoQV/2HJ8giXchqpEnCIwBZHs=;
        b=AMIFV3dLtN3Wcqm6cP9EalmZXPtCc64JM8xKNtyjAn2xcMmrCg91+DSCQPxX6kMfJD
         H6mS9ogn5zT22umGhQspJ3aLLMPk/Xk2gDL5pgC8BoK9DO9bIerZQxsJ5HuAb4+C0Uml
         /VRROUlq62g0I1BCJgvaHITx5g5IJTHJ/CZFxKAdm5uqQSwbv58ARHonA8Bc8SGbDJGo
         xeN6V6gMXTG1Ir7NUJW/n86nOmTkNQtbJ+eJ9AvUmLfC3GfXCFJfg8Mob6upFXFeSG52
         tutbBIm/LTd3/viW+JV90mM0FPTHE4OFyLoXYrmsnnsL1NX8wkxPlvDBZlBdojMJxf1+
         ibFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773499115; x=1774103915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJRUFugpgm3O9WBS4rVoQV/2HJ8giXchqpEnCIwBZHs=;
        b=kEMJ7lhAg7khZoLCZBlCWRLSIIPwhmAPnELmiEN1ScZ7ZfrVnz21yK4p+XTXT9a8xx
         4Zq+ACYzmqVfWMeTA8RencS/PpMC0zNJruiA0erCqipDdoo4EUH6igLGUlsEqNZbkIAf
         61faRSToUFkdPF6LICdDCuclaWpDu42E8cJppcFN+Pg1zrLLsd/EI74+r5h+rCecU7jV
         wOzXtYL6pewcbIGhUcZO2jtLOzcYJwxoIfTk4o3Ec/XkkFvqmTTzKndeVO+4cCdDw8KL
         i6MFB/TSGvTX2UkA7Nz7uIhW776444Tf11RYEdsUM597LuknDRJMfHm/iU44msQx7FGK
         oqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJjMKyBcTXbqSQMZ5ZMeAyDnUx3zvlDU58iawVqH9AMsCMOLbhxWqoD992byUGjEFT1cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUL8+Z4k9EAC2wz20YZALsjgnKC7E5C1/If48yU5ztu8s6Ys1d
	rURLvM01xlyYGQk/64wgI1/jJXzo5zW5z4vemnoCmrQa5oHNKFCZ3Rdg
X-Gm-Gg: ATEYQzy7kdPuToDnd/Qm37Mo8+MXH6YH4CgVDHxOnGSjGB5VUMloQdNi0ZBbAWUvz30
	iXb+ydIX8C2eo7TvGXkkDVZHWWpU4FU7VE7emPJH/irEhTnd8I1p0l6lo8VV34DHm+QuzdirmIJ
	6ZXR92nf/5ytB71YwJwpUrTQGxe+TNBftF9SUMgXMZyYTPprmrgLXadv4Dy6vMGPm3T8lEmXd9d
	x6qGoH0sXVskSccJUbVWLnM5Xmc0+9EiQClbw7k0L1QDNOIOzGtrCJuKMVtnRME1rUibJ7paS9o
	hrOBv++MSHthIcSe8xS1rdv1bZ3FH3WjWIE+AhpP7dgGYPMXpxUcVxOXjgL2FMTyVyqZfMinhBv
	XFrZGykRUjkWcKjG6Fhi3wWd7tqSKUv5uKSF9+A/v+b7wAl39Mucqua9hsGPQKOVsQ/V5Tly13c
	mIJx7PWeFwi25pDzNOiiYYzRpnEY20fFdP5siKp45d6QYGf207o3du8tq2zunQhmrjW8Tv2zNFT
	51WHAZH3A7m2UP590y/OLU08ELgb3/SSAz8E9RGdjfZTXRkwRpsOpKuw+6m9DOuoksGZMXFRiYB
	kIhIWJ+TNSk=
X-Received: by 2002:a05:690c:3387:b0:798:7821:8b8c with SMTP id 00721157ae682-79a1c1d9d8amr71236127b3.49.1773499114816;
        Sat, 14 Mar 2026 07:38:34 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f0846csm65264207b3.39.2026.03.14.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 07:38:34 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v3 2/5] docs(l10n): add AGENTS.md with optimized update-pot instructions
Date: Sat, 14 Mar 2026 22:38:11 +0800
Message-ID: <573c24e798ff570921a3bce1dd07f78d662549f1.1773497547.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1773497547.git.worldhello.net@gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com> <cover.1773497547.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new documentation file po/AGENTS.md that provides agent-specific
instructions for generating or updating po/git.pot, separating them
from the general po/README.md. This separation allows for more targeted
optimization of AI agent workflows.

Performance evaluation with the Qwen model:

    # Before: No agent-specific instructions; use po/README.md for
    # reference.
    git-po-helper agent-test --runs=5 --agent=qwen update-pot \
	--prompt="Update po/git.pot according to po/README.md"

    # Phase 1: add the instructions to po/README.md; the prompt
    # references po/README.md during execution
    git-po-helper agent-test --runs=5 --agent=qwen update-pot \
	--prompt="Update po/git.pot according to po/README.md"

    # Phase 2: add the instructions to po/AGENTS.md; use the built-in
    # prompt that references po/AGENTS.md during execution
    git-po-helper agent-test --runs=5 --agent=qwen update-pot

Benchmark results (5-run average):

Phase 1 - Optimizing po/README.md:

    | Metric      | Before  | Phase 1 | Improvement |
    |-------------|---------|---------|-------------|
    | Turns       | 17      | 5       | -71%        |
    | Exec. time  | 34s     | 14s     | -59%        |
    | Turn range  | 3-36    | 3-7     |             |
    | Time range  | 10s-59s | 9s-19s  |             |

Phase 2 - Adding po/AGENTS.md (further optimization):

    | Metric      | Before  | Phase 2 | Improvement |
    |-------------|---------|---------|-------------|
    | Turns       | 17      | 3       | -82%        |
    | Exec. time  | 34s     | 8s      | -76%        |
    | Turn range  | 3-36    | 3-3     |             |
    | Time range  | 10s-59s | 6s-9s   |             |

Separating agent-specific instructions into AGENTS.md provides:

- More focused and concise instructions for AI agents
- Cleaner README.md for human readers
- An additional 11% reduction in turns and 17% reduction in execution
  time
- More consistent behavior (turn range reduced from 3-7 to 3-3)

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/AGENTS.md | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 po/AGENTS.md

diff --git a/po/AGENTS.md b/po/AGENTS.md
new file mode 100644
index 0000000000..94b7aa7f28
--- /dev/null
+++ b/po/AGENTS.md
@@ -0,0 +1,70 @@
+# Instructions for AI Agents
+
+This file gives specific instructions for AI agents that perform
+housekeeping tasks for Git l10n. Use of AI is optional; many successful
+l10n teams work well without it.
+
+The section "Housekeeping tasks for localization workflows" documents the
+most commonly used housekeeping tasks.
+
+
+## Background knowledge for localization workflows
+
+Essential background for the workflows below; understand these concepts before
+performing any housekeeping tasks in this document.
+
+### Language code and notation (XX, ll, ll\_CC)
+
+**XX** is a placeholder for the language code: either `ll` (ISO 639) or
+`ll_CC` (e.g. `de`, `zh_CN`). It appears in the PO file header metadata
+(e.g. `"Language: zh_CN\n"`) and is typically used to name the PO file:
+`po/XX.po`.
+
+
+### Header Entry
+
+The **header entry** is the first entry in every `po/XX.po`. It has an empty
+`msgid`; translation metadata (project, language, plural rules, encoding, etc.)
+is stored in `msgstr`, as in this example:
+
+```po
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Language: zh_CN\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=2; plural=(n != 1);\n"
+```
+
+**CRITICAL**: Do not edit the header's `msgstr` while translating. It holds
+metadata only and must be left unchanged.
+
+
+## Housekeeping tasks for localization workflows
+
+For common housekeeping tasks, follow the steps in the matching subsection
+below.
+
+
+### Task 1: Generating or updating po/git.pot
+
+When asked to generate or update `po/git.pot` (or the like):
+
+1. **Directly execute** the command `make po/git.pot` without checking
+   if the file exists beforehand.
+
+2. **Do not verify** the generated file after execution. Simply run the
+   command and consider the task complete.
+
+
+## Human translators remain in control
+
+Git translation is human-driven; language team leaders and contributors are
+responsible for maintaining translation quality and consistency.
+
+AI-generated output should always be treated as drafts that must be reviewed
+and approved by someone who understands both the technical context and the
+target language. The best results come from combining AI efficiency with human
+judgment, cultural insight, and community engagement.
-- 
2.53.0.rc2.20.g532543fa46

