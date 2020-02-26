Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8F9C4BA06
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 00:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6F32072D
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 00:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hphm5O0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgBZAht (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:37:49 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46302 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgBZAht (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 19:37:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id p14so1529451edy.13
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 16:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ued94sAe25jLviRr06fisUF/LLj418CpSDTIEWdKscQ=;
        b=Hphm5O0EhOmvk+x3yHOaYL+GEh/rCqbs0dOcr+VqaTymj5IS92nLnAVcT1XDEd9BM3
         Z7gQOtvfzawKr/9rGzpjTT4MTahD2pEbEoMS7EU1DKoxonrKpwddrEJh2O2h+AXslWPf
         3YeCDuMA8dH/i/ntr9v2b81/V5v10z/ATFLehKyeQyXUu4oclSK5d2B3z2uO653wmqw2
         m5ma3uBBctWI1QlFkwbg6qrwxJaCP8GbpPIYuYVWHKXz8MxyF8jG/SLAXKKtlF2NBU3n
         DeFc/sotyvGqR1mkSeuGj3rdPhjXYD5xqGBWNvhUiiCdtS5ZYR9wECiXzciQmP4rY16W
         ksvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ued94sAe25jLviRr06fisUF/LLj418CpSDTIEWdKscQ=;
        b=FSPNa5fuP3s9vh9bMm9fs8SFTmzxJd5xV/OLm1QvwIHQXA12IE87cxSVTrvMciJfLT
         hCMbIWYZyWWF5v0KOe/V2gAVjbCO6fBUdLwdy71VwPzQuh+DG92rmYuHs5EbVoh9pXV2
         A9owEKT6vBFI5UsH+iqqQO+9ueoP5B8+DvRizGMaOT6iWsWjf/6jCxskAaHt1Pl3OY+R
         0JLHwzxSULZj69Ei3IJiwDs8d/yqs+KBEKmNikweeaGFoAUddp2HKDQIypIJkbqULtec
         bM3RWSuIy1PLojwVgYCFcdmDCmyi6cv7BXUlIebbTqji0Zbbt93jeGNXcL0igxBFcmqu
         2wEQ==
X-Gm-Message-State: APjAAAXKsgEPy67kdvVoUbYOCJMgL+A/S2m4U7oSnQqEIxkkp712khZ4
        2HhVrcRDnOPe9fvppLXb8ik4vWK+t7VKm9kGYl0=
X-Google-Smtp-Source: APXvYqx8lxu7kTeUYKtk9w/+s4WxGpvhpZb0pYu/+XhpXoeww7WAGr7qR2hH7T8IXD2zrR2yFeudhCcdvrYRX7RTjSY=
X-Received: by 2002:a50:8f66:: with SMTP id 93mr1525512edy.33.1582677467647;
 Tue, 25 Feb 2020 16:37:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
 <pull.548.v5.git.1582628141.gitgitgadget@gmail.com> <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
 <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com> <CACg5j27SfWsj2t_z8zxOvjc6MSot2yMi1J+R4HJinFhHgTpveg@mail.gmail.com>
 <xmqqy2sql405.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2sql405.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 26 Feb 2020 13:37:36 +1300
Message-ID: <CACg5j25EdX2fPHpAq3TEhaJPiQg4dA52soOyCMm17wg_O-c4Ng@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 11:02 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Heba Waly <heba.waly@gmail.com> writes:
>
> > I wasn't very happy about having to keep the list of config keys in
> > memory, but that was a good enough solution for now.
>
> If you force your programmers to specify the advice_type as a small
> integer, and the setting is stored in the config as string keys,
> somebody MUST have a table to convert from one to the other.  So I
> am not sure if it is even sensible to feel unhappy about having to
> have a list in the first place.  Are we looking for some kind of
> miracles ;-)?
>

The reason I had to add the list of keys wasn't the enums, but because
it's needed by list_config_advices() which returns all the advice
config variables names. This is used when the user runs `git help
--config`.
And as a result, I added the enum to utilize it in accessing the list
and avoid hard coded strings in functions calls.

> On the other hand, it does bother my sense of aesthetics a lot it
> our code forces our programmers to give a small integer to us, only
> so that we convert that integer to a string and use the string to
> look up a value in a hashtable, every time the program wants a
> lookup.  Performance-wise, that's not a huge downside.  It just rubs
> my sense of code hygiene the wrong way.
>
> Especially when the primary way for our programmers to specify which
> advice they are talking about is by passing an integer, and if we
> need to have a table indexed by that integer in the program anyway.
>
> We could instead do something like:
>
>     /* advice.h */
>     #ifndef _ADVICE_H_
>     #define _ADVICE_H_ 1
>     extern const char ADVICE_ADD_EMBEDDED_REPO[];
>     extern const char ADVICE_AM_WORK_DIR[];
>     ...
>     #endif
>
>     /* advice.c */
>     const char ADVICE_ADD_EMBEDDED_REPO[] = "advice.addEmbeddedRepo";
>     const char ADVICE_ADD_AM_WORK_DIR[] = "advice.amWorkDir";
>     ...
>
> and the callers can still do
>
>     advise_if_enabled(ADVICE_NESTED_TAG,
>                       _(message_advice_nested_tag), tag, object_ref);
>
> with the benefit of compiler catching a silly typo, without having
> to have any "enum-to-string" table while letting the config API
> layer do any caching transparently.  As these calls will never be
> placed in a performance critical codepath, that might be more
> appropriate.
>

I'm not against this approach as well, but as I mentioned above, we
need a list of keys to be returned by list_config_advices(), that's
why defining the constant strings will not be sufficient in our case.

Thanks,
Heba
