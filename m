Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E5C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 20:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiGVUqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiGVUqI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 16:46:08 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D7C30550
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 13:46:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7029E320094A;
        Fri, 22 Jul 2022 16:46:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 22 Jul 2022 16:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1658522761; x=1658609161; bh=QXAPH+axE8
        HMjwO4kVgeCmU2KO4rArMd/6mrwmtoLNw=; b=WABtv7sALvddCxiWgSMDM4o1nQ
        z/NIUaQlxY9+TT9yQH+rDaMf7Z03patv/N96ESW+VadkJdvtHKKfcxY0mb2f4lxL
        YZ9lBQq988R3MQDy9FSjXN44Pg+rdPez5W0eKh+WvCp3aAarjXEKxomuzErnxdgV
        hk3UPre9XL89nfx4WvovcGSsC2cQJ6Ruq+ZBJqoCFkolm4U+uM4iMnk4KcgNWR4S
        iVwG/Rqcr3UUuaS9JA7zRga4wW3n+oc2nyDbsHCkrDzcZtXMEJJVZHA+6d5dcIfj
        llAgCbGJVK90k0LULkfCmuRkXUNxrpk/bE4bxofRtLfeZ+I4D46b5c2kVvmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658522761; x=1658609161; bh=QXAPH+axE8HMjwO4kVgeCmU2KO4r
        ArMd/6mrwmtoLNw=; b=oyNfEGJbhSQhVYox+sGd042OHIdRBQunbv0bCrBZvM6l
        ymwj/fKqoAFMzJF4kMK5xGHaw98CCBvZbkcn63VOfKwfK3QVP/vXbPhqTWaXtOUc
        PRRYeOQZxSXasEejeeRWyvUIavxVhkrI2ib2Jg6quLuXywP1Om6QginQmouOmNxC
        d+zSqHqqLUtEZMaY6dL4XqXmf08nl51rXVHZVS/8Y2OEgJrJvsT0YiY/uvd4RLUM
        dWvfPlrso28UoGnBCtZjnQkdvUSJPLttpJKeeeHy3iusI6agtUw8k326BywBeK5s
        qzJKLnDym2uUdH0a/q2xvGQONV3ylJyXCo9FXBn0Eg==
X-ME-Sender: <xms:iQzbYmOnh7xBbh2SIEe6OEl27Nh2P5kalLLhoTa1vKINMxP91qfWGw>
    <xme:iQzbYk9TX5fWs8pWYR52hhrfLW1aGTZ6m7eNCZagUGzgbX7IN6QpQh6KBWBgP8zFj
    Q0bPPcTcE8S58tWIA>
X-ME-Received: <xmr:iQzbYtTKo163xOkpDQdRzsW1MX6iSe4nQCkIJjirCCiv-X7KCsjzxsoBDA0sIG_9QIy-im3yFf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtvddgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeefleetgeefhfduieeitdegieehhfduudfhuddttdekgfduhfduieefteek
    hfduveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:iQzbYmtAS4zXzDpa0VkZnrsVfOhEavCGsT7HA82dV7QVFk6AB6B_gA>
    <xmx:iQzbYudT0sDZDHy6rLDBgdPgx0wBj8190vpFzM37SPgbFqEc4Pc46Q>
    <xmx:iQzbYq3fyTwO9mh-vDTDczhtSK4lYpJBNy_D3FXDIAcfDuZUveqmgg>
    <xmx:iQzbYiHOg7ILfN6TyJ7-kvLdDeIPwOkakVYSoXA-sB2FZsbWRjxfYw>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Jul 2022 16:46:00 -0400 (EDT)
Date:   Fri, 22 Jul 2022 22:45:57 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Claudio Ebel <claudio.ebel@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Changed diff3 view from =?utf-8?B?Mi4z?= =?utf-8?B?NiDihpI=?=
 2.67 for vimdiff
Message-ID: <YtsMhb0XUPw2EekJ@zacax395.localdomain>
References: <99c80fc2-0f94-a607-ca71-c45961c07e2b@web.de>
 <CAN0heSrCocuKA+8UvU8dH_bsM4Xg8L3M8O4W0buXkUc3uCxpGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN0heSrCocuKA+8UvU8dH_bsM4Xg8L3M8O4W0buXkUc3uCxpGA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> There exists at least one vimdiff bugfix [2] in git.git's current
> 'master' branch that is not yet in any released version. If you are able
> to build Git from source, you could try that version to see if it fixes
> your problem. As far as I understand, that patch relates to end-user vim
> settings, and you did write that you nuked your .vimrc, so maybe that
> patch doesn't quite match your problem, although from the original
> report [3], it does seem similar.

Hi Claudio.

As Martin just said, this looks *very* similar to the behaviour you would
experience if you had vim configured to open splits "in reverse" (when compared
to the default settings).

You can make this test to confirm whether this is the case or not: try to run
this command:

    vim -c "echo | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis" -c "tabfirst" local.txt base.txt remote.txt merged.txt

(note: this is the same command git 2.37 uses when running
`git mergetool -t vimdiff`)

It should open 4 windows with the following layout:

    -------------------------------
    |  local  |  base  |  remote  |
    -------------------------------
    |           merged            |
    -------------------------------

If you see something different, please then try to run this other command :

    vim -c "echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis" -c "tabfirst" local.txt base.txt remote.txt merged.txt

(note: this is the same command git will run in a *future* version)

Notice that this new command is exactly the same as the previous one but
including keyword `leftabove` before all `split` and `vertical split` commands.

If you run this command and this time it displays the expected layout, you have
two options:

    A) Wait for the next git version where this will be fixed :)
       (as Martin pointed out, the patch can be found in [1])

    B) Update your .vimrc to include these two lines:

         set nosplitbelow
         set nosplitright

       ...or, alternatively, update your .vimrc *not* to have these two lines
       (as both options are disabled by default):

         set splitbelow
         set splitright


> Since redirecting HOME works, I wonder if you do have some other config
> file after all. Maybe you have more than just one vimrc?

This is also what I suspect.

You can make this experiment to confirm this theory:

  1. Run "vim" and then ":set splitbelow?"

  2. Run "HOME= vim" and then ":set splitbelow?"

If the returned string is different ("splitbelow" in one case and "nosplitbelow"
in the other one) it means you have a ".vimrc" (or something else) somewhere in
your $HOME that is changing vim's default settings.

By the way, you can list all scripts "sourced" by a vim instance by running this
command from inside vim:

    :scriptnames

That will help you find the "rogue" script inside your $HOME.
Note that it could happen that some of the other vim scripts you have sets those
variables without you noticing!... in that case you can also change their value
back *at the end* of your "~/.vimrc"


Fernando.


[1] https://lore.kernel.org/git/20220708181024.45839-1-greenfoo@u92.eu/

