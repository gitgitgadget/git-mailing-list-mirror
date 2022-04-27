Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350CFC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 20:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiD0VDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiD0VC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 17:02:59 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08104DEE
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:59:46 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id x9so1477158vke.4
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnnQbQLMN60oW+qJxohrDkYZYktNC5/774K5CsWiXlY=;
        b=PNv8GftSQbcchS8HDKb0nY9DXxWtUTfUwK8J6u16lYP9qqxRkrUprWiFCkp4yLVcjJ
         cnXc8cdLvPU5mBK0jcAd0U1ITfiS3dm3E09iLNs4ZOmfrd714ua0KtqLw5ottA1gbmK2
         r9TNxBHSKNI3o5NhzIpg83vooWDzv7Fgt4t7LdN9/IgIjXkVDGMvb6dGIM9h+7mwrTHG
         un4/tvlhnliSvHC9sZ8AEYwObApEZTgg5+ViTzZeYRtzRvkvv+ybK4rrcrxjWUyeQQpm
         jzpAj4qZBijm7GK1mkv50y6gnnIwBO3W54F8tYPKLzjWGGN3a2v1p+Cbza8N8sgShA+h
         A1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnnQbQLMN60oW+qJxohrDkYZYktNC5/774K5CsWiXlY=;
        b=Qcp5HYpoJj6Jsx6v4nbanRmbtYYYOIkiLqDNEUdCa5qlACdC7nXy/PkCGzQ0VGJT+i
         8e/xoIWA4vp9ZXfigQPmB0uLGmmrFdomBg8K5aUzoLabFhEZ5s+wbMgDbnzhYBi+ZjYA
         3aPyfUvdTcGYW9rpAAaN0bnUR62uiUVhMcKvG04etbJOT6SyhblzlFx9W/9JBRS+hNl8
         Ug5Heew10lukc4GFyPeICDRDaCVzW0c49QkICJcthGAMkI4yIWgSCO0ZMx8NkJMls8J+
         g4z9XKKtOgg24hHTnliVms9mlKFkrRzQHjS7eLn1VGxhLSpT3eP/P20FfnFODgMflPmV
         LvCQ==
X-Gm-Message-State: AOAM532X4gu4CD7zexa+i4Iq+rm+h6gBRPHcB1Yx2djkVBLZgTys5KX4
        /5eSsKtYIuioGJf+FzptzuGD/vWUWYe/1Xqo4FU=
X-Google-Smtp-Source: ABdhPJyu0/L2uDIrUx8mrFiPS+4aThjDcYMGU41d2+W4aCwz20XbIySpsxGm5iaq6X+dGxnz2k+VLM1GCbDgA8CK9wc=
X-Received: by 2002:a05:6122:984:b0:34d:8cc5:43d8 with SMTP id
 g4-20020a056122098400b0034d8cc543d8mr5773035vkd.39.1651093184965; Wed, 27 Apr
 2022 13:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com>
 <CAPUEspiHWTTAvNyqqLzcC854UccH=bkPLPBzPaPfzFKn_yt4aA@mail.gmail.com>
 <b0a80f47-f441-fc6e-3695-58ea83dea2b8@gmail.com> <xmqqzgk6l5ly.fsf@gitster.g>
In-Reply-To: <xmqqzgk6l5ly.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 13:59:33 -0700
Message-ID: <CAPUEsph9tUkm+JsvU6z0Wt7mtRcTCH1vbvYTEdWjNyXzdoU=vw@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        philipoakley@iee.email, me@ttaylorr.com, guy.j@maurel.de,
        szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        derrickstolee@github.com, Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:

> The "sudo sh to get a shell, chdir to /var/tmp/foo to do something"
> use case does care---it needs to make sure that whereever it goes is
> not part of a hostile repository.  So "if SUDO_UID is there, anything
> goes" is not a good protection for such a use case.

FWIW that was never part of the proposal, indeed making git aware of
SUDO_ID when it is running as only as root was part of the design to
avoid other users probably allowing repositories they don't control by
having an evil SUDO_ID.

as per the root user, I was expecting that he could be trusted more
and that wouldn't accidentally get an evil SUDO_ID on their session
because it is something that gets generated from their original
account and they should be aware of it and even might need to tweak it
(ex: by un setting it if it gets in the way).

To make the `sudo make install` use case possible I think it make
sense to trust SUDO_ID by default, but I would be open to add a
configuration setting that would be required to enable it (it indeed
might become useful for root users that might want to disable it as an
alternative to unset SUDO_ID).

> Possible?  Yes.  Practical?  I dunno.  Especially if we do not
> deliberately truncate by reading into int16_t but use "int" (32-bit
> almost everywhere we care about) or "long".  Now how likely is uid_t
> narrower than long?  If it is not likely, then we probably are OK to
> use long and not worry about the truncation at all.  Or use strtoll()
> to make it even less likely.

strtoll (or my suggested alternative of strtoimax) suffer from
portability issues which are handled later in the git-compat-util.h
file, so while I think it is worth doing, I would prefer doing so
later as part of moving this code into a proper compat module.

for this iteration, the suggestion by Phillip to use strtoul makes
more sense (specially after confirmation by Randall that it works in
NON-STOP), it is more portable and doesn't require later in the file
git-compat magic to work, it allows for the full range of 32bit that
might be needed in 32bit *NIX, it is should fit find even in 32bit
environments with a 32bit unsigned uid_t (which is fairly common), it
doesn't sign extend if applied into a wider uid_t and would be likely
able to be assigned even without a cast and without the risk of
truncation for most uid_t types.  Lastly, since now this code is
focused only in sudo compatibility, and sudo casts their uid to an
unsigned int and prints it into that variable with "%u" it is the
right "API".

For comparison, I would also think it is better to let the compiler
warn if needed so at least the users would know their uid_t type is
narrower than what we expect and sudo sets, and might work as a
weather balloon to find those systems.

>
> So, in short, I think it is reasonable if we did:
>
>  - do the extra "if SUDO_UID exists, then..." only when we are root.

already in since the RFC, see discussion above for an option to
tighten it further if really needed, but even in that case I would
rather do it in the next iteration.

>  - use strtol to ensure SUDO_UID is in good shape (all digits) and
>    read into long; use errno=0 trick to notice overflows.  err on
>    the safe side and do not allow if the value cannot be read
>    correctly.

already implemented as part of v2, except it is using strtoul/unsigned long.
also in the line of "err on the safe side" I was also discarding any values
that would overflow an uid_t (which is assumed to be unsigned), which
affect the next bullet point.

>  - do the comparison between st.st_uid and strtol() result by
>    casting both to (long).  Without this, st.st_uid has a value that
>    needs wider than long, we cannot allow the owner of such a
>    repository in (and I somehow feel that is unlikely to happen).

do you still want to cast both sides even if discarding values that would
overflow an uid_t?

FWIW, as Phillip reported, using long (or another signed type) would
restrict the valid ids in 32-bit *NIX to half of what the expected uint32_t
range most of them should have.

>  - or omit the third one --- tough luck for those whose UID is
>    beyond what a long can represent (and I somehow feel that this is
>    probably OK).

That was what I proposed in the current RFC (at least in 32bit *NIX)
but I have to admit that i'd seen a lot more issues with uid larger than
INT_MAX that I expected when doing google for it, so that is what I
thought it would be safer to use the full 32-bit and an unsigned type
instead.

> Another thing I'd suggest doing is to have a helper function to do
> the "we do a bit more than geteuid() to come up with the allowed
> owner of repositories we encounter", and call that function instead
> of geteuid().

I did this originally, but discarded it quickly because it was a
little odd and easy to reuse, for something that I was hoping wouldn't
stay in git-compat for too long.

The use of the current helper function covers that use case but is by
design harder to reuse while keeping the overall logic of the 2
combined functions more visible.

Once we move this code into a proper compat module, I would be happy
to add a geteuid_or_sudo() function but that would be probably after
we also fix doas.

Carlo
