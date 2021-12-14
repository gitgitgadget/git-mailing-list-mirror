Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE05AC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 01:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbhLNBzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 20:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbhLNBzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 20:55:38 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D662C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:38 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i13so5714847ilk.13
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LMumUQ2hzoDKMXFY3lwDuDhafwwkP0GDPscap3ppkSk=;
        b=j4ytsUXw/WXHsy81vZRE30BvqUWXS8QMu1j0GGyDnymelkVGwpEsiCtg2A6QCdkLOE
         eT8baMB2U49L8GhYX7QPnVG8nvKknLjPwOeGV0H5QyAQXh7Vg/Zi9CQ0T602+I6YZrol
         X+ZDZL8mudnmjM8n+LghJ2+w0LFw7n7l22xnMt6dIGmdaPp4K98rUAaq+sT+jfl/of/1
         pUtXGnez6+CVSOfdVDpFNpx4fasUhPxPzff2W5fLQA+puRflCR1ofxndXCKlS3zaecHt
         35VBN9Y6ciWiqHM/IoN4Xhna9/yIuQSNoGnQboiNzdAYGfpd9BH1K2M6hSrok6f/Y66f
         9KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMumUQ2hzoDKMXFY3lwDuDhafwwkP0GDPscap3ppkSk=;
        b=nhI51P7lrwn0VBGbMF2DoKrPWtpKu+CMX66rI/j7eLD2SfPfOwymE0Zy/D+4ZujofP
         vh9XID+BhRdU65f127v1VSalD94QsDUtM6Tal+hECG4PED43KqyV9J0A7G4z6qVZy8Wx
         Acfxkv4LPpSAnIlyZCRXqXrpYJjUvSQr1PPruCnM5RweGPyvC6mEMr1DTCkv7Yo8O6OW
         phvzP5y5hUkRoS0jHsHWexyitO2q8r4sFZ1R+H98fFXLU1G/Z+C4N4rd4KzeZe1X0UKt
         iMGasdoJ86pWeFKnOpu83F3CbHu0hs/jpq6fPY8FFXZHh7KOPXsdEI3t9AlJGZ+oH/vb
         nuoA==
X-Gm-Message-State: AOAM531J7o2uHrbq9zRGDHUo1o0oeqlWvPg/B4QLMX7NucClIfDbeS9R
        A7QMDAYdmir//jCCXmnYDRqt41SAqtjGm2vm
X-Google-Smtp-Source: ABdhPJzEZko69uanejYp4r8aw1ahrTLqJRCzDNrQAZ56ROVe/68i2pwQHksjYCEPdnJmedD5WyZ3vw==
X-Received: by 2002:a05:6e02:216b:: with SMTP id s11mr1561268ilv.228.1639446937223;
        Mon, 13 Dec 2021 17:55:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-2faa6b4dab7sm186799173.205.2021.12.13.17.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:55:36 -0800 (PST)
Date:   Mon, 13 Dec 2021 20:55:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH v2 4/8] t5326: drop unnecessary setup
Message-ID: <f430b6f2e9a8b2c0fb84e86c353fee47a9753845.1639446906.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1639446906.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core.multiPackIndex config became true by default back in 18e449f86b
(midx: enable core.multiPackIndex by default, 2020-09-25), so it is no
longer necessary to enable it explicitly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 353282310d..1a9581af30 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -19,10 +19,6 @@ midx_pack_source () {
 
 setup_bitmap_history
 
-test_expect_success 'enable core.multiPackIndex' '
-	git config core.multiPackIndex true
-'
-
 test_expect_success 'create single-pack midx with bitmaps' '
 	git repack -ad &&
 	git multi-pack-index write --bitmap &&
-- 
2.34.1.25.gb3157a20e6

