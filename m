Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C219FC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C243214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3iZv7K7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgAaUPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:15:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32944 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgAaUPe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:15:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so9178148edq.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKLdNBtxrFlvQvduh7HiJZzkSRjk+IR8jKffNeSg8yE=;
        b=c3iZv7K7qdEF1bdRqHAm659TCPQmFGyAkRpAx7/ptid8R6bV+fycbndxxFXI2yHGiL
         2048Ykdo9xlC2wxTbcHf4uZ+t6+4QsZ2GcSf6jf2KlR9mm/0885cSW4ZoE7Zu40tIE1p
         nmy1/Qmhvxs4VPwqMSs/MuXlfAD1B77WvAe9WGI44QF5KVCImFR7himj6uowh9iuZsE1
         TLYSV/9WV4G05Ri9Uw/2UdWohzQ83Q1gYxEEyCzaOr0Vtb/gwvvbNQvAuwY182D4KgKf
         8VGI+INp/uVA3Rp+Fh8wJ3Uqzg/lrRqOHfJau/sxYnuE1a/tbpvUR6l6zM7Mx2i56b7J
         UViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKLdNBtxrFlvQvduh7HiJZzkSRjk+IR8jKffNeSg8yE=;
        b=UQYL/HkC9Q34oEEz0RBy6YcTMbY5qrXvMCsVCG5Xt6kSgGuMM08zaW/8M+Ubs9ToTw
         41ktp80fyUoaF+B41fnvqpByzN2sOgpSBCHTP9fL9hfvFHYr51WZ3EhmOPi6oL0t7hCX
         2R7NhCLTH+7UbhMrQ609CaiSKqK2o8ZNgZPfxhae1+9+dTPgZ4VLdZV1waU0pQQbkkVR
         V75YIjlemhZY1fbcBS0FRRDzTGthHXyVmBgDgY7M73EybTM06NtKsFT2zJxpqHrzhVai
         BwDl+4e5TkzkCAgAhjvBhh9h/2Rp1W6FdugEd0ugCBjXpFW8IH9SNz0oZ8S66PHPyCnh
         lkag==
X-Gm-Message-State: APjAAAWt5UJK3uNZe3uttb20cvyVhvbGDQkR8zBmz6yBd6+Ye7Pk9hoj
        iXCd4yoIcYUt75gSTIFz7JBuOyM287o5tqJ8vL8=
X-Google-Smtp-Source: APXvYqxmPPZCRSKX0csqTwLST04q43VpvRuOSE+BA5cP7FQli3SmoNKRxuJqoO5l3J8YinM9HTNltAP1hPx50KaxF6c=
X-Received: by 2002:a17:906:8d0:: with SMTP id o16mr10423380eje.101.1580501731780;
 Fri, 31 Jan 2020 12:15:31 -0800 (PST)
MIME-Version: 1.0
References: <xmqqv9owa6cw.fsf@gitster-ct.c.googlers.com> <20200127232004.GE19360@coredump.intra.peff.net>
 <xmqq36c09zo0.fsf@gitster-ct.c.googlers.com> <xmqqa764d9f1.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa764d9f1.fsf_-_@gitster-ct.c.googlers.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Date:   Fri, 31 Jan 2020 21:15:14 +0100
Message-ID: <CACayv=hcH=dvfup2fzm5-OKYxEyC1m7YBTfpm=6z0BhO=hK-cQ@mail.gmail.com>
Subject: Re: [PATCH v2] C: use skip-prefix to avoid hardcoded string length
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/20 8:35 PM, Junio C Hamano wrote:
> We often skip an optional prefix in a string with a hardcoded
> constant, e.g.
>
>       if (starts_with(string, "prefix"))
>               string += 6;
>
> which is less error prone when written
>
>       skip_prefix(string, "prefix", &string);

Should the subject line say "skip_prefix" with an underscore instead of
"skip-prefix" with a dash?
