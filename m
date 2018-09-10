Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD911F404
	for <e@80x24.org>; Mon, 10 Sep 2018 14:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeIJTBs (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 15:01:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40401 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeIJTBs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 15:01:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so22104555wrw.7
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N3yBE+pAfU7+dZqRzFMfa1/GUC3HVDHCqcCLOzu0UM=;
        b=FXgn1IQRWrwonVHbGU6aQ3a0iqWwkDCS2cwK8DCw90XDy5mi6w1JX3ahi2GVNsd5Q9
         JJllwbw2tyM0Alb5URe5nAeRUQ63oIGGYpgrb06mwNwhBIE6AS83RXEwTNdD++pI4msD
         /sm71deNvv5Pc73laK05tcAdmg7EddN7EvzK0ovZz65naSDmrmn3gtLGX8bnxSZ2Wiqa
         lutxZIZ3L+GLuJVsIFJR3IjlZlHGZZp7b375Ca0XkTS0pVBtjfuUnpLnb3cDRfIoaqSQ
         Oxd4upPR0Zrn2v3yYr7vgN/FX4muBup9LXwS1dxgRXp4NZJ63KfigTKwUcC9S22A4cUp
         9i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N3yBE+pAfU7+dZqRzFMfa1/GUC3HVDHCqcCLOzu0UM=;
        b=WRixB3gvyrwp3QmS+LCn9d4A0HZXN3e3XyOy7ikJ2BiTrFBF2lEuhdrCc8Bvnf+9MT
         sC0znzj56P3OdSrjZF03fWoflFhs7L2j4XpaLmoPQus5nNCRHWZDWe7gTOzyQnxyU4eT
         HCWIG+Sl+yU+yQdDXdw4nu2X5BBVZ0U63UtTuZGiWUA7RjAn+j3QpsVV2wkYk1Pj94lD
         bVL4I3+QdzaVw4h4SqewZCm9ibK66r4Nc7jS4tvn0jIYI4lZxCtMRn1rtF4KDAJvlUxQ
         e3qTD1HR3ZgedOyiBdv4SYHUwyVkQfKInb0B1r/i/IHDxGkMYvGKqKmQMgjVxedeYiat
         ei0A==
X-Gm-Message-State: APzg51AITPc8AG/nnthw6k8rIOkvpd2Vi6NCAk/KAEgjU/gp5QHCvx+h
        9P+cD7WSySDYIUq00o5DiutJyEnZ3Fs=
X-Google-Smtp-Source: ANB0Vdbd/Bby0FG9X0scVH8MZb5eN8LPirYD/yrcYq5BZtieDkNVvMZwVa4DRCZ/tCw0CO0pKEMmZA==
X-Received: by 2002:adf:ef89:: with SMTP id d9-v6mr15310587wro.195.1536588449237;
        Mon, 10 Sep 2018 07:07:29 -0700 (PDT)
Received: from localhost.localdomain (x590d3ee7.dyn.telefonica.de. [89.13.62.231])
        by smtp.gmail.com with ESMTPSA id e7-v6sm20307809wru.46.2018.09.10.07.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Sep 2018 07:07:28 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t3701-add-interactive: tighten the check of trace output
Date:   Mon, 10 Sep 2018 16:07:14 +0200
Message-Id: <20180910140714.19617-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.140.g09cf9e37c9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'add -p does not expand argument lists' in
't3701-add-interactive.sh', added in 7288e12cce (add--interactive: do
not expand pathspecs with ls-files, 2017-03-14), checks the GIT_TRACE
of 'git add -p' to ensure that the name of a tracked file wasn't
passed around as argument to any of the commands executed as a result
of undesired pathspec expansion.  This check is done with 'grep' using
the filename on its own as the pattern, which is too loose a pattern,
and would match any occurrences of the filename in the trace output,
not just those as command arguments.  E.g. if a developer were to
litter the index handling code with trace_printf()s printing, among
other things, the name of the just processed cache entry, then that
pattern would mistakenly match these as well, and would fail the test.

Tighten this 'grep' pattern to only match trace lines that show the
executed commands.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3701-add-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 609fbfdc31..65dfbc033a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -540,7 +540,7 @@ test_expect_success 'add -p does not expand argument lists' '
 	# update it, but we want to be sure that our "." pathspec
 	# was not expanded into the argument list of any command.
 	# So look only for "not-changed".
-	! grep not-changed trace.out
+	! grep -E "^trace: (built-in|exec|run_command): .*not-changed" trace.out
 '
 
 test_expect_success 'hunk-editing handles custom comment char' '
-- 
2.19.0.rc2.140.g09cf9e37c9

