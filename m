Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85640C00528
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 10:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjHCK2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 06:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjHCK2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 06:28:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62219211E
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 03:28:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31757edd9edso623740f8f.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691058501; x=1691663301;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFlEMxijSUn53x3INOGBdqUaKZQQxsdGpoJxtWOxCcM=;
        b=bGhWHwr4AgWGnzuAr3AMZWaVwF4re27ASTAVLXNJDZVIzQbG6sNBghUMCaBjSQJ3+N
         rQvBDHtX/SN6T+Ejo36CikG4xHVIzEwhsh0JemNgWb2gQSqs+3RuyGKp7LsFpzAeRB0+
         hjzMmrHlxnbUsubwMYV6SDnJ9v6er3d2tC9krmnSpNSd8cRRlDPsTspv7lYyGlN+uILV
         cJ3Wy/GiTXtTxP3ofvp2ZZ/sPJG6v78vLs4WZ3j8MbCe+aw2mwurFolhZzzf8Z8alnko
         jh0eGgpd+ZQa069q2t1OiHsxdY5V8FoPgoqGmoReOFZUb+Vi+XAQ6154wdu2LO/1xH3N
         PArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691058501; x=1691663301;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFlEMxijSUn53x3INOGBdqUaKZQQxsdGpoJxtWOxCcM=;
        b=N/q6tLYPGwOuQZek9Wd9Wd7oMuCm5ck/9oyszMU8aNFBSNEAtUTmdRbJsKLzsOrm4o
         p0MmlimAPc7b9uMcUuBx7Wldg58H7cD3Q7LvYz3Gj1/Ap97oCLp+UfVfjASYVG/g0cSy
         MSvjPfmC5LOf0DRaEwc42Oc3BLM2t6QvPKQeSKbxavtWgoidf9VsNcD2STc27g3raS66
         bpYR004kIpMkaMd3yfuAD2ObIjqWMNDbC6Cyr6kcr3yOJ2h0V5j9xycyfc/svnZjJe62
         9Dug+ILQVllWpx45vv1Kl67nSzhEUe0lDn8LsENygczkPa3lW2DHJsabTnaD248XFpx/
         C8vQ==
X-Gm-Message-State: ABy/qLYoXrQuLCUe7XR/90xypIXuurSQRu64nfvB5oiE25NZyZo37srt
        gTPhw1YFw0EqjSjKxsMcDa6e8Yy51jc=
X-Google-Smtp-Source: APBJJlHh/h6/HmmaQ3z7MV23JlWSOTYQQtt6WE3t4i7BoP1zrPOjOFshpHOIhiLbBQbN5EzE0NuCsg==
X-Received: by 2002:adf:e441:0:b0:317:5e91:5588 with SMTP id t1-20020adfe441000000b003175e915588mr6466602wrm.3.1691058501681;
        Thu, 03 Aug 2023 03:28:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9-20020adfe4c9000000b00314374145e0sm12143546wrm.67.2023.08.03.03.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:28:21 -0700 (PDT)
Message-ID: <c872431b608424007f72c69c8526f96d532aaca1.1691058498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 10:28:18 +0000
Subject: [PATCH 3/3] docs: update when `git bisect visualize` uses `gitk`
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

This check has involved more environment variables than just `DISPLAY` since
508e84a790 (bisect view: check for MinGW32 and MacOSX in addition to X11,
2008-02-14), so let's update the documentation accordingly.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 Documentation/git-bisect.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index fbb39fbdf5d..82b1d5ac6c5 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -204,9 +204,9 @@ as an alternative to `visualize`):
 $ git bisect visualize
 ------------
 
-If the `DISPLAY` environment variable is not set, 'git log' is used
-instead.  You can also give command-line options such as `-p` and
-`--stat`.
+If none of the environment variables `DISPLAY`, `SESSIONNAME`, `MSYSTEM` and
+`SECURITYSESSIONID` is set, 'git log' is used instead.  You can also give
+command-line options such as `-p` and `--stat`.
 
 ------------
 $ git bisect visualize --stat
-- 
gitgitgadget
