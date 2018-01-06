Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4021E1F404
	for <e@80x24.org>; Sat,  6 Jan 2018 08:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeAFIVq (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 03:21:46 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36777 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbeAFIVp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 03:21:45 -0500
Received: by mail-wr0-f196.google.com with SMTP id b76so6169608wrd.3
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 00:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TtPUr4clrkMBKNvTvlQPzGMaCWlfmS42nnscjR7zXTA=;
        b=VwsSKb9xQVUVPOWe5ZI83qKnRexdZPo4qWS9m6fro6+oktH0CD5SJaXFxr92E02etl
         dEkh8BtyuLYkZ4IpdUNlZey2321bVOHBVAvFztvgZTMqw5JX2zEiwf77dBG/V5Q+69Jc
         jGjrttGLrgOAkO96f+zzqZ1qdqao47bQWGuvYhSu9JWj/V5U+ztEzNcqz3KXWBgnsG/F
         DYcfb0H2oVXSW1mMNutF3ntipuAwd8WdPrS4kEHWVJzkjwZhV1r0kDAl1OtP78ABBj3O
         XherbK01Sx/3BkgW2oRe2mxFVzogMhYbCv1UJYXpIMQV5tzPzH3+NTCZXgmDURei0x85
         94Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TtPUr4clrkMBKNvTvlQPzGMaCWlfmS42nnscjR7zXTA=;
        b=mLdDYzBU0AXZ0Ucwy4Lu8CwKvNBXe20oa4py9Hi1MVGfo52bJal3VsJA/8wiWz8hiQ
         JdmKEndshcu+kCnfCAlisn9fVQTo1jms/Uu7U6flVX+HPDAE9UiaVu/Y0o9ofO63Ge8W
         f04D8sUsDJFq0x9NZHNoY2ukGySRO+hRhjMO0xVaDxHcVGwaUF7Wjozkpp7Ljq6XYDHq
         5WDCxT1C8qJSid4+kDjOTttiR1OxFYzx6AyrXD8jB25yNV17iWkkDFHMRh/iSY+pCT1i
         gUnM9jfcouZjOEBkyOLFeH07AfgPoiGDnXgY9P+WOFKi2bkMZ288uI6cLUuO62zQprEl
         Oaow==
X-Gm-Message-State: AKGB3mK4mdHC/v+Hs/7ifLmDCKrmDBWLu5OaH9hcnOuY2XYKt9g5YIkr
        egWFnwabbxxjWjsK3c9gR7w=
X-Google-Smtp-Source: ACJfBos4bEg40d1wdtqnz6CGSa0raYjn4z6qGmjfcqU6C8d/y+eYTa76IgUXugCCSDbjZEuJ68EzXw==
X-Received: by 10.223.187.129 with SMTP id q1mr4661985wrg.252.1515226904274;
        Sat, 06 Jan 2018 00:21:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id q6sm6247025wrc.36.2018.01.06.00.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jan 2018 00:21:43 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
Date:   Sat,  6 Jan 2018 09:21:16 +0100
Message-Id: <20180106082116.11057-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1
In-Reply-To: <CAELBRWLyZ5s2Wvk2U5Ks2adx23Z+51dbEs3QbAq+5nGLe21srQ@mail.gmail.com>
References: <CAELBRWLyZ5s2Wvk2U5Ks2adx23Z+51dbEs3QbAq+5nGLe21srQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Fri, Jan 5, 2018 at 11:45 AM, Yasushi SHOJI <yasushi.shoji@gmail.com> wrote:
>> When does the list allowed to contain NULLs?

Short answer: there are no commits left to test.

The list is built in the for-loop in `find_bisection()`. So the
technical answer is: if all commits in the initial list `commit_list`
are UNINTERESTING (including if `commit_list` is empty to begin with).

It's also helpful to study where we should end up from there. We should
take the `if (!revs.commits)` branch in `bisect_next_all()`. That is, we
should print either "There are only 'skip'ped commits left to test. The
first bad commit could be any of:" or "<commit> was both good and bad".

>> Since nobody noticed it since 7c117184d7, it must be a rare case, right?

Right, you marked a commit both good and bad. That's probably not very
common. But it obviously happens. :-)

On 5 January 2018 at 06:28, Yasushi SHOJI <yasushi.shoji@gmail.com> wrote:
> OK, here is the step to reproduce on git.git

Thank you for providing a script for reproducing this. It helped me come
up with the attached patch. The patch is based on ma/bisect-leakfix,
which includes Ævar's patch.

I think this patch could be useful, either as a final "let's test
something previously non-tested; this would have caught the segfault",
or simply squashed into Ævar's patch as a "let's add a test that would
have caught this, and which also tests a previously non-tested code
path."

Thanks for digging and finding a reproduction recipe.

Martin

-- >8 --
Subject: [PATCH] bisect: add test for marking commit both good and bad

Since 670f5fe34f ([PATCH] Fix bisection terminating condition,
2005-08-30), we have noticed and complained when a commit was marked
both good and bad. But we had no tests for this behavior.

Test the behavior when we mark a commit first bad, then good, but also
when we are already in the bad state, where `git bisect skip` should
notice it.

This test would have caught the segfault which was recently fixed in
2e9fdc795c (bisect: fix a regression causing a segfault, 2018-01-03).

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 8c2c6eaef8..190f0ce0ab 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -894,4 +894,13 @@ test_expect_success 'bisect start takes options and revs in any order' '
 	test_cmp expected actual
 '
 
+test_expect_success 'marking commit both good and bad gets reported' '
+	git bisect reset &&
+	git bisect start HEAD &&
+	test_must_fail git bisect good HEAD >out &&
+	test_i18ngrep "both good and bad" out &&
+	test_must_fail git bisect skip >out &&
+	test_i18ngrep "both good and bad" out
+'
+
 test_done
-- 
2.16.0.rc1

