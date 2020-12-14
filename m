Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B6C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 00:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFDA224B0
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 00:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437325AbgLNA6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 19:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLNA6I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 19:58:08 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F27C0613CF
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 16:57:27 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so13775555wmf.3
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 16:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vE5jha/DWwksrKCmEdDKft1fm3zwmmDzMKFgJisAIwk=;
        b=PuXuGgWCFkKUmrhyHb6rrqhto2Vo3elFVSjmf6lSkK2ZWwSpS13AW3IpGzVZgUFEMb
         0fDL0SKrmsiWAFeMkql86xeCrhPZbq9sclicGDr+GZJ3BdBAEYn5XIE1RgEIEy/RN57u
         Ypj6Uny14ndl/7GS96Mo1LDBgf8We/N5IE7MoohS2iMxmKk2MDbDWTLDx40nldsela8x
         ULhTLNSmsLGiX4EycbkXC7s16ULzSfrDNV5OwbYnP4w5B7nd42MTYGSEoL6iJ0KEXAM2
         96v6776fiqLDVEnOWYjG2YAdLXGr6niI0Kk59rQ1tcxi0TCFC5enF9NaCx49aDx48Iyh
         hqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vE5jha/DWwksrKCmEdDKft1fm3zwmmDzMKFgJisAIwk=;
        b=POWldwxrGqD0unoXuPYW738HA22pY3t7dHMGtdLVhRE64Xyaznq8noMDfmmFUSZdQ/
         R59wS3waA2s+aB24sRGCvHN8TWZxOhP9cIIX5+96jMBRrxjHPOwo181iOit0uLNgI6LP
         w2/ug/YTMZmTxfUmvEHQPVkLfp7blhzoOu0T/JvT4+3tO7nT/9AvqrYabptaBIqpei63
         YeHKjkz4jXnEYJHR+rGoLatJIKaugHmPd4g8Fk5o82NtfU0BH11Qab5W6bI+QJ51ZxlX
         p7GqWMFQFFAazerqacEJFn28jXIQzjQokhwWsbV9OwrkKSGkaR32EUuucxV9/f0CWJK1
         l6PQ==
X-Gm-Message-State: AOAM531zkpnbD1kNAzRwgzt1wBO2FYWeBDrRJ8h3gNqyXXItnpExasgk
        hx7fRlUUg6mhgOeDhikTpEhp9bHgpyXRTsBFCP2GPlLHAKoiseLF
X-Google-Smtp-Source: ABdhPJwVu7YZa6oLeqw9NIXLL9/J5mAuoBlOwYIlooBihEzo0Odms6dfmQPGaa5fJxxUJsppAlGQnpStvAso7ya9wrU=
X-Received: by 2002:a05:600c:4101:: with SMTP id j1mr5381082wmi.55.1607907446603;
 Sun, 13 Dec 2020 16:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <xmqqo8j0io39.fsf@gitster.c.googlers.com> <CAMP44s0uyxs4p+HJ5ZDrrKJs9wQW4tSCZzPonpvP=FcTGCcxSA@mail.gmail.com>
 <xmqqv9d7faot.fsf@gitster.c.googlers.com> <5fd4f189a1f4e_bc1eb20891@natae.notmuch>
In-Reply-To: <5fd4f189a1f4e_bc1eb20891@natae.notmuch>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 13 Dec 2020 18:57:15 -0600
Message-ID: <CAMP44s2VoMeFaS-eBSJt2N9T2T1aPHJ4-XeaA34J95t+RztXHw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] pull: stop warning on every pull
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 12, 2020 at 10:36 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Junio C Hamano wrote:

> > I am starting to feel myself that "don't do anything if this is not
> > a fast-forward" may be something that would have been great if we
> > had it from day one but is no longer a feasible default with
> > existing users, to be quite honest, so you can count my 20% as
> > another example.
>
> As opposed to virtually everyone in this mailing list that has given an
> opinion about the topic in the last 10 years (including you I count 3
> out of literally dozens).

A quick update after reading a great deal of mails.

The only person I counted in 2013 that was against changing the
default is Matthieu Moy, and reading back what he said, even him was
in favor of adding a configuration for the new mode [1]. What he was
against was making it the default, and adding a warning stating it
would be the default.

Fortunately my patches introduce the mode [2] without making it
necessarily the default (we don't even have to change the warning and
say it will be changed in the future [3]).

So *nobody* was against the introduction of such mode.

Also, after reading the input from GitHub trainers, which Jeff
provided [4], perhaps leaving the default as "merge" makes sense. Our
curse of knowledge may bias us into thinking the user knows what a
rebase is. Maybe a permanent advice warning is the way to go, I'm
still mulling it over.

> Anyway, this is not relevant today, because you were the one that
> proposed to go straight to an error.
>
> What I propose for today is to introduce the option
> "pull.mode=fast-forward", and improve the warning. Not an error.
>
> That doesn't break the behavior for anyone, including Schindelin.

This is still true. We don't lose anything by introducing the mode.

We can make the decision to flip the default later (or not).

Cheers.

[1] https://lore.kernel.org/git/vpqbo41lo2v.fsf@anie.imag.fr/
[2] https://lore.kernel.org/git/20201208002648.1370414-18-felipe.contreras@gmail.com/
[3] https://lore.kernel.org/git/20201208002648.1370414-19-felipe.contreras@gmail.com/
[4] https://lore.kernel.org/git/20130909201751.GA14437@sigill.intra.peff.net/

-- 
Felipe Contreras
