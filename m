Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5C61F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbeGQMlE (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 08:41:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33575 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731468AbeGQMjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so1022631wrp.0
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=2L2txHp3jRYYt5mZwjXghaTZV0d2RMQIabRbk4o11ek=;
        b=LiTIdFYKIQD1yh5ayexKCVjekbhkbRuTKdx52ybSsdXwJq6IjBWhVXd908AFXYaqx9
         /cU9aIaJN0VYalsHYUnbdDWlRTe1eU6PcEDCKDBqf1BtiD4t2O4VWXzHzK4AE5XWBeIj
         nf557P1rmEDyqflTNSZCJafwN+z4UhqZqkGpKUG+IT7xOhNtNZ1J6W6dz4/CRwtTkw3I
         sezV+KQfs/7gRbA51CPzc1idrnYzbBdqNdLge4exGeZfdKPNoODZgU5hcJdAZDFNf7jy
         cP1LzuZJW13ZvVRaekDJA21ube4/CczwenEPuP3q0oRCPD+oqlmu+PqlCX06pU+GBK7k
         wfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=2L2txHp3jRYYt5mZwjXghaTZV0d2RMQIabRbk4o11ek=;
        b=o/7d1mejbitfd3ux0f0BcEO0VHXIDB91IXB1Ow/q1Xc6XekSSYH8ML6WUGvy6GGzQI
         2LTDgrAPxeOuQ0AdbBuwlqYi+Q5ucX13kIoq5+oqTxLekaPUz8HmkUCrEkacabzBHfO5
         Z+34u/1NQT6YHUaI518UcU4k4ywa98lyygpVX5CIW3+EVMrx2IHIY50vi18yEmqKQ0FS
         1I+qsSg/sQhn/7hHO52g+WatTONckyMcvLf2x9Oizs6B5QbWX9m25k4Go330ySS/V8+m
         g/TQQY/XKbMFZCSM71DXPyfOAae4FyQDuekcSFwR+2TsZsooN7g2hKCrqxuVvfXjqGyJ
         Osyg==
X-Gm-Message-State: AOUpUlHuH079UIv2TJFIHODNndjJ4OR+VayQhL3r+ZCkWlC/mSdD4B8m
        0haYu8BGsziTVTQg/LHCK2GVEA==
X-Google-Smtp-Source: AAOMgpfZt+jZh+Li767WIVVKk02WkggYD14Zwt+TNJBruzIZDs6BW5FAboiyJR4UsiwKxTde/J4hfQ==
X-Received: by 2002:adf:fec8:: with SMTP id q8-v6mr1201798wrs.164.1531829206671;
        Tue, 17 Jul 2018 05:06:46 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-157-218.residential.rdsnet.ro. [5.13.157.218])
        by smtp.gmail.com with ESMTPSA id d4-v6sm542099wrp.51.2018.07.17.05.06.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 05:06:46 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 1/6] sha1-name: Add `GET_OID_GENTLY` flag
Date:   Tue, 17 Jul 2018 15:06:31 +0300
Message-Id: <973c4d380743b4a0491ec63909fef862413db065.1531778417.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.184.ga79db55c2.dirty
In-Reply-To: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current API does not provide a method to call
`get_oid()` and avoid `exit()` to be called. This commit
intention is to introduce a flag in order to make `get_oid()`
able to get the sha1 safely, without exiting the program.

Since `get_oid()` calls a lot of functions, which call other
functions as well (and so on), there are a lot of cases in which
`exit()` could be called. To make this idea more clear, here
is one example, which could cause `get_oid()` to die.

  get_oid() -> get_oid_with_context() -> get_oid_with_context_1()
  -> get_oid_1() -> read_ref_at() -> exit()

Where `function1() -> function2()` means that `function1()` might
call `function2()` at some point.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 cache.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cache.h b/cache.h
index d49092d94..cb8803e2f 100644
--- a/cache.h
+++ b/cache.h
@@ -1314,6 +1314,7 @@ struct object_context {
 #define GET_OID_FOLLOW_SYMLINKS 0100
 #define GET_OID_RECORD_PATH     0200
 #define GET_OID_ONLY_TO_DIE    04000
+#define GET_OID_GENTLY	      010000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
-- 
2.18.0.rc2.184.ga79db55c2.dirty

