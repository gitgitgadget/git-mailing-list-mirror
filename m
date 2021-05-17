Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6679DC433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 23:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449B561285
	for <git@archiver.kernel.org>; Mon, 17 May 2021 23:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbhEQXfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 19:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbhEQXfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 19:35:09 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C94C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 16:33:51 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id b25so8120582oic.0
        for <git@vger.kernel.org>; Mon, 17 May 2021 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=EVBfLUfIz4qGm+9Lsx9Wq3GHjGn45/it3Z76jihNVuE=;
        b=uKHxKaBW2PUGbJ/6tRvutH4f0Q/hvGsQAj9kSZsRPYYeiaJe+EMO3+P5OBCn4pcP9j
         3q/3LTEI5yQFrNqeISdOPuNgCTlfR8RVoa/7zf472rwiFKe+S6bhA+tl63Jc3faRjMuj
         7CgVKEn0jQ9SuxKIw55wwEqTUnBl9C5Fh0nIb2j7VEbGQkmxR6L4kk2SBOH1A0J/H2pZ
         fkzn0PFdm3uVLUzNXooGVC93tD4Fnujyfzc/HhcMatotTnd5N3jrbpeHJ4jN4qr3qR7p
         HL8U1BE/BdGjZ+Fa+5BngD7+AmhBiVCIimuh3X4ENHnrq7FRlMk9YFXGQyVadCuG30OB
         FVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=EVBfLUfIz4qGm+9Lsx9Wq3GHjGn45/it3Z76jihNVuE=;
        b=biUQmlLlRfq/Gssc+sbM+e66MtcK9K5dey1hXDVJB0HHTaqI+r2bqwqFO0/YO+bav7
         MWYTdJHvB+7g+NeSBcwX2kMu0EurvBidXCqAQMnVT5EBlLBVYQYhECuCpDA8nI62khO6
         7stABo7rkMV9GZr27UHn3n4AShjAFa0WLSmrsYJC5Djk38mv2PI7Z4HWVkMsD8sfiCRP
         HKJ8WD0pxLszkKbdE1rtiK4hzPV9nLlIVGMsbIcBdQGtZjy891ATP0Nn2zBYfGHEfR3P
         ZenibXbabICVQsNOUM2M9jSbBPZr/FVhLFvVLjLTw2HRZUx7pHiQWmu/lTc/44eU3lA4
         1meQ==
X-Gm-Message-State: AOAM533Aa5rlU130n2Ljnhpy3JZQxNbpahboGXU7Dyarm0idKXOO+Dql
        6PfGSl1edfvGxPUOZsGbNd0=
X-Google-Smtp-Source: ABdhPJyxFAXR7t8fzg8ffiBYG9M5H5FcPIAsh/ZxW+6gQfMauzyV2SZAE985RJMTwEi2XyAJai/bdA==
X-Received: by 2002:aca:db41:: with SMTP id s62mr1658458oig.167.1621294431391;
        Mon, 17 May 2021 16:33:51 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id g6sm3430476ooe.1.2021.05.17.16.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 16:33:50 -0700 (PDT)
Date:   Mon, 17 May 2021 18:33:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60a2fd5d52740_1461a92083d@natae.notmuch>
In-Reply-To: <00b701d74b6f$aa295ed0$fe7c1c70$@nexbridge.com>
References: <60a046bd83001_f4b0f20861@natae.notmuch>
 <87tun1qp91.fsf@evledraar.gmail.com>
 <xmqqlf8d6ty5.fsf@gitster.g>
 <60a2f1c4cab0d_13c3702083a@natae.notmuch>
 <00b701d74b6f$aa295ed0$fe7c1c70$@nexbridge.com>
Subject: RE: Man pages have colors? A deep dive into groff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On May 17, 2021 6:44 PM, Felipe Contreras wrote:
> >Junio C Hamano wrote:
> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >>
> >> > This looks much better.
> >> >
> >> > I wonder a good follow-up (hint, hint! :) would be to have
> >> > exec_man_man() and exec_man_cmd() in builtin/help.c set this
> >> > depending on color.ui (so we'd do it by default with "auto").
> >> >
> >> > Then e.g. "git help git" would look prettier than "man git".
> >>
> >> As long as color.man.ui can be used to override the blanket color.ui=
,
> >> I think it is a good idea.
> >
> >Why not use color.pager?
> =

> I think there is a lesson to be learned from git checkout;
> specifically not to overload semantics.

> Manual representation is a presentation world unto itself that has
> should not be blended with programs like less.

Huh? man is basically a grapper for `groff | less`:

From man(1): "man is the system's manual pager".

You could use it for other purposes, like generating DVI files, but
that's not how git uses it. We it in the normal mode, which uses
the environment variable MANPAGER.

This has absolutely nothing to do with man:

  export GROFF_NO_SGR=3D1
  export LESS_TERMCAP_md=3D$'\e[1;31m'
  export LESS_TERMCAP_me=3D$'\e[m'
  zcat /usr/share/man/man1/git.1.gz | groff -T utf8 -m man | less -R

> More than that, being someone who loves automated
> documentation generation, manual representation has a broader semantic
> that should not be dismissed.

But what does that have to do with `git help`?

> There are probably a whole class of colours that ultimately might be
> requested - might be me - so I'd rather not blend these into
> color.pager.

But it's 100% pager-dependent. Not only do you need a pager for this to
work, but you need specifically the `less` pager.

This:

  MANPAGER=3Dmore git -c color.man=3Dalways help git

Would not work, because `more` doesn't read use the LESS_TERMCAP variable=
s.

So why call it color.man, if it's not really a man thing?

Cheers.

-- =

Felipe Contreras=
