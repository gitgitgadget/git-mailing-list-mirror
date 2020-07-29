Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9ABC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE732068F
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596057629;
	bh=lUzDDSw/3Pe4/me1cs78O1PlwKVmcaM8bPwOikSJCSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=grHPq6NBFRi4uUpPBitxEky76lWzT/wZxif5+7zFivzBG3azxr9d9Nson15FX5swZ
	 +RVQEAiOhbwTv18dlgqk4I2LI8e1LXYSuD2Do4WWcIFdzusL7SLNkujTYrxeNQRoDM
	 /8UYH6zclnBcapq2r6dB/sSuzoub8vR1aMeuFWlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgG2VU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2VU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:20:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6139DC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:20:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q6so26615328ljp.4
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EbhmAOT3BXqdN2PZNcx6O/mNI2G0+kofKLEESyj5Qc=;
        b=cXRtBSFI5N1JIEilLJfxJM7x8Z/ymbn0xUF9Itui1M4ym8+Xi8u4jHk163IsdBsU+L
         pAQolWnVoNM+tEgAjDMMameXMlKiEkQlCCTN4w8RWmqF0mmWtmkRSv5f23K3rJTTBnbk
         LygimS9zHfx2H9lHKtRWfJGD0KzPywGEUpEko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EbhmAOT3BXqdN2PZNcx6O/mNI2G0+kofKLEESyj5Qc=;
        b=S98RlwbTBd4fQkN7L8weJK4ZGwKGgtCArIwvwr772qPT3/p0vOb54MITnNtps67ttG
         h2zBZpiLb2Uu7qpr7GqwBRozaV7kcZRTROHo/wIj+8JGc5bntUlAqmLPHyvTZOGKzGD8
         yHAosaNXOW+K2SGuDN1ix50MCfPT7fRoYTCv0Uvbnb8qRRlVXV6G4C7AewYiKkc6bNdO
         mrfBMy6ZNf4WPqzjiZRbHhhA2k7hJQysHZ+jqsCrp+KGTzUphF3pkr13Ascwq40N6dYr
         Y+mXZFs1/GvHFNAaEpCEwnEy5P4NmFrJtE4eCF+9OuluZRQF0G7LFgcVR9FJOK6QM6yv
         ehyw==
X-Gm-Message-State: AOAM5323zNfafHoGSyhTmbl8DvFgR7TGoevTElztN5UB+2vNxOnE7Njm
        IP0xDMSr7mcdVHfjikFMLQ9Gzl9779k=
X-Google-Smtp-Source: ABdhPJxdL4/VYJbrN1TPqppoihdRh1L+awBuQcbC89rWZGxwPDIdGz14Z9/TR2NiM4gm8ce1Pk2mEw==
X-Received: by 2002:a2e:9dcc:: with SMTP id x12mr108642ljj.415.1596057625334;
        Wed, 29 Jul 2020 14:20:25 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id h26sm608169ljb.78.2020.07.29.14.20.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 14:20:24 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id q7so26624486ljm.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:20:24 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr125910ljf.285.1596057623813;
 Wed, 29 Jul 2020 14:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com> <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com> <20200729205846.GA2992025@coredump.intra.peff.net>
In-Reply-To: <20200729205846.GA2992025@coredump.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 14:20:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7r=y_tYpWuRwNFP0JU5D4g=UN1puCzkvQP4bey0-Hmw@mail.gmail.com>
Message-ID: <CAHk-=wg7r=y_tYpWuRwNFP0JU5D4g=UN1puCzkvQP4bey0-Hmw@mail.gmail.com>
Subject: Re: Avoiding 'master' nomenclature
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 1:58 PM Jeff King <peff@peff.net> wrote:
>
> Users can set init.defaultBranch in individual repository config files
> to get the right behavior, though probably it should be a separate
> config variable (the reason it is init.defaultBranch and not
> core.defaultBranch is that you may want different defaults for different
> operations).

That would probably be even better, yes.

It's hard to tell what the default branch of any _particular_ repo is, though.

One option that I considered was to just suppress both "master"
(because that's clearly an old default value) _and_ the new
git_default_branch_name() (as the new default value).

But you're right that you can then interact with systems that have
used yet other defaults.

That said, I still claim that my one-liner is better than what
actually got merged.

> So I think a path forward is more like:
>
>   1. Add a new config option to shorten fmt-merge-msg's output when the
>      destination branch matches it (and this should perhaps not even be
>      a single name, but a set of globs, which supports more workflows).
>      Call it merge.suppressDest or something.

On that note, I have a special

   .git/hooks/prepare-commit-msg

in my tree, because I want to regularly replace the URL I pull from.

In particular, for kernel.org, I actually pull through the
non-public-facing master machine (because that way I don't encounter
mirroring delays etc, and since I don't _require_ that people sign
their kernel.org trees, I want to make sure nobody does any spoofing).

So I use the "url.X.insteadOf" git config functionality to do the
replacement of the URL on the incoming side.

But for the merge messages, I want to do the reverse, and don't want
to expose those not-usable-to-others addresses, so I replace that ssh
access with the public-facing "git://git.kernel.org/" instead.

I use that prepare-commit-msg hook to do that.

I *could* have done that for branch names too, but that is something
that git has done right for the last 15+ years, so I never had to
worry or think about it.

But a generic replacement (or generation) machinery for the whole line
would be lovely. And then perhaps just _default_ that regex to be the
equivalent of

   sed 's/ into master$//'

would work really well not just for the branch name prettification,
but also for things like that "internal vs external hostnames".

>   2. Optionally a repository created with "git init" could copy its
>      init.defaultBranch into merge.suppressDest. And likewise a clone
>      might copy the remote HEAD into that variable. I'm not sure if that
>      is worth doing or not, but it would restore the original behavior
>      for the most part.

Well, the real objection I have to that commit 489947cee5 is that it
breaks existing users workflow.

So some way of suppressing "into master" by default should be part of
the solution regardless.

Making it optional, so that people who *want* to show the default
branch name can do so, and specify what it is, that sounds like a good
idea.

But breaking existing users - that I find to be very objectionable.

                  Linus
