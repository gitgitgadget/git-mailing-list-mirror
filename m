Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AD0C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 22:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609ED2087C
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 22:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YfvrV8L6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHZWIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 18:08:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53557 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgHZWIA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 18:08:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDAE8E9007;
        Wed, 26 Aug 2020 18:07:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u4j8DHpDld/G2/RebHo6YkWAUc8=; b=YfvrV8
        L6EmOUJqLgEzkoFoHyqGbZrhGufBLp3MMxI9/MDtcGfHqvkarFppyF3v5Sxyg91h
        BxDm0zZ+d9jlAT87yKhDLiAQbhx8lJyBpCS8mujYKDv/tKcsLhBC+sAXFOl4q9it
        oJgOLQLcHIhSjrc6faxd2o1BGha255iUSHjuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zj/OwlWoCqoBbX6PxRNuNTAIsq0BF8ib
        bwjcwctlRhxxuTW7Nml9t+s/Bb0FhTdeAtcvUerEOAX831Zi/I8WnUkPucXjN39+
        baNpe6Y3fe8foC9Z69wloN/yci/R54XhQ2C/f0rCj0To0rbuCGW0lsc9xL/7si5R
        253bYsK+cdU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E64F3E9006;
        Wed, 26 Aug 2020 18:07:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 397BCE9005;
        Wed, 26 Aug 2020 18:07:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty-options.txt: fix --no-abbrev-commit description
References: <20200826144923.16806-1-sorganov@gmail.com>
        <xmqqv9h5uw7u.fsf@gitster.c.googlers.com> <87pn7d9inu.fsf@osv.gnss.ru>
Date:   Wed, 26 Aug 2020 15:07:52 -0700
In-Reply-To: <87pn7d9inu.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        27 Aug 2020 00:55:17 +0300")
Message-ID: <xmqqr1rtt613.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9725FB12-E7E8-11EA-91BE-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> Keeping the original sentence structure, e.g.
>>
>>     ... and those options which imply abbreviating commit object names
>>     such as ...
>>
>> would have been what I wrote, instead of "either explicit or implied
>> by", though.
>
> Sorry, but it'd then read:
>
>   This negates `--abbrev-commit` and those options which imply
>   abbreviating commit object names such as "--oneline".
>
> that again essentially reduces to:
>
>   This negates "--oneline"

"--oneline" means a lot more than "do not use full object name", and
I think we are on the same page with our shared goal of not negating
everything "--oneline" means.  We just want to say the option
negates only the "do not use full object name" aspect.

"and the effect of abbreviating commit objects implied by other
options, such as '--oneline'" may be a more verbose way to say the
same thing, I would think, but that would be overkill.  I would have
expected that with common sense readers would think it would be
crazy for --no-abbrev to override everything --oneline means, but if
you found that the original risks such an interpretation, perhaps we
would need to be more verbose and explicit.  I dunno.



