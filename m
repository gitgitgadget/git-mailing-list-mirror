Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6182ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 13:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbiIEN36 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 5 Sep 2022 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiIEN3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 09:29:55 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4DDF5B6
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 06:29:52 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0028E8C17EA;
        Mon,  5 Sep 2022 13:22:22 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id EA3908C0D20;
        Mon,  5 Sep 2022 13:22:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662384141; a=rsa-sha256;
        cv=none;
        b=Sda5s+GR2Y2A19h/ABjiaB94faN/UPdFeVCNt7V/xHywhYiXyF/AhlGLvJ+PM+bMqA1R9G
        yN09+c0bPRitXdmotNyhQtDLFbqpde6vYa8ZBRFH7fVdYCK+MY+cgYwec1nv6PQdRkjtVs
        2WyPiggeyWDdYwRBq2eEn4NVtKVxtLHFYegEuCFHuukYdVgzmCCE0q4yCbI1MDbgxCyyQG
        v/Jgo2V7vYzhooyoKIQW3oWxz5zTxqFBrg4Idf1neTx5nLTTfNuCN64Uvwzin6Iq+8QKX6
        22TltMjStHC1r6cCNwfEczrkn63Pca9XK6bXMs3X6/AjEreI5ArLQ4sUJChalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662384141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbFy014nDTk/BNh/Q+EUlp93TLKmR1XnGegvCZ7v3vU=;
        b=GT6U0AHQxIz9Qn3V9E2rzh8f69b0i53O6DrIVPMDfUaAnaRVuKHV4Srg68rvt6qMIIBeo/
        zd2wFpy/+EFivNX5xv5Oa/tXVnGM9S771qEAVDkZnXxEFky81sac5AkylAk7c32oTsX95q
        Twcf5fhMrM4yJ28DiuMh00HC833pCHRqWOZcyJexizFffvVewhJj25W0/D2plFcw2UASe6
        0l1AMWF2Dk63J66hUXVrhKMPDr+J8mGfRP2Vy/VTvc9xYb2VoPUlHLwgqXJRhWsLNy/Oyg
        LrrfqTeUOlnlZq4YTFhjLl/fIEZBpWgE66KQC1uKq5OmTQ1fQNhXptqW3Mc8AA==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-dcrf6;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Tank-Eight: 58eac0597b69bed4_1662384141605_2323026220
X-MC-Loop-Signature: 1662384141605:2207319635
X-MC-Ingress-Time: 1662384141605
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.147.32 (trex/6.7.1);
        Mon, 05 Sep 2022 13:22:21 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:33902 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oVC3M-0005zy-E6;
        Mon, 05 Sep 2022 13:22:19 +0000
Message-ID: <c209dc21f6826bbb60d75450e6f7f9ff2258d18c.camel@scientia.org>
Subject: Re: status on security of embedded repos?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Date:   Mon, 05 Sep 2022 15:22:14 +0200
In-Reply-To: <6sq30r84-1s65-91n4-5qoq-23s9q433sno1@tzk.qr>
References: <4e9ad5486e8a887f1e92cc4e401ca61be5f2bb9a.camel@scientia.org>
         <6sq30r84-1s65-91n4-5qoq-23s9q433sno1@tzk.qr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Johannes.

Thanks.

Is it known whether this will automatically prevent the issue also for
any 3rd party modules for git?
I mean is special action needed by them to consider the option? Or is
it likely that there are some which manually discover the git config
and could thereby still suffer from the vulnerability.


I assume the same wouldn't be possible for non-bare embedded repos? I
tried to try this, but when git add(ing) such repo, it already warns
that the embedded (non-bare) repo would not be included in clones.



On Mon, 2022-09-05 at 12:21 +0200, Johannes Schindelin wrote:
> Note: The default will still be at `safe.bareRepository = all`.

That seems like a not so secure default, given that probably only few
people will ever encounter embedded bare repos.

OTOH, the attack surface seems rather big, if one just needs to clone
some arbitrary repo where one wants to look at some code, and is then
in principle already fully vulnerable?!


Thanks,
Chris.
