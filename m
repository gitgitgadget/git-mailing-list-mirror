Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FEC1D6DA9
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798016; cv=none; b=e4Ogij74hqX00cf7Mrl4W/3RqpP6RQXzImYSJdJN1TCdMteFDLoS49vZ7C2Lf2UPDc8MbzAxYLUHaJm0hedWYR2bGtbmZNIqk1R6EGzbe5jlL+CYtPqjyDL5wC/jPzJeAV6DNKVHBrUQybngyLauXYPisAaVw9Gfg2JGd83MvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798016; c=relaxed/simple;
	bh=4/rErBHkwdc/nIpVK/9rhLBrzMLP2HSwS1bJnNzjkiQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPEdJXVJPSG2Owvu5VEnX8w080tn3GGSgNaqNtU7byOrlP19SGBPsmA5JteXyi7Aw6cXxaWMKwIJe0Fo54xKt9KLjWM7dxYqBgS8Sdrdg6d7peFiS/JWoWJGeJu/5pgKefPKciT0HQTZ/MZ8B8N9elX1ieIdub/P4lQDB9PhMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=juaRn4sh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IraVIA8x; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="juaRn4sh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IraVIA8x"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BB40DEC00FD;
	Sat, 11 Jul 2026 15:26:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 11 Jul 2026 15:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783798013; x=
	1783884413; bh=3Km0qtblK/iVoXbF52YHSZk7xoqIJ6aU8AWmQKsc3Fo=; b=j
	uaRn4shTe7OzIZqvhO1bSoL3MUAlNroJK8zULPN41FhlBhnCJznI0NOHwDkffQNd
	w5OezUlXsRDVx5754IFtFeAvVEQ5cvNDM/IFdfacH50rakPwvtDKHFkJUnwVgPL0
	yv5medGINOzvvmXYCrqME8227+/0/XMLnQm1IUYoiLTb0qoNWlPnGc024fVKRDfd
	LRglDyPZohnOhOydgQTVouOpyUxUXZaMv+d0cCNE9dA2APQZtCn5KSgA+ZzhKpxB
	olx5jeaGPOhumDtB8q7ojrnRSxXB+/4M6AW2W10zxUko/oHZS88abeL381c56dcX
	t4VWwBh3e7DUrYXrxRTRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783798013; x=1783884413; bh=3Km0qtblK/iVoXbF52YHSZk7xoqI
	J6aU8AWmQKsc3Fo=; b=IraVIA8xJlovtQg2Wis5/CtwOXj795ZcUeG2DgVwMllJ
	TGxa32b5p8LJKO0ZSsAiYq9JMO6OzaO/VC0Kib4aJxHcGC2bomWbNf8SbkAuRtJT
	SG85RgkrIOytAZiDMLmQF2l0vnR2iU4EjzhcDeSNUo7UASxyPFaDttSfdk0W7LMr
	Y4Cgf7A24vKYIKwd6yEAaJaf1O6+B8pH43ePxMe6Cr47LCKkt3s1hOJXvRkbRa+M
	FM8Zr7d6ifDZ5ck5VI5hQFDRCCvRZgbk+XIw1nvoyp2E/BEaRNI1O/BAYU3iLeDW
	UyoSXDcqa8qjG2u7Z2riHfY/SVmlPZOiELOn30yFNQ==
X-ME-Sender: <xms:_ZhSatFFdQ8Jc3BrZDAsnT7MsipsICkzgLp6ZjObDKXbrieeFVhUuQ>
    <xme:_ZhSaoUf6GTp3jx7VSQruGT5OwyFLqiAsLCkNfQ4vkMi6gJp-kK0dcnmVqEhOSDYL
    90_0XtD_9PV2SCwr6v6ApxPB_E-vjhLmbo9b0su3zUYX5hwMGN3yw>
X-ME-Received: <xmr:_ZhSaszfCxyNCS8fhSgkqdr7wbz_cP79LyY5tywyZ3IyvMPAU7LdhcsIlGEN0SHrtnpbuur_6SUt_cF9HSynQtt_GyAy0LdhEv70MWc>
X-ME-Proxy-Cause: dmFkZTFJqDDiLOtZNK9IvspcieMba+1eLNTx4J7Cw7UAxOT6+ouPyrq6BGv8CmHUd2yp1c
    3LMnbIMYWc/oetxfu+mKHTLz17Exy8hCJVcRjfraJGA6VV5ICpS2oZCzWdS24PVZ+aLY30
    MyWDLG0gm/JKg0jlleOwkLmuavqw28VyOz2mUZP3kBlXWWbiFNtEgxOTnhjArRJLn4v9Wj
    kHHNDOhwlLq9Ne68NTTJxEAZclo3E+temZV1Dtje6ypm11Jz6233+i5EmhGrzCZCODkNrq
    f85z6kei2FP7RRJRW4N9tS+iJtQgbwn8ErEA7bx+HSh0jiSqZlcbsxbC3vQz5oeokJ9gZS
    0QXtY+un5OiM9IxnmeQQ37JGHSPoIMcZ+czjWjAHwjyf4EzUC0bpeTp0VklQ1pqsYxSMCY
    pJ92ED6IUlmz1AGvEpaSeuXTq38izTHIbsG7ajNs/eXzQCTQjYG2t+kecCrWBFkQHhHbn1
    C7Wm/AfTsh1VOb4ru87G81UFGnKBg0EIHSqZ6Hsg7PtTIDs7uwsgjANRwggOzl7cBQDjNd
    JRAQ2iveQZBq58td/vOUD/uoNtTjFvoMTWt7QLNFakrI6PEXGK40XPbSbPm7t+T8Pye9YD
    mZNvJMH8jTUTd/O3Jnto4IcrIZRC+HHOT1HKYT3Lsxi4S2CKI7LAQRkSCEhQ
X-ME-Proxy: <xmx:_ZhSauPaCfzTKugBdb3u45Lb9AphsrExFvD29nVuNove9RSnr6lQcQ>
    <xmx:_ZhSal6i5LfQNhiIEeHKjlcsJbX-ObHBhTj2rhGNDwDb8f-bGzE1dw>
    <xmx:_ZhSanOBeYbty8_vhlRw9dzokaeyjH3ClvcaDcpbhrEX4DTeo5AZSQ>
    <xmx:_ZhSarkioleBAxknVsc3MX9RSVytO-sArpitq5umYiA-om2-6bpYGA>
    <xmx:_ZhSaoeQXib8aBbiGt8xIek-o1-ihxjOAjLs0lhgEjggByr2Mcjh0RF->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 15:26:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/6] SubmittingPatches: clarify expected structure of commit log message
Date: Sat, 11 Jul 2026 12:26:45 -0700
Message-ID: <20260711192650.2417665-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-391-gdf86bf5712
In-Reply-To: <20260711192650.2417665-1-gitster@pobox.com>
References: <20260711192650.2417665-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current text on log message has lots of justification and
rationale before telling contributors what exactly is expected of
them.

Simplify the rationale section and jump straight to what to write
and how.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 140 +++++++++++++++-----------------
 1 file changed, 65 insertions(+), 75 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d2d82eb543..12f9660cef 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -289,86 +289,76 @@ run `git diff --check` on your changes before you commit.
 
 The log message that explains your changes is just as important as the
 changes themselves.  Your code may be clearly written with in-code
-comment to sufficiently explain how it works with the surrounding
-code, but those who need to fix or enhance your code in the future
-will need to know _why_ your code does what it does, for a few
-reasons:
-
-. Your code may be doing something differently from what you wanted it
-  to do.  Writing down what you actually wanted to achieve will help
-  them fix your code and make it do what it should have been doing
-  (also, you often discover your own bugs yourself, while writing the
-  log message to summarize the thought behind it).
-
-. Your code may be doing things that were only necessary for your
-  immediate needs (e.g. "do X to directories" without implementing or
-  even designing what is to be done on files).  Writing down why you
-  excluded what the code does not do will help guide future developers.
-  Writing down "we do X to directories, because directories have
-  characteristic Y" would help them infer "oh, files also have the same
-  characteristic Y, so perhaps doing X to them would also make sense?".
-  Saying "we don't do the same X to files, because ..." will help them
-  decide if the reasoning is sound (in which case they do not waste
-  time extending your code to cover files), or reason differently (in
-  which case, they can explain why they extend your code to cover
-  files, too).
-
-The goal of your log message is to convey the _why_ behind your change
-to help future developers.  The reviewers will also make sure that
-your proposed log message will serve this purpose well.
-
-The first line of the commit message should be a short description (50
-characters is the soft limit, see DISCUSSION in linkgit:git-commit[1]),
-and should skip the full stop.  It is also conventional in most cases to
-prefix the first line with "area: " where the area is a filename or
-identifier for the general area of the code being modified, e.g.
-
-* doc: clarify distinction between sign-off and pgp-signing
-* githooks.txt: improve the intro section
-
-If in doubt which identifier to use, run `git log --no-merges` on the
-files you are modifying to see the current conventions.
-
-[[summary-section]]
-The title sentence after the "area:" prefix omits the full stop at the
-end, and its first word is not capitalized (the omission
-of capitalization applies only to the word after the "area:"
-prefix of the title) unless there is a reason to
-capitalize it other than because it is the first word in the sentence.
-E.g. "doc: clarify...", not "doc: Clarify...", or "githooks.txt:
-improve...", not "githooks.txt: Improve...".  But "refs: HEAD is also
-treated as a ref" is correct, as we spell `HEAD` in all caps even when
-it appears in the middle of a sentence.
+comments, but future developers need to know *why* your code does what
+it does.  The goal of your log message is to convey the intent and
+rationales behind your changes.
 
-[[meaningful-message]]
-The body should provide a meaningful commit message, which:
-
-. explains the problem the change tries to solve, i.e. what is wrong
-  with the current code without the change.
+Reviewers will evaluate your commit message for clarity and structure.
+A well-structured commit message typically follows a three-part flow:
+**Observation**, **Solution**, and **Command**.
 
-. justifies the way the change solves the problem, i.e. why the
-  result with the change is better.
-
-. alternate solutions considered but discarded, if any.
+[[meaningful-message]]
+==== Structure of a Commit Message
 
-. records the resolution of design or viability concerns raised by the
-  community during the review, if any, ensuring the historical record
-  explains why the chosen approach was accepted over alternatives.
+0. **Title**:
+   The first line of the commit log message is the title that lets
+   readers of `git log --oneline` quickly understand what area the
+   commit touches and what problem it addresses.
 
+1. **Observation (The Status Quo)**:
+   Explain the problem you are trying to solve.  Describe what is
+   wrong with the current code *without* your change.
++
 [[present-tense]]
-The problem statement that describes the status quo is written in the
-present tense.  Write "The code does X when it is given input Y",
-instead of "The code used to do Y when given input X".  You do not
-have to say "Currently"---the status quo in the problem statement is
-about the code _without_ your change, by project convention.
-
-[[imperative-mood]]
-Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
-instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
-to do frotz", as if you are giving orders to the codebase to change
-its behavior.  Try to make sure your explanation can be understood
-without external resources. Instead of giving a URL to a mailing list
-archive, summarize the relevant points of the discussion.
+Write this problem statement in the **present tense** (e.g., "The
+code does X when given input Y", not "The code used to do Y").  The
+status quo in the problem statement is always about the code without
+your change, by project convention.  Do not use words like
+"Currently" to describe this state.
+
+2. **Solution (The Approach)**:
+   Justify the way your change solves the problem.  Explain why the
+   proposed approach is better and mention any alternate solutions
+   considered and discarded.
++
+If your change only addresses a subset of a larger problem (e.g.,
+handles directories but not files because of characteristic Y),
+explain this limitation.  This helps future developers understand the
+boundaries of your work and whether it can be safely extended.
++
+If the change resolves design or viability concerns raised by the
+community during prior review rounds, ensure the message records the
+resolution, explaining why the chosen approach was accepted over
+alternatives.
+
+3. **Command (The Instruction)**:
+   [[imperative-mood]]
+   Command the codebase to change.  Write this in the **imperative
+   mood** (e.g., "make xyzzy do frotz" instead of "This patch makes
+   xyzzy do..." or "I changed xyzzy..."), as if you are giving orders
+   to the codebase to change its behavior.
+
+#### Formatting and Style Guidelines
+
+* **The Subject Line (First Line)**:
+  * Keep it short (50 characters is the soft limit).
+  * Skip the full stop at the end.
+  * Prefix the subject with the modified area followed by a colon
+    and a space (e.g., "area: subject").  The area is typically a
+    filename or identifier (e.g., `doc:`, `transport:`, `t5601:`).
+    Run `git log --no-merges` on target files to see conventions.
+  * [[summary-section]]
+    Do not capitalize the first word after the "area:" prefix unless
+    there is a specific reason (e.g., `HEAD` is always in caps).
+    E.g., use "doc: clarify...", not "doc: Clarify...".
+
+* **The Body**:
+  * Explain the *why* rather than repeating the *what* of the diff.
+  * Try to make the explanation self-contained.  Avoid relying on
+    external URLs (like mailing list archives) as the sole
+    explanation; summarize the relevant points of the discussion
+    instead.
+  * Wrap lines to 68-72 columns.
 
 [[commit-reference]]
 
-- 
2.55.0-391-gdf86bf5712

