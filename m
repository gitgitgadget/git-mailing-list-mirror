Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389827FB18
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705309; cv=none; b=pozqtv77OIH+M4X6zCINHB16brzSlsP8ajtRRL4f5YbtnkodOGaCNZHt6czslgmLm5VPtGjjXonkonHsoAIMZmZETWVuSaMXH/n6c5SCyDsBD7KqjKVR1GdfE0l1zctw1vwMCELBpm2jN2PXpVidE6Hy03dyjV4kNEfj3ZFehRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705309; c=relaxed/simple;
	bh=q+m2d0jX1pMMCtlaU1tTBP6vS4XPkXoiOljKW5L1ESM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fndxHAIzV8CcCD7WkGv/PQLFY2CHyj9ywfBRj302rNz9RQRILnoEAfyyudUsdiNExAnDiat/ER1BjoaMxvrUYru2s2ng/hm2/24XikdqadQZRCVS9TAfG/gTtBDmQdbN7Cs5366LAbFcBEVpKucYq5CWtClrqgr7EJtI2zbVZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp3rtm0H; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp3rtm0H"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a3ba1653fso16682927b3.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773705306; x=1774310106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJRUFugpgm3O9WBS4rVoQV/2HJ8giXchqpEnCIwBZHs=;
        b=Lp3rtm0H+dJjiLJDCofVYKxSxFIaB79RnB++CbQtgYX/qJNeUf7n5kpRQWHG6hvOdX
         3zqILsjbSqBhtQGYjvUPbmurTvaWF0rnKltNMqOaYAw8pKBMmuhwzwhl5TeWWO0BuUvx
         S5yqzoLunm18/4B8trsQBpTGocty3eiYtJqn6Y1DR9WdDVlFx/9jizNrm8lSZ44nJZR8
         sr7Puf01jmKnFwItpzWaYJUgYU0FArTn4XPknjBKvxIdbWV4P4lOA2waYgSfONfUe/b0
         1umk9MZZlPheCXvp2ZGaS7xo8fyEe++CWKtE0dFq180HMu2bYdo1n4p9UlKJmz4oYnvv
         kMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773705306; x=1774310106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJRUFugpgm3O9WBS4rVoQV/2HJ8giXchqpEnCIwBZHs=;
        b=L99zt6xTW5aw4EB0P5ehKJGMfoSP9VNZdifFMDyUlEgA/offrIZLuyfcVoU5NIXVUr
         DA5YKfAoIaEqgvd5RHV6r+UKGBgSRrU6XvPo7IylqLbUDwOaSU0St1oxbldNuaGMzWng
         CtJ+nHZP3eyzxh1HAZZCz4lG3jeJhgiBcn9MuDk5wryB1BNaUIrPzAoqiWu1b5ygCqQT
         88vvRBII4QuFoitphK63x90f0mbdfROuhYMPBWYdwaPZ85lNuioMJb9vZymNP5eRNCux
         /ioLLoNNqUvcPlG9hQqsvFphDfIdRU4Pl07C85GDaY2pwgdhl3V1AhFAoFeSfe1vAlTq
         EvzA==
X-Forwarded-Encrypted: i=1; AJvYcCXhnf4TJuWajlPoP4F8B9KVfWnWmKbR+DMMCUjF9p0J9ZiVJBl4VCRetDd5e5ei+o8fL4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMk7zZXmcizAYGHX77/E8hJqtdJvjrETRKwcZ5pMpZ8ShkynL
	o2OqEwKYQNh9J29wZS287g2+5WWE6agMhJcNB+nLlfdfgWkFobZW9U5h
X-Gm-Gg: ATEYQzwfo8bFb469OVZyymYlVG/Hfe961Sv2oPTKmneUxe7hFwWL8521hb3JgAV4CVU
	yqMAtcoPuOaaXHDSjekgXlB36fHbXfigarjGhF5WTgyflRv6E9s1Lnu3XDM8QMCMhB3Ddmmg+PZ
	qCtOH9O7krPofPRva+nd/Y/iIrqyaOs3FE3XuY58RFb62lLrIBmLDF/iivRMjcHDvLApde2CuFO
	y/uLEj//7/7RBvd5+rLRRhBCggYLNWlUQwNuCct4fWht6ZELsoezOzq1pvA7D+WnntgA2+oY4nB
	rIFor5g/mMjTjwgdOW8bPYbp3/ROiMphW+kZ5UTTDeFNjqYw6h18cw4mrAvovhgSl5zcIACruP9
	jpRcdRy2UIb4sT9HPRrFEbQX88/ZcWzQFi8AFSJYNziDdtwHFPyb2IzXSs3ci3IlokXZFh0raJg
	Fr1kPhy6xRBYpqzWyaaLFoMQlD9St4gNZziXwzj987NNibB2GstnNomMe3eUUoEOZjnmw409NUq
	NJ9jT73P/9cQ/j8Hu9wxknss/CLB7JnTlBjhB0kkUNbaquzmjgMqoMgopxFTTfBi+b/muIgcYuw
	cDesg/Uf1u0=
X-Received: by 2002:a05:690c:48c9:b0:79a:5164:bb08 with SMTP id 00721157ae682-79a516515d9mr43759737b3.8.1773705306487;
        Mon, 16 Mar 2026 16:55:06 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a1fb76793sm56812897b3.38.2026.03.16.16.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 16:55:06 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
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
Subject: [PATCH v4 2/5] docs(l10n): add AGENTS.md with optimized update-pot instructions
Date: Tue, 17 Mar 2026 07:54:46 +0800
Message-ID: <e1258eac7deb27c3152633b0ba68beb6b05e3142.1773704908.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1773704908.git.worldhello.net@gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com> <cover.1773704908.git.worldhello.net@gmail.com>
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

