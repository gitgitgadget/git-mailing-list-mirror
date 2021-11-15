Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC036C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 09:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD29615E1
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 09:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKOJzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:55:48 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42755 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230492AbhKOJzl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Nov 2021 04:55:41 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C7CF5C00FD
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 04:52:46 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute4.internal (MEProxy); Mon, 15 Nov 2021 04:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dbrgn.ch; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm3; bh=klFrxtDnegjt0xMCBueAkgrJlrkdvfwt2IGoLV1q3W0=; b=wG85dbCc
        wPTKpU+82hreNT5IPPwSblQjrRBWfKBxG4Xg1cDhT5yd/P953cCRnhEk6Y5jmPqz
        aiKQnZY4lnsMZNDRMI48Tp2qlLMyfZsSEOoU5q50fnKmfCLiqjcHlcgkc6fne75i
        HbCN7+Qq3qy7+WcLjUYXuNqaw9CfeKmBT3/2omTjI5l5bndUpCAN4C/N/IT6iC/f
        tuL+WlFoKFx7gYJMwCZfXUSHEXeEBw8+LlwXzutNsH5ooBwrq5WVxbjTyINn3LeZ
        vEI9ZIQxpZ8l6Rrla5vp4k6EM+AX3eJzmHA9Z1H4qn/vO62ixAs5xU+oh3hqNhBV
        36Nij4I/Y7t3KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=klFrxtDnegjt0xMCBueAkgrJlrkdv
        fwt2IGoLV1q3W0=; b=g5ZAbIfgpuPr5tNLU4axUjW1GkIQ7r4pAioKQyHcUfTZJ
        IXAd/L4SWvDqsfLba1wrYkJnGfJrEDNUh18QHBwuf1LVNjxgnp9SBT34kI1C6/wN
        hbZ880Ivr1a0d8T/56oc/dVoRHiXDB6kwodUY1/KQcX+C4cFwjpiW3B1f08bg0Zi
        nqwN+AY4U2XlDVNROICyFcoZoSh7Eqr/+X1wciPdF7JKmeFZ1+trxIpS1p9hNJJF
        L/yMa5un3xss2eWClTsx2I3KG70PPOT/jvq9DjCKk0P2gpukcCwB8EG8Ow+aRMED
        lUR8Ucl9NkQym0G2pgVKj8/upsOKdJPQPXY4bijgg==
X-ME-Sender: <xms:7i2SYWmfiJeP1Z-68bd9tOZBVoFjPX-1YKbn8RjQryTRUTsDRVgAyg>
    <xme:7i2SYd1RJo-9OW7KtTgRYBBBzJXA7EMi7xJ71odRaekV4nOn6Gskzp9zNS1Hghjan
    CkBjzSD574i_aek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdelgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
    ertdenucfhrhhomhepffgrnhhilhhouceomhgrihhlsegusghrghhnrdgthheqnecuggft
    rfgrthhtvghrnheptddtkeduffeiveefgfeuhffgheeivdffjefgveffjefhtdekgfeive
    dujedthfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrihhlsegusghrghhnrdgthh
X-ME-Proxy: <xmx:7i2SYUrB-XU2EIo0yL9vqUaxo6m2EbTr5zXS4IxeSlWU0jpnZfpcUw>
    <xmx:7i2SYak0G0ALfG724fOGRU5FsFUUYbsRNMoz_ms999m0zKGB4bGeyA>
    <xmx:7i2SYU0G9RIRx7ppyBHATEArH4p3znl4gN2reQ1F0uydQDAtFLMwqg>
    <xmx:7i2SYZ_9PWKUuZqT85kafAWw4ySEau0052OX1fmyzbXP0xQFqsZMqQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 404B421E006E; Mon, 15 Nov 2021 04:52:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <30999b1a-70b3-4489-b751-024c26bbbd11@www.fastmail.com>
Date:   Mon, 15 Nov 2021 10:52:24 +0100
From:   Danilo <mail@dbrgn.ch>
To:     git@vger.kernel.org
Subject: SSH Key Signatures: Feedback
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, and thanks for your work to support signing git commits/tags with SSH keys!

I tries this feature with git version 2.34.0-rc2. Here's some feedback from my first use:

- To find out how this feature is used, I used "man git commit" and searched for "ssh". However, no result showed up. Maybe the manpage could be expanded to include a mention of other signing methods in the documentation for the "-S" command? For example, something like this:

    2,4c2,5
    <            GPG-sign commits. The keyid argument is optional and defaults to the
    <            committer identity; if specified, it must be stuck to the option without a
    <            space.  --no-gpg-sign is useful to countermand both commit.gpgSign
    ---
    >            Sign commits with GPG or another method like SSH (see `gpg.format` config).
    >            The keyid argument is optional and defaults to the committer identity; if
    >            specified, it must be stuck to the option without a space.
    >            --no-gpg-sign is useful to countermand both commit.gpgSign

- When I tried to sign a commit with my SSH key, I got this error message:

    $ git commit -S -m "Release v${VERSION}"
    error: Load key "/tmp/.git_signing_key_tmpvhKT9L": invalid format?
    
    fatal: failed to write commit object

This message was very confusing to me, because the SSH key format in "user.signingkey" was correct. In the end it turns out that I had loaded a few SSH keys into the key agent, but not this one. Could this situation be detected, to show a message like "No private key available for signing key X"?

- If `gpg.ssh.allowedSignersFile` is not set, `git log --show-signature` will show a "No signature" error message next to the commit. However, this isn't true, there is a signature but it cannot be verified. Maybe the error message should be updated to reflect this?

- If `gpg.ssh.allowedSignersFile` is set to an empty file, the error message in `git log --show-signature` includes "sig_find_principals: sshsig_find_principal: unexpected internal error^M". First of all, the message seems to include a stray "^M", and it could be updated to show the same output as when the file contains signers, but none of them matches ("No principal matched").

That's it from me, I hope this feedback can be useful!
Danilo
