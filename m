Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179EDC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E047361463
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhGADVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhGADVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 23:21:40 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250CFC061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:19:10 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s17so5759913oij.0
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0nI36bv76ButPb687bTr6Wqcvv8fkiMst6bFwAkxMQM=;
        b=hFDw0fsOmPEv6Ehy23d55NEmrBH8qR+XnxGMpHzmpJvAl+hVkGvGbEdQ+9hqIoRQik
         49SYqMKhVFmP2MlqQBcTR834A6z+bAvoBLLTteEA3CuWEC7727Mc6pnp/4O47jpgFWUe
         Md+OMUFGUwrude/ptJAU1ItC2xpfSlETiaYiTmTkVOOA9QuHUfVaiPTsL18pVrYPY5Y8
         V22MU1cOTQSv9FHojyluKNORpEOgds8xOfTtdqf8IaAPcNf7C9/kULehCHY0bzYVOkra
         vI5K7h5tb7dXleiXr6zdr8jCEgHM8WnpMAMQ4Ejs+DIwYFtjtXrqTJLsSisFR6ry1TqQ
         lYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0nI36bv76ButPb687bTr6Wqcvv8fkiMst6bFwAkxMQM=;
        b=VFinuLsqWubzhBmU4HE0EX4PGFT8Y1CH6QrV5eOHhg/tWJBgrtVnLg7bdvVKIHbqGW
         +lWA5RURD/wXDqTYA4F0q7WEZgI0r/u6dza1P2ESJIUF8m0dRZQDnyh1v/nDu8LsSvoW
         KU6r7CqMDOCJB5pgdDw4lAiByME2UdreBtVcTSvyrh2PfjJu3Yfx8NB9i7sMJ92jqrna
         6SadDt3PHQTlMSpKiYuCLANPOXC/F8k1QH+QiPh64XHi40dVvgo6PtgDHwJ03/cpfvL3
         eCkgliwVgsziLsp9dwysT3Mmg/xJIB8+6N1HdkWxlejbnTC/1LY0zS4UVhDuYL1Zxy3m
         XI1Q==
X-Gm-Message-State: AOAM53367xStimBi245hc1/CSEt2QKZQlixilynlwqEiJzmGVaWUEj53
        LdVpUeflOjs9WK8EQwguDQ4=
X-Google-Smtp-Source: ABdhPJw7LrnfG/lTvMwrCfp9EgQ7uxBTZetJOXhM8SQsBGBO9BAU0MpeFWmEeRlTsJF4xyxs1tXidA==
X-Received: by 2002:a05:6808:910:: with SMTP id w16mr15700660oih.53.1625109549441;
        Wed, 30 Jun 2021 20:19:09 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id t144sm581848oie.57.2021.06.30.20.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:19:08 -0700 (PDT)
Date:   Wed, 30 Jun 2021 22:19:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Message-ID: <60dd342b92b8b_174a22083a@natae.notmuch>
In-Reply-To: <8735t1gk0d.fsf@evledraar.gmail.com>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <60d389d015943_4290208ae@natae.notmuch>
 <87o8bw1hc5.fsf@evledraar.gmail.com>
 <60d39ef9a8071_429020896@natae.notmuch>
 <8735t1gk0d.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Jun 23 2021, Felipe Contreras wrote:

> >> > What about these?
> >> >
> >> >   $(REMOTE_CURL_ALIASES):
> >> =

> >> Uses a chain of ln/ln -s/cp, would need to add "-f" flags.
> >
> > Why? Isn't "x && a || b || c" the same as "a || b || c" if x is alway=
s true?
> =

> It does:
> =

>     rm x &&
>     ln y x || ln -s y x || cp y x
> =

> If you run that you'll get a hardlink the first time around, but the
> second time around you'll fall back to the "cp" if you remove the "rm".=


Right. We'll need to do ln -f, and god knows if that's portable.

-- =

Felipe Contreras=
