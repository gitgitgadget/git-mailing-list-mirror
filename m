Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8801FEC875E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbjIGWUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241407AbjIGWUc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14991BEB
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4018af103bcso9354105e9.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125220; x=1694730020; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgOZP2UTxk6qof7UeF3G3H6T/61SdqkS7V9hwZKLdag=;
        b=sAP0hbv1LzKQ+V94+h1azGAPqU14SK4rl2+ap4V/6nCGyEaULccuvgMDLbTvzwWQw4
         o5eZiGUaG+7C818hUrH1ZO042t7XbSBQ/Sc8ZewqDyZuDEdGtgJ1augbAQWEsf7ZJLS1
         JJDq9sclTWrsKzuhQTsKlOMBBTN0jFA2shodPthWIlclIgGyVodEv2kge5MG2ZLaKSEf
         0WFEqv2cDDC1lKHzEujVNerzn8BlnO3Nf/1rYdgv79N5xiVuP1RMEgvIH3S/MeQ23i1d
         aD4+bDS42k7VF0j8GmH1b5g5pv8eg7oGwk6707Mrdy3ZCpiDP6euLGj+T9OM7WMa4S+X
         +16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125220; x=1694730020;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgOZP2UTxk6qof7UeF3G3H6T/61SdqkS7V9hwZKLdag=;
        b=J7+XWhsgP2bwiXWC6v255qkig+p1f94kylV62cSTwqi/Z7ain9LVQuAgOC5gHiWQbg
         EZ0M/SSafqtRajEqTqnLwlLMv0OHVeIyye5PE/g+qYCXAO72gvsuYrYo78eoeckcygbE
         xoW0twPSEGxCOjl0QHeHNCMCjejOOo/aVDSwXxVPIJqYuR5EWlsN9Agqs1diTCeJPcaT
         b71PjW42pQSUVz2hyNXhKoMRc1H5wECBu+HDjDkt3ZnCMMU3NXhTajRovqwDaQmDW7Ss
         tQtGt+sbjhUTpEa91/MozEmXmYWWjaaQnqRnwL6DqOsHjbJR6J7bPISo/GDcKvY5oMnr
         rXJQ==
X-Gm-Message-State: AOJu0YykbSxp8qfV24d3kXZUwiHb62gtB52I7TiPixlQdj43JF0UjyNo
        NX0rVcmW3JS7KWC7t4xSemqUS5OC7WM=
X-Google-Smtp-Source: AGHT+IHwu/Xwj7MTXhOZPeOnZYxrNS6LO6JVu17dmHuak9IlNO6Om+linCggqMhwoAya9cXRji0v2Q==
X-Received: by 2002:a05:600c:6013:b0:401:c7ec:b930 with SMTP id az19-20020a05600c601300b00401c7ecb930mr3162991wmb.10.1694125220281;
        Thu, 07 Sep 2023 15:20:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6103000000b00316eb7770b8sm448047wrt.5.2023.09.07.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:19 -0700 (PDT)
Message-ID: <66087eaf5bd2abc416628cdcf166b8bd7e9cbf2e.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:20:08 +0000
Subject: [PATCH v3 12/13] trailer doc: separator within key suppresses default
 separator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index a288ff111cb..25433e1a1ff 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -255,8 +255,8 @@ trailer.<token>.key::
 	but this can be changed using the `trailer.separators` config
 	variable.
 +
-If there is a separator, then the key will be used instead of both the
-<token> and the default separator when adding the trailer.
+If there is a separator in the key, then it overrides the default
+separator when adding the trailer.
 
 trailer.<token>.where::
 	This option takes the same values as the 'trailer.where'
-- 
gitgitgadget

