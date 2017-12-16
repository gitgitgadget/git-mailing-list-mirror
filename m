Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C871F406
	for <e@80x24.org>; Sat, 16 Dec 2017 19:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756882AbdLPTwv (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 14:52:51 -0500
Received: from mout.web.de ([212.227.15.4]:60843 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756815AbdLPTwu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 14:52:50 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MASfy-1eKCuw2MBu-00BbFI; Sat, 16
 Dec 2017 20:52:48 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] check-non-portable-shell.pl: Quoted `wc -l` is not portable
Date:   Sat, 16 Dec 2017 20:52:46 +0100
Message-Id: <20171216195246.10445-1-tboegi@web.de>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d
In-Reply-To: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com>
References: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:GNRlxIaTDHknwxFVu2FeRA+sCbLcy6KIIdglFLmflJEv+gWwmVf
 GKn3LVRaG6OtRxUf4SWmTIERl8rJrY69nGu3BWg3MVtXSCVCAifEFaU1hzhBvhT2o+TiJbk
 klNbFCCGHhPjtfTrKCo4rvH06D1z4tS1A3YhoQaZ/UsUBuEUFFQuH6XQFMqjskwrJCe7yzw
 ug40uaNVrltufQALq0RxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:toyyfIE/EoM=:3AhPTylCDsyKwDK5H6Y6bN
 fe6opBYI0A2s75nHr2M1K6Oa7fFlI17RR/zRdSalBBdL0bVK7pjRMsAFq9XIaATX2M7hbVKZJ
 5lzamCKmq1GWGFhehuSKK5lWz7ohZAoVkmM8HdLTvE9Wq0egapJogaQV6EF5ozd+QmbTZmatm
 zZJzzBpGoU9WySGVMFYC+jlx6ATh/N96WePXW/FK9qnUEVJakNu9zuPvd8krIlYyyVQkXMQRZ
 H/YW3gx/VN2Et4Qqum4kzHmHfipnknq4gZSMWlJjrk6kgHemEyMB2fGfuFTzmM+HEWf5MLrjH
 gttxnJcH6b6asEkAO9Z+O92IWRRhGcs7P7tsvUrYVRETyemjaKb5YJzU44kfKnh0U9NWbcW44
 7mT5PUJj0QoY2H+5QwfE2EXr/XohgaXwNccRFFw7vLFFB1e7JdqRHpvjwkL0K+oX3yhK4vBXy
 pYEZ3cVQzrJvO3nwCfgjzgBi/RSr5gFBX+T5jytNQEmTHKTGX0A/mlp70nE/Xn4QstmxQazQs
 PZTTD7+3bG1U00iZXPjMTZsVaRnYYauudWBUEe3vA5vNN64ppUnryBN/bJifgECGcJGT/ia2l
 5X1iqoetaTLW0EcSgEWX1+/+P77HkmBffDMRz8jED9bbmX0XSBrzO/3jahIOhZlAKgoqIUbgs
 lPgEAFVafJ4pbQs8NGSkD6C01+VTOcG6kGPsBMFUm1LnLlQ/1TkQSgjZpruslgu8JDghGvBLv
 JhhYzy/KUyxda5BWhT2BQ9R7m1C1GBCSCVPZ9iS47tK1faGO71hkLHVlbvPCH3QFJbDCQF0EU
 eQwuYwcItKHJ3Pkgqd3rPpjdr1yyfpTEdk8tNNDnOoYMQK3KFQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

wc -l was used to count the number if lines in test scripts.
$ wc -l Makefile
gives a line like this:
105 Makefile
while Mac OS has 4 leading spaces:
     105 Makefile

And this means that shell expressions like
test "$(wc -l <expect)" = "4" don't work under Mac OS,

Commit fb3340a6 introduced test_line_count() as a portable solution.

Add a check in check-non-portable-shell.pl to find '"' between
`wc -l` and '=' and hint the user about test_line_count().

Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

I added Dscho as reviewer, thanks.
If there is anything more, please holler.

 t/check-non-portable-shell.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 03dc9d2852..fadbb1e5a7 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -21,6 +21,7 @@ while (<>) {
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
+	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable, please use test_line_count';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
 	# this resets our $. for each file
 	close ARGV if eof;
-- 
2.15.1.271.g1a4e40aa5d

