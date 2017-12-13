Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523C71F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbdLMPOV (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:14:21 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:44125 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753301AbdLMPOC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:14:02 -0500
Received: by mail-wm0-f66.google.com with SMTP id t8so5677885wmc.3
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 07:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3FWZ2uOe1FecSLV2p0EqZUE58hU2gIGRaKP7Xuimpak=;
        b=sqTcXA8dEwamNodGid1NSJ1QpV+OZKjdkR1eU8445ipcEAQerYS0OfU7GP88s+aUtp
         b0oAExHjHFawMx2OB5E+igfz6XSKiOUA8sf6WouYoFUNXsXSGwY2aFvMChg4+jg0JxYM
         B3c4N7v6MhHefCon4lI4qM/oXFiZLSaEwF/JMgioSjjEDzMikNmfiFXmbQ4L7CfbqM/f
         JXFCCFJZfvg16yGodoWeUUZUR4+aVlrJgliHZn7zg6sUUu4KxZtFmlo/g+RZ473CtLQs
         bBxuBZLtmDRFvJudZFtv+8odwK+G60xgSAT71IEA6/j5i0wfn0q6MI3E/rYVpLxe1jmE
         M46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3FWZ2uOe1FecSLV2p0EqZUE58hU2gIGRaKP7Xuimpak=;
        b=Q6GTalvCh0u5mnMbTT5GEy9MN5s4sNE2rqr/25N0TD7ANCk1OqV9+QwjPMcU9CfpD7
         6JXNotuWWUjdFJjTLB+++ga3OFIko7gzKsXYGACfhTZgCEjDbsFO1UF9T2Z9aWRmiuDB
         hwAaWPOmXzCg0s3r5OlFqUzDQMr8C+OsYXVRvqirI1GJHETqUKnW9sZIU8rdpE1PL+vp
         vk7Sfx5cUg8Awqjnfs8sac+Rc0oeLRa+DgmNfejf189slPFsofl4fOliMaScQGAb3EHB
         2oVj1brpWLYzhGdE+miN/1tmyCCJ/MhjuIqqGVIQOmYVDzQqBjrPpp7xE1/Oy2NIVEa/
         m1Kg==
X-Gm-Message-State: AKGB3mJ2sRq81vxLTYYxFQW6pYStT3gMyFNrb06EcGrq90dIVkb3tIwH
        t3voMctYoEsc5LmagrJ+8IjDWVgv
X-Google-Smtp-Source: ACJfBothgm2HCHHMgnVh1v151Z8r6Ay5Bqjxu5MJioYD5FqRKoGckKM+7IjIMTRnAXZqEajtQI/qoA==
X-Received: by 10.80.170.87 with SMTP id p23mr8400345edc.289.1513178040457;
        Wed, 13 Dec 2017 07:14:00 -0800 (PST)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id z56sm1552690edb.72.2017.12.13.07.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 07:13:59 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/8] perf/run: learn about perf.codespeedOutput
Date:   Wed, 13 Dec 2017 16:13:42 +0100
Message-Id: <20171213151344.2138-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171213151344.2138-1-chriscool@tuxfamily.org>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index 04ea5090f9..4454a2713d 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -144,10 +144,15 @@ run_subsection () {
 		set -- . "$@"
 	fi
 
+	codespeed_opt=
+	test "$GIT_PERF_CODESPEED_OUTPUT" = "true" && codespeed_opt="--codespeed"
+
 	run_dirs "$@"
-	./aggregate.perl "$@"
+	./aggregate.perl $codespeed_opt "$@"
 }
 
+get_var_from_env_or_config "GIT_PERF_CODESPEED_OUTPUT" "perf" "codespeedOutput" "" --bool
+
 cd "$(dirname $0)"
 . ../../GIT-BUILD-OPTIONS
 
-- 
2.15.1.361.g8b07d831d0

