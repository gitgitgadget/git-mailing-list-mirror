Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DADC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 17:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7900D23B40
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 17:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbhANRHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 12:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbhANRHK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 12:07:10 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5527BC061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 09:06:25 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 22so8909439qkf.9
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 09:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x7AWxJgrXCr1UJpFkrbLLehc66mNGp+qDpEYJrK8HTo=;
        b=hUKN6zUzVVFkU+0asdR1gYSLoK47gaZGvOheUL1XkDkJ+NKL9U5QGLPk8RRdlSZQAU
         jhClnAbbD9OylpFR3auYS8ModkdUdhdP/xuemohb2mmu5XYsbsmJ7/N34blDnFPuEjbR
         sYcUYU+XOASTjskH/zvidciwDTRkZ0uTnF5uI9NNtjdJzdWAhO2z4uxRrYVcc+zqQYG7
         CFRjfGk/nLekMf0Ee8QlHbv/EyxtRdG5aCvTT4TnarFUwaj5i9iDJ39TOq1ldI4sT7ef
         5b9VZnfXvXnaiXFs1yV7MZZXuvd1dVHIIcKW/gHY8EZ5YrR45/8FnOyJR8th8mst/GvC
         TzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x7AWxJgrXCr1UJpFkrbLLehc66mNGp+qDpEYJrK8HTo=;
        b=ADBJMfcoDFwSjK6/CJbXoK8Vpl/WLgqho3W3a5nyJb4rgyLvA5QMmgX5dtkr11e1ta
         FnIlQJS+Eq5sHJzV0fJLO4z1QQTUMVE05XjRBuMOqiDlyep49NhDwgs+6X5K42Aggua9
         JY3hR9W5JEZcMsUY0Zt+Utdaz2i66pJhId0KBxRo/OWVUJTe2QZ7sacDo6Z758H3leN9
         Q0gEZjOF7caSqAL+hZAK7SkWtFHnVp1KlkxikOXl/Huu727j4/Po5ndd8Cu92kkk00Zc
         EUEvOiS+WL5smsyze7c80PzhOa/HyiF4AOltSi2zeKfebWtzAR69F6O2j6aBqF1H/krr
         3jRQ==
X-Gm-Message-State: AOAM5323pTIYS+D3wO7Vc32Du6V2qyqCC5b0Dbrn9sMYucamiTJt+Bza
        4YXFvYRQiUow5S5iSzukugYtXHgajiqE3w==
X-Google-Smtp-Source: ABdhPJxxQ8eCQ77PcFCewJ0A67QmcCk8zIhI4Jc/EqUa6fXLtM4wFLVEMMxHamZZmYhdUS4Pq///Sg==
X-Received: by 2002:a37:9d0e:: with SMTP id g14mr7886819qke.125.1610643984558;
        Thu, 14 Jan 2021 09:06:24 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id x185sm3316253qkb.87.2021.01.14.09.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:06:23 -0800 (PST)
Date:   Thu, 14 Jan 2021 12:06:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 01/20] pack-revindex: introduce a new API
Message-ID: <YAB6DNk4wPBVbGtU@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <e1aa89244ad3edb52aaeb28d6934cb2b0a0dc65a.1610576604.git.me@ttaylorr.com>
 <xmqq1reoypzy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1reoypzy.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 10:46:57PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > +/*
> > + * offset_to_pack_pos converts an object offset to a pack position. This
> > + * function returns zero on success, and a negative number otherwise. The
> > + * parameter 'pos' is usable only on success.
> > + *
> > + * If the reverse index has not yet been loaded, this function loads it lazily,
> > + * and returns an negative number if an error was encountered.
>
> It is somewhat strange to see a function that yields a non-negative
> "position" on success and a negative value to signal a failure to
> have a separate pointer to the location to receive the true return
> value.  Do we truly care the upper half of "uint32_t" (in other
> words, do we seriously want to support more than 2G positions in a
> pack)?

I don't think that we care about that as much as we do about potential
misuse of a signed return value. There are indeed a couple of spots
where a potential negative return value is ignored, and then used to
lookup an object in a pack, or some such.

And that's part of the goal of this API: we have strict guidelines about
when the output parameter is and isn't usable. That makes it more
difficult to accidentally use an uninitialized value / negative number.

> What I'm trying to get at is that [...] is more natural than [...] but
> now I wrote it down and laid it out in front of my eyes, the latter
> does not look too bad.

OK, good :-).

> 	... later comes back after reading through the series ...
>
> 	The new callers all looked quite nice to eyes.  Because we
> 	discourage assignment inside if() condition, the converted
> 	result does not make the code more verbose than the
> 	original.  In fact, it makes it even clearer that we are
> 	checking for an error return from a function call.
>
> 	Quite nice.

Thank you :-D.

> > + * This function runs in time O(log N) with the number of objects in the pack.
>
> Is it a good idea to commit to such performance characteristics as a
> promise to callers like this (the comment applies to all three
> functions)?
>
> It depends on how a developer is helped by this comment when
> deciding whether to use this function, or find other ways, to
> implement what s/he wants to do.

I don't mind it. If they all had the same performance characteristics, I
wouldn't be for it, but since they don't, I think that it's good to
know. Peff suggested this back in [1].

Thanks,
Taylor

[1]: https://lore.kernel.org/git/X%2F1guCOGWybOzIS7@coredump.intra.peff.net/
