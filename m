Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D91C3DA7A
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 14:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiLaONq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 09:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLaONl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 09:13:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7457B841
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:13:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bn26so3035400wrb.0
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY6zT+iNRAgRXAmF6hXSlCkCYx0v2MoRNOw1eZ3gglY=;
        b=XywCGoANNVhZJXpSr/eu3cI1+8l33KRep2yxktG8s9tQKD1FxtiOEB9Kd9VAvO9IKY
         9vR2JuzN8oSxjtdScxRg6nP+6HoIvfnX28D45xvM+1kE0urloKQgC4+nuay6dq7G+guJ
         vHaNDnCq8K2PQ+nlXD7ZLrVKpMPyGzD5/e25QlPOPW3cq++B+BNE2pvEgZDxYmbjRvjk
         MPlLtXAYE9nPJ8eQN/2G3bLbuVYnygkYxGRKdAHz5zh5HUke0uf4BT4PNxp3H1wCFj+9
         ts0mWbBBDuQc00wYCM/Ix5vwOpxxR5t3f3fDkjD+ZoCeOirhJh+nbCyYa1fjmvPMJqwe
         gX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WY6zT+iNRAgRXAmF6hXSlCkCYx0v2MoRNOw1eZ3gglY=;
        b=hPSaZu1MkRcesKTInTQ9qQXBjrLEDshUOH0PAC8YnlbvtISDykCJBwkxNZYBuWqSMU
         tKZbvb8a9gtLtIXdBY5nHUi34+L2Xk7GvdnXcciXOVyKKCnPa/xfXC/flcEsRbTKTxZB
         U2RiHJTHprP9x+IjP6LJEScqMZZp21sccbn1G/CxPICP5QaJN0Rk2ApKw7Wodmti+H1g
         NjX0QMWrjdGMDv8BKJL7EsuQOn3jaLwoGbk9Ldioq7g4kcW2gTo/XWA/RNNZ2/gXNDJ5
         GHfgitzn2pRmEqqiul9UAjNmvtD6bdXSJH9dwHOI31VzGUkU/cYtBsKCC6wio66peNEW
         KFSg==
X-Gm-Message-State: AFqh2kor7BE80+hd5VuYu+/8+IxM51lQh0UatKvMvJJLGs0CoGyXh1Pk
        a9Q667uAEJNV248PXbwmrU0=
X-Google-Smtp-Source: AMrXdXt0a6VNuMcF5X+rfjAK9qCPJM3VTUL1zY/E2QYczZFzdRiwVNDNfLRu5diwXn6MmVSn5vxGlg==
X-Received: by 2002:a5d:6545:0:b0:27f:4a7e:fc47 with SMTP id z5-20020a5d6545000000b0027f4a7efc47mr11800095wrv.67.1672496018119;
        Sat, 31 Dec 2022 06:13:38 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d4fca000000b00281eab50380sm15473205wrw.117.2022.12.31.06.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 06:13:37 -0800 (PST)
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] get_oid_basic: detached HEAD and @{-1}
Message-ID: <c18c0328-9292-aa02-2922-f139e578ac07@gmail.com>
Date:   Sat, 31 Dec 2022 15:13:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We discourage the use of branch names that resemble commit ids; but
for convenience not as a limitation:

	$ git commit --allow-empty -m first
	[... 000001] first
	$ oid=$(git rev-parse HEAD)
	$ git commit --allow-empty -m second
	[... 000002] second
	$ git checkout -b $oid
	Switched to a new branch '000001...'

With this usage, removing that risky-named branch and trying to re-use
the branch name again, the result expected is an error but:

	$ git checkout -
	$ git branch -d $oid
	Deleted branch 000001... (was 000002).
	$ git checkout $oid
	... You are in 'detached HEAD' state...
	HEAD is now at 000001...

With @{-1} shortcuts the result is the same, but here we can do better
and give an error as a result:  from the reflog we know @{-1} refers
to a branch named '000001...' which pointed to commit '000002...'.

Let's use this unused-yet information to avoid the ambiguity in the
result.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 object-name.c                         | 20 ++++++++++++++------
 t/t3204-branch-name-interpretation.sh | 10 ++++++++++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 2dd1a0f56e..3fae19de2f 100644
--- a/object-name.c
+++ b/object-name.c
@@ -878,7 +878,8 @@ static inline int push_mark(const char *string, int len)
 }
 
 static enum get_oid_result get_oid_1(struct repository *r, const char *name, int len, struct object_id *oid, unsigned lookup_flags);
-static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
+static int interpret_nth_prior_checkout(struct repository *r, const char *name,
+		int namelen, struct strbuf *buf, struct object_id *ooid);
 
 static int get_oid_basic(struct repository *r, const char *str, int len,
 			 struct object_id *oid, unsigned int flags)
@@ -940,10 +941,12 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 
 	if (nth_prior) {
 		struct strbuf buf = STRBUF_INIT;
+		struct object_id ooid;
 		int detached;
 
-		if (interpret_nth_prior_checkout(r, str, len, &buf) > 0) {
-			detached = (buf.len == r->hash_algo->hexsz && !get_oid_hex(buf.buf, oid));
+		if (interpret_nth_prior_checkout(r, str, len, &buf, &ooid) > 0) {
+			detached = (buf.len == r->hash_algo->hexsz &&
+				!get_oid_hex(buf.buf, oid)) && !oidcmp(oid, &ooid);
 			strbuf_release(&buf);
 			if (detached)
 				return 0;
@@ -1383,9 +1386,10 @@ static int get_oid_oneline(struct repository *r,
 struct grab_nth_branch_switch_cbdata {
 	int remaining;
 	struct strbuf *sb;
+	struct object_id *ooid;
 };
 
-static int grab_nth_branch_switch(struct object_id *ooid UNUSED,
+static int grab_nth_branch_switch(struct object_id *ooid,
 				  struct object_id *noid UNUSED,
 				  const char *email UNUSED,
 				  timestamp_t timestamp UNUSED,
@@ -1405,6 +1409,8 @@ static int grab_nth_branch_switch(struct object_id *ooid UNUSED,
 		len = target - match;
 		strbuf_reset(cb->sb);
 		strbuf_add(cb->sb, match, len);
+		if (cb->ooid)
+			oidcpy(cb->ooid, ooid);
 		return 1; /* we are done */
 	}
 	return 0;
@@ -1416,7 +1422,8 @@ static int grab_nth_branch_switch(struct object_id *ooid UNUSED,
  */
 static int interpret_nth_prior_checkout(struct repository *r,
 					const char *name, int namelen,
-					struct strbuf *buf)
+					struct strbuf *buf,
+					struct object_id *ooid)
 {
 	long nth;
 	int retval;
@@ -1438,6 +1445,7 @@ static int interpret_nth_prior_checkout(struct repository *r,
 		return -1;
 	cb.remaining = nth;
 	cb.sb = buf;
+	cb.ooid = ooid;
 
 	retval = refs_for_each_reflog_ent_reverse(get_main_ref_store(r),
 			"HEAD", grab_nth_branch_switch, &cb);
@@ -1621,7 +1629,7 @@ int repo_interpret_branch_name(struct repository *r,
 		namelen = strlen(name);
 
 	if (!options->allowed || (options->allowed & INTERPRET_BRANCH_LOCAL)) {
-		len = interpret_nth_prior_checkout(r, name, namelen, buf);
+		len = interpret_nth_prior_checkout(r, name, namelen, buf, NULL);
 		if (!len) {
 			return len; /* syntax Ok, not enough switches */
 		} else if (len > 0) {
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 3399344f25..5839884ae4 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -167,4 +167,14 @@ test_expect_success 'modify branch upstream via "@{-1}" and "@{-1}@{upstream}"'
 	test_must_fail git config branch.upstream-other.merge
 '
 
+test_expect_success '@{-1} might look erroneously like a detached HEAD' '
+	oid=$(git rev-parse HEAD) &&
+	git checkout -b $oid &&
+	test_commit new-oid &&
+	git checkout - &&
+	git branch -D $oid &&
+	test_must_fail git checkout @{-1} &&
+	test_must_fail git rev-parse @{-1}
+'
+
 test_done
-- 
2.39.0

