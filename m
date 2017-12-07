Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351A020954
	for <e@80x24.org>; Thu,  7 Dec 2017 17:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757025AbdLGRaj (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 12:30:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59386 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753062AbdLGRah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 12:30:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35636C14FD;
        Thu,  7 Dec 2017 12:30:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=XlFx
        QXjNh00mQYE+V0dDS2gYsuU=; b=CEt8BAHHSnFj3/Gk6mpqC8kcZqsWYF9XhO8q
        xPkMOzdQ1x6mQKClu9haLhrMETgRh4i1WstEO1mudcmqsbcNrVfumNGEDsgqx0Ba
        BDusUNc433kq75NQFzYpDY3GmFn0uFkVamgPCVfnfZEabriic0ewDUKgbONz1hA1
        h01OcBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        WW8X90Mf2IGHmw1etbOkXmFKtRLTbPEuHcfu8Gcx2OGmxjtGqGFYUOnGoJr2E9ew
        hL+jhjuJJc4Q6Q97mF2FnHL9tKNgHMJnxIHo4r0siartwFOXRmIXyOUAhiXXlQW5
        RqyLamJgsrB31YPapc3iqLM3g7QSlM8QwqZV6sH4XFM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C738C14FC;
        Thu,  7 Dec 2017 12:30:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95710C14FB;
        Thu,  7 Dec 2017 12:30:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, jacob.e.keller@intel.com
Subject: [PATCH v2 0/7] reroll of cc/skip-to-optional-val
Date:   Thu,  7 Dec 2017 09:30:31 -0800
Message-Id: <20171207173034.12865-1-gitster@pobox.com>
X-Mailer: git-send-email 2.15.1-480-gbc5668f98a
In-Reply-To: <20171207003517.11729-1-jacob.e.keller@intel.com>
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
X-Pobox-Relay-ID: 558FF618-DB74-11E7-BF6D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm sending out only the last three parts, as the changes necessary
to 03/07 that incorrectly used the variant without _default() to
overwrite options->prefix should be trivally obvious.

05/07 uses the _default() variant so that the caller can react
differently to "--relative" from "--relative=" correctly.

06/07 is an update to t4045, so that the change made in 07/07
becomes readable.

07/07 updates the test to verify the change in 05/07.  I just made
sure that these tests catch it if we deliberately reintroduce the
broken version from Christian's series on top.

Junio C Hamano (3):
  diff: use skip-to-optional-val in parsing --relative
  t4045: reindent to make helpers readable
  t4045: test 'diff --relative' for real

 builtin/index-pack.c     |  11 ++---
 diff.c                   |  50 +++++++--------------
 git-compat-util.h        |  23 ++++++++++
 strbuf.c                 |  20 +++++++++
 t/t4045-diff-relative.sh | 111 ++++++++++++++++++++++++++++-------------------
 5 files changed, 128 insertions(+), 87 deletions(-)

-- 
2.15.1-480-gbc5668f98a

