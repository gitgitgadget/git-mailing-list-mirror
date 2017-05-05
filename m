Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90675207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbdEFStt (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:49:49 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33843 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdEFSth (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:49:37 -0400
Received: by mail-qt0-f194.google.com with SMTP id l39so4886624qtb.1
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BoxVk23LnnT72EgvOwFEjnI9dqbfr6cyDM8kZt0IcMY=;
        b=bf6uIYMMpdX1IJGc7gx1v4v1TcU+CNEXlLfCmLaHO3yR1suxMsDsGamfXLcE2SfFNo
         SrD7H93YuXFVZmUGYA89rAfSzSS3VNn/YcyhvRKcmcxNYX1LzvL8QLsQX4ATIBY+J9g8
         i0NFMacyVgfrFQpTwu+AoeWVk9j6MfZ1/BW8RAh3XOCv2VdYxSwO177jBVxyAO9BRIDA
         X9fMwhqenQkxXj8hAggKe+KN/ayPBG5+A8Lw6DNW4tsp3n7FGgd8c9eaH0MrkiZeg3mS
         sA6wmiL4L9RNzP5b8/WDmGJfco0IXnv8UIlGULya2V18StPHprPLhiiPnUMlL8VY8XCU
         O4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BoxVk23LnnT72EgvOwFEjnI9dqbfr6cyDM8kZt0IcMY=;
        b=Tk417NHtQV13qM36tKuaRSypJQZ6n4U2dzsPKB0gPLPX5rk+ugG5JlfYULi7QnviD4
         0lxWrxDRUlovbt7yFbe3ymfA/mTLq59W7ntgkmOwpf7K+OZw9lkzMnBjmWgTzYbllQqA
         Pu7WHrr58gVLwOo6iV+deC4EwGIijndS3Lgg6urguGl5z+o6c1HAGHNbkWYgiRTtlXQp
         3RDHBLuc36qMIM5lbJG7Qb92V3h1qrlOi2PdqmgOKoXXdwPb4CWZeR6Xyb3vD3ZjzV/E
         TNqz+FIPqWp8HnFvssAZcBpyixBKj9N3VfuvCQQBljstaxxd6kJ9gSAqKZFfL5gYACDa
         Eimg==
X-Gm-Message-State: AODbwcDI918wXngTuCZ/On3JLJ9NGOBnWp0N7KWGZooSGO41eIFIFx3D
        MoQuYTc/mvzo5g==
X-Received: by 10.237.62.115 with SMTP id m48mr17193661qtf.179.1494096576288;
        Sat, 06 May 2017 11:49:36 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.17])
        by smtp.gmail.com with ESMTPSA id 83sm6866347qkq.26.2017.05.06.11.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 11:49:35 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 8/9] t7300: clean -d now skips untracked dirs containing ignored files
Date:   Fri,  5 May 2017 05:46:10 -0500
Message-Id: <20170505104611.17845-9-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was previously broken (and likely never worked); this concludes the
patch series fixing the behavior of clean -d.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7300-clean.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 252c75b40..948a455e8 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,7 +653,7 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
-test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
+test_expect_success 'git clean -d skips untracked dirs containing ignored files' '
 	echo /foo/bar >.gitignore &&
 	rm -rf foo &&
 	mkdir -p foo &&
-- 
2.12.2

