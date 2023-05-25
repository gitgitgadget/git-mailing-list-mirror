Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8185C77B73
	for <git@archiver.kernel.org>; Thu, 25 May 2023 03:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjEYDMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 23:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYDMg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 23:12:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A6BBF
        for <git@vger.kernel.org>; Wed, 24 May 2023 20:12:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E993182C9;
        Wed, 24 May 2023 23:12:35 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=lIrI80v/Nys+/6wg8MvHzQtUuiVPQQR1/13dX/JmgZQ=; b=HGOF
        QDOVihaZE5MalWIt0F+ggbsB42vHGErf1CZpfy4ugnxXzPCsMF30M3MM2bwm4n5e
        s8CZd6pmtIJv5ucGKFTTdc/kvhKIQVj8PLawAIl8zrmAcChbfldwh6cyIHD6cucx
        tHtvLa0RRCzIBQfC3+XKYuMcgu4ng9POiII+NUk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4875D182C8;
        Wed, 24 May 2023 23:12:35 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 29277182C7;
        Wed, 24 May 2023 23:12:31 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <jeffhost@microsoft.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>
Subject: [PATCH] trace2 tests: fix PTHREADS prereq
Date:   Wed, 24 May 2023 23:12:07 -0400
Message-ID: <20230525031218.3554586-1-tmz@pobox.com>
X-Mailer: git-send-email 2.41.0.rc2
MIME-Version: 1.0
X-Pobox-Relay-ID: FCCBF5DA-FAA9-11ED-BEEA-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prereq guard added in 14903c8e92 (trace2 tests: guard pthread test
with "PTHREAD", 2022-11-24) lacks the S in PTHREADS, causing it to never
be satisfied.  Fix the spelling of the prereq.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/t0211-trace2-perf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index b4e9135118..cfba686132 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -203,7 +203,7 @@ test_expect_success 'stopwatch timer test/test1' '
 	have_timer_event "main" "timer" "test" "test1" 5 actual
 '
=20
-test_expect_success PTHREAD 'stopwatch timer test/test2' '
+test_expect_success PTHREADS 'stopwatch timer test/test2' '
 	test_when_finished "rm trace.perf actual" &&
 	test_config_global trace2.perfBrief 1 &&
 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
@@ -249,7 +249,7 @@ test_expect_success 'global counter test/test1' '
 	have_counter_event "main" "counter" "test" "test1" 15 actual
 '
=20
-test_expect_success PTHREAD 'global counter test/test2' '
+test_expect_success PTHREADS 'global counter test/test2' '
 	test_when_finished "rm trace.perf actual" &&
 	test_config_global trace2.perfBrief 1 &&
 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
