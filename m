Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2A5C56201
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 20:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C03B20756
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 20:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g2JxXj/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756005AbgJWUSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 16:18:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55673 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750409AbgJWUSU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 16:18:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D825945D3;
        Fri, 23 Oct 2020 16:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Py4b4YjbXTZhwGugd5qgkJtsP/I=; b=g2JxXj
        /aUGWCJBlN61ZapphRBI3L4DmJ+WOdweD7r2vfeKEX1nLwxItZXzaIhX/RTSlV3f
        kT88lwXm1iLbxpng3urlDAIruSnOTVrnAmrxtSA7BGo4BhRSW4LPASzU/FARUzwy
        p9lxd5LyrAxZAtvFqq99Wl1+RBOdz5s1VMup0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XZ9ZfORyrgXkPw7xfugsAU7HLyDajf0Z
        YjpQFYUWXapTsSVqe8rdMhnw8MEbJL8hf3GYoIIen8H3noEUF2mqgeTxwFztLlG0
        uQEyCm53Uqd8Eg8++NlG1zADJ3iWjGYJGYDwopDdQAJUsDsOYNOakF9PRVsuDm+0
        6jwQdcbhjEM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26062945D2;
        Fri, 23 Oct 2020 16:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9ABA5945D0;
        Fri, 23 Oct 2020 16:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: clarify description of --index
References: <xmqqzh4dk3ey.fsf@gitster.c.googlers.com>
        <23806f2c-df96-b105-3b85-f40b0e8ec7ca@kdbg.org>
        <xmqqzh4dhurk.fsf@gitster.c.googlers.com>
        <92f3ec02-14f2-482c-5754-5bff0db9d634@kdbg.org>
Date:   Fri, 23 Oct 2020 13:18:14 -0700
In-Reply-To: <92f3ec02-14f2-482c-5754-5bff0db9d634@kdbg.org> (Johannes Sixt's
        message of "Fri, 23 Oct 2020 20:08:52 +0200")
Message-ID: <xmqq4kmkhf21.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1F5195A-156C-11EB-BB77-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 23.10.20 um 16:38 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> 
>>>> -	Apply the patch to both the index and the working tree (or
>>>> -	merely check that it would apply cleanly to both if `--check` is
>>>> -	in effect). Note that `--index` expects index entries and
>>>> -	working tree copies for relevant paths to be identical (their
>>>> -	contents and metadata such as file mode must match), and will
>>>> -	raise an error if they are not, even if the patch would apply
>>>> -	cleanly to both the index and the working tree in isolation.
>>>> +	After making sure the paths the patch touches in the working
>>>> +	tree have no modifications relative to their index entries,
>>>> +	apply the patch both to the index entries and to the working
>>>> +	tree files or see if it applies	cleanly, when `--check` is in
>>>> +	effect.
>>>
>>> I don't think that this is an improvement. The purpose of --index *is*
>>> to apply the patch to both index and worktree, and that should be
>>> mentioned first. The check that both are identical, is a prerequisite
>>> and not the primary objective of the option.
>> 
>> Yeah, but this was an attempt to clarify what that "apply to both",
>> which is the central part of the operation, exactly means.
>> 
>> The only mode of operation we offer is that we start from identical
>> index and working tree, and make the same change so that we arrive
>> at the same outcome.  It is not like you can have some changes in
>> the working tree file as long as they do not overlap and collide
>> with the incoming patch, make the same change with the patch to
>> arrive at different contents as the outcome.  We explicitly forbid
>> that, but "apply to both" does not exactly tell it to the readers.
>
> Your have point that the original text muddies the preconditions a bit,
> but I still think that "what it does" must be the first thing to be
> mentioned, and the preconditions the second.

Yeah.  I offhand do not think of a better phrasing within the
constraint that "apply to only identical state" must be said after
saying "to both the index and the working tree", though, so I'll
leave it up to the list's wisdom ;-)

Thanks.
