Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36118C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 15:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiHLPtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbiHLPtT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 11:49:19 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40058ACA27
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:49:18 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s10so666018ilq.5
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=FOccY+JnqT2j7F42GLB/Vq9WHyk3/1zs+4SnfmYN8eM=;
        b=h5cssywmc9dGvruFiNG+dRBurKVBdJvH0hykiT/tAZNGsGU8hcnustMypdYXITvxbx
         TSsTpy86F/cvHK6dvgtOQ2KHSD+2uMV2LXGri3UaReA15lljx2ChxlpUWAPuLRhzO7sR
         3Qjg56fg+o1eFIP2Rx4bs0ZUz7WkhBZl0yKvW8Q+CwQHDQK4k3HvoQ0ATP2am5oUNSXC
         ycAqQdRDG5arLBG49YllpP7KfvluOswiRS2+UlKR3lCurkJvkM54ObJnOO/onywbAKdf
         6GJr1rffZflxN/uVKkhYmDWp/46t2q6aaDc1ruNQBJdC8EoZ2gZCniHNP+krNYqDTMPw
         u47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=FOccY+JnqT2j7F42GLB/Vq9WHyk3/1zs+4SnfmYN8eM=;
        b=Rmo3OHVCLUN2B8VXKlStQj+5xaMTPh1E43JnecyLtHqX4O0s6yGB8y/Qp9mMmpyefE
         DJacMCiUmK2Nor9Yn6oRKky1mD8deUzGyiNwECj/AT0u2o0xyTnmsJVIlYteo6h63Dci
         5MDvZMeLamVSyAS3xCa/8sN8pwh5LBmS9qvTOIcVQ5b+ygDr0T3lcibK4msPGrN/u8Pm
         F08qZPVuE6Wer6iqu5Dm6yFpRe2HI4QIQZ4NgHV4bSU6h5mD5rj8n2aziR6mKiaPdkJg
         XVBG283k2Ev/T0IYq9q6xQCwUzdNODly0iJ9r4n0+DhOnzGt62G6JUWvke1J1dYzynIe
         52pw==
X-Gm-Message-State: ACgBeo3MgUeVCsB2m5em3SB3fBDXzA8y2LUXxaeLgf9wKSlGtb4IhyeT
        STIO50S0Z1TocHVU/pD3dhfqbRqIvACl5a4UtKE=
X-Google-Smtp-Source: AA6agR5GJGin7v8xYj9K4X/zmQj8s8qiNEXiFris7oVpqn5tNa5Y46Qm0F0ZPgW0RNJMh34kUxO2QaDje842B0dLP1w=
X-Received: by 2002:a05:6e02:180a:b0:2de:20c8:572 with SMTP id
 a10-20020a056e02180a00b002de20c80572mr2028283ilv.213.1660319357663; Fri, 12
 Aug 2022 08:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1316.git.1659958159193.gitgitgadget@gmail.com>
 <xmqqczdau2yd.fsf@gitster.g> <46ca40a9-2d9a-3c7c-3272-938003f4967a@github.com>
 <YvQf/xW7oohAsJct@coredump.intra.peff.net>
In-Reply-To: <YvQf/xW7oohAsJct@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 12 Aug 2022 23:49:06 +0800
Message-ID: <CAOLTT8QfmVXHDVfWZf0U73PXOQ--ZUmm3N=a60fv_Wo_5UnqmA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] list-objects-filter: introduce new filter sparse:buffer=<spec>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2022=E5=B9=B48=E6=9C=8811=E6=97=A5=E5=91=
=A8=E5=9B=9B 05:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 09, 2022 at 09:37:09AM -0400, Derrick Stolee wrote:
>
> > > Was the reason why we have "we limit to an object we already have"
> > > restriction because we didn't want to blindly use a piece of
> > > uncontrolled arbigrary end-user data here?  Just wondering.
> >
> > One of the ideas here was to limit the opportunity of sending an
> > arbitrary set of data over the Git protocol and avoid exactly the
> > scenario you mention.
>
> One other implication here is that the filter spec is sent inside of a
> pkt-line.  So the implementation here is limiting us to 64kb. That may
> sound like a lot for simple specs, but I imagine in big repos they can
> possibly get pretty complex.
>
> That would be fixable with a protocol extension to take the data over
> multiple pkt-lines.
>

This sounds very scary, a filter rules file has (more then) 64KB...
If the filter is really big, I think the server will really be slow to pars=
e it.

> That said...
>
> > At this moment, I think path-scoped filters have a lot of problems
> > that need solving before they can be used effectively in the wild.
> > I would prefer that we solve those problems before making the
> > feature more complicated. That's a tall ask, since these problems
> > do not have simple solutions.
>
> ...I agree with this. It is nice to put more power in the hands of the
> clients, but we have to balance that with other issues like server
> resource use. The approach so far has been to implement the simplest and
> most efficient operations at the client-server level, and then have the
> client build local features on top of that. So in this case, probably
> requesting that _no_ trees are sent in the initial clone, and then
> faulting them in as the client explores the tree using its own local
> sparse definition. And I think that mostly works now.
>

Agree. But we have to fetch these blobs one by one after partial clone,
why not reduce some extra network overhead If we can get those blobs
that are *most* needed in the first partial clone, right?

> Though I admit I do not keep a close watch on the status of
> partial-checkout features. I mostly always cared about it from the
> server provider angle. ;)
>
> -Peff

Thanks.

ZheNing Hu
