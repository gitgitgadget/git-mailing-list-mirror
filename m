Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B011F404
	for <e@80x24.org>; Mon, 26 Feb 2018 21:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBZV3b (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 16:29:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:44825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbeBZV32 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 16:29:28 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5nF-1eSb281KtF-00kjGA; Mon, 26
 Feb 2018 22:29:21 +0100
Date:   Mon, 26 Feb 2018 22:29:20 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 02/12] sequencer: make rearrange_squash() a bit more
 obvious
In-Reply-To: <cover.1519680483.git.johannes.schindelin@gmx.de>
Message-ID: <a7e01df062d64a2b89c99a4de4a772cfb0c84017.1519680483.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519680483.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:B3MWQRz9h2iMxrmIIvZKpxrtkgzZcNZGzdlBdpHXwfHf6lHRJ0n
 NTt2oyImpE8yoRfbAQ+F+gs5tlhEUh1sutX1bXBZa9LdcXiLTjQ2bQ8TsRfax7IrlQhVgEN
 Sbkj620NiUHHO8sPnJQSdQgxKPPOKqExNhQfAzjrT64XKfOqyyjMsuKdJ57vM/OYsMD3xmS
 cgelzEAzWxVwzJ8Y20RmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:slprkTYzmYc=:OioEAopD/8HiuALVa73SvD
 OUQUEKi2O3BXVifcG9U54oMUiPExjT5vEAJCEOhpBl2S5vfOKkV3vbCHzspymv3Va3MF3UjNR
 pEg3NZamXlths3eSFI/oyuKgjfNELFONz7jBYfodg6D4F71CweoC6ebdnxbxzHUhTF/uufuya
 fMKIXhf73VIjiw3JKEXViK2OxuLHGVRYwkUKA5l+mrbGvETylrYeWjhO7vZ5NpfI7WDGJsDdx
 TXG+eUzBJJ0To0e1Slzq+2LWrEIoVsUV8XC62I8Eo5ZFtlukVXTWD4hEvVQmNLz9Bmftq2M8u
 Sb8dNs2Tb5EfdC+FBb7r+XwEd1TOMvh4vnsEZgDLBghas0RhzpKy5JjJeA5qD21117Tq43WGt
 Ugs/w6n51r7gDQCNI/55gNXbdDXHoPkrRnkO4Z83RWwKtVPJxKIF6fejUNZRzvhodVkklyAK9
 6BYputsxB63bQyg7eMNV5P3odMcksy5kwZHtlt4YB0dwxOB8mg2mDMfLwpT0WeyBK3nFFPjcv
 KR/3MQZXSoGF/GB9A6bzMVA4/I4BnCg+DzSBQK2il33Td01kFZLVLbjTDg20VzE3sFvHqqaRu
 j8sW8IHP4Jbgqc46nFWdN7QjbIA2AXw3jA+7JPutie792NqoHYm84Eooc7l/oY6CjZsialTiQ
 ogYpDqXp7OH5PQQlI03zrC75JPCSZy51mS/UGlQoKCfmHFHI5zrhLo+CjiuhBVOH/Sh0fsYt5
 PTuwty1Cl9cc8v6DTJt9MX1/yOm7M7Tqd4/oFa3uJgFPnShE0nM6BS3Ac8Qu3I7Ao5ZoUz5j6
 HD+P6UwUvUrdL92uaRCNI1hkZVYvjx6O4uCUv0RdvbFH576GOzufcP578RXXKPcr+M0WVgr
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
index 5aa3dc3c95c..cfa01d3bdd2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3412,7 +3412,7 @@ int rearrange_squash(void)
 		struct subject2item_entry *entry;
 
 		next[i] = tail[i] = -1;
-		if (item->command >= TODO_EXEC) {
+		if (!item->commit || item->command == TODO_DROP) {
 			subjects[i] = NULL;
 			continue;
 		}
-- 
2.16.1.windows.4


