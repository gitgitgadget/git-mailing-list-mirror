Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BA6C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABC661184
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhETGiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:38:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51224 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETGiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:38:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 328E2BADFF;
        Thu, 20 May 2021 02:37:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rRJF5b+3yOGCr8vh4xiBVzGaEzud6c3H7pzPzW
        HnGFQ=; b=O9xBjriE/Iugy7bB4KOt7rp1N2vB1wJNugh71LkFTbgZjk82bawx3T
        c1IsxuBbcZbkVP13fvs9bERoHY106syP3dKtJzUaRh4mDFrx7fzYmPDnhOOfmhF5
        Q1u7hS/nPd2GJ5RZLJmCB4/L6KXkW51N96zniXas7vIhQjxXsqcrM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2809BBADFE;
        Thu, 20 May 2021 02:37:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1410BADFD;
        Thu, 20 May 2021 02:36:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] doc: explain the use of color.pager
References: <YKTXlTjwOUi4W+R8@coredump.intra.peff.net>
        <YKVsw3uqb66ifzvd@google.com>
Date:   Thu, 20 May 2021 15:36:59 +0900
In-Reply-To: <YKVsw3uqb66ifzvd@google.com> (Jonathan Nieder's message of "Wed,
        19 May 2021 12:53:39 -0700")
Message-ID: <xmqq5yzdvrlg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C786431A-B935-11EB-9833-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> The current documentation for color.pager is technically correct, but
>> slightly misleading and doesn't really clarify the purpose of the
>> variable. As explained in the original thread which added it:
>>
>>   https://lore.kernel.org/git/E1G6zPH-00062L-Je@moooo.ath.cx/
>>
>> the point is deal with pagers that don't understand colors.
>
> Missing "to" before "deal".

Will locally amend.

> More importantly, I think I'd find a
> reference to the commit or a quotation from the affected user more
> helpful than a reference to the mailing list archive, since that would
> make this a bit more self-contained.

The original commit and its log message we ended up with did not
explain the motivation behind well enough.

The motivation from the original thread:

      When I use a pager that escapes the escape character or highlights the
      content itself the output of git diff without the pager should have
      colors but not with the pager.  For example using git diff with a
      pathspec is quite short most of the time.  For git diff I have to
      enable paging manually and run git diff | $PAGER usually but git log
      uses the pager automatically and should not use colors with it.

can be quoted as a whole, but "the point is to deal with ..." is a
succinct summary that is good enough for the purpose of this commit,
I would think.

>> +	A boolean to specify whether `auto` color modes should colorize
>> +	output going to the pager. Defaults to true; set this to false
>> +	if your pager does not understand ANSI color codes.
>
> I quite like the "set this to false if your pager does not understand
> ANSI color codes" part --- short and to the point.
>
> The sentence before takes me long enough to understand that I don't
> think we've gotten the wording right yet.  Before I suggest some
> wording, let's make sure I understand the behavior correctly:
>
> - unlike other color.* settings, this can only be "true" or "false".
>   It cannot be "auto".

Correct.

> - in other color.* settings, "auto" means "colors are used only when
>   stderr goes to a terminal".  A pager typically ultimately writes to
>   a terminal, but (1) it's not guaranteed to (e.g., xless writes to
>   its own window instead) and (2) more importantly for us, it's not
>   guaranteed to write terminal escapes as is.

Correct---color.pager is about telling Git about the pager's capability.

> - so this setting can be used to answer "for the sake of evaluating
>   color settings, should we treat output that is going to a pager as
>   going to a terminal?"

I am not sure if that is the easiest-to-explain way to view it.
It's more like "color.diff says 'auto', so we'd color it when the
output is going to tty and the terminal is not dumb.  We'd also
color it when our output is not directly going to tty (because we
are writing to a pipe whose other end is being read by the pager)
but we know we are talking to a pager, BUT the pager may not be able
to handle coloured output correctly---so we need a way to say "no,
even though our output goes to the pager, we cannot colour the
output".

> If I understood correctly, how about some text like the following?
>
> 	A boolean to specify whether `auto` color modes should colorize
> 	output going to a pager, in addition to their behavior of
> 	colorizing output going to a terminal. Defaults to true; [etc]

The variable has no control over what happens to output that
directly goes to a terminal, so while the additional phrase might
not be technically wrong per-se, I do not see why this is more clear
than the original.

So, in short, I think it would be sufficient to amend the proposed
log message with s/deal with/to deal with/ and nothing else.

Thanks.
