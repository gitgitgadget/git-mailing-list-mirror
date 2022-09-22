Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC534ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 22:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiIVWLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiIVWLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 18:11:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123AB1129D8
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 15:11:52 -0700 (PDT)
Received: (qmail 9295 invoked by uid 109); 22 Sep 2022 22:11:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 22:11:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8434 invoked by uid 111); 22 Sep 2022 22:11:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 18:11:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 18:11:51 -0400
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        mjcheetham@outlook.com,
        Matthew John Cheetham <mjcheetham@github.com>
Subject: Re: [PATCH 0/3] Correct credential helper discrepancies handling
 input
Message-ID: <Yyzdp21kNuLqhM0X@coredump.intra.peff.net>
References: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 04:59:31PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> Whilst working in the credential helper and auth space I happened to notice
> that the behaviour of some of the credential helpers in contrib/credential/
> is not consistent.
> 
> Specifically both the git-credential-wincred and git-credential-netrc
> helpers die when they receive unknown credential property keys, which is
> contrary to the behaviour of all the other in-tree helpers including:
> git-credential-cache, -store, -libsecret, -gnome-keyring, -osxkeychain.
> 
> Also update the git-credential-osxkeychain helper to include a comment
> making it's behaviour explicit in ignoring unknown keys, as per other
> helpers.

Thanks, I think these are all sensible changes. The new behavior matches
the original vision of the helper protocol. But more importantly, it
brings them in line with all of the _other_ existing helpers. Which is
no coincidence, since the designer of the protocol wrote most of them. ;)

I haven't had a chance to look carefully at the rest of your larger
series yet, but I think these are a nice standalone improvement
regardless of what happens there.

-Peff
