Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78518C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 09:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570A161260
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 09:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhKKJTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 04:19:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:57382 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhKKJTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 04:19:45 -0500
Received: (qmail 32514 invoked by uid 109); 11 Nov 2021 09:16:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Nov 2021 09:16:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27382 invoked by uid 111); 11 Nov 2021 09:16:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Nov 2021 04:16:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Nov 2021 04:16:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, fs@gigacodes.de
Subject: Re: [PATCH] RelNotes: mention known crasher when ssh signing with
 OpenSSH 8.7
Message-ID: <YYzfhKt7SRT9p8Df@coredump.intra.peff.net>
References: <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
 <20211110093912.4382-1-carenas@gmail.com>
 <xmqqczn7y9kh.fsf@gitster.g>
 <xmqqmtmbwtim.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtmbwtim.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 02:11:29PM -0800, Junio C Hamano wrote:

> >> diff --git a/Documentation/RelNotes/2.34.0.txt b/Documentation/RelNotes/2.34.0.txt
> >> index effab2ea4b..54dcc7240d 100644
> >> --- a/Documentation/RelNotes/2.34.0.txt
> >> +++ b/Documentation/RelNotes/2.34.0.txt
> >> @@ -8,6 +8,9 @@ Backward compatibility notes
> >>  
> >>   * The "--preserve-merges" option of "git rebase" has been removed.
> >>  
> >> + * The upcoming ssh signing feature is broken if used together with
> >> +   OpenSSH 8.7, avoid using it if you cannot update to OpenSSH 8.8
> >> +   (or stay at 8.6)
> >
> > That may be correct, but it is NOT a backward compatibility note.
> 
> So, here is what I plan to do.
> 
> diff --git c/Documentation/RelNotes/2.34.0.txt w/Documentation/RelNotes/2.34.0.txt
> index effab2ea4b..6ed8b92e10 100644
> --- c/Documentation/RelNotes/2.34.0.txt
> +++ w/Documentation/RelNotes/2.34.0.txt
> @@ -77,7 +77,10 @@ UI, Workflows & Features
>   * "git fsck" has been taught to report mismatch between expected and
>     actual types of an object better.
>  
> - * Use ssh public crypto for object and push-cert signing.
> + * In addition to GnuPG, ssh public crypto can be used for object and
> +   push-cert signing.  Note that this feature cannot be used with
> +   ssh-keygen from OpenSSH 8.7, whose support for it is broken.  Avoid
> +   using it unless you update to OpenSSH 8.8.

Attaching to the existing gpg-ssh release note like this makes perfect
sense to me. Thanks for tying this one up.

-Peff
