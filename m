Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22C31F404
	for <e@80x24.org>; Sat, 31 Mar 2018 15:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeCaPOy (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 11:14:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52311 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeCaPOs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 11:14:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id l9so19376415wmh.2
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Czs/h7u24zuC6pZyUf2SpBQ9RUYVgjgoBf+0nCaMcBo=;
        b=fq8eSl0D7fzXiDjMUwEGnCnqWH+4MHOO5Lt1LXFUmxNPhl0PLafA6+MjjNF0AKAxyU
         ZwL2e567qmslceAjh7QjdvxbJw+pQvG/Er0yuP9xd6IukxXKZimPqhCD2GEEejLo/7ib
         HI028FP07LdwaNrlZiVOT6rArQ8wtjc44PqwfhNs61vbV22sPvRL5F+MIqZnUWaBsPnX
         tEkzY3f995KMfZyYcNgX44DBVmAPKhKzDaANG+whUkT/rW+UpQEdiauBckFJbMXpsyQv
         3BcH0/yNUToV9WXbDV10KDP9rmHS98uYaCzYK6voLhBhbPfuqLMVXXtLslqOVfqgr8qp
         fDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Czs/h7u24zuC6pZyUf2SpBQ9RUYVgjgoBf+0nCaMcBo=;
        b=f4ZBSkWlorvBWFiA+7zjtn1nZmJeadGkp+6rYwJm/ZiNugUW0wDe+ln6nFaZpefs/i
         GPuhBxrVkKUsQsfC+Ex1vdLolNah09DkZg7H9ci02Zk1FflthSMTuSCUrK1bFXIYh/oR
         bhWEqMjHmJ+Hc3+1TtJPK1GIQ0nOOicPtjO2eUOUaofr9GIqNuv0ZC35goWbfgVPUnjv
         xfk86rLiM6IwcDCk51EwLW/IWsYoDWc4Dd51X/yNIPMJq3FNSTeIIR87BGoEbB3NVy+Y
         Ioa3eK1NUzv7y4Kxd6b/H59JI55ClSRzs/y8rwsw2mTrxHN5aao8o34fL3wujqGeyG49
         YvMw==
X-Gm-Message-State: ALQs6tC4DPopyhkE1jP1wLuMMhJqjSdVd6wn0d0yPaOzWAVjaPVQYi5P
        Dmz42qQ2DC4VHETfGSewaeabbiqX
X-Google-Smtp-Source: AIpwx4+1mVpelmyLkBpudTpds3Ta49yDFaOCKvygqP4gCKQkQnMblZilBpUEISEejfx62rkvCtUvog==
X-Received: by 10.28.230.148 with SMTP id e20mr3821515wmi.89.1522509287049;
        Sat, 31 Mar 2018 08:14:47 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id x10sm10842497wrc.64.2018.03.31.08.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 08:14:46 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 2/6] reset: introduce show-new-head-line option
Date:   Sat, 31 Mar 2018 16:18:00 +0100
Message-Id: <20180331151804.30380-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.78.ga2082135d8
In-Reply-To: <20180331151804.30380-1-t.gummerer@gmail.com>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new --show-new-head-line command line option, that
determines whether the "HEAD is now at ..." message is printed or not.
It is enabled by default to preserve the current behaviour.

It will be used in a subsequent commit to disable printing the "HEAD is
now at ..." line in 'git worktree add', so it can be replaced with a
custom one, that explains the behaviour better.

We cannot just pass the --quite flag from 'git worktree add', as that
would also hide progress output when checking out large working trees,
which is undesirable.

As this option is only for internal use, which we probably don't want
to advertise to our users, at least until there's a need for it, make
it a hidden flag.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/reset.c  | 5 ++++-
 t/t7102-reset.sh | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index e15f595799..54b2576449 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -288,6 +288,7 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int show_new_head_line = 1;
 	int patch_mode = 0, unborn;
 	const char *rev;
 	struct object_id oid;
@@ -310,6 +311,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
+		OPT_HIDDEN_BOOL(0, "show-new-head-line", &show_new_head_line, N_("show information on the new HEAD")),
 		OPT_END()
 	};
 
@@ -403,7 +405,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		 * switched to, saving the previous head in ORIG_HEAD before. */
 		update_ref_status = reset_refs(rev, &oid);
 
-		if (reset_type == HARD && !update_ref_status && !quiet)
+		if (reset_type == HARD && !update_ref_status && !quiet &&
+		    show_new_head_line)
 			print_new_head_line(lookup_commit_reference(&oid));
 	}
 	if (!pathspec.nr)
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 95653a08ca..a160f78aba 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,9 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reset --no-show-new-head-line suppresses "HEAD is now at" output' '
+	git reset --hard --no-show-new-head-line HEAD >actual &&
+	! grep "HEAD is now at" <actual
+'
+
 test_done
-- 
2.16.1.78.ga2082135d8

