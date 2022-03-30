Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ACDC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 04:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbiC3Esy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 00:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiC3Esw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 00:48:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2032AA02B
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 21:47:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so39083506ejd.5
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 21:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1BvRd31FUUzlIKABN4HVZW3iHW1dv/aR2fxdsFonI4=;
        b=pokgQl3XgD84OrB/fXt1qTFQvGglwCtLPIhkTC/o2EPr9O/BadcVK9radXWkkU2xFU
         qBEVJ80Wky+VGEk2TVGJytPK5wesa/QQ9WFllsxKOMR8asaP7QHK7pTOnd1GQXMdNxsi
         zf8qaSatQKMOC2Y/MiDJnGUTxNVDRh2aD/08Phxpfe5SpA0RTo0RxmU1ROEXWyfaVKN/
         M3G3mBfE9SFQ11waB7sMK6BJ48S+b/giKYQ9mUn/uUajXTj6dKsOn4hBBnLoPeM3xVl/
         uhf+UtAjUa6MGJyW/9/wiytByuRXWiKWWZHS4GJrQ7Y9kQPCAMsI0z/gVj7x1M6kQkOb
         Sq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1BvRd31FUUzlIKABN4HVZW3iHW1dv/aR2fxdsFonI4=;
        b=GopMS750uFcsgUisgZEWekRRdKa4S0YcOGIXLDIxU4E3uuy6H8YytORrGK4jtN5/pT
         2OAVjXFCt6kXa1S2dqqOk6d6ZCaSQ2vJwRdMD4fovegz6d8kkgYgzPUF8syHs1cRRc5o
         CflqkcbYi4Z5azaOqJ+FUjhd5OjRhA/09RVWfZfQXBxsFBQI3JP2QA1d1vg2fb1ASR+v
         UpV8sR51yX+h2GAeZRXOetA6bUcSnGk8JvogGNdBdRg3KZJ2rxqP5B5VXbrhZvLyDudb
         brh8gNcYBGwI+1J0bWpChe2K49Mj3VjS572iqK3J0o0cLESj+Y94JEDpBvPB694kDr82
         wQdQ==
X-Gm-Message-State: AOAM532eSw5al45QqgRiao9Foe3IKcP/imwWRM3f9tJpFFlIfS9HdZOL
        QCAp6ksMdNimuP/6i9Lqksayu7CtZLIpBHEzSKzXbqOMYWBdrSWH
X-Google-Smtp-Source: ABdhPJxzWIRjqPiYBScxzppESWfg8vrMFlZU+/CQTtHNlH7otftVMpaUDad9MDy7/ednZP+kFFGpyMjWFHhTb9X4w1E=
X-Received: by 2002:a17:906:4fc8:b0:6d8:5059:f998 with SMTP id
 i8-20020a1709064fc800b006d85059f998mr38825270ejw.487.1648615627117; Tue, 29
 Mar 2022 21:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
 <pull.985.v5.git.1648553134.gitgitgadget@gmail.com> <98a4d8f35c5abfcda5590f7e511f7b576000fd5a.1648553134.git.gitgitgadget@gmail.com>
 <xmqq5ynwwvli.fsf@gitster.g>
In-Reply-To: <xmqq5ynwwvli.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 30 Mar 2022 06:46:52 +0200
Message-ID: <CAPMMpoigpEi9mTET1r9sbSdw92kUXw9cRQPdUv-O179j3+_wAQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] untracked-cache: test untracked-cache-bypassing
 behavior with -uall
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 6:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +# Bypassing the untracked cache here is not desirable, but it expected
> > +# in the current implementation
>
> If that is the case, it is much more desirable to squash it into a
> single [2/2] patch so that the desirable working is documented (so
> future breakage can be caught), the reviewers can read what the
> intended behaviour is more easily (so we do not have to be confused
> by this one saying "expect success"), make it easier to cherry-pick
> the fix and test in the same patch elsewhere, and the existing
> breakage can easily be caught by applying only the test part of the
> patch.

Sorry, I'm not completely sure whether my comment was misleading, or
whether I'm misunderstanding your feedback.

The test added here does not test "desirable" behavior from an
end-user functional perspective, but it does test behavior that is
working "as-designed" as of many years ago.

The intent in adding this test is to ensure that if/when someone
changes this behavior down the line, they be forced to understand the
implications (eg: the current untracked cache structure does not store
the same data for a -uall run as for a -unormal run, and so using the
data from one in another would lead to output correctness errors).

Importantly, the behavior that this test is exercising *is not
changed* by the 2/2 "improvement" patch; this is why I separated it
out - it's a change that I feel we should make either way, and could
even be its own independent patch. It's in this series as it adds
relevant context and I am later adding similar tests for the
new/additional behavior.

Given the (I believe) misunderstanding, a better comment would be
something like:

# Bypassing the untracked cache here is not desirable from an
# end-user perspective, but is expected in the current implementation.
# The untracked cache data stored for a -unormal run cannot be
# correctly used in a -uall run - it would yield incorrect output.

Does that make more sense?
