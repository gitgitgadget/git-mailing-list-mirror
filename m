Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22372EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 12:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGUMmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjGUMm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 08:42:27 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39E430ED
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689943326; x=1690548126; i=l.s.r@web.de;
 bh=sRATAvauQjX9Gjvtses1t29OZ+LxnagDMEvNfWHNkdM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=pwYg/rXueIYYvM3AeAiRSbDR5YHf0YcluC71TbWA7rWyTccJRxhYJ+3FpPCbUIeJeuTGeEn
 zRLC9IR9vGMUWlXphBAl61sX+vV9AMz8QLEAWinS+nP/P/lwvnHTNUAYkmm3Kzwu+MvOPDJpF
 L5msPdNuyQFPt5WI3h7ncgHMhR94QzlhIgATPCtcF8Auj+flc6+sSuT2HlvrXq3UXA1si66IL
 N8Rst+xV5tWKsohtm84Y0hRb/tLnGNG2RGuKZwHE32hnN7abe3yZODKuXL+qSNtm1QuYknWJm
 npRtKHlqmZF0B6qgS4L/g88jnkIDLAWVPxdF5CdyAoVxiXjjoMwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwR05-1q6fYB1fbp-00s2R2; Fri, 21
 Jul 2023 14:42:06 +0200
Message-ID: <3fc80266-3fc3-32f7-a918-3f7a854dfdb9@web.de>
Date:   Fri, 21 Jul 2023 14:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH] am: unify definition of --keep-cr and --no-keep-cr
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7k9fa5x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:chA7ypmofMpLy1QjfWEWfk9jQhCXT6iFFNsxjk3oly/mavc275T
 /LpO+b/bruTpulHszS4XvD7ao+DuRTDX22nrzulriXsRysQKArNOTbkf8HtbEUIfHDGgnuM
 dM1f5qIicCNpeLDGtZlR29M/O+yoe8it8NeEo113593k7QRf3eFJfZW7wX/iT2bRCYHHSSb
 +c7NOsNdfVgVz355Q7nqA==
UI-OutboundReport: notjunk:1;M01:P0:FZMMxN4/340=;rLNr1+Jmbac/tjTj8tqJmrVqjIM
 Y8WEG0houIowE1ZwEoZuKfxlcPyAUVHQeUy0VWEfYuEC5ZdTuYlWXDvDRoJpt5lIn+fsch3mS
 LDyZTJ4mPDpG706oxdzxAfjRy+0PmHcPXfgkVFhWB/EY175HtLFYwwPsJPA9i0uBYGQNACL15
 q5q3Z/CaIV8vlj1nZh3xucbJ1l8bK9YET0ehYM/6yjlDYd53+oCZNFphFGFfKsKt6YVg59ihX
 OJXoH18+E8zZtRPV9fzMSdFS2N11BVuzJ9+MvAhULtottrzQPqZKWj0bERsg+Y18bj2NodhQB
 cZnhTOvLNd1xEqBNCPSL9oja9wjjSac6memPEsli8b18GaAhk0WTj1oJaTjraoHBxZpsAmXd2
 8V9KQpOgZPr/QnQiZ6n9lothR+O+GH5AJ423h7IgTCcFpg5p0a8Cane2HK632Axd5gRB/+IdM
 CoztoQnJlnhKCrLKOoiWpOkQj9CeMuM/7UUfYCazv9UzCZrzLq5LrGsTE/ZVO2myRkrrTzT44
 QFkXj+FeAM6b87YJyv7BRnroKFvPVVu23nqrnlJFfp9WAekP1A5VAPG5VXr7dAz7jhFL+/RmD
 DILdNogAiReaVxsCxZkJ1mq3Ew3qLX7P7bOkntUbjd8kT9QkT60TJ63yGn7lDlZJRXAQxPogQ
 iISYY6L3NUa/ebn84dC2oaYqIdVHQJZOkiCVU5polf5gtPbxUOKjz8I+BmC+4bVxKvrSObP3g
 E4nN3Pzf0Q/nKpX0IXxV9+shEDmsJCHTSPclmrF79bXqvE0UvkBPutT2ASH+KR88s8yEtObRi
 hmHMXCA5oShs6TeIIEXheSmNdGCgczszCdCKZ1L3M0UorbLELOz2+ATSxi11GswFx+oB6mkXD
 Ap9XAgTmzeOlWiGNSECxZJIDzmQs87Jtv9627HdPXxJO2fez97eJR7vkIJCyo9CbL9HFIqkla
 EAlEQA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The options --keep-cr and --no-keep-cr set the variable keep_cr to 1 and
0, respectively.  We don't usually define the negative variant
explicitly.  The extra help text only tells users that the option
overrules the config option am.keepcr, which conforms to convention.

So allow --keep-cr to be negated and drop the now redundant definition
of --no-keep-cr for consistency.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/am.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index dcb89439b1..a216024e1d 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -2347,12 +2347,9 @@ int cmd_am(int argc, const char **argv, const char =
*prefix)
 			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
 		OPT_BOOL('m', "message-id", &state.message_id,
 			N_("pass -m flag to git-mailinfo")),
-		OPT_SET_INT_F(0, "keep-cr", &keep_cr,
+		OPT_SET_INT(0, "keep-cr", &keep_cr,
 			N_("pass --keep-cr flag to git-mailsplit for mbox format"),
-			1, PARSE_OPT_NONEG),
-		OPT_SET_INT_F(0, "no-keep-cr", &keep_cr,
-			N_("do not pass --keep-cr flag to git-mailsplit independent of am.keep=
cr"),
-			0, PARSE_OPT_NONEG),
+			1),
 		OPT_BOOL('c', "scissors", &state.scissors,
 			N_("strip everything before a scissors line")),
 		OPT_CALLBACK_F(0, "quoted-cr", &state.quoted_cr, N_("action"),
=2D-
2.41.0
