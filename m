Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4BB1F424
	for <e@80x24.org>; Tue, 19 Dec 2017 00:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966056AbdLSA3l (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 19:29:41 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33576 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936200AbdLSA3h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 19:29:37 -0500
Received: by mail-pl0-f65.google.com with SMTP id 1so4429335plv.0
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 16:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XRo0qA4+I29FQoO4r8ZbCGqYryMhNTKk9F2i9AAWXI8=;
        b=j20E5PKUm76QWg3OLRb2ObFwWeJYI1BNwE2kT5KbNrqyGpDqcOA5g50XZNmcV9Hj/S
         p2BAJVGF/wiVNz2ZW31zANiSMpwy0g1lTJhms2I5xkPCOrDqgIH8ceFwcX8akfKOqo7Z
         NUZ90JY7UMptKipfRHlGDhCRbTE6W2PUmDxq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=XRo0qA4+I29FQoO4r8ZbCGqYryMhNTKk9F2i9AAWXI8=;
        b=RfwPSFJqF4txHcIi6hknaVLFymt6m5JOVi7Y2v5hdBs5uxYv+qwg07+K5TM3bN29Te
         N82WToGtBdJ4+34O5KJzYB/IhUHwTB9vU5y1uTGPjD0mEUQfh9ujSzgf6kydLgm0BPZd
         Sh1NiymFaZnYnfnMoHD9BC6iIE1rVDzybx3tEZXLhzDdk3ApAltzfiN21Q9iuMHMU8e4
         n0R4SrFwJYtS67G4NzjLjvCspoJevqI+Cnpw1caR1xzaoIzYrqSJjpk1P44U7Q5T+tNH
         lfjhrEdiKywxjpQ3qt2j33SOIq2TrrGhkGLAzfzZoZkkQYxYVOoJfr38R1ihGaAp0B/d
         zkOA==
X-Gm-Message-State: AKGB3mLsFCCWCvqaHwUtDAYFFj1c0tiyR8OZyUO7cyV4Dl1YiOPAaY+u
        iZyyUdsV5J3Tf0HOdSgSMjYjBe4U92A=
X-Google-Smtp-Source: ACJfBos+Y3MQteNzf8vDRJBixXs4iGJ+QRRrxV5LIfYCIZkScxpPuK50oRlQgx1Zzm99u5i5b+Gsww==
X-Received: by 10.84.233.1 with SMTP id j1mr1417289plk.311.1513643376258;
        Mon, 18 Dec 2017 16:29:36 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id b10sm26056581pfj.20.2017.12.18.16.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 16:29:35 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 2/6] fsmonitor: Add dir.h include, for untracked_cache_invalidate_path
Date:   Mon, 18 Dec 2017 16:28:54 -0800
Message-Id: <c8cf261d9d620d8123e8bfa5aa952fa55685a8db.1513642743.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.626.gc4617b774
In-Reply-To: <20171219002858.22214-1-alexmv@dropbox.com>
References: <20171219002858.22214-1-alexmv@dropbox.com>
In-Reply-To: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
References: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This missing include is currently hidden by dint of the fact that
dir.h is already included by all things that currently include
fsmonitor.h

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 fsmonitor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsmonitor.h b/fsmonitor.h
index cd3cc0ccf..5f68ca4d2 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -1,5 +1,6 @@
 #ifndef FSMONITOR_H
 #define FSMONITOR_H
+#include "dir.h"
 
 extern struct trace_key trace_fsmonitor;
 
-- 
2.15.1.626.gc4617b774

