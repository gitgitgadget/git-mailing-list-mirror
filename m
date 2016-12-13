Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFAE203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbcLMTn2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:43:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64793 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753168AbcLMTmf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:42:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 839EC55471;
        Tue, 13 Dec 2016 14:42:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gA0Vh4hqOZAjGoHI5qBqOFJbX2E=; b=Dce5RX
        ArMgLC24BTueJL7wPCP3au2ErnpO2Vr24l0lBrVT49hVwBH++x3sbKZNKocZt0Az
        wGFXwEXEJraaVkjZIRkM8kqS5LOarjhnQeJ5Cr3zqs1Dmg/xch3k0sS/y+j7LU+e
        zR7FWyFo8lixSOJRN8Eza5WvXTapouvoCeadE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZPG6cneLAluKyk9nvGPIaykdf1DR0kmj
        vgp6G3CtQQKk1yjR58Du/+s3QDRkRB4muAaDIn+1MVSJXfGNjncia1uEqa4qmeRJ
        QAgX4w549BIZn0iFRP9+MuJySLA6hV4INXfDj5OeXRLx9xGtSq4p9mM9nD60Z3QS
        6nqaJfO745w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79B4F55470;
        Tue, 13 Dec 2016 14:42:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECC4D5546F;
        Tue, 13 Dec 2016 14:42:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 00/34] Teach the sequencer to act as rebase -i's backend
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
Date:   Tue, 13 Dec 2016 11:42:31 -0800
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Tue, 13 Dec 2016 16:29:06 +0100 (CET)")
Message-ID: <xmqqa8bz39aw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A61066A-C16C-11E6-B947-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This marks the count down to '3': two more patch series after this
> (really tiny ones) and we have a faster rebase -i.

Nice.

> Apart from mostly cosmetic patches (and the occasional odd bug that I
> fixed promptly), I used these patches since mid May to perform all of my
> interactive rebases. In mid June, I had the idea to teach rebase -i to
> run *both* scripted rebase and rebase--helper and to cross-validate the
> results. This slowed down all my interactive rebases since, but helped
> me catch three rather obscure bugs (e.g. that git commit --fixup unfolds
> long onelines and rebase -i still finds the correct original commit).
> ...
> Please note that the interdiff vs v1 is only of limited use: too many
> things changed in the meantime, in particular the prepare-sequencer
> branch that went through a couple of iterations before it found its way
> into git.git's master branch. So please take the interdiff with a
> mountain range of salt.
> ...
> Changes since v1:
> ...
> - removed the beautiful ordinal logic (to print out "1st", "2nd", "3rd"
>   etc) and made things consistent with the current `rebase -i`.

It was removed because it was too Anglo-centric and unusable in i18n
context, no?

Judging from the list above, interdiff are pretty much all cosmetic
and that is why you say it is only of limited use, I guess.

    ... goes and reads the remainder and finds that these were
    ... all minor changes, mostly cosmetic, with a helper function
    ... refactored out or two and things of that nature.

It is actually a good thing.  We do not want to see it deviate too
drastically from what you have been testing for some months.

Thanks.
