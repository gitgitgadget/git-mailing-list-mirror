Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B9AC433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 18:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357805AbiELS6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 14:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348075AbiELS6D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 14:58:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFF9712ED
        for <git@vger.kernel.org>; Thu, 12 May 2022 11:58:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x52so5607763pfu.11
        for <git@vger.kernel.org>; Thu, 12 May 2022 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFeGXu4JtlL7ajJfo9ocR6vsyaJulJH2macwsnXhXnw=;
        b=YXXREif6XBD5Tzb3HluABc5xlenjVWVqqqPPX/VR7u5vdWZdywBz0xgt0L4O5h1dtT
         q+2Ll4ZZCylRJfNLH4Q8dQ1Q2qvX0OQNJ+iBZHpJ6/L9aolpMCtQQGu8QuwKDKTxVDr4
         KzKBiYrUZPKuRR1kPNNjna7CwZP1cjPz+oJLtak+fsa9mjvSvasREwiMgmsyTGleYpTN
         pverim0KbwYLDnnHbDcDiDNqkQN35DI0+23b9W2hjbGxV/osu6rz4Cg6IpRwYsT7kqS6
         CEbxKU7dx1cIEbmoIHFyXR7u2oPePBUVd1jAmycetm7KEosbNaGZTPOiZG8iSRZEGWUj
         941Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFeGXu4JtlL7ajJfo9ocR6vsyaJulJH2macwsnXhXnw=;
        b=gMoY3pDE0x5bKq6e+yq7DO5YaZp04GiE2S4P5U+rzlxA4ozNwtkapE69/soA+NtwoB
         mKbd1P83pzxgh9ADxFoFvr7ES89xTSWt8PxzfYXtPDRrhT9+vZYw2neWNJoIyYjczx3Y
         KQQEwXwjbbt7uGbnKFp/jLnqSQLVpCTTQdZjt/oe08gAFHkDY7aJCun86EpQF5DZvHIr
         h9vKSbMKmC/XgXHf+q6Eo5Ri2S4n844X2wiBUm8oSYxxP2CgUzPeSAgwqFtCVU0dzYsR
         biFXuCo8u2Zm0QwsYavyVgRQYrNUIhDL1TnbMx18H8KQMrfpEBAbWcPzCvPFIBAvgnCQ
         FOfg==
X-Gm-Message-State: AOAM532RTNUlcBLXOrlBCJvEVoTlo8yKsFaesGmmxXbUzHVgVShBRJqH
        AvLs1o56hLTwN6UHMixOCXVYXfjPXIaaDpuQs+PhM/iRF/A=
X-Google-Smtp-Source: ABdhPJyin2H7Mv5zXYcnrm3ayGd3tdqLjSRT7C7KPlNr0Ji/fb7xgJOzp/VWt8OjWa2u1YSey+3DuTwKLM/jRzdwYBk=
X-Received: by 2002:a05:6a00:8c2:b0:510:98ac:96c9 with SMTP id
 s2-20020a056a0008c200b0051098ac96c9mr871056pfu.18.1652381882305; Thu, 12 May
 2022 11:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220502083639.610279-1-chriscool@tuxfamily.org>
 <20220504104601.136403-1-chriscool@tuxfamily.org> <20220505112114.ktki3dgjbyukzhlm@carlos-mbp.lan>
 <CAP8UFD3UvjJzEQApiCKSknDWaTjbEMKkr17j1QN-8gwz7eWV3Q@mail.gmail.com> <xmqqzgjmg1q5.fsf@gitster.g>
In-Reply-To: <xmqqzgjmg1q5.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 12 May 2022 20:57:50 +0200
Message-ID: <CAP8UFD2tk7ti_G0Ao_-u0g9+hm-x4gnuSjEPHbnKPan6S741Ug@mail.gmail.com>
Subject: Re: [PATCH v2] http: add custom hostname to IP address resolutions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2022 at 6:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > "Perhaps invent a totally bogus domain name, map that to
> > localhost ::1, run a test server locally, and try to clone from that
> > bogus domain?"
> >
> > (See: https://lore.kernel.org/git/xmqqfslrycvp.fsf@gitster.g/)
> >
> > I think "a totally bogus domain name" refers to something other than
> > "example.com".
>
> I meant a domain that should not be used for purposes other than
> being examples in the real world, including "example.com".

Ok, thanks for the clarification and for copying the relevant RFC
information below.

> But RFC6761, which is an update to RFC2606, describes a set of
> properties that make .invalid nice domain to use, including:
>
>  1.  Users are free to use "invalid" names as they would any other
>      domain names.  Users MAY assume that queries for "invalid"
>      names will always return NXDOMAIN responses.
>
>  3.  Name resolution APIs and libraries SHOULD recognize "invalid"
>      names as special and SHOULD always return immediate negative
>      responses.  Name resolution APIs SHOULD NOT send queries for
>      "invalid" names to their configured caching DNS server(s).

I wonder if libcurl considers itself as a name resolution library or
not. It has a DNS cache, so maybe in some ways it is. Also however it
considers itself now, it could perhaps change in the future. Even if
the current developers are against such a change, a new RFC might be
more precise and specify something for libraries like libcurl which
could make it change.

So I am not so sure that using "invalid" is our best bet.

> Another possibility is ".test" but it is more for testing DNS, not
> application, i.e.

In a way we are testing DNS, as we are actually testing libcurl's DNS
caching and its CURLOPT_RESOLVE option (even if we also test that Git
is correctly passing the config option to libcurl at the same time).

>  1.  Users are free to use these test names as they would any other
>      domain names.  However, since there is no central authority
>      responsible for use of test names, users SHOULD be aware that
>      these names are likely to yield different results on different
>      networks.
>
>  3.  Name resolution APIs and libraries SHOULD NOT recognize test
>      names as special and SHOULD NOT treat them differently.  Name
>      resolution APIs SHOULD send queries for test names to their
>      configured caching DNS server(s).

So with this we can at least expect that the way libcurl considers
itself will have no impact on our tests.

> so for a code like what we are discussing, which would not want the
> names to be shown to DNS and yield any IP address, ".test" makes a
> poorer "bogus domain name" than ".invalid", I think.

I would think that there are risks in both cases. I am Ok with using
any of the following in the test:

BOGUS_HOST=gitbogusexamplehost.invalid # or
BOGUS_HOST=gitbogusexamplehost.test

The test passes for me either way.

> By the way, we seem to have references to .xz top-level domain,
> which appeared only in earlier drafts of what became RFC2606 (which
> was updated by RFC6761) in both documentation pages and tests.  At
> some point we may want to update the former to ".example" and the
> latter to ".invalid" as a clean-up.

Yeah, good idea.

> > Also "example.com" does seem to resolve to an IP address and even has
> > an HTTP(S) server on it, while I think the purpose of the test would
> > be to check that there is not even a valid DNS resolution when the new
> > option is not used.
>
> Yup, that makes ".invalid" a better candidate, I think.

Ok, I will use "gitbogusexamplehost.invalid" in the next iteration then.
