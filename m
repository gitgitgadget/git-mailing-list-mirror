Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4BD3D5246
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296440; cv=none; b=GJwgKL8cTK+dF6V3cJVuYYGF2c7tBZ02HDEEHK3Np3hWk7f8PxfgW/05CWi1QwjqP5AXFtfNMKOkAHc9LDwlkl4JgkuyCeIzkm7yyCsO+UgH3qjJep37cFuZw8SmbUB7uqyC8NmXS2L4Go6RmBmoEV7GHN4gUxK3Fka74whNXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296440; c=relaxed/simple;
	bh=GWAihX+sjDqK2SaqEeBhdD8JiSQNO/jhx4uVnvh8n5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5gt4QyM/Y3TTSocpGr6gM8lT/Y+PEDq3+S8j1TWsqiyX+qWSAEhLHjV1zB9VMkT9eruRSSGi552VeSz1+iRtS/fa3HaVY41dmO8eDfO/FOYiZSocygpFzmNDdQcDPm5Dgsn/P5zJbxL4O9LTyFiYq3IFTKJcN033foxATcL4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV3D5b6c; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV3D5b6c"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7927261a3acso8718337b3.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 05:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770296438; x=1770901238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqpCH9LLIX4s9fjToFxnajaBccJ8yezPb+85wKCKTvc=;
        b=cV3D5b6ct3m4PR0U48IPvpSTec7dl6gYN2pxH30PWzMpBchTMu3Jhun6DALrm4tj8C
         aGWiRjipj9cKmcoFkPxod3USmeiNYYKzCel8OEam7wCcsrn8p7rRG9gs7LCCOnlZFuax
         4JD8u7pYmR/5q9FtXRJfGYXgdTx4zQqjFVh5xOePa6kvw4uGnIWh+WWI1IREp1bajtsQ
         Y3PLHLVuaoU99JLAjP00L8SZbD0KQDi0Ib86FdnmZIktf3qSiSv3Oyzy0jCmcaPazanx
         lliCFLPrdymkOfbWkL6ZpBZdbX2L4CmqJBCeR3Mtecb149+w+X5s3T3d+CaPU/YKPLtA
         7aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296438; x=1770901238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqpCH9LLIX4s9fjToFxnajaBccJ8yezPb+85wKCKTvc=;
        b=TeR+SWbP31hP2QX7lBfP5rYsDbfrnXvPQwkX1CR8K6nL39k4BPIYcBHFvdLX39KMal
         0RawdLNipUQtbikFcgeNhsEvIKBfDVXx7jFVMmalAO9GMSZXKTKOsg93ZErNShmaLnCh
         0/xQU4bafNdnEUjwJFLe15FSDchFu3eUqNO3QBrktwTytXwRzHTDYognhv7OEcIaSj98
         rRwcycqeS5jKYmSKJl27v27DoM3z1AP1HBzbLa1CJeBowARLLlYNW7XitgNg9+ySm7Yb
         aPX7VSk5kRwHKgqdpdan4OoMU0NMUYQwXu01cF+OOslT6N847BThmVfmiI+kXCUMQMFP
         t00w==
X-Gm-Message-State: AOJu0YxNb2zF0tTs6DLC3hV8S4AU/cLr27Q1sLF1eACB4WUkjeigjg6/
	0b1nIEl7OQErsEbuU+asV2DxlsSa5mv1Q6cVzJkkgh+YVh122fw/Qvbng8n8iT8pWM0=
X-Gm-Gg: AZuq6aKBRTAPQiZqJ/3C8EEyWJY24BRGLTjqn7EKrz4Q5GOP9qiEeEEmvMZakHU+jk5
	bpXoF1uKZwpxNkOqsbJw7MT7D6gBskPBwDzU1o8uuZjJQ5jqrREyoa8lb/+zX8KbdSbuWPTSo7q
	RGQZ038qVnqdS14EaH+6Vr1DddFPSA/sqohtic5o3zFqP5LiU2kjbl2BZg27Fi5JKc0eU5+xfhk
	Ri+wNDs0jX0BRXAsIHfpKggUgPE3qdUcmi1vMvEGu97i9W/jsCE49meL7RZGeJxA9XWB4ClxSP+
	SZcCNb55WjvV/dHrbb27suR4V2Y4Jzin+TuWQZHIzKDnDPJlBTGZazo2prn+gI2na+hrFUqzE7a
	5GuhnsBCNRj9Z0FUA4u7nC3mhRTSw19LBn/tQLkrTyY1zHXOIj/m8Da8sB53MfA+4Nu0B43fhR5
	Mnp4Vs0Jnd3/Ve/HTylMNUkNq89dyN9HTcMn+rB3mgbS+pzNAyxBiv/vGeqNLobUW3YKASGocbV
	blT59/CLTflEuqWuvRzEwUtw/0Kxmy5x0lxNqpez/fyumMjMoklPxv6bsv3/6pNQA0vx4UWaIE=
X-Received: by 2002:a05:690c:397:b0:794:b36f:7a72 with SMTP id 00721157ae682-794fe62cb75mr62953147b3.5.1770296438015;
        Thu, 05 Feb 2026 05:00:38 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc49692bsm5263152d50.5.2026.02.05.05.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:00:37 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [RFC PATCH 2/2] l10n: README: document AI assistant guidelines
Date: Thu,  5 Feb 2026 21:00:28 +0800
Message-ID: <71bfd9231e339cf43af86cfbffbbdde753d3fb82.1770296405.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add guidelines for using AI tools as optional assistants in Git
localization work, while emphasizing human translators remain in
control.

Also update `git-po-helper` command examples to include the
`--pot-file=build` option.

Example usage in prompts to AI assistants:

  - "Update translations in `po/XX.po` following the guidelines
    in @po/README.md"
  - "Review all translations in `po/XX.po` following the guidelines
    in @po/README.md"

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/README.md | 294 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 291 insertions(+), 3 deletions(-)

diff --git a/po/README.md b/po/README.md
index ad7f72ba83..6ba082376a 100644
--- a/po/README.md
+++ b/po/README.md
@@ -227,8 +227,8 @@ L10n coordinator will check your contributions using a helper program
 (see "PO helper" section below):
 
 ```shell
-git-po-helper check-po po/XX.po
-git-po-helper check-commits <rev-list-opts>
+git-po-helper check-po --pot-file=build po/XX.po
+git-po-helper check-commits --pot-file=build <rev-list-opts>
 ```
 
 
@@ -430,7 +430,7 @@ There are some conventions that l10n contributors must follow:
   your commit:
 
   ```shell
-  git-po-helper check-po <XX.po>
+  git-po-helper check-po --pot-file=build <XX.po>
   ```
 
 - Squash trivial commits to make history clear.
@@ -459,5 +459,293 @@ additional conventions:
   ```
 
 
+## Artificial Intelligence (AI) as Translation Assistant
+
+This section provides guidance for human translators who choose to use AI tools
+as assistants in their localization work. The use of AI is entirely optional.
+Many successful translation teams work effectively without it.
+
+
+### Human translators remain in control
+
+Translation of Git is a human-driven community effort. Language team leaders and
+contributors are responsible for:
+
+- Understanding the technical context of Git commands and messages
+- Making linguistic and cultural adaptation decisions for their target language
+- Maintaining translation quality and consistency within their language team
+- Ensuring translations follow Git l10n conventions and community standards
+- Building and maintaining language-specific glossaries
+- Reviewing and approving all changes before submission
+
+AI tools, if used, serve only to accelerate routine tasks. They do not make
+decisions, do not replace human judgment, and do not understand cultural
+nuances or community needs.
+
+
+### When AI assistance may be helpful
+
+AI tools can help speed up certain mechanical aspects of translation work:
+
+- Generating first-draft translations for new or updated messages
+- Identifying untranslated or fuzzy entries across large PO files
+- Checking consistency with existing translations and glossary terms
+- Detecting technical errors (missing placeholders, formatting issues)
+- Reviewing translations against quality criteria
+
+However, AI-generated output should always be treated as rough drafts requiring
+human review, editing, and approval by someone who understands both the
+technical context and the target language.
+
+
+### Preparing your translation environment for effective AI use
+
+If you choose to use AI assistance, investing time in preparation will
+significantly improve the quality of AI-generated suggestions:
+
+1. **Maintain a glossary**: Add a "Git glossary for XX translators" section in
+   the header comments of your `po/XX.po` file (before the first `msgid`). List
+   key Git terms with their approved translations. AI tools can read and follow
+   this glossary.
+
+2. **Keep translations up-to-date**: Regularly sync your `po/XX.po` with
+   upstream. AI learns from existing translations. The more complete and
+   consistent your PO file, the better AI suggestions will be.
+
+3. **Document style guidelines**: If your language team has specific formatting
+   or style preferences, document them in your `po/XX.po` header. AI can
+   incorporate these guidelines into its output.
+
+4. **Choose appropriate AI coding tools**: Evaluate and use models and tools
+   that work best for your target language. Different AI models have varying
+   levels of proficiency across languages. Test multiple tools to find which
+   produces the most natural and accurate translations for your language.
+
+
+### Technical guidelines for AI tools
+
+The following sections provide technical specifications for AI tools that
+assist with Git translation. These guidelines ensure AI-generated suggestions
+are technically correct and follow Git l10n conventions. Human translators
+should be familiar with these requirements to effectively review AI output.
+
+
+#### Scope and context
+
+- Primary files: `po/XX.po` for translations, `po/git.pot` for the source
+  template (generated on demand; see "Dynamically generated POT files").
+- Source language: English. Target language: derived from the language code in
+  the `po/XX.po` filename based on ISO 639 and ISO 3166.
+- Glossary: Git l10n teams may add glossary sections (e.g. "Git glossary for
+  Chinese translators") in the header comments of `po/XX.po` immediately before
+  the first `msgid` entry. If a glossary exists, read it and keep terminology
+  consistent.
+
+
+#### Quality checklist
+
+- Accuracy: faithfully conveys the original meaning; no omissions or distortions.
+- Terminology: uses correct, consistent terms per glossary or domain standards.
+- Grammar and fluency: grammatically correct and reads naturally.
+- Placeholders: preserves variables (e.g. `%s`, `{name}`, `$1`) exactly. If
+  reordering is needed for the target language, use positional parameters as
+  described below.
+- Plurals and gender: handles plural forms, gender, and agreement correctly.
+- Context fit: suitable for UI space, tone, and usage (e.g. error vs. tooltip).
+- Cultural appropriateness: avoids offensive or ambiguous content.
+- Consistency: matches prior translations of the same source string.
+- Technical integrity: do not translate code, paths, commands, brand names, or
+  proper nouns.
+- Readability: clear, concise, and user-friendly.
+
+
+#### Locating untranslated, fuzzy, and obsolete entries
+
+Use GNU gettext tools to parse PO structure reliably (safe for multi-line
+`msgid`/`msgstr`):
+
+- Untranslated entries:
+
+  ```shell
+  msgattrib --untranslated --no-obsolete po/XX.po
+  ```
+
+- Fuzzy entries:
+
+  ```shell
+  msgattrib --only-fuzzy --no-obsolete po/XX.po
+  ```
+
+- Obsolete entries (marked with `#~`):
+
+  ```shell
+  msgattrib --obsolete --no-wrap po/XX.po
+  ```
+
+If you only want the message IDs, you can pipe to:
+
+```shell
+msgattrib --untranslated --no-obsolete po/XX.po | sed -n '/^msgid /,/^$/p'
+```
+
+```shell
+msgattrib --only-fuzzy --no-obsolete po/XX.po | sed -n '/^msgid /,/^$/p'
+```
+
+
+#### Translation workflow (`po/XX.po`)
+
+When asked to update translations, follow the steps in this section in order
+and reference this section in your plan before making edits.
+
+- Generate `po/git.pot` from source code (see "Dynamically generated POT files").
+- Update `po/XX.po` with the new template.
+- Translate new entries identified by `msgattrib --untranslated` (see above).
+- Fix fuzzy entries identified by `msgattrib --only-fuzzy` (see above) by
+  re-translating and removing the `fuzzy` tag after updating `msgstr`.
+- For entries with `msgid_plural`, consult [Plural forms](#plural-forms) to
+  supply all required `msgstr[n]` forms based on the `Plural-Forms` header.
+- Apply the quality checklist to every translation.
+
+
+#### Review workflow
+
+Review workflow has two modes: direct review against local `po/XX.po`, and
+review based on a patch.
+
+##### Full file review
+
+- When explicitly asked to review all translated content, review `po/XX.po`
+  in chunks (see [Handling large inputs](#handling-large-inputs) for splitting).
+- Apply the quality checklist to each message you review.
+- Unless otherwise specified, update `po/XX.po` directly; if a summary is
+  requested, provide a consolidated report of the issues.
+
+
+##### Patch review
+
+- Review requests may come as patches of `po/XX.po`:
+  - Workspace changes: `git diff HEAD -- po/XX.po`
+  - Changes since a commit-ish: `git diff <commit-ish> -- po/XX.po`
+  - Changes in a specific commit: `git show <commit-ish> -- po/XX.po`
+- For large patches, follow the split guidance in
+  [Handling large inputs](#handling-large-inputs) when splitting.
+- When diff context is incomplete (truncated `msgid` or `msgstr`), use file
+  viewing tools to pull nearby context for accurate review.
+- Apply the same quality checklist as in full file reviews.
+- If the patch is based on workspace changes, update `po/XX.po` directly
+  unless a summary is requested.
+- If the patch is from a specific commit, report issues or apply fixes when
+  comparing against the current `po/XX.po` in the workspace.
+
+
+#### Handling large inputs
+
+When a `po/XX.po` file or a patch is too large for LLM context, split it into
+chunks while keeping `msgid` and `msgstr` pairs intact. This includes plural
+forms: `msgid`, `msgid_plural`, `msgstr[0]`, `msgstr[1]`, and any additional
+plural indices required by the language.
+
+For `po/XX.po`, split on the line immediately before each `msgid` entry. This
+guarantees no chunk begins with an unpaired `msgid`. Use
+`grep -n '^msgid' po/XX.po` to locate split points, and group the file into
+chunks of no more than 200 `msgid` entries (about 50K bytes each).
+
+For patch files, check the patch size first:
+
+- If the patch is <= 100KB, do not split.
+- If the patch is > 100KB, split it using the same rule as for `po/XX.po`:
+  split on the line immediately before each `msgid` entry so message pairs
+  stay together.
+
+
+#### Plural forms
+
+This section defines how translators should handle `msgid_plural` entries,
+including how many `msgstr[n]` forms are required and how to index them. It
+provides the canonical example and points to the `Plural-Forms` header for the
+language-specific rule set.
+
+For entries with `msgid_plural`, provide plural forms:
+
+```po
+msgid "..."
+msgid_plural "..."
+msgstr[0] "..."
+msgstr[1] "..."
+```
+
+Use `msgstr[0]`/`msgstr[1]` as required. If the language has more plural forms,
+follow the `Plural-Forms` header in `po/XX.po` to determine the required number
+of `msgstr[n]` entries.
+
+
+#### Placeholder reordering
+
+When a translation reorders placeholders, mark them with positional parameter
+syntax (`%n$`) so each argument maps to the correct source value. Keep the
+width/precision modifiers intact and place the position specifier before them.
+
+Example:
+
+```po
+msgid "missing environment variable '%s' for configuration '%.*s'"
+msgstr "配置 '%3$.*2$s' 缺少环境变量 '%1$s'"
+```
+
+Here the translation swaps the two placeholders. `%1$s` still refers to the
+first argument (`%s`), while `%3$.*2$s` refers to the third string argument
+with the precision taken from the second argument (`%.*s`).
+
+
+### Integrating AI tools into your workflow
+
+If you decide to use AI assistance, here's how to integrate it responsibly:
+
+
+#### For AI tool developers and users
+
+When building or configuring AI-assisted translation tools:
+
+- Use the quality checklist (above) to score or filter draft suggestions
+- Apply the `msgattrib` + `sed` commands to extract relevant entries for processing
+- Ensure AI tools read and respect glossary terms from the `po/XX.po` header
+- Configure tools to follow the technical workflows documented above
+
+
+#### Human oversight is mandatory
+
+**Never submit AI-generated translations without human review.** The human
+translator must:
+
+- Verify technical accuracy (correct placeholders, plural forms, formatting)
+- Ensure linguistic quality (natural phrasing, appropriate terminology)
+- Check cultural appropriateness for the target audience
+- Confirm consistency with the language team's established style
+- Take full responsibility for the final translation
+
+Example usage in prompts to AI assistants:
+
+- "Update translations in `po/XX.po` following the guidelines in @po/README.md"
+- "Review all translations in `po/XX.po` following the guidelines in @po/README.md"
+
+
+### Summary: AI as a tool, humans as translators
+
+AI can accelerate translation work, but it is not a substitute for human
+translators. The Git localization community values:
+
+- **Human expertise**: Deep understanding of Git's technical context and the
+  cultural nuances of each target language
+- **Community standards**: Consistency across releases and alignment with
+  language team conventions
+- **Accountability**: Human translators who stand behind their work and respond
+  to feedback from users
+
+If you choose to use AI tools, they should enhance these human contributions,
+not replace them. The best results come from combining AI efficiency with human
+judgment, cultural insight, and community engagement.
+
+
 [git-po-helper/README]: https://github.com/git-l10n/git-po-helper#readme
 [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
-- 
2.51.0.rc2

