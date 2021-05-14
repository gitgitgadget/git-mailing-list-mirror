Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F6C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 01:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5456961354
	for <git@archiver.kernel.org>; Fri, 14 May 2021 01:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhENBCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 21:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhENBCb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 21:02:31 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749A1C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 18:01:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e11so22408287ljn.13
        for <git@vger.kernel.org>; Thu, 13 May 2021 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i6kru9vtSh5SiB+JYK6RJiAHCQSIPGpAN/SLtebyrI0=;
        b=VklXyMA4IpxwIVLf8bosOEHFfBzxB/7P670D4A+K34/iECaEA1ojGW0mWNjMelfELj
         4FMeaBXY9a4d5RViNK+RdRxzrxS/guky4ILkrgUWbgmdGX2yFdtZko+673MkKxSBmoud
         plTEKE6bZQcqY39Sv3xyRy+C7TNwmlbssc7zMWgT1q8NNj83DiQFrcY+wHf0gf0bx1tu
         lGXgDy23QkO2Gy1Y5FvbiZNEGJFRMTPd2dBhjE1UQOIRd37M1gXa0x9pWoTM7WuwsnRm
         8YXxLo4yiQ0IxrNZSfYJxSRxmILDgy0Aw79ljGVL5dKeakVVsHSntpRhWyZLHWoTzysn
         LbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i6kru9vtSh5SiB+JYK6RJiAHCQSIPGpAN/SLtebyrI0=;
        b=s2vDYeqz5A7gOKOPAjNrDWlXNMUEMpZN4w+/vwiudd6sfhobT9c1hA6hxWaA5qhyGI
         4SUTaT/CatjOtDNhw8I8fOhfbW7pf3gt79YdmW+hbhqJDdITVNkTdKFzYzADvDsTlm42
         kTYcuOQ22HNhCsi+FrpXE3swcY8T31QPNYxkOGVS6tzaPq5sjIVwVZZFxhzbJF07wAA8
         wbdyYnpqDvNVFOy7iJkbvXWt/P4tejVWZzmUFiREn78E0M3IQByh8/PrlrYZm6tbWNy1
         q9KZn/XEhCsuMv+SFnyVzfxc7oAukXHsvIygsV5sPc15VnmGofJK7gnHpkWboXFn19te
         Oesw==
X-Gm-Message-State: AOAM533tOE+ek2qV1w04yBnK1uxC/YL0Dch/V7LKEhAApdLhtHG2Jup5
        50hW35J5k+I6VZqGvWANbe54koAEKeV5haKAsTI=
X-Google-Smtp-Source: ABdhPJyPPkjr4rCKFHBb7skPd2YLoOfH6jFfGyM7bYAxHIVAjmZX39jaLoeekcQp9SHNhyoMCE1i4hkU4YP3uVbZzOc=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr37585806ljg.74.1620954077972;
 Thu, 13 May 2021 18:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <87r1iakbyn.fsf@osv.gnss.ru> <CAMMLpeQ8_isyDtP34p+_tEK3JAasfro7dJbVrTVPZ7C4q0kT6w@mail.gmail.com>
 <YJ3LJ++lsAuSkCUJ@danh.dev>
In-Reply-To: <YJ3LJ++lsAuSkCUJ@danh.dev>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 13 May 2021 19:01:07 -0600
Message-ID: <CAMMLpeSaJ-tr64qMATJOodBa=jtSvN0+AdDWpGxPG09XwSfvEA@mail.gmail.com>
Subject: Re: Rebase options via git pull
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 6:58 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2021-05-13 18:49:03-0600, Alex Henrie <alexhenrie24@gmail.com> wrote:
> > On Thu, May 13, 2021 at 7:23 AM Sergey Organov <sorganov@gmail.com> wro=
te:
> > >
> > > Hello,
> > >
> > > Is there a way to specify additional options for "git rebase" when it=
's
> > > invoked via:
> > >
> > >   git pull --rebase
> > >
> > > ? What if rebase is used implicitly due to "pull.rebase" being set
> > > accordingly?
> > >
> > > In particular, I'd like to be able to:
> > >
> > >   git pull --rebase --no-fork-point
> > >
> > > but it doesn't work.
> >
> > It would be cumbersome, but you could run `git config rebase.forkPoint
> > false` before pulling and `git config rebase.forkPoint true` after.
>
> Or, for this *specific* case:
>
>         git -c rebase.forkpoint=3Dfalse pull --rebase

I forgot that you can do that. Thanks for the better answer!

-Alex
