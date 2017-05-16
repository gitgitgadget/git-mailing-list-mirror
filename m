Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E097A1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 20:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbdEPUhY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 16:37:24 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34759 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753218AbdEPUhX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 16:37:23 -0400
Received: by mail-wr0-f193.google.com with SMTP id 6so15323871wrb.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrAV0IgR4ZL0nUvHFhdBYvCP+nDW/chuJ054XPVXvxg=;
        b=CY0g1AYaazkuc3hOsX+4ZNRcYzqVMUns/olXEm7kZoYEMV+zMJEYgPr5VK9Fp5eHma
         SzbVOH/PliU//3RUP0q2riVdh3bgiRihcRjbmIG06x04YKLG3oeDCY+N/qNti+JxLPkO
         /MysNjFMyyPGeq87W280EN4AYG1omuVCrF/4Ihtg7tMRlfrYwsbM+qcqKkV4O7pNstOH
         1Mq5DoIFq07vDp9o3zftjbNyMY/dcTiJoKJdJCW3pt68H2XCC62at18Xxekn50pRj39B
         SkBy8VAjIQJjJu0XyH0AolngsYRa5dTZWXKVJIhAEBrppsIQ7tgLrq9gSCa9l0LyRrpr
         1r0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrAV0IgR4ZL0nUvHFhdBYvCP+nDW/chuJ054XPVXvxg=;
        b=bwpaPc7ETZXRpLRGmNBmGOIjrOR3px2ehlOoNzym8iJqqNSlNgXWCBi56rlGhFJ6rq
         S5/q/5utqpUo0tna4wdc39bnmr36w4L1I9HQoxmkq/14lsKrUKWe69jBgHTblYChiLgO
         LIlHy2EDyTLDfnQSs6/7ZsiHOB82babaxMyqWD4ph5lSOVEs69kt0Yj06ZCoAO+r346p
         EKv+yyxq6LXfQ9WQO/de2o7IgFQkyL3mZA7xlvuaTWg036Aekv9VXIMyK+p/GfNughHK
         ULElSz59jxSR+BF9rV190j4jWrj0Vo5HgyHJKVO8ivPLbvy9GFex4DJdyTMVHFcHa+/Z
         Td1A==
X-Gm-Message-State: AODbwcCEH/U16frZVzij1Ued2WZBT6ITB1Ppjso71dnf/TQyiFusK1jN
        V8a1SbU5AQOUGA==
X-Received: by 10.223.139.25 with SMTP id n25mr8692247wra.17.1494967041791;
        Tue, 16 May 2017 13:37:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b201sm15134648wme.2.2017.05.16.13.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 13:37:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Joey Hess <id@joeyh.name>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: add an optional test to test git-annex
Date:   Tue, 16 May 2017 20:37:12 +0000
Message-Id: <20170516203712.15921-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net>
References: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an optional test to test git-annex. It's guarded by a new
EXTERNAL_TESTS environment variable. Running this test takes me 10
minutes.

As reported by Joey Hess in "reversion in GIT_COMMON_DIR refs path"[1]
commit f57f37e2e1 ("files-backend: remove the use of git_path()",
2017-03-26) first released as part of the 2.13.0 broke git-annex's
test suite.

This could have been spotted by us before the release by optionally
running the git-annex test suite as part of git itself. This optional
test does that. It currently fails due to the reported regression,
but, passes on the 2.12.0 release.

The git-annex revision to test can be specified with the
GIT_TEST_GIT_ANNEX_REVISION environment variable. Joey has expressed
interest in testing development versions of git against git-annex[2],
and can now test the latest revision with:

    EXTERNAL_TESTS=1 GIT_TEST_GIT_ANNEX_REVISION='@{u}' ./t9950-git-annex.sh

By default the test finds the latest git-annex release tag and tests
that, since the primary purpose is to test regressions in git which
cause git-annex to fail, not regressions in git-annex itself.

The t9* test namespace is currently full as documented in t/README. In
lie of an empty t9X for "external tools" this change claims t995* for
that purpose.

1. <20170516171028.5eagqr2sw5a2i77d@kitenet.net>
   (https://public-inbox.org/git/20170516175906.hdwn4x5md7dj7fo3@kitenet.net/T/)
2. http://git-annex.branchable.com/devblog/day_459__git_bug/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Tue, May 16, 2017 at 7:59 PM, Joey Hess <id@joeyh.name> wrote:
> Ævar Arnfjörð Bjarmason wrote:
>> On Tue, May 16, 2017 at 7:10 PM, Joey Hess <id@joeyh.name> wrote:
>> I have no idea what this bug is about, but side-question: It looks
>> like this is git-annex's own test suite that's failing with 2.13.0, is
>> that right?
>
> Yes indeed.
>
>> It would be very nice to have a test in git itself to test with
>> git-annex. I.e. some optional test that just pulls down the latest
>> git-annex release & runs its tests against the git we're building.
>>
>> Thanks for annex b.t.w., I use it a lot.
>
> If the git devs are ok with this, I certianly would be happy if such
> tests were run, at least occasionally, on the git side!

I for one would run this test occasionally, and perhaps we could even
run it as part of Travis eventually (although there would be a *lot*
of Haskell deps, on my box "apt build-dep git-annex" brought in 1/2 GB
of packages).

As noted in the commit message, once this is part of git.git you can
easily set an environment variable to test the bleeding edge of git
against any arbitrary git-annex version.

 t/t9950-git-annex.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 t/t9950-git-annex.sh

diff --git a/t/t9950-git-annex.sh b/t/t9950-git-annex.sh
new file mode 100755
index 0000000000..2cbc1f4be3
--- /dev/null
+++ b/t/t9950-git-annex.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='the git-annex test suite'
+. ./test-lib.sh
+
+if test -z "$EXTERNAL_TESTS"
+then
+	skip_all='skipping tests of external tools. EXTERNAL_TESTS not defined'
+	test_done
+fi
+
+if test -n "$NO_CURL"
+then
+	skip_all='skipping test, git built without http support'
+	test_done
+fi
+
+test_expect_success 'clone git-annex' '
+	git clone https://git.joeyh.name/git/git-annex.git
+'
+
+if test -n "$GIT_TEST_GIT_ANNEX_REVISION"
+then
+	test_expect_success "plan to test git-annex $GIT_TEST_GIT_ANNEX_REVISION" "
+		echo '$GIT_TEST_GIT_ANNEX_REVISION' >revision-to-test
+	"
+else
+	test_expect_success "plan to test git-annex's latest release tag" '
+		git -C git-annex tag --sort=version:refname -l "[0-9]*.[0-9]*" |
+			tail -n 1 >revision-to-test
+	'
+fi
+
+test_expect_success 'checkout $(cat revision-to-test) for testing' '
+	git -C git-annex checkout $(cat revision-to-test)
+'
+
+test_expect_success 'build git-annex (if this fails, you are likely missing its Haskell dependencies' '
+	(
+		cd git-annex &&
+		make
+	)
+'
+
+test_expect_success 'test git-annex' '
+	(
+		cd git-annex &&
+		make test
+	)
+'
+
+test_done
-- 
2.13.0.303.g4ebf302169

