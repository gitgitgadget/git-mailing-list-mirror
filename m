Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3451F404
	for <e@80x24.org>; Sun, 25 Mar 2018 18:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeCYS2k (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 14:28:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39136 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeCYS2g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 14:28:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id c24so16701604wrc.6;
        Sun, 25 Mar 2018 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6OaaWJzBZIG41DvyAe+h1/mrADNT6s1whJnQyHCZrn8=;
        b=DvyRmwT+qtqGrR6s1HHildQHAeQPSHECbJHa7u0sU8iXx24stCkzP3rFqH7NiDl0wH
         6tar6md+rP6rH/NGfg1De3iDI878jfEcMOI14VSHP0dqY0rIt9HFJJBUdQXuDM9xfJOK
         YIW4m9O2iqP9fMl4hkYK1EvxOEI0WP7sOS0qNg2AATu6DnIoOQszDF4eDdzowaSS6O7g
         PpJnCMTxAKSaNyBA6QCpZuPvhkB2hDd60lRndQGE3u69B6M1YHQ6RmJjBe/hOaWRtoTp
         /cmW9kxeMjdhJ/olzZuKvd8lWUbGm0goVgSHQaVzmdqbdXl5YNsV0DYC1ak4AQpMy18I
         twuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6OaaWJzBZIG41DvyAe+h1/mrADNT6s1whJnQyHCZrn8=;
        b=F1ldzHTx34dYx6/zJr2sHT34jNTzDUYXVna0bxtrxmQxKg5HPgtn8P6jkDgp2IbwNa
         Q7yTq7N1wdTpjTfaCGRrL/wdbdFCgfJy76EYF5NQ0FTdYRRNjKFmQXC1RsxKcUbUF+ix
         fJLcp4wkzoDyNvavi+OFlg/Jxf4xHj3hHDpW905lidIF6i2+qEsXIqpaAylp7TfL0zgY
         YCQyaL0iGeJ1a+Npk6XoHsAer/Y+eqEa6FoW1nTA9bY8s0JjmWSpMgmZR1J4F4G4zQH+
         OPhQb1x4+eBUFfwoX+mFTEGapS+qac6C9LfVhSp6NrT53910+IZgWzER/Cp6AAOuVLXd
         nNrQ==
X-Gm-Message-State: AElRT7G524ToFlKNhC05l9U8Vmic2RIOkyYtDlKjyfhtYR3EYDvoraBY
        SBStd5qqWk/EMu98BgXu/8IZ1LiJ
X-Google-Smtp-Source: AG47ELvAJYTUyFN8zLwpdfb7Gqi7tiBoyuQK/cpthhjt2XGTOfit/2GuoFUBohUQLNvp6wWgugUzAw==
X-Received: by 10.223.197.139 with SMTP id m11mr27708372wrg.198.1522002514973;
        Sun, 25 Mar 2018 11:28:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x10sm14451762wrc.64.2018.03.25.11.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 11:28:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] send-email: supply a --send-delay=1 by default
Date:   Sun, 25 Mar 2018 18:28:03 +0000
Message-Id: <20180325182803.30036-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.37.g46b2b28759
In-Reply-To: <20180325182803.30036-1-avarab@gmail.com>
References: <20180325182803.30036-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer-Send-Delay: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The earlier change to add this option described the problem this
option is trying to solve.

This turns it on by default with a value of 1 second, which'll
hopefully solve it, and if not user reports as well as the
X-Mailer-Send-Delay header should help debug it.

I think the trade-off of slowing down E-Mail sending to turn this on
makes sense because:

 * GMail is a really common client, git.git's own unique authors by
   %aE are ~30% @gmail.com, ~20% for linux.git. That's just patch
   submitters, my guess is this it's much more common among those who
   mostly read the list, and those users who aren't using mu4e / mutt
   etc. anyway.

 * There's really no point in having this feature at all if it's not
   made the default, since the entire point is to be able to read a
   list like the git ML or the LKML and have patches from others show
   up in order.

 * I don't think anyone's really sensitive to the sending part of
   send-email taking longer. You just choose "all" and then switch to
   another terminal while it does its thing if you have a huge series,
   and for 1-3 patches I doubt anyone would notice this anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 13 ++++++++++++-
 git-send-email.perl      |  1 +
 t/t9001-send-email.sh    |  4 ++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f155d349c0..bd578642c1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3070,7 +3070,18 @@ sendemail.smtpReloginDelay::
 
 sendemail.smtpSendDelay::
 	Seconds wait in between message sending before sending another
-	message. Set it to 0 to impose no extra delay, defaults to 0.
+	message. Set it to 0 to impose no extra delay, defaults to 1
+	to wait 1 second.
++
+The reason for imposing a default delay is because certain popular
+E-Mail clients such as Google's GMail completely ignore the "Date"
+header, which format-patch is careful to set such that the patches
+will be displayed in order, and instead sort by the time the E-mail
+was received.
++
+This causes sent E-Mail to be shown completely out of order in such
+clients, imposing the delay is a workaround that should usually work
+(although it's by no means guaranteed).
 +
 See also the `--send-delay` option of linkgit:git-send-email[1].
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 013277ede2..ddbc44f1c9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -489,6 +489,7 @@ die sprintf(__("Unknown --confirm setting: '%s'\n"), $confirm)
 	unless $confirm =~ /^(?:auto|cc|compose|always|never)/;
 die sprintf(__("Invalid --send-delay setting: '%s'\n"), $send_delay)
 	if defined $send_delay and $send_delay !~ /^[0-9]+$/s;
+$send_delay = 1 unless defined $send_delay;
 
 # Debugging, print out the suppressions.
 if (0) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index fafa61c5d6..1580e00fce 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1713,7 +1713,7 @@ test_expect_success '--send-delay expects whole non-negative seconds' '
 	test_i18ngrep "Invalid --send-delay setting" errors
 '
 
-test_expect_success $PREREQ "there is no default --send-delay" '
+test_expect_success $PREREQ "there is a default --send-delay" '
 	clean_fake_sendmail &&
 	rm -fr outdir &&
 	git format-patch -3 -o outdir &&
@@ -1724,7 +1724,7 @@ test_expect_success $PREREQ "there is no default --send-delay" '
 		outdir/*.patch \
 		2>stderr >stdout &&
 	test $(grep -c "X-Mailer:" stdout) = 3 &&
-	test $(grep -c "X-Mailer-Send-Delay:" stdout) = 0
+	test $(grep -c "X-Mailer-Send-Delay:" stdout) = 2
 '
 
 test_expect_success $PREREQ '--send-delay adds a X-Mailer-Send-Delay header to affected E-Mails' '
-- 
2.16.2.804.g6dcf76e118

