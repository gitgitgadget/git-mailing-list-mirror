Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3865B20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754790AbdCIBdV (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:33:21 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34719 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754780AbdCIBdU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:33:20 -0500
Received: by mail-pf0-f181.google.com with SMTP id v190so21859339pfb.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d17FJS5jFNVtEgOMUE6k1T8u3LZ69mWnShkFXsTa8PY=;
        b=sbVHnpbGaMJ1eaklROdwr+7gv7wpJGDDUQrBcU2XcykAgULvdTgnnmCm7TQ9PiPH/P
         MTbphSHu9+w1PmtUSTMjqA1IcA8zxqyw0+Sj29dvJgEBu37jYcoH5NEzllLfKrxMEnDk
         A2naMaIr0WDV1QTbMdDDXye7KFYFNrJjRzEkv0//nQgjhMGrqUdtft2KW1uk45ji9sh6
         oldiD81RNKjGKCKSHVrhqBXK07T+/r0b6H5sigXp0WbpRV+8Nj/AvFcH6xNdt+vSoL8N
         mGOxu42CjeNsygNs+3D38Yz3MYVi6zLGDPTjJ/92QIsJyqrieuU9xDoYyFQpRQhDDj6l
         eLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d17FJS5jFNVtEgOMUE6k1T8u3LZ69mWnShkFXsTa8PY=;
        b=AbdclwEbTwxafry07daUOSWOkguSkH0ndlRYTE0uBTVNZdZvAC5vQDOLfMXwxqiyRK
         nBfUjfR0XMCl1YRWNSRL8kcSjf6Jc9CgHVOZM0ZEtgpXucj3TbSzSGRKmHj8DydJc8O+
         ehZkDOj/CIaDmm9EZrgK/r2Mu2dR/1nb1dDfz9aqb2+1CBTVr8JvEf4nT/vjYdnFyMFd
         rD7nauTc+5udQVoGPHGJC2bgQHQButUqJ/Evgl9FvveWROQ/d/P5lgJo7yE79KUYQhbT
         37ruhIMVp4BJQZdSPxOdxVY7P1+KUYPIeMePr7XGaVlT5H/aq2f5bOl/Ib2IjKmmpBLs
         BjtQ==
X-Gm-Message-State: AMke39nWCNztw2mI0we8S8EG8B+vY6zsCmhO+pqpS5nD0jxwKFHPnnE02EL4XM8Bn9T8sgOW
X-Received: by 10.99.61.195 with SMTP id k186mr10321172pga.154.1489022647310;
        Wed, 08 Mar 2017 17:24:07 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:24:06 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 09/11] completion: clone can initialize specific submodules
Date:   Wed,  8 Mar 2017 17:23:43 -0800
Message-Id: <20170309012345.180702-10-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6721ff80f..4e473aa90 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1138,6 +1138,7 @@ _git_clone ()
 			--single-branch
 			--branch
 			--recurse-submodules
+			--submodule-spec
 			"
 		return
 		;;
-- 
2.12.0.246.ga2ecc84866-goog

