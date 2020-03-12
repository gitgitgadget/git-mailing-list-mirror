Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11BCC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 03:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7F6206E2
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 03:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="GyljSKA/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcwPOoWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbgCLD6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 23:58:12 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44755 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387453AbgCLD6L (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Mar 2020 23:58:11 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A360A22199
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 23:58:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 11 Mar 2020 23:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=HPp43kOc8Yj7VOzFQWQ/7a1q5+X7yPbB2oobjzntCzE=; b=GyljSKA/9ofa
        KXx5UMMxJd0APau2xAxJ9wpyLBAP6W/mEmXDug/ZqcIO9wGM01YSma/91I18k9Hu
        CWOYPRD8QynYzcUw/q++4xSD8pMLzNLi2Br6fHsOz5pv8JUmPfeLHBt6GbcS4mDy
        EIbqwofjNk4g1nzuvKDLJhPfDFK7dBo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=HPp43kOc8Yj7VOzFQWQ/7a1q5+X7yPbB2oobjzntC
        zE=; b=UcwPOoWqA9h8CsdnixDPKe2NGqOsRN/478ZSp0OOPdC+b+zbcxj7kvfxA
        auh2JAnzSwOFYyCViXTWCPCoqcuWTr5lxPRvUkz1alJWcRZ7CbjWdR3uhoeQZowZ
        avyaZprRNhlUmAB9+S1qpdCzQ3hzQCO45Wm3ibBm4N5nmLF4XYudZIMUCyDwSbJY
        Yudjgd09fDP5bTUG0xa0Nxy3ruma5SFFXOyWKI9ew1ocGMfctG3JXGAvBZKJ/npH
        K08YYi7BnHqJosliE8k4f/bfBSwzx/3RvQq7dGMpT0c5dsJ/t2URxNX2eijHTNXo
        Ve8UPY3OrTNjDDE1ichPNyWjW3fYw==
X-ME-Sender: <xms:UrNpXvi32T-C7MGHHYI2--yG6Nke-KrjCJp0F6X3zQHxkhtJtumaVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:UrNpXthOPfmj2J_P22Z6bz4nAEwovHNsifmyE6vBQ73-u-XUkqS-Qw>
    <xmx:UrNpXvJeJmg1oi6S7oXufmIWMh_GSGwoha7k7x25_9arzRGtklq5pA>
    <xmx:UrNpXsEyuDiTGpMkKXU-Sle9uO03HSOXKKVU0wjmLHUsdeVGaYoBqw>
    <xmx:UrNpXp88MiXqiiwqbzFhzr55EG8fmp0rLuBSWE7Yi3mohz61sRgvdQ>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id CBD2D328005D
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 23:58:09 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 4/17] Sparse checkout
Date:   Thu, 12 Mar 2020 14:58:06 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <577F08D9-719A-4C66-B135-DC62E68AC941@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Stolee: built in! We’re making improvements! We’re looking at UX 
- add, remove, state. Harder things like grep needs everything, but not 
expected.

2. Elijah: we do have a strongly worded warning, so we could just change 
it.

3. Jonathan N: I like both modes.

4. Terry: how is GC wired up? If I change a cone, will it be reclaimed?

5. Stolee: GC doesn’t remove reachable objects. Haven’t found people 
need to do this, unless they accidentally rehydrated something massive 
they didn’t really need. Day to day work doesn’t introduce too much.

6. Terry: Android devs have massive special machines. Constantly running 
out of disk space.

7. Stolee: more of a partial clone feature, than a sparse checkout 
feature. If I checkout three branches, go offline, I don’t want GC to 
clean things that I had downloaded.

8. Jonathan N: switching between Word and Powerpoint. Would it be useful 
to attach cone to branch rather than repo.

9. Stolee: Office team is building some kind of magic to automatically 
detect from branch.

10. Brian: can use reflog maybe. Prune based on that? People who run out 
of disk space could have shorter reflog.

11. Elijah: biggest problem people run into doing a rebase/pull, hit 
conflicts, then they need to update sparsity patterns, which they 
can’t do because there are conflicts. Working on a patch.

12. Stolee: Office scoper tool would automatically recalculate 
dependencies and update sparsity config so that they can build.

13. During break, Minh brought up an idea that we could use in-tree data 
to manage the dependency chain: The tree could contain files that 
contain directory names, and users use config to specify the list of 
those files to use for the sparse-checkout definition. When Git updates 
the working directory and those files change, the sparse-checkout can be 
updated to include the union of those directories. Stolee will look into 
how this could work and whether this works for existing customers.
