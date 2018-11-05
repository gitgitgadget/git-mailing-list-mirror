Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5D11F453
	for <e@80x24.org>; Mon,  5 Nov 2018 01:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeKELKm (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 06:10:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37061 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbeKELKm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 06:10:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id o15-v6so4035299wrv.4
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 17:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uJW6BJRxDWB1NFqfXTtMiXU9Y6qLKI8SkZ+v6ARtCtU=;
        b=rKVq0KufiCvu3u/lVDAZkEIfUgER3XPgDoLsnLEsEJzno6NyK1DTlH4zWyEgQcAOJp
         h14UqU4iK9C+FYGRKyn+zPUYRTZrEp3umU5kT5ohnyfM8FaREbVerJCGlbMmer7JdMHx
         6LqseK4d0mBHksA8hC0nr7i4XO8r+H1xnEsJvvDC9PIiGgLECWXW6zIKbgfjR+BbQ8Td
         iKw7lyIJ68VUeVdw6nNndsEujFDkKzKN7wJ9Huy7EVhwAkkdacB39TSBt6+H1Kn9JBVC
         NbV72LJv8ikfTOyHutHnJqPnJGxgkdSTaNAIe7ZEmzf30KJclNoyQXLWHFVnledTQT2N
         iHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uJW6BJRxDWB1NFqfXTtMiXU9Y6qLKI8SkZ+v6ARtCtU=;
        b=oAiDRaIiGii+5ypdj4rdwkoryIsp6zN1HldJKmkkL//HSjdVGyMLdTDJNx2bAEMg+K
         CEPLjmZpzMEdIAr3slp1Nz44aR3CI+Xa/XWQ4kyyiCC3B5AsmNqSaYmqXFz3RNk6RLe/
         CFtMQ6U4ubJR1Rm4pn4mIEM8hjdoKdNUPhr3WunGdyKFt20u3Mi7eLH4A+tGAgzvYL5f
         +HLA1oyNNwHA7nGqypjzBHYABfDOOyDNpFMwOIpJfpEEOjCv94tuEvAu9vmjiBiBllac
         ojVGmbX3h87YM+CRXJU5nYN/sDFgN/JGY/Cq9rd65Rd5va7++wJewQfGLYA+CABVsIuz
         0Pxg==
X-Gm-Message-State: AGRZ1gLx5RWseNBDWdTY3mNvcCTU5vLOmO2mLz4exPMRXUNKfzgPgh+J
        gzlo2KWHqemd+L4k+jwosEg=
X-Google-Smtp-Source: AJdET5f1F/uRtMcfSeeWJ41o2y3QWRPJH6tK7eED5YbEanWhkXUYGWkAWqEFs2xU1ORO6nk0eEtEpQ==
X-Received: by 2002:a5d:66d0:: with SMTP id k16-v6mr5836029wrw.154.1541382809039;
        Sun, 04 Nov 2018 17:53:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v62-v6sm6208911wme.3.2018.11.04.17.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 17:53:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/5] am: improve author-script error reporting
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
        <20181031101556.27169-1-phillip.wood@talktalk.net>
        <20181031101556.27169-3-phillip.wood@talktalk.net>
        <CAPig+cRBwkKGtzY6CwZiKb1mef0a-9F+O24d0R8ZfsRb5ssUbA@mail.gmail.com>
Date:   Mon, 05 Nov 2018 10:53:27 +0900
In-Reply-To: <CAPig+cRBwkKGtzY6CwZiKb1mef0a-9F+O24d0R8ZfsRb5ssUbA@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 4 Nov 2018 00:12:13 -0400")
Message-ID: <xmqqy3a8jnmw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Junio labeled the "-2" trick "cute", and while it is optimal in that
> it only traverses the key/value list once, it also increases cognitive
> load since the reader has to spend a good deal more brain cycles
> understanding what is going on than would be the case with simpler
> (and less noisily repetitive) code.

... and update three copies of very similar looking code that have
to stay similar.  If this were parsing unbounded and customizable
set of variables, I think the approach you suggest to use a helper
that iterates over the whole array for each key makes sense, but for
now I think what was queued would be OK.

> An alternative would be to make the code trivially easy to understand,
> though a bit more costly, but that expense should be negligible since
> this file should always be tiny, containing very few key/value pairs,
> and it's not timing critical code anyhow. For instance:
>
> static char *find(struct string_list *kv, const char *key)
> {
>     const char *val = NULL;
>     int i;
>     for (i = 0; i < kv.nr; i++) {
>         if (!strcmp(kv.items[i].string, key)) {
>             if (val) {
>                 error(_("duplicate %s"), key);
>                 return NULL;
>             }
>             val = kv.items[i].util;
>         }
>     }
>     if (!val)
>         error(_("missing %s"), key);
>     return val;
> }
>
> static int read_author_script(struct am_state *state)
> {
>     ...
>     char *name, *email, *date;
>     ...
>     name = find(&kv, "GIT_AUTHOR_NAME");
>     email = find(&kv, "GIT_AUTHOR_EMAIL");
>     date = find(&kv, "GIT_AUTHOR_DATE");
>     if (name && email && date) {
>         state->author_name = name;
>         state->author_email = email;
>         state->author_date = date;
>         retval = 0;
>     }
>     string_list_clear&kv, !!retval);
>     ...
