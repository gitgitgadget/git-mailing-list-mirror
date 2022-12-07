Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3F0C3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 02:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLGCek (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLGCej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 21:34:39 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D1954748
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 18:34:33 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id d123so5561368iof.6
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 18:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eVdmRjYDt0ypzjExP3Bpr/qcU1lRKDbpQIrxG2Sb8l0=;
        b=kpp4w1E+CzcE5qC+pbni8/lvz6hfD5xYtZGQbiPy9K2UqJ7NGcSfQLwPKg949gUnQp
         anJ0Wjzag24Clecm+1h/M4Y2t+5QgRIEMKdRax+rbO3v3Rweq9nG5kYigxBsheQFQqt+
         QORlUMhnYYvZe+oz7KhigaY2AEOihj6rX8oS83ZS7LA1XY6vhmoC70WbeNiBi6Glwt9v
         UnEY2HADCbGeUjpn12uDZ9dNNj/gDOFPPAseFxvIujMt3alPn2mriQnhxPnz9ZU8XeNK
         zZjSaGe9wD8F05wpjtvC32CVM4ubSYVAQ0+FBPKtRrcsKTU/9+Ug5gFLyDQudKmvV48b
         iPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVdmRjYDt0ypzjExP3Bpr/qcU1lRKDbpQIrxG2Sb8l0=;
        b=wnQJPSSR0RIKjhtgNOUL831K+zv6UOOT3/NF4VgYebOxz0vUBnE1ed12Z3DaYP2b7/
         2vHhpTV6a4fPnFIrFEWZl6fN+itsoEP+P1mOhm17yvy0axaUV+7/hvfHqf3jTUE7uu8r
         98IcJoUb8wNYuNuejY36KbeoJE4h/F4Mx+P6pHTNtdYJFeGcz+i0/ydIpsZz8EoFKCeB
         pPMabPCASXb3ML46E5QhNgMx67dhAiWkiQNR6AjdmKCFg1iUS1MXtwi+RmFG4Fqzji1G
         BuOQneWIRhBseolxCZHvkzHkBD5YYocBc1THaCEHGsOQHCoDb4R5noqF8ivEjinQjjps
         D5Fg==
X-Gm-Message-State: ANoB5pl4ei4KIaBhMYv0nnDwVJ3XPImtZm8DyHkyNqIa3fgcVMPwYFFe
        /FgOiprWp7YpXRZGZbhUx2HRjw==
X-Google-Smtp-Source: AA0mqf77zIr88Cv5nokC7/HKVm7Yp7ozqhe+9HTMe5l7uyc6yXdMbMUSaKfoNmBFYoSh0TJWDrSwLA==
X-Received: by 2002:a02:942a:0:b0:373:d769:bc14 with SMTP id a39-20020a02942a000000b00373d769bc14mr34610157jai.264.1670380472940;
        Tue, 06 Dec 2022 18:34:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bo5-20020a056638438500b0038a56fc3ca9sm1705759jab.124.2022.12.06.18.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 18:34:32 -0800 (PST)
Date:   Tue, 6 Dec 2022 21:34:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y4/7txDTWK5nGPDu@nand.local>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
 <Y45yaYV3xFB/xR2G@nand.local>
 <221206.868rjle7za.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221206.868rjle7za.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 12:12:32AM +0100, Ævar Arnfjörð Bjarmason wrote:
> First, when you add *.pending.cocci rules they shouldn't be pseudocode,
> but things that are too large to apply right now. I think my recent
> 041df69edd3 (Merge branch 'ab/fewer-the-index-macros', 2022-11-28) is a
> good example.

Agreed, but I do tend to consider this patch too-large to apply right
now.

Whether or not 2k lines of diff is review-able or not (and FWIW, I think
that your recent Coccinelle-generated patches were quite easy to review
pretty quickly), I think there's a bigger question of whether or not we
want to make such a sweeping, tree-wide change. And assuming the answer
to that is "yes", there's is also a question of timing. Proposing it
towards the middle or end of a release cycle seems in bad taste.

But I think splitting this discussion up into, "should we introduce
something like CALLOC() into our style conventions?" and "do we want to
apply this everywhere?" is worth doing. The former doesn't seem to take
a ton of time away from polishing the release candidates, and the latter
can be done only after the former has settled.

So the decision to make this a *.pending.cocci rule was definitely
intentional in this case.

> Second, we have test support for rules now, see
> contrib/coccinelle/tests/. You just need to create a
> contrib/coccinelle/tests/xcalloc.pending.c, and have the expected
> post-image in contrib/coccinelle/tests/xcalloc.pending.res. Please add
> one of those. We don't have them for existing rules, but it really helps
> to assert & review new rules.
>
> The various edge cases that your current *.cocci doesn't compile on
> etc. should go into that test file.

Thanks for mentioning.

> Third, the resulting patch is currently ~2k lines. Can we really not
> make it non-pending with some whitelisting/gblacklisting. E.g. see this
> out-of-tree patch for an example of opting out certain functions:
> https://github.com/avar/git/commit/bedd0323e9b

See above.

> Fourth, I must say I'm kind of negative on the proposed change. I.e. the
> foot-gun is definitely worth solving, but why not just create a
> coccinelle rule to narrowly address that? In that case we can presumably
> start with it non-pending, as we don't have that many of them.
>
> On the notion that we need to special-case:
>
> 	- CALLOC_ARRAY(ptr, 1)
> 	+ CALLOC(ptr)
>
> Because an array of one is "not an array" I don't really buy it. The
> calloc() interface itself exposes that, so I don't see why we'd consider
> those separate on the API level for these wrapper macros.

I think the point is that it's just weird. Yes, an array of just a
single element on the heap is indistinguishable from asking malloc() to
give me the same bytes and then memset() them myself, just as it's
indistinguishable from calloc()'ing the right number of bytes for a
single structure to begin with.

But whether or not the two are indistinguishable doesn't mean that it
makes intuitive sense, and that is the goal of CALLOC().

Thanks,
Taylor
