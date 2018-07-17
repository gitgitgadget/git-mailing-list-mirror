Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FF61F597
	for <e@80x24.org>; Tue, 17 Jul 2018 23:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeGRAAY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 20:00:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53551 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeGRAAY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 20:00:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so918295wmh.3
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W9swPQjYGUEy8B+XwZDTdOUF3lVMlZuIHqfhLt2OJwQ=;
        b=gy5TVDJ0v8r6lhP6Y/dlKidAgRGydmzmRD1g7rEvVRCH5BQsS6LIz48DdBIgp/fxIE
         2n2o0sLBcdiBXBrhTMdiHPhu4sIATqM55JhQG3INHKqxe4GYqByh9AkwK8ZSktRtL2S/
         gSeyWeLNlBSV4jAByvx7pEz0y/ymJBx9Lwabok0o3n7EhU0GJoGpNldIhjnWSK++fEkI
         3LT8+7FsjzhxR9n1PUbJLl6SYtuUHo+wGEfv56FEQ4rQMJqW31N6ZZNhnohNie4+rIET
         aaz13/f3ySdqlMCU181z29ps8HGjIqBcMeg88V3GDeVnH0IhEd6LKqxboosX3R4/td4s
         ezhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W9swPQjYGUEy8B+XwZDTdOUF3lVMlZuIHqfhLt2OJwQ=;
        b=qFRQ66KZgj4jXBCCa47BzCa4ur7ETjZcieoiJfDgN2Y6/SJsuHFO2dkHKyfsNIPKgf
         Sui+2iQB/qMAMOu/S58Rpc1XIkNR1aCJAqNhkvKi23V9ox5SIJWAZqEEAa+hw4wbp+JI
         IPHQXwDAINJBtc14vNRve8gNADYemGc1BOl91LUKoKpHe0V8xBV7porxEBx+I9Q1OEGR
         dsCVDJRtjRPVWVGLbnkJhVAS8oS0NveqkBbRzAsdlt0IBsUHOcAiWJvofiGv/BK9hrcr
         /TAiclvB6wFNWuy7rbqfO9c6Hj2GacfRAcnp9VL2PEGE48j4HT7UNr+KrrbZrF85kIxi
         OQNw==
X-Gm-Message-State: AOUpUlGiTvMFWK7aWw7fg3cVXjG0nSvpu6h7wY5DJUb7arVvVm/sSAwQ
        0QWslZgWyEOBThlTTeuFjyJvZx4H
X-Google-Smtp-Source: AAOMgpc+v2VFAUJkgD3wNt0sAvTiHJdjRuhjJbjmI2eA+yxUqV36CjycYRF/DLd8EIs/NjB9sKyC+Q==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr94187wmt.94.1531869926087;
        Tue, 17 Jul 2018 16:25:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g15-v6sm3867015wrh.48.2018.07.17.16.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 16:25:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     knu@idaemons.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script properly
References: <86a7qwpt9g.knu@iDaemons.org>
        <xmqqa7qww6uk.fsf@gitster-ct.c.googlers.com>
        <CAPig+cQWA+sE3iH89kQGWgS+0HQDK-V5++S0+F6_dpfOCfXxDg@mail.gmail.com>
Date:   Tue, 17 Jul 2018 16:25:22 -0700
In-Reply-To: <CAPig+cQWA+sE3iH89kQGWgS+0HQDK-V5++S0+F6_dpfOCfXxDg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 12 Jul 2018 16:16:50 -0400")
Message-ID: <xmqqpnzlla1p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll squash the following in (which I have been carrying in 'pu' for
the past few days) unless I hear otherwise soonish to correct the
issues raised during the review.

Thanks.

 t/t3404-rebase-interactive.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 2d189da2f1..b0cef509ab 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -81,11 +81,13 @@ test_expect_success 'rebase -i writes out .git/rebase-merge/author-script in "ed
 	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 	test -f .git/rebase-merge/author-script &&
-	unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-	eval "$(cat .git/rebase-merge/author-script)" &&
-	test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
-	test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
-	test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"
+	(
+		sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
+		eval "$(cat .git/rebase-merge/author-script)" &&
+		test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
+		test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
+		test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"
+	)
 '
 
 test_expect_success 'rebase -i with the exec command' '
-- 
2.18.0-129-ge3331758f1

