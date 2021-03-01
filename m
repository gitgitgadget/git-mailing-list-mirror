Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC7C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651C264E68
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbhCAUHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 15:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242486AbhCAUCt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 15:02:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F247BC061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 12:02:08 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b7so8887010edz.8
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 12:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XQTvYnhSOGvAAj+6LmANBOpZ67XN0+2LzZzwc/a/PrU=;
        b=Lv03pMYuEVM1Y2BcmoZ9FD/IO+cmQRQvv0d5c4DMbtJq58SEYvvAffoP1xuGjq9Tsn
         5XFqBvlytubvFlo9eX3xJZ6bfRRRU2mSj+Kk7V0eeMv0AM4lkO4PdqTywwi3NEvYyg6P
         isk2Q1GgXjisvo6wb7Q/SiRXTmcgBh+x05E8QoSvRFJ1bg8qc1PzS0uV9wPgsfiwGm8I
         ezPqdIYbP//mY8bryQkMS4Cr75ag5eFbKL2Kl8/gjkAhxfProG3ec98KIGlxnnNlwUgT
         OwCH7oxpJ7WcRe4xiYdri6sFtnps45znm9lVD7LVxKbtdIbCLYcX+XWTUfudUjtUh9qW
         +z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XQTvYnhSOGvAAj+6LmANBOpZ67XN0+2LzZzwc/a/PrU=;
        b=CvdNw2THBRaM4XuptY8V6M/fL1Qrwl8vkioBC+EyAf/UeeRq2neXG/XG1dQUUwZxqj
         Furas81MeA0F3nPNvEOtQri95+WOjNTD57TEzKW9r1BmYHNbd3b4Dpd6WdYkdhhAcRJW
         QI3sijKvNwFzxZsfje+li/EhpZtTqusZyQKYN3fGTO0PupkpHjgz5tSqZICHUfnWHMPD
         QJua2pYv1CUdJ6dxV+Nx5KvNq7IR+HE7NX/8UTlIK3cS+pL/pT+pHbyQAKdu8OZtlMSw
         DStfc1Jr08LK3uiq9YRHpeed7VUw6gGhEk1xpA72/6nWax+PtliFFqJukK2swvPYTkF6
         v7tQ==
X-Gm-Message-State: AOAM532LA35BenLPmy9PnxrRRYQZVatSWXJL9djAm/5iKvH1+IcpRz8t
        qTH0RRHrv5lL9sor1YMFPXPNo4fbuCw=
X-Google-Smtp-Source: ABdhPJzxffFo+FyXTzyb/9K10eLQkCUwss6IzoaOspt1sKZqzBhRAyRz7jhycDhVibvSuDoZJ6IpXw==
X-Received: by 2002:a50:aac8:: with SMTP id r8mr17606462edc.9.1614628927669;
        Mon, 01 Mar 2021 12:02:07 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id yk8sm10644809ejb.123.2021.03.01.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 12:02:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Round-tripping fast-export/import changes commit hashes
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com>
 <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
Date:   Mon, 01 Mar 2021 21:02:06 +0100
Message-ID: <87im6ak5hd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 01 2021, anatoly techtonik wrote:

> On Sun, Feb 28, 2021 at 1:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> I think Elijah means that in the general case people are using fast
>> export/import to export/import between different systems or in
>> combination with a utility like git-filter-repo.
>>
>> In those cases users are also changing the content of the repository, so
>> the hashes will change, invalidating signatures.
>>
>> But there's also cases where e.g. you don't modify the history, or only
>> part of it, and could then preserve these headers. I think there's no
>> inherent reason not to do so, just that nobody's cared enough to submit
>> patches etc.
>
> Is fast-export/import the only way to filter information in `git`? Maybe =
there
> is a slow json-export/import tool that gives a complete representation of=
 all
> events in a repository? Or API that can be used to serialize and import t=
hat
> stream?

Aside from other things mentioned & any issues in fast export/import in
this thread, if you want round-trip correctness you're not going to want
JSON-anything. It's not capable of representing arbitrary binary data.

But in any case, it's not the fast-export format that's the issue, but
how the tools in git.git are munging/rewriting/omitting the repository
data in question...
