Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449FBC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 22:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188E2613AB
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 22:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhDZWbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 18:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhDZWbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 18:31:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6B5C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 15:30:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n138so90807886lfa.3
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fi/zJ/yFIPW+e4F3Z/2L4FJGuMNbmAy8v6ZK2Xfe238=;
        b=MNK896MdrXfQsPqVN+cdLoOi29ilijnKdS3d/OiPoYDvacG56YfpaS7LEfw3/l+oW4
         wn5HSMokLb21v1qLW7GLevNUKJdQ9IkGDNcQhHQpJi30zw48Hw0v4VQ6W5dGBjLEP7fR
         8PqNxe1PTbNT5BuXSWRi2vynLiIeQch2L0uVeCUz6/a04XoPOX9quiKWv3uHmVFsMq7T
         Gc/umNcMd5xKqLga2ObvZMpLuhiuyFSB5uHJM88HG5zSGErrCOmY3VDfcZNsj4DBqOv6
         R+8xYX1FeLtGIgD3E2UPEvFMJ+y7KsAllxkO6/cg3cvGASV/KaV/DTLQnS+g0VI5w58J
         SKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fi/zJ/yFIPW+e4F3Z/2L4FJGuMNbmAy8v6ZK2Xfe238=;
        b=ShVl3OxoGR124FqJMfc9iamSjcYhKD9NC6416G1k7JYBZ8cKNs6bctXT+4cL4uLMhR
         cDxWqXFH+/0KBFtwDTtgnxr9h3QxDvkGi/pAwN6WayK0ES43cVW00Lm4KFbMVDBKrF3/
         46MVGTWZErDly0IvcPLTYqrTvpJ9RhlP0O1A09ALM5KTYu4ho4YCPxVr3ODpJp8XWh9f
         qm/Ecgeh5p5R6ka89vBgJDaSxVQRca+bbR4GZsNqcb/CPptBpu75HQRvhOCJU7YKG/tT
         X3mQ+q9ynLYQmF5leT6WWwWZC4JUTuL01mj4H/xnvIfCJoPtbBiKIDfWMIjNbkEPVfyw
         d+jQ==
X-Gm-Message-State: AOAM5314+G8tMku+0bN7Avao6wSblWph+jDlRgNXn/Rbs2FZyivW12G/
        F+MKhzyd3pciu3M4KesoibenO2r/zqP1PGWseL1RgA==
X-Google-Smtp-Source: ABdhPJydvhyKzlzq6TWeiZxF+Zr2SSe9zRZjfRSBOrMXDp6khT/jHqmGrvaX2iL0HwfTMhnr9JdYo1SLLiJhdJPw0ZI=
X-Received: by 2002:a05:6512:3094:: with SMTP id z20mr14933235lfd.354.1619476255783;
 Mon, 26 Apr 2021 15:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619104091.git.matheus.bernardino@usp.br>
 <6bf1db2fd8e807f9f259787ef75651d43b61e03a.1619104091.git.matheus.bernardino@usp.br>
 <36615f6a-ce58-3737-8c1d-fa1253a85439@gmail.com>
In-Reply-To: <36615f6a-ce58-3737-8c1d-fa1253a85439@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 26 Apr 2021 19:30:44 -0300
Message-ID: <CAHd-oW547EXAg6bCFx84pKX0j_8Ry2RraYxVscNbK17+0ObkRA@mail.gmail.com>
Subject: Re: [PATCH 3/7] checkout-index: add parallel checkout support
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 3:32 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 4/22/2021 11:17 AM, Matheus Tavares wrote:
> > @@ -142,11 +143,7 @@ static void checkout_all(const char *prefix, int prefix_length)
> >       }
> >       if (last_ce && to_tempfile)
> >               write_tempfile_record(last_ce->name, prefix);
> > -     if (errs)
> > -             /* we have already done our error reporting.
> > -              * exit with the same code as die().
> > -              */
> > -             exit(128);
>
> Here, it makes note of returning 128 as if it were a die(), but
>
> > +     if (all)
> > +             err |= checkout_all(prefix, prefix_length);
> > +
> > +     if (pc_workers > 1)
> > +             err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
> > +                                          NULL, NULL);
> > +
> >       if (err)
> >               return 1;
>
> This returns 1 instead. Should we `return err` and use an error
> code specific to the response? I imagine there are other reasons
> that could cause a non-zero return for checkout_all() and
> run_parallel_checkout().

Hmm, I think checkout_entry() returns -1 for any kind of error, and
checkout_all()'s `err` only holds the number of checkout_entry()'s
failures. run_parallel_checkout() also always use -1 for errors.

> I suppose: is there a value in persisting the 128 response code
> here, or is an exit of 1 sufficient? There is no documentation
> about the exit code, so any dependence on 128 is not based on a
> "written promise" but I thought it was worth mentioning.

Yeah, I also wondered if we should keep the 128 exit code here... But
I couldn't see much value in doing so, unless there are scripts
actually expecting 128. But I guess this is unlikely, right?

The additional bonus of unifying the exit path for `git checkout-index
--all` and `git checkout-index <path>` is that the code flow becomes a
little easier to read, especially now that they both need to
[conditionally] call run_parallel_checkout() before exiting.
