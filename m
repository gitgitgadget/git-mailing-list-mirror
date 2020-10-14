Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BD8C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9244C20691
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvC0QRWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgJNTJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730423AbgJNTJS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 15:09:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41A6C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:09:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gm14so272627pjb.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cyqbpwb4rRhFgyz9qJpoJpSeWtkSaXUHJXdpa87L8+4=;
        b=nvC0QRWXFIuqrAo2aaQV6a4oVDS1I/pzJ+IcPQux6BFTxByaULQTqj+CQ6ygllC5zY
         S7OX8JkH1BtomqSYwEZHy6EpctBBLyNKN54HDv+ky71FXa9W/MISMVs7rzCbH3b5ApDw
         7NDDT+MGHgPxlZPcGwubPHY/whNghkvugJb8YdtMVy8ebGDrH2AgHp6qiVbQKm/Zgc4n
         Wy5TixPFmUBK+cwuoEWXKYWLlk3k94c1iRM5ts86iwEkzoWEyywqrgZLBn4/fp61amR6
         WFUsufvEkBdf/482So451HcDSnN75MRS40vk7y60eEZsP/lDJfuSv9iswbyQAozLd78d
         OliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cyqbpwb4rRhFgyz9qJpoJpSeWtkSaXUHJXdpa87L8+4=;
        b=BHpGTxfwRpjR/wsuCjh71WvKdp6pHbbhXbINL5F/EhJvxdm9nmaJZkTtb9E43Io8Hp
         QpDQs054/PPLLLiSPO55FUxEY+Sdw8jmX4OerMeS0mzwEbjrc/lmXybIV5xtEb6dCnxL
         aMGtVPobt6GbZjpfrSgzDRYioJuQPxalyowDwQ194rLRrwoyQjbs0bN6NcsIPBNBqT8s
         +0tbF0aq2wHjxIsbNBgNIXYS+4kKAFaalAJvuxQjp1OdJWpZ1/R7a5WhCDXK6qiboM7w
         A7vnRi5/Af+Mg5DDztgJ3zVqcaUSyn8njnA8hBX1msE/1w0/s4G/OyAi2XKNvddc+hJs
         ZRqg==
X-Gm-Message-State: AOAM531HcNHfvGyY9XYXUzBhPp2oCGd6S4/LMKJpEmHs2s1rWE8Bfhfy
        s7ALATjX+Cz3ld6Te5juEx1bfuwtagi1HunVFUinyQjGt/r6KA==
X-Google-Smtp-Source: ABdhPJyr71sldRUNmuFu2R96e9+oAGEHGFT+sB1jASClanXAHPTXw/KD+cPMjbLeKk+4sqqBJaOGXBBTq8vS2I2rGlo=
X-Received: by 2002:a17:902:ee52:b029:d5:b156:3ff8 with SMTP id
 18-20020a170902ee52b02900d5b1563ff8mr374498plo.85.1602702557808; Wed, 14 Oct
 2020 12:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <20201013191729.2524700-3-smcallis@google.com>
 <20201013211453.GB3678071@coredump.intra.peff.net>
In-Reply-To: <20201013211453.GB3678071@coredump.intra.peff.net>
From:   Sean McAllister <smcallis@google.com>
Date:   Wed, 14 Oct 2020 13:09:00 -0600
Message-ID: <CAM4o00eCKP1+f=xBw4LJfNqrstEnutAe9StxknW9qLMtPBdhKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 3:14 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 01:17:29PM -0600, Sean McAllister wrote:
>
> > Exiting immediately becomes irksome when pulling large multi-repo code
> > bases such as Android or Chromium, as often the entire fetch operation
> > has to be restarted from the beginning due to an error in one repo. If
> > we can reduce how often that occurs, then it's a big win.
>
> I had hoped that libcurl might have some retry mechanisms, since the
> curl command-line tool has several --retry-* options. But it looks like
> that is all only at the tool level, and the library code doesn't know
> anything about it. So we are stuck driving the process ourselves.
>
> I do think you could be leveraging CURLINFO_RETRY_AFTER rather than
> implementing your own header parsing, though.
>
Ah I didn't know about CURLINFO_RETRY_AFTER, I'll look at that and use
it if I can.

> >  static int http_request(const char *url,
> >                       void *result, int target,
> >                       const struct http_get_options *options)
> >  {
>
> It looks like you trigger retries only from this function. But this
> doesn't cover all http requests that Git makes. That might be sufficient
> for your purposes (I think it would catch all of the initial contact),
> but it might not (it probably doesn't cover subsequent POSTs for fetch
> negotiation nor pack push; likewise I'm not sure if it covers much of
> anything after v2 stateless-connect is established).
>
You're right that I only trigger from this function.  I've since removed them
in response to feedback on having too many tests, but I originally tested this
with:
  t5539-fetch-http-shallow.sh
  t5540-http-push-webdav.sh
  t5541-http-push-smart.sh
  t5550-http-fetch-dumb.sh
  t5551-http-fetch-smart.sh
  t5601-clone.sh

I'd have to look at the packet logs to see exactly what each of those
protocols is doing, but it seemed to cover _most_ of what they were doing.

Definitely open to adding retries in other places though.

> >       struct active_request_slot *slot;
> >       struct slot_results results;
> > -     struct curl_slist *headers = http_copy_default_headers();
> > +     struct curl_slist *headers;
>
> So here we stop copying the headers at the top of the function...
>
> > [...]
> > +retry:
> > [...]
> > +     headers = http_copy_default_headers();
> >       if (accept_language)
> >               headers = curl_slist_append(headers, accept_language);
>
> And instead set them up totally here. Which make some sense, because we
> wouldn't want to append accept_language over and over. But who frees the
> old ones? There is a call to curl_slist_free_all(headers) later in the
> function, but it's after your "goto retry". So I think each retry would
> leak another copy of the list.
>
> The ideal thing would probably be to create the header list once, and
> then use it for each retry. That would require reordering some of the
> setup. If that's too much, then it would be OK to just create a new list
> from scratch on each call. Though in the latter case I suspect it may be
> simpler to wrap the whole function, like:
>
>   static int http_request(...)
>   {
>         int try;
>         int result;
>         for (try = 0; try < max_retries; i++) {
>                 result = http_request_try(...);
>                 if (...result is not retryable...)
>                         break;
>         }
>         return result;
>   }
>
> and then we'd know that the single-try function just needs to be
> self-contained, without worrying about gotos jumping around in it.
>
> -Peff
I like this idea, I've refactored it to do just this.
