Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D477C1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeAaLJA (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:09:00 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40466 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbeAaLI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:57 -0500
Received: by mail-pg0-f68.google.com with SMTP id g16so9759583pgn.7
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+jc5zrkYV75YnCFmJhnOikRnd9HKPEbPXdOwE5in2I=;
        b=pWhK+DlOIDw8fZOBUXHq0nhxvkSqhzW76cS4pu/Ly+XzI0jj8l/lLbsfhoaON8cfuH
         Kbno/KJarLIF1qEPU/kcZ6VMVlBReroC24DYbnFm0rmzCv8O2O8UEc5QRJ45rXrm6T7P
         bm+UwnkANLvfg6obuzlawLp6bhih6IlEIdK5C9AGi5gt0+ZMLDzfitdJmz5Q7b56rOGB
         htYAgaMaqORKJj1lkI2RIHmp/ABseat4giQ29sp0VVCPyGvIN1C9c9XR9n4n/v4mX3DE
         ekso2FHwDcrMoeYs0hA8nhZtYyJTNzTSuG05UoPPEs9m0NVCtlEcmPc6ENU9ww9m8Zba
         dqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+jc5zrkYV75YnCFmJhnOikRnd9HKPEbPXdOwE5in2I=;
        b=uMGqbUJoy3tbw3l77BZWsqkc+9PwiIr0bEs5hdyubUDKhkbuVYGdjHpfHgm2i7gtnk
         acuHkAVSkBwWuDAqeUGeNFM8fdmG7t1MaXFulXSAnlH0caHNWRio713VPRfpncsDmVkD
         2ueR9SKMfsUnA9BdFvjINgJQ/KThErvUTyi0ZEKIAUZVjIJQwbL1YgGgjApz/WoEQcbb
         D756OYcKr03gSnfMeUQxBr9CO9gXOfrkQilGorcZSAABmBx7nve/UA4PY6dPxXmoLN+u
         lkwvx9HMBx+Irex+Ent6ryiMDlDiQVXbVZCrxwVux7F0Dl1QT0WLr7PGFE/IhRTl+JO7
         aH+g==
X-Gm-Message-State: AKwxytcHhUzjomKy/LRK+irG7OQLA/ClJ/WO+Gls2iRTwPBD33FBwXMh
        Ice4UviVMX39yNtx9SYSEueKtg==
X-Google-Smtp-Source: AH8x226ZEMl56U9EUDG/kzUSjYtgQTDK+4hE0dtbuU8dLIbCJWXq/RM0ZgKO6MjlaFAsNXoyV67p0A==
X-Received: by 10.99.100.131 with SMTP id y125mr25446610pgb.359.1517396937026;
        Wed, 31 Jan 2018 03:08:57 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id p75sm43269168pfi.148.2018.01.31.03.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 40/41] completion: use __gitcomp_builtin in _git_tag
Date:   Wed, 31 Jan 2018 18:05:46 +0700
Message-Id: <20180131110547.20577-41-pclouds@gmail.com>
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

The new completable options are:

--color
--format=
--ignore-case

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba9438e437..179ddd8c44 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2985,11 +2985,7 @@ _git_tag ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--list --delete --verify --annotate --message --file
-			--sign --cleanup --local-user --force --column --sort=
-			--contains --no-contains --points-at --merged --no-merged --create-reflog
-			"
+		__gitcomp_builtin tag
 		;;
 	esac
 }
-- 
2.16.1.205.g271f633410

