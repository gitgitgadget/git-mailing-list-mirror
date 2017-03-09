Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66D7720135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbdCIBaz (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:30:55 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35515 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdCIBay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:30:54 -0500
Received: by mail-pg0-f51.google.com with SMTP id b129so19760207pgc.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mmxYtTBAY2yuTA3Vc5U8foH/swlXyANLUp08F8WQItY=;
        b=qDWAIpbptunZzgQ0z7Lh4anuYG0SzLMt4nyamDUjtsa1WLA2Z2J1uSxp9i0TKw0WqF
         EwbJBfXrP7qfGcQyP0yv6ncRAVV/u4BPz75/JoPoXq+3xEJiAjLz/Mzabd6Ch2HAAfn8
         JhlAQy3pFPtmj1Oin5o3Qwi3dZw1PLPEC5CbegR5G1wdW91KYtB/to3LzQgaw6bTI0Oy
         9/LcZA/IwX3CtNfMxvWiMRYhQ6uNeRKGwDKRuosOxsB1yGqRm81IBKuDpaTMOVROTLXm
         b9YdBkIoDYEYCKHTamqlGPXGkbQ6ZN9nX/ngEMoXq4VOCwAZNJf5PmM7gIMlCgUWMEB9
         KNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mmxYtTBAY2yuTA3Vc5U8foH/swlXyANLUp08F8WQItY=;
        b=Y5S1q2CX8iSmYZfhEhgatzRR2bRYcOGDhWJmi6qAKclibSpzCwRhkcBrUE6UblWyEs
         ND9i6Jo5k+duSVQqQLzsEuo2r9GOJqBlYP+NNM8GiHguQCIUJAUam+eiQ8ylofWBZyvP
         o9BrqGZ4olT+JqYJGPEhn19Np9wBMik8y6rbvip4FAHo+0B3qMdy+oJylxvrxdG98xaj
         SMae+d+nctXY26Qvp+ufPVebyINHErNxgOYayPzE4kUxD8AHVgr2vxK25yoWQUofWg8M
         rFqdNXMOw686F0nqzd9B1aXmCND6J5zhcNcX9s3zdLEbIPnYcVGZpGhBjDI5bXMS+hF1
         8D1Q==
X-Gm-Message-State: AMke39myA4TSthZ7on4jHQXmN6zwkzxbmiJpcfB7/lLRKjyIhGRTQpqnJnqKjM3fCK6N/7N7
X-Received: by 10.84.232.1 with SMTP id h1mr12973397plk.95.1489022636470;
        Wed, 08 Mar 2017 17:23:56 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:23:55 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 02/11] submodule status: use submodule--helper is-active
Date:   Wed,  8 Mar 2017 17:23:36 -0800
Message-Id: <20170309012345.180702-3-bmwill@google.com>
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
 git-submodule.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 554bd1c49..19660b9c0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1000,14 +1000,13 @@ cmd_status()
 	do
 		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path") || exit
-		url=$(git config submodule."$name".url)
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 		if test "$stage" = U
 		then
 			say "U$sha1 $displaypath"
 			continue
 		fi
-		if test -z "$url" ||
+		if ! git submodule--helper is-active "$sm_path" ||
 		{
 			! test -d "$sm_path"/.git &&
 			! test -f "$sm_path"/.git
-- 
2.12.0.246.ga2ecc84866-goog

