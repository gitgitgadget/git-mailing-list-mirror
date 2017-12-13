Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944B41F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbdLMPOI (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:14:08 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:42458 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbdLMPOE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:14:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id b199so5748635wme.1
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+dxfK4CObia+LH+lscHey0060NLUV/h9rIGIqwlONxg=;
        b=W7uV2RiM2dOoaX3dGTKrNHqqrL6sXJ+pRN7X5qAHNOidK7ogEwTu/Cf1VTFxc1ZyKh
         Fhjgc+TTbPIwjSPCZWYWukSGzqY6iZmjl5Pkjl/LcxprcEBabxMhX8yaoOsk/OG866sV
         z/hju1iHs1lU5TW6TGis/qObibsoCqfxtbxAuIsP2sq3c1Pq809nN73ofE2jxB4D4svf
         Mh4OpdSVGJOip4JzemQkWgR7IGPfYkJ15RYD91qCs1QhYm2VXdXuIGmU5FGHiuFqPis9
         MGaaeQMKoeTL5chds8qVjvioi7AokodcO+VKibLQvNUbfLlRqOqwJgk3WFESRvrs8Ry2
         xWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+dxfK4CObia+LH+lscHey0060NLUV/h9rIGIqwlONxg=;
        b=WRWLCuo1wP1tWHBvqZXq1e5LHPD4/UjNDAtPhAWOndSDaPSS6Unme48+HfRgdjsW+Z
         tmMBV8v1MK2OW+C5Ypz0KAonwj/V3DHvG6RcV9495NGek5lBFMOPXLmBa3tlh6upcC6P
         GLJOlOhB8dQyVC2WQRNdVVumCxHeipZzyhlt2hB/hj/+Z+wTk3MP1ezKKTlphP9AJNPi
         Z1ytjNBsfC7P/EyZaR/oc2vxTexSk6MM1IB7AegWpBUoPjphmSkI40jf1ZsASIRh3/9J
         hFyz51Hyc8SgcadFaxzfW/RLxiyuMq/+S0KuDZ7xrskwqGz1mmCTKhQdqt6VdtwMJO+3
         bgMg==
X-Gm-Message-State: AKGB3mLqUIRJ5EYojxKKhFHjQssu3vmzzV+wuXAEO0YQf5NPFJsaAvZ8
        cr6JJsif02vdUlTigE9VGUneFina
X-Google-Smtp-Source: ACJfBos5tJnBN3r5WJg66RXPDbwSp+9zFBhy9Ok3A1Y9HXTN2zRw99ex2gdXfpla5Sccl5V7VpVMyw==
X-Received: by 10.80.138.34 with SMTP id i31mr7712351edi.193.1513178042883;
        Wed, 13 Dec 2017 07:14:02 -0800 (PST)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id z56sm1552690edb.72.2017.12.13.07.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 07:14:01 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 8/8] perf/run: read GIT_TEST_REPO_NAME from perf.repoName
Date:   Wed, 13 Dec 2017 16:13:44 +0100
Message-Id: <20171213151344.2138-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171213151344.2138-1-chriscool@tuxfamily.org>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index 7b7011f19b..279c2d41f6 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -137,6 +137,9 @@ run_subsection () {
 	get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf" "makeCommand"
 	get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf" "makeOpts"
 
+	get_var_from_env_or_config "GIT_TEST_REPO_NAME" "perf" "repoName"
+	export GIT_PERF_REPO_NAME
+
 	GIT_PERF_AGGREGATING_LATER=t
 	export GIT_PERF_AGGREGATING_LATER
 
-- 
2.15.1.361.g8b07d831d0

