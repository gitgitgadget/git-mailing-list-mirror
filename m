Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E89420357
	for <e@80x24.org>; Thu, 13 Jul 2017 06:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbdGMGvG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 02:51:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35384 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbdGMGvE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 02:51:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id u23so3077861wma.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e5Vl2SZsOzWmooRY6z/1CA4Fm9hxaln5NEB+12m3Xk4=;
        b=QeT/vug3fcw6mTfTahOJDaPYIgy2Poi9X9osavZvQLdDx2CnZerLFEnarQOzikz9O2
         NGZW6dTYrX5UIupnzyLWr1TYmMEcyLxbrueV1VzDu9/f1i2pmLS7of/xzmkwUmt32nco
         YINdHwA5d2uds2MxNFZVHhXFy/8uc3wdzgpTu4nLGHMFx6MwSrFKvA+M3QlimOaFbZiA
         5D9WfMr3CyIIZGdmhwarEaLhyGTjJe1gQZwbEzSDC4AT+i+cZgbscQ9geDRpITp30mnY
         /3O7hHJsUVFPzbHD0P2C/X+OQzSZyWSnqSUTDKdqBxiBYFOuafQeU5sjzrMv1vHrdqeA
         k5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e5Vl2SZsOzWmooRY6z/1CA4Fm9hxaln5NEB+12m3Xk4=;
        b=rlmLW+xnHohoVoKEIOvGdmxxZndlkchNQOEF8znRPmwBu175bH+XssOTNJaE9rOh1r
         JMKsAS9QmJ6OHpTM726kJDpQcHKbesiT6oL1eHG7IB9xGy6qM4z0kkrfFn7+oXFsige3
         UReF3FjaLoakHhYc/jwOv4MLFly0gZ/TOpj/wA9tfdQgt/Ro9jRQ69UfmhyBbKONwAPv
         CbNTU517HxFThoanV5HhaT0b0fDLVuT08f9J7b9tqkXJBM5ZwW46br5GsBcf/p7BNT5h
         ffHqJ1J/5vN2pkkHrn8SGVr2IzC7iaq0h2Gc+yOShLYfEsqfXWByHFmZsNZx17tnoTmX
         /mJQ==
X-Gm-Message-State: AIVw113wWx2JowUJbzhBigKZjN/O8noYLzXSm5hLUvWvc6Nx5ON1k7GK
        BM8AdGu425H9Al1Q
X-Received: by 10.28.17.78 with SMTP id 75mr847576wmr.63.1499928662823;
        Wed, 12 Jul 2017 23:51:02 -0700 (PDT)
Received: from localhost.localdomain (43.40.120.78.rev.sfr.net. [78.120.40.43])
        by smtp.gmail.com with ESMTPSA id l20sm3332564wre.25.2017.07.12.23.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 23:51:02 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 1/4] perf/run: add '--config' option to the 'run' script
Date:   Thu, 13 Jul 2017 08:50:47 +0200
Message-Id: <20170713065050.19215-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.2.647.g8b2efe2a0f
In-Reply-To: <20170713065050.19215-1-chriscool@tuxfamily.org>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is error prone and tiring to use many long environment
variables to give parameters to the 'run' script.

Let's make it easy to store some parameters in a config
file and to pass them to the run script.

The GIT_PERF_CONFIG_FILE variable will be set to the
argument of the '--config' option. This variable is not
used yet. It will be used in a following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index beb4acc0e4..1e7c2a59e4 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -2,9 +2,14 @@
 
 case "$1" in
 	--help)
-		echo "usage: $0 [other_git_tree...] [--] [test_scripts]"
+		echo "usage: $0 [--config file] [other_git_tree...] [--] [test_scripts]"
 		exit 0
 		;;
+	--config)
+		shift
+		GIT_PERF_CONFIG_FILE=$(cd "$(dirname "$1")"; pwd)/$(basename "$1")
+		export GIT_PERF_CONFIG_FILE
+		shift ;;
 esac
 
 die () {
-- 
2.13.2.647.g8b2efe2a0f

