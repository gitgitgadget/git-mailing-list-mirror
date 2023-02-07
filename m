Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481EFC636D4
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 16:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjBGQPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjBGQPv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 11:15:51 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DB56193
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 08:15:50 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id fi26so16314279edb.7
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 08:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGuFuUOOdcFscRZ7SFQXG7PQtUwVfahz+PdWI9tcznc=;
        b=S87HAKolcIdzBL1/HYLkapO3xysfy9FDEBmtZZ0VT8LKaS/yNwXLWheNWQOWkaXuQW
         mx3HBiQIXcD9xaaxIXwOyk5Rr3RVhyVvvv3q7k9qWCAGY3gdM+0t7UTk0nJ+9qIH5fXw
         57beuX3y0AjyySi3OpDnwCoX7bmve+i7xslw9iPDyvrupgUspjAlso1i8P2p5LKg+AgS
         FDoXCSmpyKPsxXQRLoM8g/V/C46D4nrBz4NsZJoqxwHS73mKK1sUPjSZ17RWa2jQVS3+
         mGMyn6i+9DdovaFRysnTtK1jIHrd9zIejgODvszL5P8aDrZsbeRPvhiv6K89Ijfy1iwx
         IXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGuFuUOOdcFscRZ7SFQXG7PQtUwVfahz+PdWI9tcznc=;
        b=yfSfuS6sihwrjadtotHgRGuLpanO/2XfRovNRIqRDIJUGuxy67vDIuSCjcLwlRBJWT
         hKcut5hIC2q+S1pSeI4coZ9G0+tIm4g78oRUhtesrUqW1bb/MjeF7ZnsGf/pw36twrty
         yS/+Rn3id+zTO7ZDQwMGOzwIy9WacKkl247yOAhVHeooN/qWq1h7sdNJDdAyR+vbVDNH
         x6r/vx+LkigAZsZq5gtDyzJMJAvQ7Bz5v7kFEYYw6QKtnTrHXynuWX8ZrfNRhdMcDShx
         JdcbPwOMFchKpn06yU3+4rvMbzqw3WUef8ikawxZf6O2Wz6tHsfwDxfIBN/RXvElJbOA
         +RlQ==
X-Gm-Message-State: AO0yUKUDnXntGam4KNLXJzUdM6dS/mI7Z7LIfPHQhkManFYE246cg3hs
        IM/0U2B4kU1mJZ0Kj8aHm2c3Xcb/HXBgzCtd
X-Google-Smtp-Source: AK7set+XkZyHAGkQdNEbJV2Iv6ul/cYhpUONcbKdhGEAt+rP2BQRBSumOR28POCYyXB5L4+6cyVF2g==
X-Received: by 2002:a17:906:1286:b0:88f:9c29:d232 with SMTP id k6-20020a170906128600b0088f9c29d232mr4071088ejb.57.1675786548176;
        Tue, 07 Feb 2023 08:15:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id kg11-20020a17090776eb00b0088519b92074sm6950943ejc.128.2023.02.07.08.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:15:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] config.h: remove unused git_configset_add_parameters()
Date:   Tue,  7 Feb 2023 17:15:42 +0100
Message-Id: <patch-1.1-31f4a08c068-20230207T161453Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1430.gb2471c0aaf4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was removed in ecec57b3c97 (config: respect includes in
protected config, 2022-10-13), but its prototype was left here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A trivial cleanup for a change new in v2.39.0.

 config.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/config.h b/config.h
index ef9eade6414..7606246531a 100644
--- a/config.h
+++ b/config.h
@@ -447,15 +447,6 @@ void git_configset_init(struct config_set *cs);
  */
 int git_configset_add_file(struct config_set *cs, const char *filename);
 
-/**
- * Parses command line options and environment variables, and adds the
- * variable-value pairs to the `config_set`. Returns 0 on success, or -1
- * if there is an error in parsing. The caller decides whether to free
- * the incomplete configset or continue using it when the function
- * returns -1.
- */
-int git_configset_add_parameters(struct config_set *cs);
-
 /**
  * Finds and returns the value list, sorted in order of increasing priority
  * for the configuration variable `key` and config set `cs`. When the
-- 
2.39.1.1430.gb2471c0aaf4

