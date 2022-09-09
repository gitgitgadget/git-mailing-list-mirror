Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E81EECAAD5
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 00:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIIAF0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 8 Sep 2022 20:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIIAFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 20:05:25 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FCA109D1B
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 17:05:22 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BDDB86C32BE;
        Fri,  9 Sep 2022 00:05:21 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1EB726C31C1;
        Fri,  9 Sep 2022 00:05:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662681920; a=rsa-sha256;
        cv=none;
        b=4Dn1GnBV8Nw72J8JOOSpWYtAvmmEYK5yy0kzmC/wHQ7pFu5wdld0AB3TNT9pko0w4+mP2h
        0hQSmmyfNWHcoU87pQDYzI1M68Og/3iFL/uoj2G8lYyS9tNbTQ60P6xqKCltEns6zZCXDU
        frkNjBwGJ9W262rElHKnAL1vFsV7xGuIANJOjQLRxad/w8Fvyk4uquA2LZbawrZEB+EXHD
        wX2cHZ1UOe50MEk1LuP5RiHa6jnyDbrKXMatScpMyvlqo5yV7E1BkpBf9ZU1oq4wnrlc9E
        VD0ZV8A6fciAl2/njxn9mth5p6GCdxakkW8t05eravshdJ8IP6VS+qmxYzXu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662681920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fpgUfN05i9fyvSXoMXw0QdDNzZeYDdj0DpOe18gPe4=;
        b=BPaBzTc0cDyVsjjGD5FGmTGf4+B94/px9qXvnDKGT67CbkBLt0xp3nl1Lfrus9SVWCPL4j
        bJ+1mrCjaAl0rSprqGPpdVyNzVYLJ34bMrqKJJ5QoLOVPCumzMXCrHsh5ZlvwKkt2i+fGt
        IVjz2V56bcP4oL230kr9JD6xr+Ug5uuySdGKDeh0ZJLuu5SMLgCUOQWuhbNKb2Hq9WNydC
        w7CLDFKLrKU5CctIPgU8eGYKtJTFYpGbv9GTzTfkkqLJxleudUcfBNWC5k0q2Q4l3hd59r
        IeyO0NxkEwUMqltY4OoNntcLdzel+qejl9im1f+AG+rJthXNXFe3Q9t+aM0aIA==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-5njhc;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Shelf-Dime: 2c9810076e07b489_1662681920926_3215942814
X-MC-Loop-Signature: 1662681920926:3771729141
X-MC-Ingress-Time: 1662681920926
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.121.210.155 (trex/6.7.1);
        Fri, 09 Sep 2022 00:05:20 +0000
Received: from p54b6d828.dip0.t-ipconnect.de ([84.182.216.40]:40460 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oWRWE-0004g4-Eu;
        Fri, 09 Sep 2022 00:05:18 +0000
Message-ID: <c5ce968cb5f764032345b654857c21745f0c1b1a.camel@scientia.org>
Subject: Re: status on security of embedded repos?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Date:   Fri, 09 Sep 2022 02:05:11 +0200
In-Reply-To: <kl6ltu5h954s.fsf@chooglen-macbookpro.roam.corp.google.com>
References: <4e9ad5486e8a887f1e92cc4e401ca61be5f2bb9a.camel@scientia.org>
         <6sq30r84-1s65-91n4-5qoq-23s9q433sno1@tzk.qr>
         <c209dc21f6826bbb60d75450e6f7f9ff2258d18c.camel@scientia.org>
         <4697o162-0pop-4715-150r-2317p0n69581@tzk.qr>
         <aeb235f7a914539ad50eff96479106f8c8ec8d48.camel@scientia.org>
         <kl6ltu5h954s.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.45.3-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Glen.


On Thu, 2022-09-08 at 09:56 -0700, Glen Choo wrote:
> In a world where we had someone who headed all of the Git ecosystem
> making these decisions, that sounds like a great outcome.
> Unfortunately,
> I don't think such a person exists.

Well it's clear that there's no such one, but at least there should be
people far more experienced than me (who in terms of git is nothing
more than an average user)... and would be far more able to see which
other projects might be affected.
...

> how do we know which projects to engage
> with? 
> e.g. we'd probaby need JGit and libgit2, but what about smaller
> implementations like gitoxide, editor plugins, and the long tail of
> other projects in the space?

... clear, too, but again, you already named more than I'd have known
about ;-) ... I mean I knew libgit2 (which is utilised by some git
tools I use) and had heard of jgit before, though I don't use it.

These are some other git related tools, which I would assume are used
widespread or in some more (security) critical places:
- dgit
- git-debrebase
- git-buildpackage
(the above being used in Debian package management)

- git-remote-gcrypt
- git-evtag
(the above being used by who likely have high security requirements)

- libgit-wrapper-perl

all these seem to either depend on git itself or libgit2, so one can
hope they'd be safe as soon as git and libgit2 were. But I guess it's
really not more than just "hope", because any of them could e.g.
manually look for git config and do stuff with it, thereby picking up
that from an attacker in an embedded bare repo. Right?

Not sure what about things like:
- meld (which has *some* git support, but probably implements all that
  by itself - at least it doesn't depend on the usual suspects)

But even tools like gitg, which use libgit2 or libgit-wrapper-perl
which uses git itself could still "manually" read some config file,
thereby avoiding any "fix" of safe.bareRepository.



> > I can however open a ticket over at libgit2, if that helps you.
> 
> It would help all users :)

I've did this now for libgit2:
https://github.com/libgit2/libgit2/issues/6400

But I'd really hope someone with more background in that field could
follow that up for other 3rd party projects.



> > Also, even with default settings, git, AFAIU, would be still
> > vulnerable
> > for the majority of people (many of whom likely haven't even heard
> > about the issue).
> 
> Yes. We've talked earlier about finding a safer default for
> safe.bareRepository; but it hasn't been highly prioritized. Feedback
> like yours is very valuable because it gives us a sense of how
> important
> this is and can definitely have an impact on prioritization.

Maybe I misunderstand the issue and make just a lot of noise for
nothing.

My understanding was, that an embedded bare repo, would allow arbitrary
code execution, when one has cloned or fetched that as part of some
regularly used repo... and as soon as one runs git commands inside of
that.
Right?

That sounds pretty severe to me. I was surprised to not see some
emergency fix, even if that would have usage of embedded bare repos.


In some mails it was said to be social engineering, but I wouldn't
agree with that:
Social engineering is when one tricks a user into doing something
(security-wise) stupid, like pishing or the CEO-fraud.

Cloning/fetch and "inspect" through an arbitrary (untrusted) repo is
however IMO expected to base functionality of git. Unlike e.g. running
make or any other code from such repo.

It's as if libjpeg would contain some RCE hole, and one calls it social
engineering because it's only a problem when people display the wrong
images.


For git, the issue seems even more critical, given that the people
using it may be easily high-value targets for some attackers (and not a
ransom ware group or so, but rather something like APT - I guess they'd
be quite happy if they could easily infiltrate the computers of kernel
developers or such of similar critical projects).


IIRC other have previously proposed having a option in the system/user-
wide (only) git configuration, where one has to explicitly specify the
paths of the allowed embedded bare repos.

But as long as something like that or better is implemented... there
should be safe-out-of-the-box default, better last month than tomorrow
- at least if the issue is as critical as my understanding is.

Especially considering, that most end-users of git likely haven't even
heard about all that.

Something like a warning in git-fsck, which I think was also proposed,
definitely doesn't seem enough, cause when do regular users invoke
this?

Also the bare repo can be embedded with any commit in any branch, or
could even be removed again later (to hide traces but still wait for
people to check out some older revision).



TBH, given how critical (RCE) and how easy to exploit this issue seems,
I'm rather surprised that not more is done.

The original issue is open since April and even the safe.bareRepository
workaround is an opt-in fix.
At least it seems that the issue is not taken that extremely serious?
Is there even a CVE for it?

At least I, personally, don't use other repos anymore at all since back
then (which is of course like half of a showstopper for git)... and if
that's so easy to exploit, I wonder how anyone could.




As e.g. indicated in the LWN article, a similar problem exist for e.g.
a .git "hidden" in a tar, which is extracted an may be used for the
same purpose by an attacker.
Seems also quite easy to do and not really something an average user
would expect.
People may have things like git-prompt active and so just by changing
into the extracted tar they might be pwned.


So maybe there should be an option in the system/user wide config which
lists all repos (bare or non-bare) which are allowed. git clone could
e.g. automatically add a repo in there (of course it would make things
a bit less out-of-the-box when people e.g. move the repo dir - but
still better than an easy remote code execution).
That might also mitigate any shenanigans attackers could try via hooks
or similar.



What's the policy from git maintainers on all this?
Is it desired that any such holes are fixed (definitely - and not just
for 99% of all cases) or is the policy that people cannot clone repos
that aren't 100% trusted or use git on systems where e.g. possibly
untrusted archives with a ".git" are extracted?


Thanks,
Chris.

