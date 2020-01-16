Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395C8C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5F72073A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGGzRDla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgAPUWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:22:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36707 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387715AbgAPUWD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:22:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so5217295wma.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VYUWqUAJ1JeOF6I5J9ytUkLJp0ByRYwLfAY5HJ/OMRo=;
        b=QGGzRDla+CfGY+PLENbUksE+h33ufkH8ZUMFoktdiySkciPjjgqwqKPF3Yhltpqrof
         6wDeGtySMPZ5pCZV8bmtw3Smi39HK/3QyyYinxETywNRjKeeN+GdJR5LhGahEIhObxRt
         b4MS808q2nfIedW+WGiBo5YKeQ23v3QCZq8WMl2ZWpZVmEmMFIXpzDifDwYVwjbnLEbo
         UE3yIp0nMkPangXo7ZVL1/y13zSoTuKK6p/gs2b2pmWho5jS1FmZULt1cfOVz4zPrwD7
         a6Fcy2C66Pw+m0deAmhb916+QH8ARxSRgqVprzImQ8TLAf5BDjlZOoKZ+7pIzaZLW+8g
         qeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VYUWqUAJ1JeOF6I5J9ytUkLJp0ByRYwLfAY5HJ/OMRo=;
        b=gj4Qf5AK5WUBZpbtjKevwzkX7fCM61hlLDwLqcK9vk7BXNmk6SV3DJC+2zLBvagMre
         ceWbkpNf/iusxP7wE3Sjl4M3XzUnSdR4RNpBavxUastjiT8ivf0R5iEapxaoWl2KMS+A
         b/IaBv7Ilqx4CQwxd3LRsQX7+7ovggXSY6cTs1I/NbE75Hpww0a7QUpY4vrtRSl1pLkb
         0KhsGtS5WNMu3dbtSqiJZW0Z16uuRnT8pm5L7U350fiYsnQBQ7HUsfEApX67GaDDzt00
         ucX/FqJs3buoLIkytDsfK6d1QulAW1y2F/KbXBJ9MM8unPXFvlevtxMtRpwH1tCfYBCJ
         OMCQ==
X-Gm-Message-State: APjAAAUrff7wcYjs8bXcmuHMtVjBuOp7Yq48PkF4KeY0PhVtmksg4+2m
        knx4ybqOgxYfsJfCPkFt1v42nOFj
X-Google-Smtp-Source: APXvYqwxvC4+opsCsPm0KbOWh65/w/YnBUEjTN/0p4k0dclB1vYdVCjDTyEIHyM58WloKmW0642Shg==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr761222wmf.113.1579206120930;
        Thu, 16 Jan 2020 12:22:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm32184540wrj.23.2020.01.16.12.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:22:00 -0800 (PST)
Message-Id: <9d346f8b6bf8ba59e5dcb5460048934030634c1d.1579206117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
References: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
        <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 20:21:56 +0000
Subject: [PATCH v3 4/4] dir: point treat_leading_path() warning to the right
 place
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Kevin.Willford@microsoft.com, Kyle Meyer <kyle@kyleam.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Commit 777b420347 (dir: synchronize treat_leading_path() and
read_directory_recursive(), 2019-12-19) tried to add two warning
comments in those functions, pointing at each other. But the one in
treat_leading_path() just points at itself.

Let's fix that. Since the comment also redirects the reader for more
details to "the commit that added this warning", and since we're now
modifying the warning (creating a new commit without those details),
let's mention the actual commit id.

Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 8437030006..b460211e61 100644
--- a/dir.c
+++ b/dir.c
@@ -2310,9 +2310,9 @@ static int treat_leading_path(struct dir_struct *dir,
 	 * WARNING WARNING WARNING:
 	 *
 	 * Any updates to the traversal logic here may need corresponding
-	 * updates in treat_leading_path().  See the commit message for the
-	 * commit adding this warning as well as the commit preceding it
-	 * for details.
+	 * updates in read_directory_recursive().  See 777b420347 (dir:
+	 * synchronize treat_leading_path() and read_directory_recursive(),
+	 * 2019-12-19) and its parent commit for details.
 	 */
 
 	struct strbuf sb = STRBUF_INIT;
-- 
gitgitgadget
