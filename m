Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CF6ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 18:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIIScf convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 9 Sep 2022 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiIIScd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 14:32:33 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA02C124609
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 11:32:31 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7E0A96C316D;
        Fri,  9 Sep 2022 18:26:59 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 581616C36F4;
        Fri,  9 Sep 2022 18:26:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662748018; a=rsa-sha256;
        cv=none;
        b=kuzz8Tz1AElB8ZUXWs83BtmK58ZIaunrOVSUiiK80kkJomKBVeOWdES/+7WmY2ITaUbJmP
        PhMl5lvGRiEbmog2fcXxcgX7s7roAF4QlOk87QA2IFwfmqnOvrLWGtU7CmZPBUO0XwlSF6
        adlpMtGO2B4mGE7zPhsv1hYUllCAdbnm0RPwCqSO29f7XGxOCc94qlWlNfL3sWK7K8YLI3
        hmYQg7NlafS/PfnwemomqMhVuxzuW9w41heYu/T/Z9tMpHXsyy8SOQ8U4X2+/AH6NEL14F
        +arvYNI+Wi8pTVlsm7yAYiDJdERwp9PE5VxzfSMgLqjwmTOHuxZqsWCUSMQjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662748018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GtckZLP1so7kSSNprVQO4WJo/PLazpIDILHbKQeupU=;
        b=Btx/huibDxjCo0xzfHFASAHTiJlahjyAp1GBEl0YHRFBOzXdG1oWa6bOsE8pxz2K0le5d3
        i9wlZn6iuZSfO7Y9HB0DwjERbjwnUOMfsna1gA9is48zV9g64AXhHsmbYM7XsVeOFvqDor
        nkcl8Sk0MXBz06zPkpQxDnpe9hJz563tJY0Dg2xVymYW56SL8aXblPMhtY9ZMNnWNCH7Yv
        aOVDkz57ymupnAPU7HVXhKbtV+rZes5ZrRKMV7U4ff2dH4LHlrMFcs7vEzQlZt/JhlfT2R
        cGThj29/pNNJ3jKBDbkS+7zjhCsrtgyzVNTDoJl6xM8SKX3bo9v8Bw4FPptZlg==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-mggm2;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cellar-Oafish: 6af97cb72de94d95_1662748019134_1941784291
X-MC-Loop-Signature: 1662748019134:3563730531
X-MC-Ingress-Time: 1662748019133
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.121.28.249 (trex/6.7.1);
        Fri, 09 Sep 2022 18:26:59 +0000
Received: from p3e9c2f68.dip0.t-ipconnect.de ([62.156.47.104]:38952 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oWiiL-0001wU-CI;
        Fri, 09 Sep 2022 18:26:56 +0000
Message-ID: <0100c85e9395b0a0768a136cf1ca1373e716cb6f.camel@scientia.org>
Subject: Re: status on security of embedded repos?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Date:   Fri, 09 Sep 2022 20:26:50 +0200
In-Reply-To: <c5ce968cb5f764032345b654857c21745f0c1b1a.camel@scientia.org>
References: <4e9ad5486e8a887f1e92cc4e401ca61be5f2bb9a.camel@scientia.org>
         <6sq30r84-1s65-91n4-5qoq-23s9q433sno1@tzk.qr>
         <c209dc21f6826bbb60d75450e6f7f9ff2258d18c.camel@scientia.org>
         <4697o162-0pop-4715-150r-2317p0n69581@tzk.qr>
         <aeb235f7a914539ad50eff96479106f8c8ec8d48.camel@scientia.org>
         <kl6ltu5h954s.fsf@chooglen-macbookpro.roam.corp.google.com>
         <c5ce968cb5f764032345b654857c21745f0c1b1a.camel@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.45.3-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2022-09-09 at 02:05 +0200, Christoph Anton Mitterer wrote:
> As e.g. indicated in the LWN article, a similar problem exist for
> e.g.
> a .git "hidden" in a tar, which is extracted an may be used for the
> same purpose by an attacker.

I spent some more thought about that, and I'd even also call this case
a security hole in git.


If someone downloads an untrusted tar and executes some code within it
(makefile, binary, script)... then it's quite clear to anyone that this
may allow an attacker to do as he likes.

But if the tar contains for example a PDF or some image and these are
displayed as thumbnail by e.g. a GUI file browser, then no one would
say it's a wrongdoing of the user (as one would say if some code is
actively executed by the user) - but rather simply some security hole
in e.g. the PDF library.


The solution proposed by some others of specifying the pathnames of
known repos may be a bit unhandy in practise.

Was it considered to use magic cookies? Either alone or in combination
with pathnames?


Whenever a user runs git the first time, some jey could be created in
the per-user git config.

And in git repos some magic cookie (e.g. something signed by the per-
user key) would need to be present for git to consider them as such.

There could further be a system-wide key, for e.g. shared repos.

When the user itself e.g. clones a repo, the cookie would be
automatically created, so such repos would continue to work out of the
box.

Any action in git, that introduces an embedded bare repo (e.g. when a
clone or fetch action finds one) would notice the user (when run
interactively) about that, and asks whether it should be trusted.
If so, in the system/user-wide config, it could be stored, that for
that particular (per-repo) magic cookie, an embedded bare repo at the
just accepted path is allowed.
Should the repo add another one, it wouldn't be allowed by that
previous cookie.

A further setting could allow to configure whether the embedded bare
repo should only be allowed, when the config/hooks/etc (everything that
is security critical) haven't changed since the time of being accepted,
e.g. by creating some hash over them.

This would prevent any attacks where first the embedded bare repo's git
config looks fine, but later some evil stuff is added.

Having this as an option would still allow people to fully trust the
embedded bare repos (either any of them, or just in an accepted path)
of a given repo (if the trust that).



Since in the non-bare repo, the per-repo cookie would set whether it is
allowed or not... and not a path... the user could move the repo
directory as he wishes (without the need to adapt pathnames). The paths
of the allowed embedded-repos would be relative to the repo they're
part of.

A new git command could allow to manage this, e.g. having different
keys, migrating them, revoking them, listing any allowed embedded non-
bares, etc..
That would also enable to allow normal/embedded repos when things are
not running non-interactively.


Of course the keys and cookies must never be published.


One could even combine all that with some path-based authorisation
(i.e. storing the pathnames of trusted repos in the system/per-user
config, in addition to the cookies)... and only allow a repo if both
match... and if e.g. only one matches, ask in interactive mode.


The defaults of all these should be the most safest one, i.e. not
allowing embedded bare repos per default, and if the user manually
accepts one, then per default only allow that particular one in the
repo and only with the config/hooks/etc. as of the current state.


One might even think of an option, to not checkout files of embedded
bar repos at all, when no permissions are set, in order to also protect
any 3rd party programs that are not secured against the attack with
embedded bares.




If things work out as I hope, this should fix both issues, the attacks
with embedded bare repos, and the ones with "unexpected" ".git" dirs in
untrusted content like archives/etc..
At least as long all tools (especially 3rd party) support the whole
thing in all places.

And it should still be "rather" comfortable. Sure, not as out-of-the-
box as right now, but still better than remote code execution.


Any thoughts about such system?

Thanks,
Chris.
