Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC5C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 01:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJFBcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 21:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFBcU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 21:32:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB3A7A768
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 18:32:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s206so557924pgs.3
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 18:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBsiZPddkOVXiPndYZkoM1WNgAHgBOn/ftiwEm2Fi3s=;
        b=WwvsfCcGMcFID3F9Q1dqwPXMAUCHFoQl8Bt62T8xlr24w8t8KladfCUcw/KAG3MvLN
         THq5xFPYV7yeGbQfk3HOgY1F+96VDeWcRFpJ6nGWS3nUjZ44SrKEwl8stHwq2xqVZ2gL
         w61GiGBxA4kn5UGvY+1NbnWxDlt0dDDkt9TSf9bRCS60jYmqnR1okU6w1lHePRaQ9wpV
         E1zYPugOtqjNXVlV9PRO63Ckye1GANhZU/X4pIKVpQSiJUJ2App4uaVmpQKaib2NILxe
         H5QwOsq+j4MKd9WNgMAIc8mqKfnqtaMLqLRXpclkBVVot37KoQ5SPmBJV46i+ePqvCon
         Mong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBsiZPddkOVXiPndYZkoM1WNgAHgBOn/ftiwEm2Fi3s=;
        b=AFflegE2beud/7/DpZPWRIshGHp2eMJ1SGFVTkku+jDf+DrRf1Ygot1rxND4x5WFsq
         FI2BzfH4z26F5MIV2V/GKFSl/JPERk0ey6m4ZzU6QzIJdK9TPBcZZdw6skd79JD6Sji2
         HVm3OUlshLaY+yUpHc3ddmoSLgZqujmNtGotF2C5rQtjRp9sLs2YaMN0ZJ7T2O7ZB4CQ
         mCSCm0q2SmjRnsUTHSoPLciGhT8gb8fxDYUQvmpQ3Pj8CwN+xtVVR1NN/cueXUkGhogX
         yNXh4fenihkavNEf1eqftoexh6qJz8pVx2kTX5goHvH+Nqmr/pz9XApzFSwIcmpSz6mZ
         foqw==
X-Gm-Message-State: ACrzQf1Wjb/4IlLBC2KYhWXfTHfC1u1R0SSZoi6ZsO2tHxbMnrE7agKl
        u98/iVnMa1qz3DUoPhshFlU+HxAtRCM=
X-Google-Smtp-Source: AMsMyM4l2ed0GEVnQKWAHReTbYQm/CEVOhaodXS2VYhLz/t8akir4c+AtaRxCqvY2cXDEqJSjJgxfQ==
X-Received: by 2002:a62:1d86:0:b0:561:397f:48be with SMTP id d128-20020a621d86000000b00561397f48bemr2299484pfd.4.1665019939005;
        Wed, 05 Oct 2022 18:32:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79910000000b0056247dfdd3csm1554645pff.182.2022.10.05.18.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 18:32:18 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, darkdragon-001@web.de,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: clarify runtime relative gitexecdir
Date:   Thu,  6 Oct 2022 08:32:05 +0700
Message-Id: <20221006013205.15015-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.0.1.ge44e9fe867
In-Reply-To: <xmqqpmf6nf09.fsf@gitster.g>
References: <xmqqpmf6nf09.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git" built with RUNTIME_PREFIX flag turned on could figure out
gitexecdir and other paths as relative to "git" executable.

However, in the section specifies gitexecdir, RUNTIME_PREFIX wasn't
mentioned, thus users may wrongly assume that "git" always locates
gitexecdir as relative path to the executable.

Let's clarify that only "git" built with RUNTIME_PREFIX will locate
gitexecdir as relative path.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index cac3452edb..8a58be440f 100644
--- a/Makefile
+++ b/Makefile
@@ -529,8 +529,9 @@ GIT-VERSION-FILE: FORCE
 #   template_dir
 #   sysconfdir
 # can be specified as a relative path some/where/else;
-# this is interpreted as relative to $(prefix) and "git" at
-# runtime figures out where they are based on the path to the executable.
+# this is interpreted as relative to $(prefix) and "git" built with
+# RUNTIME_PREFIX flag will figure out (at runtime) where they are
+# based on the path to the executable.
 # Additionally, the following will be treated as relative by "git" if they
 # begin with "$(prefix)/":
 #   mandir
-- 
2.38.0.1.ge44e9fe867

