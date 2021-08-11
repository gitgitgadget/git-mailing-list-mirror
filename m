Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A03C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC1160EB9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhHKWLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 18:11:21 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36133 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232226AbhHKWLU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Aug 2021 18:11:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 3C1D0320091C;
        Wed, 11 Aug 2021 18:10:56 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute2.internal (MEProxy); Wed, 11 Aug 2021 18:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawned.biz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=cLmM2iqb8KaHZCuoJ5jHnUKyKh4UpkP
        3T2URfMq5r2U=; b=B0PHJz/n5UcITM+ZDoTN0x0TPnfiMOkdhZ215K3KKlEsplL
        HQ3kqB9Atkid+rdMVhTDNUAtXkDqUrlQo/ogz6RRNUhEfavQkKvkvzIel/PJNUZ9
        nSEFm0ok/IeolcCdJQUZPwNATwvkY3teeAXYZVjrI5z0xrcv8337UjMGUBoqjWg8
        9e/VTKxOe5QySnwQ0TL/9RzcaN9xBhOmYq+MIXCfRNiwTS2pK0BflHojbXkwUaQu
        QLdrTHAiIS20wSloJBRzjHzIBF6UBiByGrMBIPvcYmkn8ffztjpkXmg5LlvfLhmS
        uINnfrf9rjSDl+uDjhTOXIqzSCtH6OffXPKRDJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cLmM2i
        qb8KaHZCuoJ5jHnUKyKh4UpkP3T2URfMq5r2U=; b=pXrP6F0xgHdts6jUwX8Kmj
        1QB56TND+Zcu6wkgGNyzWtScnKAWsCDVGCqf4bGrERq6Dx/BdBgOqGHlTszuyQpj
        Xy67pBV4bE6/wbJchH8omOUR46AIQs5C6zBbFBiVwVaT9G538Wya+JqXD77Kb70z
        4ZXCsP4j4K6K8OReeWXBog8QcH452wiMv7qcujopugUKb9ckSWIYD3w2VMF6XSam
        5Yxwbhazriyr8Ogb21BXvQUmey/BP+pXDHDAT+Lq/zHS1p4Q4BXrQL3WFkRgGwe2
        KnNedNnAFflGeALaksQKS2B9FzlPxaZywxcorVGr1dWmFRUrRJULahju9AW/cj5w
        ==
X-ME-Sender: <xms:70oUYRsSi6alMkMb8-rcbND7SzyMtFFo3G0Pz3fZYaWO9V3NNguPcw>
    <xme:70oUYacTVT4X7bemlpm9iNzeu0rvHEmN9x5xD3hemiIYODaqHdoo9raDmNIcggM47
    Oyz-Y5n54ZGahTfTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedflfhovghl
    ucfmlhhinhhghhgvugdfuceothhhvggpjhhksehsphgrfihnvggurdgsihiiqeenucggtf
    frrghtthgvrhhnpedtkefgudekudejieejgfehleekkefguddvuefgudelfeefffdtveeu
    ueehhfeifeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthhgvpghjkhesshhprgifnhgvugdrsghiii
X-ME-Proxy: <xmx:70oUYUzANeHNDuDt1wagmdNGW_iVKFL-FI-U1-am5avlMNDviE2OgQ>
    <xmx:70oUYYOUmqFxIcqlav2pnsIaFfaBNIlrS58-B5T0LIY_ur5SqHPIQA>
    <xmx:70oUYR-yRm_UeMo_BJsbai3Ik8hT98H3TzpLBnum6LVEcQ_TjLZ1sQ>
    <xmx:70oUYeEappF9cEk11W6ofJfxmSQRFmQWrMn8Y3RK_FsgY4ZTFEhGRw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8D677A03D5D; Wed, 11 Aug 2021 18:10:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <127626db-302e-426c-a158-35f46205e1d6@www.fastmail.com>
In-Reply-To: <YRQx/jXdydxMGBmS@coredump.intra.peff.net>
References: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
 <YRQx/jXdydxMGBmS@coredump.intra.peff.net>
Date:   Thu, 12 Aug 2021 00:10:28 +0200
From:   "Joel Klinghed" <the_jk@spawned.biz>
To:     "Jeff King" <peff@peff.net>,
        "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: restore --edit when combined with --fixup
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Wed, Aug 11, 2021, at 22:24, Jeff King wrote:
> On Wed, Aug 11, 2021 at 01:49:18PM +0000, Joel Klinghed via GitGitGadget wrote:
> 
> > From: Joel Klinghed <the_jk@spawned.biz>
> > 
> > Recent changes to --fixup, adding amend suboption, caused the
> > --edit flag to be ignored as use_editor was always set to zero.
> > 
> > Restore edit_flag having higher priority than fixup_message when
> > deciding the value of use_editor by only changing the default
> > if edit_flag is not set.
> 
> This is definitely a change in behavior due to 494d314a05 (commit: add
> amend suboption to --fixup to create amend! commit, 2021-03-15). That
> was in v2.32.0, so it's not a regression in the upcoming v2.33 which
> needs to be handled in the next few days.
> 
> My inclination is to call it a regression and restore the original
> behavior. But when I was going to suggest that you add a test, it made
> me wonder: what would we be testing for?
> 
> If the user says "git commit --fixup HEAD --edit", it seems reasonable
> for them to expect that the editor is run, and that is easy to check.
> But what are they planning to edit? If they modify the subject line of
> the commit, it will wreck the "fixup!" mechanism. If they modify the
> body (which starts blank), it's going to be discarded by the fixup
> operation.
> 
> Is the goal that they might leave notes for themselves, which they can
> view in the meantime before they run "rebase --autosquash"?
> 

At my work we use "fixup!" when pushing fixes to a review, using
the modified body to outline what issue the commit is addressing,
helping the reviewers to see intent and not just the end result.
All "fixup!" are then ofc. squashed before integration.
Same can be achieved with -m but --edit is generally
easier to work with in my experience.

I've also once or twice used it to avoid a "fixup!" of a "fixup!" instead
of looking up the original target commit hash but that's just me being
lazy.

I'll add a test to check for previous behavior.

/JK
