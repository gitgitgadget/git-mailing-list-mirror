Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F316AC432C3
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 13:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F352075E
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 13:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFxDcmrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKXNJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 08:09:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54029 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfKXNJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 08:09:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so12353317wmc.3
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 05:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=iIA91TnQBc6ulR+2vAC3fFzGSllS+yxLkYHCQuleEEM=;
        b=jFxDcmrjA2g+gr2y3n4SuLuH4JyiEUIHqfp8HFcJvNLvrpcQ32ggvly2EldPEN7TDm
         ZMMI6z9iBshrZWky3hfnHSYst8pohrBXMp+OUJWgYpxZjVDJHMpuC50Ysh/ABIUatcA/
         NHwidyVncYA8sGgjU6AyppRBXj9qTdsirvSfpt2HWG5BNTDOYiNjQu7DgYSwjXFvIfGC
         kfs4NkNEUMeY20Nm4hKZlCmOqBdjeCX0veR082LboIXVrefl4x98rFFvYqeBQ0Hx+lMp
         wwQQgYKfJwIUjccO/cmMMSdzfzCM5uhVU5TeplVB8i7oiT2jzeR2gB+cvUXaAHZi7YpI
         f6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iIA91TnQBc6ulR+2vAC3fFzGSllS+yxLkYHCQuleEEM=;
        b=O80qHQ2SlCREFpr1KkOCx84VQ1DjF1e1auN/Kvbf9jOl/+JnWVdEMrRxfz9WjGu7Sw
         273gT6qlLxYliPI6BGQ4b1RbwOR3bNdFpPxE1kXTn1+Ru4vLgzP0IyFMqHDDX0d1S0wa
         ZqBwFBGp6YbkfokE77piXcbgDZxIDidaHJry0Uy5jFulEZqeQ7pHvvtR/Ofapht133OD
         kFwnYTddHPVwTxnJxkzDhDak0irvH5eRDH9aW+37Dj54OqJYWSBitWcsjBEMGHnvFu6p
         DTtZHnpCOHNKg4cGGg8MSNU1iu1iOMgj4Pq6PZGNtmFx1EUbvufjktOvwdsUbMI745kF
         D15w==
X-Gm-Message-State: APjAAAUYOs7BUJmxLvMRKguZse89CLsYnGuhw9CiQ6uqIiaH0BAfBToS
        evYKp/ixFfL/2FCHw8IK5NIoyPF3
X-Google-Smtp-Source: APXvYqwe2Q0FmTKtHCDKGlfuQ4tQrBJtCPjem6dZ8NwsGcrdo8jQraI3aqt7lrUPtlQQxVfgoUhkOA==
X-Received: by 2002:a1c:48c2:: with SMTP id v185mr23075637wma.61.1574600964610;
        Sun, 24 Nov 2019 05:09:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f24sm5046044wmb.37.2019.11.24.05.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 05:09:24 -0800 (PST)
Message-Id: <pull.473.git.1574600963.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 13:09:22 +0000
Subject: [PATCH 0/1] git-compat-util.h: drop the PRIuMAX definition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's code base already seems to be using PRIdMAX without any such fallback
definition for quite a while (75459410edd (json_writer: new routines to
create JSON data, 2018-07-13), to be precise, and the first Git version to
include that commit was v2.19.0).

Therefore it should be safe to drop the fallback definition for PRIuMAX in
git-compat-util.h.

This addresses https://github.com/gitgitgadget/git/issues/399

Hariom Verma (1):
  git-compat-util.h: drop the `PRIuMAX` definition

 git-compat-util.h | 4 ----
 1 file changed, 4 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-473%2Fharry-hov%2Fpriumax-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-473/harry-hov/priumax-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/473
-- 
gitgitgadget
