Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E76C678D4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 09:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCFJZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 04:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFJZz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 04:25:55 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09FB20D37
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 01:25:53 -0800 (PST)
Received: (qmail 5752 invoked by uid 109); 6 Mar 2023 09:25:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Mar 2023 09:25:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28069 invoked by uid 111); 6 Mar 2023 09:25:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Mar 2023 04:25:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Mar 2023 04:25:52 -0500
From:   Jeff King <peff@peff.net>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Henry <git@drmikehenry.com>
Subject: Re: [RFC/PATCH] bundle: turn on --all-progress-implied by default
Message-ID: <ZAWxoAd7vOcDqUCL@coredump.intra.peff.net>
References: <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
 <xmqqv8jhcvrq.fsf@gitster.g>
 <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
 <xmqqpm9pcu6t.fsf@gitster.g>
 <ZAKexHiit5vOmv7M@coredump.intra.peff.net>
 <ZAKi8MzGWk5PZUJk@coredump.intra.peff.net>
 <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
 <ZAMjkffYmp+DNmr+@coredump.intra.peff.net>
 <robbat2-20230306T033734-620860556Z@orbis-terrarum.net>
 <ZAV8XW34CjUy5RyF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAV8XW34CjUy5RyF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 12:38:38AM -0500, Jeff King wrote:

> @@ -612,4 +613,10 @@ test_expect_success 'bundle progress includes write phase' '
>  	grep 'Writing' err
>  '
>  
> +test_expect_success TTY '--quiet disables all bundle progress' '
> +	test_terminal env GIT_PROGRESS_DELAY=0 \
> +		git bundle --quiet create out.bundle --all 2>err &&
> +	test_must_be_empty err
> +'

Err, this should be "create --quiet", of course, not the other way
around. I did run it before sending, but I removed the "--quiet" to
double-check that it generates progress with test_terminal. But then
added it back in to the wrong spot. :-/

-Peff
