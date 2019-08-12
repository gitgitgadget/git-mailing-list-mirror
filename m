Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E620D1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 00:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfHLAjP (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 20:39:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58545 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLAjO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 20:39:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9614277459;
        Sun, 11 Aug 2019 20:39:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7kWJFvjjBuz63rv+67IEVixPE5M=; b=VVmAvE
        1IfMQ47jMrsYZPMubI5fWl6C5mYcOto8RtSdjTHZ2v5LTqhdD6V5NRdniRoQ1Ljf
        MUdbPL1dq6exVN+voJYr8ZXJLlovR5ApSEo4hdUn9W10hbZ4uR5Tfjvu64T1n7Y7
        1TzgLkEkoBs4Fi5aafqFVM3WD9HZLmyFLviaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G+VhAmf8LBcrl3dmyzj2KKHf2+oEcrBO
        3YHI5OmcH9inwdVzMBLMIlbZ7wW3KjiS9rGYkgqXROo3IpecJS+Wb8EIsAVSrx0C
        qa2+Yc1HZH7Qn4D5bsN8KlP7nJpxN4QaWLqJeACtv2lzMZkdsiRUra7Sx4nXBS3/
        Rx5NR47nsXg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B11877458;
        Sun, 11 Aug 2019 20:39:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 92B5E77457;
        Sun, 11 Aug 2019 20:39:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phil Hord <phil.hord@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
        <20190809001315.GA87896@syl.lan>
        <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
        <001e01d54ebb$9a1ab4b0$ce501e10$@nexbridge.com>
        <20190809162900.GA9094@sigill.intra.peff.net>
        <xmqq36iadygk.fsf@gitster-ct.c.googlers.com>
        <CABURp0pb4QY+Qbvn6YAtQ=bevSQW+vQXFMChyd_phtUK4P5M7w@mail.gmail.com>
        <20190810061006.GB25876@sigill.intra.peff.net>
Date:   Sun, 11 Aug 2019 17:39:07 -0700
In-Reply-To: <20190810061006.GB25876@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 10 Aug 2019 02:10:07 -0400")
Message-ID: <xmqqwofjb4k4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 991A61C2-BC99-11E9-9E25-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> IMHO scripting around "action" commands like checkout is less bad than
> around "output" commands like log. The general action of "switch to this
> branch" is unlikely to be changed much over the years (or via config),
> but the output of log, etc, is.
>
> There are no guarantees, of course, but I imagine that the tradeoff in
> simplicity of using git-switch versus manually reimplementing it is
> probably a good one for many scripts.

Another reason why scripting around "action" may be OK is that most
of the time scriptors would want to (blindly) adopt improvements
made to the underly ing command anyway.  If you scripted around "git
checkout" before we introduced multiple worktree feature where a
branch that is already active in another worktree is protected from
getting checked out elsewhere, your script will automatically get
that protection (and more importantly, the error message given as an
explanation to the end users) for free.  Of course your script must
be prepared to react correctly to a failure from "git checkout", but
that goes without saying for any command you invoke in your script.

