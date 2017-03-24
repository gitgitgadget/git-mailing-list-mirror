Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A5F1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755015AbdCXXZR (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:25:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:61976 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754629AbdCXXZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:25:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsCAp-1cApE3400F-013xB0; Sat, 25
 Mar 2017 00:25:01 +0100
Date:   Sat, 25 Mar 2017 00:25:00 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] t0013: do not skip the entire file wholesale without
 DC_SHA1
In-Reply-To: <cover.1490397869.git.johannes.schindelin@gmx.de>
Message-ID: <1f26e0320db1182d68663812378937e438d5c887.1490397869.git.johannes.schindelin@gmx.de>
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FEvHydlWFgWM8UmoGpP3pqW9NalC9cG1eGL8c3OOWin3k7zxv9d
 O9p9S1eWPX5/dev2t5PerPPXe0nFnJdKyTIaR5e80EAxt547+Jg0JTMz3c5VPkltxPlKUt/
 nJexmOFRH/Csi66Y25b81gQF/ZFeGOebaWELIsDzTww0LOig+G4NhgjlJ9BNMpbYdsuq58Y
 09bkm3FjgmRsPfY9MwR9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cwVQPQz+07A=:KfbyC/cxW1EJeihBaRwlXb
 n+bywKv1KQaieXKrZb2P0NTm3NvgzDHmKWSkS/psmAXWmK/jVSUqKzolTX9Ib0Bn2wHXvSDF6
 Ib2eVUGV/zsyDBSefF4GwyguF5cpypQ38p69Bc/hSoyMTvqWO3WXWZ6w71GmW3rJuJM70baKx
 8prEXe6I887Pi4ezaul/BvxjiQa8O7ORyRyydCH7XTkrJe+0zj6EPlcDSVOJaV5h6TW0UfQ5q
 /7WfhdgHJIcf1+NUsuhwqEgUm4wjU/PEywEp4qN53S1okNeJ/j3bZQ8ioNqVI30urbByj7TP8
 D5T2zA7ggFiXrSeGg7HUzeqDcz4VAZk6eJ2GouE1ZVcaKGjrTgHKjHym/mw93w7fexh4yb3Aq
 qrJl5cHO9mKpqWty0K+5KUKarWEDsvjm0+Ut8bvRJ0W39O0FTOtkz4/NlMy1LQSVAZQcZ+DNB
 D/pcg9uBsyFssYLmTi6aYiYNu6OXejxUjRx18pkVgypgT5wBpBMhmpqh4aKAnhuW7SewAELhh
 OtjxgPgsUI3jXYVj8azGdk/BJTmN2YpVVW08LkYLO1+z/WgrB94I4s7bk8tg7RTGl+gVcn8H9
 woyVraIUwl56fmgiXRHN8MdpA1MNyKqkhlqBjUOxiNxwNBUne7AsUmvGi4+nCOVzENY/DgldL
 Eg1YtzIVpCFxxC6aQe51Zujv4m4hCoFZyZz0ypqpmUsed30UICyjubAGWkI5pTCVC7agPb81l
 g8ajf4dr5BZjjbusPRxDVL72BPks8XB+RiuCQantjLzCBn179IzCFNq0/Tc6/aEhFrFcXCONN
 V6mpQ6pkrxeb0SWcmBpaCOPVLIThw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far, there is only one test case in that script, and that case indeed
requires that the code was compiled with with the DC_SHA1 flag.

However, we are about to add another test case to verify that the
DC_AND_OPENSSL_SHA1 flag works correctly, too.

So let's refactor the code a little.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0013-sha1dc.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 6d655cb161b..435a96d6108 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -4,13 +4,9 @@ test_description='test sha1 collision detection'
 . ./test-lib.sh
 TEST_DATA="$TEST_DIRECTORY/t0013"
 
-if test -z "$DC_SHA1"
-then
-	skip_all='skipping sha1 collision tests, DC_SHA1 not set'
-	test_done
-fi
+test -z "$DC_SHA1" || test_set_prereq DC_SHA1
 
-test_expect_success 'test-sha1 detects shattered pdf' '
+test_expect_success DC_SHA1 'test-sha1 detects shattered pdf' '
 	test_must_fail test-sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
 	test_i18ngrep collision err &&
 	grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
-- 
2.12.1.windows.1


