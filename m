Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F9820437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932182AbdJaVTF (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:19:05 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:54701 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbdJaVTB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:19:01 -0400
Received: by mail-io0-f193.google.com with SMTP id e89so1864435ioi.11
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EI/4dmcppN42J3wIYQ5qmDIDXB89WuNctT9orOaERV0=;
        b=nE7ROfP6LDq3i/4OFU4O9mFrB/vPIhgUNepr2LxdpPyUr6MA16cO2h5iBsA+NbtUf/
         bCoqYkmb6Ic3PP/QCBPX721ftf7UAX60r/LvzvAa35P3l9w0zF7R7E55qeQBTfJm/TPU
         TYepfVtJfozuqMGLUdE/Tt+M5pwS5p78ueULtBgviMfo7sOdO2Bj1qVMCYMSg/2F0AMa
         4CB1/FM99GkslGXQcPny9QaJHOr97Cnz0mWE1JSI1JyqCghJOkwBJojpolXXzhmVaKy5
         1pKtlc7PXglypF/Sd8vm7AC0Z3M+0AtG7fuOFJkHtO5pyVkDA+cGtS5fqqG5rpsWbTcl
         UjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EI/4dmcppN42J3wIYQ5qmDIDXB89WuNctT9orOaERV0=;
        b=G2/osRE1/pIwfAiNiZUa86BjSK3Mf04lCH9nlNLezCHG4AQOe4IA0ONrJwK+T7r2nT
         4O+SCAj8okYfdDzNttdWCFXPb8nkb/W+8MqA2U4DpHSV8XexkDwBDJ1JUthfSrJW/05o
         ViXfhe6CxllJTv7TLf6hXMgHzsN1ZM1mcp+PIrG/OzcDQTta/249zze1lbrlaLwOBJsp
         GOiDrujYKsR+pHBDhc0JISqDrsnnslvDlhFwn0dwRQ1mGlvmletiC7AivQicR4qmq8YL
         /4umue93bzbR9n9GJL4wlvpJvADP/C9CNVj+nabqYJJtAyZMsELJ5Wa/t81RlBHBAOnE
         TSvQ==
X-Gm-Message-State: AMCzsaV4Vf+QjIiFIxpioC2UQ4oOjLz85EgHgl+RzCQc+u5j6/jWFZc5
        9kzytrIN/MPRbu4wrwYkU/8RQQ==
X-Google-Smtp-Source: ABhQp+Qhn/D3DiXF4fYVoCgK26KgE136uFmswwevnGggoIyOLzeDXm7vgD6QbKnqJuJHNA4Mu11zPg==
X-Received: by 10.107.222.17 with SMTP id v17mr4255041iog.283.1509484740364;
        Tue, 31 Oct 2017 14:19:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:55a5:57f1:5248:2d32])
        by smtp.gmail.com with ESMTPSA id e99sm1311670itd.40.2017.10.31.14.18.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 14:18:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: [PATCHv2 4/7] builtin/describe.c: print debug statements earlier
Date:   Tue, 31 Oct 2017 14:18:49 -0700
Message-Id: <20171031211852.13001-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031211852.13001-1-sbeller@google.com>
References: <20171031003351.22341-1-sbeller@google.com>
 <20171031211852.13001-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For debuggers aid we'd want to print debug statements early, so
introduce a new line in the debug output that describes the whole
function, and the change the next debug output to describe why we need
to search. Conveniently drop the arg from the second line; which will
be useful in a follow up commit, that refactors the describe function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index fd61f463cf..3136efde31 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -293,6 +293,9 @@ static void describe(const char *arg, int last_one)
 	unsigned long seen_commits = 0;
 	unsigned int unannotated_cnt = 0;
 
+	if (debug)
+		fprintf(stderr, _("describe %s\n"), arg);
+
 	if (get_oid(arg, &oid))
 		die(_("Not a valid object name %s"), arg);
 	cmit = lookup_commit_reference(&oid);
@@ -316,7 +319,7 @@ static void describe(const char *arg, int last_one)
 	if (!max_candidates)
 		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
 	if (debug)
-		fprintf(stderr, _("searching to describe %s\n"), arg);
+		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
 
 	if (!have_util) {
 		struct hashmap_iter iter;
-- 
2.15.0.rc2.443.gfcc3b81c0a

