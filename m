Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443F91F424
	for <e@80x24.org>; Sat, 21 Apr 2018 07:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeDUHfX (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 03:35:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:48521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbeDUHfW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 03:35:22 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC7em-1fIYTe0OBM-008slC; Sat, 21
 Apr 2018 09:35:18 +0200
Date:   Sat, 21 Apr 2018 09:35:02 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 1/4] rebase -i: demonstrate bugs with fixup!/squash! commit
 messages
In-Reply-To: <cover.1524296064.git.johannes.schindelin@gmx.de>
Message-ID: <a0ed6c98095b73e5c2475de3a3526c93f1967b94.1524296064.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524296064.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VgMHFIKl4Eq+Hc47Do9EzXoqK74xLYhmhvdd3XeRc0KOtXR0G78
 u3ipWcTa+Gi6nYam+ttpKc5bc3amwttlZRZzE/CTFUVjKttfyWOC4FWcv9Ct1SzKAK/8co/
 QEOIhFr0y0pwXQaL5pHLDBv1HKRjiDnkSq50Lqi92QP+EjLAXI/KxTtF9SRIfOzY1VL1moy
 lb39VzNNfbpdmMwmSGTNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QJD3i5qlglc=:YarZ3raHIIDa5U1IptKEqB
 Lna1i61ozH44f1ULpLzBKCnC9EBC+iiHdBsO21YPh/5W4Wzq6G36Cruo3ZL/P2tkSXrlBkNZS
 GgPqBAvBPiK+SS7ISLJ/gYXQbL3TXFZ9TAYFIYyA8XHLYX96cpMiZ3VbAmti+ITJc6stXCgGk
 IFxjWwk/6jHqyI1O0r7RS5uJ0LBEJQdZaw6xdeChd4RSI3hMSDCmCZPiiBvEfPkMf9J+Ws8j6
 IIKJiK5b95RCanH2qelWTCjE3aT77Wn7apGb+/HWJEsfLkr5IulT3xCbjf8Kd34JnJb7U468n
 WBqYRXDH7vLJKaWSDMK8mRwv7zZTWKKXd71FO7ijcZPGvnSsvQlXTZfeLXqC+ahTqgouehXXY
 zW7KcddHUtWBLnq1i8Bby/7Hf9lR7jdCaYC2zqPxL0Iv7dw7M5ZrEhrItzp+yyTsdzJGc51q1
 rikCivS89hs1uaG9VuGuAQMejiX9Oof8gj/wkz6jLSazHB7z98nUEA1wc/5uQ0qBnfiI0gmpz
 +gqRBXVidlF56inwGDLieLNOU5vbLrIYVrzJ49wQTa07MwxRcq/hRjkl5f2U+hvdd9tvhFfpJ
 cN1ZM+Tk4XEKJirRX7bLvqLQ0COpswPuGXeZp8hbPd1LvCNSZsjpKALkTrVjIZzWReRQu6XYx
 xlyu17rmHI8pbcpbYxpiN2UQAiKz35a0Bo2O8ndfpM8lpLs062mTQ8cODi97yOLet+CQNRDV+
 klRzpNbZqrVWqW0kDFfwkxAqsBA5Ecnv9aaEqLJA6PWFfd/dtVFr/i8DYc/CmOpj9lto2MBXi
 dvzm/HU0ITTEDIaRvQBuBUh5w2hm4cX0AkYLy18PboP+xbavtU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When multiple fixup/squash commands are processed and the last one
causes merge conflicts and is skipped, we leave the "This is a
combination of ..." comments in the commit message.

Noticed by Eric Sunshine.

This regression test also demonstrates that we rely on the localized
version of

	# This is a combination of <number> commits

to contain the <number> in ASCII, which breaks under GETTEXT_POISON.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3418-rebase-continue.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 9214d0bb511..6ddf952b7b9 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -88,6 +88,28 @@ test_expect_success 'rebase passes merge strategy options correctly' '
 	git rebase --continue
 '
 
+test_expect_failure '--skip after failed fixup cleans commit message' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout -b with-conflicting-fixup &&
+	test_commit wants-fixup &&
+	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
+	test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
+	test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
+	test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
+		git rebase -i HEAD~4 &&
+
+	: now there is a conflict, and comments in the commit message &&
+	git show HEAD >out &&
+	test_i18ngrep "This is a combination of" out &&
+
+	: skip and continue &&
+	git rebase --skip &&
+
+	: now the comments in the commit message should have been cleaned up &&
+	git show HEAD >out &&
+	test_i18ngrep ! "This is a combination of" out
+'
+
 test_expect_success 'setup rerere database' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-- 
2.17.0.windows.1.15.gaa56ade3205


