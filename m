Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4D0C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbhLVS44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344966AbhLVS4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:45 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9597EC06173F
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso2020592wmf.3
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S929WtbLycx8tthlebgwee0eZnsSzF55QNgcBtMV46g=;
        b=Dtj26eDLjkRVNKQjBPVG4jhMmfMkttqoQRbB37DyZPysw9WyrYXXYbMU+dUpEV6RAo
         Y6sWCYxH5kEBGOeXysIUOlcdDKZKS3uqsx1EsbwHN8mYDi0MoR4Qw9h7VEu/9adbB3MU
         sqwMofMC82DorEQnmawctQMedHKvscPibxJoa/HDWwaQGpEoYOkuB4LgHizMtVrBI2T+
         rr9HQQrOfqx5FcMMOg2iQbCCmRXCn2pIK58QCajIJsXNZGdc8tdX6zU/L+tCXPKHLEq1
         7ySdxPk6c6lUDiqKUxpxtjq1x1KdaDB248JeozKCuvCJO7m5I4OApJFpsWcqHgiO2t3T
         Joew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S929WtbLycx8tthlebgwee0eZnsSzF55QNgcBtMV46g=;
        b=upVxemxdrXQ+WC/O6s6nP/3G9MrYSbF2HOzFoDN5a9bOOfJ5xGn6BR4j/Rre7OrMYK
         ZdDhIIrBQJN+DlMXCDXdpEjNhixSxY+SZPTAtwLY6H7GJZA7G8RcXgydF34hL6V4U03O
         DKQuolkI7kVfvyQHGdDQNlfLtMowZiu3l4SmXhfz6a+gWKNBR8s2eiTzMd1eV88Zey/C
         HyXdNSPVfcnzOQM+3rSd2UPCdrA3ImpLw+Mlg6CTVzo5IOsG5f4ZzUyLFNGjBI8XJdr0
         PsPztIDNdou6tuvXML8xv+fIyLJ80feo+aodBI4THfAhEDwDq27x4KjsDO74vT3QunNN
         rXZw==
X-Gm-Message-State: AOAM533x80s8Dv5DcKUjOB/tL/VOnC/G7LK98q3dbbjcPatjWDrrtELZ
        rxGwSjcNKv/7jC38cMsis9EzS32zezg=
X-Google-Smtp-Source: ABdhPJyh+2bNQIHnlswLX+o7j64k4lTJM0w8yp454XreYnJ6qWUZcyr+r6RYtQP+uKFXra9yP++Uvw==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr1797073wmz.89.1640199403104;
        Wed, 22 Dec 2021 10:56:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm2587519wra.61.2021.12.22.10.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:42 -0800 (PST)
Message-Id: <425e12d3667754a152b32a75cad435aad6a06148.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:29 +0000
Subject: [PATCH v5 09/16] reftable: drop stray printf in readwrite_test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 6e88182a83a..9b89a5da103 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -662,7 +662,6 @@ static void test_write_key_order(void)
 	err = reftable_writer_add_ref(w, &refs[0]);
 	EXPECT_ERR(err);
 	err = reftable_writer_add_ref(w, &refs[1]);
-	printf("%d\n", err);
 	EXPECT(err == REFTABLE_API_ERROR);
 	reftable_writer_close(w);
 	reftable_writer_free(w);
-- 
gitgitgadget

