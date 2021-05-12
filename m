Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520DBC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A78C61433
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346183AbhELUir (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:38:47 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:39887 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378777AbhELTye (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 15:54:34 -0400
Received: by mail-ej1-f54.google.com with SMTP id l1so728859ejb.6
        for <git@vger.kernel.org>; Wed, 12 May 2021 12:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amhZ8OGHDwePKwj2P+Umha8T+K+RiMR4MRCcPIEDI8A=;
        b=NRAR+BRHgIoGaTtScJnVvKApuP7ClwT0aRCFqn0uPuwYbNRCeKFBJCDM7wJGFgN2pN
         8mtusIbR2rX/U+9kpb3oH2hvClO/w4PP+gQwON24Ly1VleBIxohAXKrfCgTEdrN9PBot
         m0fqNMGHtU7Z9zxDFgeZzwaeWhmukWwnpRM0OK5fvBuRFVT4DYbep7mUhBisq9+YJaPv
         eEyubVgyvm3kQzbfmTq3pT9DsR8PIsxW6nWClUnC709eqw+YhUNVhFBqdRFqifHrn+uh
         jfSW+ROXvJTFPUZxX5ia5lGK3zTqtYzXeifGeSnE3duEh0WwLo9LI0ustZek480dCgsd
         /dew==
X-Gm-Message-State: AOAM533SiM1sgxJ7J+18OCnTrmupRed4HLVrmSu7JzCUrPykoZ69iuQl
        QJbf82L0lFZcdSbeyATaijNVu5mbh6/xsAJjQz+22IakAgM=
X-Google-Smtp-Source: ABdhPJxnvMF6CNNH9oHj5tEunUxFpzJkz84A1yuD0/PFceoXOaqp7fvnrTPEtZTuQCCcbWByBEFrm1MtFvqUqK68iak=
X-Received: by 2002:a17:906:a18e:: with SMTP id s14mr37231509ejy.311.1620849200180;
 Wed, 12 May 2021 12:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <609b2828309fc_678ff2082@natae.notmuch> <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <YJt0Dv7HP2VnLLwv@coredump.intra.peff.net> <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
In-Reply-To: <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 May 2021 15:53:09 -0400
Message-ID: <CAPig+cQ6xw_RDmStExWGjmwuQQP+q5F5wCMtrMvtDt4GaAKXUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 2:30 AM Jeff King <peff@peff.net> wrote:
> The new option enables both asciidoctor as well as its direct-to-manpage
> mode that skips xmlto. This lets you view the rendered difference
> between the two pipelines with something like:
>
>   ./doc-diff --from-asciidoctor --to-asciidoctor-direct HEAD HEAD
>
> Note that we have to add quotes when passing around $makemanflags, as it
> now may contain whitespace due to multiple arguments (but the deference

I suppose you meant s/deference/dereference/ ?

> inside render_tree must remain unquoted, because it wants to perform
> whitespace splitting to get the individual arguments back).
>
> Signed-off-by: Jeff King <peff@peff.net>
