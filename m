Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC981C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EA72227E
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueL99zC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgJRUld (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgJRUlc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 16:41:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E60C061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 13:41:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d81so8373934wmc.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJ279O4zWLoT00FtNMWtTEnDaAT2CZWXPZA32Dnkcc0=;
        b=ueL99zC+8yWkQ7Vuwn0/Eg+7OuXxFz4R7AotJSMgzP1aiu6AUsG3LOzIVB/bG13HZA
         G875gmPHKJx3bTCiI3FMtgkbxHOhZB83m0dFANlGvVDNZK14Px6RvDye+yhQWXJUFLTc
         sFM+pd0WEqsrYK5aIEIxdVyXBetrJVFRfEEsrMAfIZM4Qa17B3q4WjiIc943V0vo8dLp
         BLizpI1QE1E9EeptQXxhDrPgDqX2Mt61ToZHGBhKl3Np+9qKvqOcfbfPEI5FH1ET7ESv
         4wrCkORrP8WVFzBF99rvWoQR+Cz4ovUmPlqhL/WvOJlfMng4/oASp169+4CihubucX3P
         7GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJ279O4zWLoT00FtNMWtTEnDaAT2CZWXPZA32Dnkcc0=;
        b=BmYoRbdomTwg0RpKV4Yfo5aMoUJiNy8AZ3bHdmBsrT4Tdy+0Qbv6dHpylJfMIiXLmn
         OfBQzMc66Pew2RxrMA1j34pwBMoxyHN2kbO14rScz0xM+bbTskEFb3gxorAVPuAshTn+
         Hojku34dtuZAwyWB3EheWC+e4QqXLKL3RZ6ZKpobeemyhHKTOQZ9yu0218lgARIksyxg
         EpGRQifJTlJaHvmCs7ZadJZyZ9cI3I+8mzgoAEqKI75DGFCg1usGCZ5DP9JQEIjMdHsu
         UKoqTl9JDvFwBUb7QKnbrsMBHnT5+x1pFdh7HybFl1KMjDI2iZlTm1aIhPMc3pOh9xKT
         msCw==
X-Gm-Message-State: AOAM533Z5j1xKdO1KE4Vmx6dho3clsnL1ln4LiOcC7tvAi7JvNqntH1a
        QRzub0jsis8VLemKNzMMJ7egYijwOiOuRI98/KQ=
X-Google-Smtp-Source: ABdhPJyXpTtLSZdmuh1cK9KWHEtKjTCMQL42WtfeFz4o+AgY+i/GnTjsKMtKx3uCjaGj3zaDC1PWLoVWu8zGDjvM3A8=
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr8250973wmb.114.1603053690928;
 Sun, 18 Oct 2020 13:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
 <pull.885.v2.git.git.1603032125151.gitgitgadget@gmail.com> <CAPig+cR7Hm9m1EiWkr5tKYS3r_zJf98XT7OQ+-Jt4EWkaFQTDw@mail.gmail.com>
In-Reply-To: <CAPig+cR7Hm9m1EiWkr5tKYS3r_zJf98XT7OQ+-Jt4EWkaFQTDw@mail.gmail.com>
From:   Amanda Shafack <shafack.likhene@gmail.com>
Date:   Sun, 18 Oct 2020 21:40:54 +0100
Message-ID: <CAGxm6oVtOuQjOEbPVtn_KOjE9nBmW=49jkdE-KRdAg-i0Quxsg@mail.gmail.com>
Subject: Re: [PATCH v2] t9832,t2200: avoid using pipes in git commands
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Amanda Shafack via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 18, 2020 at 8:25 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Oct 18, 2020 at 10:42 AM Amanda Shafack via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > t9832,t2200: avoid using pipes in git commands
>
> The subject is a bit confusing since pipes aren't used in Git
> commands; instead, Git commands may be components of pipes. However,
> even that is too imprecise. The issue this patch is addressing is that
> we want to avoid Git commands _upstream_ in a pipe. It's perfectly
> acceptable for the Git command to be the final element of a pipe since
> the pipe returns the exit code of the final command. So, to be more
> precise, the subject could say:
>
>     t2200,t9832: avoid using `git` upstream in a pipe
>
> Nit: It's subjective, but it feels a bit more natural to list the test
> numbers in ascending order rather than descending order, which is why
> I swapped them around in the example above.
>

I agree it looks more appropriate.

> > When a git command is upstream in a pipe, an unexpected failure of
> > the git command will go unnoticed.
> >
> > Write out the output of the git command to a file, so as to actively
> > catch a failure of the git command.
>
> It's easy to see from the patch itself that the output of the Git
> command is now written to a file, so it's not necessary to say so in
> the commit message. Therefore, the entire body of the commit message
> could be written more succinctly, perhaps like this:
>
>     Avoid placing `git` upstream in a pipe since doing so throws away
>     its exit code, thus an unexpected failure may go unnoticed.
>
> The actual patch itself looks fine, and these comments about the
> commit message are quite minor, thus there probably is no need to
> re-roll (though feel free to do so if you think the bit of extra
> polishing of the commit message is worthwhile).

I believe it's best practice to optimize one's work as much as
possible, so I have included these changes.
Thanks for the detailed explanation.

> Thanks.



-- 

Cheers!

Amanda  Shafack
