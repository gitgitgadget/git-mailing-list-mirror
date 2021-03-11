Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2F5C433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 05:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB8D64FC4
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 05:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCKFhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 00:37:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60603 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhCKFhc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 00:37:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 301901269DE;
        Thu, 11 Mar 2021 00:37:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hgvVQ9JNaA9sLyJAH7XouFwWFnY=; b=P1PWeP
        up8SMegt6yU/fE2ga+pIyDJRgfNOrtEBHhgDKQSnbw5Ef/DD8wvQ/Jk61igMUAcw
        sBkeTu2C8R2xKa1dzqgMbaZa58b0IT0ndEdLL1ZZzea1ZUfK06LaAemZEnNJhesX
        hrdys85BBs1FmGpm6T9UJv97vi0PhlMIQWWA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h6Ctzr3inC/SXhGVnHpqrRnnct0WFUY9
        4KKtUU0upo9SJmsmm8ZSCJuZdebYjHoIdn4psK9pqva9APEuyn95A8nRsMhhsXIq
        qYJhzKq7u3MreZP4e/7SNhynayu0C3KZPjZA7gU6Xe3tXXotZoGnvdhmQHQ4OV8m
        eCnXRCwbT58=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 292211269DD;
        Thu, 11 Mar 2021 00:37:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7173C1269DC;
        Thu, 11 Mar 2021 00:37:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 3/6] commit: add a reword suboption to --fixup
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210310194306.32565-4-charvi077@gmail.com>
        <xmqqpn06h6os.fsf@gitster.g>
        <CAPSFM5dqRbuoCvEFcHQPSQt+EK1_pBVQ--f42jR+GNqCFd_SOg@mail.gmail.com>
Date:   Wed, 10 Mar 2021 21:37:27 -0800
In-Reply-To: <CAPSFM5dqRbuoCvEFcHQPSQt+EK1_pBVQ--f42jR+GNqCFd_SOg@mail.gmail.com>
        (Charvi Mendiratta's message of "Thu, 11 Mar 2021 09:31:59 +0530")
Message-ID: <xmqqa6rafdyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE9A0EA6-822B-11EB-8841-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> On Thu, 11 Mar 2021 at 06:01, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Charvi Mendiratta <charvi077@gmail.com> writes:
>>
>> >                * reference for example: --fixup="HEAD^{/^area: string}" or
>> >                * a suboption of `--fixup`.
>> >                *
>> > -              * As `amend` suboption contains only alpha character.
>> > -              * So check if first non alpha character in fixup_message
>> > -              * is ':'.
>> > +              * As `amend`/`reword` suboptions contains only alpha
>> > +              * characters. So check if first non alpha character
>> > +              * in fixup_message is ':'.
>>
>> Sorry, but I cannot quite follow the logic.
>>
>>         We limit --fixup's suboptions to only alpha characters.  If
>>         the first character after a len of alpha is colon, then the
>>         part before the colon may be a known suboption name like
>>         `amend` or `reword`, or a misspelt suboption name.
>>
>>         Otherwise, we are dealing with --fixup=<commit> that happens
>>         to have a colon in <commit> object name.
>>
>> perhaps?
>
> Yes, Agree. Here I just intend to mention the special case
> "--fixup=HEAD^{/^area: string}" because of which we chose the method
> to check if first non alpha char is ':' instead of directly checking
> the suboption like (skip_prefix(msg, "amend:", &arg). So maybe we can
> reword it like
>
> - To check if fixup_message that contains ':' is a commit
> - reference for example: --fixup="HEAD^{/^area: string}" or
> - a suboption of `--fixup`.
> + fixup_message could be a commit reference for example:
> + --fixup="HEAD^{/^area:string}" or a suboption of `--fixup`.
> +
> + As `amend` ...

My suggestion primarily started a reaction to that "As `amend`..."
which was not gramatically complete sentence, and I ended up
rewriting everything after "As `amend`..."

But re-reading what is in the paragraph before, I tend to think that
it places too much stress on 'colon' and should be removed.

The comment is about what is being parsed, so

         We limit --fixup's suboptions to only alpha characters.  If
         the first character after a run of alpha is colon, then the
         part before the colon may be a known suboption name like
         `amend` or `reword`, or a misspelt suboption name.  In
         either case, we treat it as --fixup=<suboption>:<arg>

         Otherwise, we are dealing with --fixup=<commit>.

would be good.  The code, when it decides it is not in the
--fixup=<suboption>:<arg>  form but it is --fixup=<commit>, does not
even care about a colon, so there is no need to mention colon in the
"Otherwise" part.
