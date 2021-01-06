Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D356C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA75E2333B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbhAFXHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 18:07:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60243 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFXHe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 18:07:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EB39B45D6;
        Wed,  6 Jan 2021 18:06:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RTNBFSoqmpofwwG2oeezz4cRk3w=; b=kpJso9
        YjsblVBO3moYusCFvuKcKftsCd2VT+/maqbWbXOtSjbuWSvIyyDXmeOsUN3kkL1U
        hrxDPHc5JLFAMh41SiglXgwT4NTpSMUga6cVhXRLYV/JpM80sO38UQHPnW28m39y
        nn30JwADZ6aVqQ+dY0xK0QwWjTl07RGVVABHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RdEGNb2OGftocEI3hR5WPN1wKqg7hO5W
        C26Dc8L5bGFfnZQPZK06mwkfdqRQr5tl+FasPc/pyhNy5XjIrjMs7nU/lDk9R4m/
        i5vJHOJfPWl4bf0yKj9dbwDZJaOkvHaaL8fZMA0/RdNO746LT5aKepX/5nbpvSyx
        nJeGWbOyyo0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94A0AB45D5;
        Wed,  6 Jan 2021 18:06:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 207FCB45D4;
        Wed,  6 Jan 2021 18:06:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        pudinha <rogi@skylittlesystem.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] mergetool--lib: fix '--tool-help' to correctly show
 available tools
References: <pull.825.git.1609179751864.gitgitgadget@gmail.com>
        <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
        <20210106131651.GQ8396@szeder.dev>
        <xmqq5z49rclc.fsf@gitster.c.googlers.com>
        <3664fffc-c2a0-62d6-298b-8e95f3c58a68@gmail.com>
Date:   Wed, 06 Jan 2021 15:06:51 -0800
In-Reply-To: <3664fffc-c2a0-62d6-298b-8e95f3c58a68@gmail.com> (Philippe
        Blain's message of "Wed, 6 Jan 2021 17:59:10 -0500")
Message-ID: <xmqqeeixpsvo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCD770FC-5073-11EB-9791-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> What was the symptom before the fix?  Is it just missing only some
>> tools among 30?  Was there some pattern in names of missing one and
>> the ones that still got output?  Or was it more like "we see nothing
>> shown"?
> ...
> Note that 'vimdiff', 'nvimdiff3' (last variant for vimdiff),
> 'bc' and 'bc4' (last variant for bc) are absent, and
> all other tools that have no variants are absent as well.

Thanks, that is exactly the kind of "some pattern" I wanted to see
us looking for, because I wonder if it is a more robust and cheaper
(maintenance wise) approach to find one single tool that we support,
which does not have, and which is unlikely to gain, any numbered
variants.  If we can find such a tool, we can grep for its name in
the output.



