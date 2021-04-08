Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7D6C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B84F610C8
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 18:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhDHSLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 14:11:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62328 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhDHSLD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 14:11:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB1CEC3D7D;
        Thu,  8 Apr 2021 14:10:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lJjxX4zRFrSP
        T4l4aSpB9rhkWrA=; b=qRIQfE1c1vkHcIkxrsnD1gOhCAi4tAHuC+O3I7XUOAZo
        pRu6WISvmERucJ/YwFq96iK6ldqeFEkAcRpj5Fihbh/R43zQtLGz5kJKOIn7n7Jd
        5Te1XjYVF5MUN9aOUNbJsudG78i3Q5CsQfPtfJaILtHgNtgO6MGagIRDqC/iu0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=asJaMs
        K6hqpE6ZWW8huW0vrTIuDzNS226dJxdxPjfP9bFCwwt01uVwcD0O28niFDqXWvOQ
        py+pgP/PH2CNYfRTkkcanMHYS6ZTmxBxIF/N7/9MlfUYS/jpcXwHRLWD8+xL5fmw
        Csl7v8YVCSxSQY3CqmoMoL31Mrqb1SqxJ+9z8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFCB0C3D7C;
        Thu,  8 Apr 2021 14:10:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE467C3D7B;
        Thu,  8 Apr 2021 14:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/5] config.c: add a comment about why value=NULL is true
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
        <patch-1.6-bd70181ffb-20210408T133125Z-avarab@gmail.com>
Date:   Thu, 08 Apr 2021 11:10:50 -0700
In-Reply-To: <patch-1.6-bd70181ffb-20210408T133125Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 8 Apr
 2021 15:34:25 +0200")
Message-ID: <xmqqmtu8tzo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C04BF9E8-9895-11EB-8B23-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Subject: Re: [PATCH 1/5] config.c: add a comment about why value=3DNULL=
 is true

A few unproductive nitpicks.

The question "why does '[core] ignorecase' mean core.ignorecase is
true?" has only a single answer, which is "because that is how we
designed (loosely imitating .ini format) and implemented."

> It's not very intuitive that git_parse_maybe_bool_text() would
> consider NULL to be a true value. Add a small comment about it.

Do you mean

	if (!value)
		return 1;

is unintuitive?  Or do you mean

	[core]
		ignorecase

being a valid way to say "the filesystem ignores case differences"?

The answer to the question is crucial to justify the title.  Only
when "the config syntax is perfectly understandable, the way the
logic to parse that syntax is expressed in C is not necessarily
intuitive" is true, the comment makes sense, I would think.

> See a789ca70e7 (config: teach "git -c" to recognize an empty string,
> 2014-08-04) for the behavior of "git -c", but we'll end up here in
> both the config file parsing and command-line parsing cases.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  config.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/config.c b/config.c
> index 6428393a41..fc28dbd97c 100644
> --- a/config.c
> +++ b/config.c
> @@ -1229,6 +1229,10 @@ ssize_t git_config_ssize_t(const char *name, con=
st char *value)
>  static int git_parse_maybe_bool_text(const char *value)
>  {
>  	if (!value)
> +		/*
> +		 * "[foo]\nbar\n" and "-c foo.bar" on the command-line
> +		 * are true.
> +		 */

This is a "we do not explain why '[foo] bar' is true, but to be
prepared to parse it, we check if value is NULL" comment.  And
I think it is a good one, except that I do not see the point of
writing "\n" at all.  Replacing them with spaces would make it far
easier to read.

		/*
		 * "[foo] bar" in the configuration file, and
		 * "git -c foo.bar" on the command-line, mean
		 * that the variable foo.bar is true.  A NULL is
		 * passed as 'value' in these cases.
		 */

>  		return 1;
>  	if (!*value)
>  		return 0;
