Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807A6C6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 00:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIMAQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 20:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIMAQU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 20:16:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1152343605
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:16:19 -0700 (PDT)
Received: (qmail 29416 invoked by uid 109); 13 Sep 2022 00:16:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Sep 2022 00:16:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19636 invoked by uid 111); 13 Sep 2022 00:16:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Sep 2022 20:16:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Sep 2022 20:16:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] chainlint: colorize problem annotations and test
 delimiters
Message-ID: <Yx/L0vWlMOyLhtjJ@coredump.intra.peff.net>
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
 <xmqqsfkwb12i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfkwb12i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 04:55:01PM -0700, Junio C Hamano wrote:

> "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > +	$checked =~ s/(\?![^?]+\?!)/$c->{bold}$c->{red}$1$c->{reset}/mg;
> 
> It may be just me, but coloring the whole "?!LOOP?!" in red feels a
> bit strange.  I would have expected more like
> 
> 	if ($c->{color_in_use}) {
> 		$checked =~ s/\?!([^?]+)\?!/$c->{bold}$c->{red}$1$c->{reset}/mg;
> 	}
> 
> IOW, switching between "?!LOOP?!" and "<BOLD><RED>LOOP<RESET>".
> 
> But it may be just me.

Having seen the output in the wild (or at least on the example which I
found hard to read originally), I kind of like the "?!" being retained
even in the color version. It really makes things stand out.

-Peff
