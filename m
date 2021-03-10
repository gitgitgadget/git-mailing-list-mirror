Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82841C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBD564FC5
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhCJWg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:36:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60361 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCJWgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 17:36:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BAE50ACEAC;
        Wed, 10 Mar 2021 17:36:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mtzaokJEgTHsnqZF0vBPz2wfHwQ=; b=cUrspi
        JFo7VGQZp0M8LHaRIHh0qVgNSP7SCPxu1Ooa/zriaNk1UuABDmQbev6Z3tXtaSxe
        iYhI+VOawyPavOXWOrR15INYrzspqWvH4jJlvT61EO6b8TOZwbhqID5W1S/1e77k
        3JtW98nEwB+l5kIqixr9dZhjRstCrs2EygDa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M3GIa7YVBr7EDYrR2SaGz+U8+Sr6kbhL
        SRl1lIWL8YDuzg5BcpplmNdH29xMAhSk+pT2HkevuYFCH56q0NWkPzU30h+QWKgn
        iQ5/AeTEkL9UdH7Tz9zkJAUBIAcAIyCFu/ajIDignn+6cFEnUaXDsXjesAPvesKe
        e0eV5mGh0aE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B368EACEAA;
        Wed, 10 Mar 2021 17:36:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 432B6ACEA9;
        Wed, 10 Mar 2021 17:36:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 01/17] commit: use config-based hooks
References: <20201222000435.1529768-1-emilyshaffer@google.com>
        <20201222000435.1529768-2-emilyshaffer@google.com>
        <xmqqlfc7jv9p.fsf@gitster.c.googlers.com>
        <YEkjSSuHXk3XI85W@google.com>
Date:   Wed, 10 Mar 2021 14:36:52 -0800
In-Reply-To: <YEkjSSuHXk3XI85W@google.com> (Emily Shaffer's message of "Wed,
        10 Mar 2021 11:51:37 -0800")
Message-ID: <xmqqh7liiqkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CA9C8DE-81F1-11EB-87D5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> parallelized" I could write:
>
>   Hooks executed during prepare-commit-msg will not be parallelized,
>   because the file provided in the first argument is expected to be edited
>   by each hook.

Yeah.  It's been quite a while since I wrote the message you are
responding to, and it took me a while to get the context back in my
head, but the above looks reasonable to me.  We could tweak it a bit
to say "the file ... serves as an input to be modified in place by
each hook" to make it even clearer, but I think yours is clear
enough.

Thanks.
