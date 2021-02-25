Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5643CC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167D364E24
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhBYUuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:50:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51325 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhBYUtp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 15:49:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADFDDA04D0;
        Thu, 25 Feb 2021 15:48:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PQaG/sFwSSxFN3aL/l3q4ZJhH1A=; b=V8P0DM
        8/TSJLX46c1sKSEuCGaLadV4xtg0DiRyPWaGwnLe5sGvHficj4e8uVdn+AFL0SYx
        eJ8SFbVcqsYobmJuNOIKnQ3Ygg6RVlJAgaNHOepEzefOMagHBorS8Z52uJuWDF0I
        2Uy4jDEPUCTDji/sxyBPPUv26i/oc3AyVC1ZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LgzlI3LsrSw1UcL5WJp2DChLby1u2FvK
        E70xj+HHyM9fwPr6kTcW1WaPhwE874sR7M64Lo6Al9LC3/0WN4CYSrEYWjxxsr0b
        BN26CsZ6Rt6p61lYCiIrTXx8X929Z7xk9qRN7QvOUJHkdsC9gIuYRvouB5Y3EMtc
        x+n6kaTlc3w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A62A1A04CF;
        Thu, 25 Feb 2021 15:48:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 22A08A04CD;
        Thu, 25 Feb 2021 15:48:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210225100855.25530-7-charvi077@gmail.com>
Date:   Thu, 25 Feb 2021 12:48:41 -0800
In-Reply-To: <20210225100855.25530-7-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Thu, 25 Feb 2021 15:39:04 +0530")
Message-ID: <xmqq4khzub4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D846D75E-77AA-11EB-BED5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> +--fixup=[(amend|reword):]<commit>::
> +	When used without options, lets's say `git commit --fixup=<commit>`,
> +	it creates a "fixup!" commit where the commit message will be

Be careful to use word 'option' that refers to something other than
what a casual reader would think of an `--option` in the description
of the `--fixup` option.

	Without `amend:` or `reword:`, create a `fixup!` commit where...

would be sufficient, no?

> +	the subject line from the specified commit with a prefix of
> +	"fixup! ". The resulting "fixup!" commit is further used with
> +	`git rebase --autosquash` to fixup the content of the specified
> +	commit.
> ++
> +When used with option `amend`, let's say `git commit --fixup=amend:<commit>`,
> +it creates a "amend!" commit to fixup both the content and the commit log

	The `--fixup=amend:<commit>` form creates an "amend!" commit to...

> +message of the specified commit. The resulting "amend!" commit's commit
> +message subject will be the subject line from the specified commit with a
> +prefix of "amend! " and the message body will be commit log message of the

While that SP inside the double-quote may be technically more
correct (and it was inherited from the original), I think with 'a
prefix of "amend!"' is still understandable and a lot easier to
read, especially because you'd mention "amend!"  a few more times in
the same paragraph below.

The same comment applies to "fixup! " above.

> +specified commit. It also invokes an editor seeded with the "amend!" commit
> +log message to allow to edit further. And it denies to create "amend!" commit

"amend!" commit log message -> log message of the "amend!" commit

denies -> refuses

> +if it's commit message body is empty unless used with `allow-empty-message`
> +option. "amend!" commit when rebased with `--autosquash` will fixup the

with the `--allow-empty-message` option.

> +contents and replace the commit message of the specified commit with the
> +"amend!" commit's message body.
> ++
> +When used with alternative option `reword`, let's say
> +`git commit --fixup=reword:<commit>`, it works similar to `amend` option, but
> +here it creates an empty "amend!" commit, i.e it does not take any staged

	The `--fixup=reword:<commit>` form creates an `amend!`
	commit similar to `--fixup=amend:<commit>` creates, but it
	records the same tree as `HEAD`, i.e. it does not ...

> +changes and only allows to fixup the commit message of the specified commit.
> +It will reword the specified commit when it is rebased with `--autosquash`.
> ++
> +Unlike `--fixup` without options, `--fixup=[amend/reword]:` is incompatible with
> +`-m` commit message option.

	The `--fixup=amend:` and `--fixup=reword:` forms cannot be
	used with other options to add to the commit log message,
	e.g. `-m`.

Again, why is `-m` so special?  Shouldn't -F/-c/-C also be
incompatible?

> +Also, after fixing the commit using `--fixup`, with or without option and rebased
> +with `--autosquash`, the authorship of the original commit remains unchanged. See
> +linkgit:git-rebase[1] for details.

Good.
