Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895FCC433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 21:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiAYVkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiAYVke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 16:40:34 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150AC06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 13:40:34 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id z199so10870458iof.10
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 13:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z3UycJYARpCRCUXtGP+ENCBDcXDkOeZ7LSy4Wi6zhJA=;
        b=D+Uj0V3nt9i15/arswiF5EPAAbiNS4GA0YMy8kQZk4+1Lzwz6C/yxdtUWgSlW3kFyq
         L31j9FZYwQqKoGp09jw8ANsv0ttyW9/VT1gVA4UScUov6QACyLHqu18qcwg2pbsxhy0x
         hjAeTlE0UzJkuxSHn8RctglCSn95Jp88B1UNQMd5EPOxObdzBHBDJ3LEJmtOIlI7c9yi
         XuaTPhGOA197psC0iXETG2ciB9oFIk8G2LYYiFJSkNA+H02XNYwWywLYAYxY80JKbu8i
         P0WmmS8Ej8iRd8uCzdRhZCngciqgK9pKx8wMepT1DrrWqSCjioCuOLBGsfjg0run+/H3
         UF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z3UycJYARpCRCUXtGP+ENCBDcXDkOeZ7LSy4Wi6zhJA=;
        b=SDmEbbECVeMYMKJQ5XhtpYeUgcUBEx10EYt7uQwzsI0CABukENI8qIa3woWcezHuf+
         n22395qgU/5ikp/yoPDgYMjc9AqsT5gCi4HijFtS2/SL+/tX2Pga+MNP7emq9OZXfrrg
         Ynnfohwa85IR86+9jcC8sEh8B/zEXVtMtthlRuurIstm+9xUeUbztlXBa4aFCM0cPP87
         OH23eKtu6iw+Ec/egMfL/x0TzutXheOwVeToyQCYpJpcBDoqejMTP5baa2v66NTcu9jM
         xCXlHpNSKAV0iVtOif9zqbbnR2lYbLLR9eD2tfmccAiaZkmxIcFWh4ovz7QxFJQNuGys
         Bk2Q==
X-Gm-Message-State: AOAM531uQqN47fBrYEiL9uRPwPqUcXyAFDsMayvL4LBK+cE+5BfODmTh
        +K1Hw/b3oe+yvwSX6n7uOtZcFMvsHQIkSg==
X-Google-Smtp-Source: ABdhPJzwalJvKNmDlnbLgIwpQBlGZkaiRkxpMpO8CUnWU4NfSf2WvqDzLu+V7QfHldLtoKOptrvluA==
X-Received: by 2002:a02:9343:: with SMTP id e3mr1784704jah.75.1643146833669;
        Tue, 25 Jan 2022 13:40:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i20sm8906237iov.46.2022.01.25.13.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:40:32 -0800 (PST)
Date:   Tue, 25 Jan 2022 16:40:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH v3 7/9] t/lib-bitmap.sh: parameterize tests over reverse
 index source
Message-ID: <YfBuUBOjWpvVOE/9@nand.local>
References: <7ce3dc60f93d5154943a63f1c09345bd47fbc7c9.1641320129.git.me@ttaylorr.com>
 <20220124191503.2447008-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124191503.2447008-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 11:15:03AM -0800, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > To prepare for reading the reverse index data out of the MIDX itself,
> > teach the `test_rev_exists` function to take an expected "source" for
> > the reverse index data.
>
> Thanks - up to here looks good. Thanks especially for patch 6, which was easy
> to verify using "--color-moved --color-moved-ws=allow-indentation-change".

Good, thanks for verifying.

> > diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
> > index 48a8730a13..77b5f46a03 100644
> > --- a/t/lib-bitmap.sh
> > +++ b/t/lib-bitmap.sh
> > @@ -275,17 +275,23 @@ midx_pack_source () {
> >
> >  test_rev_exists () {
> >  	commit="$1"
> > +	kind="$2"
> >
> >  	test_expect_success 'reverse index exists' '
>
> To make it easier to understand test failures, we should probably
> include "kind" in the name of the test case.

Sure, that seems good to me.

> In a separate commit after this one, we should do it for the other
> blocks.

But I'm not as certain about this one. The tests are already separated
into two different test scripts (t5326 for the in-MIDX .rev file, and
t5327 for the external .rev file). So it should already be clear based
on what test script you're running.


Thanks,
Taylor
