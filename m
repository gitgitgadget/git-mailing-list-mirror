Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B74C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 15:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E6E235F9
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 15:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgLQPBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 10:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgLQPBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 10:01:24 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A75C061794
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 07:00:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o17so55177779lfg.4
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 07:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y17M3hesuRh7i8HU2YolYiOwpJL+5NWs8S2MDrWm/2M=;
        b=cMgdFLM2P2DY4i4azwmHRu6nl+ka1/+yGLIdFmA6wqjDIEZSC7qyGizhuvq8paMNyv
         3IAymDQtPpNm/O8rYJvW5DoYFg1CR+j7rctb/ft9CIOFLhZlRHaZdLQFJsTmis6x+hsV
         ekjHzfd8E5FKbhzMn30480+8QnzPU6FctOn10meBLyXORq5US3+uOeUC6FBgUsSfGu+C
         cqys+TC6N2J9ea6sbpETNIPxqGMDQxsb/3X70Vl9g8967y8yYHgfs7olSzuRiM4PJbng
         48d5M5XE8iI4S/yj6DeS+ZIP++7/e4He+Vc3wME9LhbY0YrlxFfwZag20/elYv8f19Gr
         /RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y17M3hesuRh7i8HU2YolYiOwpJL+5NWs8S2MDrWm/2M=;
        b=Fmc197Ok1/cOfkSiNSEMHFMNHFqVOPlXGZR5PUIUejuNBCo+ZAm/3/ZhopT28cCP9e
         9/wE/MOAouMLKB6fvCAVsTMGZ+Q/x1HknffZ+4JqpA2vZ2HEQar3cgo+e5h2wSKIOvBG
         LJ5oFAQDz4MOvlY0wG6qw/Ebp9sgfvkG6dN0tpZVdzKZ5JVV6pU0dikVUe3QlLlPp0gJ
         ZcPLJZsu/hY06AaPlyzf1KzKh8uxbZtjjEwZ8Ig0FTq//ZKBm0bgNlgODUkwnC1xTX+L
         RMzK12n2xOiWH9Jmx3OMDwFLWsqqQWiLpFVtNwiSPGgDg769Pehs9o62AHEWMTHQ4Z8Z
         TOXA==
X-Gm-Message-State: AOAM533DEMX+cUqa2dzovR6eDOCPmg1u3cTVf81qmLK9YjUk4ufnde74
        bUZP6qsoCAL3xAYAE4+LN16Uq2s0t0oOrmh276E+Rw==
X-Google-Smtp-Source: ABdhPJz/pj46yA/MNJT7J+4Hx8myn4VpMuLIN0oUyE8o2vdUYm1U3M6IBY4/2XG3jTPtM4zMjbmZVZfSejdrFkC+LdM=
X-Received: by 2002:a2e:8014:: with SMTP id j20mr9482539ljg.248.1608217242136;
 Thu, 17 Dec 2020 07:00:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br>
 <815137685ac3e41444201316f537db9797dcacd2.1604521276.git.matheus.bernardino@usp.br>
 <20201216223123.GH3783238@google.com>
In-Reply-To: <20201216223123.GH3783238@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 17 Dec 2020 12:00:31 -0300
Message-ID: <CAHd-oW4zM91A0Oz77Px_gtAyhM8opMy3=ChJ4uAm1n0jEXcLmg@mail.gmail.com>
Subject: Re: [PATCH v4 11/19] parallel-checkout: make it truly parallel
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Emily

On Wed, Dec 16, 2020 at 7:31 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Wed, Nov 04, 2020 at 05:33:10PM -0300, Matheus Tavares wrote:
> >
> > Use multiple worker processes to distribute the queued entries and call
> > write_checkout_item() in parallel for them. The items are distributed
> > uniformly in contiguous chunks. This minimizes the chances of two
> > workers writing to the same directory simultaneously, which could
> > affect performance due to lock contention in the kernel. Work stealing
> > (or any other format of re-distribution) is not implemented yet.
> >
>
> Only having done a quick skim, is there a reason that you are doing the
> workqueue handling from scratch rather than using
> run-command.h:run_processes_parallel()? The implementation you use and
> the implementation in run-command.c seem really similar to me.

TBH, I wasn't aware of run_process_parallel(). Thanks for bringing it
to my attention! :)

Hmm, I still have to look further into it, but I think parallel
checkout wouldn't be compatible with the run_process_parallel()
framework, in its current form.

The first obstacle would be that, IIUC, the framework only allows
callers to pass information to the child processes through argv,
right? I saw that you already have a patch lifting this limitation
[1], but the feed_pipe callback requires a strbuf and parallel
checkout communicates through pkt-line. This is important because,
otherwise, the workers wouldn't know where each parallel_checkout_item
finishes. (The size of each item is variable and, since we send binary
data, it might contain anything, even bytes normally used as delimiter
such as '\0' or '\n'.)

Another difficulty is that the framework combines the child processes'
stdout and stderr, dumping it to the foreground process' stderr.
Parallel checkout expects workers to print errors to stderr, but it
needs the stdout of each worker to get the results back. This is used
both to get stat() data from the workers and to advance the checkout
progress bar. I see that you've also sent a patch adding more
flexibility in this area [2], but I'm not sure if parallel checkout
could use it without pkt-lines and separating stdout from stderr
(although, of course, the latter could be implemented in the framework
as an optional feature).

Also, we might want to later improve the main-process<=>worker
protocol by adding work stealing. This might help in the workload
balancing while still minimizing the chances of having multiple
workers writing to the same part of the working tree (as would happen
with round-robin, for example). I already have a rough patch for this
[3], but it needs to be timed and tested further. With work stealing,
the protocol becomes a little more complex, so it might not be
suitable for the callback-style interface of run_process_parallel().

I'm not really sure... I guess parallel checkout could use
run_process_parallel(), but it seems to me that it would require a
good amount of work on the framework and parallel checkout itself. I
don't know if it would be worth it.

[1]: https://lore.kernel.org/git/20201205014607.1464119-15-emilyshaffer@google.com/
[2]: https://lore.kernel.org/git/20201205014607.1464119-17-emilyshaffer@google.com/
[3]: https://github.com/matheustavares/git/commit/a483df570a3cdd1165354388ea3c9fcc0ec66aaf
