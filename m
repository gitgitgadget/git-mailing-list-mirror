Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D6320248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfDFLfV (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:35:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39567 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLfV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:35:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so4493917pga.6
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2oBmbf5BDonb8ioNi8En6W+qxy7sm7wmSFCILcVceI=;
        b=ro4fJVr03OqLNbiCgx7EDrgkkm+1k1C9VOtYZg+AIDX8ZERjT9vOfH0zK+pilEl7ma
         gpIME0R3uTbN2SXUW4k2gdSwoqfsGJ02f4y/4uG8Iqaa6YYVrBxXafbbw3Ia2K9H6j2t
         DqK8l21goXjBtDod0MvBjiwG6tXSC0nYwRNf+XEd6/amoq6U0vZiCJwW5uiM2jQRyYmz
         paHu5/CSqU2StG61y5LwM1bXBOjv28yB7PFOjzSwRKN7QByjKaAmxGsXp6eoENlJJ5e0
         ABCIDiA8vcpkXsweTbMNvWZtBRnMlu3VE+RJ1/n5nzYvMFuMj0U3I8Jz3Ner9CaP6n1d
         R6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2oBmbf5BDonb8ioNi8En6W+qxy7sm7wmSFCILcVceI=;
        b=YhaXAUoaHAPzE/6/senDCRyVMTmieohlLf+BkbhSo8PRf9UF+0MwyRqb/1VeiK8/74
         gpaKnb/nFwcdopxjonwMI4HkvXjGkZO5+VoSg0E6kJSaOFjAERgOQiq55qTi55z4sy5q
         nGvrLZ2GNxBuhwjrF/D23ObRTqCAbE/z29rAGyKfk0uUqoerYrYsJxfbKxAi/5Im2Ns7
         iHfwvZEzxzRJCONtkqOE9EJ2R2GiRQikEWyviSPnpuMliuBzKUIfP72pRcZn2SGPEwPR
         Iem4fMaUh4h2jj1ut84kvOVfieQK2gsL8edGJprDYqkk+70K7rKmdgVoUQitMW+9/Iis
         nIkQ==
X-Gm-Message-State: APjAAAVZGUnFjE6J/pDodJtILZp60v5FMxtWeG+/qrTxPIOcb6pCjHvF
        O113AwpaPF9s7lOTvYmHMV8=
X-Google-Smtp-Source: APXvYqwlQSKZNTMi2i+6nATZKLnS+zuA2Rp5yGiL/VFG3XOizYL/Ir7MRQ/R5Ob5O7zEmuNDdBSiGA==
X-Received: by 2002:a63:d256:: with SMTP id t22mr16541284pgi.80.1554550520343;
        Sat, 06 Apr 2019 04:35:20 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id p189sm18986970pfg.184.2019.04.06.04.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:35:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:35:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 01/33] builtin rebase: use FREE_AND_NULL
Date:   Sat,  6 Apr 2019 18:34:21 +0700
Message-Id: <20190406113453.5149-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

Use the macro FREE_AND_NULL to release memory allocated for
'head_name' and clear its pointer.

Patch generated with 'contrib/coccinelle/free.cocci' and Coccinelle
v1.0.7 (previous Coccinelle versions don't notice this).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rebase.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 77deebc65c..868bcd1446 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1592,8 +1592,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				branch_name = options.head_name;
 
 		} else {
-			free(options.head_name);
-			options.head_name = NULL;
+			FREE_AND_NULL(options.head_name);
 			branch_name = "HEAD";
 		}
 		if (get_oid("HEAD", &options.orig_head))
-- 
2.21.0.479.g47ac719cd3

