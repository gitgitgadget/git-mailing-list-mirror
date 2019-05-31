Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8991F609
	for <e@80x24.org>; Fri, 31 May 2019 05:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEaFKk (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 01:10:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33654 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaFKk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 01:10:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so12663325edb.0
        for <git@vger.kernel.org>; Thu, 30 May 2019 22:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLxyJon7/EiB7Pw6XYoXzNV4gKrA7ugsFmaC6dbcICc=;
        b=OAx18/Jo6usrZuO0atYCz8mXmGZaSmFonFkPpALxA6d4Es/txOxUq/YZ1Qv5i9U0wE
         f1e6JdfwLc1mj5Njx0h353F9U8OjpKBgDF5cRKwgyuI+y4DB9y31N2O5xJs+gnJykkOF
         1BOn0fNUTLvnqAXmAqvxA0gdlI4Iuo1ky0WvMf8fNn48EF3FzspHCWz0KJJk8SvztlE5
         xoenGErGRt1lseegWSbD+iMFrdbl2hXLnIug+NozdRTC5PA9992mHTG6Lw3w8ULSyekv
         oo7a+7SI4wW3bdVlkJhsfCXF7f+F2olT9CB1vS1INJ4+BQ8al9mI1z8JRsHISQeEzLfK
         OieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLxyJon7/EiB7Pw6XYoXzNV4gKrA7ugsFmaC6dbcICc=;
        b=Lq774tiTkudmWoxdFdkCCk0LJPSWFy3N4m7s2mxKpeh26dQGqVOj04tUYrVcprWBSG
         0FORYM52TYrIvlyIIVdKtkRHtTszZoZRF+alaot102CUub9Q/lOMFw5bkvbM1SX+LHTb
         wVylpXuEJ0FqIux5bj6OF8yqmfTLdd1FEVAmRTAJZq6ETlquDp/zWxlFyNo/E1Zd/QOV
         7Xy7yKL/XmSknJFrVWW1roIgpgwUMAq8bDe7nLxueUewKCrlgLTA0Yfm2dl057duyc0d
         0YrQu3bXRQzxWyHhwdm+7tr4r4wBg+4sSdelTGzg4WGuQTfbgR4t6s8T6o3An8ldOc3i
         o8BQ==
X-Gm-Message-State: APjAAAXv9gr8tFIxO2T1m8t9DPPtFnr8SXzFVSwx1Q9PNLJ3w6BGf1GX
        lp9eIx/zF/Y3Is/07cYWgS8PVhqOM9t+p8i4Eko=
X-Google-Smtp-Source: APXvYqz04MWpX/I+DeMAwfeXKTDrJhABWSQ7B4MxZUfkdx/nNgLtbCXleCui4BmtwXD+xg2AQX+18B/bbcL0ZdojmF8=
X-Received: by 2002:a17:906:6c94:: with SMTP id s20mr6988435ejr.294.1559279438432;
 Thu, 30 May 2019 22:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
 <20190409161116.30256-5-chriscool@tuxfamily.org> <b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com>
In-Reply-To: <b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 May 2019 07:10:26 +0200
Message-ID: <CAP8UFD0zvqC2s3_RsWfKwoWQL=2iV6PbaL8+hwUXrWBVe+6sgA@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] promisor-remote: implement promisor_remote_get_direct()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, May 30, 2019 at 7:21 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 4/9/2019 12:11 PM, Christian Couder wrote:
> > From: Christian Couder <christian.couder@gmail.com>
> >
> > This is implemented for now by calling fetch_objects(). It fetches
> > from all the promisor remotes.
>
> Sorry for jumping on the thread late, but I noticed some peculiarities
> when looking at the test coverage report.

You are welcome. It needs review according to Junio, so it's
definitely a good thing that you take a look at it.

> > +static int remove_fetched_oids(struct object_id **oids, int oid_nr, int to_free)
>
> This method does not seem to be covered by the test suite at all.
> Is this scenario difficult to set up for a test?

I think so. If I remember correctly, I added this following a review
by Junio because it could be possible that a promisor/partial clone
remote only sends parts of the promisor objects it is asked. In this
case the objects that have been fetched should be removed from the
list of objects we try to fetch from the next promisor/partial clone
remote.

The issue is that now if a promisor/partial clone remote can send only
parts of the promisor objects it is asked, it should fail, as far as I
understand, which means that we will not actually get the objects it
should send. That's why I think it's not easy, or perhaps even not
possible, to test this.

> > +{
> > +     int i, missing_nr = 0;
> > +     int *missing = xcalloc(oid_nr, sizeof(*missing));
> > +     struct object_id *old_oids = *oids;
> > +     struct object_id *new_oids;
> > +     int old_fetch_if_missing = fetch_if_missing;
> > +
> > +     fetch_if_missing = 0;
>
> This global 'fetch_if_missing' swap seems very fragile. I'm guessing you are using
> it to prevent a loop when calling oid_object_info_extended() below. Can you instead
> pass a flag to the method that disables the fetch_if_missing behavior?

If such a flag existed when I wrote the function I would certainly
have used it, as I also dislike this kind of messing with a global
(and globals in general).

I will see if I can do something about it according to what you
suggest later in this thread.

> > +     for (i = 0; i < oid_nr; i++)
> > +             if (oid_object_info_extended(the_repository, &old_oids[i], NULL, 0)) {
>
> A use of "the_repository" this deep in new code is asking for a refactor later to remove it.
> Please try to pass a "struct repository *r" through your methods so we minimize references
> to the_repository (and the amount of work required to remove them later).

Ok, I will take a look at that.

> > +int promisor_remote_get_direct(const struct object_id *oids, int oid_nr)
> > +{
> > +     struct promisor_remote *r;
> > +     struct object_id *missing_oids = (struct object_id *)oids;
> > +     int missing_nr = oid_nr;
>
> Note that for this method, "missing_nr" actually means "number of oids still in the list".
>
> > +     int to_free = 0;
> > +     int res = -1;
> > +
> > +     promisor_remote_init();
> > +
> > +     for (r = promisors; r; r = r->next) {
> > +             if (fetch_objects(r->name, missing_oids, missing_nr) < 0) {
>
> This block hits if we have any missing objects. This is not currently hit by the test
> suite.
>
> > +                     if (missing_nr == 1)
> > +                             continue;
>
> But we skip the call below if there is exactly one object in the list, as it must be the one
> missing object. So, to be interesting we need to try fetching multiple objects.
>
> > +                     missing_nr = remove_fetched_oids(&missing_oids, missing_nr, to_free);
>
> Here is the one call, and after this assignment "missing_nr" does mean the number of missing objects.
> However, I do think this could be clarified by using remaining_nr and remaining_oids.

Ok, I will take a look at using "remaining_nr" and "remaining_oids".

> > +                     if (missing_nr) {
> > +                             to_free = 1;
> > +                             continue;
> > +                     }
>
> Now this block took a bit to grok. You use to_free in the if(to_free) free(missing_oids); below.
> But it also changes the behavior of remove_fetched_oids(). This means that the first time
> remove_fetched_oids() will preserve the list (because it is the input list) but all later
> calls will free the newly-created intermediate list. This checks out.
>
> What is confusing to me: is there any reason that missing_nr would be zero in this situation?

I don't think so but I will check again, and maybe add a comment.

> I guess if the fetch_objects() failed to find some objects, but we ended up having them locally
> in a new call to oid_object_info_extended(). That's a fringe case that is worth guarding against
> but I wouldn't worry about testing.
>
> > +             }
> > +             res = 0;
> > +             break;
> > +     }
> > +
> > +     if (to_free)
> > +             free(missing_oids);
> > +
> > +     return res;
> > +}
>
> While the test coverage report brought this patch to my attention, it does seem correct.
> I still think a test exposing this method would be good, especially one that requires
> a fetch_objects() call to multiple remotes to really exercise the details of remove_fetched_oids().

Yeah, I would like to actually test it. I will take another look at
what can be done to test this. Perhaps I will look at what can be done
to still get some objects when fetching from a promisor/partial clone
remote even when it doesn't have all of the objects we request.

Thanks for the review,
Christian.
