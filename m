Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E1E1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 22:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbcH3WXP (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 18:23:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50391 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751143AbcH3WXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 18:23:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C628F3AA50;
        Tue, 30 Aug 2016 18:23:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dM2Ma8hEAEyCrhLCfTgBqB7zxZI=; b=wphbhy
        ZhRF+ChCrI0SIB9uGlBao7TI0y+j5mwBYpG1LiL8/hhNd1B8RqOCxYKtWA9pm4X8
        nxKqkjT4Q8WIm7QMSN4BjQO9pdAa8e5aRhlimy44IG7QNAxh7DL+LgXvxqjgV6Xa
        hdgJIIhx8+MwgNikvBLKh3AawRJjtgfi2ZmcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nd+iyhEdVOf1duA2kI9b1RD4nLF9rcsi
        1dzgbZcJFjVZMZejnI09GhbiulHcEdw7dB5st6pnMbbzVl4b7uYbVBmNih7ou///
        7Ct9qADmZQTKc0JtLTRJB4At/vCRuqyBjx3HHuft8bIpEL8oEzJUhJjPM7cnGV4x
        ALj8xQFuINs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE5B73AA4E;
        Tue, 30 Aug 2016 18:23:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4838F3AA49;
        Tue, 30 Aug 2016 18:23:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 12/13] convert: add filter.<driver>.process option
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-13-larsxschneider@gmail.com>
        <xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com>
        <7A378528-58DE-4C17-9F00-9708947716DD@gmail.com>
        <xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com>
        <4020D8E2-77D9-46AE-95DC-F644F7C6FDAF@gmail.com>
Date:   Tue, 30 Aug 2016 15:23:10 -0700
In-Reply-To: <4020D8E2-77D9-46AE-95DC-F644F7C6FDAF@gmail.com> (Lars
        Schneider's message of "Tue, 30 Aug 2016 22:38:15 +0200")
Message-ID: <xmqqmvjt3nht.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56870930-6F00-11E6-9F0E-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> On 30 Aug 2016, at 20:59, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>>> "abort" could be ambiguous because it could be read as "abort only
>>> this file". "abort-all" would work, though. Would you prefer to see
>>> "error" replaced by "abort" and "error-all" by "abort-all"?
>> 
>> No.
>> 
>> I was primarily reacting to "-all" part, so anything that ends with
>> "-all" is equally ugly from my point of view and not an improvement.
>> 
>> As I said, "error-all" as long as other reviewers are happy with is
>> OK by me, too.
>
> Now, I see your point. How about "error-and-stop" or "error-stop"
> instead of "error-all"?

Not really.  I was primarily reacting to having "error" and
"error-all", that share the same prefix.  Changing "-all" suffix to
"-stop" does not make all that difference to me.  But in any case,
as long as other reviewers are happy with it, it is OK by me, too.

> Good argument. However, my intention here was to mimic the v1 filter
> mechanism.

I am not making any argument and in no way against the chosen
behaviour.  That "intention here" that was revealed after two
iterations is something we would want to see as the reasoning
behind the choice of the final behaviour recorded somewhere,
and now I drew it out of you, I achieved what I set out to do
initially ;-)

> I am not sure I understand your last sentence. Just to be clear:
> Would you prefer it, if Git would just close the pipe to the filter process
> on Git exit and leave the filter running?

As a potential filter writer, I would probably feel it the easiest
to handle if there is no signal involved.  My job would be to read
from the command pipe, react to it, and when the command pipe gives
me EOF, I am expected to exit myself.  That would be simple enough.

>> I meant it as primarily an example people can learn from when they
>> want to write their own.
>
> I think `t/t0021/rot13-filter.pl` (part of this patch) serves this purpose 
> already.

I would expect them to peek at contrib/, but do you seriously expect
people to comb through t/ directory?
