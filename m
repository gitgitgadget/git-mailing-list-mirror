Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2381F461
	for <e@80x24.org>; Fri, 19 Jul 2019 19:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbfGSTpB (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 15:45:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51667 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfGSTpB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECE91161A55;
        Fri, 19 Jul 2019 15:44:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kt2AKpt7muIXruZIhVKIQeX6/w8=; b=AbtlJg
        NagDNgyRv61RLNxOMn+FtWIk0p6RD3vzAfhTEhflURkrqHqZY0+WXdOiIo9RMNYd
        JAgMFTJXX1BLQTBpKjoKauCeCn9QOcTulMQirSYMYTtdw/taQSly5TkwxbQGFfV1
        TkTZwyunFA/LcrNMd7aaI1AC4F1udh5kSHzXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mifYWtVd5g4zGDLkazGmDYW+ZB++WSFh
        XPCvYWGu1ip9uEBBdvSD8JzHJlnMYyHqpSYSA/W92BE7eBQKAAksrIvSE5Mxz43+
        xfJHGhLX3RoVM6BDyOGUfo4ZdBHJocOxwdiYUT6BN15C5l5aoNqrTlufwY8U0Qdm
        sSYFIlUI9F0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3107161A54;
        Fri, 19 Jul 2019 15:44:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D361161A53;
        Fri, 19 Jul 2019 15:44:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "cclauss via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, cclauss <cclauss@me.com>
Subject: Re: [PATCH 1/1] Travis CI: Lint for Python syntax errors and undefined names
References: <pull.290.git.gitgitgadget@gmail.com>
        <ad1fdb86ae42378d10584deb58115adf11de8ef7.1563545933.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Jul 2019 12:44:57 -0700
In-Reply-To: <ad1fdb86ae42378d10584deb58115adf11de8ef7.1563545933.git.gitgitgadget@gmail.com>
        (cclauss via GitGitGadget's message of "Fri, 19 Jul 2019 07:18:55
        -0700 (PDT)")
Message-ID: <xmqqmuh9vmfa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0A7763E-AA5D-11E9-B12B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"cclauss via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: cclauss <cclauss@me.com>

I'll tweak this line (and your sign-off) to read as "Christian
Clauss <cclauss@me.com>" as you had in your cover letter.

> Several things were changed between Python 2 and Python 3.
> There are a few Python 3 incompatibilities to work on.
> Here we are making changes to make the code run on both Py2 and Py3.
> We are doing this because the end of life of Python 2 is in 167 days.

All sounds sensible, and the above is quite a good problem
description.

> We are using print() function because legacy print statements are syntax
> errors on Py3.
> reduce() was moved in Python 3 and raw_input() was removed so we make
> changes to avoid NameErrors being raised at runtime.
> We are also putting flake8 lint tests in place on Travis CI to avoid
> any backsliding on future pull requests.

Nothing is wrong here, but the convention in our codebase is to
describe the changes as if we are giving orders to the codebase "to
be like so".  And as you have enumeration, I would write something
like this if I were describing this change:


     - Use the `print()` function, because Py3 no longer has the `print`
       statement.

     - Import `reduce()` from functools, because Py3 requires this, and
       importing also works with Py2 (even though it wasn't necessary).

     - Use `input()` instead of `raw_input()`, as the former can be used
       with both but the latter was removed in Py3.

    Also add a CI job to Travis CI to run flake8 lint to avoid an
    backsliding on future pull requests.

https://python-future.org/compatible_idioms.html#raw-input seems to
suggest, just like you import reduce from functools, you need to
import input from builtins.  Is it not the case?

> +      script: flake8 . --count --select=E9,F63,F72,F82 --show-source --statistics

How was the set of "select"ed violations to catch chosen?  How are
we going to maintain this list going forward?

The rest of the patch looked sensible.

Thanks.
