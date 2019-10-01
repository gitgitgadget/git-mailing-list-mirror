Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F3F1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 19:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfJATYq (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 15:24:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43423 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfJATYq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 15:24:46 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so12405591qke.10
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Kcd+U+bco7keArjVPT+wy3xbzd7ipQp8AnDMaYJCiA=;
        b=DOnT2a4Q/P/D2R5QJGtk+8aVnY/f7eyMlK3i7ssPkaCl5oQfuPUN7lM2efYzvkJrTu
         CluyicgoWWXSS/w+oLDhZMcm957GOeeh8p/UxsVC8YgTded+0k2RTJlWRoIEZbKlRvKm
         xiI+sMFO5MdfMSfDiCmw+w/Ny3bpWLfyyhHt9zdcJofMgtLB6SFp9oRl7Q1j3rN/hKn6
         TgqgFI7B7n2DF+lO8UOuxzuWIkBybyICm+r9QjY9RarSyYhUzoegM+vqeoxkfNv60i4U
         TMXQHuEjZg3VatYSVWoeEwJyBo7mKfVZdHbkOGTZit0ftygoaVptWbAqACKESFIAHoRD
         3gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Kcd+U+bco7keArjVPT+wy3xbzd7ipQp8AnDMaYJCiA=;
        b=rHaAjQwJR/ysHmA/HuxczKdp5ep/jwwj6a1fbBhG5yjvc59tH76vTbyeJPThmM8mBg
         /BpdqSGh6fCCjD3KJ3rGiiJpQdhnu0PG1QF4sXZMMhuPJsqId56aNH09tmvbN9j78sio
         B84BFXFMIxHyaPruHBjo2SECi1UvQvI73yGfDK4fB/w60gXTQcyWrKA8E4t0yMzSCR1c
         Ju320vl7wXpdLa1hFI56uQMSdihxdA5dyvavcaTrn5QIdycM4no2ihRjH1AzABnOvReG
         abdUt8GuBhMvLLuSoBVZJH6UdulwDeoUbBnRbxCxWV6QAPmCCM9BZ6b+097oDA7jEKnf
         ItCA==
X-Gm-Message-State: APjAAAWlc8je4vVi+8v+OWvTREZJF6KSmUAyj3AUD0gqU+qlDn3yQ4xy
        Ntq7kO9bUxmyv8+UCB0LrkLV0mEOqFA=
X-Google-Smtp-Source: APXvYqzSO7whczuBlI1V3u5K8wFupKCzPInRt54U4McGUYzWJcPnho22YeJ2tKpMgHf5rETfHhI3Mw==
X-Received: by 2002:a05:620a:140b:: with SMTP id d11mr7976710qkj.22.1569957883489;
        Tue, 01 Oct 2019 12:24:43 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d133sm9355020qkg.31.2019.10.01.12.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 12:24:42 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     bwilliams.eng@gmail.com, christian.couder@gmail.com,
        gitster@pobox.com, jrnieder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        stefanbeller@gmail.com
Subject: [PATCH] squash! grep: replace grep_read_mutex by internal obj read lock
Date:   Tue,  1 Oct 2019 16:23:34 -0300
Message-Id: <e452947091b96a02ca3292f8cd9793a8d661fca4.1569950899.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <48b632d7a0278f4abb4f0b0390f316a631a9d0ef.1569808052.git.matheus.bernardino@usp.br>
References: <48b632d7a0278f4abb4f0b0390f316a631a9d0ef.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

This is just a small fixup to be squashed into patch 6: with multiple
locks, the locking order must be consistent across all critical sections
to avoid dead-lock. Since grep_attr_lock() is called before
obj_read_lock() in grep_source_load_driver(), it must also be called
first here.


 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 0ca400f7b6..85ee89b5d6 100644
--- a/grep.c
+++ b/grep.c
@@ -1813,11 +1813,11 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		 * currenty thread-safe and might be racy with object reading,
 		 * obj_read_lock() must be called.
 		 */
-		obj_read_lock();
 		grep_attr_lock();
+		obj_read_lock();
 		textconv = userdiff_get_textconv(opt->repo, gs->driver);
-		grep_attr_unlock();
 		obj_read_unlock();
+		grep_attr_unlock();
 	}
 
 	/*
-- 
2.23.0

