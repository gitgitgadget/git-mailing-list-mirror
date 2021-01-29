Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4706C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E2464E08
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhA2Sjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhA2Sji (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 13:39:38 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555FC061573
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:38:58 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j13so4899438qvu.10
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ajD0Vq1P4Yd9sve+n3B8AlHDxRGMdjn57B3ouIV8JI4=;
        b=y3n8Y9h7PKfa8Ax7POUJoRnhyKMDyBMSCGyHXYWpaHVBRuIVMpeVbB5KBLiDep0rM2
         yoiNcXuuFg6KJapSMxSTS7nOMCABDONVH0XNMdsQuEdLHTeF6puzMxZnABGH+U1oCaqV
         jsWJKFt4xyQjLP26MgysbGKmspe+QB4dFdlF+IBTru/YDDRH65yPm0gjBnmu/riNKGa9
         outT5S2IEECv+NTh2K+9Ip15EH9HzqJaGrNfoZvJz3xOSBsFNPGimKALvgz/Bvm/IVun
         +AOS+8LZoCl7/BsDGK4XvProycLuklLq48aIh4vUoJNafoStkXUsx8RjZW9CWjgpCyYO
         bBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ajD0Vq1P4Yd9sve+n3B8AlHDxRGMdjn57B3ouIV8JI4=;
        b=PogUJG+xCuxs7M6iaIgKmHD7BLq0RoQ/wKgMOJqCRPEBu10p8DI7t1ODkBDlE55EQa
         ogC2r+lCeol1jllcThTq3+WQV2Z5li8SfQC0NjNivZ8S9QH4C+uNZex4fFf8TleeiFKF
         gvuCdoEMC+gRX/da9sXyAbWqeYa7aA/wRsc+ubSoiAJ0nd8XXbvbBeat5uQprubSrpLv
         ln9cUigXU3mBHbFEOcC6POF9XDxsEQXmlHJAhWUBlKuWrtgrzIxaZDRd3SalmqdWqIhO
         ZCm++YQgce3v6HIiK7B09fJL8iBweIw81ffEeMP6emcpIxj8uNXwye5kKolVA0B0svc8
         j2AQ==
X-Gm-Message-State: AOAM533Dp7oFRuf3LITtxxr6cKoImTTOr17bZCvGouasJJaRgBWAoc/X
        hGI1e6SnxMR1Sq2Cz1UKGepbLg==
X-Google-Smtp-Source: ABdhPJx8+joD3VXbX61QkiP6Hhpl4bd+n1mhFhTcS0WiyVN8BUgYh8sbte5SPCspYysspKwDLOq/0A==
X-Received: by 2002:ad4:5bc8:: with SMTP id t8mr5490633qvt.36.1611945537309;
        Fri, 29 Jan 2021 10:38:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f05a:e493:9aaa:4c8c])
        by smtp.gmail.com with ESMTPSA id r17sm6239313qta.78.2021.01.29.10.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:38:56 -0800 (PST)
Date:   Fri, 29 Jan 2021 13:38:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH 01/10] packfile: introduce 'find_kept_pack_entry()'
Message-ID: <YBRWPnTxeFPBft7y@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <dc7fa4c7a61f657e779e10385d3e8076d6dac36c.1611098616.git.me@ttaylorr.com>
 <xmqqwnvwtqu1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnvwtqu1.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 06:33:10PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Future callers will want a function to fill a 'struct pack_entry' for a
> > given object id but _only_ from its position in any kept pack(s). They
> > could accomplish this by calling 'find_pack_entry()' and checking
> > whether the found pack is kept or not, but this is insufficient, since
> > there may be duplicate objects (and the mru cache makes it unpredictable
> > which variant we'll get).
>
> I wonder if we eventually need a callback interface to walk _all_
> pack entries for a given object, so that "I am only interested in
> instances in kept packs" will be under total control of the callers.
> As it stands, it is "just grab any one that is in a kept pack, any
> one of them is fine", which is almost just of as narrow utility as
> the original's "just grab the first one---any one of them is fine",
> the latter of which is "insufficient" as the log message says.
>
> But this (in the context of the remainder of the series) might be
> sufficient, at least for now.

As you note, it's more about "can I find this object in any kept pack
(of a certain kind)" versus, "show me this object in a pack" (and hope
that if it appears in a kept pack, that that's the copy that is picked).

> > Teach this new function to treat the two different kinds of kept packs
> > (on disk ones with .keep files, as well as in-core ones which are set by
> > manually poking the 'pack_keep_in_core' bit) separately. This will
> > become important for callers that only want to respect a certain kind of
> > kept pack.
>
> Or maybe not ;-)

:-). The difference here is that we will only want to stop the traversal
at packs which are considered to be stable from the perspective of a
geometric repack.

We mark those packs as "stable" by setting their in-core kept bit, but
we don't write ".keep" files (which would make them on-disk kept). The
latter is up to the user, not us.

> If there are notable relationship between on-disk and in-core kept
> packs (e.g. "the set of on-disk kept packs is a subset of in-core
> kept packs", "usually on-disk kept packs get in-core kept bit upon
> their packed_git instances are populated, but we can drop the bit at
> runtime, so on-disk and in-core are pretty much independent and
> there is no notable relationship"), it must be explained upfront to
> help the reader form a sensible world view.

Unfortunately, I don't think that there is a sensible world-view here
to be formed. Honestly, the distinction between .keep packs and in-core
kept packs is incredibly narrow, and I find our separate handling of
them awkward and error-prone.

But, it is sort of what you'd want here (i.e., a way to mark all objects
in a pack as ignored without actually writing the physical file that
says "ignore all objects in this pack").

Thanks,
Taylor
