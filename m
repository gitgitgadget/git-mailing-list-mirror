Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63862C433E4
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0F761972
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhCTLOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhCTLOc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 07:14:32 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5E8C05BD43
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 04:04:35 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so2948401ook.2
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PaFxpaVuZlRymXocucu7UB2t/Mr2ObHBr+jgtbgWeWs=;
        b=Gh/aLw2gv4SGGZkPtyWCHiRWkHOKY/VNutHaOtsyLO2cJRt4I68vYr9upDCM0tompU
         TxL2f8FWM4fosoUMzBclInb54BqddUIf/zUTzb5vAcE+4yWPH++BShqaeiosjpS5hnCv
         dQpho3IX3SX81gJ+pyNzRWqB6N5wU+qeS6x7wq55wm9o/0LG/MLkDSY2vhxgdO+84Ezr
         7oWrPVHV0vAWhfM2tSWCLCjUNAC4whmYnnaLaawHkm9oqyqUqk7hHh3xF5eIOLSN7WPx
         NOOZopGQM0Sb3VD72hHlhoGNiW0e23QdPhrRfAL8gdX/A96+5+GoCaDoSBQEw5y13pdi
         19Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PaFxpaVuZlRymXocucu7UB2t/Mr2ObHBr+jgtbgWeWs=;
        b=Js1u4+xDaf1+3kOE0tFVWbcjbZ5sOpeYxa8jIpMbGQ3SVs2UtIvpmbyacjrIwKggO2
         hN+FTa20V3dRoMnj3P7sk99LYuPMZpzIaIOcMWAX2N7tspHwd2VIiWAk95BUtxzmd5TK
         VlBV9I2yVfouIqdiQQ7+s7j2sbT14w9hvqvtQchuHgEJNgzt8K/lKCpUO+YJfhgKVIGU
         JAXmkMTx+oLHhhi0lyxOq+Lp8RNqsjSK9GMxnh0ii8/+i5WpgbphOe6ayNM0CLrEwk2E
         l07B8yXVJSStE32Bs0i2Q47yL/KJCXksQU2BCQvPhFtw2xMA82oIzrS1Nx/5YUh1LokE
         pJCg==
X-Gm-Message-State: AOAM531CfYkk21Coo7bzWdAlUAIX1pEFcxQA0zmt0121M1vYZBnFx4iX
        F+NITkxW0Ak/CLfgsXtmqMh08gGFqX5Rgtd3zZ9aPm42R7I0qQ==
X-Google-Smtp-Source: ABdhPJzJBmZo6TXjeCOyaZ999aXxu/JcPR0svQxm8uyJhfjyJ7tiYr3Ukk1jIRe62H8IEqimJlvnirX8GcBEZzO80vs=
X-Received: by 2002:a4a:bd97:: with SMTP id k23mr4469418oop.13.1616229811186;
 Sat, 20 Mar 2021 01:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com> <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
 <xmqq1rcctgj7.fsf@gitster.g> <CAOLTT8RzvQzD0baWPdJzRLK3Q+WeJR_HNA4RVHMxRmwHeym9QQ@mail.gmail.com>
 <xmqq7dm3p344.fsf@gitster.g> <CAOLTT8TQdT1PkdfuOk92U89Lgk9o_YhdeMyHb6SrE7GW+6PQJQ@mail.gmail.com>
 <YFWCvePMGvBY/I9v@coredump.intra.peff.net> <xmqq4kh6l6fd.fsf@gitster.g>
 <CAOLTT8RE6LOx2AUH8PJMzFdqp4_GJkiY41K0xE1YiSQNixKCRA@mail.gmail.com>
 <CAOLTT8T54RHPm8P=mJ3vOKZPEwpJQgnbeU3VqczWbPSk36wZcA@mail.gmail.com> <xmqqzgyyjoyy.fsf@gitster.g>
In-Reply-To: <xmqqzgyyjoyy.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 20 Mar 2021 16:43:20 +0800
Message-ID: <CAOLTT8TUtYxciGr-HjRM9604HQfZDHSGrpTyVia-QUFjZvHrpA@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8820=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=882:53=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > In actually ,
> >
> > @@ -1071,6 +1071,7 @@ static const char *find_author_by_nickname(const
> > char *name)
> >                 strbuf_release(&buf);
> >                 format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
> >                 clear_mailmap(&mailmap);
> > +               reset_revision_walk();
> >                 return strbuf_detach(&buf, NULL);
> >         }
> >
> > then we can reuse this function.
> >
> > But I think I can give find_author_by_nickname another arg for choice i=
f we want
> >  `reset_revision_walk()`.
>
> That is half fixing and half breaking.  It would allow us to call
> the helper number of times as long as there is no other revision
> traversal is in progress; calling reset_revision_walk() would mean
> any and all revision traversal in progress will be broken.  So we
> cannot use the helper to tweak each and every commit we encounter
> while running "git log", for example.  Imagine adding an option to
> "git format-patch" to allow each commit it formats to be tweaked by
> adding "--trailers=3Dfoo:@ZheNing" and the like.  There is one primary
> traversal that is used to list which commit to format in what order,
> and every time that primary traversal yields a commit, if we run
> find_author_by_nickname(), we end up initiating another traversal,
> and then by calling reset, we clear all object flags that are used
> for revision traversal, thereby breaking the primary traversal.
>

I understand what you meaning. I may not be very thorough in considering
 the potential problems. This is as dangerous as calling `list_del` in the
 middle of `list_for_each`.

> The only safe way to introduce a generally usable helper (without
> rewriting the revision traversal machinery) is to spawn a subprocess
> and do an equivalent of find_author_by_nickname() in it.
>

If I didn't notice what you mentioned later, I might think about it
for a long time.
Execute a child process specifically to execute `find_author_by_nickname()`=
,
which feels a bit wasteful.

> A standalone "interpret-trailers" command, as long as it won't do
> any other revision traversal, would not have such a problem, and
> calling reset every time find_author_by_nickname() is called may be
> sufficient.  The only thing I care about is *not* to pretend that
> find_author_by_nickname() plus reset() is the generally reusable
> helper function and advertise it as such, which will mislead future
> developers into misusing the function in a context they shouldn't
> (i.e. while they are performing their own revision traversal).
>
> Thanks.

After listening to your previous explanation, I agree with this view.
`interpret-trailers` alone as a process, as long as it does not traverse
the revision externally, It is safe for us to call `reset_revision_walk()`
after `find_author_by_nickname()` inside interpret-trailers.

Thank you for your thoughts and answers.
