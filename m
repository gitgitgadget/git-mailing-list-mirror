Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B00C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 00:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA74661107
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 00:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhKJAS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 19:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhKJAS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 19:18:57 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1BC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 16:16:10 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id w15so615060ill.2
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 16:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PaENmZ9pDBUQP3NPVHPI2C7y/W64v2mZoVagjLS5Hfc=;
        b=kWO8d96ON2v7eJ/+LWBRe5SXmzv7kTsYu0nK4J55kxLcxKpKmv631YBjk2SFgYKh6L
         qk41l5VFVUzZUFOOqllZ7K7BJVX6AoGwHluSpgxLiMpv268UFj4kin/cT0VqLLyhp1tV
         GS+D2fdg5be5pcg5pMPPhZ1VA3Txqo0znVCsmUqeOIDZ9JdCP8DTbPzrZd6EBAvyzVBE
         +SlC6MWPT0KUZDoe3pcoCmsIrDKdwqzrSUjTD4BvFRTMnkb3HaJV1mhT0IUkEp5AMeiR
         +gVD152fL/omvj5qZyk9F2tyUS+9QEp+vl6sR6zbh9eP3lPyYADy2UD2VtcHo+21lZ1N
         1EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PaENmZ9pDBUQP3NPVHPI2C7y/W64v2mZoVagjLS5Hfc=;
        b=EEnGM9KweNzMzDTIHqm0Ejk/Rh/mu3Q6e8Dp42czfOJLN4ARKJf9UkkRnjzvpYKw7T
         sly3mfrQpfOyGpH9wgQGKhnDL494h5fIQv3Y+kb//DbbIasD6yOL+AqvukMfzf7KD1ME
         +tcGd6zbObe6694mxf9WvbRzAJd48JRCpASO+tMWQY5D/bgYglwtjXD59EFJU33Df1ln
         y3llX5WhEpAkS4zb0EbKsuFu+VeFgRCkojH3p+eYwXJikUWGlo7n0K1Wd7cHvEYXDXqF
         nn1FjlTYTkAfuBeFjg5yS/35K9WL3G/8fZDTs3slmIqa3zpkaNHaWqare8Ba2MmR3Msb
         J2gg==
X-Gm-Message-State: AOAM531ARJzlWIdchfGG1/ik2uYqkAc62uwk6fzrBQb7yUv6unESV40/
        p+hADBPOf2DP3mgdQQZf+7RCNZl4zlneit6O
X-Google-Smtp-Source: ABdhPJwwS5SZMjtxh1UOxjjlL4lN1HZPYbsYZBe/eVuD8O2vZ87S9u3Z1zyJXyt9z6YC5Daq1iuIvA==
X-Received: by 2002:a05:6e02:1989:: with SMTP id g9mr8532549ilf.61.1636503369084;
        Tue, 09 Nov 2021 16:16:09 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f5sm11014031ioo.34.2021.11.09.16.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 16:16:08 -0800 (PST)
Date:   Tue, 9 Nov 2021 19:16:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH 7/8] grep: simplify config parsing, change grep.<rx
 config> interaction
Message-ID: <YYsPRxe0hgJYlisq@nand.local>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-7.8-677a8f8520f-20211106T210711Z-avarab@gmail.com>
 <YYms4czKVnQFWYQ+@nand.local>
 <211109.86ee7qdqz0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211109.86ee7qdqz0.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 03:01:12AM +0100, Ævar Arnfjörð Bjarmason wrote:
> Or someone who'd read the docs, understood that we promised that would
> do nothing, and inserted that just to test us, but that seems unlikely
> :)
>
> Or, I suppose someone who's entirely confused, and will continue being
> even more confused now that behavior changes on a git upgrade from ERE
> to BRE.
>
> I'm hoping the last two paragraphs describe no-one & that this is safe
> to do.

Yeah, I agree that it seems very unlikely that anybody would actually be
affected here, so I'm comfortable with the change.

> >> ---
> >>  Documentation/config/grep.txt |  3 +-
> >>  Documentation/git-grep.txt    |  3 +-
> >
> > Not the fault of your patch, but these two are annoyingly (and subtly)
> > different from one another. Could we clean this up and put everything in
> > Documentation/config/grep.txt (and then include that in the
> > CONFIGURATION section of Documentation/git-grep.txt)?
>
> I've got a large series to do that for all of these, but opted to skip
> that particular digression here (even for just grep.txt it's a bit
> distracting).

I think that you could include a preparatory clean-up in this series to
make the Documentation/config/grep.txt included by
Documentation/git-grep.txt without being too distracting. But if punting
on it now works better for you, I don't think either makes a reviewer's
job substantially different.

Thanks,
Taylor
