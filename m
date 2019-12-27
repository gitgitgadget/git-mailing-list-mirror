Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19F1C2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 20:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA82320740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 20:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfL0UUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 15:20:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34364 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfL0UUX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 15:20:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id c127so7475924wme.1
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 12:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLxIo1u5MEhcdFMfXYyICfBJ1Zyi4ix5hay58yIt0uM=;
        b=txkqNuZg5oiRa6oyp0KOHHUif2sfEtKmOOqBHgvEq2tf+7BrfBA5vOoQS7UD3eoenI
         xMTCjqd0Z/JOEfz05naVjpp6R5a9v9crLdX2W9mzc94CI4BXXJ06HuYWRGmDu/p4RLrk
         LBvmVQsYqacESeu8IyVFbAgwsm9VHACvjTGGzPXO0V7Oa2PG0LgjipvQFh9T6EfzlVQZ
         His8pa9/fri3Snb+LXuzA7FFXs3jKRXt5SAduicYJ3IFf5OTm5BRvhJPi36Yrdlvd5jT
         vJaP/fg8dcRlz3zT6Lj6ScBxx2rjqUkOjmzykZvCFNj910GtqwQ9NawVhHqkWcsrUxQ2
         eLSw==
X-Gm-Message-State: APjAAAWjHfwHF0bnDsCvyu+LUkXfB8klcqkap5aTdVB/RyhEhguaeRQ0
        nqPrOp9YPOJtsdMIB34tAQ9Z+QTEeUnsUftUDVc=
X-Google-Smtp-Source: APXvYqwTPrwEcerjgPSPlsp09LZiaKFkc+CBV9ZnzBqOInpdSk3PkJR1Sv1UIiJsMgxDNGkKU3LG4bzL3YrY1el2vRQ=
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr19978460wma.84.1577478020779;
 Fri, 27 Dec 2019 12:20:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
 <pull.500.v2.git.1577472469.gitgitgadget@gmail.com> <331bb7d6fbec6f2f429feb36cf32e0931307ae0b.1577472469.git.gitgitgadget@gmail.com>
In-Reply-To: <331bb7d6fbec6f2f429feb36cf32e0931307ae0b.1577472469.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Dec 2019 15:20:09 -0500
Message-ID: <CAPig+cTvFW_84TqKsOPjjBM37cX1OL9uX15APcEYpuKVjvM+dg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sparse-checkout: document interactions with submodules
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jon Simons <jon@jonsimons.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 1:48 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> @@ -340,4 +340,32 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
> +test_expect_success 'interaction with submodules' '
> +       ...
> +       cat >expect <<-EOF &&
> +               a
> +               folder1
> +               modules
> +       EOF

You would normally use \-EOF rather than -EOF to make it clear that no
interpolation is needed/expected within the here-doc body. However,
this script is already full of -EOF when \-EOF ought to be used, so
being consistent with existing tests may override an objection.

Likewise, please note for future reference that the usual way
here-docs are formatted in Git test scripts is to indent the body of
the here-doc to the same level as the command which opens it. That is:

    cat >expect <<\-EOF &&
    a
    folder1
    modules
    EOF

But, again, this script is already full of these malformatted
here-docs, so maintaining consistency with the existing test in the
script is probably okay.

(Of course, a preparatory patch fixing these here-doc issues would be
welcome, but might also be outside the scope of this submission. And,
fixing these very minor issues is quite low-priority, so I wouldn't
expect or demand it.)
