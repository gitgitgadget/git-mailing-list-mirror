Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F26BC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE02764F39
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhBDUyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBDUyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 15:54:23 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7777C061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 12:53:42 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jj19so7910346ejc.4
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 12:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/fCyX+G2ETyvYOy2qLxaTfpU6Ox8NvjHZOFw2d/j27I=;
        b=fxNqznXgf9Jm7pgdDm0FyhVNweneShEZaxD2VK8ggf9cbQoQpuTXulyYW7/O2kUOgu
         /eHZ+AfwDiRqcm+rMgSzek6Ml3I+Jdv5KS5J821gqask3BFxLLI4L91jdw93ita6zTWt
         PEFuU8U0Csex+s4mwn4yJKwtk462LwraW2ldrigQritu0pxFWo15uS/DtThNUaGlC2/P
         MAOqZXhfrb8FwnQGnBGOVdJyDnrYjtqzSXUsaLlvUL6mOSPOUx8fEqpz3AvpcBmEsb/I
         U2AKazXEEPKxmsviVNrbA3xEvKoinmNKsC6lg8xgF90Xk12OTf3+B7LthcDNSLn2cE76
         2biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/fCyX+G2ETyvYOy2qLxaTfpU6Ox8NvjHZOFw2d/j27I=;
        b=I7oblC603/zpd3QZ6GKjAezQZPdO66zuBy5rBrEacK/5wUHrOCq3rfwPSFY0jU3AuX
         GuTjZNGLfwaX5zx42pxig6GopVs1fV87Ero1Enzg2h15O8xpmAg9YpkNGKrtqDjbisn6
         YQv6AfpAKg2/ijZnY26+FSS7cy2ltAu/5qSQIsTdeo+g1bOeya6CwS8yhG9LLFDDgv2D
         5jYvaFIYaFpbAceEbal5koMckGs0kE08bjeBTLaugtuAHpRwFxyH0hZL5jRp4F7vvO7j
         cSqXhfssKDAOyFo8wK4QEtDLMCU9/j7u6+3HylRnerGABU0SDtchuyb2fyRt+O+gjyNe
         StTA==
X-Gm-Message-State: AOAM532C6hwwRrLx95bA7nZ94imY6E+6HJRW+TPGiVeLRF8Oc9UWBsc7
        Frv0Viv4Ur4Xf1PvFkRKg4rPTE0Av6TFVA==
X-Google-Smtp-Source: ABdhPJwgu4ttDCsWiYeTpYpI5BNVdir+DvsUQN8u9kFQpUT2rPyjmgF4IS/RL6IBu5Hs2xPzafoiyw==
X-Received: by 2002:a17:906:48e:: with SMTP id f14mr887572eja.152.1612472021025;
        Thu, 04 Feb 2021 12:53:41 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id f11sm2926658eje.114.2021.02.04.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:53:40 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] ref-filter: use pretty.c logic for trailers
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
 <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
 <7b8cfb2721c349f2bcebec98f84291b1cffd3b49.1611954543.git.gitgitgadget@gmail.com>
 <875z3ep30j.fsf@evledraar.gmail.com>
 <CA+CkUQ_YDxF+fphzyQRD1OkFh7NGEmHUABvRiAjL-H52MHyH3Q@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CA+CkUQ_YDxF+fphzyQRD1OkFh7NGEmHUABvRiAjL-H52MHyH3Q@mail.gmail.com>
Date:   Thu, 04 Feb 2021 21:53:39 +0100
Message-ID: <87sg6bd06k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 04 2021, Hariom verma wrote:

> Hi,
>
> On Sun, Jan 31, 2021 at 2:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Given that the goal of this series is to unify this parsing logic
>> between log/for-each-ref, why do we need to then copy/paste the exact
>> same docs we have in pretty-formats.txt?
>>
>> At the very least we should move this to pretty-formats-trailers.txt or
>> something, and just include it in both places, or better yet just refer
>> to the relevan parts of "git log"'s man page, no?
>
> Ok. I will refer to the trailers part of "pretty-formats"'s man page
> in "git-for-each-ref"'s man page.

Sure, FWIW you can also (not saying it has to be this) include the same
section in both, maybe with some blurb on the top saying it's not
different between the two...

>> And similarly, here we have now mostly duplicated tests for this between
>> here and t/t4205-log-pretty-formats.sh.
>>
>> I think the right thing to do is to start by moving the tests that are
>> now in t/t4205-log-pretty-formats.sh relevant to this formatting into
>> its own file or something.
>>
>> Then instead of duplicating the tests here, just prepare them to be
>> changed so that we can add both "git log" and a "git for-each-ref"
>> invocation to some for-loop, so we'll test both.
>
> With this unified trailer logic, "git log" and "git for-each-ref"
> still behave differently.
> For e.g.: "git log" does nothing for unknown/incorrect trailer option,
> whereas "git for-each-ref" stops.
>
> Even if we move trailer related tests for both into a new file, I
> guess we still need to test trailers for both "git log" and "git
> for-each-ref" separately?

We have a few tests that define a test function to test these sorts of
cases, t/t3070-wildmatch.sh is one, t/t3800-mktag.sh another.

So you can just do:

    test_trailers A '%(trailers:keyonly)' 'Signed-off-by' 'ERR: error from =
for-each-ref' # (or whatever)

And make the "test_trailers" function do the common setup, have both
"log" and "for-each-ref" look at the "A" tag and assert what their
output is, respectively (or an error, or whatever).

I think that's especially valuable in cases where you have similar
codepaths, because it makes it easy for both the author and reviewers to
eyeball intended an unintended differences.
