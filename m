Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E57D1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 21:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754806AbeCGVLq (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 16:11:46 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38186 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCGVLo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 16:11:44 -0500
Received: by mail-ot0-f195.google.com with SMTP id 95so3438610ote.5
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 13:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SvX1TF9mSq7sIuySNkol1bCXLhmfHKmq00bPcnGHV+0=;
        b=iMVB15RP4lEPnFXrXG2zvTv9oHIKfC6/GmKtKE69s0k/a2iFzE8NgfIWX/dh0SEPYO
         gZKI2xDFNUDhjVQNPvgD7RLvoyMdyLnnbVseb7NDRsCmaa+2Byyft31jKKbTKtOqWlJc
         zaeMAOI/H51kfOESlvB3M3umKlcrOXMS7MAFmAELZvIzxxOgPYyzxfXTXG3H8xBXo+/T
         LTIN/3FPxRqbYaum6en0RK+8Tp9xfXCGSaaJkI5SQeJTS5cZIlXhKiVKUHs2HhAP9a+f
         LJBRdXPAuMKZnIhSwus87EzQNKz9AuRRm/+fD3x03inu96Iyk5VTVraaRYl8/rvxFLnj
         dbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SvX1TF9mSq7sIuySNkol1bCXLhmfHKmq00bPcnGHV+0=;
        b=ViQurPD4KXhqZXmwjgUyal9o3UpGzoUbAxbpsH3zfp8pXpmvpAU3wziTnsATSKsbF5
         ODAnVef9UU4pYI4OjR/zKmSfIfNsVrxvJdJeB/JcHtPF57sMxcSwQUtoGTgE66dAFeV5
         JY95frxwUC2JYbDXXYn3uXNcU6nXRDQU16I9eqoZAhFZzurAQkHNty1U45HD+emoxn5c
         vl7OegyMEuP47OiroA6177NC2nMJsy6swdnehAT4hpQXfFUfhIBze4wZFgbxmkpsr3Jn
         RLfBjlfibuKvUYzQUmNhPMjKpYz70sDhsHspa9LE3z6JqMXuKEwDqA9Mqmn3QaPtJC/I
         c4JQ==
X-Gm-Message-State: APf1xPBVwi3+OjzBV1uAWBBQjqzf+nnrfUMmzK9SJkb8BgDWFlUqApj7
        pfkoctcOE+3Cr6MQR+6BCgBX0A==
X-Google-Smtp-Source: AG47ELtO/JD/i3Vrv7lm1PV8V+DANonPKPONrFp2/5DgKZUoqsZpg1G4kkLH6nLvDMAsVef6TmsNMQ==
X-Received: by 10.157.71.25 with SMTP id a25mr17539929otf.42.1520457102812;
        Wed, 07 Mar 2018 13:11:42 -0800 (PST)
Received: from M1075.tabletopmedia.com ([12.193.167.218])
        by smtp.googlemail.com with ESMTPSA id u2sm5689457otf.69.2018.03.07.13.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Mar 2018 13:11:41 -0800 (PST)
From:   Robert Dailey <rcdailey.lists@gmail.com>
X-Google-Original-From: Robert Dailey <rcdailey@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH] Support long format for log-based submodule diff
Date:   Wed,  7 Mar 2018 15:11:40 -0600
Message-Id: <20180307211140.19272-1-rcdailey@gmail.com>
X-Mailer: git-send-email 2.13.1.windows.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am experimenting with a version of submodule diff (using log style)
that prints the commits brought in from merges, while excluding the
merge commits themselves. This is useful in cases where a merge commit's
summary does not fully explain the changes being merged (for example,
for longer-lived branches).

I could have gone through the effort to make this more configurable, but
before doing that level of work I wanted to get some discussion going to
understand first if this is a useful change and second how it should be
configured. For example, we could allow:

$ git diff --submodule=long-log

Or a supplementary option such as:

$ git diff --submodule=log --submodule-log-detail=(long|short)

I'm not sure what makes sense here. I welcome thoughts/discussion and
will provide follow-up patches.

Signed-off-by: Robert Dailey <rcdailey@gmail.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 2967704317..a0a62ad7bd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -428,7 +428,8 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	init_revisions(rev, NULL);
 	setup_revisions(0, NULL, rev, NULL);
 	rev->left_right = 1;
-	rev->first_parent_only = 1;
+	rev->max_parents = 1;
+	rev->first_parent_only = 0;
 	left->object.flags |= SYMMETRIC_LEFT;
 	add_pending_object(rev, &left->object, path);
 	add_pending_object(rev, &right->object, path);
-- 
2.13.1.windows.2

