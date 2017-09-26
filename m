Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA33D20A26
	for <e@80x24.org>; Tue, 26 Sep 2017 19:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968490AbdIZTyR (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 15:54:17 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:53544 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965209AbdIZTyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 15:54:16 -0400
Received: by mail-pg0-f45.google.com with SMTP id j70so6479755pgc.10
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R09SI9SShC7hhotb320LIWjQmBSZH4q1b4VNzoeviCA=;
        b=UAJZCpS1lXLb/H8hCiXAHp3UfboN+90+zho4cTxG6hgmCI43JSu9+GnXNE9wVc9g2A
         COm/jCpcCfgG5pE3RlZvGXeLWncv9um/v3eYsiGt/q7LhLdHh/gfMKX7yu7acqd80cdk
         Tjjd8l4wxy2MYnB22yN8GLJ5OtaA7ia1jSYgbqIADNis/KyKQIVHSfUKkULdZlenLVUh
         yD6bdP88Q0zwsrtMs/9ViGEWteeQffvxg5MVUQOHOPpmzLoNPChOxvoY3TBpnt+Z2Dck
         ntK6v3aCdNLWLhkMcxb/lMJPo+zUyR7ptBGVVL2qoRhG2ThEUVUPMqyvID3oLJj3cccl
         QScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R09SI9SShC7hhotb320LIWjQmBSZH4q1b4VNzoeviCA=;
        b=WEsQKsuQNvxd3IKz2tOVwmrkGra4/4+973ATL5iZFeGGZ826rFzWbtP1Lk5Mu415mq
         LDHMgRPstUO1wBdsTGNIy9ic/s+cTPxTspx+HmCklDKYUZ2u1c1+Dg58MV38bU9nXmxq
         GA9kTYT35CWMAgjmi65Lz4dOBTUbMl+AHihzA5Dcpozi/LDK/decYglIgKdWNONJhsc8
         HG6LQ9TzVPFErBeINLperMS7hf8uxMu31p5omPn4WZVg6TZoQX762uUOjRpjYAe/PoGc
         fBG69g/B98BnTuapERLPOcNeBuaJMWXkVeZTo5VwsF9p0CJUThhPO4jGpJL5yNvRY3qV
         ty0A==
X-Gm-Message-State: AHPjjUi26UuQXDfOWhSp/V7r602B17rtxVHFivTGx3w/hwD0RVkONeAr
        ZmON3M405tH38MZnDaaR8PTNqg==
X-Google-Smtp-Source: AOwi7QA8Ce3KzexAxlo0U0OzdzucStBdWWqS4Gwxc0YTLfOMkVoayOcWUJrdRJ/iGjyR5iLV9uRdVw==
X-Received: by 10.98.74.74 with SMTP id x71mr11972939pfa.236.1506455655991;
        Tue, 26 Sep 2017 12:54:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7981:413b:8357:cbf7])
        by smtp.gmail.com with ESMTPSA id s76sm17808559pfj.119.2017.09.26.12.54.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 12:54:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     j6t@kdbg.org
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        sbeller@google.com
Subject: [PATCH] t7406: submodule.<name>.update command must not be run from .gitmodules
Date:   Tue, 26 Sep 2017 12:54:13 -0700
Message-Id: <20170926195413.3916-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <0b69c0b0-6246-2428-b4b0-bb3ef3cb5ae7@kdbg.org>
References: <0b69c0b0-6246-2428-b4b0-bb3ef3cb5ae7@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

submodule.<name>.update can be assigned an arbitrary command via setting
it to "!command". When this command is found in the regular config, Git
ought to just run that command instead of other update mechanisms.

However if that command is just found in the .gitmodules file, it is
potentially untrusted, which is why we do not run it.  Add a test
confirming the behavior.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

> This test for a missing file is certainly a remnant from the
> previous iteration, isn't it?

Yes. This is a good indicator I need some vacation.

Thanks,
Stefan

 t/t7406-submodule-update.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 034914a14f..6f083c4d68 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -406,6 +406,14 @@ test_expect_success 'submodule update - command in .git/config' '
 	)
 '
 
+test_expect_success 'submodule update - command in .gitmodules is ignored' '
+	test_when_finished "git -C super reset --hard HEAD^" &&
+	git -C super config -f .gitmodules submodule.submodule.update "!false" &&
+	git -C super commit -a -m "add command to .gitmodules file" &&
+	git -C super/submodule reset --hard $submodulesha1^ &&
+	git -C super submodule update submodule
+'
+
 cat << EOF >expect
 Execution of 'false $submodulesha1' failed in submodule path 'submodule'
 EOF
-- 
2.14.0.rc0.3.g6c2e499285

