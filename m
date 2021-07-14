Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFECC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58386613AB
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbhGNRoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbhGNRob (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:44:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D616C061762
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:41:39 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id u7so3163920ion.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QPRkJSLJrWARN2s8HxHM9hr1wmoN6Yd/yBZCxYQale8=;
        b=JMYaybJXXSk1zb4x3ZhHNdgtfxeDfIeZDmuN1nDYoUwuNode/2ELEnJV9ALcC/L6NU
         H6HRJPqFyjDSq9Ir1pxe7sz7hg27/bh8ydvPMVAOD5TriAYlJtKNc2PK+MvbReeYMuLe
         wlVAvDyeoNwS0cg/tvtTQXKhruweaTy1zNl37ZOdvj6aZkNNxLt5GGjw0myCnCSEHdjQ
         dggTUuaYiXmKH9YasmVSYf92KZh12zfcgLIESw6u6yq5ZMrlbLiKKrAYhtSV5BwlB6O2
         Oi0T3ZNpW19hY49TWFIosJz0cZRDegI23MP5A6JUx89vN3guaufKAW2RszeF1s9YvzUx
         +3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QPRkJSLJrWARN2s8HxHM9hr1wmoN6Yd/yBZCxYQale8=;
        b=c7paoorMxcuNhsMWv9vJ5hr35fwdyYkErpYye1MpQQUDkLxe5EULT2Qh7OXnG8kHnD
         mmW8ClsasDfwZIrwnHpy5DFDRejmyuwVxekWucqUxLl25G/SY0cEk6IJqKbt+xXKuLMR
         Cl6nRsxUo8Ei1gNznjSTauHYlHMq+2+d+yG8kJPmn24U8T98jc/WCztZDcBSZRjJ58+T
         vDrKR3NABkCUEGLfqd2poRKvMG+QZQaqjgMzjVdIWS5sW9/nGBMVf8bdt9+P7pVW1JmL
         nVInb89wF+NftsuW0geYbD745SUahGO7U6KQ3ktWbH3K+U5vG7GoHXE26h2TLs8QKafm
         kcHw==
X-Gm-Message-State: AOAM531LZv8vx/x+pjkvyCR51BhC8oaWKHlLablcyfvEFQfY+dBpKPXO
        Oldm2eI2NugJZGGP+u0i3mp+5Q==
X-Google-Smtp-Source: ABdhPJxqTdGBhTh5YXNCofnLbE+DWdNh3NO4ozNc2bWz0ZhXZ63O9hMgiSvxDlVUDQxbqCc6XqTJPQ==
X-Received: by 2002:a02:b199:: with SMTP id t25mr4800445jah.35.1626284499017;
        Wed, 14 Jul 2021 10:41:39 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id 204sm1586577ioc.50.2021.07.14.10.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:41:38 -0700 (PDT)
Date:   Wed, 14 Jul 2021 13:41:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 04/24] Documentation: build 'technical/bitmap-format'
 by default
Message-ID: <YO8h0smhBPuIjFAa@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
 <87bl7uzvaf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bl7uzvaf.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 25, 2021 at 01:35:48AM +0200, Ævar Arnfjörð Bjarmason wrote:
> As a mostly aside I've got a local series queued up to move all of these
> "format" docs to e.g. gitformat-bitmap(5), i.e. to make them first-class
> manpages, so other pages can link to them. Right now we mostly don't,
> but when our manpages do they link to the generated HTML, which e.g. I
> don't have installed by default.

It would be nice to be able to look it up with "man 5 gitformat-bitmap".
I actually don't have strong feelings about this particular patch
getting picked up or not, since it doesn't add the actual format changes
to the file itself.

This does pick up the bitmap-format document in "make -C Documentation
html", which is nice(r than "make -C Documentation
technical/bitmap-format.html" IMHO).

> But there's still (but maybe later in this series) a link to
> bitmap-format anywhere from another manual page (but there is for
> e.g. technical/pack-format.html).

No, I didn't add any links pointed at bitmap-format.

Thanks,
Taylor
