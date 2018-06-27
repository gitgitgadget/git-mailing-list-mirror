Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3A81F516
	for <e@80x24.org>; Wed, 27 Jun 2018 16:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965237AbeF0Qor (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 12:44:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56097 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeF0Qoq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 12:44:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC329F0340;
        Wed, 27 Jun 2018 12:44:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=mhyYrOo+433DNC3cuxzSNtEFjbI=; b=K2H9j3V
        yUrSRRg+aeYTRget9eWVzxqJ4b+t+3Glf9y6KZwqKq2eo8oZVi270n9DBSQ5dhzq
        M0goLfiD96sogE+GyhKTTtMiBkO6YdjppC/qm6BWW5Tr3fbbxzXhntxFxK9UQ24S
        0ujk5Swv3Wn1D3TMnJyxwqPR+rgTD04Hk+CU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=pFCbYc8UlLJi7R34ygDOAsqaaWy57luTX
        kihqujNSbLGuEeqYHJFeuid1ft989CtKN4kw1d5LlCtGJJJ2+rW57U1Ee+oAx9Ns
        nEoIh6WWwIATluloCzCv2lUHVCPSJ1TS0MVGs/Q+TjFd1SbEtB8o5Xj1Oquy1gPb
        fcu7mIpTDM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2CD5F033F;
        Wed, 27 Jun 2018 12:44:45 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45A25F033E;
        Wed, 27 Jun 2018 12:44:45 -0400 (EDT)
Date:   Wed, 27 Jun 2018 12:44:43 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated
 docs
Message-ID: <20180627164443.GK20217@zaya.teonanacatl.net>
References: <20180627045637.13818-1-tmz@pobox.com>
 <20180627141430.GA13904@sigill.intra.peff.net>
 <20180627150352.GJ20217@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627150352.GJ20217@zaya.teonanacatl.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 65B2A9CE-7A29-11E8-9011-40570C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote:
> Jeff King wrote:
>>      (Related, there's a build target in the local Makefile for using
>>      asciidoctor; does it need updated, too?)
> 
> I didn't test asciidoctor specficially, but it also respects
> the ASCIIDOC_EXTRA parameters, so I think it will work just
> as well.  I'll try to confirm that later today.

Testing confirmed that asciidoctor works fine with this as
well.

Somewhat tangentially, I looked at using asciidoctor for the
Fedora packages last year and one issue that kept me from
using it then was the '[FIXME: source]' it includes in the
footer of the manpage.  When I dug into it at the time, it
appeared this was due to no <refmiscinfo> declaration
(similarly missing for manual, and version).  It wasn't
clear whether it was possible to include a custom header
template in plain asciidoctor.  I got the impression that it
would require using a custom backend, which in turn required
the rubygem 'tilt' for processing.

I spent about an hour poking around with it and decided that
I'd put off building with asciidoctor until that was fixed.
I felt that displaying '[FIXME: source]' wass worse than
simply not including the version.

It's always possible that I was doing something wrong in my
use of asciidoctor (I just set USE_ASCIIDOCTOR).  Or maybe
the Fedora packages are missing some dependency which I
missed.

It might also be that we need some adjustments similar to
https://patchwork.kernel.org/patch/10360207/ to get the
mansource attribute passed on to asciidoctor.  I only just
ran across that patch and haven't had a chance to test
sometime similar in the git manpage build.  That looks
promising though.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Why is it that we rejoice at a birth and grieve at a funeral?  It is
because we are not the person involved.
    -- Mark Twain

