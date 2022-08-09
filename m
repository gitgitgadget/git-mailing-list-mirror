Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77286C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbiHIMHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiHIMHW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:07:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D224313D60
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:07:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so14834407edd.3
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TJVaCm2iifTpmoJ5mIVYNZXvl283w5+9P73FqRLZToo=;
        b=MZo3DPLUoxx9zpbxVHRrqpiSKhRTg2d4yHUGYUyHNpgus7X1eXLecrRZ0GIvZW0Gjv
         BjqSaJ15RxtpnOD1M6RBv5cUATtaJNsJZl132PQ96sTpNTvdeMAUUSHzM/mIFnZPt4eY
         As6JGPFTE+26LefuO42s0n4EEjMMjJaX/T56QZIPySsVbLNfhud0HbMRaREiFwFxwNeg
         eVPi79mE1oRtt9IRgrfbxqUVybS9zU44xuxRc/gXDMGFhjntWF2LfRX48mkTZj0wt3Tz
         kS0Fu+9WdEf6vs/AxVKK8rcHnKVk4zulAOMMvVM5BVI5lX6CL4Nv2LPb+1BDZkXJbhDa
         J5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TJVaCm2iifTpmoJ5mIVYNZXvl283w5+9P73FqRLZToo=;
        b=xqneyJQzrEVZVOUD4qaiB81FvUyn+yHkF2p7wT7RlgeWOUjB3u05yfseoxTy4GS7i7
         PvSDW4IPwnOiBJ7iEJLaUUgrhpDFTEYA20h7mPJnHF7BC/bdYljh9zC0RywpVz24cv1I
         +UJVdkAs202UQFlM38ti87G0ZrRmdiBsM66bu/csdXcQUFlnNnj8r8tpEF6UAQXwrvDP
         2YiCrW58NwPgTg++NewgGqszi8vyZfuB6rOugIfV5eU2PgZWA6qlk45B+Dpxdo6lbYce
         j5G/AoqDkJ38D3rKKJQn09z8XcIUqOUwaxRFntxggOFSfK6zj+ayhBiKGQN2E+oF3wht
         3Hyw==
X-Gm-Message-State: ACgBeo0ZbaW5oZdTHlz0OsfSMEoLXnoc8KL6Dn4nGOyqcKwgg8uqYDpD
        fGwBQ3A4ndjiyUNs/ZNauDefXg1scSpLcqgFRgw=
X-Google-Smtp-Source: AA6agR6eNzd4tsLSSfi96Z2OHTnh7DfxNLFFf3MmMYpSJGxUzlbBZdCJCTSho+CqKbKPxF+Pp/O4b4Z2UwRS6+ysJhw=
X-Received: by 2002:a05:6402:50ce:b0:43d:559d:43f4 with SMTP id
 h14-20020a05640250ce00b0043d559d43f4mr21223250edb.325.1660046840259; Tue, 09
 Aug 2022 05:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr> <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
 <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr> <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
 <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr> <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
 <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr> <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
In-Reply-To: <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 9 Aug 2022 17:37:08 +0530
Message-ID: <CAPOJW5wKnpTpQTbNY2cGt87ZLb9=2i+=ZdzH9XBiuQHtmMcn+Q@mail.gmail.com>
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

On Tue, Aug 9, 2022 at 5:33 PM Abhradeep Chakraborty
<chakrabortyabhradeep79@gmail.com> wrote:
> I also checked whether the `packing_data->in_pack_by_idx` contained
> all the packs. For this I wrote a debug error message in
> `prepare_in_pack_by_idx()[1]` function and found that `packing_data`
> is using the latest packs.

Looks like I forgot to specify the link -
https://github.com/git/git/blob/c50926e1f48891e2671e1830dbcd2912a4563450/pack-objects.c#L87
