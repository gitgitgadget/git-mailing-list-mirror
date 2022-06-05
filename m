Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C258C433EF
	for <git@archiver.kernel.org>; Sun,  5 Jun 2022 10:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiFEK4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jun 2022 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiFEKz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jun 2022 06:55:59 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C574A906
        for <git@vger.kernel.org>; Sun,  5 Jun 2022 03:55:57 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:41560)
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1nxnvI-0003eC-96; Sun, 05 Jun 2022 06:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:In-reply-to:Date:Subject:To:From:
        References; bh=tcAAVGnJPFtkmLxKliPjWyl17LGsdimy2OouLfbgrrc=; b=M5TpkSGGcZrjLY
        8LGd2Nuuc1Wy8ULgufGH0jVTgv9g3H0uqg8I96827z+Sgg43mNEUS6v6xF1eZdeGoPp9O9iM5kXhJ
        7CvvdkpO0jCujg+tkYCJfckLwtUI+QsNP/e7tMULcsGtLGO/SgXPULsCTm79L7hl/nQb+wcFZ7A97
        NRbXCUMl6ChvhgvEHEkUAM4GAd8fQaQEakyqzHUeZIeTqnJlmnuJrpqfzB+kf/W48nIyOKvxFm8zK
        nMgFOqSD7bg/NAAEPcSMtAzKnwrvsS5DD2bCwlJ9z30XUqgHuW5uyM+98V09CjrwkC7W6aiF9ZrIA
        ZKqE3G0T0h8XGKjWskew==;
Received: from auth1-smtp.messagingengine.com ([66.111.4.227]:44027)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1nxnvG-00057K-VS; Sun, 05 Jun 2022 06:55:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id DCB7327C0054;
        Sun,  5 Jun 2022 06:55:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 05 Jun 2022 06:55:53 -0400
X-ME-Sender: <xms:uYucYqLzV2UbdJJ-O6TbKudOWmOoM40_KYF5oN4DTNO4pR_BVpM9Ug>
    <xme:uYucYiJkpIis8pqTP2Oa_sTofxTXrf714QSps4BJrODLQiUlsJccYsipBsNGXS5Md
    evECkLVZJ39aw>
X-ME-Received: <xmr:uYucYquGraLfji2L2bXG9NbreZSXqbQw5aptO1uawqS2YrAYQrHTo3hN-Hk6q3rJLkDjMgs7OJpmK7UqJvUq7gnvzCkt_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefvrghsshhilhhoucfjohhrnhcuoehtshguhhesghhnuhdr
    ohhrgheqnecuggftrfgrthhtvghrnhepueegteeugeeuvdefhfeklefgueeikeeiveelff
    ekkeekudduhefhteefkedthffhnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhorhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdekieejfeekjeekgedqieefhedv
    leekqdhtshguhheppehgnhhurdhorhhgsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:uYucYvZkZ9_WCvfZSPnWXMEJjVdI03eOCyBgZ27wVBdNyk9L6lZBIA>
    <xmx:uYucYhbFxqakwFXTXWvjDaoRke3xnH_w3Fzl2u69X67q2VZfa11xlA>
    <xmx:uYucYrBK4tzLvgCl4d-TEMoQfg-Vlmre8NxoXCTlpJjaMEJVHHxhbg>
    <xmx:uYucYiCuBpPyVaqyM7SVTwyPl8BfZno6U_AscaSrGbZhRdXKxQ6DQg>
Feedback-ID: ib2b94485:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jun 2022 06:55:53 -0400 (EDT)
References: <87h750q1b9.fsf@gnu.org>
 <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
User-agent: mu4e 1.7.26; emacs 29.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git@vger.kernel.org
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
Date:   Sun, 05 Jun 2022 12:46:15 +0200
In-reply-to: <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
Message-ID: <87y1yb2xc8.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

Hi Tao,

thanks for your response.

> All this to say: I haven't understood your branch setup, but I'm
> guessing that you're regularly integrating work from "far-behind"
> branches, and most or all of your commits on master are therefore
> merges with large diffs wrt the second parent, and those large diffs
> wrt the second parent are what's "getting worse".

That's exactly correct.

> I haven't attempted to debug this, and personally have little
> incentive to do, as switching to "git log" and accepting the process
> overheads solved *my* problem.

And I'm happy to report it solves *my* problem as well.  There's a PR
for the Magit git porcelain replacing "git show" with an equivalent "git
log" incarnation which makes the 30seconds "refresh status buffer"
operation instant.

  https://github.com/magit/magit/issues/4702
  https://github.com/magit/magit/compare/km/show-to-log

Still maybe someone might want to have a look at the "git show" issue to
double-check if the performance burden in this specific case (no diff
should be generated) is warranted.  But at least I can work again with
no coffee-break long pauses, so I'm all satisfied. :-)

Thanks a lot for your insights.

Bye,
Tassilo
