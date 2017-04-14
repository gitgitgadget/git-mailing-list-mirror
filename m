Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5F92013A
	for <e@80x24.org>; Fri, 14 Apr 2017 22:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbdDNW5X (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 18:57:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32793 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdDNW5W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 18:57:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so607598wmb.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 15:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=36+yg10oe7LuTQt77hei8GQWAlskbPgmSvzAigNsQwQ=;
        b=I1TZD0ktyEOAkuz3L5mG+PkbzxQtn82+gMVY2InvIJqQ8/7wfFVm3XYIvZsips3mhU
         ttYjo49bdQ9R+yPSmjwAqxwvesnFtPkC0cVWvcTZ0FHd6W7OqRkZRDwgYLzXhvybNbtz
         YIDQDV6YPz79zTBmvNx0HeSSAoneqUT1QGy0pnhZ6eKd3t67ItorSR8+wM1Hk2TDpQJm
         AmYuh8oJBRvGBroKVICOD/7cdMvTy2FLjPxcV+X9lmeTHvUK4gTrkSk6ohB3/MssPYzF
         CBbKIDDs8WJ4K+Rn1ZqW/3W4i6cHk2AiThV59QC6dMcMBkPHmnPQhVW+AdvkCf/Ve4i/
         LhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=36+yg10oe7LuTQt77hei8GQWAlskbPgmSvzAigNsQwQ=;
        b=Dpeyspviy6JOcfjJmX3uFasEmohF5xyWhD7vVRfQz3NfaxKShqDPVSQR2/oucPgnbG
         mHs7PZdienE5Gbjx/ifFNSe22npVLFrbZaoBsQXtHU2rZD7OMGRLTooUB8VLuKY4gHha
         Be5t4rdRmdvYWPd7f3hcq0GOC24iaikBdHIkJT0sGkQNM03ZIvCOAZEHMW0z7UV5A1qe
         SHT4noX25pqKHvHyDDCE6/8n8XwxgXtGdS6wwn7lUUglePefvz2GZ22hX92rh51N7YIU
         LVpAmdqB7rfbXYDCb8vtIjkxizpiKQm6JniLtRzLiE4OTZB++aaNkgdh861T/BQFnQzU
         /OkQ==
X-Gm-Message-State: AN3rC/4KUnCkK1tL4rDV1xqZf1icGeobbsmsxVr4wpCyiIOtlwX8OaNU
        if75Yphf9gdrHA==
X-Received: by 10.28.184.73 with SMTP id i70mr520948wmf.104.1492210640699;
        Fri, 14 Apr 2017 15:57:20 -0700 (PDT)
Received: from localhost ([151.54.23.249])
        by smtp.gmail.com with ESMTPSA id o123sm258862wmg.16.2017.04.14.15.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Apr 2017 15:57:19 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3] rebase: pass --[no-]signoff option to git am
Date:   Sat, 15 Apr 2017 00:57:13 +0200
Message-Id: <20170414225713.29710-1-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.765.g845dc5dc05
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easy to sign off a whole patchset before submission.

To make things work, we also fix a design issue in git-am that made it
ignore the signoff option during rebase (specifically, signoff was
handled in parse_mail(), but not in parse_mail_rebasing()).

This is trivially fixed by moving the conditional addition of the
signoff from parse_mail() to the caller (am_run()), after either of the
parse_mail*() functions were called.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-rebase.txt | 5 +++++
 builtin/am.c                 | 6 +++---
 git-rebase.sh                | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

As suggested by Ævar, it's [no-]signoff, not [no]-signoff.

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 67d48e6883..e6f0b93337 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -385,6 +385,11 @@ have the long commit hash prepended to the format.
 	Recreate merge commits instead of flattening the history by replaying
 	commits a merge commit introduces. Merge conflict resolutions or manual
 	amendments to merge commits are not preserved.
+
+--signoff::
+	This flag is passed to 'git am' to sign off all the rebased
+	commits (see linkgit:git-am[1]).
+
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
diff --git a/builtin/am.c b/builtin/am.c
index f7a7a971fb..d072027b5a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1321,9 +1321,6 @@ static int parse_mail(struct am_state *state, const char *mail)
 	strbuf_addbuf(&msg, &mi.log_message);
 	strbuf_stripspace(&msg, 0);
 
-	if (state->signoff)
-		am_signoff(&msg);
-
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
 
@@ -1848,6 +1845,9 @@ static void am_run(struct am_state *state, int resume)
 			if (skip)
 				goto next; /* mail should be skipped */
 
+			if (state->signoff)
+				am_append_signoff(state);
+
 			write_author_script(state);
 			write_commit_msg(state);
 		}
diff --git a/git-rebase.sh b/git-rebase.sh
index 48d7c5ded4..cce72d8494 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -34,6 +34,7 @@ root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -i
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
+[no-]signoff!      passed to 'git am'
 whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
@@ -321,7 +322,7 @@ do
 	--ignore-whitespace)
 		git_am_opt="$git_am_opt $1"
 		;;
-	--committer-date-is-author-date|--ignore-date)
+	--committer-date-is-author-date|--ignore-date|--signoff|--no-signoff)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
-- 
2.12.2.765.g845dc5dc05

