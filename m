Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D89B11F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeGVKyN (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:13 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37279 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeGVKyM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:12 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so13246210ioh.4
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71je/1xeOO/EbqDyMgyNXTXlCI/bfqmDLiOgM6RZ3z8=;
        b=IHeOFrEhTRkTQgoccm4k8uTofmWN+RDLEZrI+57k4dNHbouKvVIMCbwhhuSB9MgPH0
         5qvXkVGuadcbUxiO5gsnui+UeCL0Sk3Qai08A9rs5Tokh7eyMrNUvZBBanrDZ+MGQhml
         9upg6p+Cf9UgxxPCaCFlfyR3xzX2mnTX78gufTbRNXAeRTCiConba12ubqePIpHV5ToW
         ncwGfF55R3W7jto4YxowYoomjb2JG3tFesFPlmEfjVQ5X/mPSuFTSFOwial9pJ3MASey
         36XydyffA4nEGe3pYtC0p6AT+s5cvhZmqiu8Au6Lyd19+MuekYiPRbIhvEuLdQUSsNlt
         YUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=71je/1xeOO/EbqDyMgyNXTXlCI/bfqmDLiOgM6RZ3z8=;
        b=JgCFZ5DmCJ7ZYa9PByWyogrmDCJNLf3nYVOm4dJgAumirkc6sAqHd9A/4Y97IVyRs5
         kC8NOb8a8yefOTiqsaOCZYG8SJOLVkEq5gj0yz9HVTNdzVAmvsF+b3aLfrWs5PSX+wrz
         x++pzZ/kGtUM//z6ni/T3TM/M2hU4rwHRT3rmZ8QprSkjU4x7t5jccJCkZ3c53s6v81U
         JBZyRJRiHBl4rBye9kBHbXV1iWPFCUSTMy4ITdkdTYZJ6p0Cl0mDsV+5+sNBX0FRk16B
         s0sg1rFk7CEn2PL3v+0egfImjZ5Wrn3VV6ScDGr8saBUUerx+/2nmeutTkyC5v7I6ljW
         +P1g==
X-Gm-Message-State: AOUpUlEEC1eWH8MrYpYRCwvvreC3RFlUz3MovMgUmQKDek9OI5RDYHBA
        KZVvoJEJlaLX0Pq6sWGa1P4r4lu0
X-Google-Smtp-Source: AAOMgpeAPjm2mUPs8qSBFJ1KvOR8kHEvIsGnY48Qdu8bhqEH4JA5LwJM76jT2d3pzJhqB0Z55QqkAQ==
X-Received: by 2002:a6b:2353:: with SMTP id j80-v6mr6148164ioj.99.1532253483150;
        Sun, 22 Jul 2018 02:58:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.58.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:58:02 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 08/14] range-diff: publish default creation factor
Date:   Sun, 22 Jul 2018 05:57:11 -0400
Message-Id: <20180722095717.17912-9-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The range-diff back-end allows its heuristic to be tweaked via the
"creation factor". git-range-diff, the only client of the back-end,
defaults the factor to 60% (hard-coded in builtin/range-diff.c), but
allows the user to override it with the --creation-factor option.

Publish the default range factor to allow new callers of the range-diff
back-end to default to the same value without duplicating the hard-coded
constant, and to avoid worrying about various callers becoming
out-of-sync if the default ever needs to change.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/range-diff.c | 2 +-
 range-diff.h         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 77ac3bff7b..bbe6b05ae9 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -18,7 +18,7 @@ static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
 
 int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
-	int creation_factor = 60;
+	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	struct diff_options diffopt = { NULL };
 	int simple_color = -1;
 	struct option options[] = {
diff --git a/range-diff.h b/range-diff.h
index aea9d43f34..73d6e232fe 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -3,6 +3,8 @@
 
 #include "diff.h"
 
+#define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
+
 int show_range_diff(const char *range1, const char *range2,
 		    int creation_factor, struct diff_options *diffopt);
 
-- 
2.18.0.345.g5c9ce644c3

