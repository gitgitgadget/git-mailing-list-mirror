Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SORTED_RECIPS shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9631F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 04:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeKYPsh (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 10:48:37 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39632 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeKYPsh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 10:48:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so11164611lfh.6
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 20:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFJwfAw7hj4OPsHImxjvUNhjOzOegqqhsn1OHLkNV8I=;
        b=sc8yEvYFA1GTn4YPsEZ4GZ7EjcIKJLevr2nTuQ/C4dpEsAqIe0bzy3fHnKUQ4oTNOx
         Ujuu++eT3xzqHH2e81JjTO/Gm91xDYe8Qa6TaCBg8unpvwrHYYMIxxzWbHAf945pHn6A
         7PCUacIkAd06izY029cpexThYBQ0f0OqGycec08crIXmBoJX7iRnBExBmHOTzNOYlpZC
         ih85o+rQmgWriCCO8zYUxeWXSFR4qM+jdUEZU2CfJ/um1CeWJArouFP5y35MzAGuhngZ
         WHe7PaTI46GxvD/eBbW8G8PIgAPQ6U1Sq9/GNYVKaVoK2zQDEpZeBdCKG49n6BCSOSMD
         H92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFJwfAw7hj4OPsHImxjvUNhjOzOegqqhsn1OHLkNV8I=;
        b=rRq4qNB4SWVTaR0jqhcT4L8btptzARZU4dSfSawvoQS0etm7xcDp+9SWywGTrcBveQ
         S8pzOsvecSPTfwKJ6dzZT+dmtmWHjHC1x56RlXvpUVkTJNnWA+v3QnZoHl6NbeuLufH0
         BPFT172ciEg8Nrn/2UHwK9yhbeASpp//PRW1YxGhNsXClC+Ybqb1rxan6JHEgIgAgBdF
         WOWs2hqhqCOgYT0XQU+RRLRe1j+zbr6Ky6LRdOvGgxfLQu6Nqrvxt2GkS2SRKGNWrvKy
         Im0SwyKKK9PTSHcH+BhrbadFbMZJNJWxJ3VHPU2US+LGr1u7ZExoTKJVavtReVll3xm3
         /WNQ==
X-Gm-Message-State: AGRZ1gKExZiLInCqxFG6FkgFQamehesawu/T8qODCxMty2HBQExwoRzu
        b/Rro2SHWztgDRy8WWamyt/TSluz
X-Google-Smtp-Source: AJdET5etLJbsYYBDpjZCPSgdblHM9w/nTxaaHkcJdsXBJMQ8cRB2rzUpHblueTeHTv3FTXQwzjWprQ==
X-Received: by 2002:a19:9e11:: with SMTP id h17mr13541161lfe.73.1543121903296;
        Sat, 24 Nov 2018 20:58:23 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q21-v6sm4885220ljc.5.2018.11.24.20.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 20:58:22 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com
Subject: [PATCH] files-backend.c: fix build error on Solaris
Date:   Sun, 25 Nov 2018 05:58:16 +0100
Message-Id: <20181125045816.12185-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <87a7ly1djb.fsf@evledraar.gmail.com>
References: <87a7ly1djb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function files_reflog_path returns void, which usually means
"return;" not returning "void value" from another function.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9183875dad..dd8abe9185 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -180,7 +180,8 @@ static void files_reflog_path(struct files_ref_store *refs,
 		break;
 	case REF_TYPE_OTHER_PSEUDOREF:
 	case REF_TYPE_MAIN_PSEUDOREF:
-		return files_reflog_path_other_worktrees(refs, sb, refname);
+		files_reflog_path_other_worktrees(refs, sb, refname);
+		break;
 	case REF_TYPE_NORMAL:
 		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
 		break;
-- 
2.19.1.1327.g328c130451.dirty

