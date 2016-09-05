Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676DD1F6BF
	for <e@80x24.org>; Mon,  5 Sep 2016 10:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933248AbcIEKYx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 06:24:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36010 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbcIEKYu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 06:24:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id l65so4782247wmf.3
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IJ1DjVRok5xT7T92kf0eYCUiOQLl6PkAQzo0YCimubw=;
        b=daceEGuD5/xP+APX2hIfUHJovAEHiP6cCEA77EmeGDMpEWJK95rcmI7G2tVPCVeD/+
         HFHXZ+L0CpbM1bKtVIQSQYZN0NbzjxCLkbQpyYpMAX9LTt0k24QLHF61kVnyNbaul1rj
         AkGo8rASFXDmseGVXMr3B1p2jaa6Li+xJNGu++REYALZ3FuXPGLW/V18KxXE57T8dCVL
         4p+PuFiHTxmIZ976sGbcxYILJLXGkXquQ4BPXv5LwfqOjkweR7UDXQuVgkk/QQjhOX7y
         tNS30y14LA0TMqC1PpFkPmaFtJXMm9CtqNxEIRu72FfY65SK2G+76eAyFIuN8c9hUU7B
         u3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IJ1DjVRok5xT7T92kf0eYCUiOQLl6PkAQzo0YCimubw=;
        b=UMAJZzCEYpP1xJcuQjD9L3L0k/O9Qh/0fMRsfKjxPHG1Sy9Ka1T2bEEgwGAN3D7y3f
         SlbKgD1GZzxe+Jyrsn6Tq+xY/BYhrMC0wxBWslRhJCqhApfH7oY5fEdfjNpRDSCETTGr
         1s4OLK7onCdMbOgvLBG5dFgK0fxzEO+LqRZvWBLaLptSvmSAufAxCAyccBXF1fg95l0z
         aNdX9BxMy/HZIM9KFPhwXFwVd87PKscxupJo8HI8j2ZP9P9SiEAAQsLeK4L1byAgQIN7
         SrQaCobb2qN+cDtAzJJOeGGSKbHSDH+Se6PPoFXPxXThzmOal8gEChdBlCrUaDU5kYQV
         QwCg==
X-Gm-Message-State: AE9vXwO8tSJpD+Oc3JTccN/UZHxDgzJbUTjYL/DjQI1Fbtd1b1PJaoYgZmz2ySHf6FDOeg==
X-Received: by 10.28.52.135 with SMTP id b129mr15324913wma.107.1473071089669;
        Mon, 05 Sep 2016 03:24:49 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id gg10sm27001666wjd.4.2016.09.05.03.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 03:24:48 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 1/4] t5541-http-push-smart.sh: use the GIT_TRACE_CURL environment var
Date:   Mon,  5 Sep 2016 10:24:41 +0000
Message-Id: <20160905102444.3586-2-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.10.0.308.gf73994d
In-Reply-To: <20160905102444.3586-1-gitter.spiros@gmail.com>
References: <20160905102444.3586-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new GIT_TRACE_CURL environment variable instead
of the deprecated GIT_CURL_VERBOSE.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5541-http-push-smart.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 4840c71..d38bf32 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -74,7 +74,7 @@ test_expect_success 'push to remote repository (standard)' '
 	test_tick &&
 	git commit -m path2 &&
 	HEAD=$(git rev-parse --verify HEAD) &&
-	GIT_CURL_VERBOSE=1 git push -v -v 2>err &&
+	GIT_TRACE_CURL=true git push -v -v 2>err &&
 	! grep "Expect: 100-continue" err &&
 	grep "POST git-receive-pack ([0-9]* bytes)" err &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-- 
2.10.0.308.gf73994d

