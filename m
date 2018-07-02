Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837AE1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeGBAZM (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46765 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeGBAY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:59 -0400
Received: by mail-io0-f194.google.com with SMTP id p7-v6so860563ioh.13
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=odJeg0Nb23OSgJ+33O8aDeioYjpBZb/DBPyzbeNZvpc=;
        b=BhF33OVZ7YbHyrz9EgUGU431kxe4G+4gI3CjMZZiylDbujLQZKvIQXORxKnP05Bx/u
         2VRPOV5eXGuwh/UzcjdbDqaePNmHkV0x8A5MljMOn8n9IvhRuO45RHmUBLn6iQMksvl9
         SriSL7SKZSKyaRDXE7JuNFncguIcbFqJtdNRovoGgvA7n+G/JeS+QbNHpaYjrjik+zNi
         4iVSLVHt0blXx0h0M6H5rqz08G3T3wnbf2pfp4BvSZ1HmC9rwowJv5yqnU5GCvO2lTYt
         GhWRIa0HcXmADkSLvnzy/dlnXp9zBBIGjdZuscfZtcfPn0M+HN2EiKzODHdx7AGZeZKd
         nIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=odJeg0Nb23OSgJ+33O8aDeioYjpBZb/DBPyzbeNZvpc=;
        b=npfg1u1veX+TQQVXFIU92+hVQqkTIvsHiUebOedYd2/GHosTBOD1mSUK6aejJZdfPj
         Gm1bJaZC5rxd8GU84GopPWzTpuZ97Vh93hd5cGNvfyNFuvMOSDuhZOHwBlcYb+Cg2IHs
         CLDLQSCUUcSCulyMOy5dLyPAAu7/BpkJA1Grl/kBA+rUj/qm1TI/1geg5ktf0io2pz3D
         LXKvtQAPftaekoFQeS4EerxRvilDoy8Rg1javnSZD3XW86v92jwi8ybiG0UiUN/I4oe8
         by+Vzf9tA6G5AFVWkdMZCgCfN2ZXINk1PNNpB4d34geSdGzVJbsX+UaCatmULVg9Pi5w
         o6LA==
X-Gm-Message-State: APt69E2e9JkPkHO2tthVpMOLh1UiX02/cL8vzZ4avsfoFUXlA00rhWjQ
        XrO6w6A8Qd+EsDr6NGjhsbHkmw==
X-Google-Smtp-Source: AAOMgpc8imyN6ddyVqBlXoG0gb4KCrUbvHLFoJUbAuX86fykLU+CZfxiDIFG8t6HS/tJrej/N+aLbw==
X-Received: by 2002:a6b:d52:: with SMTP id 79-v6mr18287863ion.273.1530491098991;
        Sun, 01 Jul 2018 17:24:58 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:58 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 10/25] t7201: drop pointless "exit 0" at end of subshell
Date:   Sun,  1 Jul 2018 20:23:50 -0400
Message-Id: <20180702002405.3042-11-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test employs a for-loop inside a subshell and correctly aborts the
loop and fails the test overall (via "exit 1") if any iteration of the
for-loop fails. Otherwise, it exits the subshell with an explicit but
entirely unnecessary "exit 0", presumably to indicate that all
iterations of the loop succeeded. The &&-chain is broken between the
for-loop and the "exit 0". Rather than fixing the &&-chain, just drop
the pointless "exit 0".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7201-co.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index ab9da61da3..8d8a63a24b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -673,7 +673,6 @@ test_expect_success 'custom merge driver with checkout -m' '
 		do
 			grep $t arm || exit 1
 		done
-		exit 0
 	) &&
 
 	mv arm expect &&
-- 
2.18.0.203.gfac676dfb9

