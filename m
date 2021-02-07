Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D196C433E6
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEE564DA1
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBGTjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 14:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGTjS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 14:39:18 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880DC061756
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 11:38:38 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id o12so12177009ote.12
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 11:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzrQEjuuyYe2MKag/0QdFeCLi6pSt5t5B8KH5iAExz8=;
        b=ln8VMsl6AsNwUYM4WuRKgwKeUt8sOUUbDIjUqkpJh/3oyJaaKh8+oRFsr3mkA3upEz
         GwtqyRxW9EmCtOHj+j+0o1MG8BuFW3Eg2DPrZC8LvpuVTkK3DQZURaKIlGF+YgllhOtc
         fJYT7xnUiQauNORCK6GGeKAHwDdrjso3OkOS3q297yAj5Cnv+LSHiLmYnq9j0i2uKYHE
         IzzRtnTVHbvhtD3xZi4lbo6G0f4+WGF5tiwd8jTrZhCNb0/tx/rBHTg0GUTK7L0xUI1V
         oimSPIxvHkr35cag7Zsl7jb5hslXTq+hOhL0cJJQuao45XbpXwX8+hRhvvEh76bdsjbN
         POWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzrQEjuuyYe2MKag/0QdFeCLi6pSt5t5B8KH5iAExz8=;
        b=rqBV49g91zJ7w2/7mEww2SPrKUlTY94zb6psUPKF4ma45WiDO6REzE6nb12T4O5bUz
         LyT0/SIipC8FPr7RUSAqAOnpDwMc7EmT723ieCT2K3HvME0HLnhNnfs0DwNtIshnYFhH
         FJXneMjBYk+wiWa/Fnyi2b2XCFmv9CrbTbVT7jqgZuCP1qmgb3lVCUMvChoYPqhpSDXm
         fjJktLLhQPhZRuu8fnQjRxt3viTxrpo01Nw+Z4/mMj4fjjpBDi0BvgHZMm0Nyg5L9ie1
         GW+M79UAXEc/DqXp2RGaKKWhmGJuGhVIqd/r7xK5OfQf7tZJD9lsrQ5KLjt64ozgMpp4
         LwuQ==
X-Gm-Message-State: AOAM532ObmGJMDLCgujanp87aRshtA6G7RpDThoKaulZRYNTQT4pFkxO
        2S+tQeVVw6TlxTpiAn4gRKfqlSNCTw0xi+taL6I=
X-Google-Smtp-Source: ABdhPJygo5XXQD93OqpYc4w5Z0vsi1N+3IVjIXah51cO20mLkBrFKiFyt4Kt1mo88COwLMyir3idcD/uX3vg/FLv9nM=
X-Received: by 2002:a9d:6c90:: with SMTP id c16mr10513743otr.177.1612726717720;
 Sun, 07 Feb 2021 11:38:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
 <pull.726.v3.git.1612602945.gitgitgadget@gmail.com> <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
 <xmqqpn1c8m7u.fsf@gitster.c.googlers.com> <CA+CkUQ9-OCiEkMDRTpyF3rp-g1mSSzn4s9MgqJZ2BJY=XJCoEw@mail.gmail.com>
 <xmqqh7mn91w2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7mn91w2.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Mon, 8 Feb 2021 01:08:26 +0530
Message-ID: <CA+CkUQ9kHhbDVMru=pRO90o+k7cc_ykxN9JRFGMvoG3hkeGJpA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: use pretty.c logic for trailers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Feb 7, 2021 at 11:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Hariom verma <hariom18599@gmail.com> writes:
>
> > Do you want me to include a patch to get rid of this "extra blank
> > line" for trailers in "for-each-ref"?
>
> I do not know the answer to the last question, because we haven't
> learned the original reason why we decided to add the extra blank
> line after the trailer output.  Even though I find it unnecessary,
> the code that adds it must have been written with a good reason to
> do so, and I do not want to see us remove the "\n" without knowing
> that reason.

As per my understanding it works something like this:

print a ref item... put newline... print a ref item... put newline..
print a ref item... put newline... (so on)

But the catch is that trailer comes with a newline already included.
So it becomes:

print trailers with newline included... put newline... print trailers
with newline included... put newline.. (so on)

So we end up having 2 new lines in total.

we just can't directly remove the newline. but we introduce an option
to skip at will. Something like this?
https://github.com/harry-hov/git/commit/af75f5c9b0325af90831998f56d6f36b6baa928e

So we can turn off newline(extra) for trailers without disturbing
"for-each-ref"'s working.

Thanks,
Hariom.
