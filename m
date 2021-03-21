Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7221EC433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 13:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FE261952
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 13:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCUNP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCUNPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 09:15:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56CC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 06:15:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b9so16934164ejc.11
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrgIO3NbEO+aop2OHxtYx0Z1k773dbaFPQEzmbgtlF0=;
        b=nT2b/c3QNvYdMoSwpwB4odEj7MJGd8seUhqW369EToBy6zzs/GjvuQK6dnFyhR01XL
         koqMgA8XD2ge9g/cu4ntp0meeSW82R51DY6iCarI24VrPZC3oxojec5L1FzNm1Girk/w
         H6XrMN8ITMou8y5oU4+YyyqXzIr4aQwYhL6WwFL21caLgZolYS84rO47MZVnPjJjPIMy
         CHPE9sF3yRO/GgQ6pEj0NKNImqpnUXOzm5Oa9zqcG3gZ3Vdw2pogeonofWr1n3hoqE8/
         pREY8s7L9rZ+0KqKatgWj14nW1VPJ3Lyz8xvkkBrwQkPMbKmop7BQCrVVXm+o5/NB8ml
         wIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrgIO3NbEO+aop2OHxtYx0Z1k773dbaFPQEzmbgtlF0=;
        b=oPkdzHWENnLMhcMKulLAQpiNsS9TV1wYrdOQEvZMY3dzhrOJz5t6ZaL/kgn6VvhgaS
         D1XNsu3LIDjjvegBYsh/GZLaz0Sdjw8+53hgoubyGxa/LDajlgcdv8ga5MVeWZ60E0Lf
         HxyYOkwEM0Kr1S0e8decp+9UiuBMbZ2xBdRO4wAgwRETojn24QvA8iLH95BH65OcM5b0
         6+2OQNV7mDEBVNXjRc4qmCybCSuwDUVnMOAZENV/+SB2/nS3SbzvPe1okdgAjO/PPEba
         GwHDlRMgfVHz0JMG/RnJNKhE18KTZkdeoCSLb9SjdIeruZf+w5TkKVNBglwTW9Fufxix
         FrkA==
X-Gm-Message-State: AOAM533TjCuJt8OZaoRKA/8uPaDrk+wPTksSySm0gBlA48JHrjwIus3Q
        2LymtLAlwpEY5k+m4eQuQApyYQVXJd2eZ4nmJmXS+WqDuatQUg==
X-Google-Smtp-Source: ABdhPJxEY2JPH+Aseq7i/VVtBGDXm7AvhY0ufQd3DAinzLkZwhpdca9THhOPHRf7bZ1O2uQMORmkJIQTRTBEDIOApCw=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr14525449ejz.341.1616332523339;
 Sun, 21 Mar 2021 06:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <pull.911.v2.git.1616317134.gitgitgadget@gmail.com> <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
In-Reply-To: <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 21 Mar 2021 14:15:11 +0100
Message-ID: <CAP8UFD1Oo-eWmoV-1mh1M=pA8+yRUYHy1wg8NvN3bthmCHBfvQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 21, 2021 at 9:58 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> The original `-trailer` adding some trailers like

s/-trailer/--trailer/

> "Signed-off-by:C O <Mister@email.com>" is often too
> verbose and error-prone.

The 'trailer.<token>.command' config option can already be used to
help with that, for example:

-------
$ git config trailer.sign.key "Signed-off-by: "
$ git config trailer.sign.ifexists replace
$ git config trailer.sign.command "git log --author='\$ARG' -1
--format='format:%aN <%aE>'"
$ git interpret-trailers --trailer sign=Linus<<EOF
subject

body
EOF
subject

body

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
-------

So even without this patch, after your first patch that implements
`git commit --trailer ...`, it should be easy to setup something less
verbose and less error-prone.
