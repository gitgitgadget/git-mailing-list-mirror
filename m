Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A66C433EF
	for <git@archiver.kernel.org>; Sat, 25 Jun 2022 01:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiFYBft (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 21:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiFYBfs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 21:35:48 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E256748884
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 18:35:46 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-318889e6a2cso39687627b3.1
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 18:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sSQ+FcQXi42OTdOdZ4qDYtbAgcgHdw018mPl819bJj8=;
        b=imyQokqb6fOf5GhLhyDQaMeTdYIIJag08ZPhrdW5NPpT5W4TvnpYumMrhsTNROg8N2
         8czYR8QSA5meIjMABGDb1quHQiyXr+oLiF0wAKYoI4TKKy+MU6yTI5JcR+CfyRddmNAp
         TVGe1VGlr4ml9jo5hl/2BLEMpB52g8pHB7he6BzdglN1Hm2L5RNh6oJVcIY95Qy3+Rwr
         7lVB4menk/hT/gCOZXqXqAWwu8PV2CTcDCLNeXQnaMLKfxv5DlaheNwBpSxUzIY52NMk
         fkx4s6AicNlqB1WJV4yGhPuwA2OTR9A8wzCDe1IKjRsIyi8IB2pHJlENLSQm/7SjKdvl
         qsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sSQ+FcQXi42OTdOdZ4qDYtbAgcgHdw018mPl819bJj8=;
        b=V5bJODRXmh1SL8MnTTWA3ffzsEZfPeTEcACoAGUBo6sJpR4oyd4LJxnZz++V8MM1jU
         83eVmYj9TBKLio99UviKSD/y4WiM9W8VNDIVB/OU1Y+QTLJ3FG8KIQc+io9aWYXMC+Bm
         eNwLv7fRzXjlYyKNo8JrAaAkYPWw/0AAmv7K3x0g09kXC11DDNdD0Jd2Zy8cUzbvePTw
         v0kSEkC+LvrXyiwDr80biGxLLMa0tuIhLKg6h1BMgD7AQ1aGnKq/g4tD8KMSfSNHL1oE
         VN5Pzvc+tmPrjutvSMQwW3QQmf79/6Tx+cqiATDYWjnb2MR9q7uuYGS/pvLmxJ7LeGfu
         7IDg==
X-Gm-Message-State: AJIora8eyTRfS8i5RHRqnuG9geqXCfhswODlK+d1pJ8XIsPthH67ipP+
        /++ey14q8kO2JTlxCO52je/fidrTqo4RdIc6TteN6w==
X-Google-Smtp-Source: AGRyM1smMMLKmrnNm7IeZHTHJuy3p8eApB4b3MUnNtJOOjpkNJ5eJDh+8SSKj3t0DtVCK80El6YKcAiBa1q4M8wJCNQ=
X-Received: by 2002:a81:3a50:0:b0:313:7539:3420 with SMTP id
 h77-20020a813a50000000b0031375393420mr2035682ywa.366.1656120946157; Fri, 24
 Jun 2022 18:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220618030130.36419-1-hanxin.hx@bytedance.com>
 <cover.1656044659.git.hanxin.hx@bytedance.com> <442a4c351dea603e226bae89eddc2b3496d93262.1656044659.git.hanxin.hx@bytedance.com>
 <xmqqfsjuvyjz.fsf@gitster.g>
In-Reply-To: <xmqqfsjuvyjz.fsf@gitster.g>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Sat, 25 Jun 2022 09:35:35 +0800
Message-ID: <CAKgqsWVAy8RTSCwG=LVHPoeF5ECSzeNfK4mPacLo=dTeUkc6SA@mail.gmail.com>
Subject: Re: Re: [PATCH v2 1/2] test-lib.sh: add limited processes to test-lib
To:     Junio C Hamano <gitster@pobox.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 25, 2022 at 12:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han Xin <hanxin.hx@bytedance.com> writes:
>
> > We will use the lazy prerequisite ULIMIT_PROCESSES in a follow-up
> > commit.
> >
> > With run_with_limited_processses() we can limit forking subprocesses an=
d
> > fail reliably in some test cases.
> >
> > Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
> > ---
> >  t/test-lib.sh | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 8ba5ca1534..f920e3b0ae 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1816,6 +1816,15 @@ test_lazy_prereq ULIMIT_FILE_DESCRIPTORS '
> >       run_with_limited_open_files true
> >  '
> >
> > +run_with_limited_processses () {
> > +     (ulimit -u 512 && "$@")
>
> The "-u" presumably is a way to say that the current user can have
> only 512 processes at once that is supported by bash and ksh?  dash
> seems to use "-p" for this but "-p" of course means something
> completely different to other shells (and is read-only), which is a
> mess X-<.
>
> I suspect that it is OK to make it practically bash-only, but then ...
>
> > +}
> > +
> > +test_lazy_prereq ULIMIT_PROCESSES '
> > +     test_have_prereq !HPPA,!MINGW,!CYGWIN &&
> > +     run_with_limited_processses true
>
> ... as this lazy-prereq makes a trial run that would fail when the
> system does not allow "ulimit -u 512", do we need the platform
> specific prereq check?  I am wondering if the second line alone is
> sufficient.
>

Yes=EF=BC=8Cthe second line alone is sufficient.

> Also, 512 is not a number I would exactly call "limit forking".
> Does it have to be so high, I wonder.  Of course it cannot be so low
> like 3 or 8 or even 32, as per-user limitation counts your window
> manager and shells running in other windows.
>

It's hard to say.
I've tried adjusting it to 256, but the test cases in next patch will alway=
s
fail with the following "err":

    ./test-lib.sh: fork: Resource temporarily unavailable

> What you ideally want is an option that lets you limit the number of
> processes the shell that issued the ulimit call can spawn
> simultaneously, but I didn't find it in "man bash/dash/ksh".
>

Maybe I should use "lib-bash.sh" instead of "test-lib.sh" just like t9902
and t9903?
The different meanings of "-p" in bash and dash really make this tricky.

Thanks.
-Han Xin

> > +'
> > +
> >  build_option () {
> >       git version --build-options |
> >       sed -ne "s/^$1: //p"
