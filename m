Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567D1C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 19:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E51C20730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 19:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="dMJaJcVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDGTn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:43:58 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:41247 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGTn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 15:43:58 -0400
Received: by mail-io1-f50.google.com with SMTP id b12so4656346ion.8
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKcPykxDAU++Rrq1QHBGcwPz/o3ghSZF/l737/gD6qw=;
        b=dMJaJcVukJvixZcqy0OnpiuKBET01rpQERnyyh6MhkGiTB8MU1d6B2HXzUjLs18b8R
         XNMBP26VraE+4Q6x8W2CsfjD4nm+6eQZSauIOS0UlguJq3Z6lm/YI5yu2irzXIKgrVgj
         YSO2V5gRyxsFNoscv1joP/VpJYn2st8l9PiwONaxN5fCbZEHeAm78sq4cxOeBEb2TVev
         rMON2JoYwyyFIA2+XmZMXvX7wdk38uKKmtdkjjFxJRZsyhH/SdBpl8KnwzpH2uCrRA1z
         l8bdvF5R85PVZO51SIhNgt4uL3V6lXRsnPXVRwbZDHK+FOEaapzc9OekDVOMcJuLybG9
         iLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKcPykxDAU++Rrq1QHBGcwPz/o3ghSZF/l737/gD6qw=;
        b=YUAlIEQhQ230iQXHmXjagC5McapeOlRFxWVTub5p6KchRZDK79O9tR19LVFn3RPv63
         WG9OJd6AG7Zz+nGjtYJoXFo7QJ/11orztyzhLX/CQ+3nhKW1N2ZN1v1NtJVOC2BDrDKq
         c6LN3tVGnvi0Kvvz844mRrS6TwBBzdc0svUq9+xXTaGxNi/OW96hfA/xCLaT2nkFQ9F/
         6tiKgo0jNCk0t/w1aidLHWFguCPw9xrnJT8BbXbwJon2NzBvzjRZ7gnwf47IXrDyEos3
         qoEpO0H6ABkawMhKwmvhdZn2WwlN/zllh7Ftrm6J7cy4IgH7ktjQTQAl7y8KG8s9LIfo
         ku+w==
X-Gm-Message-State: AGi0PubqrdGTSvy8dqk52URql4eGR+az6Y51WRODcM3y8fCKGabSgv/Y
        WoH1tbO40MuWqtvEaUzAvKzaMHklXbLhso2lq5p+Up9hPEmjuA==
X-Google-Smtp-Source: APiQypKxV9/xB97p9JyqA/Pn+qk8RO1TZ2bvOaDgLbgCEiLaFsqKEM0+9oKzbVeZzT63WmA44ojSrtDYs6A0jFQICeE=
X-Received: by 2002:a6b:b703:: with SMTP id h3mr3710108iof.42.1586288636727;
 Tue, 07 Apr 2020 12:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAAb+AL8+c6knrQnoi7YOjyM+Wc8-rws-JXVufBc=PciAvPPFJQ@mail.gmail.com>
 <CABPp-BGFinonZJb2u_0-fX3y_UyJ1dY+O40oN0WAzZht0ddJ4w@mail.gmail.com> <xmqqh7xvtby2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7xvtby2.fsf@gitster.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 7 Apr 2020 12:43:45 -0700
Message-ID: <CAGyf7-GNHPB_9yDQhwzt5VjEe3-SOPM-DAntTojo+zmLoCzVzA@mail.gmail.com>
Subject: Re: New git-rebase backend: no way to drop already-empty commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Sami Boukortt <sami@boukortt.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 10:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Yes, from the manpage:
> >
> > ...
> >
> > and
> >
> > """
> > Empty commits
> > ~~~~~~~~~~~~~
> >
> > The apply backend unfortunately drops intentionally empty commits, i.e.
> > commits that started empty, though these are rare in practice.  It
> > also drops commits that become empty and has no option for controlling
> > this behavior.
>
> This is a very good illustration that shows why "switch the default
> and retire the apply backend" deserves to be cooked for quite a long
> time.  The 'apply' dropping empty commits may have looked like an
> 'unfortunate' thing to whoever wrote the above paragraph in the
> documentation, but it clearly shows that person (me included) did
> not think of the ramifications deeply enough that there may be valid
> workflows that _depend_ on the behaviour.
>
> As we will be dropping 'apply' that could be used as an escape
> hatch, before we do so, we should teach the other backends an
> alternate escape hatch to help those who have been depending on the
> behaviour of 'apply' that discards the empty ones, whether they
> become empty, or they are empty from the beginning.  I think the
> "has contents originally but becomes empty" side is already taken
> care of, so we'd need to make sure it is easy to optionally discard
> the ones that are originally empty.

I wonder if the existing --empty could be extended, such that "drop"
was treated as a (deprecated?) synonym for "drop-new" (a new entry in
the list), with a new "drop-all". That way end users could pass
--empty=drop-all to get the old "apply" behavior with "merge".
Something like "--empty={drop-all,drop-new[,drop],keep,ask}::". A name
like "drop-all" seems more obvious/intuitive than simply "all" or
"always".

Just a thought from someone else who was also bitten by this behavior change.

>
> Thanks.
