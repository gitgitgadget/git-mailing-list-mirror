Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB40C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 04:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D88613AE
	for <git@archiver.kernel.org>; Mon,  3 May 2021 04:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhECELw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 00:11:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58092 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhECELv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 00:11:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14139C3721;
        Mon,  3 May 2021 00:10:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
        ZkbUhF0AP2H18F5S+6CBxwBvF9V0FpjoKSz+/mWHOM=; b=YzjselXk/txkk+5PZ
        c/wvOZb+FbVHfsJk9z7bSwFKZY/+BgzpDzkru9rxgCmjbvHzHlGU21Rb0aBKDsed
        Qfrxj91zTnxBSVeCnowi/5WcDVLEkVDHH8rU5sOVAV6fbFMSrE1aTLmngRxspGOm
        Wd+foTi8DGIzGHf2udOZoflLpg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0ABC4C371F;
        Mon,  3 May 2021 00:10:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DA4FC371E;
        Mon,  3 May 2021 00:10:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] CodingGuidelines: explicitly allow "local" for test scripts
Date:   Mon, 03 May 2021 13:10:58 +0900
Message-ID: <xmqqfsz4a23x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 907D27B2-ABC5-11EB-9876-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

01d3a526 (t0000: check whether the shell supports the "local"
keyword, 2017-10-26) raised a test balloon to see if those who build
and test Git use a platform without a shell that lacks support for
the "local" keyword.  After two years, 7f0b5908 (t0000: reword
comments for "local" test, 2019-08-08) documented that "local"
keyword, even though is outside POSIX, is allowed in our test
scripts.

Let's write it in the CodingGuidelines, too.  It might be tempting
to allow it in scripted Porcelains (we have avoided getting them
contaminiated by "local" so far), but they are on their way out and
getting rewritten in C.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 45465bc0c9..ea70676a30 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -175,6 +175,11 @@ For shell scripts specifically (not exhaustive):
 
    does not have such a problem.
 
+ - Even though "local" is not part of POSIX, we make heavy use of it
+   in our test suite.  We do not use it in scripted Porcelains, and
+   hopefully nobody starts using "local" before they are reimplemented
+   in C ;-)
+
 
 For C programs:
 
