Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A130C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 17:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiLARpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiLARoa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 12:44:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D285BB7DA
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 09:44:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n16-20020a25da10000000b006f2b5bc99f9so2342460ybf.11
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 09:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ytvz3B1AiJdPYmQ4RaNRetPGldqbyzqdqD+UklzVy70=;
        b=aOPCWgFfQ1mWo6GZkEdJ0Vnd5ybBTr27716hbJcCnT6QBVlv/8NVU5cj13TdDprGKo
         Q8wY7XkinrvYk3ApilLT68K+qpULmFc/xqPwl6KxinePV+oMrpWRAC/SRbHtr0gD79Ft
         pI1KNGNCf5l0o+JdGcJAxcHmkuYoCNNdMJxHqZqTmmnVSKQkt3PJrmNejKwaXaU3Tszp
         EYCeHVqgXp41obcCdDEaO4swkMfPlOFPzh4Z/c0QdzokJqRsqqZ6qm/YdZhWCaaR42Mj
         1AxHuRqN+1BlFl1sddr9d5ITGjVcvT6GGOj0YnHIRn5SK9aeoqOjc4jRm4/zF52PJisr
         gW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ytvz3B1AiJdPYmQ4RaNRetPGldqbyzqdqD+UklzVy70=;
        b=2OcweFzzWyMN98mkYs2KqA5VE4YDRnW7VhAcIKP7iYkh4NxyBTK2LIp7bdL84L/XiA
         1OWqb0B9WOTjJHAvCDwf5hGdf3mfpGxsaGX3pZ072EmRtToxmsdDBzMgNQQlGYZWdLOY
         qzvTzQsIX4kN0TyyFy3kWlAATz8QvLtg9cB2auVwhuucg4Ur30urxZAhvo63Cq8M+7bK
         hR6vKXgVFmJDWjvh6L+y4zkGrLrVtCzWsQ2KZJSpVjfX5zzrceeIh4/BSYJ1Kq0iRHEW
         SWmRANAcLs7tXBEvdh9j+/y08oIEgikNfmAwOgJ8g4Sd1DZZxIJkCbqwzmnAK3bAs6B5
         uL0A==
X-Gm-Message-State: ANoB5pnfEw6akOYpsNnPepatbpFP9vwJUJsQVtr/2qzaLjUB1weeztPQ
        8fPaN3WdhPZMwpqKSIUBAyWL3efV1/NZhw==
X-Google-Smtp-Source: AA0mqf5mz2qbLoLyBd93JOD6Y3APfVA6ygrLKPLtKLRwnrb6pUZ+J0IlyVH5D/fu3DlrdKw5BLDqOFwjx4+KJg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:af04:0:b0:6de:9623:a2ec with SMTP id
 a4-20020a25af04000000b006de9623a2ecmr45586497ybh.496.1669916663527; Thu, 01
 Dec 2022 09:44:23 -0800 (PST)
Date:   Thu, 01 Dec 2022 09:44:21 -0800
In-Reply-To: <221130.864jugi59l.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <xmqqsfi22j67.fsf@gitster.g> <kl6lsfi1d1tf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqilix150o.fsf@gitster.g> <kl6lh6ygqphu.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221130.864jugi59l.gmgdl@evledraar.gmail.com>
Message-ID: <kl6la647ow7e.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: ab/remove--super-prefix and -rc0 (was What's cooking in git.git
 (Nov 2022, #07; Tue, 29))
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> For my part I was waiting to see what Junio would do with
> "ab/submodule-no-abspath", which is already in "next". Depending on
> whether it's ejected or not I'd need to re-roll
> "ab/remove--super-prefix" on top of a new "master", as it extends the
> tests it added.

Thanks for the status update!

> You noted in [1] that you strongly preferred seeing
> "ab/submodule-no-abspath" ejected. I think you're right that the output
> is a bit weird, but:
>
> A. I think it's mainly odd/unintuitive for the recursive cases, I think
>   outside of our own test suite absorbing repositories recursively
>   almost never happens.

Frankly, I find it odd in the non-recursive case too e.g. in one of the
non-recursive tests, we have:

  Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''../=
../.git/modules/sub1'\''

where all 3 paths are relative, the first two share the same base but
not the last one. I don't think a casual reader can easily tell that the
last one should be relative to the second one.

> B. I think it's an improvement in the output compared to the absolute
>    paths we have now, especially for the common case of non-recursive.

For the reason above, this doesn't feel like an improvement to me :/

> C. Changing it made it easier to test it, which is how it ended up as a
>    supposedly quick prerequisite for "ab/remove--super-prefix": It's
>    otherwise changing a test blindspot.

With abspaths, couldn't we test this with $PWD?

> D. As you note in [1] the data we'd need to pass around to make it
>    sensible (maybe it should always be consistent with "git mv -v"?)
>    would require passing more state around, some of which is tricky.

Yeah I think this a good to have in the long run, but let's punt on it
for now.

> I'd prefer to just have it graduate as-is, and build
> "ab/remove--super-prefix" on top. We can always further tweak the output
> later.
>
> But if you & Junio feel otherwise I think the best way forward would be
> to eject both topics, and I'd submit a re-rolled
> "ab/remove--super-prefix".

A re-rolled "ab/remove--super-prefix" makes sense to me. Sorry again for
not voicing my thoughts sooner and saving us from this churn :(

>
> Either would work as a way forward. Just let me know what you both
> prefer.
>
> 1. https://lore.kernel.org/git/kl6l7czmec10.fsf@chooglen-macbookpro.roam.=
corp.google.com/
