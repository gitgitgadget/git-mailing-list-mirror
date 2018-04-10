Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6E21F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeDJM3r (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:29:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:33031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752669AbeDJM3n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:29:43 -0400
Received: from minint-aivcfq2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MfVU3-1erNYR0upX-00P8Dm; Tue, 10 Apr 2018 14:29:36 +0200
Date:   Tue, 10 Apr 2018 14:29:35 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 02/15] sequencer: make rearrange_squash() a bit more
 obvious
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <824260f7d71ab2fcc29e4f067092e8d1acbfd33a.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8lp0br5JMZV5U16KoWTFZR1goioJL7LDO0mqzYpbZiiwYRWcxWs
 RnQSUFNq2Drr4j8Dat4/y121a0SjEZ48yoUs2xh6y5sD2Rw6Be5pIoBLOd9URB1Bpr0MUn2
 F0SdlKBm52GJ4vf+LwbSxQ1WDrL17i7+ZD3iWgS4t6c+Ngw+MdkjEfxX2Rkmd2dvY+QzQtc
 Jv1wnP+cSgwcHoMsRU7VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iL8XQZglMgs=:YOlyOvfD063W2ja48PyJVD
 2tLbCqJaMW0siKAmmgkE1ImrNt7C5H5+ceJGgRVpP1rKFc5po2Q6vLhOhTfTqIiU9i9kNTr7e
 IIKI+8xsfTP4fKbr6yJS3yx1H07or/aeiHHxOMJ3Jok1cJLVHdT6VF3VjrzLruvLWr0FL75uR
 ZXdldn9Vb3eWxMEKiyowveI0/SO9kUHVz8f5KSn6duaErFvSQ9zliqVXEH74l+8yU04YeOffl
 hv52AZNqb25Dhs1ZDEDpNVye5yPAxQMpx3UCThMl/TQBQnph6VqoFEu94Vcqant1Tss7rk6yn
 9nNrAFlDaM48wP4b0FpieIlqa7mM0gRIMPQVlb9gZSo661uFFI13hyGMoEqz5wubbF0TBLSbN
 oIyWP0l8FwmMNZ5GbzA7td7kqADhgGGWnTOKQQohE+NIHC0AvX2xqSrpuUN+n9vw44G4p+G8U
 pv1AMFOFBlwZDDHio5Q+r7ln4HxlddjsZH6SZZ1S+BOwTV2ymzg6/lGbdJ+0CHe29oSPpnZ5V
 A6FY8diLNS7nKFup8FD3zn6RCXwAW/MmqUe8LjyrfvL9s+dIpkNSWoRnx455uA00d+gUxdELi
 n/WS7RZhkvARoti9kvLhL/yaucmz5eIUzQW7TonQ1t6NHtALhr4JYmtka5la8Xg+SXg+kQF53
 kMXt+d8HILHOubkeg1q4sfhg5F0gowktZ1HmfeFCA/gIafdLDCAoreoUTavZQw/Kqq/hI1LNV
 8Kqdd2thBrqEHXeWmHOYPyq6Lq3weG7VBEsAOdoJ70RGMbpiSQFfS7fTSC5Em0YQZaNhp5VYQ
 PQoiFb6MALiSnem0bE9sMEJAAva6Y4oxMjiFKHNoZLN08QV5M0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some commands that have to be skipped from rearranging by virtue
of not handling any commits.

However, the logic was not quite obvious: it skipped commands based on
their position in the enum todo_command.

Instead, let's make it explicit that we skip all commands that do not
handle any commit. With one exception: the `drop` command, because it,
well, drops the commit and is therefore not eligible to rearranging.

Note: this is a bit academic at the moment because the only time we call
`rearrange_squash()` is directly after generating the todo list, when we
have nothing but `pick` commands anyway.

However, the upcoming `merge` command *will* want to be handled by that
function, and it *can* handle commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 096e6d241e0..1ee70d843c1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3393,7 +3393,7 @@ int rearrange_squash(void)
 		struct subject2item_entry *entry;
 
 		next[i] = tail[i] = -1;
-		if (item->command >= TODO_EXEC) {
+		if (!item->commit || item->command == TODO_DROP) {
 			subjects[i] = NULL;
 			continue;
 		}
-- 
2.17.0.windows.1.4.g7e4058d72e3


