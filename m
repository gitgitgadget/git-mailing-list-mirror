Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4780C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 01:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E472076E
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 01:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="j7qI7lw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHTBd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgHTBd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 21:33:27 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A984C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 18:33:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v4so428790ljd.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 18:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0I2pxxNtgVhFx380b5Bzk4RsLGSfhhCR/kgzAppvTiY=;
        b=j7qI7lw7qwpuerZ4QhqY2zFgmRygkgD0o94O4Po8ztKq0DgvhkXTA5z3VRzZSfpIqV
         NLDrSq7UWuug0WUnHswY3EUI0dl8eEVyC+Jd7LfU/HM+NkCNMj8nfpsht9nTSf5e9Vc3
         LeaTn76AkjmvGp5/6Kxzi7ffHaqZWyG2lbHr7gygJcSFkp4LZ2BUKNCsFCunlcgim+aY
         ALQ2lfqOv3nomirKnaH0g75M/ECtnsYT3OFa9OH/P7+nNxLJ5u/aEdx4gW5RECIQYUWm
         JHROr+YTCMZhi3RUYVoM4beqcHkQFnevaXmoCadg78nIUgzGGuqc3BCkUlHo43cBFbk9
         RMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0I2pxxNtgVhFx380b5Bzk4RsLGSfhhCR/kgzAppvTiY=;
        b=hV6poX7FiIxMXAhVs8Z1FHycKwl4gqRDns6xZolnkD31++DwHkHvmjnaX6gBg+rx62
         Bbv0q3KEo+P1i2poNBIzhdE429qg2CxeSRv5KW4C5Jyt0a3Zvp0txH5Pv9f232w+PA6O
         8SBoa1cGO7pJyjacGHya9gGFoyKfgsEX8h4+4l8PSnCYj/xtaSYdFOoDRQy6MGPrlMd8
         nQYLEuqJkmZuAR/oTcclCimOCp4WlHvtP98NX+xf4i++af3hU/W1VOgTW6hDwcBRpKdg
         l+ai3JCiOplvlpAuoYgP81V2MrZ2wp38brfsM1DeCtMkrTfMrVC2Azdx+tfVHmta7564
         GoDw==
X-Gm-Message-State: AOAM530FIE2UNe4vC5A+a8AXrurSHDxwKioX+6I3PzEGIsQRDlpCLMLp
        xUtTwzYi17U6d25pqPHkAmms4v1KkrTTK7Qh4G3AzQ==
X-Google-Smtp-Source: ABdhPJwjiIs4fWRFfCZZsSHmREq5o0kgwRD94rIaN1o3vpe+aJop7s8D1ulCkEhS7fdKPlLA4EZHQUFnI7wtaGN2p7o=
X-Received: by 2002:a2e:b174:: with SMTP id a20mr466731ljm.200.1597887204822;
 Wed, 19 Aug 2020 18:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597093021.git.matheus.bernardino@usp.br>
 <7e7527ef3e8a9e71a012f1623e9642c47f7f741c.1597093021.git.matheus.bernardino@usp.br>
 <f3291797-3ef1-8a2b-d6d5-394f3c32c83c@jeffhostetler.com>
In-Reply-To: <f3291797-3ef1-8a2b-d6d5-394f3c32c83c@jeffhostetler.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 19 Aug 2020 22:33:13 -0300
Message-ID: <CAHd-oW5QjLPmvRL0YojL=NiO-ciY7rNZkQuvCtnF-1vmR4ykKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/21] parallel-checkout: make it truly parallel
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        jeffhost@microsoft.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Paul Tan <pyokagan@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 19, 2020 at 6:34 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> On 8/10/20 5:33 PM, Matheus Tavares wrote:
> >
> > +static struct child_process *setup_workers(struct checkout *state, int num_workers)
> > +{
> > +     struct child_process *workers;
> > +     int i, workers_with_one_extra_item;
> > +     size_t base_batch_size, next_to_assign = 0;
> > +
> > +     base_batch_size = parallel_checkout->nr / num_workers;
> > +     workers_with_one_extra_item = parallel_checkout->nr % num_workers;
> > +     ALLOC_ARRAY(workers, num_workers);
> > +
> > +     for (i = 0; i < num_workers; ++i) {
> > +             struct child_process *cp = &workers[i];
> > +             size_t batch_size = base_batch_size;
> > +
> > +             child_process_init(cp);
> > +             cp->git_cmd = 1;
> > +             cp->in = -1;
> > +             cp->out = -1;
> > +             strvec_push(&cp->args, "checkout--helper");
> > +             if (state->base_dir_len)
> > +                     strvec_pushf(&cp->args, "--prefix=%s", state->base_dir);
> > +             if (start_command(cp))
> > +                     die(_("failed to spawn checkout worker"));
>
> We should consider splitting this loop into one to start the helpers
> and another loop to later send them their assignments.  This would
> better hide the process startup costs.
>
> When comparing this version with my pc-p4-core branch on Windows,
> I was seeing a delay of 0.8 seconds between each helper process
> getting started.  And on my version a delay of 0.2 between them.
>
> I was testing with a huge repo and the batch size was ~200k, so it
> foreground process was stuck in send_batch() for a while before it
> could start the next helper process.
>
> It still takes the same amount of time to send each batch, but
> the 2nd thru nth helpers can be starting while we are sending the
> batch to the 1st helper.  (This might just be a Windows issue because
> of how slow process creation is on Windows....)

Thanks for the explanation. I will split the loop in v2.

> We could maybe also save a little time splitting the batches
> across the helpers, but that's a refinement for later...
>
> > +
> > +             /* distribute the extra work evenly */
> > +             if (i < workers_with_one_extra_item)
> > +                     batch_size++;
> > +
> > +             send_batch(cp->in, next_to_assign, batch_size);
> > +             next_to_assign += batch_size;
> >       }
> >
> > +     return workers;
> > +}
> > +
> > +static void finish_workers(struct child_process *workers, int num_workers)
> > +{
> > +     int i;
> > +     for (i = 0; i < num_workers; ++i) {
> > +             struct child_process *w = &workers[i];
> > +             if (w->in >= 0)
> > +                     close(w->in);
> > +             if (w->out >= 0)
> > +                     close(w->out);
>
> You might also consider splitting this loop too.  The net-net here
> is that the foreground process closes the handle to the child and
> waits for the child to exit -- which it will because it get EOF on
> its stdin.
>
> But the foreground process is stuck in a wait() for it to do so.
>
> You could make finish_workers() just call close() on all the child
> handles and then have an atexit() handler to actually wait() and
> reap them.  This would let the children exit asynchronously (while
> the caller here in the foreground process is updating the index
> on disk, for example).

Makes sense, thanks. And I think we could achieve this by setting both
`clean_on_exit` and `wait_after_clean` on the child_process struct,
right? (BTW, I have just noticed that we probably want these flags set
for another reason too: we wouldn't want the workers to keep checking
out files if the main process was killed.)

Maybe the downside of using the atexit() handler, instead of calling
finish_command(), would be that we cannot free the `workers` array
when cleaning up parallel-checkout, right? Also, we wouldn't be able
to report an error if the worker ends with an error code (but at this
point it would have already sent all the results to the foreground
process, anyway).

Do you think that we can mitigate the wait() cost by just splitting
the loop in two, like we are going to do in setup_workers()?

>
> > +             if (finish_command(w))
> > +                     die(_("checkout worker finished with error"));
> > +     }
> > +     free(workers);
> > +}
