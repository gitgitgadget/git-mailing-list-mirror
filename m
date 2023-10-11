Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65001CDB46E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjJKXXK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Oct 2023 19:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjJKXXI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:23:08 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9ABCC
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:23:07 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D9B5B81D4A;
        Wed, 11 Oct 2023 23:16:30 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id CB1DD80DDE;
        Wed, 11 Oct 2023 23:16:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697066190; a=rsa-sha256;
        cv=none;
        b=21/uR67fwAw46GjIJu0wpA8NTuM9H+M1+KeX858tAEeQJWvIKrJ9lqJ6ZsvAzjA8r2+mfP
        GdnGpZYuOvk16X4AF/sL2DcLVkIkwKZVR0xJ+ZU8myHZKbW4CkaBk1BXR6soy0N5/zwZPP
        mVMwe+cq8H3CsOmziPE3zhErd4pB8x5Y+ifp+EmaOyJDX6tl8f0tXnlbvXGYXiunCZMms4
        8yVlbRrRlHHTRVEHHozDK4Yz647YdiR+hqRzI0GhQNEUBkuAhpzYj8dMc7NSRyVUi8bnf2
        nNdDwtwjwUbtSuZciFuWTQoKhdNUC6znChEbZtLHsqqb/fapex9t+9zYNWzvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697066190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7R9vSd1GBgEsX5gUOinVY5K3MY80c4t9jN+avfpqVOY=;
        b=2Tw0/re2VR0036nmRNXdHnOza60YLJBHe+pGZcDfyOjGyHIfcjfWXZb6fdlYOe1UsEhd9x
        ynW+K1s1IYPzYDUeLxAHuJ0Eyryg+L2aDofMX4Hl/G9MdYliV1dG58/koG9Wx/k+yfudg6
        ct3e7H0LQBgHdTSEY6Y3ZA1V7tSWQnZ/6FEorc79RzPoCCpufk1Gr/q0FqJhzNZhaEcPXz
        5FEy0KvPicZsrhK8nrwnr9gUVnaCXU+tJFQmNp9BYXIgE/9c0jv1O5F5H4bUBqq5myvo/Z
        pXLf5y7AnsPbAMTGhaxAvNNyywQsyt8yeYBXIiC35l3N7Dlvw+iaXOO5SrVY4Q==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-v84gc;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Shrill-Imminent: 4974d7d9162d7938_1697066190606_3552679438
X-MC-Loop-Signature: 1697066190606:1018752896
X-MC-Ingress-Time: 1697066190606
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.222.7 (trex/6.9.1);
        Wed, 11 Oct 2023 23:16:30 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:33338 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qqiRE-0006xV-2l;
        Wed, 11 Oct 2023 23:16:28 +0000
Message-ID: <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
Subject: Re: why does git set X in LESS env var?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Thu, 12 Oct 2023 01:16:22 +0200
In-Reply-To: <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
         <xmqqa5sokdd3.fsf@gitster.g>
         <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
         <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2023-10-12 at 00:51 +0200, Dragan Simic wrote:
> In general, not clearing the screen (i.e. "-X") is there so the 
> displayed contents is still visible in the terminal after exiting the
> pager.  That wouldn't be the case if the screen was cleared, making
> it 
> less usable for most users.

Well, I personally, also prefer it that way... but I'd also say that
just like in the case of `S`, this is not really needed from the git
side, but rather simply a user choice.

And since, if the output did not fit one one screen, the non-cleared
remains may likely be chopped off,... one could argue that some users
would actually prefer to have it cleared.


> Exiting if less contents than one full screen was displayed (i.e. "-
> F") 
> is there to save people from the frustration of quitting a pager that
> actually wasn't needed to be executed.

Same actually here, at least strictly speaking, ... though I (and
probably everybody else?) would really hate it, if that was removed. ^^


Anyway... that's no request from my side to change the default. I just
wanted to know whether that don't-clear-the-screen part was the
motivation for the `X`.


In case someone cares, I've asked less upstream whether there's a way
to have VTE scrolling work with -X:
https://github.com/gwsw/less/issues/445


Thanks,
Chris.
