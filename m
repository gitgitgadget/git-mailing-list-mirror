Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C30FEB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 23:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGRXTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 19:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGRXTI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 19:19:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB88ED
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:19:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so10339751e87.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689722345; x=1692314345;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VKMJSFKYgTGWbb9NcOWFBqBMt9n2gdZklN5dF76qiY=;
        b=YM/vQAVwIqK5EGdBcxXX0G5YCjl2f+Zp6Z4apRGVJU2uUAzjSQvJdQOElB+TYHwYgC
         0OLUW9c+ZgQGSEz46KLpRR4QEAZpkXyTs9zrAciGcsq7IjbIzrJ7a9kzVxnGF18Cl506
         gIQH6akr3oUT3QiIKVB7nP1WKqNacbU8H4aqlBMABU1sxQ41P8vIIjvc7I+z6IziQVk/
         FsYox7DF2CSZLqxbZOrQJhjKnc7uoEEZ/9FzDG/hQAElbbVMCUM6nDtdUjNo7JAbSipY
         2u0DENZH/HPXh5yEzNbCCp+w/zobVfzaRHkIq3zeIGCCjd4xe3qYkWcB7hvtiQvmSQ3q
         8Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689722345; x=1692314345;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VKMJSFKYgTGWbb9NcOWFBqBMt9n2gdZklN5dF76qiY=;
        b=js1V9polUnT8yaZzMkGyopC7wqY5lUmxvh3vvA11DbixA3poeXuB+nMSJLpk2ReyDG
         BXBXs2mM1FNExS8Inc9JhRCdv+5knKN2R9OkG88JHRnbj2wQUt0DmqQ4ZrHpXFeKvXDV
         eQyN2GsfXZ1zacfEBfEABst7tW3qvAKRZhAp0NoPEakUOdkCNjH1oxSBSNTtrfwH5MWv
         MX/OC+FGWj6qXeO9+gIro4WwAE8FQYfBgDrpdLlp8uQQxizJQpryWM9YXWW13kod4gPu
         K4St1gCEampFO9lRPzoXknf0fI83YtpapHRwVWCnGGvy8DMx7HurfRovYhGsK/IFx4y8
         1RXA==
X-Gm-Message-State: ABy/qLZQTFSCWIxZNta3IZxk1Q9gLPAXdQoVJFExCd1kBU7emSqIosWQ
        lVog6Li+vTN1oGFvqNwxszEbgUD/THcJvMHhIg4VpoY1
X-Google-Smtp-Source: APBJJlFap59MXPM8EUcYmS0HB2X1Fu1M1q4Ohc1NYSps0M9ho0OSIkou8AT8nUC+/P/Ucz1eQlnnNr28G71ucKfoQEk=
X-Received: by 2002:ac2:4d96:0:b0:4f8:5905:8e0a with SMTP id
 g22-20020ac24d96000000b004f859058e0amr10255974lfe.6.1689722345405; Tue, 18
 Jul 2023 16:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHfWF5n5kk1bYdU4qKTF3n_Ad9BGjwbbmm+0ZQEX=1NZzRiWXA@mail.gmail.com>
 <xmqqcz0oerup.fsf@gitster.g>
In-Reply-To: <xmqqcz0oerup.fsf@gitster.g>
From:   Immolo <immoloism@googlemail.com>
Date:   Wed, 19 Jul 2023 00:18:36 +0100
Message-ID: <CAHfWF5mjquES-nocQaK+CAEsqWgdy-_OYdGtN82heYs0eJP3eQ@mail.gmail.com>
Subject: Re: [Bug Report] Git fails to compile with fortify-headers and LTO -
 error: inlining failed in call to 'always_inline' 'fwrite': function body can
 be overwritten at link time
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've reported to the folks over at fortify-headers already and they
came to the same conclusion (minus GCC), it's an odd one that's for
sure.

Immolo

On Wed, 19 Jul 2023 at 00:13, Junio C Hamano <gitster@pobox.com> wrote:
>
> Immolo <immoloism@googlemail.com> writes:
>
> > /usr/include/fortify/stdio.h: In function 'verify_cache':
> > /usr/include/fortify/stdio.h:59:28: error: inlining failed in call to
> > 'always_inline' 'fwrite': function body can be overwritten at link
> > time
> >    59 | _FORTIFY_FN(fwrite) size_t fwrite(const void *__d, size_t __n,
> > size_t __m, FILE *__f)
> >       |                            ^
> > cache-tree.c:175:33: note: called from here
> >   175 |                                 fprintf(stderr, "...\n");
> >       |                                 ^
>
> It looks like a plain vanilla invocation of fprintf(), unlike from
> any random application, a user of the standard C runtime library .
> Is this a bug to be reported here, or would it be more valuable and
> useful if reported to GCC or Fortify folks, I wonder?
>
