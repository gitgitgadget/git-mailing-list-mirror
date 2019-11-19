Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E649D1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKSAVg (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43731 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAVg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id b1so939073pgq.10
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=btGSgSaCriDWt9uz6WVnPkIUjfJuM5ZNFO42sbxpE5E=;
        b=k9cjta3SoYBVkpxTPTlZH7t04jETsKJSUR4N4fGAvBqUuThuVsbwQMFAqa1Kk/c0oX
         h2VOg4mFGTKt5C0zhK/+ZO9nau2VmtvNYNFSkU43WQb+qY0Bsv6D6032xtINa3uHaLmS
         7c8HDDwy6RXnHlvWSNUcL578w1wlvmf46KZX2viJaiHkVKpRAnLZpoyCqKIcm2DB5nAV
         arPmdkRisxJaKJ7Ze3iVZ0J8f1her17NET/Lejf/POovbTjVbmvIounmipyQmdIsGasm
         i/fCO/W9MlBdE+h0T8R4Y5i0DFz6vm/zxFMe1JBBjt8/QUDza69tfJGzcQgi6xOhuHVa
         9AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=btGSgSaCriDWt9uz6WVnPkIUjfJuM5ZNFO42sbxpE5E=;
        b=rcDlW6kRngDH1NwMJaoju19lYJbyP75Pp9EZ8i3nhkT47ZDo5ld1Za6ChSXmVJDZev
         VRCGkdH2z3DHd+Al8pVLdd2NfFOGlsVUrhCVM8ocrqYVqsUczA8U4amvA65zS5Fh2ZrW
         3lNY8lLpoNo9LBzquMqFrLTT5c8vf16+N4dK5lWNyt0dEEzgCPeq5EmnX54hHUiT2OqH
         2DhI2EHWRQk39P0ZCZesMpxUY4UvIjX2wZLx2WFgfLBnvBox0539nQqRGIog1E/7ribm
         W4pu38X29rfPdf1trWYBKNBeqn0ZJbjubPdDl6FTgi6P0b95t1ACdk3RsawWnS5Pbfbz
         q69A==
X-Gm-Message-State: APjAAAWflksNTTucr40eRZl4PwShfXLMmvy+MviTqISm5Yj1VubUBe84
        03OJKlqOIUd6QpDBZnfN8zCeK8DV
X-Google-Smtp-Source: APXvYqxTzWAjJF2sGbmEFKBGJ1AQHwVOwibLuKyws/1kQkeoZUtNZLEmWfoRzck1cTyUxsxpqpxuCg==
X-Received: by 2002:a63:5725:: with SMTP id l37mr2296267pgb.247.1574122895529;
        Mon, 18 Nov 2019 16:21:35 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id r33sm659159pjb.5.2019.11.18.16.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:35 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:33 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 10/11] SubmittingPatches: use `--pretty=reference`
Message-ID: <888c496991642e63049ed84e84ba7af3c53311ee.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git was taught the `--pretty=reference` option, it is no longer
necessary to manually specify the format string to get the commit
reference. Teach users to use the new option while keeping the old
invocation around in case they have an older version of Git.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/SubmittingPatches | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 7860dd2568..4515cab519 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -153,6 +153,12 @@ The "Copy commit summary" command of gitk can be used to obtain this
 format (with the subject enclosed in a pair of double-quotes), or this
 invocation of `git show`:
 
+....
+	git show -s --pretty=reference <commit>
+....
+
+or, on an older version of Git without support for --pretty=reference:
+
 ....
 	git show -s --date=short --pretty='format:%h (%s, %ad)' <commit>
 ....
-- 
2.24.0.420.g9ac4901264

