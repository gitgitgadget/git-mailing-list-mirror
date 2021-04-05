Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AAAC433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF8861399
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhDERon (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:44:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52537 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhDERom (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 13:44:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C36EA80BC;
        Mon,  5 Apr 2021 13:44:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0pJA0cOq3r8PgIJNNfmIXx4R+NQ=; b=donseL
        9+Uej0Cjt/QQY663eocLJ555sJ+LG/aro40lEkzXGbdHalZT6EtaZ6gNATqMR66g
        9IaK2rvP4+x/HXLFiwU5cLO4F1bWfH4aLCMHOdsJxVudNtz6GEjw1NK/WjWvNLq+
        isFWbdNhM9pwVWs6a46/RmCnmBi4EBSCEEDNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rU82Y4FGqD2RhjICABqe/QxgCwJN0wzp
        Lid8e+9dvvHgLcpYu31opP+QfXhDx28ZBxwXTQx0GkfJpoZf/VgNJF1Him8fYc8v
        PY1+9ilvmVr6AwZRhgpS0gqSgKKVVR/ufZbXfaH+HPxERhhOzlvYcrU8l7Or39PM
        3F4B9W5mksc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91605A80B9;
        Mon,  5 Apr 2021 13:44:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17FD3A80B8;
        Mon,  5 Apr 2021 13:44:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tom Saeger <tom.saeger@oracle.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/5] refspec: output a refspec item
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
        <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
        <20210405165740.brevvzc7hiyg2wj4@brm-x62-17.us.oracle.com>
        <CAPig+cSfzpynO5es+B4=7_Dz-qTHNXpDeUVxs7z5yffQFgWU=A@mail.gmail.com>
Date:   Mon, 05 Apr 2021 10:44:34 -0700
In-Reply-To: <CAPig+cSfzpynO5es+B4=7_Dz-qTHNXpDeUVxs7z5yffQFgWU=A@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 5 Apr 2021 13:40:34 -0400")
Message-ID: <xmqqzgyc62yl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95D5F328-9636-11EB-835E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Apr 5, 2021 at 12:58 PM Tom Saeger <tom.saeger@oracle.com> wrote:
>> On Mon, Apr 05, 2021 at 01:04:13PM +0000, Derrick Stolee via GitGitGadget wrote:
>> > +const char *refspec_item_format(const struct refspec_item *rsi)
>> > +{
>> > +     static struct strbuf buf = STRBUF_INIT;
>> > +
>> > +     strbuf_reset(&buf);
>>
>> is this even needed?
>
> This is needed due to the `static` strbuf declaration (which is easy
> to overlook).
>
>> > +     if (rsi->matching)
>> > +             return ":";
>> > +
>> > +     if (rsi->negative)
>> > +             strbuf_addch(&buf, '^');
>> > +     else if (rsi->force)
>> > +             strbuf_addch(&buf, '+');
>> > +
>> > +     if (rsi->src)
>> > +             strbuf_addstr(&buf, rsi->src);
>> > +
>> > +     if (rsi->dst) {
>> > +             strbuf_addch(&buf, ':');
>> > +             strbuf_addstr(&buf, rsi->dst);
>> > +     }
>> > +
>> > +     return buf.buf;
>>
>> should this be strbuf_detach?
>
> In normal circumstances, yes, however, with the `static` strbuf, this
> is correct.
>
> However, a more significant question, perhaps, is why this is using a
> `static` strbuf in the first place? Does this need to be optimized
> because it is on a hot path? If not, then the only obvious reason why
> `static` was chosen was that sometimes the function returns a string
> literal and sometimes a constructed string. However, that's minor, and
> it would feel cleaner to avoid the `static` strbuf altogether by using
> strbuf_detach() for the constructed case and xstrdup() for the string
> literal case, and making it the caller's responsibility to free the
> result. (The comment in the header file would need to be updated to
> say as much.)

Very good suggestion.  That would also make this codepath
thread-safe (I do not offhand know how important that is, though).

Thanks.
