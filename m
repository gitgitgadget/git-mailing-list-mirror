Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A998C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A332063A
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9YUSQ2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgHQReF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389010AbgHQQuC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:50:02 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB955C061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 09:50:01 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a1so8609051vsp.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnKQsAu+utbtQw57rkDtPYqXFsJfizw35CWEBc3MfjY=;
        b=d9YUSQ2lAyQR7wOSkbbO9eCmtOplIs6vhDpVt9AbRCMg4l0OfCbxPucs+x7M0RG0RE
         tMJ5PmTLh3pPPDo536pNrpQg0Byc6YOj119HquxfKC6ayc05JS2myNce7WVwz/4r/jpk
         UszHySjCMD2G0oVzNsoJ0CcJLzSjDOwPqVEnvWZ9RdX89gvSX0PxImABB4a827RvyLWp
         btN0BIfpR7eTsyGXNbQ0CuKYn81qJLkfCe6klAgQdoAmu1dG2Aw45V+vXMhKiA5Bxa2P
         bV1CDMQ0US1ujl5wOfmivEdlyxAi04HPjeh0VZCjtk7DJOTPpUKKpECjvEgEReYs9i48
         de7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnKQsAu+utbtQw57rkDtPYqXFsJfizw35CWEBc3MfjY=;
        b=lKALpcz9iUx1L9Jl6JN/CWBKVIZ1dSuYdcYld0Akcs0prVa4On2CgTlAhPxnhtf+hA
         5MpT011fh9FkGYWYMf4NgntNZCHgnyllIws5j8mKfKsZOXqJA+e8cNJQ3jdqONBTGKaH
         gWHffs8RVPjdIflRlhPPDZ2UeTa7O6xZqrGubzoqsimLV0xWd0AGipXieVauDlye4ZDG
         CyUtWrALFQmCQwYnN+vs5SkvgI/r1doKCGQRgxlZj/6HPoGQ9L7mZMedznGcTGlj2U55
         a1wl68fj2ClO9XdkHtDuWwlIk2V3nHBg9URiiPBwj4LZ4QFogJYoqnAC+uOI5i9am4KV
         Xm9w==
X-Gm-Message-State: AOAM531/WvxFEds15YQ76BXgCvaiDYgu9s3+axWxvuSqVOPl5D83hgIN
        J6k+9ppj23nsNBrAJ9ywX35h4hE9qUnZJiygv10=
X-Google-Smtp-Source: ABdhPJyi+l7+rIJhUWM6yI1ty3Ik/K+7ZJJdAZlTGv2YyJr8N8XttWXXCm/arVLeDObaEn9YwNC6+PNfn9CSD+cZPmU=
X-Received: by 2002:a67:8750:: with SMTP id j77mr8887596vsd.5.1597683000723;
 Mon, 17 Aug 2020 09:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
 <20200815002509.2467645-2-jacob.e.keller@intel.com> <xmqqd03p44gr.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd03p44gr.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 17 Aug 2020 09:49:49 -0700
Message-ID: <CA+P7+xoC8SOn+fOtzL1GqN0P+eB67-L19yUwYo6UNrYoYGh8Lw@mail.gmail.com>
Subject: Re: [RFC 2/3] refspec: make sure stack refspec_item variables are zeroed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 9:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > A couple of functions that used struct refspec_item did not zero out the
> > structure memory. This can result in unexpected behavior, especially if
> > additional parameters are ever added to refspec_item in the future. Use
> > memset to ensure that unset structure members are zero.
> >
> > It may make sense to convert most of these uses of struct refspec_item
> > to use either struct initializers or refspec_item_init_or_die. However,
> > other similar code uses memset. Converting all of these uses has been
> > left as a future exercise.
> >
> > Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> > ---
> >  builtin/remote.c | 1 +
> >  transport.c      | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index c8240e9fcd58..542f56e3878b 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -478,6 +478,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
> >       struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
> >       struct refspec_item refspec;
> >
> > +     memset(&refspec, 0, sizeof(refspec));
> >       refspec.force = 0;
> >       refspec.pattern = 1;
> >       refspec.src = refspec.dst = "refs/heads/*";
>
> The original leaves .matching and .exact_sha1 bitfields
> uninitialized.  As .pattern is set to true, .exact_sha1
> that is not initialized does not make get_fetch_map()
> misbehave, and .matching is not used there, so the code
> currently happens to be OK, but futureproofing is always
> good.
>

Right. Today the unused fields happen to never get checked. But by
being uninitialized we risk unexpected behavior in case either new
fields are added or in case those fields start being checked by the
code using the structure.

> > diff --git a/transport.c b/transport.c
> > index 2d4fd851dc0f..419be0b6ea4b 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -443,6 +443,7 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
> >       if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
> >               return;
> >
> > +     memset(&rs, 0, sizeof(rs));
> >       rs.src = ref->name;
> >       rs.dst = NULL;
>
> The original here passes the rs to remote_find_tracking() with only
> its .src and .dst filled.  The function is to find, given a concrete
> ref, where the refspec tells it to go on the other end of the
> connection, so the code currently happend to be OK without all other
> fields, but again, futureproofing is good.
