Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD6AC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 03:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B08D610A1
	for <git@archiver.kernel.org>; Mon, 17 May 2021 03:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhEQDZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 23:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhEQDZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 23:25:16 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E3C061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 20:23:58 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id s19so5260309oic.7
        for <git@vger.kernel.org>; Sun, 16 May 2021 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Tz6UzsPjVqxRTwLQrZmI1+1F/Atj6mFNf/fUZrZBCyc=;
        b=JYvODOosmbbcIL6XO97jRsGl+w60+e5cPuNA5OoEbBPwHMIcRkxiJPVTGQK1DeAZ6L
         4JN8DYGMCEn0xWvLR4Mj0VKD1i/FFrtMwmNmj4u7k9riRqQnXhEhdHK/KNyBk0B9P1oB
         Qs5b4iw9PRxFAqq+lA6RolBJOfXOB2+X6L8AsQg3JZR+qRvnncQDpvYj80vmsUfemqdX
         EEaMWcayggt8wyTRGhmB4Fs3ZA83J+eEsI8pPrg/1wlxWXNUL7dcJD5bsWz5M0foum/n
         RVxf8osN8vbYZbX0ecd7tQiWfxTOuBTjRoGpth/FFCNjbzmILsz/1wtZQuEgh7hE4rzR
         AvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Tz6UzsPjVqxRTwLQrZmI1+1F/Atj6mFNf/fUZrZBCyc=;
        b=f1siQo4gx7N7Mv4x6Eo4hcROGm84172kwsTqusJJ+pYu1Ir1lYx6iLmwPcuQH9fr0K
         5mrPAaPxfKWOHiQNjd3VGw7uihRsJSUzEu5xc4amRZ82W0IsUE3hSa+MDQ8f8Y5/hA8/
         tHBcfKoeW5Fn/t2t5lUETxWTqqbLucrPGB4EH7zAOqbHJ5NoW+RM3yM9HDaA96B5zpGS
         +MEGKlG2avyEu4b39KuXUBAe+T6O7d2dkaVJnBvgXfLF9MEDmAWSdhGnWkRVLNXN4IzQ
         J5AEEZGcEjoe1Xs1G3kTKjNkLQdHLZMZ39GGcm6zEY1Uu61l/NjctSEkZwQ84XSUe70h
         Wbhw==
X-Gm-Message-State: AOAM532RzZnRFqE5na5lXLVJS9PMZsD9D8n89SsK9wCxeanDZR9Zc6Vf
        fPc30WfTTZD5uhhcOQRhnBWEiIWaRwjMEQ==
X-Google-Smtp-Source: ABdhPJzRkIaU+g3QQaRIoP9ryrSkrRNxb+fN5IpX3tKqXvQZT4abM9zwademRy1NvH4StvURFa0ETA==
X-Received: by 2002:aca:eb02:: with SMTP id j2mr14292173oih.92.1621221838163;
        Sun, 16 May 2021 20:23:58 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r10sm2532538oic.4.2021.05.16.20.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 20:23:57 -0700 (PDT)
Date:   Sun, 16 May 2021 22:23:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Personal Sam Smith <sam@samuelsmith.org>, dwh@linuxprogrammer.org
Cc:     git@vger.kernel.org
Message-ID: <60a1e1cc5b8b6_11206d20830@natae.notmuch>
In-Reply-To: <D433038A-2643-4F63-8677-CA8AB6904AE1@samuelsmith.org>
References: <D433038A-2643-4F63-8677-CA8AB6904AE1@samuelsmith.org>
Subject: Re: Preserving the ability to have both SHA1 and SHA256 signatures
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Personal Sam Smith wrote:
> One of the essential properties of any good cryptographic system is
> what is called cryptographic algorithm agility. Without it the system
> cannot easily adapt to new attacks and newly discovered weaknesses in
> cryptographic algorithms. Self-describing cryptographic primitives are
> the most convenient enabler for cryptographic agility. One advantage
> of signed hash chained provenance logs is that the whole log must be
> compromised not merely one part of it. Such a log that exhibits
> agility especially through self-describing primitives is self-healing
> in sense that new appendages to the log may use stronger crypto
> primitives which protect earlier entries in the log that use weaker
> primitives. This makes the log (or any such agile self-describing
> verifiable data structure) future proof. It is the best practice for
> designing distributed (over the internet) zero trust computing
> applications. 

This is way above my pay grade, but let me try to interpret the above.

If we have a repository with two digest algorithms:

 2. BLAKE2b (considered non-compromised)
 1. SHA-1 (broken)

We may not be confident on the SHA-1 history (1), but as long as we have
BLAKE2b history (2), we can be confident on that.

The delta between when SHA-1 was broken, and the switch to BLAKE2b
happened, is when the repository could be potentially compromised.

So, it's in the best interest of the repository owners to switch to the
non-compromised version as soon as possible. In fact, it would be better
if the switch happened *BEFORE* SHA-1 was broken.

This is why algorithm agility is important.


But this is not sufficient, because BLAKE2b could get
compromised in the future. The repository owners need to be thinking
ahead to the time, to when they'll need to make yet another algorithm
switch.

When such times comes, they need their infrastructure to be able to
perform the switch as fast as possible. If possible right after they've
finalized their decision.


So, if I can summarize your and dwh's proposal: git should be
cryptographic-digest-algorithm-agnostic.


So far this makes sense to me.

The only problem comes when you consider day-to-day operations, which to
be honest have been totally uninterrupted by 15 years of using SHA-1.

At this point it's worth noting that if the git project has a maxim, it
would be a single word: "performance". Nothing else matters.

So, if you suggest to switch from SHA-1 to SHA-256, that's fine; as long
as you can guarantee that *performance* is not affected. This is the
work brian m. carlson seems to have been doing.

On the other hand what dwh seemed to suggest is to support every digest
algorithm on the horizon--without regards of how that would affect
performance--and as expected that didn't land very smoothly.


But I don't think the two approaches are incompatible.

All we have to do is reconcile two facts:

  1. The ability for users to switch to a new digest is important
  2. We don't want users to be switching algorithms every other commit

If git can switch the digest algorithm on a per-repository basis, I
don't think anybody would have a problem with that.

Git could support SHA-1, SHA-256, and BLAKE2b as of today. The
repository owners can decide wich algorithm to choose today, and their
past history would not be affected.

This is future-proof, and would make repository owners be able to make
that decision, not git.

If at some point in the future people want to start to get ready for
SHA-4, that could be introduced to the git core, *before* people want to
make such transition, and *after* the project has made sure such change
does not impact on performance.

Or am I missing something?

Cheers.

-- 
Felipe Contreras
