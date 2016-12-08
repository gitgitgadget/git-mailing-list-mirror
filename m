Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE771FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 14:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbcLHOYb (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:24:31 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34698 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbcLHOY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:24:29 -0500
Received: by mail-wj0-f195.google.com with SMTP id xy5so54695905wjc.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0q1TSZXfdtTW+lLzMToDdHxfAUkju7FE3gLLeyuqzM=;
        b=cgLyt96VJFqvKwTX1Nz0rmG/HjAs/NAMohtNuXfRAbuTS5TQhEChXie/hQ7/mEZvZK
         nkmbcFWeqYndEh/wFSGKr/lKhl0a25ntD0A/f/WVn15Db0XmfMSr8BUqcLEY63E760+E
         JHqE0BAAWfB9I1emYH+w3DA2C4ZiiWlPe6VlU6fw5rfbgRi2+cK8wNJ5kZ4Qx606n5Tj
         HLMJwcsboNRSwSs0Wv/Ec3KefwgNjk5qzvA76kPOQvcI8V8Oze5kcfH24rN0X51NWaj/
         TgzVHoAISR+nOSIrjhPWCybiC+Vrlc06NKdfxO8kwBwCybvQA9WQsason2i4t10b5leP
         Lyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0q1TSZXfdtTW+lLzMToDdHxfAUkju7FE3gLLeyuqzM=;
        b=PhUVGUe25bqIkfoTuTupoVQRprh9i1bq/GIGknmA5UPuy2HdXhVKlxoHCmSDqi0X2B
         SL77BMtiYLNKEtx0YEBeaQzTZTIbboWdxtQdETV7MxNILtR/BCt4VL4S4eDtRJxLmnrz
         sTBzK2i5S05iH9odb+Ey3jR0eAAy4YTn4ofHTXmsgjPThlaq8xMlGohYONlJiUFjL3Pb
         D1VVKeLxYF3GimiHgYMoPifRemSAanNHXzGGBsqWzYZ8oSIa9lnzOO0grznMri5XbNL6
         C9KDz1GnLvYCC0EpzPOq3jH6TnGAtTdN5R65Qh3LzEYfSpud31zY0QXIrQYZ/u6zJxu1
         ShZw==
X-Gm-Message-State: AKaTC02g2/O4LzpNWRwmxM4zwwX8vCO+De5LjE+qG/VU3WAI07K7QvKdyX/l0iiFAFm44A==
X-Received: by 10.194.209.169 with SMTP id mn9mr62406925wjc.114.1481207068296;
        Thu, 08 Dec 2016 06:24:28 -0800 (PST)
Received: from localhost.localdomain (x590d68ae.dyn.telefonica.de. [89.13.104.174])
        by smtp.gmail.com with ESMTPSA id l67sm15464028wmf.20.2016.12.08.06.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 06:24:27 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 1/7] t7004-tag: delete unnecessary tags with test_when_finished
Date:   Thu,  8 Dec 2016 15:23:55 +0100
Message-Id: <20161208142401.1329-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.78.g5a2d011
In-Reply-To: <20161208142401.1329-1-szeder.dev@gmail.com>
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <20161208142401.1329-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--force is moot with a non-existing tag name' test creates two
new tags, which are then deleted right after the test is finished,
outside the test_expect_success block, allowing 'git tag -d's output to
pollute the test output.

Use test_when_finished to delete those tags.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t7004-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 8b0f71a2a..396cffeeb 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -122,11 +122,11 @@ test_expect_success '--force can create a tag with the name of one existing' '
 	tag_exists mytag'
 
 test_expect_success '--force is moot with a non-existing tag name' '
+	test_when_finished git tag -d newtag forcetag &&
 	git tag newtag >expect &&
 	git tag --force forcetag >actual &&
 	test_cmp expect actual
 '
-git tag -d newtag forcetag
 
 # deleting tags:
 
-- 
2.11.0.78.g5a2d011

