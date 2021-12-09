Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B73EC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 04:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhLIEQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 23:16:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55744 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhLIEQP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 23:16:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B725B161F3D;
        Wed,  8 Dec 2021 23:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=8/j1vaJHZBS/IQln/jrFx/DVKP+hwDKHb8KEXvGXNg4=; b=TcY6
        jv7BKL7SYzgK7VASMEUE5kp/9xRpsU1WPc+Hl3bm/v0wUKXlgMeBSD0B94yGxjsD
        t2eNkmCwRgq81ja0DEj3ncW0WB9DQ5ndVi8Epvb9XI2pMFWmheBP7Ct7sCREnZCb
        0qnepxDen6rADPe7aHTjk7AdNSofK7CN1X5E3g0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFDBC161F3C;
        Wed,  8 Dec 2021 23:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8BC0161F3B;
        Wed,  8 Dec 2021 23:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] fixup! add -i: default to the built-in implementation
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
        <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 20:12:37 -0800
Message-ID: <xmqqwnketo0a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F139DDC-58A6-11EC-A416-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the reimplementated "git add -i", two test pieces that used to
expect failure now succeed.  Mark them as such.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Yes, I know this is on hold until some issues in the "add -i"
   reimplementation on MacOS are resolved, but as I am getting tired
   of seeing "TODO PASSED" when I rebuild and test 'seen', I'll
   queue this band-aid at the tip of this topic.

 t/t3701-add-interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 207714655f..1effc3f419 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -500,7 +500,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	! grep "^+15" actual
 '
 
-test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
+test_expect_success 'split hunk "add -p (no, yes, edit)"' '
 	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
 	git reset &&
 	# test sequence is s(plit), n(o), y(es), e(dit)
@@ -524,7 +524,7 @@ test_expect_success 'split hunk with incomplete line at end' '
 	test_must_fail git grep --cached before
 '
 
-test_expect_failure 'edit, adding lines to the first hunk' '
+test_expect_success 'edit, adding lines to the first hunk' '
 	test_write_lines 10 11 20 30 40 50 51 60 >test &&
 	git reset &&
 	tr _ " " >patch <<-EOF &&
-- 
2.34.1-373-gb739cc97c5

