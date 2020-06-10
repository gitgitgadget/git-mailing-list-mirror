Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287CCC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 03:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03EAC207F9
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 03:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJteWUkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFJDnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJDnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 23:43:22 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61DC05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 20:43:21 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y5so582288iob.12
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 20:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bwB7oemie52O6ZkgPXlMiWt9kykhoFnBXKjUD0VSfhM=;
        b=tJteWUkVunlS7ZkmtdNR34ki6ZsdYEYaEBqnDLV+XtBgOUNUBbMjMxWJ5c969Eby5+
         2a8w+Fs/hq3Jo7Z1FxKvWwZqc14LEHAqIkwuljiXQJDuX9nVKsZbRQX/HjOCSHtKHwf4
         Zs3m9gJRkOoR+fCxqSaF7jIYytXp4h2nJd2Ynk/2/9J8ZI1MGVpDJdyA+CPb+1NBAgdi
         OqDYnIGi9NDIGTcnHKI0nnxNI9FoEcahcJFtzX5gpIqQqM/+XY+vaUyBN8l/EDtl7j5o
         fVrl8V69vJ4sAymFrCSu5X+1Zsf3826rtt/xPQ0D91ows9OHnCfti9Kaz0ym8aXU2i7n
         KAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bwB7oemie52O6ZkgPXlMiWt9kykhoFnBXKjUD0VSfhM=;
        b=Pvxtq+FCFb8q+1jUP29jSy96XkZo6hFoGQ+pK46us6eRjawn6zUuIikR7Xaoyd+79q
         FWESZDGzZJWUUeRhLLGHrs3nSGQY6eYdwviK4hbabjkxJn7NA5xLms91/dEoGLRNrFr9
         wF2NBv2rb1pSdAun9qLzoskcwFqnf/KY4/jMW6/5Y6jRSehim1/kyMGxKT9iFVLhXvER
         OMaFNaTJgzv4loDZTNDA8297g/z+3zrbsCQYlNv1vvbLljlgQj/8UAgCN054VttuX9iH
         2bKmwy1Jd1XDgdSfaDA5XUG6FJZoRt3ZCGRuMjUuJGiP+MWiOoV/375nolFEyHO6NAMb
         +h4g==
X-Gm-Message-State: AOAM533bzaOqFdVcdMNpM5MilqGqb+QqaqlrWmH0Bv/SLXr/onZy9f1O
        VhIGi7+k2crsTAOqwM4P+OjPoLpDQ3A8Jg4v3Jw=
X-Google-Smtp-Source: ABdhPJw+UbMZsMbV5G9+ZBwHcyLz/spyKc2MqR9A+Jkxced5JMGG0wRDoORFl55ayDnmAmsn5JvzLLOPjieOy02qcuk=
X-Received: by 2002:a02:b782:: with SMTP id f2mr1293474jam.91.1591760600489;
 Tue, 09 Jun 2020 20:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.652.git.1591581739031.gitgitgadget@gmail.com>
 <pull.652.v2.git.1591662224566.gitgitgadget@gmail.com> <87bllsa47u.fsf@evledraar.gmail.com>
 <xmqqa71ci5vd.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa71ci5vd.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Wed, 10 Jun 2020 11:43:09 +0800
Message-ID: <CAKO26MuO6UR8c5U+WX0ayEJjmXEnsp9P=ujZGwasM7KbrUgcRw@mail.gmail.com>
Subject: Re: [PATCH v2] gc: recommend `git gc --prune=now` instead of `git prune`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Thank you Bjarmason & Junio. If Denton doesn't have other concerns,
I'll start working on adding bash completion for "git prune".

Best,
John Lin

Junio C Hamano <gitster@pobox.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:03=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Tue, Jun 09 2020, John Lin via GitGitGadget wrote:
> >
> >> From: John Lin <johnlinp@gmail.com>
> >>
> >> `git prune` is a plumbing command and should not be run directly by
> >> users. The corresponding porcelain command is `git gc`, which is
> >> mentioned in the man page of `git prune`.
> >
> > This change feels incomplete without a change to git-prune's
> > documentation, see 8d308b3540 ("Documentation: point git-prune users to
> > git-gc", 2008-04-29).
> >
> > I.e. it still talks about "in most cases you shouldn't run this", but
> > here we are removing a case where it would otherwise make sense because
> > the user shouldn't use it directly.
> >
> > I think instead the small change that makes the most sense here is to
> > just add "prune" to completions,...
>
> That's perfectly reasonable stance to take.
