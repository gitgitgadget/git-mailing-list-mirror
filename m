Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EA5C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C076197E
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhGETML (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGETMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 15:12:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E379C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 12:09:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hr1so26923407ejc.1
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 12:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cq2C6729QQqfpDuY2oleifjabFAWDqBEn+OiI6rSW9g=;
        b=IB2en8939y0IJBmzs5xJ8KmsrjBCw0gG0JeNMXK/wNc21Iq5EQ2ipfdjapgD7OlmiG
         WtUlJyjVlcK86SMHe2E7zUze+EFUyUrB3zQxXnXCkO5kcc/gAPF8kxxgIOtUuBsBwMRh
         FUdLeEswEmpqPjZ7Hg0R7kcwZAQgWLstLqMkFFIoBy3h9Zpn9N5w8Jg9tt39t7d3hHYw
         6e5gfXyjmiCLKcLHkAXfwIDc5B3LPEzKl6/aZsVKw1hBOhXYOxsTjxfLP2JDeW4UcXcM
         JGiSUSDrntfaOq4XtJgx0wQNRBcHvffZtSmcqKCBEeWtyUPDDEgxhJ8KQVJ2RBcI/RPd
         15xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cq2C6729QQqfpDuY2oleifjabFAWDqBEn+OiI6rSW9g=;
        b=eKnwudXyBN5tU5XJXTs3KVXU9vwX6obl0hJBn5uKEAI/GEefbioy9YuGjAMQDv5oNR
         iDzH7FKD6QtSngJdw8quwvooWtGmiH6MtU0/GXihoCbjBNK5KNGuZ+OkijWSz7n6vsJa
         kUEI0lTEqdHRY7EeKye14jbtAhMIPIfdJhlaG6NdrBqcFKU2A0pu3IgW1l9uUPOzVqgc
         XvTrMvwoQikdYPlfDJPF5k2EWO9jG2uP7LlDVwMh4TZFqb3o3uK4NPfpQnrjb4wn0RUF
         a6qeWdj4tL2s7CsMZB7gq5NyQHNZGI/W5CHR5wq/n7yS/CJwrydPrkFjEkQVvL179gNW
         Sd+A==
X-Gm-Message-State: AOAM5307dOYcF5RGECXrlb3/gQSfj6ssAcvGNpbJgeHnUZ56IDyjtsT+
        0hRagH3DMJLcarFwrFBwBoJCy+XvvfNUqGFxozE=
X-Google-Smtp-Source: ABdhPJw2tZvc0VvKN2iRkJzNVV/4uSNSewhoQSeRe9r2xu9iHIpmzR44ya4ZnE3cWB2+TEvJpo8daJM/314DYRkgJe8=
X-Received: by 2002:a17:906:b18d:: with SMTP id w13mr14594548ejy.341.1625512170671;
 Mon, 05 Jul 2021 12:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8R_=8Md3vk5yBK4dggq1RKof_6c1tOEtfchbSmYf+gwtA@mail.gmail.com>
In-Reply-To: <CAOLTT8R_=8Md3vk5yBK4dggq1RKof_6c1tOEtfchbSmYf+gwtA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 5 Jul 2021 21:09:19 +0200
Message-ID: <CAP8UFD1_xjJxWA6O8Sx9-AEk5oC62U4GFkt5iRdx8Po_mJzTMg@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 7
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 4, 2021 at 4:42 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> My seventh week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-7/

Thanks!

> ## Week7 Performance Testing 2
>
> This week I used performance flame graph at the suggestion of
> my mentor `Christian` to find out where my patch affected the
> performance of `cat-file --batch`. `oid_object_info_extended()`
> takes the largest proportion of time, accounting for `90.28%`
> and `41.60%` in `cat-file --batch` and `cat-file --batch-check`
> respectively. Part of the reason is that `oid_object_info_extended()`
> is called twice in `get_object()` with my patch. I tried to revise its
> logic (`WIP`), the performance is improved when without using

s/when without/when not/

> `--textconv` and `--filters`.
>
> `=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason` gave me a good suggestion on
> performance regression: When we use the default format of
> `git cat-file --batch-check` or `git cat-file --batch`, we can
> directly print the meta-data of the object without going through
> the logic of `ref-filter`; When we use other format, use the
> logic in ref-filter.
>
> In addition, `=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason` also suggests addin=
g a
> performance test for `git cat-file --batch`, this can help us analyze
> and compare performance changes later.
>
> There are intensive exams in these two weeks, and sometimes the
> response may be delayed.

Ok, no worries!
