Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3162020357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754523AbdGNOpR (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:45:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:58297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754516AbdGNOpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:45:16 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M82zV-1ds4xh2TQX-00vivU; Fri, 14
 Jul 2017 16:45:08 +0200
Date:   Fri, 14 Jul 2017 16:45:06 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v6 04/10] rebase -i: do not invent onelines when expanding/collapsing
 SHA-1s
In-Reply-To: <cover.1500043436.git.johannes.schindelin@gmx.de>
Message-ID: <4a5f540d4dcde47a7ba5e08b990de164cc0c52b2.1500043437.git.johannes.schindelin@gmx.de>
References: <cover.1500043436.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3jZ+xut6SRm2dOxo67msvxrStwXKM+qSGnFy9jc/X3q8P80P8DX
 X9LxtYSVR1G+3P9tRlnDENkdRyu42bhg3HbWnr3OwNhdqo7S3jwRaS7b0fWboIHR2tc/tva
 I9TIpnUqt3helvOVo8S0URfDTJOm0M4RLu7eYTRvu+07wbEYmNXKZp72NO/R/xRW0SImiZi
 CapTdG5phi3ZMlDgwQ6NQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X1CTGr/SNqI=:lRDB1oL8ItY+0b3OYhZKc/
 hOHTO2mV0+mLLGBqOpyY0wJz679cEY8gtWbGfFAeueEKTAaCOUYVwTZwt5+IqUlcfuEk62dXA
 JN3tCCl7+LWMjtkQYgoq5SopVt/n2sc6lE/TMo/iokYxU8mg2cyY5mLXVAiBtU4JNRa6zqDdO
 jzngvjLADLUPDv7PDw7cxsF0P3T7kD1fZnvEbXhE8aiOrp4JtTngYA1MkodnSSqW4Qci7b8gq
 MwS/aTlMx8oK4b0Z/Gmu0ZhxybEgurSzZEMNisz7esMJFIniQJTkadnCx1PAgF37zo4VuaGCc
 p+D5Ej4mk2ErHm5wvDwiTPmK7VpzItHKfZIVj6i1nxblmuj44lMPioJ/iaQ/60JxibNS17ZcF
 rLArv6FtPnmXyyo1eZ0ONpnoi2zIAH/3YLXaHaYTpbJb01InxmljN4vaFK2VeIokbue5rJb5h
 hAkYjFHdwPjAcCwxpFm4IC33vHYO6C3BQFMPgoKvWK1qvBzMOlXRsgXSDjKQLCZpWw6QaA/NJ
 9lMk2UnBlfAfvo4rI7SImY81gvMDpveGWHmKWyLc6eTmTEaUC1yMpZ9soBdFyGlLiGV8hWxxV
 NY+XgWMBnEk9eAHea6hCIl3JfuLYzfBkkTjx78IaLNQcCK4Tcf8bBOObOsorasORa9DEFxkJW
 dm12Rqeqyan6YOnyXYiTOWBGRESdNIrZOhdN2acspSAbA2Fs5OcYCCySYbSLRxXJIxiychUzA
 gxFqB2HDZdrALlB+sINByPgDUE7zdcI/8Ul5iSj/wb5uzIGo22+mpZtLWFRr+2zmWi92vVSoE
 7+u8JJID31KKFkBIszHgwLZFT8Ll7fEZV1rS22sT5M+WE7EAGs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid problems with short SHA-1s that become non-unique during the
rebase, we rewrite the todo script with short/long SHA-1s before and
after letting the user edit the script. Since SHA-1s are not intuitive
for humans, rebase -i also provides the onelines (commit message
subjects) in the script, purely for the user's convenience.

It is very possible to generate a todo script via different means than
rebase -i and then to let rebase -i run with it; In this case, these
onelines are not required.

And this is where the expand/collapse machinery has a bug: it *expects*
that oneline, and failing to find one reuses the previous SHA-1 as
"oneline".

It was most likely an oversight, and made implementation in the (quite
limiting) shell script language less convoluted. However, we are about
to reimplement performance-critical parts in C (and due to spawning a
git.exe process for every single line of the todo script, the
expansion/collapsing of the SHA-1s *is* performance-hampering on
Windows), therefore let's fix this bug to make cross-validation with the
C version of that functionality possible.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 93372c62b2e..9d65212b7f1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -760,7 +760,12 @@ transform_todo_ids () {
 			;;
 		*)
 			sha1=$(git rev-parse --verify --quiet "$@" ${rest%%[	 ]*}) &&
-			rest="$sha1 ${rest#*[	 ]}"
+			if test "a$rest" = "a${rest#*[	 ]}"
+			then
+				rest=$sha1
+			else
+				rest="$sha1 ${rest#*[	 ]}"
+			fi
 			;;
 		esac
 		printf '%s\n' "$command${rest:+ }$rest"
-- 
2.13.3.windows.1.13.gaf0c2223da0


