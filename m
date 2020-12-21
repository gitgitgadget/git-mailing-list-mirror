Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BADFC4332B
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C59222D08
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgLUS10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUS1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:27:25 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D82C0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:26:45 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s75so12213818oih.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D45UGHXroyjCDdCCCUfqHMLSUEMXod73Q7gQYOOZceg=;
        b=S1S14aZiSdStML5fEwTtLhAMxRmyzaUG5c9y1EzmhFvUJcRqlO2o7QI4qzbvxG6c1k
         UjesLU4JIfGVUw3V0LsMLT6u+yfvQHvyRiXeMBvQtfUgAF0uRaYVwSY8E1TZmmDywh9w
         updOOkjFUrqYLn0H4lMcOYQejSayzXqf1tNDTIw2rQzhXb64DeDjHO+G1C+7Rq1BmMgT
         Hcb0LrXJPr5nnczk7Vi28TTwC5DxGJnq7a2Cejg5qIKKkKC/VUVKwDz2yOcW5E+8em54
         13kxclohvPyYO0RZfUMN2G79+kt72wEu+NE3uIDqCOJZhaWAPjN5tV2+yubE0cpJeY9c
         0Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D45UGHXroyjCDdCCCUfqHMLSUEMXod73Q7gQYOOZceg=;
        b=oY6FaSFfXXcE4YrTPfRSmclJC81vGZimMYOzvTWlqt2/ApxUKpsroQbbwlGkdQBRre
         QWPHHRvMJCJn1JEfy8zfNHorgtCvwC5hj5jHcWw7QOzTVaF/3XWpgpX9ltLSDVEHXXXk
         xBFD3VOV5wHptMdLw/EvfIBEhaYk2iQdHFyW8wLE7wWu/1hoxf1X9Xy8DljzbbtY9P+b
         73fMPV0YysYa8+YlakIl6fypE1GK1uLmhL2mKQnZ5ul2XfbbX96271jA1P29vjrl7u15
         Q05W6U5geTtBrWF/5ZZSzZxwC6UusmyrZi5wtrB/DgVCm+OpKCv4Tx6M8Xq2X4eWYFMq
         cX/A==
X-Gm-Message-State: AOAM531StP1RYRq7UFu53y9lLLsFBYCqJ/jBQTOAyF7822eTA9LRjv+z
        BBYrf9B2S1x9Qm93m4LCs1DPnENLqVBQ5DcyO06T+sgDZJ2ISw==
X-Google-Smtp-Source: ABdhPJz+rnPh99DPmPWe9o5tXwh5s19B6LADYs3VeCSdIsz9xerOIi5FUmpLjlbq8n2xMUzT7rSNk+kac7BrpHkTYqs=
X-Received: by 2002:a54:4185:: with SMTP id 5mr1174672oiy.31.1608571526355;
 Mon, 21 Dec 2020 09:25:26 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com> <CABPp-BFoSz40-1mNLrxCgMTccYqLOg6ifX5PeLDutbimF9ysPQ@mail.gmail.com>
 <xmqqblepnd9k.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblepnd9k.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Dec 2020 09:25:15 -0800
Message-ID: <CABPp-BErnY+zfmp-LWTe0EUB5QKKcLCP=4t9VxwvA_+DaBvDuw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2020, #03; Fri, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 19, 2020 at 11:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > What do you mean when you say these two topics are tangled?
>
> When two topics are "one builds on top of the whole of the other",
> my tool labels "uses" vs "is used by".  All other cases where two
> topics share a commit are labeled as "tangled", as I couldn't come
> up with any better phrase.

I'm still confused.  en/merge-ort-3 and en/merge-ort-recursive do not
share any commits.  The only tie is that each "uses en/merge-ort-2",
as you noted, but that was already noted separately.  Am I missing
something?
