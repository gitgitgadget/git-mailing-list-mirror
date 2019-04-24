Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555721F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfDXWrC (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:47:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34620 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfDXWrB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 18:47:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so10139069pgq.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g1GWNAXsguWdeUVRjfvuvM9pMHNnk2b7B0N7Q5+tmjI=;
        b=NWY8o8q4WBkdmsplStw8+FTeG8AqW2oIlB2L6bOzs3ah5FY1qUccqgCGHeH6LGlR65
         YONabpXpC/e/pD9ScNJpknPjGJKO85HQK4sHO58IpbmoyJVQ3Baf9slJoXPH4ZI/K8KI
         /Vw0Llw5IAqWBNnP1njXkQqozz+Kyd3aO+RuAauchOJiZueVLBPVyywvjh+ULbQo6GX8
         SY4F6SyM7D6+9UtBMVtW8dVcrhicg+xLEgYxOEpFoObCcKB7g/WIae91sgiuYcYszA7W
         Jgl32elCg6fMJpNF8xyy2v5pmbMcm+PLQ5wbXXvmIL4pJsWYPFLcCA136nKIXus7dXYE
         EzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g1GWNAXsguWdeUVRjfvuvM9pMHNnk2b7B0N7Q5+tmjI=;
        b=Ce6CS2AqBCyM/W5OjC+hkPNXYmdF4hceskn3FMJ7H20MLC0V5026Kwsx3K0rnIwfxE
         oh31qv+J6mscWz5earBYLi3KRC1Os//4ITMucpfPdxnGEp07+mQSbymSywSfEH234c7s
         FGB0hfeauLjhDNb55YJmhc/zm7YxuNFetkDbsxqyfZeTEnoRYMyW33lkWr437WEMR8MF
         lP1h91kNi1qRUrcDn/UzGrJmanETrmVnTB3oZQwHTTw7ory0EGeTU1FU7mdGa168dx0x
         P6iXCLOzu05E50WkMa4Cu5NJ85VSDjkXgSHEEyCpRSgyzP2C6J0Pdu+5swkhFDDQvcB7
         JDQA==
X-Gm-Message-State: APjAAAXqv9pkwhyNphtQGeevgiszbVU9Ir4konmGPZ3ZPil364d6kL2l
        /f6w2NKr5DUf0mlmMvAmyk9EEHaE
X-Google-Smtp-Source: APXvYqzKaBOZ/fbNv4Dmwdnz2AV0Hq/b0VwoywaHruYdyk1IxJFOd/DiuzTdm67r7pkkvZr5afheXQ==
X-Received: by 2002:a63:d250:: with SMTP id t16mr33238101pgi.288.1556146020504;
        Wed, 24 Apr 2019 15:47:00 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id b7sm38969826pfj.67.2019.04.24.15.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:46:59 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:46:59 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/6] t7610: add mergetool --gui tests
Message-ID: <0f632ca6bf4f5e76d18b17435a8e565b4cdc3cc0.1556142510.git.liu.denton@gmail.com>
References: <cover.1556009181.git.liu.denton@gmail.com>
 <cover.1556142510.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556142510.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 063f2bdbf7 (mergetool: accept -g/--[no-]gui as arguments,
2018-10-24), mergetool was taught the --gui option but no tests were
added to ensure that it was working properly. Add a test to ensure that
it works.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7610-mergetool.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 69711487dd..dad607e186 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -145,6 +145,28 @@ test_expect_success 'custom mergetool' '
 	git commit -m "branch1 resolved with mergetool"
 '
 
+test_expect_success 'gui mergetool' '
+	test_config merge.guitool myguitool &&
+	test_config mergetool.myguitool.cmd "(printf \"gui \" && cat \"\$REMOTE\") >\"\$MERGED\"" &&
+	test_config mergetool.myguitool.trustExitCode true &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
+	test_must_fail git merge master &&
+	( yes "" | git mergetool --gui both ) &&
+	( yes "" | git mergetool -g file1 file1 ) &&
+	( yes "" | git mergetool --gui file2 "spaced name" ) &&
+	( yes "" | git mergetool --gui subdir/file3 ) &&
+	( yes "d" | git mergetool --gui file11 ) &&
+	( yes "d" | git mergetool --gui file12 ) &&
+	( yes "l" | git mergetool --gui submod ) &&
+	test "$(cat file1)" = "gui master updated" &&
+	test "$(cat file2)" = "gui master new" &&
+	test "$(cat subdir/file3)" = "gui master new sub" &&
+	test "$(cat submod/bar)" = "branch1 submodule" &&
+	git commit -m "branch1 resolved with mergetool"
+'
+
 test_expect_success 'mergetool crlf' '
 	test_when_finished "git reset --hard" &&
 	# This test_config line must go after the above reset line so that
-- 
2.21.0.1000.g7817e26e80

