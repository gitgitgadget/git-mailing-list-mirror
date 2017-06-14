Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A3920401
	for <e@80x24.org>; Wed, 14 Jun 2017 06:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754363AbdFNGv5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 02:51:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33426 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdFNGv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 02:51:57 -0400
Received: by mail-wr0-f194.google.com with SMTP id v104so36442585wrb.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 23:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QOjAo8VLr5iNSlS9IO53OIcjxR+QttUBPV9pPv/+cs=;
        b=a4ETD8FaDz9FXTtsBpcTeBoaQ6JD9nugSPJ1gQ9LQ9NBLm5QC9YTR4EItsTOTfE5Fc
         hIIaCm9hRbMgF7jdQfXa2L9hf/owzE96QDmttqIdE5U3y474YgM3DeujE2LyVb4IcqL6
         XgOghPVXhcmEAOtFWVgv/IOOSqfXRp35RWb9Lyqei/FPGr/QRCeJFCKCguJKelOEGZTJ
         kxj5tvFmzfBbjLxsqTp4KmP7Yn3MWDny618EZsjHJLXsdYTBWwvXsv/Auap0Af8gIRYO
         OzfRrUgfzzI6wfVCJY4KKopeDqCWafHMkxI0gCg/xj5FxasHyjUEe7Z5QO/LjTwhG6F6
         LYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QOjAo8VLr5iNSlS9IO53OIcjxR+QttUBPV9pPv/+cs=;
        b=Pl2KSArV63Q6Vzv8PS+wvqdgXiOrv1e2D1nbJY6tm72wtzGvFNk1IFpz9myspI68aJ
         ZXkidhldCprNKawQsE6YgD++3KDWa37aNGbpE8TSaafhkK/J8jCXS6S6ZkIfBSVEjcqT
         OWQvNRqogIo2JuhAlmKhN2w4B98JX6uQ5U6TPQ8x9dZnO9cpcxZ2oMvLq/fb8Hy4bMHO
         26ajzrH2hmJvU4yTcTlSXOzQEcyDq+SXaBs1UYcZdFb6sgOu6VxY/xFcbhdShdJriI6d
         r12Une5ZtD1dEccUabbFXF2dkpQPb11OknN8KBBvsoeILyAL5CJpfFaIXNQM+OC+9uVk
         uRiA==
X-Gm-Message-State: AKS2vOxtHEzzF/L8HckUqn1czH5XBkD+JwIfdwoCiscKqhRpASOwZazi
        IK8U46bfNT03Xt0okv4=
X-Received: by 10.223.133.208 with SMTP id 16mr4919170wru.199.1497423115490;
        Tue, 13 Jun 2017 23:51:55 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3418:f00:2da1:5d6b:dc:8e99])
        by smtp.gmail.com with ESMTPSA id p187sm19919440wmd.20.2017.06.13.23.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 23:51:54 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     git@vger.kernel.org
Cc:     asheiduk@gmail.com, tboegi@web.de,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] doc: do not use `rm .git/index` when normalizing line endings
Date:   Wed, 14 Jun 2017 08:51:39 +0200
Message-Id: <20170614065139.10825-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170613221506.32732-1-asheiduk@gmail.com>
References: <20170613221506.32732-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When illustrating how to normalize the line endings, the
documentation in gitattributes tells the user to `rm .git/index`.

This is incorrect for two reasons:

 - Users shouldn't be instructed to mess around with the internal
   implementation of Git using raw file system tools like `rm`.

 - Within a submodule or an additional working tree `.git` is just a
   file containing a `gitdir: <path>` pointer into the real `.git`
   directory.  Therefore `rm .git/index` does not work.

The purpose of the `rm .git/index` instruction is to remove all entries
from the index without touching the working tree.  The way to do this
with Git is to use `read-tree --empty`.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 473648386..2a2d7e2a4 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -229,7 +229,7 @@ From a clean working directory:
 
 -------------------------------------------------
 $ echo "* text=auto" >.gitattributes
-$ rm .git/index     # Remove the index to re-scan the working directory
+$ git read-tree --empty   # Clean index, force re-scan of working directory
 $ git add .
 $ git status        # Show files that will be normalized
 $ git commit -m "Introduce end-of-line normalization"
-- 
2.13.0

