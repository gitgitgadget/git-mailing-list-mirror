Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D34C4332E
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED3564FDC
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCKAbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:31:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61933 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhCKAbA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:31:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C63E211B133;
        Wed, 10 Mar 2021 19:30:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eobUMNXUJ4R1R80EDuaFJn9yQlA=; b=Phk+p2
        A7y/nghjYD2d5Ef+N01t9K2OyCAIo0Uys/x5DXs9WhCsLmGYaVQkwQpuCxzvNW1C
        +IderzyQv9PxCh1tH1IR/obnctminwSclwTns6UcVvjltibXNIhE9URG6ma4pFA/
        gH1R5hE/bU1bosNGYXd2Exzskg75poy1NBjRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nZbA3YP9s8xZwk5AZOMIIL3q3atYtui3
        1PUkWPbfS8pTDxnVyLbNeLty0N8pJtF5YAqoQS9UcIG/rA0A+JHB9eTZxnwz9II/
        sHnj7bh6LsO7W2cLhNpoVqujMr0no0lDEUBcQ3r5Du+6mfIFjFnndgtU+uGbJzk6
        SUV4JT6tJ5I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE63911B132;
        Wed, 10 Mar 2021 19:30:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 156AD11B131;
        Wed, 10 Mar 2021 19:30:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210310194306.32565-7-charvi077@gmail.com>
Date:   Wed, 10 Mar 2021 16:30:55 -0800
In-Reply-To: <20210310194306.32565-7-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Thu, 11 Mar 2021 01:13:10 +0530")
Message-ID: <xmqqwnueh6ps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BE46D0A-8201-11EB-AFAA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> ---fixup=<commit>::
> -	Construct a commit message for use with `rebase --autosquash`.
> -	The commit message will be the subject line from the specified
> -	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
> -	for details.

Overall, the text in this round reads much better than the previous
round.

> +--fixup=[(amend|reword):]<commit>::
> +	Construct a new commit for use with `rebase --autosquash`,
> +	which fixes the specified commit. The plain form
> +	`--fixup=<commit>` creates a "fixup!" commit, that allows
> +	to fixup only the content of the specified commit and leave
> +	it's commit log message untouched. When used with `amend:`
> +	or `reword:`, it creates "amend!" commit that is like "fixup!"
> +	commit but it allows to fixup both the content and the commit
> +	log message of the specified commit. The commit log message of
> +	the specified commit is fixed implicitly by replacing it with
> +	the "amend!" commit's message body upon `rebase --autosquash`.

Rewriting

    "is fixed implicitly by replacing it with" -> "is replaced by"

may make it easier to follow.

Thanks.
