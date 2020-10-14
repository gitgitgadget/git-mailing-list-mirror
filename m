Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C13CC433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374582173E
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+Tf5YCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgJNRL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbgJNRL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:11:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C1DC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:11:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t18so53872plo.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBiF+Xsspr5jN9+hEBXSuVcBGeApW8RRvzaTUm8dhwU=;
        b=r+Tf5YCjY5bCAsOvhq42ye8mcf+hooOwAMV+VMJ/sc7PMe25OdjC4zgLc1/uWG8ntP
         KWN8GowBeUKvbstnottZIlhaEtoMPSQFYZWhLZUEWk6eKU3GPfR0iho7bSIdV4ZF3r/U
         w95NAj6CWPPVhnJCKxp5bPXe+8LK5DD+dB2h8HB5jw59e++Z98venEwCD5ZjUqZrSOjA
         arBQ6QXNUxTDYtfRv/6h1SC06RK5MYzk3OP/LmlDWykrBN4JY2GXiixIQwe2rTh5x7Lq
         9QKH6RT/pYjj29HOXpFvE+Nm677mie6gYV9BC46IvZJ1TnwWsmAxBi0vdGzJ1I8zEvwA
         PKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBiF+Xsspr5jN9+hEBXSuVcBGeApW8RRvzaTUm8dhwU=;
        b=Vz1lEC7T+wG5YjhPMJX4Ezyo7xGmsHo1bPIEUgMZqJTcM6F6KwhH61uzr94WWTVuDJ
         nO9ALk1UM/XneI7w+XczLpSvXNaFABag/+OMv9HcblhEZN6Wlpxycvq9qxJPYGFG1bEq
         zJfJKbSEsGGx9W9HzH17fDzVt7ZxWXeJxtDdKMod8lG7vmpQw9Z8G2xg/8EELr1gj7Jk
         CYRT+BZEsxfurGmHqq1CzkFXxTbjZBdsqrYsSas4tAO7cZymLLZ6Q8Ze8QrCmaAqX58S
         eUQA1+EwM3UxHon5XKga1v6FwAoo0RdklrGtRIjupGt4r9TzGqEMmTSyZVeI2C9HKm2k
         +f9w==
X-Gm-Message-State: AOAM53125F4aZLS+6OyG7AXpPry5A5eVTJp6yiXRZepK5HKccjrZWvJD
        abTNYhTB2UkdX6Afw9tqbYL4HPBbQLC1IMFUKuGOsw==
X-Google-Smtp-Source: ABdhPJwpir/NTI+8WeVLqFBAsIRs0XjlkjMtfjfgYpu7NUhS1khgJMnN9WoBHoyVP3g5ITIBfPT8CnsJ9rBZ3SZH4Jo=
X-Received: by 2002:a17:90a:430a:: with SMTP id q10mr201326pjg.45.1602695485473;
 Wed, 14 Oct 2020 10:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <20201013191729.2524700-2-smcallis@google.com>
 <xmqq7drtkg6o.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7drtkg6o.fsf@gitster.c.googlers.com>
From:   Sean McAllister <smcallis@google.com>
Date:   Wed, 14 Oct 2020 11:11:08 -0600
Message-ID: <CAM4o00eZkkqwB=8+YCA_p1oY-V7F4EhdsqqqtToXjADXo2aZ_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] replace CURLOPT_FILE With CURLOPT_WRITEDATA
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Masaya Suzuki <masayasuzuki@google.com>, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> Sean McAllister <smcallis@google.com> writes:
>
> > CURLOPT_FILE has been deprecated since 2003.
>
> I thought that Dscho already mention this, but updating the above
> description to mention that _WRITEDATA was introduce to overtake
> _FILE as an equivalent in the same timeframe would be more helpful
> to readers.
>
>
I've updated the commit message in v3 to explain more about the
history and details here.

> > Signed-off-by: Sean McAllister <smcallis@google.com>
> > ---
> >  http-push.c   | 6 +++---
> >  http-walker.c | 2 +-
> >  http.c        | 6 +++---
> >  remote-curl.c | 4 ++--
> >  4 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/http-push.c b/http-push.c
> > index 6a4a43e07f..2e6fee3305 100644
> > --- a/http-push.c
> > +++ b/http-push.c
> > @@ -894,7 +894,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
> >       slot->results = &results;
> >       curl_setup_http(slot->curl, url, DAV_LOCK, &out_buffer, fwrite_buffer);
> >       curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
> > -     curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
> > +     curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
> >   ...
