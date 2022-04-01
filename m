Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389D9C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 04:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244848AbiDAEcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 00:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiDAEcm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 00:32:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71A11FF433
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 21:30:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o10so3404387ejd.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 21:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+kfkO+VRkYJVcpfXILHASPT//TpvOgLdE4tItZUn50=;
        b=ZplHcU2ZnKJzurp7sDsJWLQSyVeAAid25/rdMSBQHiruQnlaePw+1iGAvgyuGz+rK0
         q+gxA7qPX2s9SO+bBrkbFC7KHbSBH4ftgJCpB5mY6mYOmSwfazVxbwQtTKErG4NpR+x4
         7vOUmlDanmRoy0bvAzrUUHWlJnUp3YlsKpDJnE8mJwyWr6vjHHjiOTlCBJZK97yX6A40
         OuDmNKOZxb4W+lIqidx3F7wDdojU4H6FQeRypJy8NwDObD43SwNufw4iIlrvnok00xh+
         hrLNI3Y7cwH/imX59NFP1thq7j7KE2yhrZnSQDKa4nwEWxZfIBI6JIzT1wtnWFSL1B+k
         wgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+kfkO+VRkYJVcpfXILHASPT//TpvOgLdE4tItZUn50=;
        b=gfnNW2rgZKiTMuBJbHUucp8Z/u7k8WHyy60C4C0rL1REmSudpliX1nBQQ6tbTFoOFl
         ZXi2T++udXcX8gR5WoBxWO9dmH/WzShhfjq8Yd/exP89scOhVm+jPAJPA7DVxFaPqpkM
         2uLC+QLkdQnKhUcNuegk1QyUkW/8+mntfB4kbsTGjU7zbsJN5zZPdYBbAa7qOJb9iYeV
         NeIGZlrm0qTstiZVT3Vj0ag17esJL9SYo2QAbG134At8BOijoKVI5/L7WbQPOzgigV7p
         MyTUOmGcRwOTnrkWc6RbQ5TdyA1rMXFtTouCcPyK+MFujFhfC/2n1zKkbYObMpFZcU28
         cGBQ==
X-Gm-Message-State: AOAM530WjA38xFtkcd7vqpmpyBv6OvjAHDHZxoL6HEfRSaGXHT8o8Vo/
        7G87eLbnhRiKW9OLl7D1hHqPPTyjTpH6yiQr0kbrJwKLOyAVwvwl
X-Google-Smtp-Source: ABdhPJzI2HmOytIhF0o1kf2IdY1GntPXCOK8nreiXCMQho+sg+7ApCqxRx8Rli7eqQWYEGVh6wbioWfyfnpEGHJSYVk=
X-Received: by 2002:a17:906:4ad9:b0:6cf:93f:f77e with SMTP id
 u25-20020a1709064ad900b006cf093ff77emr7879704ejt.558.1648787452285; Thu, 31
 Mar 2022 21:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
 <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com> <xmqqpmm13okb.fsf@gitster.g>
 <kl6lsfqxsmj3.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lsfqxsmj3.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 1 Apr 2022 06:30:34 +0200
Message-ID: <CAPMMpojb7-tD2kFNZPiaC0MpB8GNXtYqpJs796pRcM7pE=ksmg@mail.gmail.com>
Subject: Re: [PATCH v6] tracking branches: add advice to ambiguous refspec error
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 1, 2022 at 1:57 AM Glen Choo <chooglen@google.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >>      if (!remote_find_tracking(remote, &tracking->spec)) {
> >> -            if (++tracking->matches == 1) {
> >> +            switch (++tracking->matches) {
> >> +            case 1:
> >>                      string_list_append(tracking->srcs, tracking->spec.src);
> >>                      tracking->remote = remote->name;
> >> -            } else {
> >> +                    break;
> >> +            case 2:
> >> +                    /* there are at least two remotes; backfill the first one */
> >> +                    string_list_append(&ftb->ambiguous_remotes, tracking->spec.src);
> >> +                    /* fall through */
> >> +            default:
> >> +                    string_list_append(&ftb->ambiguous_remotes, remote->name);
> >>                      free(tracking->spec.src);
> >>                      string_list_clear(tracking->srcs, 0);
> >> +            break;
> >
> > Just to sanity check this part,
> >
> >  - During the first iteration, we append tracking->spec.src to
> >    tracking->srcs, and set tracking->remote to remote->name;
> >
> >  - In later iterations, we do not want to touch tracking->srcs, and
> >    want to collect remote->name.
> >
> > And "backfill" assumes that tracking->spec.src at that point in the
> > second iteration is the same as what we got in remote->name in the
> > first round.  If that were a correct assumption, then it is curious
> > that the first iteration uses tracking->spec.src and remote->name
> > separately for different purposes, which makes me want to double
> > check if the assumption is indeed correct.
> >
> > If it were tracking->remote (which was assigned the value of
> > remote->name during the first iteration) that is used to backfill
> > before we append remote->name in the second iteration, I wouldn't
> > find it "curious", but the use of tracking->spec.src there makes me
> > feel confused.
> >
> > Thanks.
>
> Thanks for bringing this up, I also found this unusual when I was
> reading v5.

If you never hear from me again, please know it's because I crawled
back under the rock I had crawled out from. This is clearly a bug from
a silly typo, and I've managed to look at the resulting output twice
without noticing the wrong thing was printed. I'm guessing the use of
the word "unusual" here is a polite euphemism for "you numskull, what
you wrote makes no sense!" :)

I did not think adding an automated test for advise() output made
sense, but I guess I have proved myself wrong.
