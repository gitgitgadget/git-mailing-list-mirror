Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B44DC433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 14:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiDWO3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 10:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiDWO3U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 10:29:20 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877ACDE97
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 07:26:22 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id s21-20020a0568301e1500b006054da8e72dso7534207otr.1
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NaTjakbHbtLWgyo9qqsKXQdcjxLkCn6nGZYUWvTPKhI=;
        b=SJNP342El9iQme3FM4r5iQrpOmNs8YYfGADtTE52C6rDlXXCceBchK/Kckt82qOAsb
         aZ9zAwap7UPd7h/M3kplZ5yTgIWrRCb805jP4SGWbRwQjiWp6yBEQuhCkvLD+CVuvs6P
         WxYoqTElx9IqzayfKG5sY+mwXJ2sBnz8zbB0mPVa8dido4Sr7mbKNBRuBmIDQV5qSjma
         0IuVPdET6hqLnqXz/K62NLC7sugPVsXNkJUeynzZ2i5eQ1NAWUqU9V34D7uwK7SFhIsL
         CkF8N7Nz1dqa+gPR90YFB4vimy55spgI3rf8NRzZcvTI0mD1rqkkxgov5dv8lekjRY4e
         gDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NaTjakbHbtLWgyo9qqsKXQdcjxLkCn6nGZYUWvTPKhI=;
        b=qAHR2j1tRkCqFHYz1H7CgqzWpaIjKM68To2Ds1vJZXyMzgdL3HVF5cd4Or0P0u9PXq
         VT0tSo1gpMoodcT6K2e8SG/r0ObzK2d31dk4hj5nMDplibbqqTVX0uXLAH52qM6CUMEV
         58iD64xSZ4k+QWsdxqweHvLhDu3pZPvIU4rTnz4z7EwTmW3LIsJQ92XQljgYLnlGvv2d
         JWOG29yyQ4haDcXcYmcWPXTorVDzZt1RfPMppbMdcuUv0DE8TpokCnpyHi2Zzre4jlRp
         kQwX9wLByJBUWyr/K57gmt9fBeeh66ZonkAoRIFXxvZKWCb3Doty5RrPHYWvDA2zDdvw
         +YPA==
X-Gm-Message-State: AOAM532cpik/hR6QAQYpK9NqBkHO9/DYpYsqYqH/V8h8mVZCm8PVclHU
        g2QIDZ8LH5JAbFFl6ltC/cvU639t/9I=
X-Google-Smtp-Source: ABdhPJxI8KDlYqmJ/KMZ3d2fuzrAh7Ter97EqXU4NhO7QNmm+1IE30SAXJd1IM5ue/uuJYI28934/w==
X-Received: by 2002:a9d:7618:0:b0:605:a132:7d57 with SMTP id k24-20020a9d7618000000b00605a1327d57mr481075otl.262.1650723981619;
        Sat, 23 Apr 2022 07:26:21 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s4-20020a0568301e0400b006015bafee43sm1869993otr.46.2022.04.23.07.26.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Apr 2022 07:26:21 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 3/4] ci: reintroduce prevention from perforce being quarantined in macOS
Date:   Sat, 23 Apr 2022 07:25:58 -0700
Message-Id: <20220423142559.32507-4-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220423142559.32507-1-carenas@gmail.com>
References: <20220422013911.7646-1-carenas@gmail.com>
 <20220423142559.32507-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

5ed9fc3fc86 (ci: prevent `perforce` from being quarantined, 2020-02-27)
introduces this prevention for brew, but brew has been removed in a
previous commit, so reintroduce an equivalent option to avoid a possible
regression.

This doesn't affect github actions (as configure now) and is therefore
done silently to avoid any possible scary irrelevant messages.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 ci/install-dependencies.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 9da03350d09..46a23a33dbd 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -41,7 +41,8 @@ macos-latest)
 	(
 		cd $HOME/bin
 		wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_64/helix-core-server.tgz" &&
-		tar -xf helix-core-server.tgz
+		tar -xf helix-core-server.tgz &&
+		sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
 	)
 	PATH="$PATH:${HOME}/bin"
 	export PATH
-- 
2.36.0.266.g59f845bde02

