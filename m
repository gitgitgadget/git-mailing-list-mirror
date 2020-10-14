Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DCCC43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 02:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBAF20691
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 02:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EE5rqWt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgJOCYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 22:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgJOCYh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 22:24:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287ECC05BD2C
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:47:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so686037pfp.13
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t69Ik00Kgb1Jmr+T0H6h8BzasHT2ldzzDcyThie851c=;
        b=EE5rqWt/rKKTkSLrfkhFCWNJdtsjIUZql58OEe6+XtlK05uvValgyK+Xn/I2GxoOKX
         v0WC9tQfLC7KyvUNDdhnqHKVRiYBSQBsUWigH4PTTy+la5WYqO4aZQ43E79oJpln5hhf
         O3sY+5QKnY3JDTDwGQFO5xyUkntIdpEzJydeQSIWAsB4F9dO2nS3Q08a/U/2fuQfxvlR
         Kz3FWLw4ylrfj+iaV2yVHCHACx3Moa2MQmQcvycPH55/jVkKXhXpWz5Ebp9RBudXqbwB
         gJWKlZpwwnSnIw8C86JRiOVa+cAOEO1KOpZNsiLhq6J9M+seY+XeTePjft7P80jFV/dq
         aGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t69Ik00Kgb1Jmr+T0H6h8BzasHT2ldzzDcyThie851c=;
        b=KcWsU81tSEHdnlr7qU6fEglNa1L6Cim+/qKxsWZYHh/FUT/TddRPgwkhGP6y5rm3W5
         kPeJSIxvnqoxKt/7MKvB6KM7vYUbIfHODppv51YWV0wnIlFBG2tD0cBtMybp7InJalNA
         gsAzDlqcQ+bgVWkRyEaItL6Uvqa1YheBL9hru11EehWbRhz5DrCcDcwzAyPzQPmhC3Gl
         XdeCjX5wBVB16Nb6Wrcl5tVbBW0cHzBNgzH4+4Xv+VxrAjlxCVshlYQNxrEiqRfRjqhD
         RjQX2MWOXAUjGRgBCSujxwWl+bXGjXxkM5nqavi75tKNvtds/07hagPrCdKq5A3GrT2w
         EWDQ==
X-Gm-Message-State: AOAM532Xf1z7mN1ZU3xofpzIib7hEzElECFHkVlED+Dyu/qTVVcC/rEw
        dE4XWcfOz5GQn4YdXBfV7l7oHcVvru5SJ1CjfSv0FQ==
X-Google-Smtp-Source: ABdhPJzKKC25AKgO09CwvqHyaXMyOP/tJC00w1yrmrZcuCyTXYdLaHuF5dB7H9CGa4WFKQ1DRBNesALUsVA6ifb/2Z4=
X-Received: by 2002:a63:dc4f:: with SMTP id f15mr910736pgj.332.1602715633740;
 Wed, 14 Oct 2020 15:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <20201013191729.2524700-3-smcallis@google.com>
 <20201014195544.GA365911@coredump.intra.peff.net>
In-Reply-To: <20201014195544.GA365911@coredump.intra.peff.net>
From:   Sean McAllister <smcallis@google.com>
Date:   Wed, 14 Oct 2020 16:46:57 -0600
Message-ID: <CAM4o00eefXK2CJ_FxwwVPpBKL01JsJANf+SdjCtw_0NVV82L+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 1:55 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 01:17:29PM -0600, Sean McAllister wrote:
>
> > +/*
> > + * check for a retry-after header in the given headers string, if found, then
> > + * honor it, otherwise do an exponential backoff up to the max on the current
> > + * delay
> > +*/
> > +static int http_retry_after(const struct strbuf headers, int cur_delay_sec)
> > +{
> > +     int delay_sec;
> > +     char *end;
> > +     char* value = http_header_value(headers, "retry-after");
> > +
> > +     if (value) {
> > +             delay_sec = strtol(value, &end, 0);
> > +             free(value);
> > +             if (*value && *end == '\0' && delay_sec >= 0) {
>
> This looks at the contents of the just-freed "value" memory block.
>
Sure does, fixed in v3, disappointed that electric fence didn't catch
this for me...

> > +                     if (delay_sec > http_max_delay_sec) {
> > +                             die(Q_("server requested retry after %d second,"
> > +                                        " which is longer than max allowed\n",
> > +                                        "server requested retry after %d seconds,"
> > +                                        " which is longer than max allowed\n", delay_sec),
> > +                                     delay_sec);
> > +                     }
> > +                     return delay_sec;
>
> I guess there's no point in being gentle here. We could shrink the retry
> time to our maximum allowed, but the server just told us not to bother.
> But would this die() mask the actual http error we encountered, which is
> surely the more interesting thing for the user?
>
> I wonder if it needs to be returning a "do not bother retrying" value,
> which presumably would cause the caller to propagate the real failure in
> the usual way.
>
I've moved this check up a couple levels in v3, so that if we get too large
a retry value, then we'll print this message as a warning and quit retrying,
which will unmask the underlying HTTP error.

> >  static int http_request(const char *url,
> >                       void *result, int target,
> >                       const struct http_get_options *options)
> >  {
> >       struct active_request_slot *slot;
> >       struct slot_results results;
> > -     struct curl_slist *headers = http_copy_default_headers();
> > +     struct curl_slist *headers;
> >       struct strbuf buf = STRBUF_INIT;
> > +     struct strbuf result_headers = STRBUF_INIT;
>
> This new result_headers strbuf is filled in for every request, but I
> don't think us ever releasing it (whether we retry or not). So I think
> it's leaking for each request.
>
> It sounds like you're going to rework this to put the retry loop outside
> of http_request(), so it may naturally get fixed there. But I thought it
> worth mentioning.
>
Yes good catch, the new http_request_try version fixes it as a matter of course.

> > +     curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, &result_headers);
> > +     curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_buffer);
>
> After looking at your parsing code, I wondered if there was a way to
> just get a single header out of curl. But according to the documentation
> for CURLOPT_HEADERFUNCTION, it will pass back individual lines anyway.
> Perhaps it would be simpler to have the callback function understand
> that we only care about getting "Retry-After".
>
> The documentation says it doesn't support header folding, but that's
> probably OK for our purposes. It's deprecated, and your custom parsing
> doesn't handle it either. :) And most importantly, we won't misbehave
> terribly if we see it in the wild (we'll just ignore that header).
>
I'll put this in my todo pile to think on a little, it'd be nice not
to have expand
the strbuf with every request, but also not a huge overhead.

> -Peff
