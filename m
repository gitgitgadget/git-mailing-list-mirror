Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B121F404
	for <e@80x24.org>; Wed, 14 Mar 2018 21:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeCNVe7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 17:34:59 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43860 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeCNVe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 17:34:58 -0400
Received: by mail-wr0-f193.google.com with SMTP id o1so6204048wro.10
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAYfzYFwl4A5ejscKUhsKc/elzewVRq+jIBhqTohhIE=;
        b=qCGRcTrk9XZ8bgA1U88mXKZr8093ugAr6QPHZGlFSbcfRQonqrsJmeo483P+oYZb9M
         ptFSGqI3BZDx6XCc/ViexDzT8EOAKjACvp/DN47tZuePunEk2BQkMxqLyfDmhozrYxw+
         RJX2yXd5u+YZecBGb6P5ZhrCpMC98LAxZ5wEL/cQ5u4q0l5aVDsLqmyab3q4hE4AlQsk
         B2PbOW+aeAMXDg2fHMZDTROR8idTbGqw83ipNHTPueOK9N0XruikWpIztvCj28m7HbH6
         70XXtMEZNpPbz66Z4CoCJBF9H3cOyfo8cIuyTvNYi5+TxQzXVHp9qYKEHoDbf6k/rHUV
         poIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAYfzYFwl4A5ejscKUhsKc/elzewVRq+jIBhqTohhIE=;
        b=tjgkMNCK/leUH4oUWAKNPt0eHxO84w6ByZYLuJJnfMQL3kDInO/5nXFemH+vd9PPP1
         pZYJkTBNqCWIkIr3yjBstcZMrw794HcCIO8Hn172yp6miZeIM0YX2DMO4CGLQBe/3/2y
         XP8+v8AUph7y2pTSSl5/Gf7uJccwQmKtJNdnQlL8iFOKxf1UTy1nBHh0Ef/NBor/Sl4U
         m/+ryuV9tYDfuvPBXZUnKdc96aP+AfjxOW1ykp+8bxSYQUS/t0PY5pjHkmpdbQn0lozr
         pgqnbhQN1LzOzKl+MEKEY0wwvRqKimROYo58fpkym9fjboeW6hyiOtRFwH5wI3v2NlwV
         r4Yg==
X-Gm-Message-State: AElRT7FbHUUr7wEWZ/YjXG4mmRGOdnQMaS5OyUoxkxJUa7pbzvdYLzKo
        3CwAzs9sgLr6Gd2eckz3oMXM0jR4
X-Google-Smtp-Source: AG47ELvczzBck3XrstA2bi14n2TwWzB2IWzyAtbtUUrQ/xOcWsrC4E4DEd2Y7ki0+yaVwUiRCvOOBw==
X-Received: by 10.223.182.174 with SMTP id j46mr5246543wre.43.1521063297153;
        Wed, 14 Mar 2018 14:34:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 55sm5049688wrw.87.2018.03.14.14.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Mar 2018 14:34:56 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] shortlog: disallow left-over arguments outside repo
Date:   Wed, 14 Mar 2018 22:34:19 +0100
Message-Id: <fa32e16aa01a46718c2fba665e8ab2c0c13bbcdf.1521062188.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1521062188.git.martin.agren@gmail.com>
References: <cover.1520680894.git.martin.agren@gmail.com> <cover.1521062188.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we are outside a repo and have any arguments left after
option-parsing, `setup_revisions()` will try to do its job and
something like this will happen:

$ git shortlog v2.16.0..
BUG: environment.c:183: git environment hasn't been setup
Aborted (core dumped)

The usage is wrong, but we could obviously handle this better. Note that
commit abe549e179 (shortlog: do not require to run from inside a git
repository, 2008-03-14) explicitly enabled `git shortlog` to run from
outside a repo, since we do not need a repo for parsing data from stdin.

Disallow left-over arguments when run from outside a repo.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t4201-shortlog.sh | 5 +++++
 builtin/shortlog.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index da10478f59..ff6649ed9a 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -127,6 +127,11 @@ test_expect_success !MINGW 'shortlog can read --format=raw output' '
 	test_cmp expect out
 '
 
+test_expect_success 'shortlog from non-git directory refuses extra arguments' '
+	test_must_fail env GIT_DIR=non-existing git shortlog foo 2>out &&
+	test_i18ngrep "too many arguments" out
+'
+
 test_expect_success 'shortlog should add newline when input line matches wraplen' '
 	cat >expect <<\EOF &&
 A U Thor (2):
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index dc4af03fca..3a823b3128 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -293,6 +293,11 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
+	if (nongit && argc > 1) {
+		error(_("too many arguments given outside repository"));
+		usage_with_options(shortlog_usage, options);
+	}
+
 	if (setup_revisions(argc, argv, &rev, NULL) != 1) {
 		error(_("unrecognized argument: %s"), argv[1]);
 		usage_with_options(shortlog_usage, options);
-- 
2.16.2.246.ga4ee44448f

