Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C60DC2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E46610A2
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhFSHDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 03:03:04 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:38599 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhFSHDD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 03:03:03 -0400
Received: by mail-ej1-f54.google.com with SMTP id og14so19490198ejc.5
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnRhoB/RMx7TQ14cYniIPJGLOdIIwsosW/2Sh8efCsc=;
        b=RH/A3Y4vE9GRcJItcLBHn4P+ozkmD9R5GFkMHzQ8v+5c9oPT+HHE9ORFWCiFZ00M59
         +k1t++SD4XdA3D3gqW5TmlO70pcyJbDJzpYgNNwzB7JC5mwXEjF9Mtdg1bAsdSUBnlet
         4CB9RtS6juPppcqPlaWDG6uZPtrllF+kxLZkPj1mznxRp7+RWHfVnAnkW0FFdw6hpwqY
         uWGcuSvB6FB0WOeOc562OG0hYsHkTeBh7SOlVfPXJsnA0WH5qDEL8q7ip0SMSzaVjaPt
         morqUDoMDMoLHRzIINUO+bk44pCOsCxEEot49rhhQcQhD9rSAOTkmZhB5mKXEdE3CxWU
         m4Ow==
X-Gm-Message-State: AOAM5327VtLWdw5Gd3T7iwPS7EZ71BWvjoFS7GwoKHDMr8pMy0NmvXA7
        iGg6l1+3MWbeBcl00z1DnfySiotH9D0vnAXr3Xo=
X-Google-Smtp-Source: ABdhPJwzhqzgBb6U35L691FfUOH5rmLR92U2kExVrgolem0IqB1i7ZmyxKezF629j9VWC6eND0TE7scQ4xl7loVeK0M=
X-Received: by 2002:a17:906:3c44:: with SMTP id i4mr1210218ejg.371.1624086051702;
 Sat, 19 Jun 2021 00:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <60cc1749b1c4d_5d12520825@natae.notmuch> <CAPig+cTr2fEYN2y7FyKaspuaCpAq6wNtHgg_8RcrOmvsN5+XaA@mail.gmail.com>
 <60ccc3332428c_5eaa2208df@natae.notmuch>
In-Reply-To: <60ccc3332428c_5eaa2208df@natae.notmuch>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 19 Jun 2021 03:00:40 -0400
Message-ID: <CAPig+cRHBFodZ=ZJzpU208AWMSD-V6xH8zKZwmDPJk5eeu571w@mail.gmail.com>
Subject: Re: Only 27% of reviewed-by tags are explicit, and much more
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 18, 2021 at 12:00 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Eric Sunshine wrote:
> > On Thu, Jun 17, 2021 at 11:47 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > > Here are the top 20 reviewers over the past 10 years with their
> > > corresponding explicit over total Reviewed-by count:
> > >    ...
> > >   5. Eric Sunshine: 14% (17/116)
> >
> > Does your script check cover letters? Based upon a quick glance at it,
> > it doesn't seem to.
>
> Not really, that's a good point.
>
> > Although I've reviewed thousands of patches over the years, I almost
> > never give my Reviewed-by:; it is an exceedingly rare occurrence.
> > However, when I do give it, it's almost always in response to the
> > cover letter (saying "this entire series is reviewed by <me>"), not in
> > response to individual patches. I've seen other reviewers do so, as
> > well. So, if your script doesn't take cover letters into account, then
> > you might want to revise it to do so in order to get a more accurate
> > picture.
>
> I've updated the script to consider all responses to the cover letter
> that start with 'Re: '.
>
> Anyway, with the updated script the explicit reviewed-bys are 40%, and
> here are the stats:
>
>   5. Eric Sunshine: 38% (45/116)
>
> You got considerably more, from 17 to 45, but still pretty far from a
> 100%.

The numbers produced by your script don't agree with my own
investigative spelunking through my own mailbox. What I found is that,
via 33 emails, I've given my Reviewed-by: to 133 patches[1]. If the
116 computed by your script is accurate, then that means that not all
of my Reviewed-by:'s made it into the project, which is believable.
Nevertheless, according to my own mailbox -- accounting for 133
patches -- I have almost certainly given an explicit Reviewed-by: to
all 116 of those patches your script found, which means the script
output should probably be "100% (116/116)". This mismatch between your
script output and my own investigation throws doubt upon the
script-generated tallies for other people, as well.

(Aside: I also gave another 37 explicit Reviewed-by:'s via another 7
emails[2], however, the authors of those series ended up re-rolling
after my Reviewed-by:, so I did not count those in the numbers I
presented above. There also have been several times when patch
submitters added my Reviewed-by: in error[3], though I don't think
those ever made it into the project.)

[1]: explicitly given Reviewed-by: (patch-count, message-id)

10: CAPig+cSXi7Ct48gqkBVvBtOm6bMqDhPcxXeiK3ZytAitZXNT5Q@mail.gmail.com
7: CAPig+cTt-TyOR8kc6YvBVLpf-bgFdJ+FVYA2NvG_Vvn7tMbBkQ@mail.gmail.com
1: CAPig+cS7SEARwoBn25SsxhkvdJfDe56FyVjDGk+sJq2kXfDbjQ@mail.gmail.com
1: CAPig+cS8hvX4GCsnfLBnQ4Q_AkUad=bw7rjVcaOqSEqcLZvx8w@mail.gmail.com
1: CAPig+cQxvq3MzyB3e8-ZeVSdCot04=9p4L8CZRnpYbrmnR70_g@mail.gmail.com
39: CAPig+cTxfheSPHJvC3_=jQjef0S7FiMEWCQ71ER7epfpeD_5OQ@mail.gmail.com
1: CAPig+cSDxBFhnJSmH+WzNZBjY4O0OczazZ7EOqn1P=zgL+ec4g@mail.gmail.com
4: CAPig+cRor4UXXZhoAkhOQfe6W+oC84YFmA-KwpLspuEh_A4Zng@mail.gmail.com
1: CAPig+cTgoD-GvpoBQ6tcGX4T2XhuKccJAZ40P76vxVD_PfEc9A@mail.gmail.com
1: CAPig+cTcqSa6AfeMQivnSdL=y2+WWw2MtSavDciMc84RcKURMA@mail.gmail.com
5: CAPig+cQVaMOKtbUCWdZqYDO8ZUZkVcSJH14S=2xrZiDVJ59Xdg@mail.gmail.com
6: CAPig+cQ2NRO4yaFkcGmUpY3TZcWkdg-vu6d7Fq7JgHzYSkcRgg@mail.gmail.com
1: CAPig+cS4Bj4N8d1a29z8=f30owOec1pB=yF32ZUPmDH2Tu2kXA@mail.gmail.com
1: CAPig+cQPbwM0+6yruK0VKKq2ujFLoCLogS7eQNN7WWgRjG5V0w@mail.gmail.com
6: CAPig+cR9i1a7pxOxV4QU2TnoJWKn4mHHVT2tG3+uRysw=sc6qQ@mail.gmail.com
7: CAPig+cR3diDfn893-ExKNZps=C7Z=M7DFAy-zbJzH3wKCmxVeQ@mail.gmail.com
1: CAPig+cRimDGFDk7A2p2rKpJ2GR27_R=BJdpyPK4xeyDU1TruWQ@mail.gmail.com
5: CAPig+cQPFzgEgdNUJSa9baUvc4BuJp8BHOLA88QJqW8N3hE8AQ@mail.gmail.com
11: CAPig+cS8sJn9tV2kW=ASN2wTtKiK-H5oa8bThiiGfu_vMv7DoQ@mail.gmail.com
1: 20160216050915.GA5765@flurp.local
1: CAPig+cSxVdZN_wr3XuqDGuKn14J3B7s=S8OoH19v+AjMvcX6+Q@mail.gmail.com
1: CAPig+cTaOTfwzodKSabdy9HFbF66RuEXwmvjZ8QuQVFMaVpA7w@mail.gmail.com
1: CAPig+cSSdGeMuV1XLqROXvSeYfmkNc_N7E_pzfJWdDR6wfD80A@mail.gmail.com
2: CAPig+cRySp4_uJYAwC-PY_Yh-YjBb0y1Tq=TwoD7d-Bpb_YANg@mail.gmail.com
5: CAPig+cQtYjyj2dVFX_8CjyacRPd+dU6aMMXYGsoX9+q+zgjdZQ@mail.gmail.com
1: CAPig+cSuCouNCuKa99mct4UMPykuMVy3+7sqB6y+v+UtP2oeTw@mail.gmail.com
2: CAPig+cSC8RZJ-+uP=ZExVH2ZyexfQmLjzdjoBA7yuWkdYE4EGQ@mail.gmail.com
3: CAPig+cQ-yLnjrsB1E-7=UXfGzuJHat6YtfS8EVRNP2dcjj_6TA@mail.gmail.com
1: CAPig+cT0-ftZZyRORx-W2_Nit6XdgrpiyGS=pRjGtHoz1jW+Kg@mail.gmail.com
1: CAPig+cQb6k8ktWR5Fz+dstfhFj5dZ+kpfzVk1Vp5piYJ3zy4rg@mail.gmail.com
1: CAPig+cRd5+9nq3YNA6e1R_tvmBTHByOg-=KRWG1m3Fxb0e_vFQ@mail.gmail.com
1: CAPig+cRpD0B2YRZYyJVUiM70AFcduTPOuJsuRFFKZE+bXttW1Q@mail.gmail.com
1: CAPig+cSuBfuzL-NXYkvFoz5+jPrEUNfTqoMf-iAYyMSv3jDsqg@mail.gmail.com

[2]: explicitly given Reviewed-by: but submitter ended up re-rolling

6: CAPig+cRz4stVQWFD-NroVHft2xFvyZJi1ePX9T4zZ3k3=X6ZrA@mail.gmail.com
6: CAPig+cSmb9wFCV+9PS4LYfd3hAH5s6ifRk8orVv+e2Q=h7F3Ag@mail.gmail.com
6: CAPig+cQ4n5j4Q-WF-0cd=2+5eSAaimh3A7La+8Fe9Ox4anjtBQ@mail.gmail.com
1: 20160327194948.GA9295@flurp.local
12: CAPig+cTrh4u7vgQRXOT0a-5St2a6TV4qfhOMCVSetbQD0kGTrQ@mail.gmail.com
1: CAPig+cTCRq9VCT7t8E9yjk4QcHYB2_qeBwGB_31keB4nTjkLkA@mail.gmail.com
5: 20150519004356.GA12854@flurp.local

[3]: Reviewed-by: not explicitly given

11: CAPig+cRmz2C7mAzc7Z=ZStAxd3qDSmbC4sbwyLGKqvkf2yzVPA@mail.gmail.com
1: CAPig+cQG16AhLPMeOFAw1GF81oXivFSDHvQ5B8kX20YGAT_BxQ@mail.gmail.com
2: CAPig+cRryaafwP4gBLe_6ebWZo12HWtEC6e2CbbP6a5gVh6W4w@mail.gmail.com
7: CAPig+cR0jG65LbopxqPpidaaNUSTRq9tboZpv0RPWyWUkSEGUw@mail.gmail.com
1: CAPig+cR=u_ak_=J=gSAWfiNB01R7FBG+bCrx+k1HNAE0xHtwFQ@mail.gmail.com
