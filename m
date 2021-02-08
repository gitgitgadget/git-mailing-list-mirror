Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B1FC433E6
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 17:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C43964DF0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhBHRKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 12:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhBHRIa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 12:08:30 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F02C061793
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 09:07:50 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id i20so14842107otl.7
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 09:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXzeqKaKUUawXJ9FFviQLVD+dtADRUZDQlWFm0CPmSw=;
        b=gBfxyfn6vfWHrCih2pVgrAeLQ9WkUzLY8+XlcEqaEKiCjAprX4TGQDZ9iACexwquk0
         wJLhUDisaNlnJZor5NipXr0kq8awtKK8NHIt8biJvt0JBIE0uLLsHsIUJs0cYBvuAUWz
         xBG72DIb5brZ63eVeOskf0Ny9QyeSuhNzdU1Sv21ZUQfJ+oYj7H/sIH8ss6nrwYOLo/0
         6JYSm11BJvGfi26nhGCjmJMiuqLWx4goSM28myH1WdVExSgYGKDbI+wZHwdpJlpq3Rcd
         AagEFEO5jsZci0PYZIJPiuS5sYfdrAKTXzohBUkXXvBl3CNqjtcZTLV17pttgY0LZBVm
         4SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXzeqKaKUUawXJ9FFviQLVD+dtADRUZDQlWFm0CPmSw=;
        b=c42RwqFBDuCOTfcLEchJ8WP8h1wsx2N3ekneAfiBmqxAAl4AUudfRnR4Hnzo8PRHOt
         4xacAPy37Eb4tw8j0F3TlIdp1ODUFgpCuooBQ6YwoQJ5rk9ZoBdV6qIdoOAjjWen3pOL
         tv1NDSx9T4K/D+TNiecSLJ9ZnGaSsVKpDPa53zKma1Mq39uT/t7edgQz0lyzEc2PVby3
         yzMgu7qYWEmlOKBS6LrANVtqIptOom/Sbsi7QDe6674u/eaIQcSNYy2KA3IXUmZCWeAO
         Oq5UOmSoBsMAg2oRozrzGC+bfrK+iXpcclkjIEagaVHXMGaz9Vw9GyuFOTkr7r0i/kUq
         8BGw==
X-Gm-Message-State: AOAM530KesbDOkBM1qfM3vd2V1UJT33O8TYuZS3KxtxPNQQtJfggRNaz
        Kof3z8YiwZmj0cyaD7glbcSxcSIwf1SAYBDEuvA=
X-Google-Smtp-Source: ABdhPJzaR+E+uJ4lBuTkUAbBhVwX88k0KrDb0tZ/m9iMSiefqmlcF0pSPrBmbvUHmKDQJb95KJx0VS/0bU8hYtbrzcI=
X-Received: by 2002:a9d:b85:: with SMTP id 5mr13662202oth.281.1612804069890;
 Mon, 08 Feb 2021 09:07:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
 <pull.726.v3.git.1612602945.gitgitgadget@gmail.com> <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
 <xmqqpn1c8m7u.fsf@gitster.c.googlers.com> <CA+CkUQ9-OCiEkMDRTpyF3rp-g1mSSzn4s9MgqJZ2BJY=XJCoEw@mail.gmail.com>
 <xmqqh7mn91w2.fsf@gitster.c.googlers.com> <CA+CkUQ9kHhbDVMru=pRO90o+k7cc_ykxN9JRFGMvoG3hkeGJpA@mail.gmail.com>
 <xmqqlfbz7i7i.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfbz7i7i.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Mon, 8 Feb 2021 22:37:38 +0530
Message-ID: <CA+CkUQ_cdUmuP+_yUeCytn=6cc8SjMBE1aTLzWJL-U_V01uzog@mail.gmail.com>
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

On Mon, Feb 8, 2021 at 1:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> If we agree that the current behaviour is *not* sensible, then we
> can.  On the "log --pretty" side, we have "terminator semantics" and
> "separator semantics" between "tformat" and "format", when showing
> more than one commits in a row, the "terminator semantics" places
> one blank line after each commit we emit, while the "separator
> semantics" gives one blank line between each commit pair.  I think
> we initially (incorrectly) used terminator semantics and our output
> for two commits looked like "CommitA <blank> CommitB <blank>" before
> we fixed it to use separator semantics to show "CommitA <blank> CommitB"
> without the useless trailing blank line.  We can apply the same principle
> when "fixing" this issue to show a block of trailer lines (that is, the
> change in behaviour to remove the trailing blank line turns out to
> be a "fix").

I suspect that "fix" for "log --pretty" isn't going to work here.

Even if we apply the same "log --pretty"'s fix here. I think we still
end up having an empty blank line between each ref item.

Thank,
Hariom
