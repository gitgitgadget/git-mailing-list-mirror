Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F711F461
	for <e@80x24.org>; Tue,  3 Sep 2019 21:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfICVL2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 17:11:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58457 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICVL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 17:11:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A84B77FC7E;
        Tue,  3 Sep 2019 17:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=E
        nfFcgiGyf3yTfFsfBV6lGcF0/c=; b=XZWfVZmndDEetxMS8XKzo1+FxcYZz5AcA
        yzUbkQf0xueF/RvV7IgpwLOQZX4m2Y1SraPW7sGJ5lg5U3Dmv68hUoGtyA3MWrpA
        9Td+pta96xk1L9zre/8yV7z2rBht0QRkk46Nj7HySrw5bGruCPlf6K90Wz/Qqvxc
        nxJm2DZUYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=tkN
        1EvabZA8CW08DIhG6Gmq0PY02ZBU2Vjis7nrvNr31oCeB+ZDIoWRv1yLD7BX5BJF
        WTOOhnHPjsChEiy5+JRqmzXN926obzO8c7WojBGAYXQbNtFVlIQ2cRXMK5tPNwtB
        DTw6FI64S4pOnnizz7Saw44hXOCquQQnzohP2myM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F6177FC7D;
        Tue,  3 Sep 2019 17:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6B557FC7B;
        Tue,  3 Sep 2019 17:11:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] t: use LF variable defined in the test harness
Date:   Tue, 03 Sep 2019 14:11:22 -0700
Message-ID: <xmqqwoeprsp1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63024B10-CE8F-11E9-B73E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few test scripts assign a single LF to $LF, but that is already
given by test-lib.sh to everybody.

Remove the unnecessary reassignment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3404-rebase-interactive.sh | 2 --
 t/t4013-diff-various.sh       | 3 ---
 t/t5515-fetch-merge-logic.sh  | 3 ---
 3 files changed, 8 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 461dd539ff..31114d0bbb 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -155,8 +155,6 @@ test_expect_success 'rebase -x with empty command fails' '
 	test_i18ncmp expected actual
 '
 
-LF='
-'
 test_expect_success 'rebase -x with newline in command fails' '
 	test_when_finished "git rebase --abort ||:" &&
 	test_must_fail env git rebase -x "a${LF}b" @ 2>actual &&
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index a9054d2db1..5ac94b390d 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -7,9 +7,6 @@ test_description='Various diff formatting options'
 
 . ./test-lib.sh
 
-LF='
-'
-
 test_expect_success setup '
 
 	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index e55d8474ef..961eb35c99 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -12,9 +12,6 @@ GIT_TEST_PROTOCOL_VERSION=
 
 . ./test-lib.sh
 
-LF='
-'
-
 test_expect_success setup '
 	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:00:00 +0000" &&
