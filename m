Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26A81F597
	for <e@80x24.org>; Fri, 27 Jul 2018 23:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbeG1BAU (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 21:00:20 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:54993 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbeG1BAT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 21:00:19 -0400
Received: by mail-qt0-f202.google.com with SMTP id d1-v6so5211293qth.21
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 16:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zuKzcxPm27xkeZ29uSZEPfHEzMcDmSfpVjL83YD112E=;
        b=vvoOquIBg1IGgrA/QGJtDc5ijDQh9sSx9qx8ZxjBMkPKzUBFPPnbU+ISQDtjdKiT2f
         P59VXi1c+uzd7jPiDv+WuLOO4zFfQUqhB2Y9cEaXKpuI31cm1/6FTcJssPcp1LkW+jWc
         sd9IlRImqgrReYqh149eoCZ6CyVaC0E0oANkWoPplB9T6NKhYwrH+aFKc2GuzmEFHf7R
         TXYvW9ikxtupbvtkLcC/mguI7yO8ZJp6v1OT3RRcuxWCPfgV/ZYmryhFHZI0C0ZJxMM+
         tgzCUATTSoSwXNfqh4LjbqTJypVP2DHDnmx6EERTYUZ0lI5Uw2KmCyUtvNsaG2KJCslW
         2s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zuKzcxPm27xkeZ29uSZEPfHEzMcDmSfpVjL83YD112E=;
        b=R5TdMaXqkjK05riOOXGjuT7+NOUn16bgEZhxit9MeR4DxWp3cTScpnv3AIMhSsAGtw
         /n+2ppByXdqmfa2zxN9wvl3EdbWETpzR9HmzxNlR9BSFDbk2cHLk7WOdTcvU3VkrMK2h
         /NFcKblmUJKfLUZVjy+PeWnOYvr0GBxDJGgweX84VqPgGs0r1u/cCypgvBG0RkALaiNh
         DQf3spd9VZvdGylsjUKsZvDlpxcK3GBz7+PJbyYPQanYde12QCajCrPIzefLcMu53Yy3
         4z9p3dMkSrabPOjspQbC2BfYCZ3ZhlfoWjm+oy3HZC1XjmCG+FKuFrYFpPrcZAeXTqfx
         lP1g==
X-Gm-Message-State: AOUpUlHaClpb7sCUGZSRVA7MlAMHlrE7f2bhhNWleevUxmCAlESfa3gd
        cINwSesUywIdujGbYnEfxUG7rj34GkWWEsa7/gjEAfsuI+03XqB5c9st3anSEuemhFNET7q1LD9
        ge1VV/yjrQ2XdkLFi0+AwADZI1lkpo0abPgdiiX2XoBDMiGFPee63NvL421q+
X-Google-Smtp-Source: AAOMgpdc311AIieMFbvt6EgAd6Nb/G273p6MG37w6kfPMwvF1+0pZ4eR4XbcHHAxnOdMbVtjTjoVlQv+1OVT
X-Received: by 2002:ae9:c118:: with SMTP id z24-v6mr4700729qki.34.1532734569493;
 Fri, 27 Jul 2018 16:36:09 -0700 (PDT)
Date:   Fri, 27 Jul 2018 16:36:06 -0700
In-Reply-To: <CAGZ79kaVS96_K-G-_hEnRecBS843tjn7=Am0xZQjZABCdC7L0A@mail.gmail.com>
Message-Id: <20180727233606.179965-1-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kaVS96_K-G-_hEnRecBS843tjn7=Am0xZQjZABCdC7L0A@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH] config: fix case sensitive subsection names on writing
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, peff@google.com, Johannes.Schindelin@gmx.de,
        gitster@pobox.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A use reported a submodule issue regarding strange case indentation
issues, but it could be boiled down to the following test case:

  $ git init test  && cd test
  $ git config foo."Bar".key test
  $ git config foo."bar".key test
  $ tail -n 3 .git/config
  [foo "Bar"]
        key = test
        key = test

Sub sections are case sensitive and we have a test for correctly reading
them. However we do not have a test for writing out config correctly with
case sensitive subsection names, which is why this went unnoticed in
6ae996f2acf (git_config_set: make use of the config parser's event
stream, 2018-04-09)

Make the subsection case sensitive and provide a test for writing.
The test for reading is just above this test.

Reported-by: JP Sugarbroad <jpsugar@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

I really appreciate the work by DScho (and Peff as I recall him as an active
reviewer there) on 4f4d0b42bae (Merge branch 'js/empty-config-section-fix',
2018-05-08), as the corner cases are all correct, modulo the one line fix
in this patch.

Thanks,
Stefan

 config.c          |  2 +-
 t/t1300-config.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 7968ef7566a..de646d2c56f 100644
--- a/config.c
+++ b/config.c
@@ -2362,7 +2362,7 @@ static int store_aux_event(enum config_event_t type,
 		store->is_keys_section =
 			store->parsed[store->parsed_nr].is_keys_section =
 			cf->var.len - 1 == store->baselen &&
-			!strncasecmp(cf->var.buf, store->key, store->baselen);
+			!strncmp(cf->var.buf, store->key, store->baselen);
 		if (store->is_keys_section) {
 			store->section_seen = 1;
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 03c223708eb..710e2b04ad8 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1218,6 +1218,63 @@ test_expect_success 'last one wins: three level vars' '
 	test_cmp expect actual
 '
 
+test_expect_success 'old-fashioned settings are case insensitive' '
+	test_when_finished "rm -f testConfig testConfig_expect testConfig_actual" &&
+
+	cat >testConfig <<-EOF &&
+		# insensitive:
+		[V.A]
+		r = value1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		# insensitive:
+		[V.A]
+		Qr = value2
+	EOF
+
+	for key in "v.a.r" "V.A.r" "v.A.r" "V.a.r"
+	do
+		cp testConfig testConfig_actual &&
+		git config -f testConfig_actual v.a.r value2 &&
+		test_cmp testConfig_expect testConfig_actual
+	done
+'
+
+test_expect_success 'setting different case sensitive subsections ' '
+	test_when_finished "rm -f testConfig testConfig_expect testConfig_actual" &&
+
+	cat >testConfig <<-EOF &&
+		# V insensitive A sensitive:
+		[V "A"]
+		r = value1
+		# same as above:
+		[V "a"]
+		r = value2
+	EOF
+
+	git config -f testConfig v.a.r value3 &&
+	q_to_tab >testConfig_expect <<-EOF &&
+		# V insensitive A sensitive:
+		[V "A"]
+		r = value1
+		# same as above:
+		[V "a"]
+		Qr = value3
+	EOF
+	test_cmp testConfig_expect testConfig &&
+
+	git config -f testConfig v.A.r value4 &&
+	q_to_tab >testConfig_expect <<-EOF &&
+		# V insensitive A sensitive:
+		[V "A"]
+		Qr = value4
+		# same as above:
+		[V "a"]
+		Qr = value3
+	EOF
+	test_cmp testConfig_expect testConfig
+'
+
 for VAR in a .a a. a.0b a."b c". a."b c".0d
 do
 	test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
-- 
2.18.0.345.g5c9ce644c3-goog

