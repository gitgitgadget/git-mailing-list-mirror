Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E879A1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbeAaLHn (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:43 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40157 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbeAaLHj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:39 -0500
Received: by mail-pg0-f66.google.com with SMTP id g16so9757291pgn.7
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWrVJLdlPrHE7ZY3DcSLRJJ0+YD1AFpDFFjNjz+qbGo=;
        b=u2POTqOF0hTT+cqt8QjjEAAtqqmwXblrDCWULpGD+G57FvN7nX/Ew9bNqN35Y7maU3
         IVZqqdq9Y1n6Er0U8C9uy0lKUNxMit+ixEaVd3gzRmKN7Sk7KMwWoFK4LrK51nDmnYGq
         CvA6X8/VJsHh97BQqJValGhxfBnfXuMfB99125w03V3xH+a4066YA1k1S9o1Ar1QkBq/
         z/bc8Xs85RNsIpo7mFw41RCaY8COnu5G5xCRz+V2EvTZLpopf3pixFKbCQyFMpYx693N
         YlpvTIn1pWGK6bkKvV7MaoGMfayu4s+6rtUmAjify1ctuPIsg/2it1vPAgio5X5f0m1G
         FIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWrVJLdlPrHE7ZY3DcSLRJJ0+YD1AFpDFFjNjz+qbGo=;
        b=dV32RaN1pNDmMqeyK79MsO7RoTNmdT23vsZeIBH6yaF6i2+C9DwqVyHq6CR/XJxSJY
         rZnIR+0gQSULfoOZRsFDfoORcRmYyVprPbEeHpFxqPGGjjzNTnyCqQJxdords5B+9HAg
         dzR7xyqJcsE+z8unlaOyiQ/PtjQlDnxt5WNgcMosxtKWRbin+z+Xuj7EpbFyl6Hfw2Xb
         C2OzytuqOA4/3FLye30GuPEmqAixdqVYYTCn9ZLG+ZRTn5qteRQFgHcIaviO0n0QUiLP
         PgHq0T+kXyCXA4lbxHxbXexgZdNQBa15JFlhVNuLpr/WHS4kjkA/L6aeHLMH0rryNdf2
         +hkg==
X-Gm-Message-State: AKwxytd0WLm9C2QDKMDAcD+Hgjpa6fuDI/CZZIHT2z4p154NqQ17HCLW
        bY+Toao3kFClE2LYhhL6RoAf8w==
X-Google-Smtp-Source: AH8x226NC/nP8Ai1QoMquiI9KnHTogI3vo3tqt8qLDKbz+Z+QRMwWMbVKFD9jkZTGB0VFOmvfkl2Zg==
X-Received: by 2002:a17:902:8491:: with SMTP id c17-v6mr28441714plo.105.1517396859007;
        Wed, 31 Jan 2018 03:07:39 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id g2sm30435385pfh.134.2018.01.31.03.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 22/41] completion: use __gitcomp_builtin in _git_init
Date:   Wed, 31 Jan 2018 18:05:28 +0700
Message-Id: <20180131110547.20577-23-pclouds@gmail.com>
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

The new completable option is --separate-git-dir=.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1e3cb39fde..3e0973a562 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1592,7 +1592,7 @@ _git_init ()
 		return
 		;;
 	--*)
-		__gitcomp "--quiet --bare --template= --shared --shared="
+		__gitcomp_builtin init
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

