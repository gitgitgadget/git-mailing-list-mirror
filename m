Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 602DC1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 18:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeHVVjc (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 17:39:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39359 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVVjc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 17:39:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so2365539wrf.6
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnvRUfZrnuaeUVH/h0/zRORAfjpV2/kOZLrRVH1w9bU=;
        b=oOH//90Ev8NT+R0wRZs7HHy1p/KXqxJztgeIsGVin4maoNx1poraF6ms9rPwoH0Rrm
         d1V5psx7Vp1Mx0hzTMRPLOIJZUEPzdqfzibE/xh7qNeq2B8UAA+L1LHzdoqSaP1JqANl
         e0L6g++5f+n2/u5Iy6eZTBaNGCbE5utOW2xgiXGkVDOzYMpiYJ77BtqtQ0o8I63kIONA
         o6MfLM6ieStp8hN86QjioqOmFBwXJtbU+5eeDbhS6EJGGHuWi4ViHHUfu6hLSbjyE34G
         mD3fp4h4WmDhnL01O+gE4Rp6imeWBmVBqpNB+Rj2x/Ru16cutsSwIGjgzAWhain8z5GC
         Z1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnvRUfZrnuaeUVH/h0/zRORAfjpV2/kOZLrRVH1w9bU=;
        b=D64OHNSqyQeH+hjfq3NZh7K/XJGSFxz9Uzl0pr4sDV7UJVvq/pgE/xPx87CN7GSPIK
         aOAsTq29cG3Jz6dswLTKjaoL79lkk8kVk/0CF53Q5G4bqubiBHLudPzm5aI6GwHqGsUZ
         XiFSe2nZGj+Q72EtgttA42fzv08aGeBr5dZbh62ddBzbMC6EoYZmN5TwY0vQZs50uB21
         OVhljzDEovaJ4vXfhbEbUeT8RKGJttpxjlvNAwouYyCoMOcqNpqyYcF9ReKDhmWsitJ6
         vH3TMrSFB2AqwaYEdFjsRKepvnvUz76i6KSjBTel6ctDbUFwMCD3KWXT+xeznnJF5u71
         ecBA==
X-Gm-Message-State: APzg51Ba0c9bsTJWL9MOO8qfb3kRyBGW2FcRjDvQNj2SW17KzAqjs1aV
        gP/1aWlbO4FFSkNH8nJ/gsU=
X-Google-Smtp-Source: ANB0VdbFdQiOa9X/PyITpEkR3wxg0ZhMPIGrv5USJqdlPtjso4rYTvkSiCwAhV+DnpoY93U0Y4K/Sw==
X-Received: by 2002:a5d:54cb:: with SMTP id x11-v6mr5184654wrv.150.1534961615480;
        Wed, 22 Aug 2018 11:13:35 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id q3-v6sm2222490wma.45.2018.08.22.11.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 11:13:34 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] t3903-stash: don't try to grep non-existing file
Date:   Wed, 22 Aug 2018 20:13:19 +0200
Message-Id: <20180822181320.14055-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.136.gd2dd172e64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'store updates stash ref and reflog' in 't3903-stash.sh'
creates a stash from a new file, runs 'git reset --hard' to throw away
any modifications to the work tree, and then runs '! grep' to ensure
that the staged contents are gone.  Since the file didn't exist
before, it shouldn't exist after 'git reset' either.  Consequently,
this 'grep' doesn't fail as expected, because it can't find the staged
content, but it fails because it can't open the file.

Tighten this check by using 'test_path_is_missing' instead, thereby
avoiding an unexpected error from 'grep' as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3903-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 1f871d3cca..6450bc6698 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -724,7 +724,7 @@ test_expect_success 'store updates stash ref and reflog' '
 	git add bazzy &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	! grep quux bazzy &&
+	test_path_is_missing bazzy &&
 	git stash store -m quuxery $STASH_ID &&
 	test $(git rev-parse stash) = $STASH_ID &&
 	git reflog --format=%H stash| grep $STASH_ID &&
-- 
2.19.0.rc0.136.gd2dd172e64

