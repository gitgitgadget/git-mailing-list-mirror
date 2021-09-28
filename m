Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74867C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFFB611BD
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbhI1IkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbhI1IkF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 04:40:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CD9C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:38:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id l8so32461421edw.2
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=46OnGNqZS6TuXG2JTjP6Bd3PJWVwnSfVMlZl2Qa1Hxs=;
        b=OFGCoZpMrd2CfpeKVuTkUdxk3gEEd+bWTRPZD92h2GFtcikN1H6ya+3LjVt1NogK61
         HKlDZrjlPwKbCyzpRajNsakFjlULv6kjxX9LGCk+0MNHDK7hDzo7IbOqNkkP3ardxp2f
         QwvrdWmjiWST4m1iO/SevWm7j4U2qAY8Pk0skAioCxItuLAV78IexTv077GmGMxNIdWW
         aQ/rO64OrpVX99Rwv5FU1tieKaCf1H7dxn3UUK+2xZViVbrh9ag9/liX5+M9+L/bh8Fc
         tdTJDqKG2ud86jabuHQif7TrUg2PDXR3eCztFdtoYsQNwLP536kS53mZRiF43ZTHySSF
         pXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=46OnGNqZS6TuXG2JTjP6Bd3PJWVwnSfVMlZl2Qa1Hxs=;
        b=M61+gSEZqYapPsOgALkvbNJqxlbvqcud02uPISX9CGgxajsGwv0aIT8IQjCGYGlAuN
         NPIb9OfUPBONfad3pxe0J7t3kok934AtosN3jBejjJNqgYC2pkmDgSSZIjHg6IXPtJPn
         kSHvyx5pnIMZaNZjkG9q2jOhS1V08UfU30UPl7hj4woJAzFK0ie5dFR8WPTKdFwVjao0
         xfuFdvmRvxV/HkMjFy1VkWehYD8whTbzpSpmkUusoMSmjZCp/c/4BhagM+O7SYdIBQnJ
         beSdOZ5jzSsUrcO7UCt/0+/V5zzCzXDrPPdVyqz5SMHtltGXiliraqsUaCrCFx/KSVBc
         6BNg==
X-Gm-Message-State: AOAM531B9giywZek3x4YdOeNoZr1/t2cK2BmG38pmI8zb+WrTIyB31lS
        p4tIVsKA9cJzBjWY2/ptk+U=
X-Google-Smtp-Source: ABdhPJyP83VwGbEh9XiyWHAPFFp+gFNTfm1+GFdx2VSTn0N1WdMjfuamRhXoLrUsUREo9oQnj8deNg==
X-Received: by 2002:a17:906:c18c:: with SMTP id g12mr5258537ejz.458.1632818300387;
        Tue, 28 Sep 2021 01:38:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y8sm10073950ejm.104.2021.09.28.01.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:38:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: hn/reftable (Re: What's cooking in git.git (Sep 2021, #08; Mon, 27))
Date:   Tue, 28 Sep 2021 10:35:36 +0200
References: <xmqq8rzhmsi7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq8rzhmsi7.fsf@gitster.g>
Message-ID: <871r59xfgk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Junio C Hamano wrote:

> * hn/reftable (2021-09-10) 20 commits
>  - fixup! reftable: implement stack, a mutable database of reftable files.
>  - Add "test-tool dump-reftable" command.
>  - reftable: add dump utility
>  - reftable: implement stack, a mutable database of reftable files.
>  - reftable: implement refname validation
>  - reftable: add merged table view
>  - reftable: add a heap-based priority queue for reftable records
>  - reftable: reftable file level tests
>  - reftable: read reftable files
>  - reftable: generic interface to tables
>  - reftable: write reftable files
>  - reftable: a generic binary tree implementation
>  - reftable: reading/writing blocks
>  - Provide zlib's uncompress2 from compat/zlib-compat.c
>  - reftable: (de)serialization for the polymorphic record type.
>  - reftable: add blocksource, an abstraction for random access reads
>  - reftable: utility functions
>  - reftable: add error related functionality
>  - reftable: RFC: add LICENSE
>  - hash.h: provide constants for the hash IDs
>
>  The "reftable" backend for the refs API, without integrating into
>  the refs subsystem.
>
>  Will merge to 'next'?

I think we've reached approximately "good enough" with this for the next
steps, and can hopefully fix any remaining nits (such as my [1])
post-merge.

Maybe hold off until Han-Wen gets a chance to ack it, and whether he's
ok with the proposed fixup(s)?

Wasn't there an outstanding "some of this in reftable/* should be static
functions" from someone, Carlo? (CC'd). In any case that sort of thing
could also be a post-cleanup, I couldn't find a reference to that
discussion in anything except my vague memory of it as I wrote this.

1. https://lore.kernel.org/git/87wnn62nhp.fsf@evledraar.gmail.com/
