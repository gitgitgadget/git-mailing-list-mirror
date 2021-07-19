Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DACC6379F
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1516113E
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376626AbhGSWZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388722AbhGSVB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 17:01:29 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83199C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 14:31:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id w22so13561290ioc.6
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zesPGVGUsMxwHSqgCLmhao8jCFIKe0UHXeTU3/TC/8g=;
        b=s9IvS7e8XyrN1c2UPs+j7O4zYVtJl5CgO2qqF34ijK3FfnSG6kFeL5adYz9xs66ETy
         xwj3Kx/TlP+jZRzzaNtvOCpw2A4Hqi5KQ2en4K70FBn5bpd1Q6ba8i3KO4sdnuaG2vDK
         83Rw0OkRud6dE5qmFQO7MfwKAmoF+jl/FENqLT7BjKPtU7AxgcTjEk1skowY8oOk8PJO
         ohJKjSja8Y2DbjQXloMX+Z26w/PQPVv4ubNKy7rDEz+IQ94NE9MidVm+XpMBfGNcf8Kp
         z8mfT+3iWoboqXURm9++/rINPgbj8pxCagdiBQpFzvFm0vpXWPMqqOxvJZoUZDBBi3mM
         LO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zesPGVGUsMxwHSqgCLmhao8jCFIKe0UHXeTU3/TC/8g=;
        b=Uj/NPHmfp/y/P/KFPqAAt4d2wRbljxFWihYq/H99Mb+rTkLaCOSgNbBBa6xuYTL+TE
         slcJK4V3FxevJryxKPC/ff0gcVQmKwLMOmMD7Xv2hv5g+SMI6FZrjKOhZG/KO6hbXFz0
         +SOcyeWRgO6vKe1puI4hlQ4kT0ZP38ScNWn7lQRo04ca7qfM4w2z+zJPEEmg5aDFkvEn
         15s3HNKE80Ue5jvA43s7j2k3WO9/ADvomleJRXhqmIz74u0Jk0zKO9okABfLgzqjuBn4
         ioMaidW5V+VuPMJUXG0L5OH17cG59rqLlxz3VN1i0Lz+d8PSrz3oGnakn6IJasa8sMMk
         YAeA==
X-Gm-Message-State: AOAM5304cfOKaK3u1GiyERQDe8sXpbVOVDCOcSdINds+PXfUi5X90Dpw
        CH5M5DHw6KHLE92hpQhLovdVaw==
X-Google-Smtp-Source: ABdhPJyB2Aw2H92l7X/RdKdSulKyMShd1LtumfUBK6Y9sDZn6Amdoolaa4e1xxTONizvxl9Zv29a6w==
X-Received: by 2002:a6b:6016:: with SMTP id r22mr20923332iog.12.1626730307847;
        Mon, 19 Jul 2021 14:31:47 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a0a0:3329:4f28:d1a3])
        by smtp.gmail.com with ESMTPSA id h8sm721416iov.1.2021.07.19.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 14:31:47 -0700 (PDT)
Date:   Mon, 19 Jul 2021 17:31:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] pack-objects: fix segfault in --stdin-packs option
Message-ID: <YPXvQXOcdKdCzcFb@nand.local>
References: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210709T101014Z-avarab@gmail.com>
 <patch-2.2-c7315f2b378-20210709T101015Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.2-c7315f2b378-20210709T101015Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 09, 2021 at 12:13:48PM +0200, Ævar Arnfjörð Bjarmason wrote:

Thanks for the update, and sorry that it took me so long to get to. I
see that this still hasn't quite made its way to 'next', so I'll just
add one comment.

> +test_expect_success 'pack-object <stdin parsing: --stdin-packs handles garbage' '
> +	cat >in <<-EOF &&
> +	$(git -C pack-object-stdin rev-parse one)
> +	$(git -C pack-object-stdin rev-parse two)
> +	EOF

I see that you left my suggestion to inline this here-doc with the
actual 'pack-objects' invocation below alone, which is fine. I think
that it does help the readability, too, since it separates the input
from the command its being fed to.

> +	# That we get "two" and not "one" has to do with OID
> +	# ordering. It happens to be the same here under SHA-1 and
> +	# SHA-256. See commentary in pack-objects.c
> +	cat >err.expect <<-EOF &&
> +	fatal: could not find pack '"'"'$(git -C pack-object-stdin rev-parse two)'"'"'
> +	EOF

On the other hand, crafting this err.expect with one of the object's
full OID still sits funny with me. I appreciate you checking that this
is the correct object to test with in SHA-1 and SHA-256 mode, but isn't
the point that we shouldn't be relying on which object comes out?

I think that dropping this down to just something like:

    grep 'could not find' err.actual

would be an improvement since it avoids the finicky shell quoting,
hardens this test in the event of a future change in hashing algorithm,
and brings the test more in line with the spirit of the patch itself
(which is to report some of its input, not necessarily the first one
given).


Thanks,
Taylor
