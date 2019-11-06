Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36E81F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfKFEvq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:51:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52616 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKFEvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:51:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DDB425211;
        Tue,  5 Nov 2019 23:51:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=idOd3RLBX7nC63gqWIBUYV2Fakc=; b=vHkBGf
        qLomPA4tn0gQHRi4EKhqir0GTcFJPHlGtgRlcrekHUn79bBbiWitwgnA4wNfwOuH
        n+29RfSvl5HhtMrQpLJ0XThEEqBMrLF0fOnB6LaHybxqaaoMu1Ab7N2TUvJOl65J
        fhJXjA7+J2vaEayFsVXHfqBHcB9g3N+dd56pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SL6tCMjRMTtsxQPfSxvzHeST2nurIize
        1TQFHL4Wti06uIkwfVeDnvcteLEdpUJP756IWae144mfbLhMAgNC2K7ymVLzxlJ6
        X0rjCtvuhWXG3ZAJdgEwi6wF2SAPlK5+/vKZZzxaTVN8OSbiBnbfpl6WBHEHFYDP
        /+SGbckAhUg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84C6F25210;
        Tue,  5 Nov 2019 23:51:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA3862520F;
        Tue,  5 Nov 2019 23:51:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 5/5] commit: support the --pathspec-from-file option
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 13:51:41 +0900
In-Reply-To: <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Mon, 04 Nov 2019
        19:26:45 +0000")
Message-ID: <xmqq4kzhvc82.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20BC1436-0051-11EA-96B9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> This option solves the problem of commandline length limit for UI's
> built on top of git. Plumbing commands are not always a good fit, for
> two major reasons:
> 1) Some UI's serve as assistants that help user run git commands. In
>    this case, replacing familiar commands with plumbing commands will
>    confuse most users.
> 2) Some UI's have started and grown with porcelain commands. Replacing
>    existing logic with plumbing commands could be cumbersome and prone
>    to various new problems.

I think all the comments I made on "reset" with these two options,
both to the proposed log message and to the patch text, applies to
this this step, too, so I won't repeat them.

Thanks for working on this topic.
