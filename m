Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF231F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeESF3I (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:29:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34200 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeESF2t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id x145-v6so4862414lff.1
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hSllLrSyw0WIJIo1/Ix0/Tom2whfLQ6BdMb8cSyelM=;
        b=U1ppcLumaLRD1ET+EjaKKC5HMobdFtIR4Z31hr5LjdhpxtZxG6tncjTuGpwE28aO6T
         ZhjA7sUAHYwIgvX2U85b7k6tZ71q+ff2JdctC40jH9b18Vlc+kSG154b00GOWGVoRFee
         oLeJ7PF4HsuxZoifYy8YMEno7iUFzIRTbbfc9oKw6xhb1N1TncB9z7G28GIYHFyWgs7N
         7b5EVp+iPtI+whP0H5WuO6m9WQ55S/TFLj8eITwhGuA8jos9lufm0R+fmGXroPJcxSq5
         kK1xSmYFNB/vnJUhrmVpXHCpasyVwZ70zBjU+FAQw1dl2/cjnO3syfuBgYF59oy3mgcR
         k/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hSllLrSyw0WIJIo1/Ix0/Tom2whfLQ6BdMb8cSyelM=;
        b=TGHoMJfhTFzemGtytTgHmyf1IPHu+Tk+FH/wfeV0WaifiI16zGOGeveX88TO8bKeVS
         TRpoPSxvMg68gkIx6ii899YhsyPjMbN2RCbAKEYGVtmfTMskvaK9dDpviH6Mwm9yfpdM
         xkZzHEuRIevgeNCqtNeNl/MCKsw2Qh7apEXSkXCtouxyXJ9f+hBZOewvU8Dpx5+g2Wp7
         3FsVncjBvaDz/1uNEZYKymqiqRbPrQGFz+wSmUuQz9wQqgOaqmbH76sqZvf+lCrvp4xz
         8hoJ9pu1YfDRdL7JAKxyYa22aV2qw1SjBOPn/SlK8QrL12MsIPLWsZUHYiMnuWZ9j4Do
         Btzg==
X-Gm-Message-State: ALKqPwdduAzSHjlQtyCC4gyAxObywQGNvozDUJzTv9UH+4kCKIp1tuZR
        8fJsy3/FJQU9zR2Tje9Lk9w=
X-Google-Smtp-Source: AB8JxZoVPxrpR5F4TRSifXOksPVmDcw94pxS+H94QYspnHhDsN4nVt0W2ClyabO8DiWQnNpwd8Q/pQ==
X-Received: by 2002:a2e:8350:: with SMTP id l16-v6mr7244164ljh.28.1526707728671;
        Fri, 18 May 2018 22:28:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 12/15] show-branch: note about its object flags usage
Date:   Sat, 19 May 2018 07:28:28 +0200
Message-Id: <20180519052831.12603-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519052831.12603-1-pclouds@gmail.com>
References: <20180513055208.17952-1-pclouds@gmail.com>
 <20180519052831.12603-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another candidate for commit-slab. Keep Junio's observation in
code so we can search it later on when somebody wants to improve the
code.
---
 builtin/show-branch.c | 5 +++++
 object.h              | 1 +
 2 files changed, 6 insertions(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 29d15d16d2..f2e985c00a 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -22,6 +22,11 @@ static int showbranch_use_color = -1;
 
 static struct argv_array default_args = ARGV_ARRAY_INIT;
 
+/*
+ * TODO: convert this use of commit->object.flags to commit-slab
+ * instead to store a pointer to ref name directly. Then use the same
+ * UNINTERESTING definition from revision.h here.
+ */
 #define UNINTERESTING	01
 
 #define REV_SHIFT	 2
diff --git a/object.h b/object.h
index b8e70e5519..caf36529f3 100644
--- a/object.h
+++ b/object.h
@@ -43,6 +43,7 @@ struct object_array {
  * builtin/index-pack.c:                                     2021
  * builtin/pack-objects.c:                                   20
  * builtin/reflog.c:                   10--12
+ * builtin/show-branch.c:    0-------------------------------------------26
  * builtin/unpack-objects.c:                                 2021
  */
 #define FLAG_BITS  27
-- 
2.17.0.705.g3525833791

