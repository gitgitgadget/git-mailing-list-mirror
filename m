Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA89CC48BDF
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 01:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CBA6138C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 01:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhFNB2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 21:28:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61304 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhFNB2O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 21:28:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F29D5D720D;
        Sun, 13 Jun 2021 21:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AywggCddhdHUf1AdAUjo0sTgZM3wn6kE74olOA
        UtDwc=; b=M00j4WvN7UsXAauf8cDXmXS6lTXi/fASrXMRkrpLzH2M95JtvXpB+n
        7eoLr3ckGvJZxEEjhfdTBPTblo7vUHsARU0lNQeE7Tv5Oxw5HMFChso62OCmCMty
        7ybhlhahVGyVA6u7Spyco1lScOi+OEW5sDi1wbtfPTgL9zPTeCHDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8FEBD7208;
        Sun, 13 Jun 2021 21:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71541D7207;
        Sun, 13 Jun 2021 21:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phil Hord <phil.hord@gmail.com>,
        Timothy Madden <terminatorul@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: Wrong tabs in terminal output for git diff
References: <8d3f8cf4-24ec-1271-ccd3-70db24f53523@gmail.com>
        <CABURp0pUDtKEDcFx+Yh3hZRXnHOzUxiOEU=epBz3SB1O5e2HqA@mail.gmail.com>
        <YMWD6G14YxfM1uE6@coredump.intra.peff.net>
Date:   Mon, 14 Jun 2021 10:26:10 +0900
In-Reply-To: <YMWD6G14YxfM1uE6@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 13 Jun 2021 00:04:56 -0400")
Message-ID: <xmqqa6nt1bkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80A86260-CCAF-11EB-87EC-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We do have a few "display only" modes. You mentioned --color-words, but
> --textconv is similar (and of course --ext-diff can generate whatever it
> wants). I'm not sure how helpful that is, though, because humans end up
> needing to look at "real" diffs that can be applied often enough (and as
> you note, changing those would break them).

Add "--irreversible-delete" to the set.  We should perhaps find a
migration path to eventually disable these "display only" things in
format-patch [*1*], if we do not already do so.

> This could be addressed at the viewing layer, though, which is what's
> converting the tabstops to screen positions. For example, "less -x9,17"
> adjusts the tab stops in the pager to account for the extra leading
> character (and you can put it into $LESS or $GIT_PAGER to have it kick
> in automatically).

That's a cute one (and can be used not just on "git diff" output but
on output from "diff" by other people).

Thanks.


[References]

*1* https://lore.kernel.org/git/7vsj8dcdv6.fsf@alter.siamese.dyndns.org/

