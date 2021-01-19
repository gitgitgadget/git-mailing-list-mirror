Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EC0C433E6
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14DC23104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbhASXxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbhASXxP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:53:15 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD15C061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:52:35 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 143so23721556qke.10
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gZ6DnzGonhalwfvYP2AQyhqvlIdggMFN0tz/PWHN2Fo=;
        b=r314TPt+WNT5NphV7l4Hy3rx3Gnebrq9f1s890p/WqJSAd+UrYWI7X78RoLAfeSOoC
         tyB2JrnoP8iiSzYS8f2jqTbJ3LeGn0Xw/GWfiJqlzK2bImrSWpoS1HsfnSnGqykUBjZc
         mK5fCia+M1YifjatnOFYjwBizD087FybyQeNPv9my5fBk9645D0cojDLfmsGW+BgSMa7
         G3UdPw+Ur3eD6C006xyxmCn1qzGXKo0TJOUIhAIIE4cxHb12iVjiwBSsZih3snimuycH
         m9QVonD0S0ZRUoEEo/1eb1A0QA4w7mkZuSZuhbMsrk9bD1gXPXmZIlt0kye6F3WlFoH2
         qXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gZ6DnzGonhalwfvYP2AQyhqvlIdggMFN0tz/PWHN2Fo=;
        b=pS2xCdIW4zPTwc3/GVD1NtpAt7fzSZcMT4HnPiAQOz53PTyRgZUIgIit72C5SvthwF
         2txN3ULkk5bJIOhwXmq56JL/yJ8W3c68WqD0B/cBweuOU0MWM8oyYs84xfRNLEyc5qZM
         bw4jnPmUMqTgWS6d5G+0uV8+9Jw0O35YT5J1Kix7lAk2G/fOa3aK6yRqAq1uOVgTbmuB
         6BFGNbPT70TgBWbvMYzYvhkEdXMXj5g32UD0uchqqGkzYRrE89nW5w9ogjmTXPPxjEB8
         84RXcjwAPfqP9LF0fgcG6SOUmAHtTGBIJpuI76JmGsXqs4wpV/2gPD+TQglFEV7prR5i
         7cow==
X-Gm-Message-State: AOAM530ZzYeYHnRU6g7OpHDwc8AL9BcB850WiQzacDb4Ta1vtPFDFV6m
        O9K37eWHkXzm95gjHYvJgpDhsg==
X-Google-Smtp-Source: ABdhPJyU8PG/wAcrFwSZsM0fsBrUo6iOz58JEy9KQ+WLvqgPrvirovzflAtiBXqvcf2buozgD1xsKw==
X-Received: by 2002:a05:620a:1096:: with SMTP id g22mr7231728qkk.7.1611100354314;
        Tue, 19 Jan 2021 15:52:34 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id j203sm192636qke.134.2021.01.19.15.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:52:33 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:52:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jacob@gitlab.com
Subject: Re: [PATCH 2/2] ls-refs.c: traverse longest common ref prefix
Message-ID: <YAdwvzQCGc5TfXTF@nand.local>
References: <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
 <cover.1611080326.git.me@ttaylorr.com>
 <fb8681d12864d724108c524834f9498d91e270e6.1611080326.git.me@ttaylorr.com>
 <YAdmtgUPiGUaXiRX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAdmtgUPiGUaXiRX@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 06:09:42PM -0500, Jeff King wrote:
> On Tue, Jan 19, 2021 at 01:19:17PM -0500, Taylor Blau wrote:
>
> > To attempt to reduce the difference between the number of refs
> > traversed, and the number of refs sent, only traverse references which
> > are in the longest common prefix of the given prefixes. This is very
> > reminiscent of the approach taken in b31e2680c4 (ref-filter.c: find
> > disjoint pattern prefixes, 2019-06-26) which does an analogous thing for
> > multi-patterned 'git for-each-ref' invocations.
> >
> > The only difference here is that we are operating on ref prefixes, which
> > do not necessarily point to a single reference. That is just fine, since
> > all we care about is finding the longest common prefix among prefixes
> > which can be thought of as refspecs for our purposes here.
>
> This second paragraph confused me. Aren't the inputs to for-each-ref
> also prefixes?
>
> I guess they require an explicit '*', but fundamentally it's the same
> concept (and certainly they are not just single references).

Yeah, that is the point that I was trying to make. But re-reading this
patch after knowing that it confused you, I think the clearest way to
make that point is to drop that second paragraph entirely.

> > Similarly, for_each_fullref_in_prefixes may return more results than the
> > caller asked for (since the longest common prefix might match something
> > that a longer prefix in the same set wouldn't match) but
> > ls-refs.c:send_ref() discards such results.
>
> Based on my other poking, I'm not entirely sure that we can return too
> many results. But I do think it's worth keeping the caller more careful.

It can return more results, but I don't think that my writing in
b31e2680c4 is particularly clear. Here's an example, though. Say I ask
for `git for-each-refs 'refs/tags/a/*' 'refs/tags/a/b/c'`. The LCP of
that is definitely "refs/tags/a", which might traverse other stuff like
"refs/tags/a/b/d", which wouldn't get matched by either.

> > The code introduced in b31e2680c4 is resilient to stop early (and
> > return a shorter prefix) when it encounters a metacharacter (as
> > mentioned in that patch, there is some opportunity to improve this, but
> > nobody has done it).
>
> I agree that is how b31e2680c4 works, but we don't care about that
> behavior here, since we have strict prefixes. Isn't the argument we need
> to make the other way? I.e., that stopping early on a metacharacter will
> not hurt us. Because at worst we return too many results (hey, there's a
> case!) and because we would not expect metacharacters in the prefixes
> anyway, as they are illegal in refnames.

Yeah, thinking on it more I agree that's the argument we should be
making here. I updated the patch to reflect it.

> > There are two remaining small items in this patch:
> >
> >   - If no prefixes were provided, then implicitly add the empty string
> >     (which will match all references).
>
> I wonder if for_each_fullref_in_prefixes() should do that, since that is
> exactly what the other caller does, too. OTOH, maybe it is better to
> make the callers be more explicit. In which case should it maybe BUG()
> on an empty set of prefixes, rather than letting the caller assume some
> behavior?

Hmm. I don't feel strongly either way, but I think that the BUG is
probably the most sensible option.

> >   - Since we are manually munging the prefixes, make sure that we
> >     initialize it ourselves (previously this wasn't necessary since the
> >     first strvec_push would do so).
>
> I think this was an existing bug (that we were just lucky it was
> impossible to trigger, because nobody looked for the NULL sentinel), and
> would make more sense as a separate fix.

Right. I'll make sure to pull this one out into a separate patch and
credit Jacob with authorship.

> -Peff

Thanks,
Taylor
