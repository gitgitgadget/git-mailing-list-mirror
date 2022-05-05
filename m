Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC44EC433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 18:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383052AbiEESR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383061AbiEESRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 14:17:25 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B65BD08
        for <git@vger.kernel.org>; Thu,  5 May 2022 11:13:45 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l16so5150522oil.6
        for <git@vger.kernel.org>; Thu, 05 May 2022 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TG1f0/vq5khi9nmOcle1C7eeZOaRJDX5lS6NJacfgog=;
        b=sLCbi3HeRf158ky5o0K8XiZQ8A2vosfVP0Ybc8uPAZvF43ZBWph/qEW+/i4tnIOqO0
         R1s2Nc3At6AxB1ruyJrDz3VykgbQc9QxUq0JSP5mQ8s7k4NaT+ailZUfAhmDR3p1j4YK
         Zg0tIbhvEpRegesnPugI64YceYepo8jPn6oT3nwZiihHIGKb+s3IRuWBjbh2x7YBsbAA
         DJtaKA6lqXAI4HvSrqfID1XuAd6NEZycEnVx52yag/sWyxP7aS+sxLG8bj92EMvzNCMc
         D3048OfVINMLnWXnp1OeWCiCQ2lS3JYByoXujbl+7CNYzpaCz0M8FM0sZ+Badge9rGT/
         EOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TG1f0/vq5khi9nmOcle1C7eeZOaRJDX5lS6NJacfgog=;
        b=LSEaJENgLZ/T0+993P2DJ1vIeLJ48Z7jYl0MQhdy6GyBYwzdF33iddQzkOolWqr2Qm
         T5RTo1G47vLQPuPNTR3bUC6B8MdY/JSocc43aSwa5XSiFMJBjOZpoLLn8igo/viODxGn
         d/CWVez4xlTJt9zefnHGDzbEPyGBR37Zk64rFC9RcNWOozfJGms9rJXM2zUHBKfpsq2/
         O/uex3aFE1FcgOLy0OOJCe25lB6floSpYhgBCO1Dt8WYG0Dk+aey+HFpvq/0nVVnQgS4
         jeXfPtCSKNEuCCKZb5UMvLg1NHcfQhPwtjQv3X6BL4YqAyWvZAWOvDJqoiXBT3ANt/zc
         Iphw==
X-Gm-Message-State: AOAM5337wUo9viMkUq5opaKsc0At1cpndxq7To4cd3Ck3RfZ+d60wVlp
        uGnmAdnImhew/ccgln4Dt0Ugmo8LEQ1Cd5LUogUkVg==
X-Google-Smtp-Source: ABdhPJxWiurllmbDobJk3iQW3nbeJawJ+647tiql9od62wKBHuaMUSJ8Mf/jhfe+sViVTEfA5gudbr5mJFMNfFcPBbY=
X-Received: by 2002:a05:6808:1387:b0:325:93d:eb4b with SMTP id
 c7-20020a056808138700b00325093deb4bmr3157032oiw.213.1651774424740; Thu, 05
 May 2022 11:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rrjv8x5.fsf@gitster.g> <20220503230658.4170414-1-jonathantanmy@google.com>
In-Reply-To: <20220503230658.4170414-1-jonathantanmy@google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 5 May 2022 11:13:34 -0700
Message-ID: <CAFySSZAdSNpaZ_ghN2Oa6OE4rQ-H387YT7VPPGE_FK0zTXpFCA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] fetch-pack: move fetch default settings
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Done thanks for the suggestions

On Tue, May 3, 2022 at 4:07 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
> > Calvin Wan <calvinwan@google.com> writes:
> >
> > > When the state machine in do_fetch_pack_v2() is in FETCH_CHECK_LOCAL, we
> > > set a few v2-specific defaults. It will be helpful for a future patch to
> > > have these defaults set if the initial state is not FETCH_CHECK_LOCAL.
> >
> >
> > > This is a safe change since the initial state is currently always
> > > FETCH_CHECK_LOCAL, so we're guaranteed to hit that code whether it's in
> > > the state machine or not.
> >
> > What does "it" (which supposed to be able to be in the state machine
> > and also not to be in the state matchine) in the last sentence refer
> > to?
>
> I think the "it" refers to the initialization code that was moved.
>
> > The patch looks correct and I agree that this is a benign no-op
> > because the initial value of state is FETCH_CHECK_LOCAL (i.e. the
> > block of code moved here will execute pretty much as the first
> > thing, and the relative order between that block and sorting of ref
> > list should not matter).  I just didn't understand the explanation
> > given by the patch why it is safe.
> >
> > Thanks.
>
> Agreed - I think the commit message would be better off if it was worded
> something like:
>
>   There are some initialization steps that need to be done at the start
>   of the execution of the do_fetch_pack_v2() state machine. Currently,
>   these are done in the FETCH_CHECK_LOCAL state, which is the initial
>   state.
>
>   However, a subsequent patch will allow for another initial state,
>   while still requiring these initialization steps. Therefore, move
>   these initialization steps to before the state machine, so that they
>   are run regardless of the initial state.
>
> I think this description suffices for a reviewer to see that it is safe,
> but if you want, you can add:
>
>   Note that there is no change in behavior, because we're moving code
>   from the beginning of the first state to just before the execution of
>   the state machine.
