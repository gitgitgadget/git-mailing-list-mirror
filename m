Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6775C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4BF2146E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXvy3EFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLQFHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:07:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39306 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfLQFHs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 00:07:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so9825230wrt.6
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 21:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V14mNc57rBCn5QXF+8CWHLJ6BSS2smsHIE6g4bsKyNc=;
        b=sXvy3EFlmGI5SJhX3YH9gmkc1gRPIaRf3T811fFzakzUz+YpEqGrVXfQhg2aC1E7Ex
         jrAQVlOWi/NHpU976sWQt5twlkAxiu7EzgOFlO68jjyLSCejiVfTncTTSxPAMn57+Gf5
         03CD7bF/+wua6G635t4vfroc9ss5wyts96+tU6nsYgoJPSgzNO5wxNW76bEN+3zds5Zs
         pveHGQa0jVd6u+/2wB7R3x9MwsEbzHx5mKiQeSaxDKUqjHj7uOcAbcud/4bK14RAouKB
         8NgHEFcGkhJozeGbpf2oM495KeGSangbMecds3Z6dU/B6/Bro3bCKNP0DPFqwKQRZts1
         n4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V14mNc57rBCn5QXF+8CWHLJ6BSS2smsHIE6g4bsKyNc=;
        b=QbA/4V/kJNwq6DbGsqaQtyTJCoJjTg7Q4p7jH7InW4wHPQ4Wq36qZC5r7UKy1d3rNu
         eX0TJWNraGnm4DJBUJH4rOn7aXmpz6wVZyQJHWQX5Z0SMPhROmqnGDcnQG6sb2KVFLp6
         weJOHZb6onpWKIxp3YsrONv/Ov+FAKksFHG3NGPIDZ8b/AdCypFntOWaiX5ZgIlWqUX5
         6m3+MZT4J5iyNSNiy/3Pb1frmoVeLXO8sA78NaLoaifnSo4v+lmssEoQUFT4erdUW4Zk
         iLpNkzfZVhQ47HT5yCTTyTD4NNLpHwZNZIWPL4DWOMDpAzhRqvS1EN2g5loCSWZDGpBx
         HesA==
X-Gm-Message-State: APjAAAU+bxKAVRxRyaMrHFFw/2AE7JuS2h+rhYiFdcE5hA3ybTRkaDtS
        pktj2ATr8A94y00QHPggjYwJvyrq
X-Google-Smtp-Source: APXvYqy4Nr75QxqB5ZGhZijeD0astqPaSE+H6AqqTNy5sFfMpBWf325AFIhnBMWjkodUljwif78XXg==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr33454609wrn.351.1576559266628;
        Mon, 16 Dec 2019 21:07:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm23950681wru.44.2019.12.16.21.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 21:07:46 -0800 (PST)
Message-Id: <4ea4eeae0c1e23221012855168bf6640be93fd4f.1576559263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.494.git.1576559263.gitgitgadget@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 05:07:43 +0000
Subject: [PATCH 2/2] Documentation/git-log: mention that line-log regex must
 match in starting revision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Thomas Rast <tr@thomasrast.ch>, Junio C Hamano" <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

When giving a regex as parameter <start> or <end> in
`git log -L <start>,<end>:<file>`, or a function name in
`git log -L :<funcname>:<file>`, the given regex must match in the starting
revision, or else the command exits with a fatal error.

This is not obvious in the documentation, so add a note to that
effect.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-log.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1c52bf184d..5c3fd39048 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -76,7 +76,8 @@ produced by `--stat`, etc.
 	(or the function name regex <funcname>) within the <file>.  You may
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
-	give zero or one positive revision arguments.
+	give zero or one positive revision arguments, and any given regex for
+	<start> or <end> (or <funcname>) must match in the starting revision.
 	You can specify this option more than once. Implies `--patch`.
 	If ``:<funcname>'' is given, implies `--function-context`.
 	Patch output can be suppressed using `-s`, but other diff formats
-- 
gitgitgadget
