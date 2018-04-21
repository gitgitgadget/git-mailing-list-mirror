Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EDC1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeDUKax (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:30:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:54921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbeDUKaw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:30:52 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyR1G-1eODDe1Upi-015rKc; Sat, 21
 Apr 2018 12:30:44 +0200
Date:   Sat, 21 Apr 2018 12:30:28 +0200 (DST)
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
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v8 02/16] sequencer: make rearrange_squash() a bit more
 obvious
In-Reply-To: <cover.1524306546.git.johannes.schindelin@gmx.de>
Message-ID: <1bea3d4cd72e8631780bb460148ad94636427744.1524306546.git.johannes.schindelin@gmx.de>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TNtVVqSYkKIn+FS9BtJZlcLPRwwKRbxRp35nLs6Gh/Ym+JhA2PM
 O1O2Db2RGycDVHRiw4Bkc4oI28gllocoAT2t3UmzqqVKrEehTrM78QdW1Ze6wwNAgkUKFqb
 Z53v3bFAbCLrYj+1tpxFbocl329+2dXWO+DKFDXha1BGUA/oT1Gqox4DpQxT/uZVmN/2NJ6
 OV+X3qxyYP2kBqODHJMPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:756ccLOJKyw=:QxATLJFkxUhi6ll5RFQoAm
 N/BWOc6UNzRbnvhkUdhdRoOwKzdcHnYG3eOW7EZgAGIqpuIZSw16tKWTqUoPcaG6SbhS1XmCJ
 k3Y7c75weCZ0BrRzmuhIFsblUVC1GmA52Fv/sPulOBK/aJ98UcFAumtlKkEsJP+83DtQp9ReG
 DAUqyv7VuXlMs5vhBQPVkY5Zt1aHkPcVJxMVitnJDIDZVpvFYsauRq159eyQZSeVTUa72NoQF
 PlpxmtzZM/nWYNyenDp84CvwHBUn7u9iTM5LfApZSHqew1p23A13I+H0YH4IDaS61GYyeJ7ny
 nT7vN5eMRFk6FLdFJrSznz2KLtGQ2KWrmCn2aqeBD1f8lQp4mODXMHKLhRPUOM5Ttz8rCJUjH
 L68Ii0v5/flZI4MlRKdkCPCQ4Z7Uj8+Ekm46Oyxi95Xe6kFfXfFHQac0bSsmWlxoHC6Xd4N/N
 ydqROF1hXwhpLxJyL+pUDJQS25D5wqWXTYqH8L/T/8tSkyi8ZzEQtr7cv1WxoNvgP0adfHsQw
 vHrT7Rx6BUVbu42XZaa8CMcEMYRXKJz98O41fPf/QSMrp9TuybQBPU1vEGMYMRhLmbs1dpyKJ
 6B1jc/F2Lju0oqdKjAWsRwPhQp01J8kOhnu0/Px4Oa2rEGv3LxgqwhtemUog9oVFwAKHq8tsf
 ggcof9k+RbFQxafBbYSi6NGUe6X0ajCv0dQSCFNmdfGYGM/wmpBhBObz4uSjMDpY90y1fX+/x
 0M9FfFi0EDZvTyneKAEPBCh4/AO2CJtIG+K5Yn2U6hRumx2bkFB/4c3jA8fGEKfOuUFXQtWi0
 6hNfP5oOt4TKVjJ+zP2XTTX3Orb10dSzLgkDrx/F00OLO43EyI=
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
2.17.0.windows.1.15.gaa56ade3205


