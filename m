Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0FC433FE
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354830AbiAXTjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346621AbiAXTb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:31:57 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4FBC0604CF
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:15:06 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x11-20020a17090a6b4b00b001b404624896so64206pjl.1
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dno9mfhhJuvq1otWl+5kUw878dVY6sUTGwJ9NBLTtFE=;
        b=ha4KSK9t+kahaJooWIoQH4rRG9bysZm9/Y8I8mgghRdMy79/W+RR0gjDRDaBxGyIYN
         BxQC9zJYDgh3wepRUF+QXTbX4V57yLjTaCd4xQcJ/ZdcNsOhCDAhpoCkdMMTS+Bu+d3P
         Z8dAex8w6xXry6yhhuWeOwnZW4aTKo+r5LM+Cds9+LPmuN8SGcKnDT0vC4oGvQ6OwLCR
         5HmAvuS1tuuEc+oC/UiZKGUG1K7Ir5WpPHByrrEX2rjQa8i4yybfnKhWqW3JKY4cxWbU
         8NGKg04yuwr+DZRqVxJMbchIn2v1SbMDWGOflPmUtDBGwBHKoJVUn7lWa893L6PUGJNp
         lJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dno9mfhhJuvq1otWl+5kUw878dVY6sUTGwJ9NBLTtFE=;
        b=c7QrhKQAxMAOpNgqCqJq+FVla0QidGi5E/5XlKhvG0COiyZR7TynS7Bb8oqkST6ytD
         HM+ycxSsc0aPwFPsdRCTNdLqWcr7wH8aPmksHHA62tTCO0E+kOjv5yqJGsP9/O8EGgg/
         jeu1QVb5aPHQPTP6Mg7U8Al/GxXSXZigqTNFXeeKfW36YBDXaJQ/yvq/HXhMAmVyw4/p
         j867Wwm4ieqY9CSOfvqJ89QmFYa9NrfBZbNUVhCI/23g7QLA2ADtzt8bv/apRwJMHW8Y
         Gl80NQG9WUHGecHbJLwUS8rvyCL8XTfW8D0XuiegBFz1wqLTIqEzy5d3Hb4D095PSK9J
         Pbug==
X-Gm-Message-State: AOAM5336ATZkC8cp8r1dQPpkuWmSyh606X5lD+sycUn/TiZT8mveY4pZ
        n32aC9IQgr3LJkJo/6Rw8J9ECooMbIJ6Ut0sQnLv
X-Google-Smtp-Source: ABdhPJzsX/OSJW0EfBlHKrWcVS3wbd129caAYwuH2grJD3+QPej+K2dXA9/6tZdpNjOGhroLJV00rhTXdiekBavTyser
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:4e5a:: with SMTP id
 o26mr12723575pgl.272.1643051705702; Mon, 24 Jan 2022 11:15:05 -0800 (PST)
Date:   Mon, 24 Jan 2022 11:15:03 -0800
In-Reply-To: <7ce3dc60f93d5154943a63f1c09345bd47fbc7c9.1641320129.git.me@ttaylorr.com>
Message-Id: <20220124191503.2447008-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <7ce3dc60f93d5154943a63f1c09345bd47fbc7c9.1641320129.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v3 7/9] t/lib-bitmap.sh: parameterize tests over reverse
 index source
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> To prepare for reading the reverse index data out of the MIDX itself,
> teach the `test_rev_exists` function to take an expected "source" for
> the reverse index data.

Thanks - up to here looks good. Thanks especially for patch 6, which was easy
to verify using "--color-moved --color-moved-ws=allow-indentation-change".

> diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
> index 48a8730a13..77b5f46a03 100644
> --- a/t/lib-bitmap.sh
> +++ b/t/lib-bitmap.sh
> @@ -275,17 +275,23 @@ midx_pack_source () {
>  
>  test_rev_exists () {
>  	commit="$1"
> +	kind="$2"
>  
>  	test_expect_success 'reverse index exists' '

To make it easier to understand test failures, we should probably
include "kind" in the name of the test case.

In a separate commit after this one, we should do it for the other
blocks.
