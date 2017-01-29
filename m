Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715081F6DC
	for <e@80x24.org>; Sun, 29 Jan 2017 13:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbdA2NSD (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 08:18:03 -0500
Received: from mout.web.de ([212.227.17.11]:54122 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbdA2NSB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 08:18:01 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ls8xf-1cLkzo3ZIV-013t9K; Sun, 29
 Jan 2017 14:10:00 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] receive-pack: call string_list_clear() unconditionally
Message-ID: <3dd27c57-9ba5-fc31-6e7e-414408cd63af@web.de>
Date:   Sun, 29 Jan 2017 14:09:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mfSKR5Fw2ax4BPUON6Exb4OK03TD/qJ8PE3/nMYo+ydVcbbO/Yv
 IKbaVyFCygnXmlk+wP6Xry4XDGLZe8o2PWClaDy4cl8GZuvJS3STdj4RQ1yrU78fwp726cl
 TkocSuMxe2jbu44/brS9KReIKZkS+wxzjUPHTizLffNwqHTrU7e4PmSUmu/+7ucPt86eXxU
 v15SM7lVDDTWW9Rt69ErQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WgS2u++YhPI=:FDH1hUGXbu9qapc/UKiNpn
 CIir6D70cxj0VaDHC0iKwGeMDxbjl1IBmH75cZdFhas/Dqy0dNopFkewJdXbh5kNRbcJt1BxN
 zQcAS0cDJ2ihsY0NgwB/uzk5eGs9W+QHKaTnfvJCUyJHS2DgA+eMFPQmroBVa5LQArHkbXbBC
 RFOx0rWkKC5HFCBj3I4HcCCvjAKvFGwwV76vNol3G3HuU6CsUpR9k00EZ3cXsndkwf5e346/H
 e53uOOccB3QMLlMe+JbA9mK1hsSaYFurGkHl5i+FGCyNERtNC+P8faYSGPg704I78M1xjR24C
 /qv4pdpnraULzuyPw3RdMu8GAC1q/4MLbTWGiJ11PhjJ21qwR80UUrVbvTContXdwu5s3YfXr
 xjVBBSInNu35L/ThWL15fkLejxA8OUihE/1IYyPWQBrIAgc66Bg5y7+xxarTwjgn7XpXgfzp7
 X8auD5NtLlXEjNF+I0w787754bdUTntK+ro9sSkS5fYrcKooa5egrzKJ+sQlCmwa4t8o0Tb00
 qqviSiG9cNMVq9I4ZAMFDb/i6acLxzam19V+S/mhZBqJBCSIr+nI6lvhrzPICjPzR2V8+8lzS
 QFrOzdR2zIN1QYckJA6luvq3p9aOXF+Hv5YLi/lWCwGsmBPE35oKRHUtUTKs1OkpSiJjZX8rg
 KmYQJkUQh4zFgMTwAP157hZNC7gwqBUHXPINz9R5+mDdLuHkBgdo6YV7E6s8/leB0yMN+JFHy
 8bxoLcoTWW+T7jDN5CIAZAW9CnGsI10XFbM2aZeimthLHZKLcFLR4yn0dSkC9l6vfrfhX54nS
 Pau5B7W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

string_list_clear() handles empty lists just fine, so remove the
redundant check.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/receive-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6b97cbdbe..1dbb8a069 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1942,8 +1942,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		run_receive_hook(commands, "post-receive", 1,
 				 &push_options);
 		run_update_post_hook(commands);
-		if (push_options.nr)
-			string_list_clear(&push_options, 0);
+		string_list_clear(&push_options, 0);
 		if (auto_gc) {
 			const char *argv_gc_auto[] = {
 				"gc", "--auto", "--quiet", NULL,
-- 
2.11.0

