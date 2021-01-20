Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFFFC43381
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C9723383
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbhATLer (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 06:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbhATLBs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 06:01:48 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5780CC061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 03:01:08 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r9so15926500qtp.11
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 03:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KK/ApKvTHJQkR/KdlI2hiSuetA3XmPQXdA2BIEkRKUI=;
        b=HaaoCL+uapaPcnO0H55YIcbU6hNffDJu+WTmAEI38znG4mVaX+9q0BZYwHnlI0iY9m
         0zxdpjoF/a7+P5QIzaDOdMWKlGWLK1w9XolEWh/vHz1szT+Ga2Nj1lnAncMv8+292VP8
         nMt+dlGyQszl9nZkAWQy/50J/TOn8KiaL/0oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KK/ApKvTHJQkR/KdlI2hiSuetA3XmPQXdA2BIEkRKUI=;
        b=HLvo+JB0+mY4r/rMXSku/RZ25MvEry1Td2rYUO5LrAQJTGu3JYf+SbHTfSWoS2R5UE
         zVBufaMXawS642oij6PhykaRL7YJaWmvuIPOHp3PldfdE4yjF9raL+OyCV42tpUmP1vz
         DpQUVgcTwDzOSGe6u4qaAQ/CBQUNF0otvPc2u/G2nqwI4KJEi+QWdHkj3/2bgSQJcNpq
         uI7D45iEYXJN89xMh8iwvyKTwXiSXN/piU4Y5guCwKcv7BUuAvTZTEuSyE4sTEA7ZxJU
         Vd7Mxu2bERUijjwroTL9UMpwirNCvog24wBm2oiXbDdEnheWVaoWyPR0KHR8EszDh+3i
         sJpA==
X-Gm-Message-State: AOAM530VBIuIfeNo6KpzgylSztJXd4gogwt7uuK6ycNfFhoEOvHVQzOK
        /cqstjfXJAUSkl6/Hq2tyGV2s54nY2mcX5D6ED+raA==
X-Google-Smtp-Source: ABdhPJyE7VqEklo83WYgRPGU4GsgqgvoiAytYMmiZ8lCPZZCSFljgdgEa44KrWVb62G7Qx2A1ZK1rthUfodTl+002G0=
X-Received: by 2002:ac8:4711:: with SMTP id f17mr8378192qtp.256.1611140467417;
 Wed, 20 Jan 2021 03:01:07 -0800 (PST)
MIME-Version: 1.0
References: <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
 <cover.1611080326.git.me@ttaylorr.com> <fb8681d12864d724108c524834f9498d91e270e6.1611080326.git.me@ttaylorr.com>
In-Reply-To: <fb8681d12864d724108c524834f9498d91e270e6.1611080326.git.me@ttaylorr.com>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Wed, 20 Jan 2021 12:00:56 +0100
Message-ID: <CADMWQoO+163mJBXctb+GHFebGCbKQRPAtMJ676_GwfEt-BedAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ls-refs.c: traverse longest common ref prefix
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 7:19 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> ls-refs performs a single revision walk over the whole ref namespace,
> and sends ones that match with one of the given ref prefixes down to the
> user.
>
> This can be expensive if there are many refs overall, but the portion of
> them covered by the given prefixes is small by comparison.
>
> To attempt to reduce the difference between the number of refs
> traversed, and the number of refs sent, only traverse references which
> are in the longest common prefix of the given prefixes. This is very
> reminiscent of the approach taken in b31e2680c4 (ref-filter.c: find
> disjoint pattern prefixes, 2019-06-26) which does an analogous thing for
> multi-patterned 'git for-each-ref' invocations.
>
> The only difference here is that we are operating on ref prefixes, which
> do not necessarily point to a single reference. That is just fine, since
> all we care about is finding the longest common prefix among prefixes
> which can be thought of as refspecs for our purposes here.
>
> Similarly, for_each_fullref_in_prefixes may return more results than the
> caller asked for (since the longest common prefix might match something
> that a longer prefix in the same set wouldn't match) but
> ls-refs.c:send_ref() discards such results.
>
> The code introduced in b31e2680c4 is resilient to stop early (and
> return a shorter prefix) when it encounters a metacharacter (as
> mentioned in that patch, there is some opportunity to improve this, but
> nobody has done it).
>
> There are two remaining small items in this patch:
>
>   - If no prefixes were provided, then implicitly add the empty string
>     (which will match all references).
>
>   - Since we are manually munging the prefixes, make sure that we
>     initialize it ourselves (previously this wasn't necessary since the
>     first strvec_push would do so).
>
> Original-patch-by: Jacob Vosmaer <jacob@gitlab.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ls-refs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index a1e0b473e4..eaaa36d0df 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -90,6 +90,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
>         struct ls_refs_data data;
>
>         memset(&data, 0, sizeof(data));
> +       strvec_init(&data.prefixes);
>
>         git_config(ls_refs_config, NULL);
>
> @@ -109,7 +110,10 @@ int ls_refs(struct repository *r, struct strvec *keys,
>                 die(_("expected flush after ls-refs arguments"));
>
>         head_ref_namespaced(send_ref, &data);
> -       for_each_namespaced_ref(send_ref, &data);
> +       if (!data.prefixes.nr)
> +               strvec_push(&data.prefixes, "");

The old code, with for_each_namespaced_ref, would walk
"${NAMESPACE}refs/". The new code would walk "${NAMESPACE}" because
we're pushing "" onto data.prefixes. So if there is anything in the
namespace that does not start with "refs/" it will get yielded.

Does that matter?

> +       for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
> +                                    send_ref, &data, 0);
>         packet_flush(1);
>         strvec_clear(&data.prefixes);
>         return 0;
> --
> 2.30.0.138.g6d7191ea01
