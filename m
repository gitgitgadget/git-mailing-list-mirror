Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B970A1F462
	for <e@80x24.org>; Fri, 31 May 2019 17:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfEaRkU (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 13:40:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64235 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaRkU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 13:40:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D34915D2C8;
        Fri, 31 May 2019 13:40:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CEC/iL3JRth50JtdEO+krzbZ5X4=; b=OkW5H6
        2q5BEBhP/NwVed1tvNkT98tYsu5XKl0+EXmRjpk1zW9Jo77QFHumgNUVWKYF2p/g
        LoxK15psS4gJLpn1pX2UPzS7F7T0Lwq2mNaNJtaYt7ZzcNrgdXa74Njq7EUqHyiJ
        95jsQP8O8sN/ZgOaHPkIHLPBvwIJJ3AktU0xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zx9Z/3K2t0aDc48BOIzL566ZhTp6ZNy4
        qsqmMYWTd9X4HK2/hh6UlPuHsdJvcaxxNdrdvnkiqrdruq4glpqanUDoXBSUvQcC
        huHWHwGNxi0eAHtcIi0vJu8l80gGAAOzbSoRfrOoAQQkNVTaXjax5mOQ4ASSqxvZ
        9uxUv3y2/KU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 859E815D2C7;
        Fri, 31 May 2019 13:40:18 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAE6315D2C6;
        Fri, 31 May 2019 13:40:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make slash-rules more readable
References: <20190531074426.6810-1-admin@in-ici.net>
        <xmqqh89awprl.fsf@gitster-ct.c.googlers.com>
        <88c6cf45-3908-6561-c3bf-11adf628f8af@in-ici.net>
Date:   Fri, 31 May 2019 10:40:16 -0700
In-Reply-To: <88c6cf45-3908-6561-c3bf-11adf628f8af@in-ici.net> (Adam Nielsen's
        message of "Fri, 31 May 2019 19:24:25 +0200")
Message-ID: <xmqq1s0ewmin.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27B2715C-83CB-11E9-8EBE-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dr. Adam Nielsen" <admin@in-ici.net> writes:

>>> + - The pattern `doc/frotz` and `/doc/frotz` have the same effect
>>> +   in any `.gitignore` file. Both pattern contain a non-trailing
>>> +   slash and thus match relative to the location of the
>>> +   `.gitignore` file.
>>
>> ... this paragraph wouldn't have been necessary.
>
> I think this above example follows from (and thus isn't necessary, but
> just a fine example)
>
>     + - The pattern is matched relative to the location of
>     +   the `.gitignore` file. Except if the pattern contains
>     +   no slash [...]
>
> Because a pattern with a leading slash has a slash, it "is matched
> relative to the location of the `.gitignore` file".

But that does not explain why the pattern /doc/frotz matches the
path doc/frotz.  A reader can understand 'd' (the second letter in
the patern) would match 'd' (the firstr letter in the path), 'o'
with 'o', etc., but nobody told the reader which substring of the
path consumes the leading '/' in the pattern as matched.

>>  - A leading slash, if any, is implicitly removed before matching the
>>    pattern with the pathname, but the pattern still counts as having
>>    a non-trailing slash for the purpose of the above rule.

Yeah, that would be an addition that makes the updated text
more complete.
