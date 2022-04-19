Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73212C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 15:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353691AbiDSPN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 11:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244276AbiDSPNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 11:13:55 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6CE34B8C
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 08:11:12 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id b81so7668844vkf.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=re8mLwvfZUg9+Qyn2xXxgsRztGs7Q6y4UDAbZb2OcIg=;
        b=a4Bv61fadDRph0l7vByWPutAUu5gXNAHlxISSAlkMKQuMEbS8SJDplM3Gq0pvj2+2y
         HEv6uixwzMewo/MAocFpYmsa3JHZDm+PkqTuALuSChV5Qk5dAmR2m+kU+HLAniW8CrXX
         Rvlm5xkaxP6ERrq8ISaNUL2dhUgOM67DUEusyKrR7X3ACYRbvMKkeeQqiQzm5xR6pjq4
         07xabb9Ul5Ay4b8jsnrOq48Ytwr4QLFykBj203ODQaJvGo2Jm9jjr5Ldn5NcWp5IH8Lm
         bXtXvNDvgnc653JIpCaKM1aSmVxoYyNw9xK2hkeHeVuGljBebxjQA/7mmpx1eOsGd/Z5
         bGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=re8mLwvfZUg9+Qyn2xXxgsRztGs7Q6y4UDAbZb2OcIg=;
        b=yk0RMlqx4EWAkGGEXNlZFpe75mTfQWDkjppDaXEiY8hmbaBJj1NHq4PASkw7j2h8r/
         VEeHxT2NbyQPBsBJ9ICS7rkdeiPnNx7zwufzhCg0JhRsJe2pThlDJ7nSnMd1y8xp1m8v
         5KMfgkdGntMky6ePO68EXNj15SEZb6xq27uN9ScltCOTCRu95Oittr9b8UApsRXo8zo5
         cLOZLhBh7V6BSadoXtKet1IPKdjtckPHvQX7P16juqbuMcYXfCT1Fxgg2rfSMD65oc1D
         323JiZZMkykXorzUs1NTbXEaYMJ5kYUHhwx39a0tiFmlMB7DTc2i93pMNYrF7st3u55J
         B2+w==
X-Gm-Message-State: AOAM532e2ld2ONg/WTyFhlyoAmwKr8c5hKGDBhrgR+cPzgSsqKYDZ8ZB
        7F/z4LtAqGBJ9oyWJF3s3WRKuqkcbTOS5CAU87hkS05e
X-Google-Smtp-Source: ABdhPJwHM1QHgK35xGVJitO88XIGgF+t3C3L10OvWAXC43P91HI4yt0bgiBJarJfjc5JX048JxgPXYLcXJ1orsLKaXU=
X-Received: by 2002:a1f:a997:0:b0:345:1996:2e97 with SMTP id
 s145-20020a1fa997000000b0034519962e97mr4698671vke.38.1650381071288; Tue, 19
 Apr 2022 08:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
 <CANiSa6ipgk3dRJfOh6i1nL=QqtPTZ6n4ZheT+JowarMTOaeuDg@mail.gmail.com> <CAPMMpog-=m2e9mgFMvUhHKLPPboqP1gkg5GkHJF2tswjp+P-1g@mail.gmail.com>
In-Reply-To: <CAPMMpog-=m2e9mgFMvUhHKLPPboqP1gkg5GkHJF2tswjp+P-1g@mail.gmail.com>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Tue, 19 Apr 2022 08:10:59 -0700
Message-ID: <CANiSa6i7iyVB4uoy1fF4EmorGFoDgYsf1zEO6F6UPeBSkSfjJA@mail.gmail.com>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2022 at 2:50 AM Tao Klerks <tao@klerks.biz> wrote:
>
> On Tue, Apr 19, 2022 at 6:25 AM Martin von Zweigbergk
> <martinvonz@gmail.com> wrote:
> >
> > Consider this case:
> >
> >   X
> >  /
> > A---B---C
> >  \       \
> >   D---E---F
> >
> > If you now want to rebase E onto X, and then F onto E' and C, then
> > Elijah's suggestion (and what my VCS does) will work correctly. If I
> > understood Sergey's proposal, on the other hand, the utility merge
> > would bring in the changes from D as well. Or, put another way, that
> > algorithm is only useful for rebasing "internal" merges, where the
> > merge commit is being rebased along with both (all of) its legs
> > (again, if I understood it correctly).
> >
>
> FWIW, I don't believe this to be the case. If you rebase E onto X, the
> way the "D side" of the merge will be resolved, on X, will be as a
> combination of "Addition of X" and "Removal of D" onto the previous E
> commit state. The secret sauce in Sergey's approach is the application
> of a patch representing the "inverted change" to the "D arm" of the
> merge base in the original merge vs the "new D arm" (which  happens to
> no longer contain D and have X instead - I just have no better way to
> refer to it).

I see, it applies a reversed D onto E before creating the utility
merges. That makes sense.

> I haven't understood or explored Elijah's suggestion (or your
> implementation), but based on your description, it sounds like they
> end up being equivalent in result, but maybe present any conflicts
> differently (as a different patch applying to a different base). I
> expect cleanly rebased merges to come out the same, and the same
> situations/scenarios to lead to clean merges vs conflicts, but the
> presentation of conflicts to likely look different.

Yes, pretty much. I expect there would be some minor differences but I
can't think of an example.
