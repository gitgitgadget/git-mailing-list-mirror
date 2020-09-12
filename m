Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A1C43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 20:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF53B21531
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 20:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ScVSE04v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgILUBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 16:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgILUBA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 16:01:00 -0400
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138C1C061573
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 13:01:00 -0700 (PDT)
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id CB2016740C00
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 23:00:48 +0300 (MSK)
Received: from mxback1q.mail.yandex.net (mxback1q.mail.yandex.net [IPv6:2a02:6b8:c0e:39:0:640:25b3:aea5])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id C72827F20002
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 23:00:48 +0300 (MSK)
Received: from vla1-1bc5b51c612f.qloud-c.yandex.net (vla1-1bc5b51c612f.qloud-c.yandex.net [2a02:6b8:c0d:89c:0:640:1bc5:b51c])
        by mxback1q.mail.yandex.net (mxback/Yandex) with ESMTP id UYgHQ7AKlE-0m0aY66w;
        Sat, 12 Sep 2020 23:00:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1599940848;
        bh=mFJTh8GXrx6U0iEJqvx5QKyRnv857qKVNIIUNPCb5PI=;
        h=Subject:From:To:Date:Message-ID;
        b=ScVSE04vxA72oy8W0IaDEBm4ng/T929GhyjP85b2RnVa0Jc53hmK2UXRlOJWvMKBu
         tTLK3zOhjytwvDWwUU2dpTwme0d+rAqfgz0VUlSLz6lfYbMJDIjoYzBxb/Y3lx3yZN
         Cf3wy9i/Muy4Yj3WfVjOQ+x3r4kpZMyyzTYKWisw=
Authentication-Results: mxback1q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-1bc5b51c612f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id LbHAFGaUcm-0mJCa1lT;
        Sat, 12 Sep 2020 23:00:48 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     git@vger.kernel.org
From:   Lobachevksiy Vitaliy <numzer0@yandex.ru>
Subject: Worktrees attached to bare repo don't work
Autocrypt: addr=numzer0@yandex.ru; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3b57a5b2-a34e-de95-38c7-9bc6923a8eba@yandex.ru>
Date:   Sat, 12 Sep 2020 22:59:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a bare repository and several worktrees attached to it. That was
working fine until recent update. Now when I try virtually any git
command like `git status` in any attached worktree, or even in a new
one, it prints `fatal: this operation must be run in a work tree`.
The workaround is simply `git config --worktree --add core.bare false`
in each worktree.

I have git version 2.28.0 on Void Linux (musl, amd64).

-- 
Vitaliy `numzero`
