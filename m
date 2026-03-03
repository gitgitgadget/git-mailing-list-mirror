Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693548C8CC
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552045; cv=none; b=RiUD9eObAK16AzYcIZigr1SUpnQBzO8JQ7ipwc4iMFqWctuyZtWWP4tbD8EGMyiY35qR9bLbWtzt8h2yWhWJ2Ymps5kGxKc95YGhDufrm5CoFwGaZWlDZ08XRTiZ8TqaC2Lm7mWTNAu6uf3yFMcNoW9XP++6lLFzYGG2CYvN1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552045; c=relaxed/simple;
	bh=rbQoY+Hxf6nbvjdq+aR69p97DE9KokYYE+l6IG0OAYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMfq0SRFulP0T8mrBZVVizNjDHUPXAOUevHOcjXwuzuPJs5DJKoLq6kG2EJtfIiu2hbyujEf7VAV3l5O2g8z/UUhXB39UmvBWf7N1vsw4s9kv5UAyViU5jwRxzKpDNeHHjBwX+QmVrH5AVXbVDD53QWmi4KeOtyjh/afbzb/Z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAcvwW59; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAcvwW59"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-797ab169454so56100487b3.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 07:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772552043; x=1773156843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKfqYYNrZu5bhj6NW3TieWZlfO0AGB3Z4YEkzFjaXso=;
        b=lAcvwW59IkV8Reu/DYty1/p3YONo6y5ghjdTR9B6gDiXk19/+xuVbG5Mo5P+a9x5Gf
         dvFMmRZVE+Q2J0SsupKugsmHMJuNe2umgiR7AFraDszmPqF4tS/isQmFNrx9E8qNNAHz
         axitAYnd/2WkluKczjvj4B3NxAD2ij/SrZMRDY/zrxElfNk0V8sxHYcXRFWl9NwSNrmK
         1dja7N3cdRHNAXXE6H+mPm38qZNpAW2WqyZ5KuXcC0XAcOMz1Z2jh75sv9xL+MVTZGNb
         gdpcaXAqxzgjDd4GqK+74EkQy72UTD7xvTNGrvJn/8qn+9qpUaGLEhhH4eOIhVCYxYkG
         VyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772552043; x=1773156843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aKfqYYNrZu5bhj6NW3TieWZlfO0AGB3Z4YEkzFjaXso=;
        b=i4h5nU2yTbG5aC5cwRkNUBQPIyMU0PFW4O0Jf//ZOCmgQLyiBQ5vqQBsRi47VWBps0
         I7d7O+hdhECVLWicANM1P0FUVORdhgM5YWFov2ChngLWsENbbbwgKz7ljI3LxNG1icuc
         CeYcE4pyA5e55FdVJ9iejXYHS7RDhpRN5mQtpms4FERo9o9ay9BtSx63kkizgDvPngdr
         vut3JRmgrfl3rv+1UpkfNU0fE9RQVaQxoXkEyumaXc3Zvdait45qSm7OrdgRJuvAbVhr
         wdp2lIt8ZUZUfP2C+PNKizFtRkQqb05x6bEi7kK86J87sXNi/FhTi8it3wdk754jFAEL
         JSYg==
X-Forwarded-Encrypted: i=1; AJvYcCXJzda5xdwzGXsIr2X2IAvXbHZwQlXlr3IbbYNUbd3LWny85EHndIgPgz5hCp4Im+vjMgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFWI8JfZwUkz5tcsaCegp8+DxZjOk2A/eXBuVCxazM3hQ97iTO
	SkHGn89fjK94jqUW/l8UPzaXdVXkS2DA305zbRWSGv5YE4cUMKWNVl7t
X-Gm-Gg: ATEYQzyECSh4CFoOdvS+ktc6p6eNUKf1EcaHJU78u9y6Zhi4KU5NTToz/KeuoRN+YJM
	cDjDGTAdxcoE/s8Hs9Pte2b9/GI88qKVWeX3P+/u0N8h+oJextbPp6rMOG8thkNqN7lE58JFrRB
	GSbyCedF3uaQkvIy0atPcnwJEwAfuJvLQuPhLO2PqsotreqTKso4MvaihsNGk0WjODZC5t9qLJz
	jERwuvjzbe1Fx8jl972qf0leePl8QVWD8YwU3cMB29TQRLiBNVwDe4gIzf6UyR4ylerO5rcmY0P
	GENJv749pAhmsbP9AWSgU0OByVap/9JYjgTJSp8Eqr73mgDA8fWG2AarGTDtEautGGajHZWqcAF
	loMjOxzRAH+BQwwou4i8qeqbHUrMr245hh9qQplkupq4qXR5ijRgTYgBwEoaumtVACzv9sfhYdV
	OxH7ezTsAdTs7BC9BYCMg5klz9aHv8bakpAjXMnbn9/fN3dVPATKcvzRQ3zwnhuk4IajT9BZwTj
	ihsWApQnPPFMkFQkBeWx4+a63gu0zCUuMamc8/qKkAeUAZL5HTBVoK/646kDcEIw6yb03W0S+iH
	47EAM5wvUu6c1l1Hf3N3qw==
X-Received: by 2002:a05:690c:89:b0:798:578c:2ad7 with SMTP id 00721157ae682-798aabe3a51mr71629157b3.39.1772552042833;
        Tue, 03 Mar 2026 07:34:02 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a8feacsm64364057b3.11.2026.03.03.07.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:34:02 -0800 (PST)
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
Subject: [PATCH v2 5/5] docs(l10n): add AI agent instructions to review translations
Date: Tue,  3 Mar 2026 23:33:32 +0800
Message-ID: <d7a7a07acdcf15520019fc58be5e6a1a1e24791a.1772551123.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1772551123.git.worldhello.net@gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com> <cover.1772551123.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new "Reviewing po/XX.po" section to po/AGENTS.md that provides
comprehensive guidance for AI agents to review translation files.

Translation diffs lose context, especially for multi-line msgid and
msgstr entries. Some LLMs ignore context and cannot evaluate
translations accurately; others rely on scripts to search for context
in source files, making the review process time-consuming. To address
this, git-po-helper implements a compare subcommand that extracts new
or modified translations with full context (complete msgid/msgstr
pairs), significantly improving review efficiency.

A limitation is that extracted content lacks other already translated
content for reference, which may affect terminology consistency. This
is mitigated by including a glossary in the PO file header.
git-po-helper-generated review files include the header entry and
glossary (if present) by default.

The review workflow leverages git-po-helper subcommands:

- git-po-helper compare: Extract new or changed entries between two PO
  file versions into a valid PO file for review. Supports multiple modes:

  * Compare HEAD with working tree (local changes)
  * Compare parent of commit with the commit (--commit)
  * Compare commit with working tree (--since)
  * Compare two arbitrary revisions (-r)

- git-po-helper msg-select: Split large review files into smaller
  batches by entry index range for manageable review sessions. Supports
  range formats like "-50" (first 50), "51-100", "101-" (to end).

Evaluation test using qwen model:

    git-po-helper agent-run review --commit 2000abefba --agent qwen

Benchmark results:

    | Metric           | Value                            |
    |------------------|----------------------------------|
    | Num turns        | 22                               |
    | Input tokens     | 537263                           |
    | Output tokens    | 4397                             |
    | API duration     | 167.84 s                         |
    | Review score     | 96/100                           |
    | Total entries    | 63                               |
    | With issues      | 4 (1 critical, 2 major, 1 minor) |

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/AGENTS.md | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 193 insertions(+), 1 deletion(-)

diff --git a/po/AGENTS.md b/po/AGENTS.md
index 3bb8fb3858..08be73ada5 100644
--- a/po/AGENTS.md
+++ b/po/AGENTS.md
@@ -10,6 +10,7 @@ most commonly used housekeeping tasks:
 1. Generating or updating po/git.pot
 2. Updating po/XX.po
 3. Translating po/XX.po
+4. Reviewing translation quality
 
 
 ## Background knowledge for localization workflows
@@ -729,6 +730,191 @@ and fuzzy entry; do not stop before the loop completes.
    ```
 
 
+### Task 4: Review translation quality
+
+Review may target the full `po/XX.po`, a specific commit, or changes since a
+commit. When asked to review, follow the steps below. **Note**: This task uses
+`git-po-helper compare`; if `git-po-helper` is not available, the task
+cannot be performed.
+
+1. **Check for existing review**: Evaluate the following in order:
+
+   - If `po/review-input.po` does **not** exist, proceed to step 2 regardless
+     of any other files (e.g., batch or JSON files).
+   - If both `po/review-input.po` and `po/review-result.json` exist, go
+     directly to step 5 (Merge and summary) and display the report.
+     Do **not** check for batch or other temporary files; no further review
+     steps are needed.
+   - If `po/review-input.po` exists but `po/review-result.json` does not,
+     go to step 4 (Process one batch) to continue the previous review.
+
+2. **Extract entries**: Run `git-po-helper compare` with the desired range and
+   redirect the output to `po/review-input.po`. Do not use `git show` or
+   `git diff`—they can fragment or lose PO context (see "Comparing PO files
+   for translation and review" under git-po-helper).
+
+3. **Prepare review batches**: Run the script below to clean up any leftover
+   files from previous reviews and split `po/review-input.po` into one or
+   more `po/review-input-<N>.json` files (dynamic batch sizing). Run as a
+   single script (define the function, then call it):
+
+   ```shell
+   review_split_batches () {
+       min_batch_size=${1:-50}
+       rm -f po/review-input-*.json
+       rm -f po/review-result-*.json
+       rm -f po/review-result.json
+       rm -f po/review-output.po
+
+       ENTRY_COUNT=$(grep -c '^msgid ' po/review-input.po 2>/dev/null || true)
+       ENTRY_COUNT=$((ENTRY_COUNT > 0 ? ENTRY_COUNT - 1 : 0))
+
+       if test "$ENTRY_COUNT" -gt $min_batch_size
+       then
+           if test "$ENTRY_COUNT" -gt $((min_batch_size * 8))
+           then
+               NUM=$((min_batch_size * 2))
+           elif test "$ENTRY_COUNT" -gt $((min_batch_size * 4))
+           then
+               NUM=$((min_batch_size + min_batch_size / 2))
+           else
+               NUM=$min_batch_size
+           fi
+           BATCH_COUNT=$(( (ENTRY_COUNT + NUM - 1) / NUM ))
+           for i in $(seq 1 "$BATCH_COUNT")
+           do
+               START=$(((i - 1) * NUM + 1))
+               END=$((i * NUM))
+               if test "$END" -gt "$ENTRY_COUNT"
+               then
+                   END=$ENTRY_COUNT
+               fi
+               if test "$i" -eq 1
+               then
+                   git-po-helper msg-select --json --range "-$NUM" \
+                       -o "po/review-input-$i.json" po/review-input.po 
+               elif test "$END" -ge "$ENTRY_COUNT"
+               then
+                   git-po-helper msg-select --json --range "$START-" \
+                       -o "po/review-input-$i.json" po/review-input.po 
+               else
+                   git-po-helper msg-select --json --range "$START-$END" \
+                       -o "po/review-input-$i.json" po/review-input.po 
+               fi
+           done
+       else
+           git-po-helper msg-cat --json \
+               -o po/review-input-1.json po/review-input.po
+       fi
+   }
+   # Parameter controls batch size; reduce if the batch file is too large for
+   # the Agent to process.
+   review_split_batches 20
+   ```
+
+4. **Process one batch (repeat until none left)**:
+
+   a. If no `po/review-input-*.json` files exist, proceed to step 5.
+
+   b. Select the smallest remaining index N (e.g. `po/review-input-1.json`).
+      The current batch is `po/review-input-<N>.json`.
+
+   c. Review translation quality in the current batch: Read the current
+      batch file (`po/review-input-<N>.json`) and:
+      - Consult the "Background knowledge for localization workflows" section
+        for PO format, JSON format, placeholder rules, and terminology. If the
+        current batch file has a glossary in the `header_comment` field, add
+        it to your context for consistent terminology.
+      - Do not review or modify the header entry (in PO format: empty `msgid`
+        with metadata in `msgstr`; in JSON format: `header_comment` and
+        `header_meta`).
+      - For all other entries, check the quality of translations in `msgstr`
+        (singular form) and `msgstr_plural` (plural forms) against `msgid` and
+        `msgid_plural`. See the "Quality checklist" above for criteria.
+
+   d. After reviewing all entries in the current batch, write the issues you
+      found to `po/review-result-<N>.json` using the format described in the
+      "Review result JSON format" section below. If no issues found, write
+      `{"issues": []}` to `po/review-result-<N>.json`. Always write this file;
+      it marks the batch as complete.
+
+   e. Delete the current batch file (`po/review-input-<N>.json`).
+
+   f. Return to step 4a.
+
+   This loop is resumable: remaining `po/review-input-*.json` files indicate
+   batches still to process.
+
+5. **Merge and summary**: Run the command below to merge all
+   `po/review-result-*.json` files into `po/review-result.json`, apply the
+   result to `po/review-output.po`, and display the report.
+
+   ```shell
+   git-po-helper agent-run report
+   ```
+
+   **Do not delete** `po/review-result.json`, `po/review-output.po`, or
+   `po/review-input.po`.
+
+**Review result JSON format**:
+
+The **Review result JSON** format defines the structure for translation
+review reports. For each entry with translation issues, create an issue
+object as follows:
+
+- Copy the original entry's `msgid`, `msgstr`, `msgid_plural` and
+  `msgstr_plural` (if present) to the corresponding fields in the
+  result issue object.
+- Write a summary of all issues found for this entry in `description`.
+- Set `score` according to the severity of issues found for this entry,
+  from 0 to 3 (3 = perfect, no issues; 0 = critical, 1 = major, 2 = minor).
+- Place the suggested translation in `suggest_msgstr` (singular) or
+  `suggest_msgstr_plural` (plural).
+- Include only entries with issues (score less than 3). When no issues
+  are found in the batch, write `{"issues": []}`.
+
+Example review result (with issues):
+
+```json
+{
+  "issues": [
+    {
+      "msgid": "commit",
+      "msgid_plural": "",
+      "msgstr": "委托",
+      "msgstr_plural": [],
+      "suggest_msgstr": "提交",
+      "suggest_msgstr_plural": [],
+      "score": 0,
+      "description": "Terminology error: 'commit' should be translated as '提交'"
+    },
+    {
+      "msgid": "repository",
+      "msgid_plural": "repositories",
+      "msgstr": "",
+      "msgstr_plural": ["版本库", "版本库"],
+      "suggest_msgstr": "",
+      "suggest_msgstr_plural": ["仓库", "仓库"],
+      "score": 2,
+      "description": "Consistency issue: '版本库' and '仓库' are used interchangeably; suggest using '仓库' consistently"
+    }
+  ]
+}
+```
+
+Field descriptions for each issue object (element of the `issues` array):
+
+- `msgid` (and `msgid_plural` for plural entries): Original source text.
+- `msgstr` (and `msgstr_plural` for plural entries): Original translation.
+- `suggest_msgstr`: Suggested translation for the singular form.
+- `suggest_msgstr_plural`: Array of suggested translations for plural forms;
+  `suggest_msgstr` is empty for plural-only entries.
+- `score`: 0–3 (see scale below).
+- `description`: Brief summary of the issue.
+- Score scale: 0 = critical (must fix before release), 1 = major (should fix),
+  2 = minor (improve later), 3 = perfect.
+
+
 ## Human translators remain in control
 
 Git translation is human-driven; language team leaders and contributors are
@@ -741,7 +927,13 @@ responsible for:
 - Building and maintaining language glossaries
 - Reviewing and approving all changes before submission
 
-AI tools, if used, only accelerate routine tasks.
+AI tools, if used, only accelerate routine tasks:
+
+- First-draft translations for new or updated messages
+- Finding untranslated or fuzzy entries
+- Checking consistency with glossary and existing translations
+- Detecting technical errors (placeholders, formatting)
+- Reviewing against quality criteria
 
 AI-generated output should always be treated as rough drafts requiring human
 review, editing, and approval by someone who understands both the technical
-- 
2.53.0.rc2.20.g532543fa46

