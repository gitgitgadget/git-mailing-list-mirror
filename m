Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669E5C43460
	for <git@archiver.kernel.org>; Fri, 14 May 2021 13:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BBC6145A
	for <git@archiver.kernel.org>; Fri, 14 May 2021 13:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhENNqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 09:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhENNqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 09:46:16 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A52C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 06:45:04 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 76so28686164qkn.13
        for <git@vger.kernel.org>; Fri, 14 May 2021 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7SYrnVyFH0F0nbLOUx2s8jCyJFtlKMa0Nb9RUF0jizI=;
        b=LxgkmPaU8ix63UAweXzvKHaJxm1IT/Ajr93YKPlfqa3oiLmOeRXtn3Bqv9iQjIP6ly
         Ix2N0hvv3nTD4bBbWhau72p4y/0PaRhXdnWEH7mrXu595f9v5cgDRLelC2odNgMQu6uo
         9cwn8NgQxHAoH1GU5VioSUmvWtw8eBBfbQS3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7SYrnVyFH0F0nbLOUx2s8jCyJFtlKMa0Nb9RUF0jizI=;
        b=k7yJp8I4tGF0Z80TpQ+uTBBZE/KIr/k9wZPFDhocbYZkXVEqFp/NdBNzokPce96CKT
         isWWevynzP4iN4Q5/E7cuVy4DVs45gwy5g5GyyTJY9CPRL3ugW4Cgimd0S2ovKNXRvaG
         OGi3R2pez0PcL2myglVJwGrtVlDtDzPpSaEL3hTYJcWu8unOCnazZhMqvcYn/ivYPXyP
         5Ks6XvGvMPLA5vW2CXsLh6Y1Z+pYvhRXS8jhAP/L94HuyCJouxLrMGvv4MsypqY8Ud9A
         fLXW+PuUhOwVtIWag5oT0OUPmabJYiEYNcmCLGqDP7csk0mOJE629R1+A/r3Sfg1rOtK
         ayGA==
X-Gm-Message-State: AOAM532aFTQDtJgD9DLcoM+jA4FAD6BFBKlEieHwB5xUbrLUGp9KceN2
        WJ+TZke4s9KlsFBu+rmFRV5EKx1QhFRP60RU
X-Google-Smtp-Source: ABdhPJxw533JXsrWGiYo0dKe1XP3ND79O0MfuDNMlZ3FFdmUvaDmZPAws4+oBbVEvsl9B0FHro+cdQ==
X-Received: by 2002:a05:620a:530:: with SMTP id h16mr14015081qkh.266.1620999903665;
        Fri, 14 May 2021 06:45:03 -0700 (PDT)
Received: from meerkat.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id b3sm3185946qtg.55.2021.05.14.06.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:45:03 -0700 (PDT)
Date:   Fri, 14 May 2021 09:45:01 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     dwh@linuxprogrammer.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
Message-ID: <20210514134501.3vzgqdfwwejafkq7@meerkat.local>
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
 <87lf8mu642.fsf@evledraar.gmail.com>
 <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
 <20210513202919.GE11882@localhost>
 <20210513204957.5g76czb5bk3thlep@meerkat.local>
 <20210513234706.GG11882@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210513234706.GG11882@localhost>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 04:47:06PM -0700, dwh@linuxprogrammer.org wrote:
> On 13.05.2021 16:49, Konstantin Ryabitsev wrote:
> > Check out what we're doing as part of patatt and b4:
> > https://pypi.org/project/patatt/
> > 
> > It takes your keyring-in-git idea and runs with it -- it would be good to have
> > your input while the project is still young and widely unknown. :)
> 
> Konstantin:
> 
> That's really clever. I especially love how you're using the list
> archive as the provenance log of old keys developers used. That seems
> like it would work although I have worries about the security of
> X-Developer-Key and the lack of key history immediately available to
> `git log` because it's in the list archive and not in the repo directly.
>
> I guess the old keys would still be in your local keyring for `gpg` to
> use but it would mark signatures created with old revoked keys as
> invalid even though they are valid.

Thanks for taking a look at it. I don't view this as much of a problem, since
the goal for the project is specifically end-to-end patch attestation. For git
commits, if they are signed with a key from the in-git keyring, it would
actually be really straightforward to get the valid key at the time of signing
-- you just retrieve the keyring using the date of the commit.

> My approach has been to move to cryptographically secure provenance logs
> that contain key rotation events and commitments to future keys and also
> cryptographically linking to arbitrary metadata (e.g. KYC proofs, etc).
> The file format is documented using the Community Standard template from
> the LF. I'm hoping to move Git to use external tools for all digest and
> digital signature operations. Then I can start putting provenance logs
> into a ".well-known" path in Git repos, maybe ".plogs" or something.
> Then I can write/adapt a signing tool to understand provenance logs
> of public keys in the repo instead of the GPG keyring stuff we have
> today.
> 
> Provenance logs accumulate the full key history of a developer over
> time. It represents a second axis of time such that the HEAD of a repo
> will have the full key history, for every contributor available to
> cryptographic tools for verifying signatures. This makes `git log
> --show-signature` operations maximally efficient because we don't have
> to check out old keyrings from history to recreate the state GPG was in
> when the signature was created.

Hmm... I'm not sure if it's an inefficient operation in the first place. If
the keyring is in the same branch as the commit itself, then you can retrieve
the public key using "git show [commit-sha]:path/to/that/pubkey". If it's in a
different branch, then it's slightly more complicated because then you have to
find a keyring commit corresponding to the commit-date of the object you're
checking. In any case, these are all pretty fast operations in git.

> I still like your approach purely for the "it works right now" aspect of
> the solution. Good job. I can't wait to see it in action.

As you know, this is my third attempt at getting patch attestation off the
ground. The first one I implemented using detached attestation documents and
it was clever and neat, but it was too complicated and failed to take off -- I
think mostly because a) it wasn't easy to understand what it's doing, and b)
it required that people adjust their workflows too much.

The second attempt was better, but I think it was still too complicated,
because it required that we parse patch content, making it fragile and slow on
very large patch sets.

I'm hoping that this version resolves the downsides of the previous two
attempts by both being dumb and simple and by only requiring a simple one-time
setup (via the sendemail-validate hook) with no further changes to the usual
git-send-email workflow after that.

I've not yet widely promoted this, as patatt is a very new project, but I'm
hoping to start reaching out to people to trial it out in the next few weeks.

Thanks,
-K
