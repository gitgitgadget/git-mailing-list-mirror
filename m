Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998471F459
	for <e@80x24.org>; Tue, 25 Sep 2018 11:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeIYSB0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 14:01:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34065 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeIYSBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 14:01:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id j25-v6so12427107wmc.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 04:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fV41yInvCdhsvUv2wVmgXInhjEVSuqiAazcH8xp6V44=;
        b=vgaiU4eb7nv67DmxkB5Y7EsgqAkfrOLWpiRzIJQ/42lUYExBwlDIP3tHXXGvK10Tj4
         85dKe5P0Rtdlg+2pNuUdbYtLDTeQ852mOkeHGT7uwq4rql63Hs7wkDGfK6ve2ZYJejDe
         rzzQb3cQ4rorOCoU1Q3jKZ1fK88syHdkxuwmsp86pm7oyCoOGMfpHMDwF3NA6AnU4Eyq
         aD/ivYlcgBC61WfVkIa5qIMCiXcroR8j7O+URXGOH9Tgyj6qPKXsvNsTDhbQJ1fS5nru
         jBajfjEZ/Gut1QNqOvOknEOrwSvvzwCj9NfJ+sRtOGM7q03lmWahLBvtDDBdySNA/ym6
         Nk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fV41yInvCdhsvUv2wVmgXInhjEVSuqiAazcH8xp6V44=;
        b=sxG8l8Ms2KGiYYjXFfU2K5Ub1ejtpREYh0JYPaArS4rihkLuj9UdQe/7vHdqK25KVX
         j6lXCcnnbbSXfA6fvw/U2dR/6cA20Q1NyYN1kWY6r/JXu45WX+xi+l03yWlWfSRNPyPO
         zJ8CfJCvOGwmfuqROkRXjjDdiNu5TSEXUGqm88uefpbZ4YWfcLesyizNGST4aZiOk8pQ
         ORikZ5reFOzdcgfJrl9w3sVf8DRUvwcmVQe+zHmjL+CVPoO5RaOwPr6TiQsrPVBH5ZQe
         5z3uASERobxcK3XPbn/+gGkviKAOqU6XncZSO1B2UQOrnFFRq2r/bbNxlTkfpJ+SdCT+
         9qQg==
X-Gm-Message-State: ABuFfog7rBLQjFB+gix47nhxhGXFWN5PiGBEuSFeqb99iFSWSOnfjki3
        npvB+pJGpE37EQen3yJVHP/Eo7Ku
X-Google-Smtp-Source: ACcGV621955V2cDm7zV67UIOaZCNwHX7v2bKqrQ+J3DmLphN7UCQCvZtxb4fNP/VZjW11qJXcf7sfg==
X-Received: by 2002:a1c:c8d:: with SMTP id 135-v6mr394897wmm.116.1537876452628;
        Tue, 25 Sep 2018 04:54:12 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1998628wrr.91.2018.09.25.04.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:54:11 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 8/8] Documentation/config: add odb.<name>.promisorRemote
Date:   Tue, 25 Sep 2018 13:53:41 +0200
Message-Id: <20180925115341.19248-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.19.0.278.gca5b891cac
In-Reply-To: <20180925115341.19248-1-chriscool@tuxfamily.org>
References: <20180925115341.19248-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad0f4510c3..9df988adb9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2655,6 +2655,11 @@ This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
 environment variable, which must be a colon separated list of refs or
 globs.
 
+odb.<name>.promisorRemote::
+	The name of a promisor remote. For now promisor remotes are
+	the only kind of remote object database (odb) that is
+	supported.
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
-- 
2.19.0.278.gca5b891cac

