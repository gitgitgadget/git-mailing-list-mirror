Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07118C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 07:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D98B461506
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 07:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhJEHmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEHmm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 03:42:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D701C061745
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 00:40:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so74717338edv.12
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M20ipbfVLCRDYXH/wO0+NoUrVmabIRlcdm99xfMMhYE=;
        b=pAwt4V8472p/VBi7Giz7kyKlRsp7uLS12hfQ/L4r9v3jkaNqbUprhpFRqsmwL/3L3N
         99XGjcfpKCSpv5mux0n1pCVRXMV6xRQY8LXRfYoRSQUdf+7MXavf/6IkYm2od5B5qJyP
         vli1talmkXFpsJxqbYYKxT143VLCO3mp+uCahXeT6RH26tMgXJ2nojDEXGaBBkiT50lf
         j4C1I6kQ0dMHeCm3RSGpwJacQAIJhUkv85xgfJn9dblCc9WJhslVlPHtEz6Hm7i4xs2b
         MrQXGjFx8CjaKkby8F1MwK4dG3yDNyIOcW8e/AcjrV+mYuD8vhW1h5Pq3HwZ9qzR3khg
         vIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M20ipbfVLCRDYXH/wO0+NoUrVmabIRlcdm99xfMMhYE=;
        b=Uv4YD0lbFCNjfoyn9N9KKPdiI3+WJMqzLx1c6pDq+DSMDLLSqmMZzkyYIKSRdhcuuF
         bo+ZXKLzgImj7lhXNgwsLRNRfk60jeLoz7esRysWC0xV+6LQfY9Lc8bE8g/H7eVzxDMI
         /sOEVm9ZUCKClKZiYmshlsMSTBV6v/liyb9FSNFfENB31JW/ZCWDF3wnKJuLAT2/kGtG
         tD57stTZv+J8vnW5JLtrySF2MJmH2f0LOk8ktGPjOKD2cI3CYPe3NAqKli7hFIMH4cW1
         AuyqFjE41MgaMb2Hl9YnKeFgqlF9BMz4WiG3dWiBX850B+xi/k7plZGcv8aIbvzZ8RJ3
         QwFw==
X-Gm-Message-State: AOAM533fccV5wMPjwMzZJiKU0/pMxXCyUeF9uW89O3nGhXMe1d+HWjZn
        oz3/AntySl9fFKwhgdX1H0CLgob4WGWdaVuAiV0=
X-Google-Smtp-Source: ABdhPJysj4r4jD/ls12WKBi5QD3iPm7RvV3M7EMYG417xQKs7dJ2+jLMniuixKCWh/jFcCfxXJETOuz270iV5dzkm/k=
X-Received: by 2002:a17:906:eda6:: with SMTP id sa6mr18654737ejb.443.1633419650531;
 Tue, 05 Oct 2021 00:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
 <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
 <CABPp-BEaJAG=pqyjCR93YUoqj06WwSqjiPENDHjgSTWwzd_C2A@mail.gmail.com> <87bl44n070.fsf@evledraar.gmail.com>
In-Reply-To: <87bl44n070.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Oct 2021 00:40:38 -0700
Message-ID: <CABPp-BEF8=yw__r3p=spt647+tLG0UshaXq45ePEsFvv89i9Ng@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/10] Fix various issues around removal of
 untracked files/directories
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Mon, Oct 4, 2021 at 10:56 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Oct 04 2021, Elijah Newren wrote:
>
> > So, I guess trying to distill what bugs me, I'd say: [...] I hope I'm n=
ot overreacting but
> > something feels wrong to me here.
>
> I don't think you're overreacting, and sorry again. Hopefully it helps
> somewhat that I for the "ignoring Junio [and charging ahead with this]"
> and the 2nd false claim about about heap allocation I was (believe it or
> not) just honestly mistaken instead of trying to get on your nerves.

I really wish I could take back that email.  And yes, I was totally
overreacting (in part due to unrelated non-git stuff going on
recently).  I should have waited a day, and then I'd probably realize
it.  I owe you an apology, =C3=86var.  I'm very sorry.

In regards to the worst part of my email:

"""
  * At least half the series of yours I've reviewed have had
significant bugs[4][5][6] (in addition to [2] and [3]).  This would be
fine if it was complex code that had bugs we were fixing, or if we
were adding new features, but:
"""

I'm no stranger to introducing pretty bad bugs either, some caught in
review (one case of repository corruption caught in a review just last
week!), some making it into releases:

https://lore.kernel.org/git/YVOn3hDsb5pnxR53@coredump.intra.peff.net/
https://lore.kernel.org/git/DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00M=
B0682.namprd00.prod.outlook.com/
https://lore.kernel.org/git/CABPp-BFWfwkYAPyySjWOMZ02_+YLf=3DTJ_aVMaHaizJWA=
sCL67g@mail.gmail.com/
https://lore.kernel.org/git/CABPp-BENB=3DmqfFU4FGb2OS9VDV=3D9VdT71HhFLZwtyx=
D8MpdTMQ@mail.gmail.com/
https://lore.kernel.org/git/CABPp-BEBKyE2NVfREov6k5qML5jryLjtzw=3DY21EA=3Df=
HXA0PO5A@mail.gmail.com/
https://lore.kernel.org/git/CABPp-BF8eokQTVwgo80ffq3tn=3DNA=3DmPf7oymce5P4i=
tDyZBiMg@mail.gmail.com/
https://lore.kernel.org/git/7v1uzu5a70.fsf@alter.siamese.dyndns.org/
https://lore.kernel.org/git/CABPp-BHL4P0RxQ6OAuDSev9BXVM0uKTYD3M4JGTQvSwcBv=
4K0Q@mail.gmail.com/

and I could easily find more, it was pretty easy to come up with that
list of bugs that still make me shudder.  Touching difficult code, or
code one isn't quite as familiar with is more prone to bigger
problems.  That doesn't mean we should avoid working on those areas,
but I'm afraid my email probably served only to scare people away from
doing so.  Treewide refactoring is, by its nature, likely to take one
into many areas of the codebase, and thus it'd be natural to expect
problems that hopefully get caught in review.  The fact that such
treewide refactorings did have problems, was by itself not my point
and not what I'd consider unusual.  I was attempting to make a more
nuanced point about lots of treewide refactorings in a short time
period coupled with lack of understanding of motivation for some of
those refactorings all combined with additional things on top, but
utterly failed at anything more than coming across as a jerk.  I'm
sorry.

Thanks for responding to my email so diplomatically; I'm super
impressed with that.  And just to be clear, I respect your
contributions and hold them in high esteem (prove, i18n, pcre2, faster
send-email to name just a few).  I think that message was
unfortunately completely lost in my email, which is plenty of reason
that I just shouldn't have sent it.
