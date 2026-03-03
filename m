Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50C494A08
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552044; cv=none; b=gfOkIqWBmAqT/Ao4Qw2BeeWxnGUm+E5Hqx15+g3e+KeYULTq/PWGOdwqzx3Qxzfxpj/YqmAh6bgtlVhksSaZEfyLD4Argbw35J82gHOndDdm+brwlVS97Dgjs9EpWSXa22kbUY1le5BVs0KMDxzktXANvE08zBp5MW+m2k07XUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552044; c=relaxed/simple;
	bh=+M8vKBGWxU43QAJqueG8ejkJ31dm8+VTdhAkS832ipg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQBpkyb4/qlm83nLRQJfZahqnIh+wtDXCvfMFNXBlglcch9657RfUg38NbwbakK80VC4+HguxQRffSWD6lsbiHoE+q1PBXtMdSxdY/cDbJBWX3W3BWLJb0NKM1q2q7/k4FmpHdhxUJnJOli1d4lnnV45h+TSu49TxXXbk5/see4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZXs8GKJ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZXs8GKJ"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79854193a54so56623327b3.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 07:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772552041; x=1773156841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG0ckpxYD0vWac61jF+ukVJcLNP9KHw/4qra2ZCr8oE=;
        b=EZXs8GKJo9NpUqivV7g2wE9XKFC8iIDZMdqBVVFSYD+nkPXNg8yQdoe2zkaXpbkhEN
         HuMEo/Fkx90qCc+U7xIh3Ym93WRJ74BUSpkLoBPKkae4uvd7/6/HDV9UYa198kXumd7q
         aQeGGWO9qvzsJUTHEqeF5FKkt/aWd+exmU0FbxI0I1YOuQUO/um/sEAhxAem3p2p2dvr
         /kFTTGdnArUa+8Y7++kSNm+7nboAm2fXZ9Eu8iYsDwmTC/6HiQ3x0GMQnE4NoVvK8qq5
         OPSr/ZnezaA674yLBjKtnWFbGg4GqOXvZNGTQXbv30pJjVdCPrfdrOLQ01zOE093anDt
         KQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772552041; x=1773156841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kG0ckpxYD0vWac61jF+ukVJcLNP9KHw/4qra2ZCr8oE=;
        b=k8ZYuHxtsVeKZY0k2Ec43ti8joRCXemJUOCaGYmI7USAGuW1RYXkz1G2AVafFOAOTL
         cLamT9JbWmDcJ7LgSukTO51bCu/5hHE6+lGgS73s6ULcn/nUUpEFjqNUUsL0h8ExxEqy
         26pqpSFhaG7mb95gbHG6L1s4TbgSKnZe3ckGOuHOEPsuygNzEwzCLZTpUWEkDUWk5PVA
         fmUSv2a1lLo6yfymQUOtLMcG0gqeHJcqxCitNpxeghAmkJUKzuTAL9ai8ty1pPDdtGRc
         lG/bRZaTLuTyKCkMzMFDB61mxvc9BAccc2kYYrTzQwCtTu549qBmejyzJDfzG+oZwJeC
         PKlA==
X-Forwarded-Encrypted: i=1; AJvYcCXMl1AlbKWL5ZvDGddjPMhTKCoezgUdT8rJOpFSG21hRjvwFqhh7YxiNzDKDV5Y5+wHB8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBvXZhbbnR28zz5vRABfueAJO0n4mRTjR97e+zJdl4PLtXS2F
	0xj0t+rn0WC77EA3zO7hshg1ZjOfWkiLkzadHsvEhHGtx2+tuRiFTcvN
X-Gm-Gg: ATEYQzz83amBcShr396Mk8aE+zi5QppdgwOK/3XLQONooYOJ4eVtLd1X9Shdqcc4Sw2
	PK3wjXJ23uf3K+1clYqlAmdP5ZUXUuk3pzpN4hX00gaqGHQJwwgygOmgly9lQ6Dn+aoFDZ11NWw
	MxvO2zc+k9b0aX/yvwmLAXnvVu9ZOSUBF7AQi659GQC3t2RUHntvo9+XK9gEWlnycy/KbWZ8Yes
	Ve9jSLlpm0vJiUytrpvNnlcLJx33lki9DYao0PFl5So7tFIINBnoQRqvU3X/DkDVpYwfnQ1IwVv
	HqE6jHOJOLgxGJwOoBu3BjRIkW2BWA1TSqS2FPcOSAv7QpweH0KGpUBCyAY+yfRZvK7RzKKXPb9
	IrDCIyBeELS1vfQslY2N79q8p3n1cTCPGuMlxhXFEYHuus0LuwF8eTGzQCMN7DLxa1PyByudTLE
	vHEDIfyQ4tbb5qvW3ut24SKlyE1q21JU+ET7w8EyOTF1C+AezXJC2vQIME8fo5rQ/rtGYQqSvMp
	lrjuMEkfUWyiMteprQGU/MKslHb7sES6am4sU5FERHgyTMVGNCvH8+K+J+G8bs60QRfaxGy3pji
	kgqYWaw7WrE=
X-Received: by 2002:a05:690c:4b01:b0:797:a162:f7c1 with SMTP id 00721157ae682-7988547cfe9mr135706307b3.16.1772552041084;
        Tue, 03 Mar 2026 07:34:01 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a8feacsm64364057b3.11.2026.03.03.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:34:00 -0800 (PST)
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
Subject: [PATCH v2 4/5] docs(l10n): add AI agent instructions for translating PO files
Date: Tue,  3 Mar 2026 23:33:31 +0800
Message-ID: <d6785db1dfedeccca1cddc17d8c95b99eb266500.1772551123.git.worldhello.net@gmail.com>
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

Add a new "Translating po/XX.po" section to po/AGENTS.md with detailed
workflow and procedures for AI agents to translate language-specific PO
files. Users can invoke AI-assisted translation in coding tools with a
prompt such as:

    "Translate the po/XX.po file by referring to @po/AGENTS.md"

Translation results serve as a reference; human contributors must
review and approve before submission.

To address the translation efficiency issues of some LLMs, batch
translation replaces entry-by-entry translation. git-po-helper
implements a gettext JSON format for translation files, replacing PO
format during translation to enable batch processing.

Evaluation test using the qwen model:

    git-po-helper agent-run --agent=qwen translate po/zh_CN.po

Test translation (127 entries, 50 per batch):

    Initial state:  5998 translated, 91 fuzzy, 36 untranslated
    Final state:    6125 translated, 0 fuzzy, 0 untranslated

    Successfully translated: 127 entries (91 fuzzy + 36 untranslated)
    Success rate: 100%

Benchmark results (3-run average):

AI Agent using gettext tools:

    | Metric           | Value                          |
    |------------------|--------------------------------|
    | Avg Num turns    | 86 (176, 44, 40)               |
    | Avg Exec Time    | 20m44s (39m56s, 14m38s, 7m38s) |
    | Successful runs  | 3/3                            |

AI Agent using git-po-helper (JSON batch flow):

    | Metric           | Value                          |
    |------------------|--------------------------------|
    | Avg Num turns    | 56 (68, 39, 63)                |
    | Avg Exec Time    | 19m8s (28m55s, 9m1s, 19m28s)   |
    | Successful runs  | 3/3                            |

The git-po-helper flow reduces turns (86 → 56) with similar execution
time; the bottleneck appears to be LLM processing rather than network
interaction.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/AGENTS.md | 643 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 642 insertions(+), 1 deletion(-)

diff --git a/po/AGENTS.md b/po/AGENTS.md
index 5eb1a606e1..3bb8fb3858 100644
--- a/po/AGENTS.md
+++ b/po/AGENTS.md
@@ -5,7 +5,11 @@ housekeeping tasks for Git l10n. Use of AI is optional; many successful
 l10n teams work well without it.
 
 The section "Housekeeping tasks for localization workflows" documents the
-most commonly used housekeeping tasks.
+most commonly used housekeeping tasks:
+
+1. Generating or updating po/git.pot
+2. Updating po/XX.po
+3. Translating po/XX.po
 
 
 ## Background knowledge for localization workflows
@@ -51,6 +55,384 @@ The header provides: translation metadata (translator, language, dates);
 pluralization rules (`Plural-Forms`); encoding and MIME type; project/version.
 
 
+### Glossary Section
+
+PO files may have a glossary in comments before the header entry (first
+`msgid ""`), giving terminology guidelines:
+
+```po
+# Git glossary for Chinese translators
+#
+#   English                          |  Chinese
+#   ---------------------------------+--------------------------------------
+#   3-way merge                      |  三路合并
+#   branch                           |  分支
+#   commit                           |  提交
+#   ...
+```
+
+**IMPORTANT**: Read and use the glossary when translating or reviewing. It is
+in `#` comments and is preserved when extracting with `msgattrib`.
+
+
+### Single-line vs Multi-line Entries
+
+**Single-line entries**:
+```po
+msgid "commit message"
+msgstr "提交说明"
+```
+
+**Multi-line entries** (first line of `msgid` and `msgstr` is empty string):
+```po
+msgid ""
+"Line 1\n"
+"Line 2"
+msgstr ""
+"行 1\n"
+"行 2"
+```
+
+**CRITICAL** for multi-line: first line is `msgid ""` / `msgstr ""`; following
+lines are quoted strings; use `\n` for line breaks. Preserve quotes and
+structure exactly.
+
+Because multi-line entries also use `msgstr ""` on the first line, `grep
+'^msgstr ""'` yields false positives when locating untranslated strings. See
+the next section for the correct approach.
+
+
+### Locating untranslated, fuzzy, and obsolete entries
+
+**The commands below are used in "Task 3: translating po/XX.po".** For
+translation tasks, follow Task 3 steps strictly; do not run these commands in
+isolation.
+
+This section describes how to locate untranslated, fuzzy, and obsolete entries.
+Do **not** use `grep '^msgstr ""$'`—it matches multi-line entries and causes
+false positives. Use `msgattrib`:
+
+- **Untranslated**: `msgattrib --untranslated --no-obsolete po/XX.po`
+- **Fuzzy**: `msgattrib --only-fuzzy --no-obsolete po/XX.po`
+- **Obsolete** (`#~`): `msgattrib --obsolete --no-wrap po/XX.po`
+
+To get only message IDs:
+`msgattrib --untranslated --no-obsolete po/XX.po | sed -n '/^msgid /,/^$/p'`
+(Same pattern for fuzzy with `--only-fuzzy`.)
+
+When counting entries, the header is included; subtract 1 to exclude it.
+
+
+### Translating fuzzy entries
+
+Fuzzy entries need re-translation because the source text changed. The format
+differs by file type:
+
+- **PO file**: A `#, fuzzy` tag in the entry comments marks the entry as fuzzy.
+- **JSON file**: The entry has `"fuzzy": true`.
+
+**Translation principles**: Re-translate the `msgstr` (and, for plural entries,
+`msgstr[n]`) into the target language. Do **not** modify `msgid` or
+`msgid_plural`. After translation, **clear the fuzzy mark**: in PO, remove the
+`#, fuzzy` tag from comments; in JSON, omit or set `fuzzy` to `false`.
+
+
+### Preserving Special Characters
+
+Preserve escape sequences (`\n`, `\"`, `\\`, `\t`), placeholders (`%s`, `%d`,
+etc.), and quotes exactly as in `msgid`. Only reorder placeholders with
+positional syntax when needed (see Placeholder Reordering below).
+
+**Correct**: `msgstr "行 1\n行 2"` (keep `\n` as escape).
+**Wrong**: `msgstr "行 1\\n行 2"` or actual line breaks inside the string.
+
+
+### Placeholder Reordering
+
+When reordering placeholders from the original `msgid`, use positional syntax
+(`%n$`) so each argument maps to the correct value. Keep width/precision
+modifiers and put the position before them.
+
+**Example 1** (precision):
+```po
+#, c-format
+msgid "missing environment variable '%s' for configuration '%.*s'"
+msgstr "配置 '%3$.*2$s' 缺少环境变量 '%1$s'"
+```
+`%s` → argument 1 → `%1$s`. `%.*s` needs precision (arg 2) and string (arg 3) →
+`%3$.*2$s`.
+
+**Example 2** (multi-line, four `%s` reordered):
+```po
+#, c-format
+msgid ""
+"the 'submodule.%s.gitdir' config does not exist for module '%s'. Please "
+"ensure it is set, for example by running something like: 'git config "
+"submodule.%s.gitdir .git/modules/%s'. For details see the "
+"extensions.submodulePathConfig documentation."
+msgstr ""
+"模块 '%2$s' 的 'submodule.%1$s.gitdir' 配置不存在。请确保已设置，例如运行类"
+"似：'git config submodule.%3$s.gitdir .git/modules/%4$s'。详细信息请参见 "
+"extensions.submodulePathConfig 文档。"
+```
+
+Original order 1,2,3,4; in translation 2,1,3,4. Each line must be a complete
+quoted string.
+
+**Rules**: Use `%n$` (n = 1-based position); place position before
+width/precision; for `%.*s` map both precision and string; verify all
+placeholders are mapped.
+
+
+### Validating PO File Format
+
+Validate any PO file (e.g. `po/XX.po`, `po/l10n-pending.po`):
+
+```shell
+msgfmt --check -o /dev/null po/XX.po
+```
+
+Common validation errors include:
+- Unclosed quotes
+- Missing escape sequences
+- Invalid placeholder syntax
+- Malformed multi-line entries
+- Incorrect line breaks in multi-line strings
+
+**Handling validation errors with automatic repair**:
+When `msgfmt` reports an error, it provides the line number where the error
+was detected. Use this information to locate and fix the issue.
+
+
+### Using git-po-helper
+
+[git-po-helper](https://github.com/git-l10n/git-po-helper) is a helper program
+for Git localization (l10n) contributions. It serves two main purposes:
+**quality checking** (conventions for git-l10n pull requests) and
+**AI-assisted translation** (evaluate; help establish and assess the impact
+of this document on automated translation). git-po-helper provides subcommands
+that simplify the AI translation workflow and improve efficiency. When
+available, this document uses `git-po-helper` for PO operations; otherwise it
+falls back to gettext tools.
+
+**This section serves as reference for Housekeeping tasks.** AI Agent should
+follow the Task steps when executing; this content provides command reference
+information. Do not run commands in isolation.
+
+
+#### Splitting large PO files
+
+When a PO file is too large for translation or review, use `git-po-helper
+msg-select` to split it by entry index.
+
+- **Entry 0** is the header (included by default; use `--no-header` to omit).
+- **Entries 1, 2, 3, …** are content entries.
+- **Range format**: `--range "1-50"` (entries 1 through 50), `--range "-50"`
+  (first 50 entries), `--range "51-"` (from entry 51 to end).
+- **Output format**: PO by default; use `--json` for GETTEXT JSON. See the
+  "GETTEXT JSON format" section (under git-po-helper) for details.
+- **State filter**: Use `--translated`, `--untranslated`, `--fuzzy` to filter
+  by state (OR relationship). Use `--no-obsolete` to exclude obsolete entries;
+  `--with-obsolete` to include (default). Use `--only-same` or `--only-obsolete`
+  for a single state. Range applies to the filtered list.
+
+```shell
+# First 50 entries (header + entries 1–50)
+git-po-helper msg-select --range "-50" po/in.po -o po/out1.po
+
+# Entries 51–100
+git-po-helper msg-select --range "51-100" po/in.po -o po/out2.po
+
+# Entries 101 to end
+git-po-helper msg-select --range "101-" po/in.po -o po/out3.po
+
+# Entries 1–50 without header (content only)
+git-po-helper msg-select --range "1-50" --no-header po/in.po -o po/frag.po
+
+# Output as JSON; select untranslated and fuzzy entries, exclude obsolete
+git-po-helper msg-select --json --untranslated --fuzzy --no-obsolete po/in.po >po/filtered.json
+```
+
+
+#### Comparing PO files for translation and review
+
+Use `git-po-helper compare` for scenarios that `git diff` or `git show` cannot
+handle well:
+
+- **Show changes with full context**: Get new and modified entries with
+  complete `msgid` and `msgstr`. Plain `git diff` fragments or loses PO
+  context.
+- **Detect msgid tampering**: When an AI-generated PO file may have altered
+  `msgid`, a translation becomes an add instead of a replace. Use `--msgid`
+  to compare by msgid only. No diff output means the target and source files
+  are consistent in the data source (msgid).
+
+These capabilities support both translation workflows and code review. Redirect
+output to a file:
+
+```shell
+# Check msgid consistency (detect tampering); no output means target matches source
+git-po-helper compare --msgid po/old.po po/new.po >po/out.po
+
+# Get full context of local changes (HEAD vs working tree)
+git-po-helper compare po/XX.po -o po/out.po
+
+# Get full context of changes in a specific commit (parent vs commit)
+git-po-helper compare --commit <commit> po/XX.po -o po/out.po
+
+# Get full context of changes since a commit (commit vs working tree)
+git-po-helper compare --since <commit> po/XX.po -o po/out.po
+
+# Get full context between two commits
+git-po-helper compare -r <commit1>..<commit2> po/XX.po -o po/out.po
+
+# Get full context of two worktree files
+git-po-helper compare po/old.po po/new.po -o po/out.po
+```
+
+**Options summary**
+
+| Option              | Meaning                                        |
+|---------------------|------------------------------------------------|
+| (none)              | Compare HEAD with working tree (local changes) |
+| `--commit <commit>` | Compare parent of commit with the commit       |
+| `--since <commit>`  | Compare commit with working tree               |
+| `-r x..y`           | Compare revision x with revision y             |
+| `-r x..`            | Compare revision x with working tree           |
+| `-r x`              | Compare parent of x with x                     |
+
+Output is empty when there are no new or changed entries; otherwise it
+includes a valid PO header.
+
+
+#### Concatenating multiple PO/JSON files
+
+Use `git-po-helper msg-cat` to merge one or more input files (PO, POT, or
+gettext JSON) into a single output. Input format is auto-detected by content
+or extension. For duplicate `msgid`, the first occurrence by file order wins.
+Use `-o <file>` for output; omit or use `-o -` for stdout. Use `--json` for
+JSON output; otherwise output is PO format.
+
+```shell
+# Convert JSON to PO (e.g. after translation)
+git-po-helper msg-cat --unset-fuzzy -o po/out.po po/in.json
+
+# Merge multiple PO files
+git-po-helper msg-cat -o po/out.po po/in-1.po po/in-2.po
+```
+
+
+#### GETTEXT JSON format
+
+The **GETTEXT JSON** format is an internal format defined by `git-po-helper`
+for convenient batch processing of translation and related tasks by AI models.
+`git-po-helper msg-select`, `git-po-helper msg-cat`, and `git-po-helper compare`
+read and write this format.
+
+**Top-level structure**:
+
+```json
+{
+  "header_comment": "string",
+  "header_meta": "string",
+  "entries": [ /* array of entry objects */ ]
+}
+```
+
+| Field            | Description                                                                   |
+|------------------|-------------------------------------------------------------------------------|
+| `header_comment` | Lines above the first `msgid ""` (comments, glossary). Directly concatenated. |
+| `header_meta`    | Decoded `msgstr` of the header entry (Project-Id-Version, Plural-Forms, etc.).|
+| `entries`        | List of PO entries. Order matches source.                                     |
+
+**Entry object** (each element of `entries`):
+
+| Field           | Type     | Description                                           |
+|-----------------|----------|-------------------------------------------------------|
+| `msgid`         | string   | Singular message ID. PO escapes encoded.              |
+| `msgstr`        | string   | Singular message string. Empty for plural entries.    |
+| `msgid_plural`  | string   | Plural form of msgid. Omit for non-plural.            |
+| `msgstr_plural` | []string | Array of msgstr[0], msgstr[1], … Omit for non-plural. |
+| `comments`      | []string | Comment lines (`#`, `#.`, `#:`, `#,`, etc.).          |
+| `fuzzy`         | bool     | True if entry has fuzzy flag.                         |
+| `obsolete`      | bool     | True for `#~` obsolete entries. Omit if false.        |
+
+**Example (single-line entry)**:
+
+```json
+{
+  "header_comment": "# Glossary:\\n# term1\\tTranslation 1\\n#\\n",
+  "header_meta": "Project-Id-Version: git\\nContent-Type: text/plain; charset=UTF-8\\n",
+  "entries": [
+    {
+      "msgid": "Hello",
+      "msgstr": "你好",
+      "comments": ["#. Comment for translator\\n", "#: src/file.c:10\\n"],
+      "fuzzy": false
+    }
+  ]
+}
+```
+
+**Example (plural entry)**:
+
+```json
+{
+  "msgid": "One file",
+  "msgstr": "",
+  "msgid_plural": "%d files",
+  "msgstr_plural": ["一个文件", "%d 个文件"],
+  "comments": ["#, c-format\\n"],
+  "fuzzy": false
+}
+```
+
+**Example (fuzzy entry before translation)**:
+
+```json
+{
+  "msgid": "Old message",
+  "msgstr": "旧翻译",
+  "comments": ["#, fuzzy\\n"],
+  "fuzzy": true
+}
+```
+
+**Translation notes for GETTEXT JSON files**:
+
+- **Preserve structure**: Keep `header_comment`, `header_meta`, `comments`,
+  `msgid`, `msgid_plural` unchanged. Only modify `msgstr` and `msgstr_plural`.
+- **Fuzzy entries**: Entries extracted from fuzzy PO entries have `"fuzzy": true`.
+  After translating, **remove the `fuzzy` field** or set it to `false` in the
+  output (`po/l10n-done.json`). The merge step uses `--unset-fuzzy`, which can
+  also remove the `fuzzy` field.
+- **Placeholders**: Preserve `%s`, `%d`, etc. exactly; use `%n$` when
+  reordering (see "Placeholder Reordering" above).
+
+
+### Quality checklist
+
+- **Accuracy**: Faithful to original meaning; no omissions or distortions.
+- **Fuzzy entries**: Re-translate fully and clear the fuzzy flag (see
+  "Translating fuzzy entries" above).
+- **Terminology**: Consistent with glossary (see "Glossary Section" above) or
+  domain standards.
+- **Grammar and fluency**: Correct and natural in the target language.
+- **Placeholders**: Preserve variables (`%s`, `{name}`, `$1`) exactly; use
+  positional parameters when reordering (see "Placeholder Reordering" above).
+- **Special characters**: Preserve escape sequences (`\n`, `\"`, `\\`, `\t`),
+  placeholders, and quotes exactly as in `msgid`. Correct: `msgstr "行 1\n行 2"`
+  (keep `\n` as escape). Wrong: `"行 1\\n行 2"` or actual line breaks inside the
+  string. See "Preserving Special Characters" above.
+- **Plurals and gender**: Correct forms and agreement.
+- **Context fit**: Suitable for UI space, tone, and use (e.g. error vs. tooltip).
+- **Cultural appropriateness**: No offensive or ambiguous content.
+- **Consistency**: Match prior translations of the same source.
+- **Technical integrity**: Do not translate code, paths, commands, brands, or
+  proper nouns.
+- **Readability**: Clear, concise, and user-friendly.
+
+
 ## Housekeeping tasks for localization workflows
 
 This section describes housekeeping tasks listed in the introduction. Read
@@ -88,6 +470,265 @@ The command will handle all necessary steps including generating
 automatically.
 
 
+### Task 3: Translating po/XX.po
+
+When asked to translate `po/XX.po`, follow the steps below. The workflow
+**automatically selects** the tool based on availability: use `git-po-helper`
+if present, otherwise use gettext tools. With `git-po-helper`, the content to
+translate is converted to JSON, enabling batch translation instead of
+entry-by-entry translation for better efficiency. Translate every untranslated
+and fuzzy entry; do not stop before the loop completes.
+
+1. **Extract entries to translate**: Generate `po/l10n-pending.po` with
+   untranslated and fuzzy messages. If the generated `po/l10n-pending.po` file
+   is empty or does not exist, translation is complete. In that case, you
+   **MUST** skip to the last step (clean up); do not run further translation
+   steps.
+
+   ```shell
+   po_extract_pending () {
+       test $# -ge 1 || { echo "Usage: po_extract_pending <po-file>" >&2; exit 1; }
+       PO_FILE="$1"
+       PENDING="po/l10n-pending.po"
+       rm -f "$PENDING"
+
+       if command -v git-po-helper >/dev/null 2>&1
+       then
+           git-po-helper msg-select --untranslated --fuzzy --no-obsolete -o "$PENDING" "$PO_FILE"
+       else
+           msgattrib --untranslated --no-obsolete "$PO_FILE" >"${PENDING}.untranslated"
+           msgattrib --only-fuzzy --no-obsolete --clear-fuzzy --empty "$PO_FILE" >"${PENDING}.fuzzy"
+           msgattrib --only-fuzzy --no-obsolete "$PO_FILE" >"${PENDING}.fuzzy.reference"
+           msgcat --use-first "${PENDING}.untranslated" "${PENDING}.fuzzy" >"$PENDING"
+           rm -f "${PENDING}.untranslated" "${PENDING}.fuzzy"
+       fi
+   }
+   # Run the extraction. Example: po_extract_pending po/zh_CN.po
+   po_extract_pending po/XX.po
+   ```
+
+2. **Prepare one batch for translation**: **BEFORE translating**, run the
+   script below. It truncates large tasks so each run processes one chunk,
+   keeping file size within model capacity.
+
+   Output: `po/l10n-todo.json` (git-po-helper) or `po/l10n-todo.po` (gettext
+   only). If `po/l10n-todo.json` exists, go to step 3a; if `po/l10n-todo.po`
+   exists, go to step 3b.
+
+   ```shell
+   l10n_one_batch () {
+       test $# -ge 1 || { echo "Usage: l10n_one_batch <po-file> [min_batch_size]" >&2; exit 1; }
+       PO_FILE="$1"
+       min_batch_size=${2:-100}
+       PENDING="po/l10n-pending.po"
+       rm -f po/l10n-todo.json po/l10n-done.json po/l10n-todo.po po/l10n-done.po
+
+       ENTRY_COUNT=$(grep -c '^msgid ' "$PENDING" 2>/dev/null || true)
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
+           BATCHING=1
+       else
+           NUM=$ENTRY_COUNT
+           BATCHING=
+       fi
+
+       if command -v git-po-helper >/dev/null 2>&1
+       then
+           if test -n "$BATCHING"
+           then
+               git-po-helper msg-select --json --range "-$NUM" -o po/l10n-todo.json "$PENDING"
+               echo "Processing batch of $NUM entries (out of $ENTRY_COUNT remaining)"
+           else
+               git-po-helper msg-select --json -o po/l10n-todo.json "$PENDING"
+               echo "Processing all $ENTRY_COUNT entries at once"
+           fi
+       else
+           if test -n "$BATCHING"
+           then
+               awk -v num="$NUM" '/^msgid / && count++ > num {exit} 1' "$PENDING" |
+                   tac | awk '/^$/ {found=1} found' | tac >po/l10n-todo.po
+               echo "Processing batch of $NUM entries (out of $ENTRY_COUNT remaining)"
+           else
+               cp "$PENDING" po/l10n-todo.po
+               echo "Processing all $ENTRY_COUNT entries at once"
+           fi
+       fi
+   }
+   # Prepare batch for translation. Second param controls batch size; reduce if
+   # the batch file is too large for the Agent to process.
+   l10n_one_batch po/XX.po 100
+   ```
+
+3a. **Translate JSON batch** (`po/l10n-todo.json` → `po/l10n-done.json`):
+
+   - **Task**: Translate `po/l10n-todo.json` (input, GETTEXT JSON) into
+     `po/l10n-done.json` (output, GETTEXT JSON). See the "GETTEXT JSON format"
+     section above for format details and translation rules.
+   - **Reference glossary**: Read the glossary from the batch file's
+     `header_comment` (see "Glossary Section" above) and use it for
+     consistent terminology.
+   - **When translating**: Follow the "Quality checklist" above for correctness
+     and quality. Handle escape sequences (`\n`, `\"`, `\\`, `\t`), placeholders,
+     and quotes correctly as in `msgid`. For JSON, correctly escape and unescape
+     these sequences when reading and writing. Modify `msgstr` and `msgstr[n]`
+     (for plural entries); clear the fuzzy flag (omit or set `fuzzy` to `false`).
+     Do **not** modify `msgid` or `msgid_plural`.
+
+3b. **Translate PO batch** (`po/l10n-todo.po` → `po/l10n-done.po`):
+
+   - **Task**: Translate `po/l10n-todo.po` (input, PO) into `po/l10n-done.po`
+     (output, PO).
+   - **Reference glossary**: Read the glossary from the pending file header
+     (see "Glossary Section" above) and use it for consistent terminology.
+   - **When translating**: Follow the "Quality checklist" above for correctness
+     and quality. Preserve escape sequences (`\n`, `\"`, `\\`, `\t`), placeholders,
+     and quotes as in `msgid`. Modify `msgstr` and `msgstr[n]` (for plural
+     entries); remove the `#, fuzzy` tag from comments when done. Do **not**
+     modify `msgid` or `msgid_plural`.
+
+4. **Validate `po/l10n-done.po`**:
+
+   Whether from step 3a (JSON converted to PO) or step 3b (PO output directly),
+   the result may have two kinds of issues. Run the validation script; proceed to
+   step 5 only if it succeeds:
+
+   ```shell
+   l10n_validate_done () {
+       DONE_PO="po/l10n-done.po"
+       DONE_JSON="po/l10n-done.json"
+       PENDING="po/l10n-pending.po"
+
+       if test -f "$DONE_JSON" && { ! test -f "$DONE_PO" || test "$DONE_JSON" -nt "$DONE_PO"; }
+       then
+           git-po-helper msg-cat --unset-fuzzy -o "$DONE_PO" "$DONE_JSON" || {
+               echo "ERROR [JSON to PO conversion]: Fix $DONE_JSON and re-run." >&2
+               return 1
+           }
+       fi
+
+       # Check 1: msgid should not be modified
+       MSGID_OUT=$(git-po-helper compare -q --msgid --assert-no-changes \
+           "$PENDING" "$DONE_PO" 2>&1)
+       MSGID_RC=$?
+       if test $MSGID_RC -ne 0 || test -n "$MSGID_OUT"
+       then
+           echo "ERROR [msgid modified]: The following entries appeared after" >&2
+           echo "translation because msgid was altered. Fix in $DONE_PO." >&2
+           echo "$MSGID_OUT" >&2
+           return 1
+       fi
+
+       # Check 2: PO format (see "Validating PO File Format" for error handling)
+       MSGFMT_OUT=$(msgfmt --check -o /dev/null "$DONE_PO" 2>&1)
+       MSGFMT_RC=$?
+       if test $MSGFMT_RC -ne 0
+       then
+           echo "ERROR [PO format]: Fix errors in $DONE_PO." >&2
+           echo "$MSGFMT_OUT" >&2
+           return 1
+       fi
+
+       echo "Validation passed."
+   }
+   l10n_validate_done
+   ```
+
+   If the script fails, fix **directly in `po/l10n-done.po`**. Editing
+   `po/l10n-done.json` is not recommended because it adds an extra JSON-to-PO
+   conversion step. Use the error message to decide:
+
+   - **`[msgid modified]`**: The listed entries have altered `msgid`; restore
+     them to match `po/l10n-pending.po`.
+   - **`[PO format]`**: `msgfmt` reports line numbers; fix the errors in place.
+     See "Validating PO File Format" for common issues.
+
+   Re-run `l10n_validate_done` until it succeeds. If repair fails, exit
+   immediately.
+
+5. **Merge translation results into `po/XX.po`**: Run the following script:
+
+   ```shell
+   l10n_merge_batch () {
+       test $# -ge 1 || { echo "Usage: l10n_merge_batch <po-file>" >&2; exit 1; }
+       PO_FILE="$1"
+       DONE_PO="po/l10n-done.po"
+       DONE_JSON="po/l10n-done.json"
+       MERGED="po/l10n-done.merged"
+       PENDING="po/l10n-pending.po"
+       if test -f "$DONE_JSON" && { ! test -f "$DONE_PO" || test "$DONE_JSON" -nt "$DONE_PO"; }
+       then
+           git-po-helper msg-cat --unset-fuzzy -o "$DONE_PO" "$DONE_JSON" || {
+               echo "ERROR [JSON to PO conversion]: Fix $DONE_JSON and re-run." >&2
+               return 1
+           }
+       fi
+       msgcat --use-first "$DONE_PO" "$PO_FILE" >"$MERGED" || {
+           echo "ERROR [msgcat merge]: Fix errors in $DONE_PO and re-run." >&2
+           exit 1
+       }
+       mv "$MERGED" "$PO_FILE"
+       rm -f "$PENDING"
+   }
+   # Run the merge. Example: l10n_merge_batch po/zh_CN.po
+   l10n_merge_batch po/XX.po
+   ```
+
+   If `msgcat` fails, fix **directly in `po/l10n-done.po`**. Editing
+   `po/l10n-done.json` is not recommended because it adds an extra JSON-to-PO
+   conversion step. If repair fails, exit immediately.
+
+6. **Repeat steps 1–5** until `po/l10n-pending.po` is empty (or does not exist).
+   Do not stop early.
+
+7. **Final verification**:
+
+   ```shell
+   # Final check
+   UNTRANS=$(msgattrib --untranslated --no-obsolete po/XX.po 2>/dev/null | grep -c '^msgid ' || true)
+   UNTRANS=$((UNTRANS > 0 ? UNTRANS - 1 : 0))
+   FUZZY=$(msgattrib --only-fuzzy --no-obsolete po/XX.po 2>/dev/null | grep -c '^msgid ' || true)
+   FUZZY=$((FUZZY > 0 ? FUZZY - 1 : 0))
+   if test "$UNTRANS" -eq 0 && test "$FUZZY" -eq 0
+   then
+       echo "Translation complete! All entries translated."
+   else
+       echo "WARNING: Still have $UNTRANS untranslated + $FUZZY fuzzy entries."
+       echo "Do not clean up. Continue with step 1."
+       exit 1
+   fi
+   ```
+
+8. **Clean up** (only after step 7 passes):
+
+   ```shell
+   po_cleanup () {
+       rm -f "po/l10n-pending.po"
+       rm -f "po/l10n-pending.po.fuzzy"
+       rm -f "po/l10n-pending.po.fuzzy.reference"
+       rm -f "po/l10n-pending.po.untranslated"
+       rm -f "po/l10n-todo.json"
+       rm -f "po/l10n-todo.po"
+       rm -f "po/l10n-done.json"
+       rm -f "po/l10n-done.merged"
+       rm -f "po/l10n-done.po"
+       echo "Cleanup complete. Translation finished successfully."
+   }
+   # Run cleanup
+   po_cleanup
+   ```
+
+
 ## Human translators remain in control
 
 Git translation is human-driven; language team leaders and contributors are
-- 
2.53.0.rc2.20.g532543fa46

