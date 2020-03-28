Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A37CC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 23:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34A72074F
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 23:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zc99xgaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgC1XtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 19:49:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56195 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1XtL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 19:49:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C34B9446D3;
        Sat, 28 Mar 2020 19:49:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sa5kVR9CdjbnvH+FXc3d3hxc830=; b=Zc99xg
        aRWXNNONuuCIzHUmHmKn3Qjj8xNXIvuWps0bSJJrxByJpz1qiirOCYuluxVdlrhZ
        kRvwa59qprRQy1cxeyDeh/nLFqYgR146wURcY6Kd6hkwV3mhnhy10cSNCGCKSNpf
        rkJJH1p7cDJk5hEfChLrBSQ+94irLoBkusuXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NK3OibCYsMpt83w8vpYla3DHn7w/rckZ
        Ya1bI6NWsBXFBH79T7Y0lKgeEo3gYwOs/vkH8vxutnSHpTVOo45Ul4iSlnIrK/aV
        IMExaTxj6cP1n6DEO4RmN0+Yis4cOfstNSZY7ThZk/AmZHCFZPojCxs1t/wukcuB
        wTmKvmGFfmQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAEB5446D2;
        Sat, 28 Mar 2020 19:49:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26CF9446D1;
        Sat, 28 Mar 2020 19:49:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH v2] t/README: suggest how to leave test early with failure
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
        <20200326083519.GD2200716@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
        <20200327091004.GA610157@coredump.intra.peff.net>
        <xmqqr1xdhev8.fsf@gitster.c.googlers.com>
        <20200328105418.GA639140@coredump.intra.peff.net>
Date:   Sat, 28 Mar 2020 16:49:07 -0700
In-Reply-To: <20200328105418.GA639140@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 28 Mar 2020 06:54:18 -0400")
Message-ID: <xmqqpncwca6k.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B71D32CA-714E-11EA-AFAF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over time, we added the support to our test framework to make it
easy to leave a test early with failure, but it was not clearly
documented in t/README to help developers writing new tests.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Trimmed the description quite a bit and dropped alternatives.

 t/README | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/README b/t/README
index 9afd61e3ca..0dca346950 100644
--- a/t/README
+++ b/t/README
@@ -550,6 +550,40 @@ Here are the "do's:"
    reports "ok" or "not ok" to the end user running the tests. Under
    --verbose, they are shown to help debug the tests.
 
+ - Be careful when you loop
+
+   You may need to verify multiple things in a loop, but the
+   following does not work correctly:
+
+	test_expect_success 'test three things' '
+	    for i in one two three
+	    do
+		test_something "$i"
+	    done &&
+	    test_something_else
+	'
+
+   Because the status of the loop itself is the exit status of the
+   test_something in the last round, the loop does not fail when
+   "test_something" for "one" or "two".  This is not what you want.
+
+   Instead, you can break out of the loop immediately when you see a
+   failure.  Because all test_expect_* snippets are executed inside
+   a function, "return 1" can be used to fail the test immediately
+   upon a failure:
+
+	test_expect_success 'test three things' '
+	    for i in one two three
+	    do
+		test_something "$i" || return 1
+	    done &&
+	    test_something_else
+	'
+
+   Note that we still &&-chain the loop to propagate failures from
+   earlier commands.
+
+
 And here are the "don'ts:"
 
  - Don't exit() within a <script> part.
-- 
2.26.0-103-g3bab5d5625

