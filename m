Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7D9C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiIGOFs convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 7 Sep 2022 10:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIGOFq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:05:46 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7BA2E683
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:05:44 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 382AD2A2524;
        Wed,  7 Sep 2022 14:05:42 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 121092A278C;
        Wed,  7 Sep 2022 14:05:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662559541; a=rsa-sha256;
        cv=none;
        b=CMR8iMudRk0eds6zq0WFMpKKsM9D4b7skKV4sMMb7MqH729aeuT/jc2TDUwUHmps2Iznrj
        7TIz2ocHenYN1gkV0ETJP5+7KrKBjRGLilC4DTbsE9jXDsFKC7y6SP8ajmnvZWpV7BDkAl
        Uqd+NqBpohGacJ5u084qfh9ajbECOt9Hn+rIJ0cHDsoRvVf3o5dMtN7ZnQsJcRm3AVFscn
        9IQZgXIUH8jOrlykBzETv21PaVNqe5onkWuu+FDfqrP1CRwuq/NS4FPfvCK9FuvYXq7rpd
        JzYzuLHIm1Of38bxWeoq+0us+emLIqT3iNtrZl3UUg3Opf3dAnZ5fTeOr/0hAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662559541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyvgNuF+QOl/Js+ewvdbiDox5P7rMh72aJV1DIJ1fyY=;
        b=rPHm6NWqEQWHjMADq55ncFc9m2TigEHEcyMKEb9dEMp5I8g4sk7Na/uvGY5pKV9FAmiR0U
        SJFwwJKFcvy+BsmIN5rY0ja4ikmXgeuDR0yvuNBUN17Pvu7mp99eahGiSpHHzb3Y+tcea4
        Xd0QI4Wvsl0KFxDvjmeMjD9V59T7MTFmHfK5WypoSIumsEewQp7afq4cQk1yil4aFsI2z1
        VMEAnRZnC6SX/tH5al39OTvG/K7d7mAzhAC9jpA7kNJukYzPER3NcGJTeNxcuCVaUJdsc1
        MOHUMY1xcVSO4qzTDEPpBn/wftd0fqDVHK2zgg9SD22NpCDcOE9KXSXWw9AJzw==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-gnv52;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Belong-Attack: 794c36d3413b817a_1662559541796_2314183292
X-MC-Loop-Signature: 1662559541796:825400994
X-MC-Ingress-Time: 1662559541795
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.124.238.66 (trex/6.7.1);
        Wed, 07 Sep 2022 14:05:41 +0000
Received: from p54b6d828.dip0.t-ipconnect.de ([84.182.216.40]:43222 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oVvgN-00030j-9U;
        Wed, 07 Sep 2022 14:05:39 +0000
Message-ID: <aeb235f7a914539ad50eff96479106f8c8ec8d48.camel@scientia.org>
Subject: Re: status on security of embedded repos?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Date:   Wed, 07 Sep 2022 16:05:33 +0200
In-Reply-To: <4697o162-0pop-4715-150r-2317p0n69581@tzk.qr>
References: <4e9ad5486e8a887f1e92cc4e401ca61be5f2bb9a.camel@scientia.org>
          <6sq30r84-1s65-91n4-5qoq-23s9q433sno1@tzk.qr>
         <c209dc21f6826bbb60d75450e6f7f9ff2258d18c.camel@scientia.org>
         <4697o162-0pop-4715-150r-2317p0n69581@tzk.qr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.45.3-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Johannes.


On Tue, 2022-09-06 at 15:56 +0200, Johannes Schindelin wrote:
> But libgit2 and JGit, two separate Git implementations that are in
> wide
> use, too, probably do not have support for this.
> 
> In other words, users of libgit2 & JGit will likely be unaffected by
> setting `safe.bareRepository` and sill still need to take manual
> precautions.


> If you are using applications based on those projects, you might be
> interested in porting support for `safe.bareRepository` to those
> projects
> and contribute the enhancement.

Well I'm not really in any way experienced with git's code ... so I'm
rather just wearing a user hat.

Wouldn't it make sense if someone really experienced within git
development to kinda follow that up for other projects, too?
Sure, it's other projects,... but still, the vulnerability seems rather
critical and many people using git also use such things like libgit2
(potentially even without knowing).

I can however open a ticket over at libgit2, if that helps you.

Also, even with default settings, git, AFAIU, would be still vulnerable
for the majority of people (many of whom likely haven't even heard
about the issue).


> 
> Yes, indeed, `.git` entries in Git's tree objects are forbidden.

And I blindly assume that this is not only checked and forbidden when
trying to commit, but also when cloning/fetching/etc.?!


Thanks for your answers :-)
Chris.
