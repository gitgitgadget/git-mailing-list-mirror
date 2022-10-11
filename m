Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C85C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJKA2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJKA2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:28:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660BD5F7D8
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:28:28 -0700 (PDT)
Received: (qmail 29736 invoked by uid 109); 11 Oct 2022 00:28:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:28:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15281 invoked by uid 111); 11 Oct 2022 00:28:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:28:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:28:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] ci: add address and undefined sanitizer tasks
Message-ID: <Y0S4q/GBlTcK6Y1R@coredump.intra.peff.net>
References: <xmqq8rlo62ih.fsf@gitster.g>
 <xmqqpmezxl9p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmezxl9p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 05:21:38PM -0700, Junio C Hamano wrote:

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 831f4df56c..92d27db0b9 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -251,6 +251,9 @@ jobs:
>            - jobname: linux-leaks
>              cc: gcc
>              pool: ubuntu-latest
> +          - jobname: linux-sanitize
> +            cc: gcc
> +            pool: ubuntu-latest
>      env:
>        CC: ${{matrix.vector.cc}}
>        CC_PACKAGE: ${{matrix.vector.cc_package}}
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 1b0cc2b57d..c9c4982e21 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -278,6 +278,9 @@ linux-leaks)
>  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
>  	export GIT_TEST_SANITIZE_LEAK_LOG=true
>  	;;
> +linux-sanitize)
> +	export SANITIZE=address,undefined
> +	;;

Looks fine to me (and I obviously endorse the goal :) ).

-Peff
