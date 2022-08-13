Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785D9C19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 11:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbiHMLFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiHMLFh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 07:05:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C4A1AF26
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 04:05:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j8so5873701ejx.9
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VLxRdHp0VF7zDfSBHumumPE/tV6FBgkqUmhk1fYaFak=;
        b=WsVYLNv2ob6lT3YRv/6bp601amHfzj9z9C7rhTxwogQyOqT3RS5/kTKodpHJg+MLLt
         d3pVRbsZT4sp+/CCaLtei71tg5EB6hClfoOR+K+jBFXLAp8DVkush1naEN57YpSTQJ3U
         DS5Zv4bbji5tihNh7xkC7WUSbIAmynuJdIrjDGV8FlWbb80UNuAISrQ5IXFbfPaFU5P3
         r1ygEp88vWGAHnZEyCFYF+zRYGCZgzn2Wx94pJmr82CWeeFDLz21SEUGFd2TZYSah7V1
         dF6q/rjkkozpcBLCA/5j2xPYLc0y7I6IG6wJYOMibk+68mjaZfPyJ53C6bTx3z5F6bJq
         sCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VLxRdHp0VF7zDfSBHumumPE/tV6FBgkqUmhk1fYaFak=;
        b=zPSdWkT7DlDn4MEd3WEAOWl1HLOiyLOzoXpZb64d6o6XOUuW4j8HK2/LJVJaMF8Leu
         uZkA3YkgtMbRZVtYPbu3woMjR1SzAA0GqyiST95EW9NeVkpSZK6tLOntE+2fEbMCOTlw
         15FA+XIOej5/Qm8lDl9fabQegDtZbIWVFvnKwtIYDBb9MGW2shWrnOjZCOZKVPcjaVcO
         U8q7eWElsW0MgJktlNPwKmkDmjCJgiqRqbStSwKgoQpRHKsQOrxDop696TGAnxq3waCf
         L34ZD1t2sXOxqzRKQye7sD/rl2oQcddzKwVq24AYQNKnlXjvEF0VlSW4/cG3FSX9BcOz
         iosA==
X-Gm-Message-State: ACgBeo3gYJF9RjEKaWgN+UT/+EZoFrMawhEZGUFGVopjzjntY1WoGIhz
        pND7Y+ZJZRca1nGWk/QsnIMT1/rpGWynbKQy36k=
X-Google-Smtp-Source: AA6agR6n2P+p7ezZ2+qC4L7S2KeoWw8EFtlDiqQF+y3c/ME393dN9RA3eLg75dibFdGErLwbMrvBiHDbWkrBKi+9b88=
X-Received: by 2002:a17:906:938a:b0:730:b3b5:54f4 with SMTP id
 l10-20020a170906938a00b00730b3b554f4mr5168284ejx.433.1660388733368; Sat, 13
 Aug 2022 04:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr> <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
 <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr> <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
 <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr> <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
 <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr> <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
 <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr> <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
In-Reply-To: <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Sat, 13 Aug 2022 16:35:22 +0530
Message-ID: <CAPOJW5yLQykokmg-MtQDwu69PtEWq+6BqiaHcP4AMn3f5E9WtQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 2:50 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Abhradeep,
>
> On Wed, 10 Aug 2022, Johannes Schindelin wrote:
>
> > On Tue, 9 Aug 2022, Abhradeep Chakraborty wrote:
> >
> > >  I noticed in the 'setup partial bitmaps' test case that if we comment
> > > out the line `git repack &&` , it runs successfully.
> > >
> > >     test_expect_success 'setup partial bitmaps' '
> > >         test_commit packed &&
> > >         # git repack &&
> > >         test_commit loose &&
> > >         git multi-pack-index write --bitmap 2>err &&
> > >         ...
> > >     '
> >
> > That's interesting. Are the `.bitmap` and `.midx` files updated as part of
> > that `repack`?
>
> I instrumented this, and saw that the `multi-pack-index` and
> `multi-pack-index*.bitmap` files were unchanged by the `git repack`
> invocation.
>
> Re-generating the MIDX bitmap forcefully after the repack seems to fix
> things over here:
>
> -- snip --
> diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
> index a95537e759b..564124bda27 100644
> --- a/t/lib-bitmap.sh
> +++ b/t/lib-bitmap.sh
> @@ -438,7 +438,10 @@ midx_bitmap_partial_tests () {
>
>         test_expect_success 'setup partial bitmaps' '
>                 test_commit packed &&
> +ls -l .git/objects/pack/ &&
>                 git repack &&
> +git multi-pack-index write --bitmap &&
> +ls -l .git/objects/pack/ &&
>                 test_commit loose &&
>                 git multi-pack-index write --bitmap 2>err &&
>                 test_path_is_file $midx &&
> -- snap --
>
> This suggests to me that the `multi-pack-index write --bitmap 2>err` call
> in this hunk might reuse a stale MIDX bitmap, and that _that_  might be
> the root cause of this breakage.
>
> What do you think?

Hi Dscho,
I used your code to see if it is the case but it doesn't affect the
result (at least in my laptop).
