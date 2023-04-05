Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614E7C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 18:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjDES3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDES3U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 14:29:20 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE3D10E6
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 11:29:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EE8C55C020E;
        Wed,  5 Apr 2023 14:29:15 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 05 Apr 2023 14:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680719355; x=
        1680805755; bh=kMrjdSnV5o4fxPBkhkHRVyUdY4iCqz3O6vlxK+Cg+Js=; b=K
        biMg9Pwr9i4OszzL0p/k8i6kuZptRwlcVa2Gi8Gy4ChzbI90m7r+apClcUjsiQKq
        D58xi0Bt+h43lk2GKm0LSPAKXJBSJV9QuYGjztDRK04D1ptXMofjZqM7g2rvH3lB
        o1P/5LS1mi3d66uU/FBv2L0vlOYNR03BB5oZFibWbcz//TDIY4Y7xQA89e2Ve+pB
        lcYzE23uRmWCsTSweQkmck2odziQ2kdwkiZCxuv6fTBtHSZdr+VK+eol7ETs7oQT
        4/JTxx5aKGtdoXr3OhJMiyPx5AsR0nge/M6ya1EKvMJsnrxVVH2M6alNJdhZnj3B
        DP+WfOe+c0AAQs9oljdrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680719355; x=1680805755; bh=kMrjdSnV5o4fx
        PBkhkHRVyUdY4iCqz3O6vlxK+Cg+Js=; b=LWyylcvWVjm4FiG8j41b/IgNWIfd6
        zTZvpbP/BKmsoxzljoUPpAxdfwf7j8GjFOTa80KY76JWV4bCxE69apqTgGHNRUYM
        Ou7NrWJHvCHXFmT2lu9O48mS5st33sRV/ah02uICUvvTT0KFvdiKq7fk3M7c+wl8
        MXOEFgRDyyy3x/LddRC5cNwQjk50trcBR5zvMn5FLewh+JqoeGDin4tyl07L8uqR
        scQgbHm/Dm1whskMnHzwmBfa1hAo6CgKXSuTSuUPy8pdAEtieoYYJ3NuVUboWfy+
        fowMgSboFMpz8Xcx+HQHh7wpxHxEqKKsWmAOoquimYpjB0sy8brL+ZxNg==
X-ME-Sender: <xms:-70tZNNsFdXk1d8Vswd0uWEXqJ9dJ4k6wI4IXg_wC7W5THPYBreANZ8>
    <xme:-70tZP8DX46T2EKH6CAyGH9fNScSeaakKKpKYYdKqfkNyMdLlHWX-1yr0ntxG7Qm3
    xC8S81AsE-Oq2MrWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:-70tZMQlgMTF4vD2CsQqZbIgw6oKZA752PbsxhA3IpEXTu0syu3hnA>
    <xmx:-70tZJuYEdrS8GdQxrqWHSmr6VIyC8xR7hnhymJXbyPs0GMlc6w3ig>
    <xmx:-70tZFcAwf1YNEi7AEG4SL6DgKvIQeFfL94F3fkv1omwVpzJWPkcGg>
    <xmx:-70tZLoXWsJyCstu8e1mfeUyMNdDwAB_iALwsvqFmaQv7vnYBrkwZg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C2A9415A009E; Wed,  5 Apr 2023 14:29:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <733d4a0a-d544-4e25-80af-45d9551ab034@app.fastmail.com>
In-Reply-To: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
Date:   Wed, 05 Apr 2023 20:28:36 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Patrick Steinhardt" <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023, at 12:10, Patrick Steinhardt wrote:
> The majority of Perl scripts we carry in Git have a `#!/usr/bin/perl`
> shebang. This is not a portable location for the Perl interpreter and
> may thus break on some systems that have the interpreter installed in a
> different location. One such example is NixOS, where the only executable
> installed in `/usr/bin` is env(1).
>
> Convert the shebangs to resolve the location of the Perl interpreter via
> env(1) to make these scripts more portable. While the location of env(1)
> is not guaranteed by any standard either, in practice all distributions
> including NixOS have it available at `/usr/bin/env`. We're also already
> using this idiom in a small set of other scripts, and until now nobody
> complained about them.

This is great. I love to see efforts towards portability, and
particularly when it benefits NixOS (as well).

-- 
Kristoffer Haugsbakk
