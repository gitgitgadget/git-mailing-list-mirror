Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B854C20D09
	for <e@80x24.org>; Mon, 17 Apr 2017 00:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757027AbdDQAlL (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 20:41:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58307 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756977AbdDQAlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 20:41:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 609A78A9E3;
        Sun, 16 Apr 2017 20:41:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xr5p9KZP/LnRy7WdLph2Ys4T1X4=; b=DFwnId
        Dw2Ee0su6Ka3zGHFt1yc39q5sZZgvfwLSdjsO9uw98JDaf3bcdUJae1Jcc4e9gqM
        TA+GCij/ox43DYyxLg/Ta+uZvj+Oly7UjCCFfKvWvp05s41UzYVp9Ic149Wl9KqO
        /vftqaQEwYRAyaGQB9FlcUxF/41U5zwjiEvis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jw6vHANHqoHHxR6fNxU+GcqhhNya38Ls
        3fKwHWALf7RdbTysr0fD3X0p20My/oLJU6Nrr571YvOUuIDg11fDdp6P7JjKQMtZ
        J/XCX71xuGZejKn6xRSWKO+YCKsWWVQadKNy5ByRhcnBqw2ndDSZr13OywhZtmQ2
        Rg1ajwsPUBI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 587D38A9E2;
        Sun, 16 Apr 2017 20:41:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB08F8A9E1;
        Sun, 16 Apr 2017 20:41:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Danny Sauer <danny@dannysauer.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
References: <alpine.DEB.2.20.1704091238560.4268@virtualbox>
        <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com>
        <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
        <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
        <20170410171352.s7r7tzheadxjlulw@sigill.intra.peff.net>
        <CACsJy8B8osxd-0axJ9giaMYKuict2h1zW8TcYYuRFGXfBbdF0A@mail.gmail.com>
        <xmqqy3v6ow54.fsf@gitster.mtv.corp.google.com>
        <CACsJy8DPFzgxqvPzpMbmoM4sMP7oSZ=eO6DJa+dv4sY=QKHjoA@mail.gmail.com>
        <20170412130145.jjnyait5234qsmys@sigill.intra.peff.net>
        <CACsJy8BbHDsk4qLhVA=0QJFPutcGJpGwWrjs0_DiscDM9Q9+pw@mail.gmail.com>
        <20170413212909.eb7zrhs7rzk6nxl6@sigill.intra.peff.net>
Date:   Sun, 16 Apr 2017 17:41:06 -0700
In-Reply-To: <20170413212909.eb7zrhs7rzk6nxl6@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Apr 2017 17:29:10 -0400")
Message-ID: <xmqqlgqzlvbx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BA6657E-2306-11E7-A9D6-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> cwd with prefix. I was kinda hoping "super prefix" would solve it, but
>> that one seems designed specifically for submodules.
>
> Ah, right. I think the issue is that "prefix" really serves two uses.
> For things like command-line arguments, we use to find the original path
> after we've moved. But we also use it for "where in the working tree
> are we".
>
> So with an out-of-tree cwd, we'd want to set the first one to the real
> path ("../../whatever" or even just an absolute path), but the second
> one would probably be empty (i.e., just pretend that we started from the
> top-level).
>
> But that would require first refactoring all of the cmd_* functions to
> handle those prefixes separately.

Yes, I am still kinda hoping that the "super prefix" thing will
address the separation of the two uses, though.
