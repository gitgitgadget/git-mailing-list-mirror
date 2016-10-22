Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A4420986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965124AbcJVXdw (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:52 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:34430 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965032AbcJVXdm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:42 -0400
Received: by mail-it0-f41.google.com with SMTP id f129so12188167itc.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIiSvy9Djfb7Q2s/4ORnyMutTmd40/Lt0xYjJCDet6c=;
        b=FS/1cO7aico2w2mr/HxIcWFKzFKhZ0lePuN6zIKSRkyny7sMFb4ID169nu/Q/xaEvZ
         +eTA3FL9kKKGj7VRIzalNGkligiwaaj7jGkS2FBxAtjAGZgCT+IsQl9PceypRDBadKTl
         nrVhtoXGpzSkMz5CrUd3eblfb+3JaFO7NB46w+hRaMa7Y2FG9U+SPeT/uPhAeQK5H3gJ
         Ubw058akH831JXBS11dXEIG6b8IHibQK1ZNcW4WqVI9jeMs/EGCbFoN0AF0RUQ1efjpc
         RmfSy3kvH1LNcNdO0TxK51LHThvyZ8zXokGe9Yo+zfNHJ6AjjDugHMfLOyY+ryfb82o0
         LbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIiSvy9Djfb7Q2s/4ORnyMutTmd40/Lt0xYjJCDet6c=;
        b=O+QoZ/q9S8DisUbfrbHeDuEPLP5loKCnp0dwfI9jBxyrrsiPDn8sF57d/e0t7zXFdq
         6SYGFIu1LSkOuut8+hf7P2uicYGdwd0Vf943Yw1IMb+q9f/k+Cs+h1Bqr+nLdU/I3J8n
         1hY0uMhfvonjWmr66PW017QLJrcgGneRGqZCG6A4+BpNM2vpx/55CMhik+CVMaPf/5GD
         7fQqNPnGaVChOeJgxAvhQy84uU+rLLVj90CXlzfBEt9reFmwaJwACB0FxJTdKXRNLvEM
         Kd2FJqKezuHTqUiaDP0CEmdoHkVLHZJSY6TyziUXtGuUnHbyo7+83y4EMbk+vbzg+Z9t
         UdNg==
X-Gm-Message-State: ABUngvdyhkY13Tii19LHvoCDZNRamqzxUUziZRL+xw+7GDwJFv4YHeyPvLhINdoconY1KFlZ
X-Received: by 10.107.138.65 with SMTP id m62mr8894200iod.213.1477179221679;
        Sat, 22 Oct 2016 16:33:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id u124sm1987036itf.0.2016.10.22.16.33.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 36/36] completion: clone can initialize specific submodules
Date:   Sat, 22 Oct 2016 16:32:25 -0700
Message-Id: <20161022233225.8883-37-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf..90eb772 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1138,6 +1138,7 @@ _git_clone ()
 			--single-branch
 			--branch
 			--recurse-submodules
+			--init-submodule
 			"
 		return
 		;;
-- 
2.10.1.508.g6572022

