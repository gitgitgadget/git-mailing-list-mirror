Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF199C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 10:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiHQKCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 06:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHQKCp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 06:02:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6257C1CE
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 03:02:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w3so16842871edc.2
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=B29Vx3D7IFncWnpDvBC+iYmCwjK6aq7kfFGXjL3Lh+A=;
        b=FZtHJPvfkpAucBhRD5X0vjb2DN0WrRv+siuWpMBSCY7whRkjtM7WcXCVuecXVY8L5B
         c66g/WRE8F0VkHqyw4Lm088UdIuuHhRgjXk5zBmo15xk5ij826NXRIXSyg0QUvpNvdlF
         sZqo+f7D5JqM3N/u4U8X46VCha+7WspW8e27TNedJlG3CL+87v6WPCoGcyqT3r7ps50z
         OTNu9B8m0x5TjcAQ7TiGne1w8Gf8rAagiBlSQlqIXbSVGEszYEglRIdL7+p3mHfVSQBk
         SmwuoDnO2TM300X30k0vyLVshll/mRMfcHk1C20MTAO0zNuBzYVrc++w7x+7lSChLNX5
         np+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=B29Vx3D7IFncWnpDvBC+iYmCwjK6aq7kfFGXjL3Lh+A=;
        b=wfzJTLiepHIWYgWwD6bPBAoIECmE0uFZlNoBQNMz3uT+7daSugscBiP6pd8VmRssII
         9elOBcLH0Is3U/mxH4Hwjbte4j+EPyWXk56m5bs2LxV+M5BHyEFXHaapcBJuP7WSN627
         X8b0eyKMp1jTxOEW2MzHSbCJ9CvPbdrTOllKvb5ZElGIacS73W5FruO2vnkDXS85r1+7
         KyyTIo1k9Uc1TIT23JXIn3v6D3plJDMzyIWoNR/LBj+iTqZJYLyW3MW7zGUQKu2P89Uz
         HZz79RhPeweQ3QZvjXLcgos5S6jLFb8u3zU4sJgv67dw4/0WH6njc5Ah9uspHEwn4+3F
         pnfQ==
X-Gm-Message-State: ACgBeo0gY8mP7mw4XK5B1XzAMCgVD38J+cOcGNfU6yJ0FD8PKa5rUJed
        DVA/iO51NhRGWcuJ5HcSqsIJKs1El6+utHcl82I=
X-Google-Smtp-Source: AA6agR6SK52FIfHQIMzu8CsoAJR5NYZaVCg3QH45Ev47zPN7vahYmehhEOL/eg6cjhuMFliCM+qb1tzhQIZ38+PZY0I=
X-Received: by 2002:a05:6402:612:b0:43d:5049:4d0f with SMTP id
 n18-20020a056402061200b0043d50494d0fmr22149005edv.127.1660730563023; Wed, 17
 Aug 2022 03:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
 <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr> <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
 <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr> <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
 <CAPOJW5w2NYbRkFOaqrNYVFkp5ud=aAxhGGV6gpdDPwnyx5TAVw@mail.gmail.com>
 <805fb0df-45ab-7edd-8787-662b84201e2b@github.com> <CAPOJW5x0coFREUPjFbF_zzQYbfEjOrL-j-G4N7MBUN4N6uS2jw@mail.gmail.com>
 <179c0d30-ccb1-36cf-f783-814c9c8d84c2@github.com> <CAPOJW5z99b0_NGBYDbZUvmzbWECJKxGvB4RffoPJYszfFB0cEg@mail.gmail.com>
 <YvwS5RlEMvgDm93m@nand.local>
In-Reply-To: <YvwS5RlEMvgDm93m@nand.local>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Wed, 17 Aug 2022 15:32:31 +0530
Message-ID: <CAPOJW5znYngr4n4tBBCgqZY4Hr38NArHC7Go=ujDkmsFXY57mQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Taylor, extremely thanks for finding the reason for this failure.

On Wed, Aug 17, 2022 at 3:28 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Abhradeep,
>
> When I took a close look at the process to generate MIDX bitmaps, I found a
> couple of interesting things. The first more trivial fix is that we
> incorrectly propagate the "preferred"-ness bit from packs in an existing
> MIDX when generating a new one. If the identity of the preferred pack
> changes, we should not drag forward those bits on objects already known
> (and preferred) by the existing MIDX:
>
> --- >8 ---
>
> diff --git a/midx.c b/midx.c
> index 3ff6e91e6e..40e520534c 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -619,6 +619,9 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
>
>                 if (m) {
>                         uint32_t start = 0, end;
> +                       int orig_preferred_pack = -1;
> +                       if (0 <= preferred_pack && preferred_pack < m->num_packs)
> +                               orig_preferred_pack = info[preferred_pack].orig_pack_int_id;
>
>                         if (cur_fanout)
>                                 start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
> @@ -629,7 +632,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
>                                 nth_midxed_pack_midx_entry(m,
>                                                            &entries_by_fanout[nr_fanout],
>                                                            cur_object);
> -                               if (nth_midxed_pack_int_id(m, cur_object) == preferred_pack)
> +                               if (nth_midxed_pack_int_id(m, cur_object) == orig_preferred_pack)
>                                         entries_by_fanout[nr_fanout].preferred = 1;
>                                 else
>                                         entries_by_fanout[nr_fanout].preferred = 0;
>
> --- 8< ---

I am not able to understand this modification.
`info[preferred_pack].orig_pack_int_id` and `preferred_pack` have the
same value, right? I see `ctx.info` getting sorted only after calling
`get_sorted_entries()` function.

> But a more interesting problem arose when I took a closer look at the
> psuedo-pack order of objects generated according to
> `prepare_midx_packing_data()`. With Johannes' fixed $test_tick value, I
> was able to see the following in runs that succeeded:
>
>     27bb4ecd3e96cd0b3bc37d92a78cb5cbf34c418afa67f74cc52517ff7df418e1 (12 in pack-63c460f99a5c08f631396b1828c64006170a9d543b064506fd11b504a62acf52.idx)
>     c68154d69c19f010afce786c6debe926ae6e7decfb946a4549085a792cf9de7e (202 in pack-63c460f99a5c08f631396b1828c64006170a9d543b064506fd11b504a62acf52.idx)
>     a0b85b314ede46aa9f9b5796a284a4cf0b86ebb8fa32f87ae246e21b5378b11c (392 in pack-63c460f99a5c08f631396b1828c64006170a9d543b064506fd11b504a62acf52.idx)
>     [...]
>
> and the following in runs that failed:
>
>     46193a971f5045cb3ca6022957541f9ccddfbfe78591d8506e2d952f8113059b (221 in pack-3fc052de674e3d48096af7cc5125675c0ae1082aa798eb9358de357b2655f9ad.idx)
>     67df8a01ac84cf5f028855c48384eac3336bb02a52603bac285c4b31d66b3ab5 (12 in pack-2021cdedb33b542b244eacf3d009d1384471a53286b0c1235c91d124355dc818.idx)
>     1556b5f0ad7cb0c25a1fc47355fcffc00775e90d94ae8c511e5776b204796ce6 (200 in pack-2021cdedb33b542b244eacf3d009d1384471a53286b0c1235c91d124355dc818.idx)
>
> In the successful case, pack 63c460f99a... is preferred, and its objects
> appear in ascending order of their pack offsets. But in the other case,
> pack 3fc052de67... is preferred, but its first object starts at offset
> 221. Huh? That's not right:
>
>     $ git show-index <.git/objects/pack/pack-3fc052de674e3d48096af7cc5125675c0ae1082aa798eb9358de357b2655f9ad.idx
>     221 46193a971f5045cb3ca6022957541f9ccddfbfe78591d8506e2d952f8113059b (1f4bd28e)
>     12 4d332072f161629ffe4652ecd3ce377ef88447bec73f05ab0f3515f98bd061cf (fadf885b)
>
> Indeed, there is another object there at offset 12. Missing that object
> (since it comes from a preferred pack) is an invariant violation (since
> all objects from the preferred pack should be selected when multiple
> copies are available).
>
> It's missing because the existing MIDX selects that object from a
> different pack, and when we get to fanout 0x4d (the one which should
> include that object), we skip over seeing its copy in the preferred pack
> because that pack already appears in the existing MIDX, though it wasn't
> preferred.

ahh, now I understand what the problem was actually. Thanks :)

> I think there are a couple of ways to fix this. The easiest thing to do
> would be to force the identity of the preferred pack to be the same when
> generating a MIDX bitmap *while reusing an existing MIDX*, since that is
> the only time this bug can happen.
>
> But that's a little magical for my taste. I think a more reasonable fix
> would be to include copies of all objects from the preferred pack
> including in the case where that pack was non-preferred in an existing
> MIDX and at least one object in that pack was selected from a different
> pack in the existing MIDX.

I think the later approach makes the most sense to me. It might not be
a good idea to keep the same pack as `preferred` as a better candidate
would be ignored in that case.

> Abhradeep -- let me know if this is something you want to look into. I
> think it's a very worthwhile bug to fix, since it is definitely
> trigger-able in the wild (notably, only with `git multi-pack-index write
> --bitmap` without `--stdin-packs` and only under certain circumstances),
> and not just limited to SHA-256 mode.
>
> If you are busy experimenting with CRoaring, that's no problem and I can
> fix this up, too. Either way, it would be worth you and others weighing
> in on which fix you think is worth pursuing.

I will be happy to fix it but I can't work on it right now (neither on
CRoaring) because I am currently preparing for my exam. I can continue
my work after that (i.e. from 19 aug). If you feel it is getting too
late then you can do this too. I am also thinking of  writing a patch
for bitmap specific test dump tool (as Johannes proposed previously).

My exam dates are 18 Aug, 31 Aug, 1 Sep, 2 Sep and 3 Sep (I know the
dates are weird) The dates are adjusted on request for Smart India
Hackathon ( 24 Aug - 27 Aug).

Thanks :)
