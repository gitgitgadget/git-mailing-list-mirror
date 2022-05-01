Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C3BC433EF
	for <git@archiver.kernel.org>; Sun,  1 May 2022 23:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356164AbiEAXlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 19:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEAXlB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 19:41:01 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95CB3054E
        for <git@vger.kernel.org>; Sun,  1 May 2022 16:37:33 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e2fa360f6dso13037276fac.2
        for <git@vger.kernel.org>; Sun, 01 May 2022 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P90v6xt1hT7uclMoalPL7XlaeaHiaJCGzVc2gE1HwN0=;
        b=mS+2IozEGXVsVshGQkAuxeoGL3u4AMGPauXBP11FG0kyxtkNm51CMjNo/QHQRa4CNO
         T1CrWLGYPKP4evW9wzS4rHhiTlpqR5p2kJXl18tznCWiYfBqClT/NID1FCH//3hnijbG
         Wxw8SaP/KQAynmpGpOK7qjLHlU1XChi+Yw3UaImU3QaSIvBTM6hcHIiMVwgdLcrJyOlc
         sr/IXqc+8XKXmzDNudOYH+o149FP9yq2/8V6Y2zMOM7cnzr1YkLlBqrceuc+ZC2cnGd8
         0enXnNDWOIIXIbt5ceB2J8hOmuEhT7j62T9EcTmlC509ejVCdarxDKMUcW0bB8hxVczd
         4mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P90v6xt1hT7uclMoalPL7XlaeaHiaJCGzVc2gE1HwN0=;
        b=TS83946fI5ST+B40caF1ZU2Zi8ux41t0zjV17dB7wbwH0TsG+bJkqkNonLD25zU8RQ
         CxZh12U3+rxoqF6aHksP9sDuF1WG0ReTNdDDfMMJYr94RcpsgtxdldFA5zqP/PW1xUuQ
         ITK9B3jzL1UJ4XOWjRpa4lqDvvtlyqlwDnNfeRTK/jhmyOrKf1SohytvX+cky/jC3nvY
         3R7N3lMZ/v3f/UOAt7SACkfAjAMKSpVfpFk3w2l5D/KEuPgsz5h+QY9tF08NkAP1sT92
         gWn5Wn8i7mpPZy4QjdPCuIyWvZmYFZw73htXfmB9NrfGtAGflBY3CeljG4+WVeiSgQH6
         KrAA==
X-Gm-Message-State: AOAM531FZbwI8tUP/EzLV7hgbuyUfWUywoBdvO2IW4471kzyQlaP3n6J
        vDvV+dZh0gzxPwk7IO9OgDl7WQZaRIozayHvuGSBbfkuje0=
X-Google-Smtp-Source: ABdhPJzbgJd9nGersWJ9F7W6BAf1sQ0EVtRxR7YY4WFIkeMpVldhhClBoWIV0M1wUyH/6rDD4T5Mwqnv8tWD208TmMY=
X-Received: by 2002:a05:6870:58a8:b0:e5:df4d:2b37 with SMTP id
 be40-20020a05687058a800b000e5df4d2b37mr3706381oab.217.1651448253002; Sun, 01
 May 2022 16:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
 <20220430041406.164719-2-gitter.spiros@gmail.com> <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email>
 <xmqqpmky70jb.fsf@gitster.g> <a3e06290-052e-af36-4170-301e567d561d@iee.email>
 <xmqqr15e5fm3.fsf@gitster.g> <xmqqmtg25cjw.fsf@gitster.g> <CA+EOSBnx3-G02=zXGUrRuKPTDPBSYoBY=rERCORe8NtywEOiGg@mail.gmail.com>
 <xmqqbkwg4zi7.fsf@gitster.g>
In-Reply-To: <xmqqbkwg4zi7.fsf@gitster.g>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Mon, 2 May 2022 01:37:22 +0200
Message-ID: <CA+EOSBkUrkj=HxUg8s6P88jPZxgs1Zc9FUUC=CANKYu9mmP39g@mail.gmail.com>
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno lun 2 mag 2022 alle ore 01:14 Junio C Hamano
<gitster@pobox.com> ha scritto:
>
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
> >> What I found curious is that the result of applying these patches to
> >> v2.36.0 and running coccicheck reveals that we are not making the
> >> codebase clean wrt this new coccinelle rule.
> >>
> > It is possible, I did not use coccicheck to apply the semantic patch
> > (on next)  but i use a my script which I think is slightly more
> > efficient but perhaps it is not so correct. Anyway, given the
> > discussion that has taken place so far, what do you think is best for
> > me to do? Do a reroll (perhaps with only 2 patches in total ) or wait
> > for the "right" moment in the future as foreseen by the Documentation
> > and dedicate the time to more useful contributions for git? Thank you
> > all for the review
>
> Hmph.  Even if these patches were created by coccicheck we should
> sanity check them to make sure we are not applying some stupid and
> obvious mistakes, but if they were created by an ad-hoc tool, it
> means we would need to check a lot more careful than a patch that
> was done with a known tool with a clear rule (which is what running
> "make coccicheck" with your new rule file would have given us).
>
> To avoid unnecessary conflicts with in-flight topics, ideally, we
> perhaps could do something along this line:
>
>  * Pick a recent stable point that is an ancestor of all topics in
>    flight.  Add the new coccinelle rule file, take "make coccicheck"
>    output and create a two-patch series like Philip suggested.  Queue
>    the result in a topic branch B.
>
>  * For each topic in flight T, make a trial merge of T into B, and
>    examine "make coccicheck" output.  Any new breakages such a test
>    finds are new violations the topic T introduces.  Discard the
>    result of the trial merge, and add one commit to topic T that
>    corrects the violations the topic introduced, and send that fixup
>    to the author of the topic for consideration when the topic is
>    rerolled (or if the topic is in 'next', acked to be queued on
>    top).  Do not fix the violations that is corrected when branch B
>    was prepared above.
>
> As I assumed that applying the patches in this series would create
> the branch B, and then I saw that the tip of 'seen' after merging
> this topic still needed to have a lot more fixes according to "make
> coccicheck", I got a (false) impression that there are too many new
> violations from topics in flight, which was the primary source of my
> negative reaction against potential code churn.  If we try the above
> exercise, perhaps there may not be too many topics that need fix-up
> beyond what we fix in the branch B, and if that is the case, I would
> not be so negative.
>
> Thanks.
Thank you but it seems like a very heavy work for something that had
to be much simpler. IMHO my contribution, if deemed useful, ends with
the patch that adds ONLY the cocci script, which can solve a style
problem identified by the documentation. And it sure works, if
applied. But it is not necessarily the case that there must be to the
same time a patch series that actually applies the script to the git
codebase, in any development branch. This can be done at the most
opportune moment by anyone who wishes it, from my POV.

Again, thanks you all

Best Regards
>
>
>
