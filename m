Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDE8D20A40
	for <e@80x24.org>; Sun,  3 Dec 2017 02:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbdLCChr (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 21:37:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52125 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751878AbdLCChq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 21:37:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38FBAB4B4C;
        Sat,  2 Dec 2017 21:37:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PgSKXkuYWFOF5hU7RaxdDI22jUQ=; b=jcpjKc
        t2+bb7UROPPkq4oDJ4Y3B+wrW/DqAVdLezivPMNmds8S3B1xxrx6WH61fokJUq2x
        hZHy+HVlBJytdKgxYB0wDouBzLDSeDMaDp9MC5YmMA+mAZYo6t5LWbzOGfhKV3BR
        B5YyNzkQHw2maDR/oAaHoFwfrEYMq61rzBkrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JhOJeja8isvyaW/+Mgwl5Sjwewu+3olG
        RU/488BHBYhPBNTUf/QzYdAzT9Au4JFa8l1Cm+nwIp8Z2YhPJ1A4Cb2VdK9sJ9Rk
        mRkTLpGBjp/77nc4GvtsETnIXESG241k7blILUiRc13tFN14kzhhRQNeemm7Uw9Y
        5+Y5lBKt4dY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30872B4B4B;
        Sat,  2 Dec 2017 21:37:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B26DB4B49;
        Sat,  2 Dec 2017 21:37:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>,
        <git@vger.kernel.org>
Subject: Re: bug deleting "unmerged" branch (2.12.3)
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de>
        <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de>
        <xmqqtvxd6gu9.fsf@gitster.mtv.corp.google.com>
        <5A1E70AA020000A100029175@gwsmtp1.uni-regensburg.de>
        <7973FF5C21C64E6492828DD0B91F5AF7@PhilipOakley>
Date:   Sat, 02 Dec 2017 18:37:44 -0800
In-Reply-To: <7973FF5C21C64E6492828DD0B91F5AF7@PhilipOakley> (Philip Oakley's
        message of "Sat, 2 Dec 2017 20:56:44 -0000")
Message-ID: <xmqq1skcleo7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F19918A0-D7D2-11E7-BD34-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> I think it was that currently you are on M, and neither A nor B are
> ancestors (i.e. merged) of M.
>
> As Junio said:- "branch -d" protects branches that are yet to be
> merged to the **current branch**.

Actually, I think people loosened this over time and removal of
branch X is not rejected even if the range HEAD..X is not empty, as
long as X is marked to integrate with/build on something else with
branch.X.{remote,merge} and the range X@{upstream}..X is empty.

So the stress of "current branch" above you added is a bit of a
white lie.
