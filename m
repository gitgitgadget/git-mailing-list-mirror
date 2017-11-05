Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1D820450
	for <e@80x24.org>; Sun,  5 Nov 2017 11:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbdKEL6t (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 06:58:49 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:48106 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdKEL6q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 06:58:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id r196so8816236wmf.2
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 03:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Kk2FJjJwLuDcx8Df/MPQZOyH9p0jmCeSuVWN5Zb174=;
        b=VRXb63xeT6KVFqhysNSDuo1ge9UYel9zAEYvmwGjpCDiJDXIO5rBlXzTq0yP1TzkHQ
         2i37MZkSRwivdDpNx4cJGDy+JoRT0N2OXL7pXRzOxMZQgQPNb+4OKsmEpj2Nu89IbmaT
         PNd4Quc1wZzC2nbdKwIP5BazCZgt9Yb6SJC+rzeWFeqhz/J2QMfKWWK6v5GvP/SRdyRu
         5LNzdVs2fAakoM3WXZLaCd18zdHisrC04SZyEuhcH6fiZFkXH0aAOl/jxZYezQAb1rGu
         NE9kDFKMIC8nZutRUjib+1j0YSK/PMUUHsqkYtPqu1btKTSY5b1syWA59ezIvw/r9ACI
         rZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Kk2FJjJwLuDcx8Df/MPQZOyH9p0jmCeSuVWN5Zb174=;
        b=d0oNAjpMHbu4Ij9eVd/4owHpeyNS6NwAWr9nCDXjzwF416ON7InE92bqdoAbkMoydX
         a3xBKwEZk8YRAkBF/6w4HA9zFCya/dOxQOQ6dR/2cKLv1VojPPMybPnJOnVU6ihxiYFO
         MIIEcvHvME5Ttu4ck6msLfcNZdun+oBbIWZCeHLcVJ02hMpYXS/VgSNdnPAEnHLEe/i5
         UTlBo3n3z3qGkhg4xumwkX5aci3YIzp8IRZ2bFD50PZu6Mdmjf+UcBB0CdMj2VWgAXA0
         DluyW64ciVnuBg//bhvHJuMhgu78oDjy9Eva8e2T07IzyxPAPutYcDFS7BoEgFapzEnM
         KkEw==
X-Gm-Message-State: AJaThX5m1GhWU3Qck3ydVkbmHqOXfPG3BXrzlJ1OEpzwWpx6lOU7YhpV
        FHLb8aWdWD2XdwSNuVzqiUY=
X-Google-Smtp-Source: ABhQp+TOqdj/kRBmbNX9yQt2HvSrey6N+bQOlFABtxwJiFdiHRCroFCwMcboJ0El2woAJ+C419YZrg==
X-Received: by 10.28.4.150 with SMTP id 144mr3107479wme.79.1509883124839;
        Sun, 05 Nov 2017 03:58:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u18sm14391450wrg.94.2017.11.05.03.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 03:58:44 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, hkleynhans@bloomberg.net,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 4/4] pager: make `pager.foo.command` imply `.enable=true`
Date:   Sun,  5 Nov 2017 12:58:22 +0100
Message-Id: <d8e25efe07e72eeef887d7af06f23b69f9b227ec.1509879269.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <cover.1509879269.git.martin.agren@gmail.com>
References: <20171104092850.5fthdgvnihd3y4fm@sigill.intra.peff.net> <cover.1509879269.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `pager.foo.command` gets configured and there is no configuration
(yet) saying whether we should page, act as if `pager.foo.enable=true`.

This means that a lone `pager.foo` can always be written as a lone
`pager.foo.command` or `pager.foo.enable`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/config.txt | 2 ++
 t/t7006-pager.sh         | 7 +++++++
 pager.c                  | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 72558cc74..91cc8b110 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2470,6 +2470,8 @@ pager.<cmd>.command::
 	Specifies the pager to use for the subcommand.
 	Whether the pager should be used is configured using
 	`pager.<cmd>.enable` or `pager.<cmd>=<boolean>`.
+	Implies `pager.<cmd>.enable=true` unless `pager.<cmd>.enable`
+	or `pager.<cmd>` have already been given.
 
 pager.<cmd>.enable::
 	A boolean which turns on or off pagination of the output of a
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 6966627dd..c5246a57d 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -625,6 +625,13 @@ test_expect_success TTY '.enable discards non-boolean' '
 	test_must_fail git -c pager.log.enable=bad log
 '
 
+test_expect_success TTY 'configuration with .command turns on paging' '
+	>actual &&
+	test_terminal git -c pager.rev-list.command="sed s/^/foo:/ >actual" \
+			  rev-list HEAD &&
+	test_cmp expect actual
+'
+
 test_expect_success TTY 'configuration remembers .command as .enable flips' '
 	>actual &&
 	test_terminal git -c pager.rev-list.command="sed s/^/foo:/ >actual" \
diff --git a/pager.c b/pager.c
index c8a6a01d8..0e037abf4 100644
--- a/pager.c
+++ b/pager.c
@@ -209,6 +209,8 @@ static int pager_command_config(const char *var, const char *value, void *vdata)
 	} else if (!strcmp(remainder, ".command")) {
 		free(data->value);
 		data->value = xstrdup(value);
+		if (data->want == -1)
+			data->want = 1;
 	} else if (!strcmp(remainder, ".enable")) {
 		data->want = git_config_bool(var, value);
 	}
-- 
2.15.0.415.gac1375d7e

