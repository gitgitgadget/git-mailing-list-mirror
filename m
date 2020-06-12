Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BB6C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 01:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD28206DC
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 01:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linuxprogrammer.org header.i=@linuxprogrammer.org header.b="nvG8A6ko";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDblNSem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFLBz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 21:55:59 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54191 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgFLBz7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jun 2020 21:55:59 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8A8A57EA
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 21:55:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 11 Jun 2020 21:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm3; bh=KTU
        JMKj+qQ/wP+wg3bEcWl8zQxwynBmZ2TJ0QUPaaAM=; b=nvG8A6kotnqFm5tCpOY
        IaDPTaE4hligy7pyVjwFGZ6BgGzV+satbALxny9jpWchGT/OCMzTdSp4cVigOfIy
        uzA6UdxSL9/NAMnV9bzdQBU/FZ6kVVnW5jrivpIRvLUpsNARkxy368t/sqBci0VA
        GhpZ7LCwtV2DWJ+DXpKF8yMD9K0MGiRdaGuATRXEurowcdYDhGNGEc4cFORntoUk
        og7GxW1tU7iEkUb+dz11aZ64v+tF5dS2BWOJbYioi3tdaMt18JwXyYbTb1rzZWLy
        aqd0Xg5JfZ8ex7MgB6xpb8en08EFQNtgqx+iSc1JM3tZiSbNewwoSvl2X1Nken63
        WCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KTUJMK
        j+qQ/wP+wg3bEcWl8zQxwynBmZ2TJ0QUPaaAM=; b=CDblNSemSnEZuy1iYrH7ZP
        uUkq8llty+QBMAe9a5OAv7X4NiIZ47NTkmnz4VAcEzSGwB33xsaYOKOe1xQFV1h3
        0Hh+PGjWpGKqTCy+2jg5KUV1gVwTLTdusefgnBhBkKKgqPapkgSV+cdXHVI9ygBQ
        Pq7AYWcbZzGBBT42k4DDIv6u/aRsedcQmIjALCWu9S1LqpZYHZsYiZMmqTEW3T7Q
        CRG5igC2BBM1YVMz+BdvrV1KRleltRPxIukfi6QTGMTAQYs6KlcX25QS8J87xKQg
        UIDzj6sGlZeb64WlAhz+pLIKJVxzOtvuUO0YNsoK1Cw1xvHEHzelt2qnbOFStUxA
        ==
X-ME-Sender: <xms:reDiXlPLnOgmd6wJ-TCwxqAtmGN1gxdMJimlgStDN9OM7A3gAg52sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtreejnecuhfhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
    necuggftrfgrthhtvghrnhepveeuudejgfdufeeiudelvefgheehfeffffdujeetlefgvd
    ekkeejkeeujedtffevnecuffhomhgrihhnpehpuhgslhhitgdqihhnsghogidrohhrghen
    ucfkphepieekrddvvdegrdeikedrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:reDiXn9A6ZtRZRw0ksBoB2D__Ube3BUeeVIt-YIA26FNfdeCWL9EvQ>
    <xmx:reDiXkTotoAILtO-x0rd-H1EaqrOW9LsADRsJ8vO3F63E1G6NnAqtA>
    <xmx:reDiXhtpIX4gnLcj0B5sUpUlYw7ycJpbxOQDlk5Qqto4i0ocoJYxrg>
    <xmx:ruDiXp_AdGfzAEpIX2GQ611CVAVRK6UhJUMpC9vPqbOq-gMcS1isdA>
Received: from localhost (ip68-224-68-5.lv.lv.cox.net [68.224.68.5])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E3F33280059
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 21:55:57 -0400 (EDT)
Date:   Thu, 11 Jun 2020 18:55:56 -0700
From:   dwh@linuxprogrammer.org
To:     git@vger.kernel.org
Subject: Re: GPG Commit Signing Project
Message-ID: <20200612015556.4kvsfcwabuaxuiuc@dev>
Mail-Followup-To: git@vger.kernel.org
References: <E7E8DC8B-BB7D-42E1-BD0E-EF59775B9E75@rams.colostate.edu>
 <xmqq1rmmg1ds.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq1rmmg1ds.fsf@gitster.c.googlers.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.06.2020 12:35, Junio C Hamano wrote:
>The fact that I know almost nothing about "Hyperledger Git Commit
>Signing Project" (other than the search term returns some hits from
>the search engines [*1*]) makes me suspect that whatever branch I
>control is not suitable to contribute to that project, which does
>not have much to do with the Git project, where this mailing list is
>its home for.  Perhaps ask your mentor first?

Hello Junio,

I thought I should jump in here and introduce myself and give Jimit
a little help. My name is Dave Huseby and I'm Jimit's mentor. I'm also
the Security Maven for the Hyperledger Project. Jimit was selected for
our Summer 2020 mentorship project to work on our ongoing efforts to
support alternative signing tools in Git. Last summer a series of
patches were submitted by Ibrahim and it was not accepted, although
we did get some good feedback.

The feedback from the Git community was that the refactor of the
signing system organized the signing-tool-specific C code into
"drivers" for each signing tool instead of being configuration based.
See Brian's comment here:

https://public-inbox.org/git/20190826231543.GD11334@genre.crustytoothpaste.net/

Ibrahim's mentorship ended with him sending a new proposal for a config
based approach to solve this problem here:

https://public-inbox.org/git/R3X1WzWH0sgOh85GuUmXwsTC6CPKysi4TRzN_BPecDVGr__ET2-mitZ2DZA0_bpKkzLRtnTtoomIWxZtL52_1XkihYBVBAuWMpSdwoboixY=@pm.me/T/#u

I now think even that proposal is overly complicated. I think the
easiest solution is to simply standardize the existing pipe-fork
interface as the way GPG talks to all signing tools. For signing tools
that have different command line interfaces than GPG, we can create
adapter scripts. Tools that want to be compatible can adapt.

I'll outline a new proposal in a follow up email.

Cheers!
Dave
