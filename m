Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D787C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F0C20657
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWqZAj60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbgHQRSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389671AbgHQRSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:18:35 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49157C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:18:34 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e11so7217292ils.10
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/BOkytHnzYFgRJBTCni8LBaimpChbtskExKQvXcK5y8=;
        b=oWqZAj60g7g2PmxZBMB2sPJdjM33XFqfUiKkxJbWseoZ3xXn049Ty6WaVj7I+HstnN
         fhrMUr2RS2No/IspPA//x21lbuZZ68I52tXHe+XVZ21aPki9xH2XAqj21JdAi/3Yb+Zt
         UBFNB1vrKeoD2MHJ4shXyHVP8cfFkbBPCAZfegMlnN/UIlo96XwgJFYJa5E29ZP9LWPN
         ZzuIpnL2m9fFeVXGTjpbIWspIJiJMoBKbcPXT/L6/dqfAZnImJrMl93uTysgyL1JiyQD
         7/FKLvqMwrK3m/mjUCAAE1CmnDQKT62eqOHV0eOCS1z3n4NY33KRJxwxy7zHimcsSqrP
         Y+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/BOkytHnzYFgRJBTCni8LBaimpChbtskExKQvXcK5y8=;
        b=dbWI9sfmgbNnKaSncsCGxsFlEyQVsinNgBS/XVLDsSsseJlJ7L2EIvbkq6Y0WBApCw
         9Dy5qUuahN9faZhOdvpdCbgGiaTpm3Ke6ir8LbZSIAQrltu6JSgqEjhuNecI2cRzaq+b
         G7aC/COZl3adbQoM/7Gx9x2hjVThQgkRmEZhIuJ/dgM5sDfNvqKh2OBi8E5WX3akKGo6
         Ld/Kq7agk8rtde9aK9yL9R4m9Jh+ZahccCYqISCQPWrdp8lmw/TUT6W2IEF+ceUvJxis
         5YCqX132jHOeGmg4j+/6bONLBaiWcZRrvzwdJdRtGCkfVKslR+YocAG7xf2LHDuOAMvn
         VJqw==
X-Gm-Message-State: AOAM532KKUBItJqQV85XckzIKsBezTREaO0kyey25UPsNebtObTe5dmB
        9W6uuy29atx5MbLzlOrMNgvtgamlkXaC1DLnbhvSA6mPeHnZZg==
X-Google-Smtp-Source: ABdhPJzXGlylKS+EZXdMlt/IjMBJhhaMPd9CfUjrmekrumEI5badAXwPJu6EqU6KfHqtrGd/7fWVIl5oKIW3Hh+WbBA=
X-Received: by 2002:a92:3209:: with SMTP id z9mr7142491ile.126.1597684713596;
 Mon, 17 Aug 2020 10:18:33 -0700 (PDT)
MIME-Version: 1.0
From:   Gopal Yadav <gopunop@gmail.com>
Date:   Mon, 17 Aug 2020 22:48:22 +0530
Message-ID: <CAAUOv8hTahjiLvPzX-281wj4omCMktE+MfnPk-xH4Ty1P4W=xw@mail.gmail.com>
Subject: [Microproject] t0000-basic.sh: replaced test -f with test_path_is_file
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t0000-basic.sh: replaced test -f with test_path_is_file

Signed-off-by: Gopal Yadav <gopunop@gmail.com>
---
Hi,
I am new here, and thought of starting out by completing the microproject.


 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 923281af93..eb99892a87 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with
--missing-ok' '
 test_expect_success 'git read-tree followed by write-tree should be
idempotent' '
     rm -f .git/index &&
     git read-tree $tree &&
-    test -f .git/index &&
+    test_path_is_file .git/index &&
     newtree=$(git write-tree) &&
     test "$newtree" = "$tree"
 '
-- 
2.20.1
