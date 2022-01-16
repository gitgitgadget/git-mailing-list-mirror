Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E573C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 01:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiAPBDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 20:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiAPBDh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 20:03:37 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C347C061574
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 17:03:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a18so49340883edj.7
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 17:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4OOoz5QQ7c0VM5DCN1wNZCWhcqyyltp4lxuB6c6defk=;
        b=ZTVY4jy/G5XVJWN6S/N0NIYmhmgxPeoAOrwKi287gk+aDtVQCvklQA8thJOCTeKbUR
         vxvRaZb55rBme3CBjSl9lduch1yzONmL1uKJrzznQMfloDjQd2K+DrqOD2UCBXSbKnUN
         q8+6lovq6+BEuQpVm1zUTWaSt5w8V5gg6yuIT4aeoXRkX2LXXqZLfbsaeH8boWWQnOZK
         1HiYuFeJqKXFEoXkoyJC1waTskzISJzEqTgVYpiJvFHNWtA7QrqXD36dDX99IzVpwHKQ
         USIte+VGQa6WNlgGcdZ7k4wIyjEZSXJ2aTWSqr7tH5BvN95fRhTEcyWurmqWRtnkFYNQ
         1Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4OOoz5QQ7c0VM5DCN1wNZCWhcqyyltp4lxuB6c6defk=;
        b=mIy8a0gG457M3mwiGYFQP9AAlhPrt/QntD9SREK3Ce8owVlJu9JoTPQcTCWS614fYH
         6IY3Lfnwlz8tPigNJzcJ32VEKZiZ06W6eBT3l8BqBh0EYH50cesehkTY1iSbRXzwzCAB
         T6mHShuss+WcgA6kEU2AZJMhp7/T7H709ATrWDKD/JcJmQLXAHoFLb6mpzs0GuS6RwDV
         tjKGlrV5SwpxBNQEAdPAntm/SRgxUx/wobqn2q+VDctow+B8nP0HCPlEQI/LzSTT5FM7
         xIqfvQ8QbBU+r82DkjdpTc5tDjl01grX2BC3ST9oPP27TVIs3ga5qWCXbtHq3g3SzNud
         EU9g==
X-Gm-Message-State: AOAM533+z62c7xkQFKLTN00D0u8tVP7LbA/XVteRTx26rjhrZdG50G00
        zqrGuq7082YbTHTc9/BbdkZpaL1WS85UW74L1co=
X-Google-Smtp-Source: ABdhPJxtznhC+WekDciE0Ygp+12Em8sAu+nH1tKoSov9BovbuLNxz4gP9/DBXESABaVSpfnbtUzaJI9IU4eWQJg0JuI=
X-Received: by 2002:a05:6402:2752:: with SMTP id z18mr15334769edd.153.1642295015596;
 Sat, 15 Jan 2022 17:03:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com> <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev>
In-Reply-To: <20220115095725.GA1738@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Jan 2022 17:03:24 -0800
Message-ID: <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 15, 2022 at 1:57 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Mon, Jan 10, 2022 at 06:59:51PM +0000, Lessley Dennington via GitGitGa=
dget wrote:
> > Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
>
> None of these patches touch sparse-checkout, but only the completion
> script and its tests.  Therefore "completion:" would be a better
> matching area prefix.

Thanks for the detailed feedback and guidance in your review.  Very
helpful.  I'll omit quoting most of it here, but I do want to comment
on the point about directories.

...
> > 4. A list of directories (but not files) is provided when users enter g=
it
> > sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
>
> Why limit completion only to directories?  Both of those subcommands
> accept files,

Discussed in part at [1], but let me give a more detailed answer.

Both of these commands accept not only directories and files, but also
nearly arbitrary input as far as I can tell.  (In cone-mode, it'll
accept anything so long as it doesn't look like a relative path that
tries to reach above the toplevel directory with '../' sequences.  In
non-cone mode, I think it accepts completely arbitrary input).  If our
guide is merely what the command swallows, then we should forgo
completion for these subcommands, because it's not possible to
enumerate all possible completions.  I don't think that's a useful
guide or starting point, so we instead need to discuss what are
reasonable completions.

cone-mode works exclusively on directories.  So, in that mode,
directories are what we want to complete on.  (And if a file is
specified, cone-mode will treat it as a directory and add expressions
for including all the files under that "directory", which might be
confusing.  sparse-checkout doesn't verify it is a diretory, because
it *might* name a directory in a different branch, including one not
yet downloaded.  But "might name a directory on another branch" is no
reason to suggest picking that pathname with completion.)

In non-cone mode, arbitrary expressions are valid and will be treated
as gitignore-style expressions.  That again leaves us with either not
providing completions, or choosing a subset of possible inputs that
are reasonable suggestions for users.  I prefer the latter, and in
particular I feel that directories are reasonable suggestions.  In
contrast, I don't think providing files is helpful, because it
reinforces the design flaw of non-cone mode.  Non-cone mode has
quadratic performance baked into its design, and since
sparse-checkouts are about performance, non-cone mode kind of defeats
the purpose of the command.  (In addition to other problems[2].)  So,
I think non-cone mode should be deprecated and excised.  Patches
elsewhere are moving in the direction of deprecation already[3], and
we've already discussed multiple steps we'll likely take soon
continuing in that direction.  In the meantime, providing just
directories for completion seems like a good direction to me.

[1] https://lore.kernel.org/git/CABPp-BG=3Dwr81CPtW1M12xFN_0dyS8mAZjM6o=3D7=
7LA20Zge8Xng@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BF=3D-1aZd=3DnFHF6spo7Ksa7f7Wb7ervCt0=
QvtNitMY=3DZBA@mail.gmail.com/
[3] https://lore.kernel.org/git/0af00779128e594aff0ee4ec5378addeac8e88a2.16=
42175983.git.gitgitgadget@gmail.com/
("This mode is harder to use and less performant, and is thus not
recommended.")

> and I think 'git sparse-checkout set README.md' is a
> perfectly reasonable command.

Reasonable in what sense?  That it makes it (vastly) easier to
implement the completion and sparse-checkout set|add will swallow it,
or that it's something that should actually be recommended for users
doing sparse-checkouts?  While the former certainly holds, I don't
think the latter does.
