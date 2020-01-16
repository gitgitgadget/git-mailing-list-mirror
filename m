Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E10C33CB3
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E234B20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzt1dLP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgAPGOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39387 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbgAPGOj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so2444839wmj.4
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a847r3KOoOakW6iuxHBv580h4QHrfm4RX5u4rfoZVMo=;
        b=Nzt1dLP9BLOfgUqJSZwbd3CmsAnS7OWj9pewoJvniL8d55+glAQL355NHU7VeklTyh
         cb9yoh3JPReFm9rSsbd/P2dyZm3Af+lluklElMEBi1BigWGkzQDBD8S5QPEx5GDMIGEb
         ORL9oOY0SVoA08fTjDcsCSriA/IjdZUnELbP2M8FIINm9dMP5u3rYUpBTjmOhvMPYtPT
         jbAmSsMnQl1MTKRFb57dukZDrSHiEzmQ5nkQi+N8prrpQxtvcO3bAhlX+W2Ym1+vrO+m
         yMXgf5jMb7FXO5maaLrpdHs+v1lN1snXamvkj52sPgjcAGU4k6wLHbgr5PxqF4dH7cYx
         MSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a847r3KOoOakW6iuxHBv580h4QHrfm4RX5u4rfoZVMo=;
        b=F2yShoLo0Zr6WAGk6sHHcII5+Mq7hZuw3OHLOBU1gQ7XuwIhFe16EoegUxee1+XDzu
         szlo3I9uIunCgzdQ40u3DlNm1NF41mTsrSD3uD25DCQFcU4971mbiytyO6dXO2Pv70BM
         AMawHmPmFSD1AAArAq8oSDEM721IM9iESl6iGiJuZazhKYvNS+ehmPPBWOv0dOhMhAj4
         qQdrWaINKhNRe94Y4RVlD3pDs18qg40zJ/IyIut9buSTLdkjYNz69TvhcgXChnPcFGEP
         oVTbKIohlFDFrGgiXL2ZMFxgEOIqb+nUi59oNEELQXNQ+Rv+PuRRmJHo8Uo9pzwmx9qC
         iL0Q==
X-Gm-Message-State: APjAAAWJD9SnbNUrm6Sf5d7r+2dZ2o4UNWaMo38XchR6R+HOhUmI/7bF
        X8QEoYyCuqjWThyTOt7/qVkaW/a3
X-Google-Smtp-Source: APXvYqxjTaa8EmgHU9GymW7hdr5aub7+RxfXjC4v3DwVV3QvL6+xcwlaCFiY0BcZHSx56PMEuraaaQ==
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr3959397wmj.177.1579155277078;
        Wed, 15 Jan 2020 22:14:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v83sm3136940wmg.16.2020.01.15.22.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:36 -0800 (PST)
Message-Id: <10fdd162a05b6e76a02f9ba9f2e00b972dba31e6.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:16 +0000
Subject: [PATCH v4 02/19] t3404: directly test the behavior of interest
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t3404.3 is a simple test added by commit d078c3910689 ("t3404: todo list
with commented-out commands only aborts", 2018-08-10) which was designed
to test a todo list that only contained commented-out commands.  There
were two problems with this test: (1) its title did not reflect the
purpose of the test, and (2) it tested the desired behavior through a
side-effect of other functionality instead of directly testing the
desired behavior discussed in the commit message.

Modify the test to directly test the desired behavior and update the
test title.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3404-rebase-interactive.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ae6e55ce79..c41531f349 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -72,15 +72,16 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
-test_expect_success 'rebase -i with empty HEAD' '
+test_expect_success 'rebase -i with empty todo list' '
 	cat >expect <<-\EOF &&
 	error: nothing to do
 	EOF
 	(
 		set_fake_editor &&
-		test_must_fail env FAKE_LINES="1 exec_true" \
-			git rebase -i HEAD^ >actual 2>&1
+		test_must_fail env FAKE_LINES="#" \
+			git rebase -i HEAD^ >output 2>&1
 	) &&
+	tail -n 1 output >actual &&  # Ignore output about changing todo list
 	test_i18ncmp expect actual
 '
 
-- 
gitgitgadget

