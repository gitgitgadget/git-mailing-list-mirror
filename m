Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59330C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 21:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBUVfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBUVfg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 16:35:36 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5022449C
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:35:33 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id ko13so7200553plb.13
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH/jpK/g8oeT3Refx0R0FvO4O4cMJaeZp+iEkUswa5A=;
        b=gIFS4eIyJvCkrJcuDfNsAvKp++ctM/YcFgZLzqzdSXBTRIBs7SsnMjl5hRmu3vCtzG
         CzdixPgTPZz2si4caUPvwgn91BAE+uQZ2o9hNo8MGepMlRKfBYrvFOViY0U1n9y27+tA
         BfGMzzgbf8POc3/b3LdGA9tDabWgr/2vVZa9LOcZydAyQuLZ+PiBsSLUClaEq5P6QViv
         jgLY1ppukoOr4IvbcMxFrhjlCtWc7JmyPPbD+plc2xJqkT0/Eh8hQmA+w42ejTedA4bT
         luEXiOcsJWcsxhwqe2rCCZsA/DsJCKEXI3q1EkaCJtFffwwvxY8ymB5BEu6H0SYTqvsc
         BKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HH/jpK/g8oeT3Refx0R0FvO4O4cMJaeZp+iEkUswa5A=;
        b=Pk7Ro55o+BqcOgXskEPhuntsgh5ktsGybTHHgS3h+TOt93FM0fxxhF26pwuQmYg95T
         V61A6kvo/oOhliccSBBm3KKMY9MpM2MpaLcSihObdDDZ1EODxl+pUeA03vUZS9yoS1/C
         pL6NX41EpDptYolpbcC3BcArUwVpugduIXdmTyV4J1klGilNAh3qdJDmCK4kiXBUabQ5
         EBC/9vpi4e9m+TkrJ94gsPnezz0iSjLM5W97mZSVuPJEGLdGbdByg1Brr/OeQwQhxWs9
         rFJeGBZ/2ttV0ZpewSJ0VyxVs2w+QyBJS7SG7pWBunNqEOFbrSdw9hA/ryvrmHXxNELg
         y+Rw==
X-Gm-Message-State: AO0yUKVfKM9CDcxYjIwUB34FAo8fiNBO3bfV+J6YdpEY86uwfqLwz1b3
        4ELD/cdTFVuSQpwYfn+y5iURtIM9ekPbPw==
X-Google-Smtp-Source: AK7set/mYd7C5pmjEVqPEmDiinJ0HC9p/4gGwRaptaaKZuija701pT8B7HAskpN4Ejfzn4obCcJndA==
X-Received: by 2002:a17:903:1c6:b0:196:2ade:6e21 with SMTP id e6-20020a17090301c600b001962ade6e21mr8730782plh.14.1677015332464;
        Tue, 21 Feb 2023 13:35:32 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dg56d59ey2wgev.ipv6.telus.net. [2001:56a:740f:7b00:548b:6839:29d0:4517])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b00199563fff0fsm6524217plm.190.2023.02.21.13.35.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Feb 2023 13:35:32 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org, vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [GSOC][PATCH v2 0/1] t4121: modernize test style
Date:   Tue, 21 Feb 2023 14:35:25 -0700
Message-Id: <20230221213526.85591-1-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <<20230220235121.34375-1-gvivan6@gmail.com>
References: <<20230220235121.34375-1-gvivan6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edited the commit message to add what the commit does and added a period at the end of the sentence.

Added a space after the closing bracket in the second test.

Vivan Garg (1):
  t4121: modernize test style

 t/t4121-apply-diffs.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  61f1ed51f4 ! 1:  77fded7759 t4121: modernize test style
    @@ Commit message
     
         Test scripts in file t4121-apply-diffs.sh are written in old style,
         where the test_expect_success command and test title are written on
    -    separate lines
    +    separate lines, therefore update the tests to adhere to the new
    +    style.
     
         Signed-off-by: Vivan Garg <gvivan6@gmail.com>
     
    @@ t/t4121-apply-diffs.sh: test_expect_success 'setup' \
     -	'check if contextually independent diffs for the same file apply' \
     -	'( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
     +test_expect_success 'check if contextually independent diffs for the same file apply' '
    -+	( git diff test~2 test~1 && git diff test~1 test~0 )| git apply
    ++	( git diff test~2 test~1 && git diff test~1 test~0 ) | git apply
     +'
      
      test_done
-- 
2.37.0 (Apple Git-136)

