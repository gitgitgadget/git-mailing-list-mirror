Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3286620285
	for <e@80x24.org>; Wed, 28 Jun 2017 21:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbdF1V60 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:58:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36397 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdF1V6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:58:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id y5so13868780wmh.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3Yv1bardrUnbYdlKOCiF379FMyHYHYszuA04qlc3uA0=;
        b=UhYmRRISahBwcmdxgQ/FSdwM8umiASSJdhQ+n4MRdNR3Q0ekWy2NudkCh/kZZuDbSm
         B2DtAGZwR+Jpat9AGwZmO5Kuf1zZkkOZzwoQsRhjbe+l0njX4nXuGNyMX1pPijQawpYT
         jUMsjG1jhuOWde1IjJImzCj86Qxu/r30EgsbEfu8pRc5vvAWN0AQffKtzRsF/qb9SgR7
         Yo3+bL+VgZ0ycJZJQTVSO0gNL3+Dfra/0GzTSU7UBWJGz2kvLXJr1XHg1QmcsCG5eIqU
         pewLATIiFy5o7OHo43gU9ZkBMSV3oi2z1OQFz/cPPBmYF3YYbUhBi0NR/0cqdOkpX3B3
         9F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3Yv1bardrUnbYdlKOCiF379FMyHYHYszuA04qlc3uA0=;
        b=jy0dk67HjyPBByyeowtGl8n/yDA1tf/SgTBFLHdIjpDne5TwmVe/bZ2N+X/gQ/gLY4
         FgZTi1c2HxHBcDI7ZcM+WjdIKqR9qGIaD9RRnF7VPmXEnRTuoDlptecC/hOYevgWe5xU
         hhzXulGVjRZEbm9wAiguqXorDPsi9fYQfyQQdwb6d5skiaK7ipB7hhsI4Lvg732ScoH2
         foVAsBNTCk1g7bbaJIShUquOKPSzaBZbFKdD2ix+25BzQ8A1q0KKKbjl7GKmoFRUGyqy
         fHPCJD6p9oF9MOfx3OBHDBTJ9ktkc9cfuGeUL1kNfWhoEAppgPXSJKbnMAJmdkl1H1Fn
         NEJw==
X-Gm-Message-State: AKS2vOwXdbuUcpzpZV2PJEKUfC0Gi7RLHC1tUrFftdDKODwZtUZCJJKM
        elZ3tI3g73ZuvPibs50=
X-Received: by 10.80.185.3 with SMTP id m3mr8962982ede.41.1498687103977;
        Wed, 28 Jun 2017 14:58:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g25sm1926975eda.59.2017.06.28.14.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 14:58:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] grep: remove redundant double assignment to 0
Date:   Wed, 28 Jun 2017 21:58:05 +0000
Message-Id: <20170628215809.23060-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
In-Reply-To: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop assigning 0 to the extended_regexp_option field right after we've
zeroed out the entire struct with memset() just a few lines earlier.

Unlike some of the code being refactored in subsequent commits, this
was always completely redundant. See the original code introduced in
84befcd0a4 ("grep: add a grep.patternType configuration setting",
2012-08-03).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.c b/grep.c
index 98733db623..29439886e7 100644
--- a/grep.c
+++ b/grep.c
@@ -38,7 +38,6 @@ void init_grep_defaults(void)
 	opt->regflags = REG_NEWLINE;
 	opt->max_depth = -1;
 	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
-	opt->extended_regexp_option = 0;
 	color_set(opt->color_context, "");
 	color_set(opt->color_filename, "");
 	color_set(opt->color_function, "");
-- 
2.13.1.611.g7e3b11ae1

