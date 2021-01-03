Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB8EC433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 14:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77012080D
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 14:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbhACOu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 09:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbhACOu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 09:50:57 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9098C061573
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 06:50:16 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s26so58603083lfc.8
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rN+ULSmpyOLafgHUgIE/rtSu5ZzYkxuxFh19lS0DYuo=;
        b=ir3kbJhlytmXjplp9n2xD6+5qyrxP5F6MFn6zST5m4IS/GaoXeq+EJnNVnvSyg20S4
         V4PzmpSCVxrRR6RGVCwQG6x/7toCR40VtLzJixiFH4d2qfYjagKjyunqTa2jndDwQebH
         khBNadjSY5rfVtbn8nx3lhCkVSkj9XiRTFKvD9oElXKhL3y4UMm0qfxh/rMgFPEjUF78
         eeQo4+IruTgo+ivjx/9ojLsFU1DvOvH3OcRTlrMYiUj6wUrLmkr8aTKMjPugAFAEhh1R
         +KNTdf+XHxuYDVyDSYXArjwjITQ2hZ9r/VstwxmGpJYQ1k6ECCCaKUh8zhZ0Kxf7XaYE
         QJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rN+ULSmpyOLafgHUgIE/rtSu5ZzYkxuxFh19lS0DYuo=;
        b=ia9G7/QBmRGPbGnqXjnF7MDZPxJzirF0lAu68WK3feaGGYzPc0ZazI647ckD92hQP2
         B2yZffzB9oXGuNHIhMd0JV3h7SeyN00+COFhQg+DUciPpvEMxf6sCDTL3VI2qChPkAFg
         u86U1/saBNrrHC7acYpxE9GotdKgVKpYgRuosjwNojNpI15pxcP3unIAbC4A3ktBzIoj
         A2Z5CW9d9QXoELPL0cKFNRrFVKn1GiprjEpIa79QP9UYKcBTy//hAY/0D1+/eH0KK0hr
         Jyrm/D6iAHAuN9O04mZwgI0I3XpiNMY9ja3g1FTa5+JUYe1ToZ8eEFlhuIBqjHYXxb9J
         L5/w==
X-Gm-Message-State: AOAM530BwBg1LGRcCQstwvwiHQocme3rcybjDKNsQTLw5KSgRuDnhdoA
        FxYkVMd0Zn3eRFYFtoQqTrQjjyqu0K6D1UOSQAE=
X-Google-Smtp-Source: ABdhPJyfH28WhoS1wjVW5ZaE8VHEFUs6HutLHEFJpyh9xOg0lWvSLg829/oaR4fK4saSTE/rWLgDKuHSoOR+TclYR0g=
X-Received: by 2002:a19:48e:: with SMTP id 136mr31848615lfe.357.1609685415330;
 Sun, 03 Jan 2021 06:50:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.831.git.1609609214040.gitgitgadget@gmail.com>
 <CAN0heSojPyr=g5PBVmT4VTfxxKxzYcFXJ1jynM1tGuZSyQMykg@mail.gmail.com> <5ff0f31315732_a76d20833@natae.notmuch>
In-Reply-To: <5ff0f31315732_a76d20833@natae.notmuch>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 3 Jan 2021 06:50:04 -0800
Message-ID: <CAPx1Gvd=zL4VWUY2GJHfuLh19H_=ePj22aYfyh9rhwyQRFJ-hg@mail.gmail.com>
Subject: Re: [PATCH] doc: fix some typos
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Ackermann <th.acker@arcor.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 2, 2021 at 2:31 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> But this works:
>
> #error "might or mightn't work"

Right: the rule here is that the preprocessor, even inside "#if 0"
sections, is working with "pp-token"s.  Single quotes are still
character constants and must be paired.  Double quotes are still
string constants (token-wise) and also must be paired like this,
but now you can hide apostrophes.

Chris
