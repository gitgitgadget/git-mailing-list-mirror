Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25674C433E5
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 16:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0726E22D02
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="s2S+BRVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbgGTQfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgGTQfu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 12:35:50 -0400
X-Greylist: delayed 352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Jul 2020 09:35:50 PDT
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE40C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 09:35:50 -0700 (PDT)
Received: from mxback1j.mail.yandex.net (mxback1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10a])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 23E9E6741755
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 19:29:53 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback1j.mail.yandex.net (mxback/Yandex) with ESMTP id Af7RlbaNFn-TqrC6doT;
        Mon, 20 Jul 2020 19:29:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1595262592;
        bh=atX5/6rBiesH5ZvUX2lOsVrc3qZEm4tFnONY667iUq8=;
        h=Message-Id:Date:Subject:To:From;
        b=s2S+BRVg1EW9OPbqhcgF9T2ZsU9sQlZMtY92h2Tl4XYawyKokAOyYSvl8r9fockrS
         SduJdUf0D4TwhFfcs0XnpUhwNd1g0FU6TJYqriqfGxPiQ6MvhlELIGfDBXKLixPUFA
         aRoNWtplkXPamn2t1sMUhJ1EzAu0a104iXRk+yVA=
Authentication-Results: mxback1j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas8-b090c2642e35.qloud-c.yandex.net with HTTP;
        Mon, 20 Jul 2020 19:29:52 +0300
From:   Martian Chronicles <martian.chronicles@yandex.ru>
Envelope-From: martian-chronicles@yandex.ru
To:     git <git@vger.kernel.org>
Subject: BUG: Cannot use bright colors
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 20 Jul 2020 19:29:52 +0300
Message-Id: <6244191595262309@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cannot configure git to use brightred, neither on Windows nor on Ubuntu. 

Steps to reproduce: 

1. Create ~/.gitconfig with the two lines (or add to them to this file, if it exists):

[color.status]
        untracked = brightred

2. run `git status` from a directory with untracked files

Expected: output in brightred
Actual on Linux:
error: invalid color value: brightred fatal: bad config variable 'color.status.untracked' in file '/home/<username>/.gitconfig' at line 2 

Actual on windows:
 brightred=normal=white.
