Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B10D1F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbdLYRoL (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:44:11 -0500
Received: from mout.web.de ([217.72.192.78]:65185 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752879AbdLYRoK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:44:10 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsQLM-1ewHwj0ecK-011xUg; Mon, 25
 Dec 2017 18:44:05 +0100
Subject: [PATCH v2 2/9] commit: use clear_commit_marks_many() in
 remove_redundant()
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <539d37d6-0d22-dba4-9b91-d5b77d43bcd2@web.de>
Date:   Mon, 25 Dec 2017 18:44:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:+mkPudsflimJcbXK4OwLrvhbyF0KbiGWgiHrPWtByEFWF2rEK/0
 VYxwdzLRy8Ku5l+RBgwBcNOaK1BWocaNG3pyfvo1HxIfu76uJNhNuJz4lS2p49GNi2PyPEA
 5vcH7p90tWssl4Avgzbv7Eh2Vo62stvuNGAtC2ArlRK9eNzajbxBUtEWPJXv4uEkFx7VXUa
 /rFYLjLvXICzuhynYZh/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9FmQ/Zy9IT0=:dlz/Rk+dwt0P+BU+doaNYj
 1+3muh7HSC5oKpWNd4zmiyAlMYyKg9oBRy5EpiB4RtOihD0CssFsMAg2bKG+S0DaDRMSYq77Q
 R6nTZc9tAY8C7BfjCewcdJ2GIe5QrFc3JljyiC1ldTW+5rxtZfl3GlkrvnpeKzlZ3NCvDvhZE
 ziYC98wYtCXzldQ4zt6TvNZwdUxGPdc1l7RWOn/DCHQYTrTRAHGrFKEMX44Zc0MbkF5WPrMi3
 QjZVJwmjifExALzfHQIIHzmWrUgfllWDOqqQsnIRa3kNup6UEUnhUPVhNznN/McEEygU8YlAp
 VBlBF7se/Mw79lZEaDL3Yz6T+TWKxgbeI7/EkS1avV/V4hS8NOO8eyfZ/+G+bEhvkWKQZA1+K
 n8DnGmCkuzESBrAD4e6FsDvghYduYEPMd6tT8yvEnW95rCj4njC3ZAvCQdqyrRKyPjGV3cVjT
 Ifi9ENg93WNfWGtwARlL9F0l9Ea3UefrM6ZxScQrR+36YT/qjYcUXi7sFMltK+YN0ErwrA6rR
 yXOL1YoAMcA/pX33Mqn4Djzl2hXhO75QURBtZwEnzbjup+oEyb0TG08+7RES3Z1P4Bcw1u2x6
 O0kj5pOLGpfFt3PqM9b6yrl84Cm2m+QcEOYNO+VUcWY7D8ab1GPlXjr1mPnJsAIvO6Oh+1EGb
 kHRUmrYl945ZMFIgBiqUYVpwmZFAxZ737x3Ef+sPsEy2m7vKnyhnyGuXAiXzX4rKKR/BZpDjW
 Ls84xBVFxEzQ9EOJ0wkKjCuzW/mhWXcvzG81jwPaCtCd+Yyf3K0cd21pyiO/uTHv7dF+1Sl3F
 /fhtYx077B7ylsdB5kYDNVXpzadv/6fG73I1HWENe03NRA8Q4Um+3gODlLyvtX9tpYvUCe8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 82667514bd..9edc12f338 100644
--- a/commit.c
+++ b/commit.c
@@ -929,8 +929,7 @@ static int remove_redundant(struct commit **array, int cnt)
 			if (work[j]->object.flags & PARENT1)
 				redundant[filled_index[j]] = 1;
 		clear_commit_marks(array[i], all_flags);
-		for (j = 0; j < filled; j++)
-			clear_commit_marks(work[j], all_flags);
+		clear_commit_marks_many(filled, work, all_flags);
 		free_commit_list(common);
 	}
 
-- 
2.15.1
