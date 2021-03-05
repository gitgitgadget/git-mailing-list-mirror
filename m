Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050B9C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 06:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A7A65000
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 06:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhCEGPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 01:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEGPE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 01:15:04 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCE6C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 22:15:03 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id e45so766539ote.9
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 22:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pR1+BS3g+9GyhwJ+R1ZG5l6wfkZ7vYWUvzvm30+B1M=;
        b=iuKi+l1ioMlhJ3mB2T0gCZLjnB6tnuS2dJ06YkU6Y/rEHhBPpzC2kYs+HpA8dE/HFC
         tmupyrMJYpsKwJT9KVx3o5NXls2mXY15r89gSzUemWLkGzfPvV1V1dOsW3qzct7OcwFh
         V1P592Gur6FCk0Mbq4aM0s6ffqPI7LNmeUcIo+xkWxVu6gNl6AipalXa9SqEJA0ZpB2L
         T9fMpONIpE5+lrLbQnwKnBDvhmgO1vqLXp77Z1Y9ByRFPiqY0vuwJI9QBpr8O/EMGnYj
         WsRnyv1UIj3RIV+pEeDyz3SNX4QnXCFc9HOXyJziob7XLNTFAn2DptVtDSGxpRmNkgAN
         gGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pR1+BS3g+9GyhwJ+R1ZG5l6wfkZ7vYWUvzvm30+B1M=;
        b=ahgyvchWGTx9dXAZ52sBDMrLmATnLE+5wMqq9O9TmeT+L4bDr0ZbnmT7HSAXpoGp2y
         T9CMga88mF4xDABVf2tBJYBilAcQ8aClYxY0PsgYCGAalJH+0Iis6TkdPhZdGrCDcTTX
         Teux1arN67/01q7vfpubCXqHFZOPquDOGCpBE3Kc9ISQ+ruotcHOzDXUmpsi7UTBZx0v
         jxWoOTWqVdj1+Y565vzW9ea9gAPu2w9upKiZG7ey0L6hIkgvgunuS1vFIfHkWY32lQ+N
         xphIPOnTyViN/MtmQgoZjUJhYeK14qp0PaPYk57W9ANZFfqOCrYHKCCfGQRcniiGL3FZ
         um2Q==
X-Gm-Message-State: AOAM533DGPok7nhjnGi7nuMXlCwqzHeDxXe2Jd6EB+SAlPsgRb7VpKL4
        j0IaJpvD/4WPZoydgaaj/5eT/kqCCvHINI6nNLM=
X-Google-Smtp-Source: ABdhPJzbtFvrjBWjo6GH8hSYi3LfC6sst4RSyizTVmghZcm2DN4SeX600uabCkOz+vsaRxZCNoiEhleH6q3dxYoUCKU=
X-Received: by 2002:a9d:66:: with SMTP id 93mr6615211ota.147.1614924903085;
 Thu, 04 Mar 2021 22:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-7-charvi077@gmail.com>
 <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
 <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com>
 <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com>
 <xmqqczwfg23t.fsf@gitster.c.googlers.com> <CAPSFM5cM4fdyWXD33PkT2bH6kM+3ixkxgAnhjUVYFtjUHgwU5g@mail.gmail.com>
 <xmqqpn0ed0m2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn0ed0m2.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 5 Mar 2021 11:44:51 +0530
Message-ID: <CAPSFM5dM4NMeGqEG7hFLzyhJskqcrNtNqL9=MUCw9SEYYaFLoQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 5 Mar 2021 at 03:48, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> >> no paths, i.e.  If you have --fixup=amend, you can do
> >>
> >>     $ git commit --fixup=amend:<original> --only
> >>
> >> and you do not need --fixup=reword:<original> at all, no?
> >>
> >
> > Maybe as an alternative User interface, we can remove the
> > `--fixup=reword:<original>`.
> >
> > But for this patch, as we have kept separate suboption
> > `--fixup=reword:<original>` , so if now we do
> > `--fixup=amend:<original> --only` then it will return the error as
> > below :
> > fatal: No paths with --include/--only does not make sense.
>
> Yes, but it is something we can easily fix, just like we made
> "--only" without any pathname to work with "--amend" (or with
> "--allow-empty").
>

Agree.

> The reason I brought it up was not because "--fixup=reword" is not
> needed as a short-hand for "--only --fixup=amend" (but thinking
> about it again, I do not think it is so bad), but primarily in
> response to "would it be easier for users if we had reword! insn in
> addition to amend! verb in the todo file?" that was raised earlier
> in the thread.  If we position "--fixup=reword" as a short-hand
> and/or a syntax sugar for "--fixup=amend" and advertise it as such
> sufficiently to educate users, it would be easier for users to
> understand why they both result in "amend!".

Okay, so now if it's Ok to keep the short-hand "--fixup=reword" ? then
I think making the documentation more clear would be sufficient to
serve it to the users ?
Otherwise if the votes are more that the user will get confused as
both results in "amend!", then should we change this patch to "--only
--fixup=amend" ?
