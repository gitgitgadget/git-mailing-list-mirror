Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BB2E8FDAF
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbjJCUHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjJCUHD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:07:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0E2A1
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:07:00 -0700 (PDT)
Received: (qmail 14374 invoked by uid 109); 3 Oct 2023 20:07:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:07:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14341 invoked by uid 111); 3 Oct 2023 20:07:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:07:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:06:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] doc/cat-file: clarify description regarding various
 command forms
Message-ID: <20231003200659.GC1562@coredump.intra.peff.net>
References: <20231003082513.3003520-1-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003082513.3003520-1-stepnem@smrk.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 10:25:13AM +0200, Štěpán Němec wrote:

> The DESCRIPTION's "first form" is actually the 1st, 2nd, 3rd and 5th
> form in SYNOPSIS, the "second form" is the 4th one.
> 
> Interestingly, this state of affairs was introduced in
> 97fe7250753b (cat-file docs: fix SYNOPSIS and "-h" output, 2021-12-28)
> with the claim of "Now the two will match again." ("the two" being
> DESCRIPTION and SYNOPSIS)...
> 
> Ordinals are hard, let's try talking about batch and non-batch mode
> instead.

Thanks, I think this is a good direction. Two things I noticed:

>  DESCRIPTION
>  -----------
> -In its first form, the command provides the content or the type of an object in
> +This command can operate in two modes, depending on whether an option from
> +the `--batch` family is specified.
> +
> +In non-batch mode, the command provides the content or the type of an object in
>  the repository. The type is required unless `-t` or `-p` is used to find the
>  object type, or `-s` is used to find the object size, or `--textconv` or
>  `--filters` is used (which imply type "blob").

The existing text here is already a bit vague, considering the number of
operations it covers (like "-e", for example, which is not showing "the
content or the type" at all). But that is not new in your patch, and it
is maybe even OK to be a bit vague here, and let the OPTIONS section
cover the specifics.

> -In the second form, a list of objects (separated by linefeeds) is provided on
> +In batch mode, a list of objects (separated by linefeeds) is provided on
>  stdin, and the SHA-1, type, and size of each object is printed on stdout. The
>  output format can be overridden using the optional `<format>` argument. If
>  either `--textconv` or `--filters` was specified, the input is expected to

I think this got a bit inaccurate with "--batch-command", which is a
whole different mode itself compared to --batch and --batch-check. I
don't think your patch is really making anything worse, but arguably
there are three "major modes" here.

-Peff
