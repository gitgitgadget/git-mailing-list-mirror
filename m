Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B647420259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbcLGPh0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:26 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36523 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753437AbcLGPg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:58 -0500
Received: by mail-pf0-f196.google.com with SMTP id c4so20788166pfb.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oRVn74MRODlyatMsduIcVt3reAFQd3PbKMZQ9sr1LAw=;
        b=P295oB5PNJGElQZpP5BRR8m3jmCX4MXZOQNTiWSnRuIfLyv6DYoiPpuSAWulOXEbmJ
         UMmSFAXQjUQcYVBMF2G59kaFJjz3e5H1dgNPbruJgHOPRorC0JpM5vnwG+4Jn72/GsJM
         CgkmsYLHPFlPzgsW4z2BFwMGb1F7V3pkrVwWQKiFeWByr15C1CBB8SHxRqvdxRZkbsRY
         zF67Yfw5bPoABYb0aVQf1fBvdnF9FqHaZYTCAuBfq6Z5SCzfH0tLKSm/eyrZQxm4jor2
         CBpclw6i3msMYgJBjmCFEnd//yJFiDP+tjiJVcySRGjErNhuMYQWbrRDhsJIIArkdUQk
         Hs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oRVn74MRODlyatMsduIcVt3reAFQd3PbKMZQ9sr1LAw=;
        b=YyHg/6V61w06QQK9o2DU4LSX4RfEwSBtsxSzzJCwuWzHqq6EPvoHWze/gyld2amizN
         Yn67gssJJBytNkMHtVRsp7qr5rOfB8zaqcmB3SQi7ferTs1YvsJCvLsCCff0ntkGB0o7
         /501SxVlu4NU4lLNG0422lFtAwHQf31OqMaF/Kd2zPJjOv7LOpTGrC6xPDNdHYu+gDhm
         x1WFfrsJHmRT8rAGQEUSFMHWoRDGrCbzXozi/jWMfOcb61Is8kMINKpAuAD9eI76bF9w
         iK6Ui5uJb8cEwWPTYANr/tOxZf0yAdtX24bzHWSwbuIHYOPjWCo7GN4PqlHKxG30f7j8
         XmpQ==
X-Gm-Message-State: AKaTC03pVMXJZ2yE/x/oh+gnX93SRim5cgik2w7Qk2zok3x2W/nqdKYYy0TMl3Zxe703NQ==
X-Received: by 10.84.216.26 with SMTP id m26mr149105984pli.22.1481125017851;
        Wed, 07 Dec 2016 07:36:57 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:57 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 17/19] branch, tag: use porcelain output
Date:   Wed,  7 Dec 2016 21:06:25 +0530
Message-Id: <20161207153627.1468-18-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Call ref-filter's setup_ref_filter_porcelain_msg() to enable
translated messages for the %(upstream:tack) atom. Although branch.c
doesn't currently use ref-filter's printing API's, this will ensure
that when it does in the future patches, we do not need to worry about
translation.

Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 2 ++
 builtin/tag.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0b80c13..4d06553 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -656,6 +656,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
diff --git a/builtin/tag.c b/builtin/tag.c
index 24bbe24..774e955 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -373,6 +373,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	git_config(git_tag_config, sorting_tail);
 
 	memset(&opt, 0, sizeof(opt));
-- 
2.10.2

