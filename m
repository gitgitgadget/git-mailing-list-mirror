Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41CC1202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 15:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbdKSPEG (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 10:04:06 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35236 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbdKSPED (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 10:04:03 -0500
Received: by mail-wm0-f66.google.com with SMTP id y80so14154932wmd.0
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 07:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vt7NEaLTb0CpnDW/w/Sx3NFY6tv6/cEoyKrpJsf2cBE=;
        b=EC/Jnxm1aNVgy5DIXK4HsKeIBKTBnGDvzQRU577h7a/MwcecQrICj7bm0Qt0dLAwUR
         /Y0pT7ezauGDcPaVMLYqDnDQfFHgvHPHlu5Tq3j1UU/cC70dpQaN1R4M7lzmrXHgm/L5
         t4l65ZQSR1TNw6GxFbFe2DIG/cfZWl1aqKyVAJVWZH9TjAsRa1CD9edOb/wW1Xeom78B
         oTKXMKhPhFHh9vJ2W4bWgIN6LFF4wUzZG7stdYTGS4uH5TgDsgnIn9uEm54SMgqjENgK
         9JIuYxvE+BnAZkWGziF2EjO3oLThdl+a7OdH6PwcuKXH8rvVJLNch44SDRfzGOd3wTC+
         PLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vt7NEaLTb0CpnDW/w/Sx3NFY6tv6/cEoyKrpJsf2cBE=;
        b=AZyX4SJ0DUzya9GmWuPH9TCxepEPVeio4gxW7mNxUy5qfAsRLImGU4hlcExLqjpkFx
         unNlfgPUfWEFOHshbAE73SnxxScCUUsqy46lB+t1eKbmxi8d0joITWHWPbHz833jCPNI
         kQu9yCKiVwlWcHpZNGb0YakzQ0DeGohW8qinJP9UVGF9Ik32tKr+DHKbFx8pg4fP2UQZ
         Yny1GvExkG7+P85MyO8eHGOUoBCjaxomq6vhhqBVVyJA5Lkhe5K5shpAlseiUT4hqsf3
         Iavdh9MBnFuU38bY58OzBTmcvLvrdUSUD67Pg3VbCCESskSyuTtuHQEYkbCSZiex0eb1
         Wrig==
X-Gm-Message-State: AJaThX7BYQNgNT7p8dcwCmnMdwJzH+dTtIM7kXnWFhdlNLMUKHxdv400
        ro/1/ROqOI/KOWlu/4sJnRHHKKQr
X-Google-Smtp-Source: AGs4zMZOoBDtsIfDI/zuZQdAeKam+trtY3NuWb9UM5IbMNvQvlrmC0TANCpTtq5r3LcM3/3h+QpXnw==
X-Received: by 10.28.107.211 with SMTP id a80mr8761013wmi.71.1511103842323;
        Sun, 19 Nov 2017 07:04:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 56sm5163518wrx.2.2017.11.19.07.04.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Nov 2017 07:04:01 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] t7006: add tests for how git branch paginates
Date:   Sun, 19 Nov 2017 16:03:48 +0100
Message-Id: <5f6be626171060e008005062560c76319b31958f.1511103275.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next couple of commits will change how `git branch` handles
`pager.branch`, similar to how de121ffe5 (tag: respect `pager.tag` in
list-mode only, 2017-08-02) and ff1e72483 (tag: change default of
`pager.tag` to "on", 2017-08-02) changed `git tag`.

Add tests in this area to make sure that we don't regress and so that
the upcoming commits can be made clearer by adapting the tests. Add some
tests for `--list` (implied), one for `--edit-description`, and one for
`--set-upstream-to` as a representative of "something other than the
first two".

In particular, use `test_expect_failure` to document that we currently
respect the pager-configuration with `--edit-description`. The current
behavior is buggy since the pager interferes with the editor and makes
the end result completely broken. See also b3ee740c8 (t7006: add tests
for how git tag paginates, 2017-08-02).

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7006-pager.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 865168ec6a..95547bb8c6 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -214,6 +214,44 @@ test_expect_success TTY 'git tag as alias respects pager.tag with -l' '
 	! test -e paginated.out
 '
 
+test_expect_success TTY 'git branch defaults to not paging' '
+	rm -f paginated.out &&
+	test_terminal git branch &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git branch respects pager.branch' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.branch branch &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git branch respects --no-pager' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.branch --no-pager branch &&
+	! test -e paginated.out
+'
+
+test_expect_failure TTY 'git branch --edit-description ignores pager.branch' '
+	rm -f paginated.out editor.used &&
+	write_script editor <<-\EOF &&
+		echo "New description" >"$1"
+		touch editor.used
+	EOF
+	EDITOR=./editor test_terminal git -c pager.branch branch --edit-description &&
+	! test -e paginated.out &&
+	test -e editor.used
+'
+
+test_expect_success TTY 'git branch --set-upstream-to respects pager.branch' '
+	rm -f paginated.out &&
+	git branch other &&
+	test_when_finished "git branch -D other" &&
+	test_terminal git -c pager.branch branch --set-upstream-to=other &&
+	test_when_finished "git branch --unset-upstream" &&
+	test -e paginated.out
+'
+
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
-- 
2.15.0.415.gac1375d7e

