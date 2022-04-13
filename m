Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFBBC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 14:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiDMObD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 10:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiDMObB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 10:31:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2649C5640C
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 07:28:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v15so2558043edb.12
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YhgM4T1kOITHOPoyLk/wvoPjrgxUqKGCTRxtWkse/AU=;
        b=YgHQEiy5zP0I8SQr2ruMpniHt/bTSz+LxZwrA4EBBu7eTwlHIqmgKac/hFhb4Mzcqk
         PVwKaqV1IS0QIXXMBxIaDKCT651E/caIqpCMICZiNnC8Ik4Zsfy8dJhq+9xa3ODYVg6y
         IkO5mzOPDB+5lQ8FT9xyiiAh784b86YJGr6sIdbi7VeV/OY5aPUfidqDTlggVvjADU/8
         jEToP5czDJRPGOqVA3mdSrJPKJfemoRRTbciz4YHvP+pW1WvoMa5+E8/3l2YOVaaSub+
         ofahhh1P51OGlgieKLVeQqjV1/zfPsQF/om1pb/qZzPC0KsABallEkZ/6XkL7XFNLlj8
         G9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YhgM4T1kOITHOPoyLk/wvoPjrgxUqKGCTRxtWkse/AU=;
        b=EpaiGz6WYzIgI+wnf13nmP/BydSa2jAvKaJ44DTq9w4vf2/uRuSxdsHPUcMepbwuoY
         Arrm5vwtSYJcM/DD0Q0NeuaZ6L/SpfByyE8WaIg9ILaw442jTqN0KmwcKJoeyzTe953l
         N8bQvtCaP4Rebd3Byds6L6/jir2Ug5+ADY32NSLq+9Ha9fEeBUusINNkJKCHEdkzElHs
         k37fJEfkPcNnIq3P1jvZIL6HcxTzkerAdpWZcjskxrTXhimMdxWcUZcHCcV8nDPqKjnW
         lAogho2bpOcja8XmWj5PqbMEw+sY5gC+XEpN8sIXCwJhYK9RotoHEIrZidLBevSlPRST
         gXDA==
X-Gm-Message-State: AOAM5339w0UkRcNc1wW8L/gXu9kefW5nb2ikaAL8sxWrVXPEPiZL8yBM
        cQkk6CS84aaqkHFDtVs1VlGKLTFqTVk=
X-Google-Smtp-Source: ABdhPJw7IXkw+ENugBFHcTJzxxelq92QXrLa8AwmTMdFwaahlzyxPphdojH8fNPJYGFQ3c/7gC5yVg==
X-Received: by 2002:a05:6402:2059:b0:41d:82c2:208a with SMTP id bc25-20020a056402205900b0041d82c2208amr13278858edb.379.1649860113547;
        Wed, 13 Apr 2022 07:28:33 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b0041cbaba8743sm1297470edk.56.2022.04.13.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:28:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nedyy-00554N-42;
        Wed, 13 Apr 2022 16:28:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeremy Maitin-Shepard <jeremy@jeremyms.com>
Cc:     git@vger.kernel.org
Subject: Re: Limitations of ownership checking fox for CVE-2022-24765
Date:   Wed, 13 Apr 2022 16:05:43 +0200
References: <CAKJfoCEgiNvQJGt=rGYTaKQ1i2ihrPmX2Sz3Zxg-y66L+1Qh6g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAKJfoCEgiNvQJGt=rGYTaKQ1i2ihrPmX2Sz3Zxg-y66L+1Qh6g@mail.gmail.com>
Message-ID: <220413.86v8vdf46n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 12 2022, Jeremy Maitin-Shepard wrote:

> The current fix for CVE-2022-24765 prevents unsafe command execution
> in some cases but does not address all cases:
>
> - Ownership by the current user should not be taken to mean "trusted":
> the user may have retrieved a directory tree from an untrusted source,
> including:
>   - Another version control system (which won't prevent a .git directory)
>   - Unpacking an archive
>   - FUSE mounting a remote filesystem

Those would be good to fix, but I don't think it's correct that it's
within the scope of CVE-2022-24765.

That CVE is specifically about the multi-user case where we'd previously
pick up another user's .git directory.

Whereas these cases aren't like that in that they:

1) Require the user to have set up that .git directory themselves, in
   one way or another.
2) ...or for the OS to enforce user permissions so loosely that others
  can chown files as you.

> Additionally, the current fix requires additional configuration to
> support existing use cases, and does not provide uses a way to safely
> execute commands like `git status` or `git log` on untrusted
> repositories.

Yes, I agree. I.e. that the method of fixing it is all-or-nothing, and
therefore creates escalation issues that wouldn't occur with a narrower approach.

There was extensive off-list discussion about this, my [1] touches some
of it. To quote my side of a discussion following-up [1] about the more
narrow approach:
	
	An implementation that asks the user to create an opt-in for any and all
	config will be much less secure for the core.sharedRepository case,
	which is an edge case my proposed change on top doesn't have.
	
	That's because we'll refuse to read *any* config (including just that
	created by "git init"), and then ask the user to opt-in to any *future*
	config to keep using the repository at all.
	
	So for the sort of staging environment I mentioned upthread it'll
	effectively create a vulnerability which we'll still have no practical
	mitigation for.
	
	Whereas if we only error on the specific exploitation vector(s) users
	who're using a repository without such config will never need to opt-in
	at all, so when someone sneaks up on them later and adds a
	core.fsmonitor=/path/to/exploit they'll know, and we can show a much
	more pointed and obvious error to that effect.

As noted in [1] the solution that got committed does suffer from that
edge case, but I think [1] also summarizes why that approach was taken.

A way of mitigating that case is to put something like this in one's
.bashrc:

	git () {
		command git -c core.fsmonitor=false "$@";
	}

Then, even if you need to use that safe.directory feature you won't be
vulnerable to someone sneaking up on you and adding this to the
.git/config of the (presumably core.sharedRepository) repo:

    [core]
    fsmonitor = rm -rf /

> I think a better solution would be for git to support a `--safe`
> option that only runs config-specified commands specifically added to
> an allowed list, or if the repository itself has been added to
> safe.directories.
>
> Ideally git would default to running in `--safe` mode, but if that is
> too disruptive at least the option would be available for use in
> prompt commands, etc.
>
> (Please CC me in replies as I'm not subscribed to the list.)

What you're suggesting would be nice, and has been discussed on-list
before.

But it's fundamentally the same case as "make inspecting an unpacked
.git [from a tarball] safe", i.e. that we'll currently pick up config
from it.

The CVE specifically exists because it's subtly different from that
long-known-about case.

1. https://lore.kernel.org/git/220412.86h76yglfe.gmgdl@evledraar.gmail.com/
