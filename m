Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6FC56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB29E2083E
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opobpvWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgKYXsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgKYXsl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:48:41 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ABFC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:48:41 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so178173wrx.5
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TqpXhFqm3LcZOAbiq8VxDeo0zsv7Gsp3EJPf8UG5u6Q=;
        b=opobpvWQ2nOBTtiR2lbU2SLA+opHWCC0fFsqprPfOW07V6Z6jwV7A2OFt/bvOyFdlQ
         Z7jscPpi6N8BIMCkAZhXsjky579FPqkhV3Q+gT5jxQ6wujntuMEwRWtBrpzuTZ4a7YdY
         uRRH3FqwT5ahBl5i0g/tkyjbHOB0QcSUlIUYoQXIL+vua/LSc/oQT29kZADcoMSi3dfK
         24BRprKbZQsINf/TLFF+Nc+0H2pZzOMU2xnt6ZDQEeWD5o84+A+nPwmfgnDzfkKn/e0+
         QST9LRug1XAvWchnrsseupD0ZcgGcUHxy9e6dy9F9N+3+jM8cQT8EXzZIZS1jfR60ncL
         aR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqpXhFqm3LcZOAbiq8VxDeo0zsv7Gsp3EJPf8UG5u6Q=;
        b=Kzl4mtbyev8u1NsS9EfA4ZK0qXPQdhNLS/mopr8b5gRX5gAVf6YFjk9FddVX+YPGpQ
         yn8cWBlGuq7dGCjqdYUwoGhGPI5UmeNeyc4BrKRiZ0yZ9lmLLW5tVbp1alWQqWOPS47+
         6sLFNlV8z0MFIE0dd+IWmZetAmi0cCuogzynQJy8lR2YZeZX69Vvyjloz51FzI0SWpie
         m16FP15wGAVhO0sE/VcZUQm4E4g7VQkJnIfIsBcCoCXBg/8AAL9PPeeTWJdVh41CPg9k
         Qg1++4v/ovVkXMrQtlJrjd4OnQP+MDoZqxBTldk+XbPMmGNzSVQ4qOdLs6zMbQbzuYwN
         kEfA==
X-Gm-Message-State: AOAM533fLySEnkPIqBJQ8S3ou6KsiL+LtfUoIRuhx/OwEM3xD5xaW0TH
        UNKcdVta3WJgbwoew2KONbLKlDvF3GupPrKBtVkRft6pGzA=
X-Google-Smtp-Source: ABdhPJwwRt/HmMl140IF2AvrgCMB+K3wp/2p6/aqKE28wjvmxVBYYlL3Y/BSk8HjBilR5zCtftMvSvSPO7PFNfOhT8g=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr320936wrr.319.1606348120111;
 Wed, 25 Nov 2020 15:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20201125001102.111025-1-felipe.contreras@gmail.com>
 <xmqqblfmgtlg.fsf@gitster.c.googlers.com> <CAMP44s2ChcCjhjksS0s5BoYznqLAoXyFvSkP4GxSCh_ALusOtQ@mail.gmail.com>
 <xmqq360ygq2g.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq360ygq2g.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 25 Nov 2020 17:48:29 -0600
Message-ID: <CAMP44s2cpPgg55XHTr=cRqRcrMOkU=qcrM=RpWYwVJJdd9V4JA@mail.gmail.com>
Subject: Re: [PATCH v2] refspec: make @ a synonym of HEAD
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 7:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > On Tue, Nov 24, 2020 at 6:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> > +test_expect_success 'push with @' '
> >> > +
> >> > +     mk_test testrepo heads/master &&
> >> > +     git checkout master &&
> >> > +     git push testrepo @ &&
> >> > +     check_push_result testrepo $the_commit heads/master
> >> > +
> >> > +'
> >>
> >> This is OK, but shouldn't this be placed before the tests with
> >> various configuration?  Something along the lines of the attached,
> >> but with the body of the loop properly reindented, would also give
> >> us a better test coverage at the same time.
> >
> > I don't see much value in those tests, since I don't see how if one
> > passes another one would fail. But I guess it cannot hurt.
>
> That can only be said based on the knowledge of the implementation
> detail of the code immediately after this patch gets applied.  Any
> future change to the code for whatever reason (e.g. refactoring) can
> make the current assumption invalid.

It's not just the current implementation of the code; it's any
implementation of the code (in my opinion).

> As the proposed log message says,
>
>     Since commit 9ba89f484e git learned how to push to a remote branch using
>     the source @, for example:
>
>       git push origin @:$dst
>
>     However, if the right-hand side is missing, the push fails:
>
>       git push origin @
>
> we care about both of these forms working, not just the singleton
> form, so it is not just "not hurt", but is actively a good thing, to
> protect both forms from future breakage.  After all, that is why we
> have tests.

Both forms were already tested.

What you suggested adds three more tests: 3. +@ form, 4. @ not present
on the remote, 5. @ in remote.*.push. If the first two pass, I cannot
see any implementation that would fail the other three (okay, maybe
the +@ one).

Anyway, I had to improve the current tests to make your suggestion
work, and what once was a single simple patch now became a series that
is mostly shuffling around test code. At some point the aphorism
"don't let the perfect be the enemy of the good" has to apply though.

Cheers.

-- 
Felipe Contreras
