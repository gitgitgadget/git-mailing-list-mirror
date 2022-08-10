Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A8EC19F2A
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 17:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiHJRDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiHJRDb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 13:03:31 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02302AE20
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 10:03:30 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4M2x8r75X0z9sR3
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 19:03:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwuensche.com;
        s=MBO0001; t=1660151005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=I0gYSXqe2nvc7e2PuildRejqJ8ZpWlyIC4VEEbnI3so=;
        b=a4NDDMJIr9lAS4a7RvjGp/i0QFAWU6fLNcllQa3Z4zuabve5nBpXEhknr5ftkJdNzlZwNw
        DJlcUt2pLOyuZlkmidXjA01ifMa1CavURXnTdDxuQFxCXfOAks1ty2N/jLX4iZ2z6r3VJh
        upHwGT+jnwVw6obAn815b42D6dESTpp3oosLwf7URNFT1IB2bkf09CctUZO1bhjEiXr7L4
        hKXha6nHY7X9AIzoBA5LWtXhGgc/5ssfr/sxfabAQtFG7SzHMw0QTgJ+dYYmc6dRhL17kN
        3dzWq4I+7Bt+Pz2sjkdg+IOshCCht5mD5eeaotNadiNevRZjUkyONjJ2bCbcjg==
Date:   Wed, 10 Aug 2022 19:03:19 +0200
From:   Niklas <git@nwuensche.com>
To:     git@vger.kernel.org
Subject: Bug: Git-Alias is callable from outside a git repo
Message-ID: <20220810170319.mxd6h2p5tm6y5xx3@imap.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps to reproduce:

1. Having the following global .gitconfig

[alias]
     f = "!echo "test""

2. Calling `git f` in a folder which does not belong to a git repo

Expected Behavior: 

Seeing some message like like
`fatal: not a git repository (or any parent up to mount point /)`

Actual Behavior:

Prints "test"

Git 2.37.1 under Arch Linux
