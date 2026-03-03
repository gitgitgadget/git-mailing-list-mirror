Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1CF49252E
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552039; cv=none; b=joz0ieCZ6DZsnSBG5M/al7d5MIbSUqVVH1rFTaXN51n+6td8dVeQguV2M/RAWAN9fVTpK5bC2HOnm8dnE2R5tGJ99DX6+z0JzchA4QVVIf4twHvSt8Zm1xkkew/d1os7yOrze90kH890u769RRIUnvpWdij3YoN2krhmLjKoR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552039; c=relaxed/simple;
	bh=h4WiV8zhi4vGveJqSTbW/Op9RnLE7i96DSZ3PHdHuZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJcqeKk92//5cXJ6L666IfR/BxPm8vY7TMXCr7AjALlvQwcn282oMhiURmCy/cKXsRQxrYhmq3kt+GPVgh4Kn9Q0hNGn0Nh1RMhBQVxCYl0Dsg4D3pRliNHGmk64+DZphDhy5fzGmvUMUzZFZ8vxKenJWjJ1W/Q1F8h3lAlcJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG23gvAO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG23gvAO"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-798617c0ad5so31161627b3.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 07:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772552037; x=1773156837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCrqa0zmelxHkxq0KXWB7MSnesC/Hyhmm4W/ctdYxE8=;
        b=VG23gvAOBn3MIqlxirpF0mR4eEWL9p26q6J5IqsAmof6odVarT48cbvt6Su0kgKNbQ
         1ofh/FmcwHdRyZnNi8JQnyWBt6K7ZHpCq3Mvz+NwYiCZMeDTBK4Li/eixCOoFpWgj/nn
         ScWgfQZ8tb7wWnpDt2e5vKNzklvk41fmXxV/4yKn1Akal6fTzv6RJKEEe8J9rpDNdtKD
         N8w3OZWAMbcviLK39lOuLf75PwvOPaaRDA4/l8KpKMORdd1N7vC9x4L+Qo2PZXNch/y0
         fPZFNOGv0hG8LTWmgtM7T0umcBWYrIN/Hm9GKuFhN+I3rAEGEtJSTl3G0TM+z0zQOBmU
         4cnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772552037; x=1773156837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zCrqa0zmelxHkxq0KXWB7MSnesC/Hyhmm4W/ctdYxE8=;
        b=nv33iT6gG3qkkKvB28HD3ahCeBL0Q8j7iRw29elwsaS6F4x2+FQBMr5FpI3hHOPw/O
         IJtDCrRliqgb6XD95rSVt/h1PVB1M8phQPcmTEz4ru/QR5Doc/xhTSZLCrr74digZsND
         5k3/0vwr6drfplR7aXj2KhknXuGNcJFX/OJG/klkxYrwsyAxukO9br0uso+JhoYLKynT
         r6OS6iCW6zd3MhUHv8QnUSNY/S8aIbO1ndUMjqGy7Dv++fYHhb24HK8TYgWz37eZEOBM
         a29tqn/gQAnKoUFTwdWb+ayXeLCfFmGY7GsgAyMCTnZjN1TtLnyqXk7KBbvXfq+n1KYD
         p0GA==
X-Forwarded-Encrypted: i=1; AJvYcCWzsFjYabaM3Yi4DHjgWxh18taO0J5Z9p6RyTHbfIVe60pwPCgrFqalrBnprOPlWBd/no8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytlE49Md8bcg2RlifWmiXKgTj8QllzEjoznIsx6zYr2jdzY1+d
	hv4ZRKdfYe56jK6Jctwuhu0ByOAhf+oe+jGdupbx1TSlTfW5e/rI7s3l
X-Gm-Gg: ATEYQzzyqzMg5XAAIsx49T8EqOU1Vu3qIzPhhRhk2Th398nbMs215vXNboms0Gtk/FT
	sIQ76/1y1yqSpPBDbslwmqJjr0+AY6wST0y18TzPVZW6Ca1FP6c+NK6L5EnDrTva6vZGOjUeiU4
	I/l+ZMppf+W6r34oefmzD873/cThGM96u+SV6SlkhXgXRcJ6iLKufY9xTbneqA0hPiCslZLzbiZ
	pXApdjQXyefokZipfrwOp57YXjtsNYCebguZWwfeFvF+hso71nxUPSsfPsWoAWUPmQqJgBp0fiB
	egDN4gU2YWKE3AAEEtJcDv6VP1QcR+qTY7yacZaShPmJ2PAD+ap4SiKmDp/9kM4QkaEwqQR/Zyo
	jkBzdfIPVp98a/lsdOYXwOHFWLE9KogV1SQqj23ko3bsNwjZ4AF74O6j8U60n/SqMZx0WCyHbH+
	0qniVU0ij32DUQbNR0QQhQ4c6ktlrzebithskPlaFvHuFwMgQn8NyAku0jvntiIB53/uKoYvVir
	J/VBL+RMR7mRpQBJUBSs8vJl7KGsnd7GrbpD6EMboS4ZgDgLZDepucGnuJbebW5Nqqm2dHkBPWy
	X0/fGEIkmXzapBbhi5TBBw==
X-Received: by 2002:a05:690c:b9c:b0:797:d5f2:c64 with SMTP id 00721157ae682-7988546a097mr141392777b3.10.1772552037125;
        Tue, 03 Mar 2026 07:33:57 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a8feacsm64364057b3.11.2026.03.03.07.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:56 -0800 (PST)
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
Subject: [PATCH v2 2/5] docs(l10n): add AGENTS.md with optimized update-pot instructions
Date: Tue,  3 Mar 2026 23:33:29 +0800
Message-ID: <5e23a45964fa86bf710d5e04396a574dc8882ef3.1772551123.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1772551123.git.worldhello.net@gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com> <cover.1772551123.git.worldhello.net@gmail.com>
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

Performance evaluation using the qwen model:

    # Before: add the instruction to po/README.md; the prompt references
    # po/README.md for execution
    git-po-helper agent-test --runs=5 --agent=qwen update-pot \
	--prompt="Update po/git.pot according to po/README.md"

    # After: add the instruction to po/AGENTS.md; use builtin prompt
    # that references po/AGENTS.md for execution
    git-po-helper agent-test --runs=5 --agent=qwen update-pot

Benchmark results (5-run average):

Phase 1 - Optimizing po/README.md:

    | Metric      | Before  | After  | Improvement |
    |-------------|---------|--------|-------------|
    | Turns:      | 17      | 5      | -71%        |
    | Exec time   | 34s     | 14s    | -59%        |
    | Turn range  | 3-36    | 3-7    |             |
    | Time range  | 10s-59s | 9s-19s |             |

Phase 2 - Adding po/AGENTS.md (further optimization):

    | Metric      | Before  | After  | Improvement |
    |-------------|---------|--------|-------------|
    | Turns       | 17      | 3      | -82%        |
    | Exec time   | 34s     | 8s     | -76%        |
    | Turn range  | 3-36    | 3-3    |             |
    | Time range  | 10s-59s | 6s-9s  |             |

Separating agent-specific instructions into AGENTS.md provides:

- More focused and concise instructions for AI agents
- Cleaner README.md for human readers
- Additional 11% reduction in turns and 17% in execution time
- More consistent behavior (turn range reduced from 3-7 to 3-3)

This change makes agent workflows more efficient and reduces API costs
by minimizing redundant LLM interactions.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/AGENTS.md | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 po/AGENTS.md

diff --git a/po/AGENTS.md b/po/AGENTS.md
new file mode 100644
index 0000000000..1fcef9119a
--- /dev/null
+++ b/po/AGENTS.md
@@ -0,0 +1,92 @@
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
+XX is a placeholder for the language code. The code is either `ll` (ISO 639)
+or `ll_CC` (e.g. `de`, `zh_CN` for Simplified Chinese). It appears in the PO
+file's header entry metadata (e.g. `"Language: zh_CN\n"`) and is typically used
+as the filename: `po/XX.po`.
+
+
+### Header Entry
+
+Every PO file (`po/XX.po`) contains a special entry called the "header entry"
+at the beginning of the file. This entry has an empty `msgid` and contains
+metadata about the translation in its `msgstr`:
+
+```po
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2026-02-14 13:38+0800\n"
+"PO-Revision-Date: 2026-02-14 11:41+0800\n"
+"Last-Translator: Teng Long <dyroneteng@gmail.com>\n"
+"Language-Team: GitHub <https://github.com/dyrone/git/>\n"
+"Language: zh_CN\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=2; plural=(n != 1);\n"
+"X-Generator: Gtranslator 42.0\n"
+```
+
+**CRITICAL**: Do not modify the header's `msgstr` during translation. Extracted
+files (e.g. `po/l10n-pending.po`) include this header; preserve it exactly.
+
+The header provides: translation metadata (translator, language, dates);
+pluralization rules (`Plural-Forms`); encoding and MIME type; project/version.
+
+
+## Housekeeping tasks for localization workflows
+
+This section describes housekeeping tasks listed in the introduction. Read
+"Background knowledge for localization workflows" above before performing
+any task.
+
+
+### Task 1: Generating or updating po/git.pot
+
+When asked to "update po/git.pot" or similar requests:
+
+1. **Directly execute** the command `make po/git.pot` without checking
+   if the file exists beforehand.
+
+2. **Do not verify** the generated file after execution. Simply run the
+   command and consider the task complete.
+
+The command will handle all necessary steps including file creation or
+update automatically.
+
+
+## Human translators remain in control
+
+Git translation is human-driven; language team leaders and contributors are
+responsible for:
+
+- Understanding technical context of Git commands and messages
+- Making linguistic and cultural decisions for the target language
+- Maintaining translation quality and consistency
+- Ensuring translations follow Git l10n conventions and standards
+- Building and maintaining language glossaries
+- Reviewing and approving all changes before submission
+
+AI tools, if used, only accelerate routine tasks.
+
+AI-generated output should always be treated as rough drafts requiring human
+review, editing, and approval by someone who understands both the technical
+context and the target language.  The best results come from combining AI
+efficiency with human judgment, cultural insight, and community engagement.
-- 
2.53.0.rc2.20.g532543fa46

