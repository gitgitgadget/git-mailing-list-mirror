Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CB320357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbdGQULo (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:44 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34292 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdGQULm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id p11so9990lfd.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jd3RjFH23R6G2edEGcWzOw9UvkqfgQOKxKMOYa99oPk=;
        b=QtAXD3EALXgO7wK2mngzh3j1AvzQ62ISG6jwT6MNeg5IjBsWSC4cJ5tU97rZwIFSYe
         ULjru2CgvkKOeltwSc6siKUKXa+ilKaLkR6CLSswYdx/IzBWnlt/TPWON/eCL1XrE3mX
         e1yLA3SeMV9f65UKzLYyULUhQm/VYLu2NCStJPpdbYDTddsEml2A6OAjI0j6voVRwHLX
         qg4uguk90xQVkTq4DwIOMq0y/B++LN77bCJt+EVZV+m0av1ZIIEhlcT5hjQDxsi6THeG
         Kw5haj9xs2I9NLpDTKKgz5lrsbWub6g/2GALou7yNPjhGEg54VAUFA/VbIttNGHxSf0g
         al/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jd3RjFH23R6G2edEGcWzOw9UvkqfgQOKxKMOYa99oPk=;
        b=Ma5a6vjZPjCQxj0w8il2uaLfIRQvgoROceqFNhxHZYVk9rumpgR0IACk4q4NhcFAas
         uhW6uQm1xb9tAj20bQJT1zxxkTk4+vwETNTP71HMyRJy0l0oU5uVg7XLy1eGf6JUvb9R
         LAJtNxZKmTICjp/3EYjh4OkCFRYOF3Nm09GqQGfTG6eDfSPwBYyRvFFMT1MLUEE4PVn1
         e7otr3+7oKJEiHDi7dqe7MWO7eo2cTRT/rbdGuM1bAkVcm++3mGq21fmMrxXbf3cnxFP
         fmJ0Wpo7wsfFerEBJ+Y7/SPT6nVTv041S2i7EtM9+r0PMmhkXRqeaDKNQ3YMIG/oNMvV
         QqaA==
X-Gm-Message-State: AIVw111+T72AHwfizN/u27/gnCt6rhT2q3dWLz86pUH1Vm3txA4chayS
        GshTWgrHGHrXQ33S
X-Received: by 10.25.168.18 with SMTP id r18mr6812502lfe.85.1500322301067;
        Mon, 17 Jul 2017 13:11:41 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 06/10] t7006: add tests for how git tag paginates
Date:   Mon, 17 Jul 2017 22:10:48 +0200
Message-Id: <f4334503b677bbbeb19660e501ad2d7213428953.1500321658.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using, e.g., `git -c pager.tag tag -a new-tag` results in errors such as
"Vim: Warning: Output is not to a terminal" and a garbled terminal. A
user who makes use of `git tag -a` and `git tag -l` will probably choose
not to configure `pager.tag` or to set it to "no", so that `git tag -a`
will actually work, at the cost of not getting the pager with `git tag
-l`.

Since we're about to change how `git tag` respects `pager.tag`, add tests
around this, including how the configuration is ignored if --no-pager or
--paginate are used.

Construct tests with a few different subcommands. First, use -l. Second,
use "no arguments" and --contains, since those imply -l. (There are
more arguments which imply -l, but using these two should be enough.)
Third, use -a as a representative for "not -l".

Make one of the tests demonstrate the behavior mentioned above, where
`git tag -a` respects `pager.tag`. Actually, the tests use `git tag -am`
so no editor is launched, but that is irrelevant, since we just want to
see whether the pager is used or not.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7006-pager.sh | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 20b4d83c2..e7430bc93 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -134,6 +134,74 @@ test_expect_success TTY 'configuration can enable pager (from subdir)' '
 	}
 '
 
+test_expect_success TTY 'git tag -l defaults to not paging' '
+	rm -f paginated.out &&
+	test_terminal git tag -l &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -l respects pager.tag' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag tag -l &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -l respects --no-pager' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag --no-pager tag -l &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag with no args defaults to not paging' '
+	# no args implies -l so this should page like -l
+	rm -f paginated.out &&
+	test_terminal git tag &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag with no args respects pager.tag' '
+	# no args implies -l so this should page like -l
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag tag &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git tag --contains defaults to not paging' '
+	# --contains implies -l so this should page like -l
+	rm -f paginated.out &&
+	test_terminal git tag --contains &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag --contains respects pager.tag' '
+	# --contains implies -l so this should page like -l
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag tag --contains &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -a defaults to not paging' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git tag -am message newtag &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -a respects pager.tag' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag tag -am message newtag &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -a respects --paginate' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag=false --paginate \
+		tag -am message newtag &&
+	test -e paginated.out
+'
+
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
-- 
2.14.0.rc0

