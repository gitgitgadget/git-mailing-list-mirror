Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362E9C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F162071E
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 21:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfKZVu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:50:57 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:49587 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfKZVu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 16:50:57 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47MyJY6Dczz1qqkp;
        Tue, 26 Nov 2019 22:50:53 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47MyJY3vSKz1qql2;
        Tue, 26 Nov 2019 22:50:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id kbXd7FIQN-m0; Tue, 26 Nov 2019 22:50:52 +0100 (CET)
X-Auth-Info: yrPTK5vu2MvYkqjREcNpl6qCWdgvcR7TEI5r0GsDEeEV3Na9BNie2rN+LFM2Qr+q
Received: from igel.home (ppp-46-244-161-164.dynamic.mnet-online.de [46.244.161.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 26 Nov 2019 22:50:52 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id B0ECF2C01AC; Tue, 26 Nov 2019 22:50:51 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t7812: add missing redirects
References: <20190724151415.3698-1-avarab@gmail.com>
        <20190726150818.6373-7-avarab@gmail.com>
X-Yow:  Wow!  Look!!  A stray meatball!!  Let's interview it!
Date:   Tue, 26 Nov 2019 22:50:51 +0100
In-Reply-To: <20190726150818.6373-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 Jul 2019 17:08:16 +0200")
Message-ID: <87blsyl32c.fsf_-_@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two tests in t7812 were missing redirects, failing to actually test the
produced output.

Fixes: 8a5999838e ("grep: stess test PCRE v2 on invalid UTF-8 data")
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 t/t7812-grep-icase-non-ascii.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 531eb59d57..c4528432e5 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -70,14 +70,14 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep ASCII from invalid UT
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data' '
 	git grep -h "æ" invalid-0x80 >actual &&
 	test_cmp expected actual &&
-	git grep -h "(*NO_JIT)æ" invalid-0x80 &&
+	git grep -h "(*NO_JIT)æ" invalid-0x80 >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' '
 	test_might_fail git grep -hi "Æ" invalid-0x80 >actual &&
 	test_cmp expected actual &&
-	test_must_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 &&
+	test_must_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 >actual &&
 	test_cmp expected actual
 '
 
-- 
2.24.0


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
