Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8050C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 19:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDFC2068F
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 19:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeG4kQVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKWTzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 14:55:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45128 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKWTzk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 14:55:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id z10so12622199wrs.12
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 11:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0SzQkxHgVdlH5GDLne5G/QBEHrmBvx04lzv5FFMx8H0=;
        b=TeG4kQVrV/WTH3WRxk+dCB8CqzWxHQH3L0mJk9osEyW6sDzXDWRpFnMdvFvRee6T84
         E/mr7fdTlqgiD8ox6evL6fndhVkXRKlgWCsiKxA5pe3JusBfjd2/q3+Ax1LSZDOhCyom
         YLXj6wPVsdCbKr8eUB+o2eOlNr0QWmZ5PyKoy9kfg52Z/oyNrvXbxuLkTEGQf4UiOfYw
         bwRAQGa5vLjBkOMmXnojhNEt55KLIdSGKmLTRioHVn6lvaTAsX+ox5c6JVTlhL7qK4fg
         n9ez0sNAU0jziG3tanMFm5MuritL+4f7IQDSpgQqCT157bt2BUntIzF+174MGctXFUON
         Wn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0SzQkxHgVdlH5GDLne5G/QBEHrmBvx04lzv5FFMx8H0=;
        b=O6qsKyGwmifiiUxeMUJjlUIp1c+iuoZKuppaOHR9ZYoZQMuRot7j1fLd6DDpVx0uYj
         38iPpAfbD9BfmwyIRov25ZGkMPqisgNng9uYJmu5Xnb5CaRUyT8CgR/irnsckRuRdIfE
         DfhZSMTpOhtb/GqAx0DjbDAJ553FsqKBPJhrdLK2TO8p/q9UK6g4sIwmGXzxZaGFCBMN
         mcdfuI8GjzVGUKPnummHsrsYEAv0xCDHlqIMpvHSgw6NRNU725ZaNp2PgphDYB7B9t4e
         Fg+iDhCJ4EVSHuvp+I3rPaJEFJGHBBHJT8T5ocwJWOID3A1m7jV2b752wBA2ptoFIEtm
         b+Nw==
X-Gm-Message-State: APjAAAWULc8d4q4TUfeHO+Ed7XBpsZVCQbaoqfhqCTOvWUzTOspoXQ0I
        91CyvsWi7VBpB2b5emAA0FKcFAOQ
X-Google-Smtp-Source: APXvYqwlaDEzK0pP5DO2iZi9GnTm2BCCLCNRFpZXxny9mLBumAcpnjGuqzbb6YDv/ppQdRaMDaSTgw==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr23242648wrc.169.1574538938153;
        Sat, 23 Nov 2019 11:55:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j67sm2955770wmb.43.2019.11.23.11.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 11:55:37 -0800 (PST)
Message-Id: <pull.474.git.1574538937.gitgitgadget@gmail.com>
From:   "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 19:55:35 +0000
Subject: [PATCH 0/1] reset: parse rev as tree-ish in patch mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nika Layzell <nika@thelayzells.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows passing a tree-ish git reset -p without specifying a pathspec.
Requiring a commit in this situation appears to be an oversight, and support
for a tree-ish is documented by git-reset's manpage. (
https://github.com/git/git/blob/d9f6f3b6195a0ca35642561e530798ad1469bd41/Documentation/git-reset.txt#L12
)

An alternative implementation of this change would move the if (patch_mode)
{ ... return; } check before the rev parsing logic, offloading validation of
the rev argument when in patch mode to the git-add--interactive logic. This
would be possible as the parsed oid is not passed to git-add--interactive. (
https://github.com/git/git/blob/d9f6f3b6195a0ca35642561e530798ad1469bd41/builtin/reset.c#L341-L346
)

Nika Layzell (1):
  reset: parse rev as tree-ish in patch mode

 builtin/reset.c        | 2 +-
 t/t7105-reset-patch.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-474%2Fmystor%2Freset-interactive-treeish-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-474/mystor/reset-interactive-treeish-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/474
-- 
gitgitgadget
