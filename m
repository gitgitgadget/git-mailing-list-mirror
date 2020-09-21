Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5FC43466
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 16:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DEE20739
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 16:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rk7OapYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgIUQQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:16:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52909 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgIUQP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 12:15:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7477F9E90;
        Mon, 21 Sep 2020 12:15:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hFSDwsnyI9MoUXKDxaKF1WHhdcg=; b=rk7Oap
        YGqQAYwKQwAZmGXq8G4j/kbs4cePTYUP0rth4akgwVr+UQvaLv/AXEZ8YazN2zcV
        GWWCIpVHaHsgu/aQy65hWN42emIcgyLzgKKjvyhpb9S9efIGgaT3GQKuJjaXKqFi
        qGwmynyW5fYERoZ7nSGuELk8onAVHjMYSqxm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wop7cGSDOrf5xGR0u2WDwiLhMhDaOfow
        K4ZQThiurTAxy863X177MF+wuY0QKmk+MxqX0msnl0OumKXjQmNIcGMcsNpM7C5R
        cC2hf0P6t5OA2u1shzFW5KXNS/SmGz+xrlyiynk7IBG5sYP+AqxEdJVnHphC4wE1
        45VaHb/YCyw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FF23F9E8F;
        Mon, 21 Sep 2020 12:15:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DFB0EF9E8D;
        Mon, 21 Sep 2020 12:15:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/3] commit: add an option to reword the last commit
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 09:15:51 -0700
In-Reply-To: <pull.736.git.1600695050.gitgitgadget@gmail.com> (Phillip Wood
        via GitGitGadget's message of "Mon, 21 Sep 2020 13:30:47 +0000")
Message-ID: <xmqqr1qvf6mg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8999FBE-FC25-11EA-8B57-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> If one notices a typo in the last commit after starting to stage changes for
> the next commit it is useful to be able to reword the last commit without
> changing its contents. Currently the way to do that is by specifying --amend
> --only with no pathspec which is not that obvious to new users (so much so
> that before beb635ca9c ("commit: remove 'Clever' message for --only
> --amend", 2016-12-09) commit printed a message to congratulate the user on
> figuring out how to do it).

;-)

"git commit --only --amend" could already be read as an instruction
that "I am only amending without changing anything else", but I
agree that the new --reword verb is a good addition.

The only comment I had on the series was that the mutual-exclusivity
logic looked a bit fragile against feature evolution of the command,
but I have no concrete suggestion to make it more robust against
time.

