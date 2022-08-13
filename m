Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A13C19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 10:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiHMK7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 06:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMK7q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 06:59:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F88966A68
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 03:59:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id tl27so5889404ejc.1
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oAame8GWQUl4qHzOmY3rB7qsPnGHAUnMw69bGSymlAY=;
        b=kZ4eGRsv1h5Ew0cwa6KacY/6pEmp1WosKgW8Fkx0FAR7Mj7w5FMh9Gc6aK/Kxbv2sr
         2ZfeCgEPI7fE8oxlXrjx4R3aiMjvIX1NZrkLzrPmAri1HVJUhwfXHmE6Tkvfi8zuGDge
         3MiJ/9PwmQKv5UsCINtNDLUnOrFZ4IKRmzLRVlkqhACqVWxscOCBF2iF+d5Wff/39s3U
         sy1wpppMdfrX/LMrzKF3ed8mYMLPx7JPHh+AbYZNdVikBt+vBSlw8e9gdAx25Y8wesYd
         4axISr8UOIBMKa2t55J19XGbDkfapl72MMeQyJLPK4l6JKB4wfG+nHWRrBhjuIC6GZA+
         erdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oAame8GWQUl4qHzOmY3rB7qsPnGHAUnMw69bGSymlAY=;
        b=3VFGV5NENzAT8w1F7D83ZHPOLZZzEbAEUELRyFN4EI9JKGXqj/iaM4uELAbxQ2yc4b
         hhDrVe2klJ1QBdomQ+aU+ZuYOEZjM71F0qTXT1zZN7fBXLpd5WPUGeWk1B/kc1xRfocD
         4xmtGQ4AoWlxz7pWXG7DdcqgrFz7WLyaiKfW8EJ6assCwfjWm8JkB8qsvW12TRSu7hb/
         Fylkqy9wAsr9ngH+XzlI5DxQbPGw4fB3egspdU88HWV32bSx7Ix07KFXdQws3QiVwlkg
         il4oBENddCiVdnN6ul0cjqPwPOeKMqSZaVVqs2ejv+GUp/phW8uLjNxavkIzlF4tWX5o
         bMbw==
X-Gm-Message-State: ACgBeo3kSOZc5nNmDbMxhusiXWD124YmzToZCaD3tDZBqwjkw1vj309P
        sKPW32irLgVmj999xbabgt+Ffgc5Es2JSke0eHI=
X-Google-Smtp-Source: AA6agR5hyiL3CbM7oUUC93+ureTS1BskCXViGigLsLwk58muaILtkEELj5rHH2RiFrGJbdHf3blIPsrNrKuYy2r6Mbs=
X-Received: by 2002:a17:907:c0e:b0:731:614:e507 with SMTP id
 ga14-20020a1709070c0e00b007310614e507mr5245973ejc.529.1660388383422; Sat, 13
 Aug 2022 03:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr> <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
 <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr> <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
 <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr> <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
 <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr> <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
 <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr> <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
 <CAPOJW5w2NYbRkFOaqrNYVFkp5ud=aAxhGGV6gpdDPwnyx5TAVw@mail.gmail.com>
 <805fb0df-45ab-7edd-8787-662b84201e2b@github.com> <CAPOJW5x0coFREUPjFbF_zzQYbfEjOrL-j-G4N7MBUN4N6uS2jw@mail.gmail.com>
 <179c0d30-ccb1-36cf-f783-814c9c8d84c2@github.com>
In-Reply-To: <179c0d30-ccb1-36cf-f783-814c9c8d84c2@github.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Sat, 13 Aug 2022 16:29:32 +0530
Message-ID: <CAPOJW5z99b0_NGBYDbZUvmzbWECJKxGvB4RffoPJYszfFB0cEg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 13, 2022 at 12:52 AM Derrick Stolee
<derrickstolee@github.com> wrote:
>
> So really, the problem is that we are handling the r->objects->packed_git
> list instead of an array of packs that are under the control of the new
> midx. This assumption is baked deep in the pack-objects flow, so it
> would be hard to separate this idea.
>
> Perhaps doing the reprepare_packed_git() to regenerate the list would be
> sufficient as a band-aid for now, but we would want to later do the big
> dig of focusing the pack_data struct to a specific list of pack-files
> (by default the set from get_all_packs(), but for midx bitmaps we can
> supply a specific set of packs).

`reprepare_packed_git()` can not stop it. Because this function
updates `r->objects->packed_git` list (i.e. it reloads packs that are
not in the old midx) and as I said before, we are setting `->index`
for only r->objects->packed_git not ctx.info[id].p. So, it will call
the `oe_map_new_pack()` function in either way.  I have tested it.

One thing that really worries me is what if the failure is not related
to calling `oe_map_new_pack()? I did all my work assuming that this
function is the culprit. But I don't know if it is.
