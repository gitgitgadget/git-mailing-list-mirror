Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D4EC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 04:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKCEdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 00:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiKCEd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 00:33:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525CB1834D
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 21:32:59 -0700 (PDT)
Received: (qmail 12845 invoked by uid 109); 3 Nov 2022 04:32:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Nov 2022 04:32:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14129 invoked by uid 111); 3 Nov 2022 04:33:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Nov 2022 00:33:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Nov 2022 00:32:57 -0400
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Martin Englund <martin@englund.nu>, git@vger.kernel.org
Subject: Re: Git Bug Report: out of memory using git tag
Message-ID: <Y2NEeWwnfHnIbNl8@coredump.intra.peff.net>
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
 <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
 <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
 <49e1eec2-0567-f75e-7d0d-0f2d00ac472c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49e1eec2-0567-f75e-7d0d-0f2d00ac472c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 08:13:27AM -0400, Philippe Blain wrote:

> >   [1/2]: ref-filter: fix parsing of signatures without blank lines
> >   [2/2]: ref-filter: fix parsing of signatures with CRLF and no body
> [...]
> One thing I think that is not mentioned in your commit messages is that 1/2
> would also apply to a CRLF-using tag with no blank lines, i.e.
> 
>   this is the subject^M
>   -----BEGIN PGP SIGNATURE-----^M
>   ...some stuff...^M
>   -----END PGP SIGNATURE-----^M
> 
> Parsing this tag correctly is fixed by 1/2, right?

Right. Because there's no blank line to find, neither the "\n\n" nor the
"\r\n\r\n" strstr matches, so it is essentially the same case. The fact
that the other non-blank lines are CRLF doesn't matter for this part of
the code. :)

> Anyway thanks again for the fixes,

No problem!

-Peff
