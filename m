Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCDBC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 18:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B14020674
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 18:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn7wjee4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFSTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:19:21 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33139 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgCFSTV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 13:19:21 -0500
Received: by mail-io1-f68.google.com with SMTP id r15so3034168iog.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 10:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=djzFOQqQ5/OYX2wmOSfxFnFVvFhc5gUrl7eVhemVr8k=;
        b=Mn7wjee4YhuI9ghwKvgCI1Zxu0lcgv4V7ykLJ2TKTWGlNpWjAV3AjlJsldvB9uXQSX
         ymTe6EufLbTTNQA3a3usdaj6Vf5s1dL54sAN9b2mAv1jp+UbA1FT8atdwAK4CTuRoKT/
         Kfez5cpi4eo5nhASiBEdK35Z0O23kyFCb7wZvz093gdplnbeCsE8nOlW4jDeZBMb9R9/
         +iFEoPFDi5HNTObIB/YT/TAl4otxbpjRCKeCOEMA3skB+u+vGhz54v+tYr8ZLdWSyJ1Q
         ZR+0Cy5rpTSbQ7qkBwfcgSrv0Uqrs9+eIkDG0vFIxfMo+QS+QJ059NgsaFI73mXpD+7t
         bkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=djzFOQqQ5/OYX2wmOSfxFnFVvFhc5gUrl7eVhemVr8k=;
        b=tA31wBhbEcfo+6/wKlbfLFr7j7IMlIzurNcsjrUqDjDEYCupkCA0oCQrDx4Nj8KPrs
         4g34lHiDVeMc8eOj/vqdmlVFeG9n4I/BzyxP0nBjZd1k3z+JlFdupsVQHfcS1y05cxJC
         QeFXX6y7lIt4W8dPunIGL8j92GP9hVTwgRFX+LXpiMmbkD7ZDvUkfiRUJCU/g4TjgaEL
         FbQWIDtHCLu5DHRfV9ZsktOgZlZSvjcbMLbcW0ZSEwLuIYfMWG50/QDefSh9GisKQUDm
         x/uYbOkRtmm3OkKV+/8JZNKrVSgRZqFSMpUnuZQKcbnXcVoMnxNqC1zD1OKPbmzYMTTy
         Sgjg==
X-Gm-Message-State: ANhLgQ1Ue24kt/z0qwdsYlPyXRV5769eFCF0J+NOBNsuges+IxcwaaeD
        4/IV3IFpBnt8gL218J8+FTQ0NYUN6oppBUpglnWWnA==
X-Google-Smtp-Source: ADFU+vsKsVGngbTSbFCOKbJ8jAfeJ+QtZDgBWcI44LGx87oxg0ROdRc7uevr3EqnVQWHyya1vLQEidGOZ1b6yyXnkE4=
X-Received: by 2002:a05:6602:1217:: with SMTP id y23mr4202547iot.34.1583518760457;
 Fri, 06 Mar 2020 10:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20200226101429.81327-1-mirucam@gmail.com> <20200226101429.81327-3-mirucam@gmail.com>
 <xmqqzhd5i1na.fsf@gitster-ct.c.googlers.com> <CAN7CjDDwgR=y8gyYmDzmuTW3AKvb1N=EdCtH-8Tr7T=b6cG5gQ@mail.gmail.com>
 <xmqqwo88f0do.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwo88f0do.fsf@gitster-ct.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Fri, 6 Mar 2020 19:19:09 +0100
Message-ID: <CAN7CjDCb3Bo-reyCZBxMuxX7ecCRLo6XaZHUE5fKGnQav9g_xQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] bisect--helper: reimplement `bisect_next` and
 `bisect_auto_next` shell functions in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

El jue., 27 feb. 2020 a las 17:41, Junio C Hamano
(<gitster@pobox.com>) escribi=C3=B3:
>
> "Miriam R." <mirucam@gmail.com> writes:
>
> >> It would be surprising if this code were correct.  It may be that it
> >> happens to (appear to) work because parents of the commit hasn't
> >> been painted and calling the helper only clears the mark from the
> >> commit (so we won't see repeated "painting down to the root commit")
> >> in which case this might be an extremely expensive looking variant
> >> of
> >>
> >>         commit->object.flags &=3D ~ALL_REV_FLAGS;
> >>
> >> that only confuses the readers.
> >>
> >> Even then, I think by clearing bits like SEEN from commit, it breaks
> >> the revision traversal machinery---for example, doesn't this mean
> >> that the commit we just processed can be re-visited by
> >> get_revision() without deduping in a history with forks and merges?
> >>
> >> Has this been shown to any of your mentors before sending it to the
> >> list?
> >
> > Adding clear_commit_marks() was a suggestion of a previous review of th=
is patch:
> > https://public-inbox.org/git/nycvar.QRO.7.76.6.2001301619340.46@tvgsbej=
vaqbjf.bet/
> >
> > And of course, my mentor always reviews my patch series before sending.
>
> OK, I just didn't know how you and your mentors work.  Some leave
> their door open for mentees and help them when asked but otherwise
> act as an ordinary reviewer who somehow prioritises reviewing the
> work by their mentees.  So your mentors may be a better source of
> information why this piece of code, which I still do not know how it
> could be correct, is supposed to work.  Good.
>
> After reading the above URL, I think you may have misread the
> suggestion you were given.  Resetting using clear_commit_marks() may
> be necessary, but you do so when you finished walking so that you
> can do unrelated revision walk later.  For that, you clear the flag
> bits after the while() loop that asks get_revision() to yield
> commits are done, using the initial set of commits that you used to
> start iteration.
>
> That is how bisect.c::check_ancestors() work, that is
>
>  - it initializes a rev_info 'revs' from an array of commit rev[]
>
>  - it lets bisect_common() use the 'revs', which is allowed to
>    smudge the flag bits of commit objects.
>
>  - it uses clear_commit_marks_many() to clear the flags of the
>    commits whose flag bits may have been smudged and their
>    ancestors, recursively.  In order to use as the starting points,
>    the original array of commit rev[] that started the revision
>    traversal is used.

Thank you for your explanation.

To my understanding, it looks like calling reset_revision_walk() after
the while() loop should be enough. Am I right or am I missing
something?
