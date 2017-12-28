Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B2A1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 18:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbdL1SzP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 13:55:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58930 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751220AbdL1SzO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 13:55:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E57FCA35A;
        Thu, 28 Dec 2017 13:55:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4QmQvCMpXd0EOoFR1E2X7Jidqv8=; b=GOdGZm
        tk2lxVEzGjPv3aGFsZw00A9BFSoBHlOwWErhdqFVIim7h3PZPWeSv0vw6EVNj5CW
        GcTe2+kscqF408Qb2GSI8fQKrZQSNtb8yO6wivT80rfRGldpF+Wzv4CjjT7dLTs9
        g8bsi+2goRCWwqv+2jct78ad5OLffOkgoQcTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ATv2YfFzu9Mr6em6Wvjz/p+BgvwkE348
        Ll0dPKBJlSti6dSGbEXAo57m/ZdtaN/FzZvX5kehnjvw2BePf5UNJvFi5rTsoLck
        4rKpl3o1hqQVKX4z1mRPOuC2YKPkjKIpYRVFQfdnHlj1QgW5ypMtdKws6ZTaqyxy
        rCH6rsjKr8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24BF0CA359;
        Thu, 28 Dec 2017 13:55:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BACACA358;
        Thu, 28 Dec 2017 13:55:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 8/9] rebase -i: learn to abbreviate command names
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171203221721.16462-1-liambeguin@gmail.com>
        <20171203221721.16462-9-liambeguin@gmail.com>
        <CACsJy8B3U0_sJeEt+gLy9HJKszO5-uRZsssL3ZFdkKbSM9yWDg@mail.gmail.com>
        <xmqqmv24m186.fsf@gitster.mtv.corp.google.com>
        <CAKm4OoVMRd-ZkaB9Z8Mxnavfy077=LifJq9OEeg-mvjEGz4K6A@mail.gmail.com>
Date:   Thu, 28 Dec 2017 10:55:12 -0800
In-Reply-To: <CAKm4OoVMRd-ZkaB9Z8Mxnavfy077=LifJq9OEeg-mvjEGz4K6A@mail.gmail.com>
        (Liam Beguin's message of "Wed, 27 Dec 2017 22:58:19 +0100")
Message-ID: <xmqqpo6ylm27.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2FA1450-EC00-11E7-8799-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liam Beguin <liambeguin@gmail.com> writes:

> Since this came up, would it be a good thing to add -Wignored-qualifiers
> to the DEVELOPER flags?

Quite frankly, I am not sure if catching that particular warning
violation buys us much. As a return value from a function is never
an lvalue, what triggers the warning may certainly be an indication
of a sloppy coding, but otherwise I do not see it as diagnosing a
potential error.  "The programmer thought that the returned value
will only be assigned to a const variable and will never be
modified, but the language does not guarantee such a behaviour out
of the caller"---does such an incorrect expectation lead to an error
in the codepath that involves such a function?
