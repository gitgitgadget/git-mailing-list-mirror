Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F1A20954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbdKVWie (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:38:34 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:38676 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbdKVWic (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:38:32 -0500
Received: by mail-it0-f66.google.com with SMTP id n134so8176299itg.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 14:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PvL1VPMETn6uo+CUFwtAseLcdO359WNx2QEGzUTnmXQ=;
        b=eekJiluXnQi86Iithz68hT7JIPZhEWR0fBUCw6bPNsd1kSt4xABYh62sxFtVnqAFLi
         o4B+InRshWfpAk7oEP/BQEDxVRyaicXwISPfBV/n+as4Tfe33hJr6+qnCFN5EVMH0AuX
         cm64aK5upULXdu4NZ8j7epamtPjZpmUHtKgjh05eAM/egO3mSjAs89Rg86a2f87mMwLE
         bZPmp2S8EOhiL3gJJnYKyTMfQ+3lTSr7DT5GZSAzirnEZTOGA/Zro/tka3KJEAuYThTk
         xVEFS5F9a6gG35M1/GS31HNgWmEtmL2H+NW4HDuhQNJkFPp2gSPYYe72mPizQS5QD7il
         etPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PvL1VPMETn6uo+CUFwtAseLcdO359WNx2QEGzUTnmXQ=;
        b=kEm44fbpzFMbR3r39irIQGJLL+ZnIdKITbpGjIbFw/MSOyIdT8YOoZBlAZXy66j/0y
         GiZuJVSqGo8ovabhKak05J0+KFDB0/3C/uPrDlUkH8W3eQ2f9uWJjWAB0kU0vXhug4kc
         afjQ2iLNAnsSyo2HKABct+5gJUn4lX6EpjGmoBAIvf3ZyftXl8AU94h/NmjLx6y/gnDL
         Vf12E5x5FmSb4XPPk6Oq3Gp9m0UPM8+cbFe8MA0245a/wsTfvXBj3E7qqq5+A806Y5cw
         JpQQ1Fau52K4bWn7Ap5cEQaCPccGeXMMm2fv9YQx0blrHKbuFJXfEgNkkONjlugrkk5M
         Wrjw==
X-Gm-Message-State: AJaThX5tcRsyoLsCbQz7Buj2fcjCWUJdsccwAyXLBNCM7cYKEMsAd3+s
        1Dk/2kfdwJMeTUTAunQ0GDxuGAsQC4o=
X-Google-Smtp-Source: AGs4zMZp/vhLvytLZAQtEzlw2v/xygPZVMgeHIB1MirGmgN20Zj5cGx7kaJZKcKRY94nV/PDbWVOBw==
X-Received: by 10.36.48.4 with SMTP id q4mr8917186itq.34.1511390311401;
        Wed, 22 Nov 2017 14:38:31 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w186sm2493363itd.12.2017.11.22.14.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 14:38:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] Documentation/CodingGuidelines: explain why assert is bad
Date:   Wed, 22 Nov 2017 14:38:25 -0800
Message-Id: <20171122223827.26773-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a-goog
In-Reply-To: <20171122223827.26773-1-sbeller@google.com>
References: <20171122223827.26773-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/CodingGuidelines | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c4cb5ff0d4..4f8791895b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -386,6 +386,9 @@ For C programs:
  - Use Git's gettext wrappers to make the user interface
    translatable. See "Marking strings for translation" in po/README.
 
+ - Prefer the BUG() macro over asserts, as asserts requires that the
+   NDEBUG flag is unset on compilation to work.
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
-- 
2.15.0.448.gf294e3d99a-goog

