Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1201F461
	for <e@80x24.org>; Mon,  2 Sep 2019 19:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfIBTZo (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 15:25:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59600 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfIBTZo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 15:25:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 390E68C45B;
        Mon,  2 Sep 2019 15:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vccI2O5Ic8eGmO+znRPpbgl437w=; b=rJsnF3
        Qzu6JyoDmcLhdQ+xmGTWsLjdsUqPGQo2vpkCzvNhF5rrm6AH6E76pnsdG/TmM2Xx
        ch1RuEcU30SPM3/B1gNiwPDfvT1x5CULqHy7uzF1bnwv5QJ5Y6SuOhQZrcs2xSqq
        mGZwJzHwldtjHmHx6BZ4hzRkKU2M8m9zmb9G4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kZUIvb0AKdhWeuyB9cHX8WXnSby+o5Qa
        7Gc+0ZcFNWRRq+l39ybC9lSGJhY0LsjBlI4csDul5pzrG16xMpHxNiuAj7vR9/Q4
        KPZLwZWx1IrA/okeZDlTSrX28QNrA1G7wsUIhlyoxHOYMqU4ykzGlD8F0rFn/tvf
        ZsTPWSk3wr4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30B3D8C45A;
        Mon,  2 Sep 2019 15:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B38E8C459;
        Mon,  2 Sep 2019 15:25:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Giuseppe =?utf-8?Q?Crin=C3=B2?= <giuscri@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
References: <20190828145640.GC14432@sigill.intra.peff.net>
        <20190826191455.GA25695@sigill.intra.peff.net>
        <20190831131748.GA13001@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
        <20190902154732.GD18593@sigill.intra.peff.net>
Date:   Mon, 02 Sep 2019 12:25:37 -0700
In-Reply-To: <20190902154732.GD18593@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 2 Sep 2019 11:47:33 -0400")
Message-ID: <xmqq1rwyv6tq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 726BE04E-CDB7-11E9-89F8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But it still risks losing a case where some code path relies on the crud
> cleanup for odd cases (mismatched delimiters, or interleaved delimiters,
> or non-delimiter crud mixed in with delimiters).
> ...
> So I dunno. There is no patch to be discussed, and I am not volunteering
> to write one.  So I think whoever chooses to do so has a lot of control
> over what is proposed. :)

Rather, they can propose what they want, but they have a lot of
tough defending to do on their choice.  Lack of potential harm is
much harder to prove than coming up with a single example that
harms.

I'd rather leave the sleeping dog lie, if we need to encourage
people to live in 21st century and step outside US-ASCII to do so,
then do that instead.
