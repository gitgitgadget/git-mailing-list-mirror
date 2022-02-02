Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E78AC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 16:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiBBQEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:04:53 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35951 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242154AbiBBQEs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Feb 2022 11:04:48 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CC2C65C01D3
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 11:04:47 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Wed, 02 Feb 2022 11:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; bh=W
        nRkfMNQVSjpYrXohfHbnQOmG9jBOKgaE9rK7+VAaJs=; b=cjgXRdRPJyNkbQmGq
        Ov3yU+wiXR5hTUq2y7+GDqh419rJsaWF3ZEsGmcGzVE5rtjFnXP6U/IVQ0nVaOij
        uJ07f/K+1t7VMAJqlKn6IpeLzNpWbCsQURCMfaBj17nNKjjCq5ddXSx0jPcJsfC4
        pfzViEVNW79jw63QvvZRNmOiQZq4O4l6eKf7kq4A272dEwjcCOcTs+3kDvN+PZi3
        kGh7tnewd1qcpqylOnL4QbTMw51DOtwUJOW124Ob7XeSGSE0WwBjj0QhpPz9P9f0
        nNiBUcCjFouiq7IylXShwFOLnaRKrahFfO0/+y7nhiIh0AXqepz1SKLllLn7qsbF
        wxCKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=WnRkfMNQVSjpYrXohfHbnQOmG9jBOKgaE9rK7+VAa
        Js=; b=k3y6OOsLGpXXFFocUx8h0TmwGmL1mu82WrZAs+eKk4AoXJfwJppeIiaD3
        nIbaODi9zoQhJ6+xJs+RW+FCJEBDIS4NJpMEHXPo3/KNnYQOFbwdOBr2jF+fmYkt
        UnIjw+5F5Q6aQ/8oGcd3xj4amNHXqQYOOb9aX4LnoGJvuVlC2xj0A+/dKPoDWzcV
        /ym4DahpIX6/tb7aNy42yYo9WYHAfFy0jrDS1sKnzprMj7i3XjMAffABPdnrQsBp
        BAfy/d0OzeuXq3WpVFfCM6WSeaOhRjF815TsZevEUQBf/WWRp1o5TeceN0c/cEXY
        7Hv2J3OeMpS1eIVHjjunQMShN/CKg==
X-ME-Sender: <xms:n6v6Ybc4yZeY5k9lCs5qmsfU4J6-W8CRH-godXuLdpgfQ1f0pljt5g>
    <xme:n6v6YRIRy8xFpfyVr3B4scpVI-o9xZna3ou9RubKHQu71AP1c8bSFl2jkb5EWslju
    oxuCqFOW2OK0Thw-hU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
    ertdenucfhrhhomhepfdfirhgvghcujfhurhhrvghllhdfuceoghhrvghgsehhuhhrrhgv
    lhhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeigeffhfeivdduvddtvdeuleehvdettd
    eiudejieektdffudetudekjeelieffhfenucffohhmrghinhepphgrthhhrdhinhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheshh
    hurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:n6v6YRZmiZ3B7UwCi3ezpGvMqJ-YfAdlZihgetXjgfMtxdzBZe76Gw>
    <xmx:n6v6YUsoK3ftwvo4aXM6fLujI5k2HxzV5CQgbyOuWIxdLt9waJu1iw>
    <xmx:n6v6YWuTtsEHcauqGMFKQAVJDTv1Eh-vez75DkjC1LuLyl1VNHyWBw>
    <xmx:n6v6YZjvfrYPFrklkwj8XPHuL_9NVD4BfVIxgBeCjs-ylLRqnDMc4g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8F76F1EE043B; Wed,  2 Feb 2022 11:04:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4585-ga9d9773056-fm-20220113.001-ga9d97730
Mime-Version: 1.0
Message-Id: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
Date:   Wed, 02 Feb 2022 17:04:26 +0100
From:   "Greg Hurrell" <greg@hurrell.net>
To:     git@vger.kernel.org
Subject: git-checkout doesn't seem to respect config from include.path
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Not sure if this is confined specifically to `git-checkout`, but that's
the command I noticed the issue with:

With the release of the v2.35.0 and the "zdiff3" setting for
"merge.conflictStyle", I find myself wanting to use "zdiff3" on machines
running the new version, and falling back to "diff3" on machines with an
older version.

To this end, I have a ~/.gitconfig that contains:

    [merge]
    	conflictStyle = zdiff3
    [include]
    	path = ~/.gitconfig.local

The idea is that I can use the same `~/.gitconfig` on every machine I
use, but on machines that only have an older Git version, I drop in a
~/.gitconfig.local with overrides like this:

    [merge]
    	conflictStyle = diff3

`git config --get merge.conflictStyle` correctly reports that my setting is
"diff3" on such machines, and `git config --get-all merge.conflictStyle`
shows:

    diff3
    zdiff3

In other words, it knows that I have multiple values set, but it uses
a last-one-wins policy.

However, when I try to run a command like `git checkout -b something`,
Git dies with:

    fatal: unknown style 'zdiff3' given for 'merge.conflictstyle'

So, it looks like something in `git-checkout`'s option processing is
causing it to disregard the override set via "include.path". In fact, it
even disregards a value passed in with `-c` like this:

    git -c merge.conflictStyle=diff3 checkout -b something

Does this sound like a bug, or are my expectations off? I'd be happy to
look into fixing this, but first would like to know whether it is
expected behavior.

Cheers,
Greg
