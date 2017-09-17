Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB02920A27
	for <e@80x24.org>; Sun, 17 Sep 2017 05:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750761AbdIQFnZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 01:43:25 -0400
Received: from mout.web.de ([212.227.15.4]:61567 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbdIQFnY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 01:43:24 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lb289-1d9hGz1aXZ-00kjYV; Sun, 17
 Sep 2017 07:43:20 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, benpeart@microsoft.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] test-lint: echo -e (or -E) is not portable
Date:   Sun, 17 Sep 2017 07:43:18 +0200
Message-Id: <20170917054318.28560-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <ce17a042-91e4-bf84-d9e6-36a9e99f3644@web.de>
References: <ce17a042-91e4-bf84-d9e6-36a9e99f3644@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:AFCNTXUkRde6l9mklVWT6RJyHn2sGWwK/ffI9uJ7VW3CRnpvWLH
 bnG4Tu6h1uFtOOMw314CTf23CWqDTwGcQf8S0dXQU3ue9JLwIggdehphuZiWyLIdvf1QDSL
 BrZYHc5HiMJk+LQnnwmcuFGUNeeXaS3URB4pRGBgqC27QQQtbdmUHrB8sJX9UXCRbGMEgc0
 E4eMRzOUqqAMCP5SqUkNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kK6F6V9EbeE=:YUyWSk9QF6Bn1XmsZRuFex
 THFN24KWDVlEPb4QIBu5RYFaSSk+By5AuyfBSTNqHNfs4FKRkCXJHe4QS2kHwCvpJO2a4PhOR
 SB0UpFqyBANiT6eLmiJMOb5hq6A3Zn4YOeYITHT7cym57Ii+WNNP95dAyvNajiUvbH7NrTwBp
 kUkImrwRAfJ3PySGfb6erpnDy5IT0rmd6ste/nwprf0a12gWfUhyhLOLcD0U5pESedVxJgahz
 s2cnc2wBVqF/FyFku08Iiczd3B0vOJRF4mCA048g0n5I8Pw6irOxhfUbuXCcjGr+FeeFdGAyU
 d9b+kD+nxWsL/w5IOPUbZ3fJ0ZVkZWf5+X9koAQ5ofrlxbX12hugydCwmUTxZJFAOnJle71bO
 XhMEiveD7O9rtGYbqXeBtSFjjXhNMrRxmTgf2BKoCojQEXnJYZxYefdUBGAlTYniyPsj9gfDm
 MWmkINo+25eBWaeA0LfC/UTUqjMyVCu1vMLWYIs9FOfiWoGGgrgjAU5UsfXf98K8jhgY9zXhl
 Ictd3szHBdg1u+mYnaSjuQh9ippJkGYkncRF8V4eSysp45MzXPK5Jx/J+dLSdoJjExZ/BOSUY
 GcP5oA18rzP77H0a3lzv5u+0CU6K/GzhN3Tad2SB4X5fkxwWlh2fnW58gyEqjj5FQvAg4nGfc
 K0tcQdS5HpHikLdRU6luZd0Kx5H5OSMdkj3uLG7+hox29rvOjtQaoAeESBEZoxWX2Bx96oKdL
 HD2lxp3jloy+5//EnWykEalsTk3bI2hEDqxE4yAIjrvJwicSPjtVbiBLEIIlHqaXKKmwn084i
 LprguGkLwQNy6ePIvVuMR4VnMXJ9gqwdRWnr8LHbPlY8JzIBMY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Some implementations of `echo` support the '-e' option to enable
backslash interpretation of the following string.
As an addition, they support '-E' to turn it off.

However, none of these are portable, POSIX doesn't even mention them,
and many implementations don't support them.

A check for '-n' is already done in check-non-portable-shell.pl,
extend it to cover '-n', '-e' or '-E-'

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b170cbc045..03dc9d2852 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -17,7 +17,7 @@ sub err {
 while (<>) {
 	chomp;
 	/\bsed\s+-i/ and err 'sed -i is not portable';
-	/\becho\s+-n/ and err 'echo -n is not portable (please use printf)';
+	/\becho\s+-[neE]/ and err 'echo with option is not portable (please use printf)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
-- 
2.14.1.145.gb3622a4ee9

