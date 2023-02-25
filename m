Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A769C64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 14:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBYOLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 09:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYOLb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 09:11:31 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB9C18AB2
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:11:29 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536b7ffdd34so56402477b3.6
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 06:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4aNn4wtBt5Yo3uBPlZZieH4hJI6nGbaLeFi7GAzbzk=;
        b=aMrC0CMHiqu/ehg8r/L+sfoVi01xqDBqhPwPvvWqfsLcXRR2SN1RFHCB6CdhE99Nt4
         hUrAbrHWDedhmEcpT84ExwLTLyJqOU9n1pzoL/Ct3sWSEgP8JQYXNSqFYrLJTMfP1kDH
         p2HI4nrXDwpF6Bm2iMgSLS+3UtLUFY3tj6k/d5iYT43gbapooDrpyHO8ztCs9vKlxSAx
         S55U3i7d3w6+LlxbgIvv111VhTtN0xyg2jTqWDL2B5vFimAIXRhrt/BEvtvJwok4cjCK
         fxpCT3H12jz6KyeMTvVv/nRr+A0U4PCMRXXRmWzaDDX+sbhFRjiZ2fmn9NSWppoliWl6
         xnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4aNn4wtBt5Yo3uBPlZZieH4hJI6nGbaLeFi7GAzbzk=;
        b=Kp2kJgweU7oxj41hDMM4n/9FA6suoeVIJUsZ6rXB4OrqRYhr5ilxodT3Mz+H8GCyIG
         B0MjzgoO/Z3djt6aSvHWoIh9xoaKE5Z24pVi4S1lk4fZ08wVApQ0Bn9NNr4D+1DqJMNd
         /hCYi+TtTFdhBH5UU8MndnMePGa3F/ZWaoQnuppVYOc4xJqv3PyU9tDxjy96N1+ywIs0
         K/A6qeSB320QUdRwPO2I8nfr2QbtVH25vcEryFPot0SG9YxNznufuEK/kw7knmF6C2XW
         fOQ8DFOh9C8eHwaoZX9cru4PRctxPltQOsWEzsU8OJtgSJo7O6v/6t8y87g3gvUvG0Dr
         w7Wg==
X-Gm-Message-State: AO0yUKXkxdiC1x/+AIXqCC7FJa2HqUrRIzbHcbb/scpr3kjXeTRkkl8r
        H/5BzsYutG+LyJfxzlgdyxacQV/mYPvOMw3eDXfaaBhGrvItQg==
X-Google-Smtp-Source: AK7set8fGZATshbYu7koqo4JsgQHmuuKtYRRSxq0rciNAFOD9afhxRZwK+Y0PWkvLhYFNkoY0xjfKjRQs5FWMkqIUpY=
X-Received: by 2002:a25:790d:0:b0:9f1:6c48:f95f with SMTP id
 u13-20020a25790d000000b009f16c48f95fmr4872863ybc.5.1677334289004; Sat, 25 Feb
 2023 06:11:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
 <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com> <966cb49c388b652861c773ad7430875bf7896c16.1675529298.git.gitgitgadget@gmail.com>
 <xmqqbkm64f3t.fsf@gitster.g> <CAOLTT8TxtysmA_Ug8-+XB02QLigQnp20eBgdCjHkdZHXidnCmQ@mail.gmail.com>
 <xmqq4jrb2dih.fsf@gitster.g>
In-Reply-To: <xmqq4jrb2dih.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 25 Feb 2023 22:11:17 +0800
Message-ID: <CAOLTT8SJGnCb0mkm120XRskyRmRHL_Yix17NyJhDcxMx8HvYiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [RFC] push: allow delete one level ref
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=85=AD 01:12=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > ... Therefore, generally speaking, it's better not to let users
> > create/update special one-level references.
>
> The question was "Is it that we are actively discouraging one-level
> refs like refs/stash, so removing is fine but once removed we do not
> allow creating or updating?"
>
> You could just have given a single word answer, Yes, then.
>
> > Certainly, I can remove the previous section as you requested.
>
> I didn't request to do anything to the change.  I asked you to
> explain why you allow only delete without create/update, and without
> knowing why, I didn't have enough information to make such a request.
>
> I think "we discourage a single-level refnames so allow deleting one
> that may have been created by mistake, but do not allow creation or
> deletion as before" does make sense.  As long as that is explained
> in the proposed log message and in the end-user facing documentation,
> I am happy with the new behaviour.
>

I understand. I didn't mention the reason for not allowing the
creation/update of one-level refs in the commit message, I will add it late=
r.

> Thanks.
