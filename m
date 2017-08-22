Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 954531F667
	for <e@80x24.org>; Tue, 22 Aug 2017 18:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdHVSWt (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 14:22:49 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33424 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdHVSWs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 14:22:48 -0400
Received: by mail-pf0-f178.google.com with SMTP id k3so8007226pfc.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U0JhDXZUALFen78HxRW4EvmHuwTim/9r8zfFf2l3424=;
        b=MV4h6dBxppHPKsgvYZqNmuF+65Y3VCYQqzaEePbfhn6CAML/dApkdvfQxIU6sL/z87
         vVf344BQ258GGuZEyuGfH1O3RIw8NLX42brc/MQDA52D4X/7T7Vp3JTjAA7GLI5ySg5q
         xPcNG52l+qOw5U5SYcpnlCOs/hVa5XKxMskE4QOM+f1qHWb+tCxLrcj6gXQdLRfnmAY6
         jvjWEUJD745ZEgI2AjJa29gy0RwXLxrfAiS8yudd+B/9MVC1qPWwAwQyt6P6H6pl/3DI
         xkyjpmzyX2LucS6YiM8N67LUK2I1C2fBcT/RaDnkdFdMsFfQti18psF2Qg10+w/YSUL0
         Pt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U0JhDXZUALFen78HxRW4EvmHuwTim/9r8zfFf2l3424=;
        b=axIr0KgRcCEomj25axTdl5wWYGKYcB3x3pTeY6zbbCLqFMrZz7RHL3v7sCzQOuVKXD
         BjIScURYjXWpOv4XpoA1Hzch0YTn9c9BHv2Rjd8gr/PFST24RkCTx8GmnDNEkGt60gzb
         Su3G9eSSR9Ybj11nmEmuvXrvh4GGcmNPtr+6xQM9yqxGZUr92Tmeh9MSIgNfOLBMYhpW
         SQyCtEAWkj1E4ylhKDV8BjpUr/bgcqw1i28bCbe/Gjr46OOVTjglcLkia9uqqD/Y09Gi
         wn3sTE60mOpQ4QwCiIGoA7aM9eNl2H/d21WcKdBq0OU0rmW0Gn7ZMG4PyEfrRDcFZ+L9
         HHGA==
X-Gm-Message-State: AHYfb5gXyaWgs2RIXw0Fcy7rjlEOt0DOdmp/kr5ZB0h8BjXg2TiUHioz
        WHDaHWWiAVVLnsOUniiFyQ==
X-Received: by 10.98.141.149 with SMTP id p21mr49457pfk.264.1503426166852;
        Tue, 22 Aug 2017 11:22:46 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id v6sm28461005pfa.135.2017.08.22.11.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 11:22:45 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] Doc: clarify that pack-objects makes packs, plural
Date:   Tue, 22 Aug 2017 11:22:42 -0700
Message-Id: <20170822182242.20862-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.342.g6490525c54-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for pack-objects describes that it creates "a packed
archive of objects", which is confusing because it may create multiple
packs if --max-pack-size is set. Update the documentation to clarify
this.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
It took me quite some time before I realized that pack-objects actually
may write multiple packs, the opening lines of the doc confusing me.
Here's a doc update.
---
 Documentation/git-pack-objects.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8973510a4..d8264ad57 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -3,7 +3,7 @@ git-pack-objects(1)
 
 NAME
 ----
-git-pack-objects - Create a packed archive of objects
+git-pack-objects - Create packed archives of objects
 
 
 SYNOPSIS
@@ -18,8 +18,9 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads list of objects from the standard input, and writes a packed
-archive with specified base-name, or to the standard output.
+Reads list of objects from the standard input, and writes either one or
+more packed archives with the specified base-name to disk, or a packed
+archive to the standard output.
 
 A packed archive is an efficient way to transfer a set of objects
 between two repositories as well as an access efficient archival
@@ -47,9 +48,9 @@ transport by their peers.
 OPTIONS
 -------
 base-name::
-	Write into a pair of files (.pack and .idx), using
+	Write into pairs of files (.pack and .idx), using
 	<base-name> to determine the name of the created file.
-	When this option is used, the two files are written in
+	When this option is used, the two files in a pair are written in
 	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
 	based on the pack content and is written to the standard
 	output of the command.
-- 
2.14.1.342.g6490525c54-goog

