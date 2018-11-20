Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 332441F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 02:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbeKTMsz (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 07:48:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63503 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbeKTMsz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 07:48:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D00F53763B;
        Mon, 19 Nov 2018 21:22:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KRKfhsnVKNzMkf8CypVMexx+B7Q=; b=Kiv+r0
        G3XYXTBBjqEPGe9qOr/uI5EHmHAdbviu51PXQsismiTxatQktiJsSgkqsMzV5bGB
        X108nYGeh0UqTICJzoPRD8yz0EfRDSNOv4w7mdcRC0ro5HffvZQZYAArCrERtTOg
        kvk03rjcsy/LDPSSjwpbgq0Q5sITl2Gy/6J7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lpNYEBusF3R9P0CKvz4/HOQpDVNWGM7p
        nTgGHxOdUH/PBrUgn3xu5plSx0rlj/qHjYQOn/cFkSuaF6RWWrKa8xo4pB6p91ek
        KzMwjpQP6CaMCv1H48GNFLPLSa9xja5gzUCer+lgOfDS1YsEm8nXXITgOSxQDucs
        MNonvXLn1qM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C886C3763A;
        Mon, 19 Nov 2018 21:22:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DBA3B37639;
        Mon, 19 Nov 2018 21:22:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?Pa?= =?utf-8?Q?we=C5=82?= Paruzel 
        <pawelparuzel95@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive filesystems
References: <20180817161645.28249-1-pclouds@gmail.com>
        <20181119082015.77553-1-carenas@gmail.com>
        <37b7a395-3846-6664-9c4d-66d2e4277618@web.de>
        <CAPUEsphrYOV64m08JY_tsVuJ-uwTv=o=m5LdCFOWd+8tWJP54A@mail.gmail.com>
        <CACsJy8A_c-O5DrZnMvEbsSa+YzatiLH3TLAy3OV1+AwY5rrCjQ@mail.gmail.com>
        <20181119210323.GA31963@duynguyen.home>
Date:   Tue, 20 Nov 2018 11:22:05 +0900
In-Reply-To: <20181119210323.GA31963@duynguyen.home> (Duy Nguyen's message of
        "Mon, 19 Nov 2018 22:03:24 +0100")
Message-ID: <xmqq36rwcwtu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1430700E-EC6B-11E8-993D-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>  
> -	for (i = 0; i < state->istate->cache_nr; i++) {
> +	for (i = 0; i < trust_ino && state->istate->cache_nr; i++) {

There is some typo here, but modulo that this looks like the right
thing to do.

> @@ -419,10 +419,24 @@ static void mark_colliding_entries(const struct checkout *state,
>  		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
>  			continue;
>  
> -		if ((trust_ino && dup->ce_stat_data.sd_ino == st->st_ino) ||
> -		    (!trust_ino && !fspathcmp(ce->name, dup->name))) {
> +		if (dup->ce_stat_data.sd_ino == (unsigned int)st->st_ino) {

This is slightly unfortunate but is the best we can do for now.  

The reason why the design of the "cached stat info" mechanism allows
the sd_* fields to be narrower than the underlying fields is because
they are used only as an early-culling measure (if the value saved
with truncation is different from the current value with truncation,
then they cannot possibly be the same, so we know that the file
changed without looking at the contents).

This use however is different.  Equality of truncated values
immediately declare CE_MATCHED here, producing false negative, which
is not what we want, no?

>  			dup->ce_flags |= CE_MATCHED;
> +			return;
> +		}
> +	}

