Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8A6C4707F
	for <git@archiver.kernel.org>; Fri, 28 May 2021 01:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46930613C9
	for <git@archiver.kernel.org>; Fri, 28 May 2021 01:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhE1BN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhE1BN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 21:13:56 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61AFC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 18:12:21 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id v22so2708391oic.2
        for <git@vger.kernel.org>; Thu, 27 May 2021 18:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=sIXgYQrhTXxCGfqIgDb+qjo7xciNhU0wg6MOULPS5Hc=;
        b=eW4A0Cdm8x2t9fhgSSMiGlhNfgehNJOl9qTVL/u5gzRCUR2en2STAxM01wOr8y64LG
         99EAlq4Ut22tjW4TuPfZUceDdvovND1vSQ0z0GVg6qkvyOY+MFPhtEg/gXsT457EbNWe
         7prcwfT7WgGg4C+ri4PidYKrvv2IfzHsTEcWfoTkhnLINT61BXQ1xHFRCu4j9jJhGsKK
         DDv5pAriE6PUK3qR00OGcrtZOEFv5MWc1LBndkF2kIjCE0ujUBeVeWSPJotMOEghnhmW
         3sd8KJO3+7BsBhP0AO1JJo4OwltjFgx3Uniqiqnc+PF7rjlZ9unbUbmKstF33F+07b9J
         A9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=sIXgYQrhTXxCGfqIgDb+qjo7xciNhU0wg6MOULPS5Hc=;
        b=g7iPm96EJyYbVA0eF0yswiFRsp53k5oJs0gZtvCk2UH5zoxvI+4uqNQCOPlTmIcyzU
         Qde21oMG5Ib1wVy891tfDeUsCFVzzfsHvkS3xLA04B1v2mzrVDKgFC83222k7ejY0dbR
         ShG/Ig1WvvuOA1F0xhSovZESb2LttbdsrQmw4WzDcR2o0Jd4b/TmYYAzfHjTx7JXcsKz
         qIOAJHY3ZYCEn27HAo1ywiX5bJBOYsleBpAteqR1JQeKKm9I3niYWtTYUxsmoMV577jz
         jW1z2w/ZREGVjA2ZL/Su3//4B1bXrIKsD18HcPqYpQQYibtYvJi4UUMp4cyVFdrecK6L
         IkwA==
X-Gm-Message-State: AOAM532rUcxdBU9/2vCH2SYwveKud2pSHvIMlAS8BzucAi5JRe4/n/Ym
        9h8+s65XbCVkh74hiDn/+Di9d3UrF3R1XQ==
X-Google-Smtp-Source: ABdhPJwyc5JpnBjDvXa8Nz2nLB0rM4C3zCiHeRzuSyhx42rbGAioT8ERABbPhTt6PrsryjpMtcyuVA==
X-Received: by 2002:aca:4a8d:: with SMTP id x135mr7348542oia.148.1622164340855;
        Thu, 27 May 2021 18:12:20 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m1sm859374otq.12.2021.05.27.18.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 18:12:20 -0700 (PDT)
Date:   Thu, 27 May 2021 20:12:19 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60b0437310c0_405922085b@natae.notmuch>
In-Reply-To: <xmqqmtsf9151.fsf@gitster.g>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
 <xmqq7djoj9z9.fsf@gitster.g>
 <YK+texFSW6UurDui@coredump.intra.peff.net>
 <xmqqmtsf9151.fsf@gitster.g>
Subject: Re: [PATCH v3 0/5] doc: asciidoc cleanups
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:

> > The "comments-by" sub-thread looked unproductive to me, so I mostly
> > skipped it. ;) But as the person whose name was in the trailer, I will
> > say that I do not care either way if it is included. It did not seem to
> > add anything to me. Some trailers are good for pointing later readers to
> > folks who may be able to help understand or debug an old commit. Some
> > are good for just giving credit to people who helped. "Comments-by"
> > didn't really seem to do either to me (and I don't feel like I
> > contributed much worthy of credit anyway).
> 
> Exactly the same feeling.  It didn't add any value that was why I
> saw no point in using something almost nobody uses (instead of the
> more commonly used Helped-by, for example).

As I demonstrated with probabilistic certainty; everyone uses uncommon
lines (including you). The fact that a line is uncommon doesn't
necessarily mean it's bad, in fact, I do see value in going outside the
box (like one of my favorites: Brown-paper-bag-fixes-by [4981fe750b]).

And of course if you find Comments-by so egregious, you can amend my
commit message (as you have done many times in the past). But this might
be a good opportunity to exercise the advice Jeff gave in another
thread, and even if you are not 100% happy with something, let it slide.

Cheers.

-- 
Felipe Contreras
