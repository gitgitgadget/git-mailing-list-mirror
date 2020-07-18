Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196E3C433E0
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 04:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0192076A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 04:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzGt34mH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgGREwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 00:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgGREwG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 00:52:06 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07DAC0619D2
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 21:52:06 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id l6so10683661qkc.6
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 21:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e08+0ZTtxbAPX4gxLRAEuIMea4+ClKHjtkygkmcIl1w=;
        b=HzGt34mHWUXjpXTIjvVmDNbluEScjy9IuwKYeDlkGzklaq1tgIqVtWVv0n9vNyILbV
         HWzI5DlfyzXyOkjY5DH53/QcGG3Sv2o3qSq7XyZuiq9E62kt7OUWs3TNtneb0S1udnAQ
         ImbHuln5YpU5koyMRnpU4znPr3ubxARXk/PPWMqkTnj5JLr7KbBMGcbw1kcyS2HCwh9J
         O4TWKN/BbJl+3bj2LA1eWf7flPcwFzC0vxri76RqlyTLmt4ih6L2RFPF3w2cvukmpm92
         An7qan/0LU+PWB4B5ruWXEzSjvCc5OtisbHOchmHCBtIX/ccvufl7HaLgHpqwKE4wFRz
         HTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e08+0ZTtxbAPX4gxLRAEuIMea4+ClKHjtkygkmcIl1w=;
        b=UmxK0UNKWsKYodH8isrEhoo/ihP0IofkFSzuCGpLTFQKBG3DPINmpvEqWvPicJ9IwA
         Pv8dvSJa3VhzYclrQHORzaeyAyDauVoksOjnbkixLIS/QIkIBy9VSbPMHATddZX5qGNe
         TchWYbFMUz6uflfn9tAkNudFLPvyiKJKBcMZNlOIwlFpEVTS9+Nv5kCliujacyN7DXeC
         IhK1rsJssTbFbsx5ArbDisw1CffkVSif3DqMokeUDOPJVsXhbjaIhFALsrV0hGlVyNNt
         4TkYfdxcnR0ceOA98twmo4VDIvd7Ks/kBv0nc7R6WbRzn5HTlVXcHcoljUonjafdnqk4
         MT8g==
X-Gm-Message-State: AOAM531Ks0AeKE9LtQ+rJE4AbwMF1nZoxtqDfk7VpP0GqFAc3ap0hMDv
        9Q+us2HYPSBi+ll20WlJmHUKx0UEKJlYVH8pu9zts3GmLWP5Lw==
X-Google-Smtp-Source: ABdhPJz4B40yC+sRTh4T3qzRyvFgRJ4qANm7XF67F5VBb5/EMfi9vYGbW656axjWifhx5mnfNsZwmxauUQ91INr31Bg=
X-Received: by 2002:a05:620a:1010:: with SMTP id z16mr11673432qkj.125.1595047925229;
 Fri, 17 Jul 2020 21:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
 <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
 <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
 <20200716153159.GA1061124@coredump.intra.peff.net> <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
 <20200717063324.GB1179001@coredump.intra.peff.net> <xmqqd04ufutq.fsf@gitster.c.googlers.com>
 <xmqq7dv2fnpb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dv2fnpb.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Sat, 18 Jul 2020 12:51:53 +0800
Message-ID: <CAAvDm6bG-s2m9fGXVtuyLB7_FSDRduhb3ptrBsL3ezR9LaS-hQ@mail.gmail.com>
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio C Hamano

Thank you for your detailed explanation.

>There is not much room for the line-level "--not" operator to
>participate in this picture.
After I have carefully read your explanation again and again.
Maybe, I think there is a way to achieve this goal.
Please point out if there is something wrong.
For details, see below.

>"git grep -e X --not -e Y" would mean
>"find lines that has X, or that does not have Y", so as long as a
>document has one line with X on it and one line (which can be but
>does not have to be the same line) that does not have Y on it, the
>variant of that search with "--all-match" in it would say "yup the
>doc matches".  But that is definitely not what the user who wants to
>say "if a doc has X in it, I want to see it, but I do not want to
>see it if it also has Y" wants to see.
As you said in your last email, I think it(i.e. check out if a doc has X,
or that does not have Y) could be achieved by this way:
(Please point out if there is something wrong)
1. Split this goal into two parts, one is to find out whether this doc
   has X or not, the other one is whether this doc has Y or not, i.e.
   result =3D "doc has X" && "doc has no Y".
   We can run the grep machinery twice to achieve this goal.
2. As what you said in your last email, I have no much doubt about
    how to find out whether the doc has X or not. But, maybe, we can
    do some improvement.
    We can record the number of each line which matches the criteria(
    i.e. this line has X). We use "resX" to represent the result of this
    step(e.g: line 5,6,9,10 has X).
3. Check out whether each line matches the criteria(i.e. not have Y) or
    not and record the number of each line.
    We use "resY" to represent the result of this step(e.g. line 1, 5, 9,
    has no Y).
4. If resX is a non-empty set and resY is full set(i.e. contains all the
    line number) ,it implies that doc "have X and not have Y".

    Thank you for your attention to this matter.
    Best Regards.
    Sunshilong(=E5=AD=99=E4=B8=96=E9=BE=99)

On Fri, Jul 17, 2020 at 6:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Jeff King <peff@peff.net> writes:
> >
> >> But none of that is exposed via the command-line of "git log". I think
> >> it would be possible to do so, but I'm not sure how tricky it would be
> >> (certainly one complication is that "--not" already means something el=
se
> >> there, but presumably we could have "--grep-and", "--grep-not", etc).
> >
> > Perhaps the definition of "distant future" is about 8 years ;-)
> >
> > https://lore.kernel.org/git/7vr4q45y65.fsf@alter.siamese.dyndns.org/
>
> Having said that, I do not think our underlying grep machinery is
> equipped to answer "find every commit whose log message has X but
> not Y", even if we exposed the interface that is equivalent to that
> of "git grep" to "git log".
>
> There are two levels of boolean combination involved in running our
> "grep" machinery.  The lower level is used to determine if each line
> matches the criteria.  The main consumer of the "grep" machinery is
> of course "git grep" and because it is line oriented, we have quite
> a rich set of operations and combinations to say things like "if a
> line has X and Y on it in any order, but not Z on it, then the line
> is a match."  That is what "--not", "--and", "--or" (not exposed to
> the "git log" interface) express and we even take "(" and ")" for
> grouping, e.g. "( X --or Y ) --and --not Z".
>
> Another level of combination is to determine if the entire document
> matches.  It often happens that you want to find a document with
> both X and Y in it, and "grep -e X --and -e Y" is *NOT* a way to do
> so---the "--and" is a line-level combinator and tells the machinery
> to find lines that have both X and Y on them.
>
> We have a fairly ad-hoc single mechanism for boolean combination at
> this level and that is the "--all-match" option, which says "Look at
> the boolean expression you used to find each matching line, and
> separate them at the OR operator at the top level.  Now, apply the
> matching logic to all lines in a document and see if _all_ the
> clauses joined by the top-level OR operators matched at least once.
> If yes, then the document matches."
>
> That is how "git grep --all-match -e X -e Y" finds documents that
> refer to both X and Y but not necessarily on the same line.
>
> There is not much room for the line-level "--not" operator to
> participate in this picture.  "git grep -e X --not -e Y" would mean
> "find lines that has X, or that does not have Y", so as long as a
> document has one line with X on it and one line (which can be but
> does not have to be the same line) that does not have Y on it, the
> variant of that search with "--all-match" in it would say "yup the
> doc matches".  But that is definitely not what the user who wants to
> say "if a doc has X in it, I want to see it, but I do not want to
> see it if it also has Y" wants to see.
>
>
>
>
>
>
