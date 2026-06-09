Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D323F1ADD
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999923; cv=none; b=T94NSHTDQcO5mfObdFn3iwd0mJlS7bPPhTdz583RfCOO+Tg0ytUnInscCVwTOhSb49wSh0A/7FXz31GqFtC8jgpQzF0CO93euJQnyqSAldshzSrbpnd81r/BOAYmD9Xu9ASHXsK6e8l2KkJJpvRWOmsGv2kJqSGSMsoPwsDVpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999923; c=relaxed/simple;
	bh=hNOj2AeubmoTQLjaI2YcJ5Iu8QsWtU+Gq14XpZ9OMJU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rmN8F/soxd8zWtBoD13PL6rT1BJ9tFj3iwhUVwuZk0Ub94j81FxOX140TNUteDjYqaTErqtvVYulsbPe9tuHVFcjWaxC9SI8ViQoDEtnO+GjIL4uK8yXHfQNLPgMrWN7cj1HoaRF2OxdSd9NskPnb0CTq4WlnyoHP0+bs27JB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rtm0gb6q; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rtm0gb6q"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176ca6bab1so56877381cf.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999921; x=1781604721; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAag01b2HCmRLBr1+Q8SfxFiDhOLCHeUSQUS4QdMF9A=;
        b=Rtm0gb6qVZjaRMob2qEwphLzQY3CBOxY8yHjowl5EkqIQfAFFFDM54Z8mmjo9Mhx3z
         3fAN9Now7PP1YmGn1mTEEFo8cLllUyNnwda+mAYh6ceBcPPoJdOWbef6xef1zV79/HhP
         u22Q/ldoXl+pC9OE6iTL/qqEmXeBTV1WCUoHMMNC9G5nhCzptT6in+5MjbOqpTjCRerr
         OHBsVKJTEwb6d/7wr558UAwUWAdFkfjXk1sEhYVBK/JrugR19GrsMLWQGKCpwI6OKBxZ
         UBvft6GdZLC2/+YEHYO2ZZ3cXk5ntLdvv98aaG7vqFkJ9wSrXFVTD8zeKTRlLQEUo5d8
         FEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999921; x=1781604721;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RAag01b2HCmRLBr1+Q8SfxFiDhOLCHeUSQUS4QdMF9A=;
        b=A/bRDQ4XGlN+BU6YdyWIOWcUhNw8TDLZA+QNvhDgOEWbAMxZIIk6EXlzIteD3KsEV8
         J1PYwJCWl2B20yxlmA+d11+nK0+ArGXmQ4diPVtgDeh8MSzZlXi+h7HkRBdNNT1N56A5
         xl7KUHtpX0j8/DqvafRq9ttsWciHsLte6u/Gc9C6kLyqtierzRpuMl9WSa8la1fgrrqK
         B6nFtzm+quNbLSaoH2csXbNnPXrCWIztTFM3JY7+hYO0VV6YsiBOf+cwFNi+r5iOJ382
         nkKa9F55U/Yz9giHCfq0C2MVGvrRilBhDvdMxfQDrDM0uqpkS2oeqT/0z4BAfbfyfz7B
         x6Gg==
X-Gm-Message-State: AOJu0YzDKptIm68qqT1qc0eQelL76MO7ZJ2uqRXy031qys9ELCDIBLyp
	KodpwqsTDCgFTGBeX0wQ9UL1uz4ODB1M3VhSjoVOnErAzY/vqCqwBEwXCdnqfj7D
X-Gm-Gg: Acq92OHpW/OGA7uIeqDEsBQdcdlEUyB0zDTiIkuMhVi9kuW0ye2y8vbOK6YD3XmJfJC
	1ByIYcj3Firv1wJAfrdNXEz1LDBfHvF0hqiQlGYsYxO7L4DFoEvh0OAebLostRFJ6rVtyixlw5F
	HlM2OENp7Lu/gp5G9vDdzMnACILBMbtLBNpuwJk81x04vOeoc1/zObe+ILeD0Ol6cve6VWE8lGT
	nfzNSqNHbijxHBw3Li65HGS+XHKntJbtSLWGD0FDyggCbUL/F81h9JYKxJoF8wFF+KoCxqrZRbG
	ND5B1X1c52D/GcS6FtrQ+Xav+8N9UKQTdgjbYNbkUNq5R7cXxQ6mLsjjuCIV6IWt265VE+C2QW1
	k9xUZA8Nyla6F1tft9kv9LE57dZmz0bP0nOlY4YNttEy3jQd6qN/98Bu12ORBYNgfL+henSG1G7
	1XYdEghoZssYvmOowSMctvWJUiZon99mzxIQ==
X-Received: by 2002:a05:622a:11ca:b0:50e:600a:638c with SMTP id d75a77b69052e-517987a919amr197152651cf.17.1780999921318;
        Tue, 09 Jun 2026 03:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.9.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775d8161csm185606731cf.17.2026.06.09.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:12:00 -0700 (PDT)
Message-Id: <259113e304c4085c2bd90cce3a40c965744d5a00.1780999917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jun 2026 10:11:54 +0000
Subject: [PATCH v14 3/6] branch: prepare delete_branches for a bulk caller
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Teach delete_branches() two new modes for the upcoming
--prune-merged: one that asks only whether a branch is merged into
its upstream, without falling back to HEAD when there is no
upstream, and one that rehearses the deletions without removing any
ref. Existing callers keep their current behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4fb012c7a4..2cc5a8cde0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -168,10 +168,13 @@ static int branch_merged(int kind, const char *name,
 	 * upstream, if any, otherwise with HEAD", we should just
 	 * return the result of the repo_in_merge_bases() above without
 	 * any of the following code, but during the transition period,
-	 * a gentle reminder is in order.
+	 * a gentle reminder is in order.  Callers that opt out of the
+	 * HEAD fallback by passing head_rev=NULL are not interested in
+	 * the reminder either: they have already established that the
+	 * branch has an upstream, so HEAD is irrelevant to the decision.
 	 */
-	if (head_rev != reference_rev) {
-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+	if (head_rev && head_rev != reference_rev) {
+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
 		if (expect < 0)
 			exit(128);
 		if (expect == merged)
@@ -193,6 +196,8 @@ enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_WARN_ONLY = (1 << 2),
+	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
+	DELETE_BRANCH_DRY_RUN = (1 << 4),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -240,7 +245,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	int i;
 	int ret = 0;
 	int remote_branch = 0;
-	int force, quiet;
+	int force, quiet, dry_run, no_head_fallback;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -268,8 +273,10 @@ static int delete_branches(int argc, const char **argv, int kinds,
 
 	force = flags & DELETE_BRANCH_FORCE;
 	quiet = flags & DELETE_BRANCH_QUIET;
+	dry_run = flags & DELETE_BRANCH_DRY_RUN;
+	no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
 
-	if (!force)
+	if (!force && !no_head_fallback)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
@@ -340,13 +347,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(target);
 	}
 
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (!dry_run &&
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
+		if (dry_run) {
+			if (!quiet)
+				printf(remote_branch
+					? _("Would delete remote-tracking branch %s (was %s).\n")
+					: _("Would delete branch %s (was %s).\n"),
+					name + branch_name_pos, describe_ref);
+		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
 			if (!quiet)
 				printf(remote_branch
-- 
gitgitgadget

