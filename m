Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DDCC3404D
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B952176D
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q344HMR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBRUqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:46:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57023 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBRUqp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:46:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC8695CD64;
        Tue, 18 Feb 2020 15:46:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VaBZyBX6hkhNuzhncBU/rv6XHl8=; b=q344HM
        R3jfaJO5ZBW3kEudQ1TrrTiBl7PNB1wpThB6xWiOUEg1IPvJjEN5LJ5LfUOTbOyi
        urp23Xe/XOMz4uWjNsBnQiftVE/Z+7mdvUg6fZ6KX4Jo0WvfGilbFGHwcQYvuQ4y
        CzoSL5S1n8ef63XU7TwX8g+xN38I9LQW2eC2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PhsUwjhLsG1wT6vvRttx9KZyES/pCti+
        brRLBjlz27MQ/JKrEByVgJFE5KRkno7Snb6nvOUmnNweCxBhfJrHSTXpDt0IC0Q2
        4Ord0G3Jww0v8BJ+e5f9xA0bmq65smBU5bX/QRsn2G9j9PuMEL67lqWZCwYRkC5M
        2PwDFdKlra4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D47E65CD63;
        Tue, 18 Feb 2020 15:46:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4796D5CD62;
        Tue, 18 Feb 2020 15:46:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     rwagih.rw@gmail.com, git@vger.kernel.org, l.s.r@web.de,
        pclouds@gmail.com, peff@peff.net, predatoramigo@gmail.com
Subject: Re: [GSoC][RFC][PATCH 2/2] STRBUF_INIT_CONST: Adapting strbuf_* functions
References: <CAHk66fskrfcJ0YFDhfimVBTJZB4um7r=GdQuM8heJdZtF8D7UQ@mail.gmail.com>
Date:   Tue, 18 Feb 2020 12:46:41 -0800
In-Reply-To: <CAHk66fskrfcJ0YFDhfimVBTJZB4um7r=GdQuM8heJdZtF8D7UQ@mail.gmail.com>
        (Abhishek Kumar's message of "Tue, 18 Feb 2020 15:00:00 +0530")
Message-ID: <xmqq36b7k4i6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C55AF026-528F-11EA-9814-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> I would also prefer the term "immutable" over "const" since const
> already has implications in C programming.

As long as the implication the established word conveys is what the
patch wants to do, it is *better* not to invent another phrase and
instead use the well-known term, no?

>> STRBUF_INIT_CONST: a new way to initialize strbuf
>
> Use imperative mood and be more specific in the commit title -
> `strbuf: Teach strbuf to initialize immutable strings`

s/T/t/;

> I feel this is self-explanatory when you go through the diff.

True.

>  void strbuf_grow(struct strbuf *sb, size_t extra)
>  {
> +    if (sb->len > sb->alloc)
> +        strbuf_make_var(sb);
>      int new_buf = !sb->alloc;

This introduces decl-after-stmt error.

Also, isn't "if (sb->alloc < sb->len)" too loose a check for the new
feature?  AFAICS in 1/2, a strbuf that is still borrowing a const
string always has sb->alloc==0.  Other instances of strbuf that
happens to satisify the above condition, e.g. (sb->len == 5 &&
sb->alloc == 1), is an error.  If we are to check the condition
about sb->len, shouldn't we diagnose such a case as an error, no?

> +void strbuf_make_var(struct strbuf *sb)
> +{
> +    char* str_cpy;

Isn't make_var() an implementation detail that should not leak
to the strbuf API users?  IOW, does it have to be extern?

In our codebase (eh, rather, in C as opposed to C++), the asterisk
sticks to the identifier, not to the type.

>  void strbuf_trim_trailing_newline(struct strbuf *sb)
>  {
> +    if (sb->buf[sb->len - 1] == '\n')
>> +        if (sb->len > sb->alloc)
>> +            strbuf_make_var(sb);
>
> Enclose this explicitly in braces.

Yup.  Also the repetition we see is a sign that something is wrong.
Perhaps adding a small inline helper 

	static inline void strbuf_premutate(sb) 
	{
		if (!sb->alloc) {
			... body of strbuf_make_var() comes here ...
		}
	}

and getting rid of strbuf_make_var() would help?

As Peff, I am a bit hesitant about leaving a strbuf that hasn't been
made mutable around, though.
