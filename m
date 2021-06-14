Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F081C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4483A610A2
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhFNMpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:45:16 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44606 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhFNMpM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 08:45:12 -0400
Received: by mail-wr1-f49.google.com with SMTP id f2so14388752wri.11
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MVEj0jyayJxj5N468DdFOi+lC7SHo1qyJKTRRJ3RsOs=;
        b=NHdmJHvGFH7cIvLawfq3RvwDroP6Um8GxMZxIv9gBoSCqNeBRKpOviAv8dnE7qp++B
         O6R8KXEUvZSqUeioOQ8k/rpgvy95dLhAfi91xetkcORNwJyBohXvcs70VfV2OD8sbLMn
         2r3xu+BWoXbvEbfqKiNqhZodYZEjbcXL9pZIm/kGRbPqrBK60IR/GhiL0NDfRsm3xrUy
         fYV6Tlmrhgnhs6WjwPyHs2x/zxCGXXMiYh27WHIpnF2hB0AKfo7sMLtG5vYmWx7I1OFf
         QB4r764iO9A/CJUVhtnnbty8Kq59VlxOKXjO5lLAJ/VoIo/Itvcgz0y/cZ574V6derWK
         TFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MVEj0jyayJxj5N468DdFOi+lC7SHo1qyJKTRRJ3RsOs=;
        b=U6OOo3dG+WmfcufW225xIfUnXwX4Jo3DeH1wV2b1qvzsMQMoZlSMIlwxpRbFO5FzfU
         Cje5GiS2KP0D8Ia2yc0Vke9ktoYnc0dFzVqQiLjRfVj+uptbirsoftGzQIizt0DomxNz
         gX5zkmF7d0FzUX7/LpQ/oz5Oj3kfa1enVQUR+QkVrLnPDFMYfgeWDaesRhbN1EpgS4/H
         3Gn/MpLwy3S+mfxp+iHI1d9QoRjZ2v9Ovhj9WDOVxc9vbKmBQw3H5nEMSxiQcJQxKVia
         yhxkvMbOPR2OvrkZMV7I+CIf+7BoVBHaraoESyGT8SE0ioDb5VGOT3M4IKL6+nRohfDb
         BkGg==
X-Gm-Message-State: AOAM533yXwRjr/qaCEflAWgAicgycyj8gLeJK1EqsajZLFnUnczIoSDO
        vfbtH1KZkh3c7QrjBCJ179Y67/h5F4Q=
X-Google-Smtp-Source: ABdhPJw+SObKL4VwWYDWWPuAuBdwTC9bTLybxIheIwe1bWP1iBik1GlmINDYwxGZRosSGcuIMuswNQ==
X-Received: by 2002:a5d:5988:: with SMTP id n8mr18485556wri.261.1623674515995;
        Mon, 14 Jun 2021 05:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 125sm21515609wmb.34.2021.06.14.05.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 05:41:55 -0700 (PDT)
Message-Id: <5f2d9434b4ebb66131ea2fb9fbb62d6338af1294.1623674513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.978.v2.git.1623674513.gitgitgadget@gmail.com>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
        <pull.978.v2.git.1623674513.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 12:41:52 +0000
Subject: [PATCH v2 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work on
 Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 22d550749361 (subtree: don't fuss with PATH, 2021-04-27), `git
subtree` was broken thoroughly on Windows.

The reason is that it assumes Unix semantics, where `PATH` is
colon-separated, and it assumes that `$GIT_EXEC_PATH:` is a verbatim
prefix of `$PATH`. Neither are true, the latter in particular because
`GIT_EXEC_PATH` is a Windows-style path, while `PATH` is a Unix-style
path list.

Let's make extra certain that `$GIT_EXEC_PATH` and the first component
of `$PATH` refer to different entities before erroring out.

We do that by using the `test <path1> -ef <path2>` command that verifies
that the inode of `<path1>` and of `<path2>` is the same.

Sadly, this construct is non-portable, according to
https://pubs.opengroup.org/onlinepubs/009695399/utilities/test.html.
However, it does not matter in practice because we still first look
whether `$GIT_EXEC_PREFIX` is string-identical to the first component of
`$PATH`. This will give us the expected result everywhere but in Git for
Windows, and Git for Windows' own Bash _does_ handle the `-ef` operator.

Just in case that we _do_ need to show the error message _and_ are
running in a shell that lacks support for `-ef`, we simply suppress the
error output for that part.

This fixes https://github.com/git-for-windows/git/issues/3260

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/subtree/git-subtree.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index b06782bc7955..3935cea7dd13 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -5,7 +5,10 @@
 # Copyright (C) 2009 Avery Pennarun <apenwarr@gmail.com>
 #
 
-if test -z "$GIT_EXEC_PATH" || test "${PATH#"${GIT_EXEC_PATH}:"}" = "$PATH" || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
+if test -z "$GIT_EXEC_PATH" || ! test -f "$GIT_EXEC_PATH/git-sh-setup" || {
+	test "${PATH#"${GIT_EXEC_PATH}:"}" = "$PATH" &&
+	test ! "$GIT_EXEC_PATH" -ef "${PATH%%:*}" 2>/dev/null
+}
 then
 	echo >&2 'It looks like either your git installation or your'
 	echo >&2 'git-subtree installation is broken.'
-- 
gitgitgadget

