Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F62520248
	for <e@80x24.org>; Tue, 12 Mar 2019 06:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfCLGue (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 02:50:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55601 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLGue (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 02:50:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so1341851wmf.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 23:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VwTZquv6Cnyw8xKxQEh3pr4w/kzfypkK6F8L+5z4pFk=;
        b=cpoBUDwOMUWKOXnLxvbe4dANpvYun9ghwTVNoFhV94KNNK44mWKKKdJF4aow2rvm14
         CC1aWh7iYvjrLtpibCZrQ5ypr71RqZsbMWKwNSpGy7YwBxT0tesYGTBwo11Q/JO8a0dm
         MSQ0n/xGsSLfCsJ54W4NavZS6vi3/n3FdjKSuDe0gRkd8UiYAQ8JUNViwVxy80TjUv/X
         XssTHLoCRh2yiA4DoPh0+aH2y4ugRJhs9bBR/oyH/a93WdHOgD8bD2cEo/WRJP6A1eJk
         XmrOzeDry4TRR138AEbCHRGYrPQr8ce1VVwJC6uz0MrJr34W1orDQJGJySXyS+VtYqap
         qH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VwTZquv6Cnyw8xKxQEh3pr4w/kzfypkK6F8L+5z4pFk=;
        b=jaftWdDz+b9Vn8e1j0j7gCRRU5d5kFSrdnrBtywzoU/VKnrE+eHA6qc84qfmSmDzEh
         UdqH2Y6TfQNn5e30+AHZ1CvXqP1D4uYDrLXEV+BgNokEl2pl3BRZDpgCP9keojHmUwYz
         GeqDbC6qjc6cNXQqcBeLGeS8Fklju5hNgFPownmIuRDnyuNCbx84kz6Uhdo62c2EIAN6
         1PuMwk4sVdS4syiUngysy+19yBmSeDN0VMzXSdQGzwES9hIx61n+ErENv2N3NPSGvlo4
         8EjrrZjFAK7FJiZgFblpHUUeLxW8uIQI/uQUBFq2ZjAXqYOacC+TSi3LMwB8RxaHn4/T
         okOQ==
X-Gm-Message-State: APjAAAWLuvgSesn6PBrATrJ6TmFudGlwyZ231MO4rxQbBqfEqui4xdI2
        Ws287y+ODzUiUEYHeFYPr+c=
X-Google-Smtp-Source: APXvYqwj9SXB6u/NvGAbxymVidXuNBgc5Nbs7F1FMq03fUFv0Ll/OdkJjrE3QDrhls1VqQnsetUQ7g==
X-Received: by 2002:a1c:7610:: with SMTP id r16mr951626wmc.139.1552373432080;
        Mon, 11 Mar 2019 23:50:32 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w10sm14857929wrn.32.2019.03.11.23.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 23:50:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v2] stash: pass pathspec as pointer
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
        <20190225231631.30507-1-t.gummerer@gmail.com>
        <20190225231631.30507-19-t.gummerer@gmail.com>
        <20190307191836.GB29221@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
        <20190309182610.GD31533@hank.intra.tgummerer.com>
        <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com>
        <xmqqd0mxkgvy.fsf@gitster-ct.c.googlers.com>
        <20190311214244.GB16414@hank.intra.tgummerer.com>
        <20190311221624.GC16414@hank.intra.tgummerer.com>
Date:   Tue, 12 Mar 2019 15:50:31 +0900
In-Reply-To: <20190311221624.GC16414@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Mon, 11 Mar 2019 22:16:32 +0000")
Message-ID: <xmqqsgvsh9hk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> Good catch on both acconts.  I'll send a new patch soon, adding the
>> clear_pathspec() calls and rebasing it on top of Dscho's fix.
>
> Here it is.  Thanks for the review of the first round Junio!
>
> This is on top of Dscho's series at
> <pull.159.git.gitgitgadget@gmail.com> applied to ps/stash-in-c.

That's called js/stash-in-c-pathspec-fix; as this patch is also
about pathspec, I guess it is a good idea to just keep them in a
single topic, so I'll apply it there.

