Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00021F516
	for <e@80x24.org>; Mon,  2 Jul 2018 17:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeGBR1q (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 13:27:46 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39349 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeGBR1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 13:27:44 -0400
Received: by mail-yw0-f195.google.com with SMTP id 81-v6so6933653ywb.6
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XdT7sBVskfjwmaFRxErYVtHv7HJMxhoZBvzfTncMThg=;
        b=t9hFFM+gmxbtltrUS0HzdDz3Atvi2gSwfVj+AIutVUTsoPEWWIOP+3fjaTLVLXWAmU
         UwY4pBVMB4Hc29CaxbRNLhA2IfVKoyg4P8TsYyat6VwlYXfhvDmeiJe/iwAocPtO0qE2
         VjIlp3NUxA9pZEeHAMTKypY770uEg8gvXVFjOCkG3FQn2rNEq3/aC5APEpQ8FY10My4Q
         mCOxs8EA91/nRPKI18Gb+8lG/wfLyzTF0tpduejXj8YXPgcPR98dyon6oSLjkkyfU/T5
         K43dnk62MIyu2GEmvisSoV/yWyGsM4depBkeS7j3uVagRGUH2H1oHNIQJx+sePRbz+EV
         FX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XdT7sBVskfjwmaFRxErYVtHv7HJMxhoZBvzfTncMThg=;
        b=Y2Jz1EyKnf/w+RE6BqICMT2lfX0CCDoL9w+Fb2JFuFYghnGOguZ5JM+Mv3JBuiFzqE
         WK3mFBNlk7DUkmTkDEa5pOtNvAP0GrJuJ9MeW47x1EEKmr1ulRAUeImCzgjR5KnDy0m4
         70NaCycgB81EiEHQKq1xyuSWgIGtiBCZvxIcxVjdVOmPtyxMG4yADsFLp3rjFODmHb48
         4qLggQyfdstMU+c+i9q8+EUvX0NN3jFcgaUHDdPPwd19IfovRoXovzk1CL/wb3fw6LEJ
         oxo0ack5IKelPnK4jtsbsdFCzdgWVRY/21Fp8oizXtP5XbE8SJYVQy1GAVWS6IxarS9R
         Diow==
X-Gm-Message-State: APt69E29ed0GxQcB1wahK/FvXTi1g+VqSC/95WicqU2i6xXI8A8iElhT
        rhSA9dsfPj43JtlNQMopNcfUvZ3E3Zsz+ceJsJTHcQ==
X-Google-Smtp-Source: AAOMgpfBqds4qIO444xm2hyvBV+J9IM3q7KesnvtJeiP8o7/Gv8ho6HP1oabntTZDEz94u2QqN6W+QZBYLtK2yZ7SfY=
X-Received: by 2002:a81:360a:: with SMTP id d10-v6mr13740702ywa.421.1530552462490;
 Mon, 02 Jul 2018 10:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
 <20180629202811.131265-1-sbeller@google.com> <72ac1ac2-f567-f241-41d6-d0f83072e0b3@alum.mit.edu>
In-Reply-To: <72ac1ac2-f567-f241-41d6-d0f83072e0b3@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Jul 2018 10:27:31 -0700
Message-ID: <CAGZ79kZzrdswds4ejCJrhJD1UcJeODdhifX5-UREuK5wPUM-rg@mail.gmail.com>
Subject: Re: [PATCH] xdiff: reduce indent heuristic overhead
To:     Michael Haggerty <mhagger@alum.mit.edu>, quark@fb.com
Cc:     git <git@vger.kernel.org>, Jameson Miller <jamill@microsoft.com>,
        Mike Hommey <mh@glandium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 1, 2018 at 8:57 AM Michael Haggerty <mhagger@alum.mit.edu> wrot=
e:
>
> On 06/29/2018 10:28 PM, Stefan Beller wrote:
> > [...]
> >     Adds some threshold to avoid expensive cases, like:
> >
> >     ```
> >     #!python
> >     open('a', 'w').write(" \n" * 1000000)
> >     open('b', 'w').write(" \n" * 1000001)
> >     ```
> >
> >     The indent heuristic is O(N * 20) (N =3D 1000000) for the above cas=
e, and
> >     makes diff much slower.
> > [...]
> > +/*
> > + * For indentation heuristic, skip searching for better slide position=
 after
> > + * checking MAX_BORING lines without finding an improvement. This defe=
nds the
> > + * indentation heuristic logic against pathological cases. The value i=
s not
> > + * picked scientifically but should be good enough.
> > + */
> > +#define MAX_BORING 100
>
> This is an interesting case, and a speed difference of almost a factor
> of five seems impressive. But this is a pretty pathological case, isn't
> it? And I'm pretty sure that the algorithm is `O(N)` both before and
> after this change. Remember that to find `earliest_end` and `g.end`,
> there has already been a scan through all 1000000 lines. In other words,
> you're not improving how the overall algorithm scales with `N`; you're
> only changing the constant factor in front. So it's a little bit
> questionable whether it is worth complicating the code for this unusual
> case.
>
> But *if* we want to improve this case, I think that we could be smarter
> about it.
>
> By the time we get to this point in the code, we already know that there
> is a "slider" hunk of length `M` (`groupsize`) that can be slid up or
> down within a range of `N` (`g.end - earliest_end + 1`) possible
> positions. The interesting case here is `N =E2=89=AB M`, because then nai=
vely
> the number of positions to try out is a lot bigger than the size of the
> hunk itself. (In the case described above, `N` is 1000000 and `M` is 1.)
>
> But how can that situation even arise? Remember, a hunk can only be slid
> down by a line if the first line *after* the hunk is identical to the
> first line *of* the hunk. It follows that if you shift a hunk down `M`
> lines, then it has the same contents as when you started=E2=80=94you've j=
ust
> rotated all of the hunk lines around once.
>
> So if `N =E2=89=AB M`, there is necessarily a lot of repetition among the=
 `N +
> M` lines that the hunk could possibly overlay. Specifically, it must
> consist of `floor((N + M)/M)` identical copies of the hunk, plus
> possibly a few leftover lines constituting the start of another repetitio=
n.
>
> Given this large amount of repetition, it seems to me that there is
> never a need to scan more than the bottom `M + 1` possible positions [1]
> plus the highest possible position [2] to be sure of finding the very
> best one. In the pathological case that you described above, where `M`
> is 1, only three positions have to be evaluated, not 100.
>
> In fact, it *could* be that there is even more repetition, namely if the
> hunk itself contains multiple copies of an even shorter block of `K`
> lines. In that case, you would only have to scan `K + 1` positions at
> the bottom plus one at the top to be sure to find the best hunk
> position. This would be an interesting optimization for a case like
>
> >     open('a', 'w').write(" \n" * 1000000)
> >     open('b', 'w').write(" \n" * 1100000)
>
> (`N =3D 1000000`, `M =3D 100000`, `K =3D 1`) or
>
> >     open('a', 'w').write("<item>\nMISSING\n</item>\n" * 1000000)
> >     open('b', 'w').write("<item>\nMISSING\n</item>\n" * 1100000)
>
> (`N =3D 3000000`, `M =3D 300000`, `K =3D 3`). On the other hand, it's not
> entirely trivial to find periodicity in a group of lines (i.e., to find
> `K`), and I don't know offhand how that task scales with `M`.
>
> Michael
>
> [1] Actually, to be rigorously correct it might be necessary to check
> even a bit more than `M + 1` positions at the bottom because the
> heuristic looks a bit beyond the lines of the hunk.
>
> [2] The position at the top has different predecessor lines than the
> other positions, so it could have a lower score than all of the others.
> It's worth checking it. Here too, to be rigorously correct it might be
> necessary to check more than one position at the top because the
> heuristic looks a bit beyond the lines of the hunk.

So this suggests to have MAX_BORING to be
"hunk size + some small constant offset" ?

Stefan
