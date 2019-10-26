Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834B21F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 09:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfJZJ34 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 05:29:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37255 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfJZJ3z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 05:29:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id e12so3732096edr.4
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9Vf9RTrd9bZG9TkKLURdJQUcIZRDnp89wEi55+upyo=;
        b=iM0WCSIavpyVVYMxhL96cceGe19LDjXzRzh89Mt08hzzKRQlY4yDYQuIZZIpr5JVC5
         sUoQHCX9LMD5NquiVnzHhtaI6E06eACSUOk/R2KplgVeEf43hiZMwlKyv6e7/f56QOCr
         b7rUWS59Cek7PZAf+UiCUFcRJzF0+UBfqE/RRLtQlJzdgQ+mM6mNCBCa8JId3owevyXB
         2yRMXYNmBFhvm1zwadg+KXqI2lsUdbIyQhSLQQKYiFc4xgy8oZ7R1IISkYE/s99RR06e
         Te8dVLzxD84yvriZxC5uFmDK9ZYbFf0QLhII8HUrpFjjNQ17ChgoRvr+X8VETWufnQ/O
         apIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9Vf9RTrd9bZG9TkKLURdJQUcIZRDnp89wEi55+upyo=;
        b=NlsEvlnN26Lqi/IBWExU7gZxt2BSw/Ze0T0PMjY5wi+T4zLVZpNUgwfcr45kgvuuJA
         X0dsqSDV7OFEtFStuSXq0wnEefzWhvY3RHz4V82GPGX/LjSOHl0uCNKzpe108o/dY7be
         +ewTucubEMb019MinaeaCVFpC6PsNFTwhW1soVQyrBiGlPrPLV5zKh2MEcXRkJrq00lL
         deEgBuu1pxVO6gFARvIpXS21NbjI+HKLUaN5Y0sd/YNpdVYiRfrQs+2auKAmXTHZDBS5
         C3yEwJQrjco2+2sESMGw3mJfIdkJid9DIkloZ8+M5RnqEavnM77EW0PY9kmrd/Q7bpGn
         Ioug==
X-Gm-Message-State: APjAAAWy6kgygU8c+a6Vksi3v/NCXb+3DP7rFEhI8SPBTVDitA7WuRqY
        rnFQn58F/cjzHArbWKfBTjVkbbG5Czp4Pxjp7N4=
X-Google-Smtp-Source: APXvYqwsPJn2WWm28t1WLNHPkq9GWXjXC+97xSacms9HYkBumm1m/ZardZM0Sx4XPIVV/eGCn3w3lso1gloydGuXXdw=
X-Received: by 2002:a17:906:4d4f:: with SMTP id b15mr7257529ejv.81.1572082194106;
 Sat, 26 Oct 2019 02:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191019103531.23274-4-chriscool@tuxfamily.org> <20191022174628.115505-1-jonathantanmy@google.com>
In-Reply-To: <20191022174628.115505-1-jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 26 Oct 2019 11:29:42 +0200
Message-ID: <CAP8UFD05uH7m7p0iR6g91MEd1QFd8vrJpKeKXsi0Brb9PKVQMg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] ewah/bitmap: introduce bitmap_word_alloc()
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 7:46 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > From: Jeff King <peff@peff.net>
> >
> > In a following commit we will need to allocate a variable
> > number of bitmap words, instead of always 32, so let's add
> > bitmap_word_alloc() for this purpose.
> >
> > We will also always access at least one word for each bitmap,
> > so we want to make sure that at least one is always
> > allocated.
>
> The last paragraph is not true - we still can allocate 0. (We just ensure
> that when we grow, we grow to at least 1.) I think we should just
> delete the last paragraph - the first paragraph is sufficient.

Ok, I removed the last paragraph in my current version.

> Other than that, all patches up to but not including the last one look
> good, except the ones that just add a new function because I'll have to
> review the last patch to see how they are used.

Thanks for your review,
Christian.
