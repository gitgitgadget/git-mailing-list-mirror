Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D0E1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390897AbfIPTXM (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:23:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40157 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfIPTXM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:23:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so331033pll.7
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SXZxbaYZ7Rr8r1Z5eCNCBkq04oRQUWgnvbhEDBZjIT8=;
        b=UKeGjRKD0/asadBQu9oGayod5CIhpn4EzyTSyy16eTvSPnZJM3ZVWChx6sMDDQt1k+
         UlRWS/ILgLRHbV7BxgA5G3V/3po83Fm/oYfIEIuvIZO7eITIho337soDAre+MmkGu4/Q
         IpQqsm8I0Os89g/PxXk4iIYWxT93Kb6ttvt0qpTO2yMxMYs01elcXdDhoWF6RAEwJ1Mt
         Askq8nZTXO62/6pWNe4uNus7smuAWQNXbd0G6bGktxx3/ZbFZbC/aV7/PHqAr53LyKj7
         TRXmJ+sAffj7/i8XwormJKPM9PaL+h5hoWicgOQH/xODOxX8WyfYfbS6y7OxQJtFWfaD
         U9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SXZxbaYZ7Rr8r1Z5eCNCBkq04oRQUWgnvbhEDBZjIT8=;
        b=DMeIpTVwALF1k6KB4+TWewpBplT38ghQzhviCU6fJOUP4H4sKFAj5M11gzI33R5aUA
         ATchCpnoutJ6TeCddPIX4k0nqMJwgVwOWOr2R9etFJsEgTvfij5MNgxIehUYoZ5yuciP
         ohySwEN73W+rPuc0SvlwilSG1VkbT3DjSMvrZHXOylHUh3GCjg0ufwpaCO6HiFErphGG
         lpSMZlLdhMNMHgkA91zt+j3enejHcsMM9rHl2S1b3ufopedMwjFNWTtV5jYddLcb8IG7
         NQ6yWbstmPDguzp0vSxcgrlqD/+0fiXe26NNYOWEaaWBEsa3vjKpveFAe2MPwNeghDN/
         0Tfg==
X-Gm-Message-State: APjAAAXuTMddAgbKRnBc874SFWAceX0G+EMr60m+FhXeOSr198AliCXF
        6g5QWg7L+oR2I6u4xHt7Ck9nOtrb1es=
X-Google-Smtp-Source: APXvYqwjmXLr0RlDUMyEmZqMCdYrN0DCMmzS9W0ESd0WcmalygWOeKptXSgmCwvVva6mz/FHxKhT5g==
X-Received: by 2002:a17:902:9a8f:: with SMTP id w15mr1436872plp.221.1568661791117;
        Mon, 16 Sep 2019 12:23:11 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id f12sm34757828pgo.85.2019.09.16.12.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 12:23:10 -0700 (PDT)
Date:   Mon, 16 Sep 2019 12:23:08 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] Makefile: strip leading ./ in $(LIB_H)
Message-ID: <e7fa5e1df76040c6e67727a4b33567a4b23a9aec.1568661443.git.liu.denton@gmail.com>
References: <cover.1568309119.git.liu.denton@gmail.com>
 <cover.1568661443.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568661443.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, $(LIB_H) is generated from two modes: if `git ls-files` is
present, it will use that to enumerate the files in the repository; else
it will use `$(FIND) .` to enumerate the files in the directory.

There is a subtle difference between these two methods, however. With
ls-files, filenames don't have a leading `./` while with $(FIND), they
do. This results in $(CHK_HDRS) having to substitute out the leading
`./` before it uses $(LIB_H).

Unify the two possible values in $(LIB_H) by using patsubst to remove the
`./` prefix at its definition.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ad71ae1219..ea77198247 100644
--- a/Makefile
+++ b/Makefile
@@ -818,12 +818,12 @@ VCSSVN_LIB = vcs-svn/lib.a
 
 GENERATED_H += command-list.h
 
-LIB_H := $(sort $(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
+LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
 	$(FIND) . \
 	-name .git -prune -o \
 	-name t -prune -o \
 	-name Documentation -prune -o \
-	-name '*.h' -print))
+	-name '*.h' -print)))
 
 LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
@@ -2769,7 +2769,7 @@ EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
-CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
+CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
 
 $(HCO): %.hco: %.h FORCE
-- 
2.23.0

