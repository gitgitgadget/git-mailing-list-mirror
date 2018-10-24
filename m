Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3571F453
	for <e@80x24.org>; Wed, 24 Oct 2018 16:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeJYAyX (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:54:23 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53075 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYAyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:54:23 -0400
Received: by mail-it1-f196.google.com with SMTP id 134-v6so6934028itz.2
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8GhCs+6tkhSRPA7EjI8G02AMns5HyrJ6aJ4mS5W2LEE=;
        b=ut2dUhYYpsSw3/dlXtGHA22dSpCotuzBGWbNCQ5d32r/HM1tJzbTxVZhfQhJhci80B
         psFWKKURsbrdsuPfBbRwE79tu6Tc5WMqADjLfszAHAD54fNUMHY0AXiHZKOwgrVCfBOB
         mdmzCPsdLQ/kUcAi7jgwJJXx9zXyyYtqmXAJ4qOoqSkxv8IMWL66r625VKGXSeBR5OyJ
         gTSrGnJlLy7/ELyqWJ4IoSeoAq0qFtYiBLwHDWi4T5HK+h/GLbo3RFrfNLFNuB3XLTet
         cAz6VtaA5tfAZ3nb1MLzcVSGk56V8GYV/H6v2cMbFCIHNOifXdPubqLF7wbD69KuEWKz
         zHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8GhCs+6tkhSRPA7EjI8G02AMns5HyrJ6aJ4mS5W2LEE=;
        b=OViQra5NOHijW0a/s6TErt38YSoy+5105EG3Gg80I87r5B1a/Zv+jf6QcAR5rxGdiU
         Zy9CUGwDRzNn9CNisuhjKGm+aniHs/bl7whTBx5irAedGbphkBl+FV203OGVngjUrES7
         5FMOthCNpzS+6acA0/T8SveH1MaL8yARG2OebOdbuD+bXOtbZNOGBS5eECc/QI+w06Rg
         PAeHtxRHRUhkUC84AxY69BCmm0/SILkwU8tNBRfpgKNvDkhIHxb+ZCsQ+nBp1GWXvMgl
         yc8CvZibvLg/1vIqRF9stzbHuKonrIet9mtFS9fvl6PpegXgsOu37APajlYH2JYHq58i
         azaw==
X-Gm-Message-State: AGRZ1gIiS+8YTkuVeuiwR9KtlfSte0Y44TfC/3a9sVMHa2jpXLbxGenM
        cX+r5h2vPlfEsUCE6Ih4eBmxBN1h
X-Google-Smtp-Source: AJdET5fuj7HTUnzfkKBv6L0Ranv3Sv3wlWxWziSAhQkhQOInddWuNGcEVPG6UTY0J8iIiy2rivr+9A==
X-Received: by 2002:a05:660c:802:: with SMTP id j2mr97656itk.13.1540398339675;
        Wed, 24 Oct 2018 09:25:39 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id g19-v6sm1801731ioh.30.2018.10.24.09.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 09:25:39 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:25:37 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 2/3] completion: support `git mergetool --[no-]gui`
Message-ID: <e0b0585a17bb0b3f43fd930b449b9bc631d58f0f.1540398076.git.liu.denton@gmail.com>
References: <b0a5d6926c130c0b143435a96ed956b3ed20dad7.1540360514.git.liu.denton@gmail.com>
 <cover.1540398076.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540398076.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Anmol Mago <anmolmago@gmail.com>
Signed-off-by: Brian Ho <briankyho@gmail.com>
Signed-off-by: David Lu <david.lu97@outlook.com>
Signed-off-by: Ryan Wang <shirui.wang@hotmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index db7fd87b6..a45b4a050 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1833,7 +1833,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt"
+		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
-- 
2.19.1.544.ge0b0585a1.dirty

