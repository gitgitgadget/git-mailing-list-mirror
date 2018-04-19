Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747EB1F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeDSIR5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:17:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:55893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbeDSIRz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:17:55 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTBfe-1f1tld2H4w-00S6w1; Thu, 19
 Apr 2018 10:17:47 +0200
Date:   Thu, 19 Apr 2018 10:17:31 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 1/7] replace: "libify" create_graft()
In-Reply-To: <cover.1524125760.git.johannes.schindelin@gmx.de>
Message-ID: <1f1c64314088383570dd2232e08a88c8df3298f5.1524125760.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hhOojvWpAIvhc71l6Q/h4TeaymTiQhbcMthnUX5Eqb26IyCIPxL
 IF3YBBHvBSdqF40PxmATHrm8c7DEm9W8tBNqT1RMH6c8UEBB8uyL1wRg4ODTQezgli1YUPm
 IgMP8c4voxx8fh+nbv3BBjXB8N8+iyrN/Hu38rzl1hydn0o1wpe578iXDjoicF3FqYtNY77
 SFQN8L7yMPSWrwQOfmEqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rQ9AsL14Mls=:0ISyQYU3P2MCVV/XQgNevk
 /I+UM5f37CmEOECwZIP8V6pYe33AoddFcMVAIG3DMlu+iTCwTBG+fvXQtXR93PNXQ+ZugfM4S
 iYZ3xLZIlEX+BxCkelonCBLITUD5HWyg8bONS1Ld9sGbTTp6z87iI59ZAAp8GnZP0Srvc9OCB
 Pm1c5qfMGrTqvVK3J5SPkSmwbhtYGsygLlkGC/m8MPhGDnOQ7pf2Vkj9oCb5UUo5hE8X7+cro
 3cQHsOkW2AidvJxfWdpGfknRnckDv/ndTPfRNNQxDgKImLKXDh29sqPqvyzDc8ecfQ0LDjQRg
 MKR9DZlfXlXsoABTqUXXomq+2lybPcB8LfOhqQ/PVa4qRkB4DE7yjoG1T2slHVuk42c1C07JF
 2gfiFb3bYGBOaEulbCC9rPHON8btAp7lnTaI8zmuR6SH1s6WrksDyl6vRhFJhQa0bzfHAlNmF
 3Nus1WpV7EGp8FgA2GExBdV3GxqQApu2eW7B+x2jrFmVxFV4WesufTQ83doVJbiCQmnWf9vib
 igNTzuhqX3AwvrDaMUNeFgDwFTzByKDeMqNn4Att2rCZlr7vNXEKxo2iu1riI972YDGfKjB1o
 9T1Du+sw9o/DRmsXbt+fddmqQFWriTODLFIhYoUPjnd5Nf9RjyL3pGsn/APtjtTF3NY4gwG6Q
 o7jleQcV/DvpBUxCi1O+oUPdXYd11C8gqHWRi9DJeljNx4tMZiIYYGCq/yP2R7goH3/mqYBLD
 tkCXr5UY+h+p61NmlN9tULqyC5ecHjzyjZslnfqNfpkhhdfU0tyHkTGjNg7w3KQn5gZuQAW1m
 MBsvWji7VfZ1Iv6BuPdSCNfgmc4XyFH+pNAJ/7apqOPz7nIW/8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is quite convenient to simply die() in builtins, in the absence of
proper exception handling, because it allows us to just go belly up
without having to implement error handling chains.

Of course, for reusable library functions, this is a big no-no, so we
(try to) restrict the usage of die() to one-shot commands, i.e. places
where we know that the caller does not want to, say, give the user a
useful high-level error message, i.e. a message that the function calling
die() could not possibly know.

The problem with this reasoning is that sooner or later, pretty much all
useful functions will *need* to be libified: the more useful a function,
the more likely it is to be called from a call chain where the outer
function implements a high-level operation that needs to provide
additional advice to the user in case of failure.

This is the case here: the create_graft() function is useful enough to be
called in a loop, say, in the upcoming patch to convert a graft file in
one fell swoop. Therefore, this function must not be allowed to die(), nor
any of its callees.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 935647be6bd..43264f0998e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -395,7 +395,9 @@ static int create_graft(int argc, const char **argv, int force)
 
 	if (get_oid(old_ref, &old_oid) < 0)
 		die(_("Not a valid object name: '%s'"), old_ref);
-	commit = lookup_commit_or_die(&old_oid, old_ref);
+	commit = lookup_commit_reference(&old_oid);
+	if (!commit)
+		return error(_("could not parse %s"), old_ref);
 
 	buffer = get_commit_buffer(commit, &size);
 	strbuf_add(&buf, buffer, size);
-- 
2.17.0.windows.1.4.g7e4058d72e3


