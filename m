Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D3C81FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 17:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbcK1RGN (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 12:06:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50293 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932495AbcK1RGL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 12:06:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1472353735;
        Mon, 28 Nov 2016 12:06:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mUQwmmXXN5Sr5na0UvBLfXBYb+M=; b=smFjWP
        AwZFs2zrnSP321maM/8SHAN7cDpP/JKOsEt4N9QURzhD3GK7OMacCxZeimqBZ4rM
        9m1U0yIrdPHdIKcq53//P2H3iu5+/2/18Hibbomoa4KUF2egoMWvmdj9iupx2/sV
        ehvAHB7vYpXUKPcvN+rvP6ioq0vZeJWvYQ+IE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GnTB2AJvLcINncH5LWSbobtKwl7As63h
        R+gCT46S3/dwm/a9lVX3jIxb+h7T9fY4MoLv0/Zs4Zqk9IoHjs/A3uQGvqlc7yoC
        i233xlJzmDmUZpuvJbNG0lb0Zt5RPo4NAyUee+9Fqp55vqKCIsdAckpx67l8Qh/j
        7gQqlBeIpuk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01C3A53734;
        Mon, 28 Nov 2016 12:06:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 247F953731;
        Mon, 28 Nov 2016 12:06:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611242211450.117539@virtualbox>
        <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611251201580.117539@virtualbox>
        <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611251841030.117539@virtualbox>
        <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611261320050.117539@virtualbox>
        <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611261400300.117539@virtualbox>
        <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net>
Date:   Mon, 28 Nov 2016 09:06:02 -0800
In-Reply-To: <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 27 Nov 2016 11:50:59 -0500")
Message-ID: <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F20BB928-B58C-11E6-AE57-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Nov 26, 2016 at 02:01:36PM +0100, Johannes Schindelin wrote:
>
>> > If you want to control it from outside the test script, you'd need
>> > something like:
>> > 
>> >   if test "$GIT_TEST_DIFFTOOL" = "builtin"
>> 
>> That is a bit magic. I first used "GIT_USE_BUILTIN_DIFFTOOL" and it did
>> not work. My name is arguably more correct (see also Jakub's note about
>> "naming is hard"), but yours works because there is a "TEST" substring in
>> it.
>
> Yes. You are free to add an exception to the env list in test-lib.sh,
> but we usually use GIT_TEST_* to avoid having to do so.

Perhaps

 - The switch between "do I use builtin, or scripted?" mechanism in
   1/2 can look at an environment (just like the old "am" rewrite
   series did), instead of configuration.  This would make the code
   a lot more simppler (you do not have to worry about the
   interaction between "setup" and .git/config).

 - That environment variable can be named GIT_TEST_BUILTIN_DIFFTOOL;
   after all, people are opting into helping to test the new shiny
   to make/prove it ready sooner.

 - The bulk of the existing test for difftool can be moved to a
   dot-included file (in a way similar to t/annotate-tests are
   usable to test both annotate and blame-imitating-annotate).
   Existing PERL prerequisites can all be lost.

 - Two tests can include that dot-included file; one would
   explicitly unset that environment (and gives up without PERL
   prerequisite), while the other explicitly sets it.

