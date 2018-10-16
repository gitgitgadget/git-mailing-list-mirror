Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9768C1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJQHJn (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:09:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40082 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbeJQHJn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:09:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so23051380edd.7
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dcrTr+zVCfdvGu98YucxLl3w9UCs7i90iCCojzhFtM=;
        b=YRD95C+GJgAP9css3vz3fQpZ+50YCxdqNwfRXq2/EQFp+ytrCHALtbNze+cPWJ2mLO
         jG0Rp3uVqnmrv5ZyC7DJcqAe/C/uXA24FBPdDAuPk0Kb1ZlKSSdQ8XXz/342kMJ8lcxz
         e0qY0biHWjqrc4myZOGXSaPiFnIuQHTWXDrPNQlEvEDQ2+dLa0SqOAApajUbrreXDGm/
         dzdjBTWOO5jUoRsTun/zy9KOrPu5vXEWaanZvQ7hnP+8cvAuZYM536PbqTDGT+lqeo+W
         9ZDO41yI4nZ34R9DF1griOWo6YsPHFA1NrnGNotDPeOYxFoCxpxXi2wklh5JSn+XHXWR
         kALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dcrTr+zVCfdvGu98YucxLl3w9UCs7i90iCCojzhFtM=;
        b=k2K6FoA8ZuyWwMEi51F3pAQsBsDAfuXYUFHSiL/ibjSOIbpyYD0VSlIcCT0YgkUWLj
         vW+Mic1K42UjQZx4n6+IHX0f7sDtbmN3b1FWW7xxBRf18/IiBv30RVunIlaGVDvhx/AM
         GuUUxFx/a7uCq66uIZWg7oAjLHZwRq8o5K/ckOtdGqIXtnlz3YI9seTUzNJcEdTQ/ZJe
         sP8jcYgozrIu/VDVSAOML/T0XFx/lXM6EP8RrQ1+zpdaM2Kgxd5PY0P2LbvmZicAnG5E
         CZJpTZtQKlh5ORxKbxPXx2PvplV9ssacAAV1t7wpU/KZEwgjOjseWb699Jjfe5g6FyVF
         o+/Q==
X-Gm-Message-State: ABuFfojriieh+nYB9ZbSiEkCduefFjQ39ukywwmfYbq6Ixko3aNI9S/s
        7CI0Ry5EEr5zhssgLxlSG2NK+BdkED6EVFxQkJgU1A==
X-Google-Smtp-Source: ACcGV63X7IgCMnLgnWYZIMTj08w86CI23NZt3Dy46/S+GSYepgI0yjdz15DMTpBXQdltGGZ3vVuRue+VMKBaq/IU77c=
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr33142360edc.76.1539731821018;
 Tue, 16 Oct 2018 16:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kYS7at89igHdg163mcZGmsOXO1jj6iBqSZF_VuMEh=g9A@mail.gmail.com>
 <20181016231343.189184-1-jonathantanmy@google.com>
In-Reply-To: <20181016231343.189184-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 16 Oct 2018 16:16:49 -0700
Message-ID: <CAGZ79kbNybApS60pvusO0OiLVca+JtN=X3vTG3dHiRDSfoy4yA@mail.gmail.com>
Subject: Re: [PATCH 17/19] submodule: use submodule repos for object lookup
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 4:13 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Thanks for the review of the whole series!
> >
> > I have redone this series, addressing all your comments. I addressed
> > this comment differently than suggested, and put the submodule
> > repository argument at the end of the parameter list, such that it
> > goes with all the other arguments to be filled in.
>
> Sounds good.

Actually I changed my mind on that after figuring out how to free
the submodule repository appropriately and went with your original suggestion.

>
> > I was about to resend the series, but test-merged with the other
> > submodule series in flight (origin/sb/submodule-recursive-fetch-gets-the-tip)
> > which had some conflicts that I can easily resolve by rebasing on top.
>
> I presume you are talking about [1]? Maybe consider rebasing that one on
> top of this instead, since this is just a refactoring whereas
> submodule-recursive-fetch-gets-the-tip changes functionality, from what
> I understand of patches 8 and 9.

From my understanding, that series is further along than this one,
so I would not want to mix up their order.

Currently I am rebasing this on top of select topics from next,
(ds/reachable) as that are the other conflicts that I'd have to deal with.

> [1] https://public-inbox.org/git/20181016181327.107186-1-sbeller@google.com/
>
> > It conflicts a lot when merging to next, due to the latest patch
> > ("Apply semantic patches from previous patches"), so I am not sure
> > how to proceed properly. Maybe we'd omit that patch and
> > run 'make coccicheck' on next to apply the semantic patches
> > there instead.
>
> Omitting the patch sounds good to me. For me, just stating that you have
> excluded any coccinelle-generated patches in order to ease merging into
> the various branches is sufficient, and people can test the coccinelle
> patches included by running "make coccicheck" then "patch -p1
> <contrib/coccinelle/the_repository.cocci.patch".

ok.

Thanks,
Stefan
