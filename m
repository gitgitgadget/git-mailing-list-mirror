Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13EC71F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbeAaLH7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:59 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44145 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753752AbeAaLH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:56 -0500
Received: by mail-pg0-f66.google.com with SMTP id m20so9753958pgc.11
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RuLtHCGDL5HygXkNVDjnFzUx8vQv/+dT7nrO5PMGN4I=;
        b=sBnv0ur7qjxpzdokyoNzyjln8+xPE8jgqAa8ejSfT4lArLsmLj/db3EMGf7UW6+X7O
         q8xdWIyhyBDevkZRdUHWUdCRnVpH4DCrVEgEYzRkriQCUJqeaEg6s/v5207IXYOjU79r
         DFPqNrphdMNF/zZ7AU8kbTY86/z+0tyoFC+h9XQ318TobhRpDGiKnAckhYWsfJZpApkk
         zRbVyncAh/JRBhahYCey9ZqJrMWL/0uV0gIpWLG6TEE+5fZdvNSN1cE/Y8Mo83i7Y3n0
         JdKcJJ2vwSML0DDfqtjYOb434AelppuBMM5BEKUQZkeWGgSPjL6m6xxUCUipaRlfghM1
         +8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RuLtHCGDL5HygXkNVDjnFzUx8vQv/+dT7nrO5PMGN4I=;
        b=MOI0nooW3JISIDIukEPNUiMyY/sEQquW6HTcWvO141U7qS8ZgVDeRWvQo2scCNlxVf
         5cFLGytTmJ+B17qXQxc2R8jWfwTpxP5NvgqWZD54+dMtecBrvvVehTYMfGMamG/yhh/F
         bbRuEGQz0BFq9VQLbKwVIDVKY9tBsmULaHtpv2q5ENH2r2MP3ja5ZUuBtmeEyqJrzYSA
         H/TwNbtUt4ZyBIacbdYgVetu2HIiownqUrr8JH9CCNLyCbb6oaBhAogds9M1uIwlSt87
         0t3kxyOvT32orSfKjVqh7lnw4CacoFpXIoVpOtmlS4Z1cmf9BxAtMMbuHaaHihQcYzoU
         firQ==
X-Gm-Message-State: AKwxytdPoekRsv8ixSWZznK+yPDzenQsVmeYoo6iAlXOoY+abRiFhqPG
        LICMJO4Tf1rtNgwaxNnDprNIhQ==
X-Google-Smtp-Source: AH8x226w2PXQX9zb9ddbaH1o5nZocMRbs+2HBJvKQWx5Gt9LNbj/nmdhNsG55hjBU7HEGV+6xppdYQ==
X-Received: by 10.98.172.7 with SMTP id v7mr33562056pfe.66.1517396875778;
        Wed, 31 Jan 2018 03:07:55 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id k13sm40407664pfj.38.2018.01.31.03.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 26/41] completion: use __gitcomp_builtin in _git_merge_base
Date:   Wed, 31 Jan 2018 18:05:32 +0700
Message-Id: <20180131110547.20577-27-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completion option is --all.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 52baa7869f..1bf1728b95 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1784,7 +1784,7 @@ _git_merge_base ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--octopus --independent --is-ancestor --fork-point"
+		__gitcomp_builtin merge-base
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

