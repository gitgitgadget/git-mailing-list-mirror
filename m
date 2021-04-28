Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1278BC433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 18:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB2361412
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 18:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbhD1STw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbhD1STv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 14:19:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA9C061573
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 11:19:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s15so75458276edd.4
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCtPhA2dA6OeAQEoIQIy24DEU837SwolI1om30eiMgM=;
        b=PwMUW2+VRLZwGaHs/ZQJ7x/m5TkKcnpwkZStWPjhf+vKIvidgS4NjhIphdiAnmXQjp
         AiyD1rasj49YE2Xs5xGZIm5xJQAQ75GyJVc6XMcLeZsygIe5zFWqobw5wo52FjkEXJUq
         HIwARcYpk96HCXbrl1z1Oo/3dG7bsVMghrEHBJ9hn9roItJ3Xfzx1wPLi128OGUHqFhk
         6oS2Zi3oL1xmRnuDdBFSzQUFCYsNJ0zXeUq67gXEwpn2wch9UUic5uYdsSjTTF7ZAsEw
         uCkfjdqtBx98DSJIWHCIc3TKCCFj4EAtu5e4iFiyZkck1i4u31/EEDe/aBJHplUCWCcW
         gR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCtPhA2dA6OeAQEoIQIy24DEU837SwolI1om30eiMgM=;
        b=MMmiaryMe6kDlIkYpH/V8GLxvt7RGf5pc5f/qwZhXmwu84OiAhH9nlHLRge2Weg73p
         8EEJh+HqozmRS8zuKtSC1VW9pEOWrNdakWh3rym2ostqvE47KYU25yNkx5UNLtXGpaKQ
         y1TsJAV7gDd+zcX0Zy+CBBGamgpBCxhmDnAwOmuwFn5yjxrs8KeiyrWEe4YRgmB5rR1m
         NrEs94Fwb52NN7rYxJJKgWTloy5hJF21tzt7SSQf/RmaYKJYfrHXhjJkhpzp8j/vYzUB
         jEprk6KaGKiNJB95REp/XlPKXAecArrTgM/bFTf19FsT1omv7aUoxyqZDmaWQlkcAxqC
         qHRg==
X-Gm-Message-State: AOAM5301FPwpoYx7GXxgcL7l72RsEXMiuCogvDkVsqG/X4dkUIwoEQic
        HjKYgFQFXxfJ2WmPA4DW7oyEcKir2oZkw1tvFonJnw==
X-Google-Smtp-Source: ABdhPJwl2lNI0cPruMyXsWHAuDbjRDwgFo74mpw0EtvcKAnt2SjCFwcyq+mGlsEYb4E/3HeVbNLph5E9wxQ3yd3IceA=
X-Received: by 2002:a05:6402:11cb:: with SMTP id j11mr13584347edw.282.1619633943218;
 Wed, 28 Apr 2021 11:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210427194106.14500-1-jerry@skydio.com> <xmqq35vac0vq.fsf@gitster.g>
 <xmqqsg3aahw7.fsf@gitster.g>
In-Reply-To: <xmqqsg3aahw7.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Wed, 28 Apr 2021 11:18:52 -0700
Message-ID: <CAMKO5CutTaW51GkkM_+viES3UbrOKA6VN1nOWNK+poRkxiO-sg@mail.gmail.com>
Subject: Re: [PATCH] git-apply: add --quiet flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 2:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Jerry Zhang <jerry@skydio.com> writes:
> >
> >> Replace OPT_VERBOSE with OPT_VERBOSITY.
> >
> > While it is not an incorrect statement, it is odd to have such an
> > implementation detail nobody cares as the first thing in the log
> > message, though.
> >
> >> This adds a --quiet flag to "git apply" so
> >> the user can turn down the verbosity.
> >
> > Sure, I think you can do "apply --no-verbose" to do the same thing
> > without any change, but we introduced VERBOSITY to replace VERBOSE
> > exactly so that --verbose can be countermanded with --quiet, and
> > this patch is a good example of the application of that feature.
> >
> > I wonder if this deserves a test.
>
> Oh, another thing.  "--quiet" with OPT_VERBOSITY is given negative
> values, whose magnitude may be used to express "even more quiet".
> This is different from "--no-verbose" that is supported by both
> OPT_VERBOSITY and OPT_VERBOSE that resets the variable to 0.
Ok I didn't realize every flag automatically came with a "no" version but
--quiet is indeed what I'm looking for since I want to silence the status
messages but still print out really critical errors.
>
> So use of OPT_VERBOSITY() to support both --verbose and --quiet is
> good, but you'd need to audit the way the verbosity variable is used
> by the code.  "if (verbose) perform_verbosely()" would have to be
> rewritten as "if (verbose > verbosity_level) perform_verbosely()"
> or something like that, as the "verbose" variable can take a
> negative value to mean "less silent than the usual 0".
Yeah luckily apply.c uses verbosity correctly and consistently
throughout.

> Also, does "git am" have an "--quiet" option (or "--verbose" for
> that matter), and if so, should it pass it down to underlying "git
> apply" (this is not a rhetorical suggestion --- it is a genuine
> question---I am not particularly interested in changing "am")?
am seems to have --quiet but not --verbose. In addition am does
not seem to pass through those options into apply.c. I tested this
using a patch that has whitespace errors and "git am" prints
warning regardless of whether "--quiet" is used. However, interestingly
"git am --3way" does not print warnings, due to these lines:

       /*
        * If we are allowed to fall back on 3-way merge, don't give false
        * errors during the initial attempt.
        */
       if (state->threeway && !index_file)
               apply_state.apply_verbosity = verbosity_silent;

Which no longer are relevant due to the previous changes making 3way
happen first. So in conclusion I think it might be worthwhile to make
the verbosity flags of "am" pass down to "apply", although it would be
out of the scope of this change.
