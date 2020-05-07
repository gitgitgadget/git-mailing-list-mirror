Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6793BC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4179A2064A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrhgNuO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgEGMcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 08:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgEGMcw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 08:32:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105BC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 05:32:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w2so5207766edx.4
        for <git@vger.kernel.org>; Thu, 07 May 2020 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFzfn5s3vRZ20ykPbPJ8LIlCYVF33P0mjXPV4MbJzxk=;
        b=PrhgNuO1VplJwVezcVJ3Uu6HpvJYbBBFryTcX5LED8k5lOAKY1CvHQlm3j6lVmm90b
         EO74tejOWNC/FjiUw64qwbgfq33m10Mx7rzeepGhwmGV3K6SkX6jkrVindC8Q/MsjtN+
         NrSDBfVnZ4RQ2oDB2ndrTMKXX22L4i1FKtGiDvdTqBLP2apDiRQ+dsM4RjajjM8REZh0
         DZPVXatibGfbMX8t9UAQXI/8SwqGbQU5I+H1kxJCwqevYJUrmVMyiuln/7ou8TmSo4tj
         NUsqfMw+uFxel3UTUMH9COIyIYD2yWfa49UNUOmbBjgqwkhMlkT2/fHxdsBxjSv2IKDE
         1iTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFzfn5s3vRZ20ykPbPJ8LIlCYVF33P0mjXPV4MbJzxk=;
        b=nz5JPrmolqv2N4eqh5QdXwQDhn+5S2QvdDXzwCu9oVV3Kr3nuhyHkmO8KPdvwcj8bl
         5guVI4DxADxKz+xJps8iqe8k/3eDrRvKlc1XDa2Y+qsNmyqnNy6u5S/nVm4DGa0JqtuL
         BLJFriSz5kqSEOUXByoPndgWigENpn9jlWDapYWt5JXcZFlamurjs7X3Npe+YL/T2w9Z
         Dt3GghAm5M5GUKi0n0Hxjk40oyG7Oi9Wd8X/ZccE9UZVVfhCCzMhF8gx0pu7GRKoZht5
         /yD6lJ7FHzSWxEhddDdeIACV4yo+5gD4o8PLYW2tAZcDUcOtSx++WpJ/0GqHNQLo19jg
         L5Zw==
X-Gm-Message-State: AGi0PuZ5tqzE8oq8ynTBQPVYHgNfviKCXWiGl4BOeJ1+yI6dfoCzLpOM
        z5sbg14bMo9WAJ0qUPhwLY63HdMQ8+rQXSg+IcI=
X-Google-Smtp-Source: APiQypIZN/eE9ygR5mc+TVFlcnP7T+RF64+IfFC9qeXvObpCRIRHGZEwSf8ILLzn1QnyJsH22P2Ykk5gnMQb8iujzVc=
X-Received: by 2002:a05:6402:44f:: with SMTP id p15mr1437269edw.87.1588854770291;
 Thu, 07 May 2020 05:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200507095829.16894-1-chriscool@tuxfamily.org> <20200507113624.GA3027470@coredump.intra.peff.net>
In-Reply-To: <20200507113624.GA3027470@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 May 2020 14:32:39 +0200
Message-ID: <CAP8UFD3AqUGrE2W3Qg_+z6HnobmRpOEyNEdspmDPGggKUqyK+w@mail.gmail.com>
Subject: Re: [RFC PATCH] upload-pack: fix filter options scope
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 1:36 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, May 07, 2020 at 11:58:29AM +0200, Christian Couder wrote:
>
> > I am not sure why upload_pack_v2() is called twice. Also it seems
> > that another similar issue might not be fixed by this. So this patch
> > is RFC for now.
>
> It's because of the request/response model of v2. The client side of the
> conversation looks something like:
>
>   - client connects transport to server
>
>   - client issues command=ls-refs to get the ref advertisement
>
>   - client issues command=fetch and sends wants/have; the server may
>     respond with a pack when the negotiation is finished, but may also
>     respond with acks, etc, asking for more rounds of negotiation
>
>   - if there's no pack, the client then issues another command=fetch,
>     repeating until we get a pack
>
> In stateless git-over-http, each of those request/response pairs happens in
> its own server-side process, because the webserver kicks off a separate
> CGI for each request. But v2 adapts git://, ssh://, and direct-pipe
> connections to use the same request/response model, but all connected to
> a single Git process on the other side.
>
> So each upload_pack_v2() call needs to start with a clean slate; it
> can't assume anything about previous rounds, and it needs to clean up
> any allocated data from those rounds.
>
> So your patch is going in the right direction, but we already have other
> similar data handled by upload_pack_data, which has its own init/clear
> functions. Probably the filter data should go in there, too.

Thank you for the detailed explanations!

It looks like 'struct upload_pack_data' is indeed used by
upload_pack_v2(). It's not used by upload_pack() though. So if I move
'struct list_objects_filter_options filter_options' there, I would
need to also make upload_pack() either have its own filter_options or
use 'struct upload_pack_data' too.

> This is an easy bug to introduce, and I suspect we'll see equivalent
> ones in the future (if there aren't already more lurking; there's a lot
> of global data in Git, and I really have no idea what subtle
> interactions one could see). One thing we could do is to truly run each
> v2 command request in its own process, just like git-over-http does. But
> there are a lot of complications there around holding the pipe/socket
> open, how the parent v2 serving process interacts with the child
> requests (e.g., noticing errors), etc. So I'd worry that going that
> direction would be just as likely to introduce bugs as fix them.

I agree that it seems better to just get rid of the global data used
by the upload pack functions.

> > diff --git a/upload-pack.c b/upload-pack.c
> > index 902d0ad5e1..4e22e46294 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -68,7 +68,6 @@ static const char *pack_objects_hook;
> >  static int filter_capability_requested;
> >  static int allow_filter;
> >  static int allow_ref_in_want;
> > -static struct list_objects_filter_options filter_options;
>
> Just looking at nearby bits of global data that might want similar
> treatment:
>
>  - allow_filter and allow_ref_in_want are set by the server-side config.
>    So they're persisted between upload_pack_v2() calls, but we'd
>    overwrite them by calling git_config() in each incarnation
>
>  - filter_capability_requested is set based on client input, but it's
>    only used in v1
>
> But boy there are a lot of global variables there to trace through.

Yeah, unfortunately.

> Probably a more fruitful way to find similar problems is to look at the
> v2 process_args() to see what it touches. It looks like options like
> ofs_delta probably ought to be part of upload_pack_data, too. We didn't
> notice because it would require a client doing something like:
>
>   command=fetch
>   ofs-delta    [claims to support ofs-delta]
>   0001
>   [wants and haves that don't result in a pack yet...]
>   0000
>   command=fetch
>   [do not claim to support ofs-delta!]
>   0001
>   [wants and haves that result in a pack]
>   0000
>
> The server _shouldn't_ use ofs-delta there (and wouldn't over http,
> where the stateless server side that generates the pack knows only about
> that second request). But in git-over-ssh, it would.
>
> A client who does this is stupid and wrong (and I didn't check the
> protocol spec, but it could very well be violating the spec). So I don't
> think it's _that_ big a deal. But it would be nice if all of those
> globals got moved into upload_pack_data, and both v1 and v2 just used it
> consistently.

Unfortunately as I discuss a bit above 'struct upload_pack_data' is
not used by v1, only by v2. I think making v1 use upload_pack_data
might be nice, but it's a separate issue. So I am tempted to just
improve the commit message, adding some information from you and from
this discussion, and then re-sending.

Another intermediate solution would be to add filter_options to
'struct upload_pack_data' for v2 and to use filter_options directly
for v1.
