Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FC8C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 20:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiJZUPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiJZUPx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 16:15:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A713965815
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:15:50 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id 7so6607839ilg.11
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmTZS19p6YPkvfPbNDk4/UyQewqYRDltDS5+Pq38oP4=;
        b=w+0L7wB3EswG503IgjFFYlEo85rbo5+b8CGThuIh4E8B1YQZTFLjBXjeFcFfeDzcXG
         KlIeCV4Ytw35G5bogszFT3Tml2+awTERqE9HMCsI0bqZeaJ0D2IAY+vYpxRnYDEmbK4Q
         6kXyZlYBpVGn5O5jqU0wfAwjCiA3zBBaeZmfpXNai9ossXgCHT4MntPk2zJ+VJ8kFfQm
         3wwQDDNYaixkBtFQTsJiMgdfkEIDoTFx2Bw2m0GWkNbuDlYntfew2bR/VDp9ZJaC05fT
         Y0v2Fyg+hTxY6CGTK7uQ+5TwtSt3Xer1TRMzWsb10DUiyCsNwcVZDyZal+JNCyxXSJke
         giTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmTZS19p6YPkvfPbNDk4/UyQewqYRDltDS5+Pq38oP4=;
        b=n2w+gFsw8tLKLIWCkcUDjELaeI39kFm5O5YcIt1iZrlKT/GU/OrjGsYMtp0MN6qyY9
         Okf11vGQKSV29KDTJJfCrTsfi74cJRXftdwcDjm+us5UmyNlZPQYEqdG8tTTTAWPFTv1
         sD8Fjnaaa8Qz15I5L9yMBs8vD89Z8SnnfZkuS9LLTDOa0THC9pVJYEmVQNgS0zPZ2X8f
         JgS9DraBc+bKKXjzFB3MKPlBItzlaYiQAZok2i0g06ZvJtX5y2rO81pgx5yOceo5xG9G
         M1JFN3P9yplfnYFlIfVx5JVLwEA67qzfjTuDY6biifLk3vqfbKZ3barpDOBJtT/iy0JT
         /nXQ==
X-Gm-Message-State: ACrzQf0jgSOjWTY1jpaJPABo9f5SoZUYUPvk87WVaShxUY3veRPzBBl6
        OOGwnBuYELV/1vVztDiPQMO4d4VZ1VTnpVXA
X-Google-Smtp-Source: AMsMyM6VIJYCPKhxTNZEQFdt9Bj986DZys6uvFIuFRp20Z+t2JDS7Wcing9z5k8u03o+mbWVH5Mm0w==
X-Received: by 2002:a05:6e02:174f:b0:2fa:5a18:96de with SMTP id y15-20020a056e02174f00b002fa5a1896demr28469063ill.52.1666815349771;
        Wed, 26 Oct 2022 13:15:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k12-20020a056e021a8c00b002fb78f6c166sm2410363ilv.10.2022.10.26.13.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:15:49 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:15:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/howto/maintain-git.txt: fix Meta/redo-jch.sh
 invocation
Message-ID: <4ba057094ae6b1bd5c18583f23f7f99232034c72.1666815325.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Meta/redo-jch.sh script is generated a few lines earlier by running:

    $ Meta/Reintegrate master..seen >Meta/redo-jch.sh

But the resulting script is not necessarily executable. Later mentions
of this script invoke it with sh (instead of directly), but this one is
an odd one out.

Update the documentation to invoke the Meta/redo-jch.sh script with sh
in case the maintainer has not made the script executable.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed while reading and following along with
Documentation/howto/maintain-git.txt.

 Documentation/howto/maintain-git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index a67130debb..215e2edb0f 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -256,7 +256,7 @@ by doing the following:
    merged to 'next', add it at the end of the list.  Then:

      $ git checkout -B jch master
-     $ Meta/redo-jch.sh -c1
+     $ sh Meta/redo-jch.sh -c1

    to rebuild the 'jch' branch from scratch.  "-c1" tells the script
    to stop merging at the first line that begins with '###'
--
2.38.0.16.g393fd4c6db
