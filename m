Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6AAC433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA6861423
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbhD1Slf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbhD1Slf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 14:41:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2B7C061573
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 11:40:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h10so75476500edt.13
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtR9asX9yCMM4LyLb/ASYePpiRGFr4OiTy7pFx5cs+0=;
        b=WwrA3B46BwqHQmH+Ff+A5EpeflIlgquXBFiZmihnXhRP8KG3rXG18j0XlwHsL21Mn0
         My4bjAAUuRX/CQ9Ep6zGB4BmIj8rLZzTkqgsHxNChYPaKD9DTPBkr2pmtEhDvm9QIgXz
         I7WYykF0jPC5zXgIm6dWiEMIOEicUDfZQgl2PcWL91jFi6j8mpo+NAbFjnZX4VWLY+86
         68CUvNhU9TOAtBt2Jg4Hh6J8BKu9E3kJ78OQnUQvKeDDPjYKvMLjO5g/fjkpQk5l+glw
         y4fmYqfeUsDCHLUxl6ilNpv8W01T7wiwNIklmFo1jMd47sXsvSWWn9dEW0MZAfMQmVTT
         WmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtR9asX9yCMM4LyLb/ASYePpiRGFr4OiTy7pFx5cs+0=;
        b=YH4qNoibGe6/XH6U2iovwQ9YX5dlPxs2j+dUEgjtWHBJL9sDvA0hsS4n5cBU+qEOBr
         RSzZdMY3FPYnj2vgmomDF1kTzE72hnEuQBHO/CSY0WZ271xarhB38cnDq7Q3w3qrTmPw
         VxtFwIn4b5T139lkPCJQeXX+/r5QfiVRpKSjGOs3k9k0uHvbSGqNXVe0Y52UsP/duexU
         5WblzB8rcmMpUQW/6SdEa+hrxGQsBYmjPR3k0r+OBQWCrnfEHzbHCWuuLV+8AErqlQxI
         GyvZ/WXlwkTIiqYMAgnJjYrh3CqQon9xMHcDFf+nrB6zjtFWRzdHwNEMSTbdeTJkvPCM
         W7hA==
X-Gm-Message-State: AOAM530qNapmVNZuR43lCn0fxtRH12KXjpmcv9KsV1gy6avs56dKy2ND
        vZHObszeIbJvSOVQ7KTvNRhRLNocdDmhGKtQdIV9Nw==
X-Google-Smtp-Source: ABdhPJzCiRFvs/qo52wX07WVagamRVUUHh5QJihll1AYhl4safBV7yH2R0Krjp+4Os501FDDp3CK4OmtzVmUk0t/cJE=
X-Received: by 2002:aa7:c9cb:: with SMTP id i11mr13337826edt.331.1619635248482;
 Wed, 28 Apr 2021 11:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210427011246.28054-1-jerry@skydio.com> <20210427194049.14399-1-jerry@skydio.com>
 <xmqqmttjate1.fsf@gitster.g>
In-Reply-To: <xmqqmttjate1.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Wed, 28 Apr 2021 11:40:37 -0700
Message-ID: <CAMKO5CvHWDQNFoPeon99K97vUY0Y8WCbBcJghGyJT9XUr=nYqA@mail.gmail.com>
Subject: Re: [PATCH V2] git-apply: add --allow-empty flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 27, 2021 at 10:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > Some users or scripts will pipe "git diff"
> > output to "git apply" when replaying diffs
> > or commits. In these cases, they will rely
> > on the return value of "git apply" to know
> > whether the diff was applied successfully.
> >
> > However, for empty commits, "git apply" will
> > fail. This complicates scripts since they
> > have to either buffer the diff and check
> > its length, or run diff again with "exit-code",
> > essentially doing the diff twice.
> >
> > Add the "--allow-empty" flag to "git apply"
> > which allows it to handle both empty diffs
> > and empty commits created by "git format-patch
> > --always" by doing nothing and returning 0.
> >
> > Add tests for both with and without --allow-empty.
> >
> > Signed-off-by: Jerry Zhang <jerry@skydio.com>
> > ---
> > This patch applies on top of "git-apply: add --quiet flag".
> > The conflict is in Documentation -> Synopsis and is
> > trivial to solve.
>
> > V1 -> V2:
> > - Moved behavior under a flag
> > - Added tests for both cases
>
> When people add a flag (a boolean option), it becomes tempting to
> add a corresponding configuration variable.
>
> I wonder it this step should start calling
>
>         git apply --no-allow-empty
>
> when "git am" drives it, so that a futre end-user configuration
> variable would not break it?
>
That's currently not necessary, since "git am" can catch empty patches
before it ever calls into apply.c:

     if (is_empty_or_missing_file(am_path(state, "patch"))) {
         printf_ln(_("Patch is empty."));
         die_user_resolve(state);
     }

If someone does make a config variable I think it might be convenient to
teach "git am" to use "allow-empty" as well, since applying empty commits
can be useful for documenting the history. The config variable could then
control the behavior of both "am" and "apply" since they are used for very
similar things. Of course that's up to the decision of that hypothetical person
since I don't currently have a need to change "am".
