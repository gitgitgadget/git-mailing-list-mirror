Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD1AC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 00:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiFNAeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiFNAee (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 20:34:34 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD0B2AC68
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:34:33 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id m30so3338134vkf.11
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6C/odosPvbI1FFRTwel7yay7WWmbbxxJJcOA+sggE8=;
        b=CYFWI16eAvYfDMYNXN7Es6Wn+Yqu3Oc/Gu/LlVCNURWoxcw3EPggD6EcZajOXBPb6l
         8t4fRXPWHE+hfudw/Nf5A5ABN5sBTawEcipajZZF9+/MYNKRDxVM3/nYKlDP0zr3+P5C
         mZn/6l1NooSwl17qiczD5OPKsysmGCqSIi+uIgKB5qe2khFt4Pq6ViNTQKRtLXTDc4NE
         WRvScF3VSGzKWxswk9DHWdtlmcTM4E5JrM1svrudcHl0l6EP5C+zEDLaimUWNqsAY350
         sQm73cPOTeL1m5UZo2Z9RWgBx2p1DOy/nARbFXeux4TA1UZh5GKHQWlMRPwZlKjwvffp
         CLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6C/odosPvbI1FFRTwel7yay7WWmbbxxJJcOA+sggE8=;
        b=qhNbHnpwZ7nvA5jwn+5D7wBxnEqhuFFrScboCsg0pelsL48IMugoaz3+rZO1oxs4aT
         7AQoUgui6fgrkmFe5857moKsCjpU6Oxzi/vQy46OTSh4GcMqHZ/Ub0TXyv9NwXpv8UMj
         jtJAwkVEIBMHpLDjoQ5YxVYg56a6OUC7oAjZwKSuqobnhpqs0VMnwA1gcZGC2Pj/gRmr
         /gUHMsdW120koOzVzbqyyP4wwiPzXnIH7/iEd2J9k9+YpbxOcx0YhoTPoH8xYfOI24vL
         FmCFsnikF2/+OFbjLkz57zgrHDbrstqUAh0ZUIz0Rg2zxEWfM3KQXZd+TBF9oS2YIWa0
         SFzQ==
X-Gm-Message-State: AJIora/FGh7EIzyjoBQw0MjqXv7u6sE1QbBFV9+SFlqWaFC/BjQ/C4aE
        UE7i0A53xi5380UZ+HNByNX5taTuOF2ny2iNZl0LCm79
X-Google-Smtp-Source: AGRyM1sD+PZv9RmNwJ65qUZIVbpIFSHbTP/rcS4SPs86C9bxlcZgATdlnRYC9izoEdDDRh2jYAtvZZ0BWnudb2Aw67A=
X-Received: by 2002:a1f:b654:0:b0:35e:eb1:793d with SMTP id
 g81-20020a1fb654000000b0035e0eb1793dmr942381vkf.37.1655166872568; Mon, 13 Jun
 2022 17:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAChcVumTgNqRTt=EtThXiw9ga=W9WC-uS0XOkz7T+TbtGKeU+w@mail.gmail.com>
 <xmqq1qvwfntm.fsf@gitster.g> <CA+P7+xrfkApv_r_YQqOt-LiaC=Ctb2px0UuaSwqU_ua_qmH4OA@mail.gmail.com>
In-Reply-To: <CA+P7+xrfkApv_r_YQqOt-LiaC=Ctb2px0UuaSwqU_ua_qmH4OA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 13 Jun 2022 17:34:23 -0700
Message-ID: <CA+P7+xrwapFU6z9P7HOKmcGUVFiAn20PVahGG=SC=KSDTv0hNw@mail.gmail.com>
Subject: Re: Should `git remote show` display excluded branches as to-be-fetched?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pavel Rappo <pavel.rappo@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 4:20 PM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Fri, Jun 10, 2022 at 10:08 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Pavel Rappo <pavel.rappo@gmail.com> writes:
> >
> > > Here's a console session:
> > >
> > >   % git config --get-all remote.jdk19.fetch
> > >   +refs/heads/*:refs/remotes/jdk19/*
> > >   ^refs/heads/pr/*
> >
> > Thanks
> >
> > "Negative refspecs" is relatively new feature introduced in c0192df6
> > (refspec: add support for negative refspecs, 2020-09-30), so it
> > would not be so surprising if it still had some surprising behaviour
> > ;-)
> >
> > Jacob, care to take a look?
> >
>
> Ok, so this looks like its caused by the fact that get_fetch_map in
> builtin/remote.c ignores all negative refspecs. I think what we really
> want to do is check if a given ref matches any negative ref and then
> maybe move it from the new listing into a separate skipped listing.
>
> Figuring out the best way to do this is a little bit of a challenge.
> It looks like maybe we need to use one of the functions in remote.c
> just after the get_fetch_map call in get_ref_states. But exactly what
> has so far eluded me after a bit of digging.
>
> I'm still looking at this, but help would be appreciated if anyone
> else has a suggestion.
>
> Thanks,
> Jake
>
> > >   % git remote show jdk19
> > >
> > >   * remote jdk19
> > >     Fetch URL: git@github.com:openjdk/jdk19.git
> > >     Push  URL: git@github.com:openjdk/jdk19.git
> > >     HEAD branch: master
> > >     Remote branches:
> > >       master tracked
> > >       pr/1   new (next fetch will store in remotes/jdk19)
> > >       pr/2   new (next fetch will store in remotes/jdk19)
> > >       pr/3   new (next fetch will store in remotes/jdk19)
> > >     Local ref configured for 'git push':
> > >       master pushes to master (fast-forwardable)
> > >
> > > I would naively expect the pr/1, pr/2, and pr/3 branches to be either:
> > >
> > > - not displayed, or better
> > > - displayed with a hint that they won't be fetched (since they match a
> > > _negative_ refspec, which is the second line in the `git config`
> > > output above)
> > >
> > > Thanks,
> > > -Pavel

I found a working solution, but I don't really like the
implementation, so perhaps someone with more knowledge of the struct
refspec, struct refspec_item, etc would help me figure out if I am
doing it in a good way. I just posted it.

Thanks,
Jake
