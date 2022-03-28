Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9839C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 18:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbiC1Ss1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 14:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241837AbiC1Ss0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 14:48:26 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCF75FF00
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 11:46:45 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f3so12536780qvz.10
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W4HXZ6IzZdfZF/8eOtHurQPM8T9xyKLybRjJfyZqM50=;
        b=PAH2eGCtmMJdHwQCOvp2Jh/+HShndEZRUW3UsJqqZP5rB0XPXwblFFkWTTJi+XOqWY
         Dk6fLCA5CnJ7m/FbvAUd6T7D/Jx9/dgE552kBI1AMg/Sz+EpBGvH4wYFMFM9pc4B/Tne
         numhOGVKXV224xkbOvCEAc8qyeMiYA7CrNPyLXRefVWbtdXLhQEuc4QuSVkmB1mRpFU+
         cgwdA9YUQX2+TXTCs42kIa0CQWVaRMhnLm71taxnFbBSEQvbEOk8zHv1tc3RyE7WM9u+
         qhzLJPD56xb7yASmCi88hmYv7S6XmXRxoxkktyBcpH9pFTiLNXSGOUI1iiApGRh3Hakh
         +h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W4HXZ6IzZdfZF/8eOtHurQPM8T9xyKLybRjJfyZqM50=;
        b=kpdEEcZ9Sg2QQGk1SYHkcss6Q9rANC3+2EXDo2B6VA9+OFpEMnoenHszgBjbmUqh3u
         YCZqR+wNylTJpdkkU3ItnyFCB89bcuZW8xHx4fFCf1eYpfBs9g2UZ1D9019xj/gLGXo4
         t24Vr6+V9vfO1m8+Zk9NBDrpUFMcAdWaEUi0F0+yHPMpz4h8Kg8qWuvSj5ZO6y2KCf47
         p+ZZv0ouvIOLr6jf2OOon6yUzmhHfWEr1f1we+Hl+dSyfvrduLTVyft+nfGNU9p/bp1w
         Nsd9bIPQMcns8aStkWqLpepqSALYk9ZjjUxYMwtAn1cpwXcyBLA3ym1TUgB39RFJFWGR
         r0RA==
X-Gm-Message-State: AOAM532O7HXKcQuisjIiCXBTyxz15GMs2kjBRQ1j7KWqbCPJVXnJCJyp
        7Y71rn0h1hwXL0hy8r7dHtkn8g==
X-Google-Smtp-Source: ABdhPJxOdp7d0TSleSkmyCNNblwIP5pQNF0UyJy2hzp2JHTWA9YFWsFBrrf73+I0UWYPcBYea12zOA==
X-Received: by 2002:a05:6214:194e:b0:441:2893:c409 with SMTP id q14-20020a056214194e00b004412893c409mr22508392qvk.48.1648493204573;
        Mon, 28 Mar 2022 11:46:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u20-20020a05620a455400b0067ec0628661sm9420881qkp.110.2022.03.28.11.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 11:46:44 -0700 (PDT)
Date:   Mon, 28 Mar 2022 14:46:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <YkICkpttOujOKeT3@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
 <YiZI99yeijQe5Jaq@google.com>
 <YjkjaH61dMLHXr0d@nand.local>
 <YjpDbHmKY9XA2p0K@google.com>
 <YjpHbaBspUasDdEy@nand.local>
 <YjpWFZ95OL7joFa4@google.com>
 <Yjpxd8qhwnAIJJma@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yjpxd8qhwnAIJJma@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 22, 2022 at 09:01:43PM -0400, Taylor Blau wrote:
> > >> Can you tell me a little more about why we would want _not_ to have a
> > >> repository format extension?  To me, it seems like a fairly simple
> > >> addition that would drastically reduce the cognitive overload for
> > >> people considering making use of this feature.
> > >
> > >There is no reason to prevent a pre-cruft packs version of Git from
> > > reading/writing a repository that uses cruft packs, since the two
> > > versions will still function as normal. Since there's no need to prevent
> > > the old version from interacting with a repository that has cruft packs,
> > > we wouldn't want to enforce an unnecessary boundary with an extension.
> >
> > Does "function as normal" include in repository maintenance operations
> > like "git maintenance", "git gc", and "git prune"?  If so, this seems
> > like something very useful to describe in the cruft-packs.txt
> > document, since what happens when we bounce back and forth between old
> > and new versions of Git operating on the same NFS mounted repository
> > would not be obvious without such a discussion.
>
> Yes, all of those commands will simply ignore the .mtimes file and treat
> the unreachable objects as normal (where "normal" means in the exact
> same way as they currently do without cruft packs). I think adding a
> section that summarizes our discussion would be useful.
>
> > I'm still interested in the _downsides_ of using a repository format
> > extension.  "There is no reason" is not a downside, unless you mean
> > that it requires adding a line of code. :)  The main downside I can
> > imagine is that it prevents accessing the repository _that has enabled
> > this feature_ with an older version of Git, but I (perhaps due to a
> > failure of imagination) haven't put two and two together yet about
> > when I would want to do so.
>
> Sorry for not being clear; I meant: "There is no reason [to prohibit
> two versions of Git from interacting with each other when they are
> compatible to do so]".

Jonathan, myself, and others discussed this extensively in today's
standup.

To summarize Jonathan's point (as I think I severely misunderstood it
before), if two writers are repacking a repository with unreachable
objects. The following can happen:

  - $NEWGIT packs the repository and writes a cruft pack and .mtimes
    file.

  - $OLDGIT packs the repository, exploding unreachable objects from the
    cruft pack as loose, setting their mtimes to "now".

This causes the repository to lose information about the unreachable
mtimes, which would cause the repository to never prune objects (except
for when`--unpack-unreachable=now` is passed).

One approach (that Jonathan suggested) is to prevent the above situation
by introducing a format extension, so $OLDGIT could not touch the
repository. But this comes at a (in my view, significant) cost which is
that $OLDGIT can't touch the repository _at all_. An extension would be
desirable if cross-version interaction resulted in repository
corruption, but this scenario does not lead to corruption at all.

Another approach (courtesy Stolee, in an off-list discussion) is that we
could introduce an optional extension available as an opt-in to prevent
older versions of Git from interacting in a repository that contains
cruft packs, but is not required to write them.

A third approach (and probably my preferred direction) is to indicate
clearly via a combination of updates to Documentation/cruft-packs.txt
and the release notes that say something along the lines of:

    If you use are repacking a repository using both a pre- and
    post-cruft packs version of Git, please be aware that you will lose
    information about the mtimes of unreachable objects.

I imagine that would probably be sufficient, but we could also introduce
the opt-in extension as an easy alternative to avoid forcing an upgrade
of Git.

Thanks,
Taylor
