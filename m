Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD563C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8057A20714
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TuwjBP8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgH0TeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:34:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63176 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgH0TeG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:34:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FC27741E1;
        Thu, 27 Aug 2020 15:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L0QTj52gtkCI
        OiazIFjQNdtZ5Ss=; b=TuwjBP8X4PMEcA/Uk1WPvzRYL/uiDEmF7msyGXXtBVbI
        JILrk/SSXLjxEZOmqweV9vBlqD7wC4+A32Ub17sw1upSX8mZ+Y/bou/n2FGyh5Oz
        RFLTJXL1XSw1YlT+y0LTSKnDyHc6Yp690lKjlVD3fwYt0PBI5nbH7NyQuFY1Efw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AbRvUP
        89g3PBqvmhdZHR8JIj3clfbaSOeUKYo/4GB+eR4H8XAWx+wJ3abCqPtxhkvkxxnS
        FFfNtKCfA+5jnvANJDaF7cRnIJR3bPnL68z4aQ88PCs8iKY/mMcgWhoyuLJDHR0p
        JXHiZYVsHJRVZY97yOg/je7vaTuG/KjOJtvgM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 466EE741E0;
        Thu, 27 Aug 2020 15:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C4BF741DF;
        Thu, 27 Aug 2020 15:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
References: <xmqq3647rjnt.fsf@gitster.c.googlers.com>
        <C580P9BS4VYA.15I6SHXQQ35HF@homura>
        <20200827192029.GA63138@Carlos-MBP>
Date:   Thu, 27 Aug 2020 12:34:02 -0700
In-Reply-To: <20200827192029.GA63138@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 27 Aug 2020 12:20:29 -0700")
Message-ID: <xmqqtuwnq3x1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 439F8850-E89C-11EA-BC13-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Thu, Aug 27, 2020 at 03:14:57PM -0400, Drew DeVault wrote:
>> Do you have sendemail.to set in your local git config?
>
> I do and can't reproduce either; which version of git do you have this
> problem with?

Any recent version of git-send-email, I would say.  The relevant
code snippets are:

    my $prompting =3D 0;
    if (!@initial_to && !defined $to_cmd) {
            my $to =3D ask("$to_whom ",
                         default =3D> "",
                         valid_re =3D> qr/\@.*\./, confirm_only =3D> 1);
            push @initial_to, parse_address_line($to) if defined $to; #
            $prompting++;
    }
    ...
    @initial_to =3D process_address_list(@initial_to);
    @initial_cc =3D process_address_list(@initial_cc);
    @initial_bcc =3D process_address_list(@initial_bcc);

    if ($thread && !defined $initial_in_reply_to && $prompting) {
            $initial_in_reply_to =3D ask(
                    __("Message-ID to be used as In-Reply-To for the firs=
t email (if any)? "),
                    default =3D> "",
                    valid_re =3D> qr/\@.*\./, confirm_only =3D> 1);
    }

where initial_to is set either from the command line or sendemail.to
configuration variable and before the control reaches this section
of the code.  In addition to realizing "ah, To: address is not given
so we need to ask" and ask the to address, it says "since we have
already interatively asked the end-user anyway, we can and should
ask other things as well" by incrementing $prompting.

That feels both understandable and bogus at the same time.  To:
is pretty much required (yes, you can use cc: and bcc: without any
address on To:, but that is not something you'd usually do to send
patches to mailing lists), so lack of it means either asking
interactively or aborting.  But other things like in-reply-to are
optional, and tying the decision to prompt for them or not does not
feel OK.

