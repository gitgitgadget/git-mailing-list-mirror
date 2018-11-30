Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B293211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 01:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeK3Mzk (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 07:55:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64156 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeK3Mzk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 07:55:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A03171CCCF;
        Thu, 29 Nov 2018 20:48:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=opUX1uUZd9Jcbf4oKu+0etg+unU=; b=tkzh8g
        UiilwwlN7cmHH9QUfBfKnVMdSP4tLQD2yIvfggJ54yaqF+D94JMLUJqK2lkpxjA/
        mKB7i4ciTf+x6ciOwXmWJpDP56hlgldFqLdCBTCCGOr1fod79rKkfFiRBmlDjmv1
        nq+i7J7cnAifSSr5QbOLi8cjmp15ugJFNs3Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X3HqQFa1qWxy05N85eeTtoLPMPSE31PU
        VdG/Yz0xgjGV94VJBAmibpwF6NQpd9ljT+2M1kgwAmoVHqQxO6iDH+DDkFR8Ly7J
        ROzZfeqcMPqPZdrCgR8JpDr5imPNXciXsVEwFePsvU+ODFcALOGOIw9weRZagphl
        VOr2lJZTkuw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98E9F1CCCE;
        Thu, 29 Nov 2018 20:48:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B1A461CCCC;
        Thu, 29 Nov 2018 20:48:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 0/7] Introduce new commands switch-branch and checkout-files
References: <20181120174554.GA29910@duynguyen.home>
        <20181127165211.24763-1-pclouds@gmail.com>
        <CACsJy8D2gxPj4u0_eEg-_x-Z3S3+5FdTU6Su4VQM113nQq=PYg@mail.gmail.com>
        <CACsJy8Cv9ZwWEs-wsOtms3JCXo7x8fL_PBatcb0TgvrrQuMUdg@mail.gmail.com>
Date:   Fri, 30 Nov 2018 10:47:59 +0900
In-Reply-To: <CACsJy8Cv9ZwWEs-wsOtms3JCXo7x8fL_PBatcb0TgvrrQuMUdg@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 28 Nov 2018 21:09:22 +0100")
Message-ID: <xmqqk1kvmj3k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8B45762-F441-11E8-9549-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Nov 28, 2018 at 9:01 PM Duy Nguyen <pclouds@gmail.com> wrote:
>> should we do
>> something about detached HEAD in this switch-branch command (or
>> whatever its name will be)?
>>
>> This is usually a confusing concept to new users
>
> And it just occurred to me that perhaps we should call this "unnamed
> branch" (at least at high UI level) instead of detached HEAD. It is
> technically not as accurate, but much better to understand.

As I said elsewhere in nearby thread, I agree that "unnamed branch"
is a reasonable way to explain what the state the user is in.  It is
not incorrect per-se that HEAD is detached from anything in refs/ in
such a state, but that is an implementation detail of how the
worktree gets on the unnamed branch (which lasts until the worktree
next gets on a named branch, at which point the unnamed branch
disappears).

