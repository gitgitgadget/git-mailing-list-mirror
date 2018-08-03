Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E75A1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 18:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeHCUqt (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 16:46:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40316 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeHCUqs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 16:46:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so7453204wma.5
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 11:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JToVU7tROF/LdmV0396KfugZW1sSYNpLbS70T3uK+jk=;
        b=VumbG448x2qVPB90qy7Ya2g21iFHsZ+iXkwUF6jaMWsotbIvacm8/i5CPdb4fnpNh9
         hBwt2cFzW10AUiMuxoH1LWRKdD3HBhkveq7G4Lm+HratMAQ61ou0zAfGy3tQyuQpadmq
         OwjgkbEtfGjyZ7YGiEZYT10O689vQElV+ARjX/5Rrbb8VBawcAqh2uDWEk6WpFr6ZCMP
         Z/sLRsh1MygiTzSpNE4vX0TU8oniTRz1lCfH+4aFLEqopz3ZcVuXyjyx3EJoWK+LYlAR
         3npcqOwHicXzR/JxeBXIDo0/78voYavoFHGwlHf6Ve47llSzcGhQOyZBKEZfzh92V7Cn
         flNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JToVU7tROF/LdmV0396KfugZW1sSYNpLbS70T3uK+jk=;
        b=Y8XdOSoROtIYBMq52BArJeEPGoNnuWTpbG+ipoJsyeeVPrukBSh2dZNV/vTqxLpIHo
         BMhBNEJnQcyoSRJ9p2oDjCbw2FRX1yOlkPWz9WiTd1i7YmH+lDikSn1JQp0Ht1mMIc65
         U1lvKnOkH6s3DVNedPkFvxpL5QDSAfV4PQlvbVwqKMzYL7SKHQ3S8/wy5gPdGDBwMutq
         ndexVMRWknhcBu6do0wZNRe9yl+cOBdnvviXn1YQlln1Ebr+cOCBUs5NoY37JaP1fv4H
         E3vfOkFnvXcHIOdq1G5yNIHHDeY84MDPXBuEOuoL4vukdNClTkynEBgSpgE536kfuhi3
         m/Xg==
X-Gm-Message-State: AOUpUlHV/TpZkVbD+94OIdmvBOw2tf8x8JWNU5pCcF+TdSm8nTuAcrq8
        hJFR5xHGk89fHSsQ0bwFjbw=
X-Google-Smtp-Source: AAOMgpdfklHKXvov1UHH+42b3ulXZey1Hfhsi2AKEmhKgLMStDaDU5haHQCkep/9KPMOlky/JlT0gQ==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr5506039wma.128.1533322156362;
        Fri, 03 Aug 2018 11:49:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s24-v6sm71845wmc.7.2018.08.03.11.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 11:49:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Pawe=C5=82?= Paruzel <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
References: <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
        <20180731192931.GD3372@sigill.intra.peff.net>
        <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
        <20180731203746.GA9442@sigill.intra.peff.net>
        <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
        <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
        <xmqqpnz03f9o.fsf@gitster-ct.c.googlers.com>
        <20180802190644.GE23690@sigill.intra.peff.net>
        <xmqqmuu4zd1l.fsf@gitster-ct.c.googlers.com>
        <20180802212819.GA32538@sigill.intra.peff.net>
        <5b17454b-7fa7-7a9c-92d9-214e6e697785@jeffhostetler.com>
Date:   Fri, 03 Aug 2018 11:49:14 -0700
In-Reply-To: <5b17454b-7fa7-7a9c-92d9-214e6e697785@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 3 Aug 2018 14:23:17 -0400")
Message-ID: <xmqqsh3vwaj9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Another thing to keep in mind is that the collision could be because
> of case folding (or other such nonsense) on a directory in the path.
> I mean, if someone on Linux builds a commit containing:
>
>     a/b/c/D/e/foo.txt
>     a/b/c/d/e/foo.txt
>
> we'll get a similar collision as if one of them were spelled "FOO.txt".

I'd think the approach to teach checkout_entry() codepath to notice
it needed to unlink the existing file in order to check out the
entry it wanted to check out would cover this equally well.

> Also, do we need to worry about hard-links or symlinks here?

I do not think so.  You do not get a file with multiple hardlinks
in a "git clone" or "git checkout" result, and we do not check
things out beyond a symbolic link in the first place.

> If checkout populates symlinks, then you might have another collision
> opportunity.  For example:
>
>     a/b/c/D/e/foo.txt
>     a/link -> ./b/c/d
>     a/link/e/foo.txt

In other words, a tree with a/link (symlink) and a/link/<anything>
that requires a/link to be a symlink and a directory at the same
time cannot be created, so you won't get one with "git clone"

> Also, some platforms (like the Mac) allow directory hard-links.
> Granted, Git doesn't create hard-links during checkout, but the
> user might.

And we'd report "we are doing a fresh checkout immediately after a
clone and saw some file we haven't created, which may indicate a
case smashing filesystem glitch (or a competing third-party process
creating random files)", so noticing that would be a good thing, I
would think.

> I'm sure there are other edge cases here that make reporting
> difficult; these are just a few I thought of.  I guess what I'm
> trying to say is that as a first step just report that you found
> a collision -- without trying to identify the set existing objects
> that it collided with.

Yup, I think that is sensible.  If it can be done cheaply, i.e. on a
filesystem with trustable and cheap inum, after noticing such a
collision, go back and lstat() all paths in the index we have
checked out so far to see which ones are colliding, it adds useful
clue to the report, but noticing the collision in the first place
obviously has more value.
