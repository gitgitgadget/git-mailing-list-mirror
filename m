Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D303E2023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbdEQC7J (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:09 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35807 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdEQC7G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:06 -0400
Received: by mail-pf0-f179.google.com with SMTP id n23so84854142pfb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HYFdFpBUP2Jrcw8vjzwQJDG4TZnJhmnGMZFZ247AIeg=;
        b=Og281DMm6TP3AhrZ7wLRNBJQhKjv0PgVj7/IH62F4GS4WS1o/eeuM5qo7ByFVAtqfj
         IiHY7LP4NAdMKPmXUiZAkvvM3MNtjT70ixlwhQnhUZvPUQTgSqWvGj0u2pWEjSlyR3pO
         Th/58/oOKwGFbBv+O75vgkskmY44+oU2Gbb48FhrY4DFYF0bLu4Pdt1pVYoadNnYDgTy
         XLvaP6wdJhvUd45sjSygPo1QU8C/54r0VbzpOrjhKfrLQb2Vdwl4LgvxQL1olBMRxhI0
         /kwh2qCuBkjr4IcTJ8lwV000RJC7iEHz6PB+VEFqI/UWcb5bSxdk1VBBamT6sufU/vwe
         NYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HYFdFpBUP2Jrcw8vjzwQJDG4TZnJhmnGMZFZ247AIeg=;
        b=tlT7s9jfjdlw+iTJ1hHUn4aO51Dnd+yM/yQyF33GlVza1nYSwFuWlBV/lBw9t1qaMj
         y77MrhHHsF//ckCxSCHlgvpjaEt5ut3SY9umetLTDQYP3qYTBmBQdgru0c+/QRXsdkdq
         FlR9SH0nsS09FXciXme9vQAKNI5U+mnTzDRIJSeVz3IGMYgLFHjgW39RkJ0SZFSTOYsW
         uFHkcrjqFDoIBWUkC3PbZkzi9nmRhYbLH+HTF0zgYxvUU9o7lMRNU7KowZ7d2Hj7Z1Yx
         JLMMgmryW1WwtX2SIbyZtXzBBijNVOpX8Zs14tteFtKWGnBxIpWDrT2O/X+IQ0iPsJM5
         71gQ==
X-Gm-Message-State: AODbwcB/D+xoR/O/n9AhihcogQp6w9OXOGoceyJXqfS7qPe3TgaFjiPl
        YUVfHoKdCnGuYlIz
X-Received: by 10.99.121.200 with SMTP id u191mr1267378pgc.113.1494989945339;
        Tue, 16 May 2017 19:59:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id m8sm647562pga.34.2017.05.16.19.59.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 01/20] diff: readability fix
Date:   Tue, 16 May 2017 19:58:38 -0700
Message-Id: <20170517025857.32320-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have dereferenced 'p->two' into a local variable 'two'. Use
that.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 74283d9001..3f5bf8b5a4 100644
--- a/diff.c
+++ b/diff.c
@@ -3283,8 +3283,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	const char *other;
 	const char *attr_path;
 
-	name  = p->one->path;
-	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	name  = one->path;
+	other = (strcmp(name, two->path) ? two->path : NULL);
 	attr_path = name;
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
-- 
2.13.0.18.g7d86cc8ba0

