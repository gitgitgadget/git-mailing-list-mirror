Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FF8C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 10:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiHJKFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 06:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHJKFA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 06:05:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725106DF85
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 03:04:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a89so18412777edf.5
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 03:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ct0zPM4fHrnckeV5YIAyM97ais4kT1FRxRzfH73hwzE=;
        b=YLobm12nAlU1mwxCUVb1r43c6OARuqQttzyvHnugEdmpZLWn4ILXSRGh3EIm9mNt/n
         fWZHa3mlK5P0fDJPtfMe8VAduJ2/r6/SFSmqYF4dY7DR0MfRZs3WOvud6/Vzd44t7r4A
         LfpG0NkJoYuIR3+Umc8cATkGA6dxdTyS/tLnD/Vzy+O+FsNSEzCuNUvs8Yly8kZRDg3t
         O0VWns6OAsq1+LnchmbzKMs5P0NXbv+oFWMfxCUWjGIYqcP5cfJp6zY7aIkVBdsedHqJ
         kw6lYtsrBttMVdI3n1yCsS7wCSs2Q886xiNehmnb9y9Bbj4ualVrWQQol18761NzESDh
         zfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ct0zPM4fHrnckeV5YIAyM97ais4kT1FRxRzfH73hwzE=;
        b=XMJk8gKXY+8QVRD5GmvwlFrBjy8Wi9fQqydvOGZSWjrmBXD1PfQntYsOjIWRM+6Uy7
         Ecjp+/jTeuMUFi/EwvIjljqVZnoPRWXBpHdvPc0dq6UDSArvIcRW9y7N9UN4jfzTn+oh
         iqXNnIZM9/8xjgs7Mf0eHd8pTjLB0tBv+hn8NoqoW7irryma3/7S7SL4swCWcG/m2T6U
         4+Aa+ZU90osjfkcFgMjLQIkNSFGRMqkesMGqrtNxZ8+Z8qKY5j8LYAHtPUDQ7zUwehMx
         C1lMStqTKcOyryWHS7CBzFn+NKtfUBdU0EJTobTXb5lVftyzcGLM2Ukt3CMlERe9ezmq
         aWMQ==
X-Gm-Message-State: ACgBeo1Q6jLu39f7BsteOVv/5P/Pha/+vyvLf10vrO17cgMwCTP0/3Nv
        BC183JBNd+eY1pxeVy7Gro12mk52pD7+KRQKR4w=
X-Google-Smtp-Source: AA6agR5uVA1SOnB7lvvAQunfipYeScACWy5x72/saD2sIF+uJ0+Plou8THwioIAuIKnV+UTlEMJ/ilZw+SmefRipu7A=
X-Received: by 2002:aa7:dc10:0:b0:440:b446:c0cc with SMTP id
 b16-20020aa7dc10000000b00440b446c0ccmr11904089edu.34.1660125897832; Wed, 10
 Aug 2022 03:04:57 -0700 (PDT)
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
Date:   Wed, 10 Aug 2022 15:34:46 +0530
Message-ID: <CAPOJW5w2NYbRkFOaqrNYVFkp5ud=aAxhGGV6gpdDPwnyx5TAVw@mail.gmail.com>
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
> I instrumented this, and saw that the `multi-pack-index` and
> `multi-pack-index*.bitmap` files were unchanged by the `git repack`
> invocation.

Yeah, those two files remain unchanged here.

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

Yeah, the `multi-pack-index write --bitmap 2>err` is creating the
problem. More specifically the `multi-pack-index write` part. As you
can see in my previous  comment (if you get the comment), I shared a
screenshot there which pointed out that the multi-pack-index files in
both cases are different. The portion from which it started to differ
belongs to the `RIDX` chunk.

So, I used some debug lines in `midx_pack_order()` function[1] and
found that the objects are sorted differently in those cases (i.e.
passing case and failing case). For passing case, the RIDX chunk
contents are like below -

pack_order = [ 1, 36, 11, 6, 18, 3, 19, 12, 5, 31, 27, 23, 29, 8, 38,
22, 9, 15, 14, 24, 37, 28, 7, 39, 10, 34, 26, 4, 30, 33, 2, 35, 17,
32, 0, 21, 16, 25, 13, 40, 20,]

And in the failing case, this is -

pack_order = [ 12, 18, 3, 19, 1, 36, 11, 6, 5, 31, 27, 23, 29, 8, 38,
22, 9, 15, 14, 24, 37, 28, 7, 39, 10, 34, 26, 4, 30, 33, 2, 35, 17,
32, 0, 21, 16, 25, 13, 40, 20,]

I went further and realized that this is due to the line[2] -

    if (!e->preferred)
        data[i].pack |= (1U << 31);

I.e. 4- 5 `pack_midx_entry` objects have different `preferred` values
in those cases. For example,
"46193a971f5045cb3ca6022957541f9ccddfbfe78591d8506e2d952f8113059b"
(with pack order 12) is `preferred` in failing case (that's why it is
in the first position) and the same is `not preferred` in the passing
case.

It may be because of reusing a stale midx bitmap (as you said). But I
am not sure. Just to ensure myself, I compared all the other
packfiles, idx files and a pack `.bitmap` file (which you can see
using ls command) of failing and passing cases and found that they are
the same.

Thanks :)

[1] https://github.com/git/git/blob/c50926e1f48891e2671e1830dbcd2912a4563450/midx.c#L861
[2] https://github.com/git/git/blob/c50926e1f48891e2671e1830dbcd2912a4563450/midx.c#L872
