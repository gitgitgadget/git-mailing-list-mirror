Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37201F453
	for <e@80x24.org>; Wed, 24 Apr 2019 02:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfDXCDS (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 22:03:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61659 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfDXCDS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 22:03:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A31613EDBE;
        Tue, 23 Apr 2019 22:03:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=+psRUzrFV5YkKxn9fLxRlNJrjEs=; b=q3vdaAJ
        Ay+y/dX/K7BWHw/Xy6ANJe3/NTWvawcW+TadC0F9Qa5so7mzS2EinWezU4tpUdhP
        5dZ/VPW65Zcfvh2F6S7rD3RMUQj15+r2WQenrHhX/NSXNXzoWv6a5RCncxiVxAXw
        zg2+5BhgVV8Ut//RS1E51mYxhaqPSptCEGBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=Hp4PFryIp4HHIq9KX82adeRGu607bQkCL
        p/EPWyAzo1rULrxY4/x3+CLWs1+jOCziG9pM6nK7zKLChkKtPiJ/kyk7rSlUgMec
        9hJQM+qJ7XY8y5w93jDokLwaNNtt7qsa4Ar0HkgucgjbP5/BCWGKBCKvPMDfmkBW
        6BEbrrJoAQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10E8913EDBD;
        Tue, 23 Apr 2019 22:03:16 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8BBEC13EDBC;
        Tue, 23 Apr 2019 22:03:15 -0400 (EDT)
Date:   Tue, 23 Apr 2019 22:03:13 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc/ls-files: put nested list for "-t" option into block
Message-ID: <20190424020313.GP3654@pobox.com>
References: <20190422151541.GA1633@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422151541.GA1633@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 1F51CDA4-6635-11E9-9D12-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> The description for the "-t" option contains a sub-list of all of the
> possible file status outputs. But because of the newline separating that
> list from the description paragraph, asciidoc treats the sub-list
> entries as a continuation of the overall options list, rather than as
> children of the "-t" description.
> 
> We could fix it by adding a "+" before the sub-list to connect it to the
> rest of the "-t" text. But using a pair of "--" to delimit the block is
> perhaps more readable, and may have better compatibility with
> asciidoctor, as in 39a869b2f2 (Documentation/rev-list-options: wrap
> --date=<format> block with "--", 2019-03-30).
> 
> The extra blank line comes from 5bc0e247c4 (Document ls-files -t as
> semi-obsolete., 2010-07-28), but the problem actually seems older than
> that. Before then, we did:
> 
>   -t:: some text...
>     H:: cached
>     M:: unmerged
>     etc...
> 
> but asciidoc also treats that as one big list. So this problem seems to
> have been around forever.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Junio: I happened to notice this while hunting for "ls-files" options
>        that could make your makefile de-dup patch unnecessary (but
>        didn't find anything).
> 
> Todd: Just an FYI that your "--" strategy is spreading. :)

Heh, cool.  This is an obviously simple fix, but for good
measure I checked the results with asciidoc 8.6.10 as well
as asciidoctor 1.5.6 and 2.0.8.  The output from each of
them looks good.

-- 
Todd
