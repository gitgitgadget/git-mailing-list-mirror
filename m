Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCEDC433E2
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 22:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C19220872
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 22:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xIG0KpXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgH0W6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:58:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53918 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0W6E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 18:58:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D103F218B;
        Thu, 27 Aug 2020 18:58:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zphtEhPLc/QR
        22GBjUjvzSs6MJU=; b=xIG0KpXFoInjsU+5KP93TtJoAoE73bT5UHnnF6KITKQK
        LcVL9A8ZeC0MIUowsEzo34yz9Ghkt/w5TBhnFV2XoW9cHkWpkwA3v4eLkJh/HiRi
        SyvSpqGQ7P07e3p57cFfNZlE8RYQY0hgDZthhx/JzLbDVuoOjsLddJvWQYE2LEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=U0MALU
        QyDcVoVAKjhBlx2VC4ObzFyvwcEMwFQf41EBt5P3Tvd0AcxkjevdgeTDgii085IX
        SJH5igeTMXU6y9QfEtQ3V7JJCSgwQEibekWPNEnq5bDJUTMnzVGJr+afUcBmbVOo
        BJvcj6wBCxyL53dSHm0tlmmQF3VFNdhzy3ZA4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85E10F218A;
        Thu, 27 Aug 2020 18:58:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC589F2186;
        Thu, 27 Aug 2020 18:57:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
References: <xmqq3647rjnt.fsf@gitster.c.googlers.com>
        <C580P9BS4VYA.15I6SHXQQ35HF@homura>
        <20200827192029.GA63138@Carlos-MBP>
        <xmqqtuwnq3x1.fsf@gitster.c.googlers.com>
        <20200827220249.GA71190@Carlos-MBP>
Date:   Thu, 27 Aug 2020 15:57:56 -0700
In-Reply-To: <20200827220249.GA71190@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 27 Aug 2020 15:02:49 -0700")
Message-ID: <xmqqd03bpuh7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BFD8DA22-E8B8-11EA-A759-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Thu, Aug 27, 2020 at 12:34:02PM -0700, Junio C Hamano wrote:
>>=20
>> That feels both understandable and bogus at the same time.  To:
>> is pretty much required (yes, you can use cc: and bcc: without any
>> address on To:, but that is not something you'd usually do to send
>> patches to mailing lists), so lack of it means either asking
>> interactively or aborting.  But other things like in-reply-to are
>> optional, and tying the decision to prompt for them or not does not
>> feel OK.
>
> but trying to "fix" this breaks 10 year old tests, so it is obvious
> that everyone already expects it to work this way (probably hidden
> by the fact most people don't let git-send-email prompt for "To:")

Oh, I agree with that 100%.

> -Only necessary if --compose is also set.  If --compose
> -is not set, this will be prompted for.
> +If --compose is not set, and there is no known "To:" this will be prom=
pted for.

The updated sentence structure, with or without the mention of
"to:", reads much better than the original. =20

The original told them that they must give it from the command line
in "--compose" mode, because they will not be given the chance to
give it interactively, and the intended target audience was those
who want to send a message with in-reply-to (which is natural, as
this is a description for that option).

The updated message says the same thing, but is audience-neutral and
tries to be more useful to folks who are not responding to any
message.  I.e. outside "--compose" mode, you'll be asked if you want
to make it a response, unless you gave "to:".

By losing the "we won't ask so you must give it from the command
line" message in the original, the resulting description has become
easier to follow, I think.  Those who do want to add the header,
when they reach this description in the manual, already knows that
there is a command line option.

To help those who do not want to add this header, it would probably
be more helpful to tell what to do when prompted (like "you can give
an empty answer to tell the command that you are not responding to
any message").

Thanks.

