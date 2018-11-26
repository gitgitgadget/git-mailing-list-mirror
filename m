Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018DD1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 23:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeK0K1E (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 05:27:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59273 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeK0K1E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 05:27:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6C1211987B;
        Mon, 26 Nov 2018 18:31:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jqm47accYK9exmXXa4EhF7D4mc8=; b=d1jadZ
        sM9Vaf83Hic7ZNCdLIaRK8BLx7n+QTeEVvas1A2Syc5e4SbX22E7INL+fV83CXG2
        lHydaFdrSp2dMjIRinJ7xMC+fd2vTWw/1M16hulZ5Fa3zIk980iSJDDqcjoQbLX8
        tF7FY6PAAMv9dDJG7YHcbWZbQyspax6vXtVZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U2eW4Hy4kwrieyPUY6dh8ISH+c5/djZf
        wvw3pr3ybw+CJ0foh7Di8KVkDxvpQX8oBAX7uf5nSgW72PHqvoPwp50NT9GuZtGe
        SU9BXwfXg1bZ9Emt9A4aVmh8+gxLTq5/KFSFM30DO+IweAdhVYKf2BSTL/EokhUX
        r1W3V+QZSE8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE8D611987A;
        Mon, 26 Nov 2018 18:31:16 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53973119877;
        Mon, 26 Nov 2018 18:31:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Frank =?utf-8?Q?Sc?= =?utf-8?Q?h=C3=A4fer?= 
        <fschaefer.oss@googlemail.com>, git@vger.kernel.org
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the ending of the removed line is CR+LF
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
        <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
        <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
        <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
        <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
        <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
        <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
        <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org>
Date:   Tue, 27 Nov 2018 08:31:15 +0900
In-Reply-To: <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org> (Johannes Sixt's
        message of "Mon, 26 Nov 2018 20:49:33 +0100")
Message-ID: <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EACBD14-F1D3-11E8-8949-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 26.11.18 um 04:04 schrieb Junio C Hamano:
>>
>> That does not sound right.  I would understand it if both lines
>> showed ^M at the end, and only the one on the postimage line had it
>> highlighted as a trailing-whitespace.
>
> I agree that this is a (small?) weakness. But...
>
>> When we are producing a colored output, we know we are *not* writing
>> for machines, so one way to do it would be to turn CR at the end of
>> the line into two letter "^" "M" sequence on our end, without relying
>> on the terminal and/or the pager.  I dunno.
>
> ... this goes too far, IMO. It is the pager's task to decode control
> characters.

It was tongue-in-cheek suggestion to split a CR into caret-em on our
end, but we'd get essentially the same visual effect if we added a
rule:

	When producing a colored output (not limited to whitespace
	error coloring of diff output), insert <RESET> before a CR
	that comes immediately before a LF.

Then, what Frank saw in the troublesome output would become

	<RED> -something <RESET> CR <RESET> LF
	<GREEN> +something_new <RESET> <BG_RED> CR <RESET> LF

and we'll let the existing pager+terminal magic turn that trailing
CR on the preimage line into caret-em, just like the trailing CR on
the postimage line is already shown as caret-em with the current
output.

And a good thing is that I do not think that new rule is doing any
decode of control chars on our end.  We are just producing colored
output normally.
