Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B111C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD1561947
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCUM1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCUM1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 08:27:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574F1C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 05:27:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j3so16015171edp.11
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=M6l5zDl/awMI9qw0BB+J46Pzo3oQjOTdVRTXBVZYfck=;
        b=MY2hMi7l7lCeyjncusPmRkFughVjUNk3jc3TCzFoM/zwWMVY4buSiJfbm8nQ2DvMYn
         9Kcc70WybSF88G3QALk1NMMRTvWrU3NZes3y5NL0HHdNsnfG9VW06o8fG5Zx9y/La9zA
         aNL8pnn9fS6TU2NiDjrn0iHZPYMBDAyRJrpNSK1S4/8sEkRKyBvkEEOnLCEAxQCE+TzD
         TdfRL43qwheE39mCauGA+Hh8aJrXedqnomI+MwhdzW0ig+uAE5lY/YzG4BpY09iSkwFs
         rWWRMpdXoxKvWC6Te07DQZB6JjXPZtRfRpgG0xBdA6fpp5fxibnu35rIIXuut+cKS81k
         ZfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=M6l5zDl/awMI9qw0BB+J46Pzo3oQjOTdVRTXBVZYfck=;
        b=Em+bWeBOr59PFdDPq+WHS8eTU+Sh5r2tJsJMykBEW1QLlIt3DEJ9/rxrD9VZSrkGKo
         7wW7msB6+PwxmXvpMlZEmIc1eDrfUMw/AOxXpDifyn4PhMfWs3Q1A2zsBkM+Q7CZV+DG
         xTNPOFzbc2s3tQjvkMIhRJVyiFT0QISk2hDPiNsmHMTQeTFKuSI4r6if73Y1NXPz+8HW
         jsoRBkoqt9oB27sN4xr8RiuIy9/MXfVhujfvJ87KkR+paYasAmv1A1tXOw61nAY2V92U
         ruNjqoKyCLAy4D0YxBfgHoWSSfH1j4DOZeMvNoFpXKVHsmIfjGCBHboRmpLboIJv0Atp
         3h8g==
X-Gm-Message-State: AOAM532l7yr9C4E7tOMpZco/9SM1Nof0D9Abr2FCk2ulhoo0FNBmtR77
        hTCauNI2wauy8y3QV5Eq4Z4=
X-Google-Smtp-Source: ABdhPJyEwdogrAK0COz9gbaMfHYQ56gkc0BNTgm3wZE8K1KSHZhbBaCnkzu9A6xzogrCVpC7QCfCLA==
X-Received: by 2002:aa7:dbd3:: with SMTP id v19mr20086229edt.314.1616329618886;
        Sun, 21 Mar 2021 05:26:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p24sm8096852edt.5.2021.03.21.05.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:26:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 00/29] tree-walk: mostly replace "mode" with "enum
 object_type"
References: <20210316155829.31242-1-avarab@gmail.com>
 <cover.1616282533.git.avarab@gmail.com> <xmqqtup5cnlu.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqtup5cnlu.fsf@gitster.g>
Date:   Sun, 21 Mar 2021 13:26:57 +0100
Message-ID: <87wnu0r8tq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 21 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> A re-roll of v3 of this series[1] and on top of (and requires) my
>> just-submitted v5 re-roll of the read_tree() refactoring series[2].
>>
>> There was a regression in 1/32 of the old series. Removing the
>> canon_mode() call in diff.c didn't account for us needing to
>> canonicalize "diff --no-index" modes. There were no tests for this,
>> and it failed or not depending on the FS modes in the git.git checkout
>> being tested. This fixes the CI smoke coming from this series.
>
> Sorry, but quite honestly, I am not quite sure what value this
> entire code churn is trying to add to the codebase.
>
> The function signature of read_tree_fn_t callback function gets
> changed from the mode bits (which is capable to express differences
> between regular files, executable files and symbolic links) to "enum
> object_type" (which can only say "this is a blob"), which is a
> regression, no?=20=20
>
> A callback can no longer do things like this, for example:
>
> static int add_path_to_index(const struct object_id *oid,
> 			     struct strbuf *base, const char *path,
> 			     unsigned int mode, void *context)
> {
> 	struct index_state *istate =3D (struct index_state *)context;
> 	struct cache_entry *ce;
> 	size_t len =3D base->len;
>
> 	if (S_ISDIR(mode))
> 		return READ_TREE_RECURSIVE;
>
> 	strbuf_addstr(base, path);
>
> 	ce =3D make_cache_entry(istate, mode, oid, base->buf, 0, 0);
> 	ce->ce_flags |=3D CE_SKIP_WORKTREE;
> 	set_index_entry(istate, istate->cache_nr++, ce);
>
> 	strbuf_setlen(base, len);
> 	return 0;
> }
>
> where executableness or symlinkshood is lost.

Yes, that would be a serious regression. I agree that all these
functions/callbacks etc. should have a way to get at the mode bits.

I'm adding "enum object_type", not removing the "mode" parameter in
read_tree_fn_t. This function (which is in "seen" as 03316f20347
(sparse-index: implement ensure_full_index(), 2021-03-16)) works just
fine in combination with this series.

The other APIs modified here all retain the ability to give you the mode
bit, they (the tree-walk.h changes) just optionally give you the option
of getting just the type (or just the path), and as it turns out most
users of the API can be converted over to that.

> This probably is the third time I caught similar "let's lose
> information passed through the call chain as nobody seems to need
> it" mistakes in the iterations of this series, and that is two times
> too many.  We should learn from our earlier mistakes---tweaking of
> the API that happens to be still OK with the current codebase can be
> either a needless churn that loses useful expressiveness from the
> API, or a useful clean-up to kill dead parameter or excess
> flexibility.
>
> And these three incidents we have seen so far are the former.

The current codebase will allow you to stick arbitrary mode bits in
trees, we have an fsck check to prevent that which doesn't work. I had a
summary of this in v1, but should probably have provided a recap[1].

This series is an admittedly long journey towards fixing that. I've got
unsubmitted patchen on top that make that fsck check work again.

I think the root cause of these bugs and other ones I've found along the
way (some of which I'm not quite comfortable discussing the details of
on the public list yet) is that the tree walking API is unnecessarily
low-level for most callers.

Most of those callers don't care about the details of the mode bits, but
are just traversing a tree and doing something with one the object
types.

As opposed to having a mode, but do you want a mode as-is from a tree,
normalized to canon_mode() (for writing?) etc. I think being able to
clearly tell apart those callers from the simpler ones is a clear win.

So I'm hoping you'll bear with me & this series, sorry about the
breakages so far, in my slight defense they were all subtle testing
blind spots (but we now have tests!).

1. https://lore.kernel.org/git/20210308150650.18626-1-avarab@gmail.com/
