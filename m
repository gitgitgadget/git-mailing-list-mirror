Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24D601F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966765AbeCAJLV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:11:21 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40465 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966696AbeCAJLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:11:16 -0500
Received: by mail-pl0-f65.google.com with SMTP id i6-v6so3289954plt.7
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CrW8HigdFwSeZAUQ44cdaix6gm6zOJGxlLxROjtR0g=;
        b=dRSl9nZs5ATSPy49hg9gC68+CMJeQ8EHmeG8jI5H6LR5DhunD6QQdhz7WKjmBOhYBn
         QI47ro458jkJgkV+IZnpwj39IR8vJT8CtxCkuLBXqEC3tfXsd/BFiU2CojLahJTvJbfq
         upby0qjgtGlycf3r5IqEKrXqK73/jHtUJ1xbCevsFFsHcdH3U+GT9myVLmdWTb6beRWq
         OWwWjbeSLYuHz/wreT0Y5QY36DPMN8ldfwdFNE5LnsMfsYuo/ZNRkBnLfVvqGJ9EqchX
         jo7dvwyhCICkvjTuodsSjG5s+ycKFi9iOXrWqeHKhLT9/DVHj3z7Hltvns+jsCULy5OW
         iITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CrW8HigdFwSeZAUQ44cdaix6gm6zOJGxlLxROjtR0g=;
        b=IMFGWMZiWjmDBcFgUbZ+WYdzDEJpfv1qxZRJLLL/4TGmM/6jM3oWW8V6aIrelbv6ig
         X5Ms6SurCiPnlTfzWSyRrZqh56ARTEhVVHmqrt3MxyBgW25+yNLK3BAmTX706X+4x+x9
         falkkuxyclSIrd8PzUMThKCwYLLvyR0ueog4yX6gmpSzlM1vQOChbmkvUyTPBc/udnOp
         a/q0+cQrR0ZX5iGuCvcfeeUbki/J80yeoktDKj4fYqiXhVl+Dkmv/hd6a3zCjWJhdtXj
         +kZY22QOrwIrVIVz535owFoIzMwVv1REnS+WXFWVC5d4Cf69YWEWyVv+fAdYvylgM6/k
         IQCQ==
X-Gm-Message-State: APf1xPCNV3LEusiNnbMMb8Ux2EoQkMUEEvnz/6h4061eab9KDSbFCJdl
        tFU8CSaMtHJOVoiguMyX1CtdyQ==
X-Google-Smtp-Source: AG47ELtHVyWL/5nCc3o/RVk6cYpApjgZ6XtQOVnpzI4sT3XSJl7Re2vHuPfuC0YQeq4PxfRvXXop+Q==
X-Received: by 2002:a17:902:a512:: with SMTP id s18-v6mr1275168plq.296.1519895475471;
        Thu, 01 Mar 2018 01:11:15 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id m190sm5509390pga.42.2018.03.01.01.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:11:14 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/11] pack-objects: document holes in struct object_entry.h
Date:   Thu,  1 Mar 2018 16:10:42 +0700
Message-Id: <20180301091052.32267-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301091052.32267-1-pclouds@gmail.com>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pack-objects.h b/pack-objects.h
index 03f1191659..720a8e8756 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -28,6 +28,7 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 
+	/* XXX 28 bits hole, try to pack */
 	/*
 	 * State flags for depth-first search used for analyzing delta cycles.
 	 *
@@ -40,6 +41,7 @@ struct object_entry {
 		DFS_DONE
 	} dfs_state;
 	int depth;
+	/* size: 136, padding: 4 */
 };
 
 struct packing_data {
-- 
2.16.1.435.g8f24da2e1a

