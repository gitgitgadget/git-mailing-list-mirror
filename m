Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C437E202BB
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfDAQl6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44709 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfDAQl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so8797310edh.11
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SvSQp0akclPiYwcPT5KWsqKUwvBiXa0m2TZuepYkobw=;
        b=kL2ZIrJNQkf0s/idYACi1wTYaiMK7p2ji/3Wm9qhzNx8u35LGAYqJahAY4g9cr5NWy
         rKmOCjWzc6i5IwF38/lKbDmeaH7GjumFAkjLe7cEIOY6mwFIPq3AIyJhkFuuWc5+Gi+p
         4sGY7W8qkyNidnzx+dzPUziFe5k1Nz7uBkPiThQMDFwfn1bWTL/l09+Y1MJoKW0QcoUR
         SQIPYjbsgu5A7FQvQ4Ag0U27ZjXTqBasYiOV+a465T3xTMI779SmMj70Udjw9aLcSpcU
         pY+Pue5dpPIC5eI8Unkj4zRna5cijQGzqhJQ6hdgFDZABLZXfpoLM5tPUw6MRQp4qzzA
         keQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SvSQp0akclPiYwcPT5KWsqKUwvBiXa0m2TZuepYkobw=;
        b=bhF0hDndvCQZQGywYm8qBfVdGWjMqfQ24Lpfuhe94kUL0XBxnT9AxgcFrqZkdPJfSF
         u2TgnFo6Nn6nmrCqq/LR2PcuxpHF9C1eeR2sQcc9mm4iLH4GjucqdGfLzpAt8tKrhYIX
         3dnSSr3IGa188jIy3zGvjAXE8BgEat+n0I7DyifqZ5lGkBJqFbC2PFckm7t9QpTDQB8F
         T/l7JZrprR5lj9Uwp3Pi7TjCZIvNILEfeH+3RlcmHxWt5fsKhodK8vdyCiqhlCxjZBHV
         U+kktzfqNwc+X7a7uEC0SLFJcaZ/hrZ+X8ngUt9w+V1Lc0ecXgMYwZE+kQ4YJTfn0pKf
         5SXQ==
X-Gm-Message-State: APjAAAWcxEEVp6P4UC9t/Wkq0jfr/qNE3GCvzMMQwEvu3fLFE5BWchZ8
        zzlhdZ7cqvI7XmL55atg6DlzBkzWO8cGQOkJsR4=
X-Google-Smtp-Source: APXvYqwYl/DH49+BRVf9ngby6Rt+gEJE0kORAPSjF1VvMcRKqSrP62jnpbcnERxA7tqIyrSfYf++4Ag8CC1rp4qdfUw=
X-Received: by 2002:a17:906:641:: with SMTP id t1mr18279216ejb.158.1554136917029;
 Mon, 01 Apr 2019 09:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
 <20190312132959.11764-4-chriscool@tuxfamily.org> <xmqqpnqve71d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnqve71d.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 1 Apr 2019 18:41:44 +0200
Message-ID: <CAP8UFD1SK2mFBYJLqY9VE_Z5tQ5Mor2guc-X3yTbzfUZbHM_2Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] promisor-remote: implement promisor_remote_get_direct()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 5:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > +int promisor_remote_get_direct(const struct object_id *oids, int oid_nr)
> > +{
> > +     struct promisor_remote *o;
> > +
> > +     promisor_remote_init();
> > +
> > +     for (o = promisors; o; o = o->next) {
> > +             if (fetch_objects(o->remote_name, oids, oid_nr) < 0)
> > +                     continue;
> > +             return 0;
>
> Suppose the caller asks to fetch 3 objects, A, B and C, from two
> promisors.  The first promisor can give you A and B but cannot give
> you C.  The second promisor only can give you C.
>
> Does fetch_objects() return failure after attempting to fetch A, B
> and C from the first promisor?

Yes, I think it should still send the objects it has and then fail.

Maybe it doesn't work like this right now (I haven't checked), or
maybe the failure should be different than a regular failure. In those
cases I can maybe improve on that in a later iteration.

> Then we go on to the second promisor
> but do we ask all three?  That would mean the second promisor will
> also fail because it cannot give you A and B, and then the whole
> thing would fail.  It would be nicer if the mechanism would allow us
> to fetch what is still missing from later promisor, perhaps.

Yeah, I implemented fetching only what is still missing in v4.

> As the original "fetch" protocol only allows you to fetch a pack
> with everything you asked for in it, instead of feeding you a pack
> with best effort, I think the answer to the above is "it is very
> hard to improve over what we have here", but people may have
> interesting ideas ;-)

I think we should make it best effort when acting as a promisor
remote. I will take a look at that.

> > +     }
> > +
> > +     return -1;
> > +}
> > +
>
> Adding trailing blank line at the end?

Removed.
