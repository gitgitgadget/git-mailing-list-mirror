Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D2520756
	for <e@80x24.org>; Tue, 17 Jan 2017 19:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbdAQTSK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 14:18:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54877 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750929AbdAQTSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 14:18:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F16161D39;
        Tue, 17 Jan 2017 14:17:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9BlKek2jW4FQ7JVVCKG7sTI0MAk=; b=j9PFfw
        lgumd/qammxXbTl4u+srjxB/S23e4IVs8S1wvOYl1tQwi84mbJNBR6Yc50bwLiYA
        lubcVojzI2ugtRSMRZL2mayd7wSxzy+uHD6hKrlUVfwZL4ObPL/nknYzO4DWMtBJ
        3b0wMmGiaR0h4AmqtbqvgdmqUwAR3RjhqsAec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lhDmFR5N9Piay/GVGrUuTC3P49PvFkN2
        BbCdTlLTQyzfI6JwwvZ6BMflJddprBr7ohwptG95dAZPrhQAkAd3o3vPmLitz3M6
        gqbEjg3RwOmmB2wAUlnYeYzBNBvTFOSS0Kj0WAwZGH5wMNqauVL8BWGIPDG97y1x
        xTBq000fXhw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76E4F61D38;
        Tue, 17 Jan 2017 14:17:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBF8161D37;
        Tue, 17 Jan 2017 14:17:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
        <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
        <alpine.DEB.2.20.1701161251100.3469@virtualbox>
        <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701161746200.3469@virtualbox>
        <677a335f-889c-2924-b7bd-93c2b6663175@kdbg.org>
        <20170116214411.a6wnp66vxydmpmgw@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 11:17:12 -0800
In-Reply-To: <20170116214411.a6wnp66vxydmpmgw@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Jan 2017 16:44:11 -0500")
Message-ID: <xmqqo9z5fqdj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D529018-DCE9-11E6-83A8-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jan 16, 2017 at 09:33:07PM +0100, Johannes Sixt wrote:
>
>> However, Jeff's patch is intended to catch exactly these cases (not for the
>> cases where this happens accidentally, but when they happen with malicious
>> intent).
>> 
>> We are talking about user-provided data that is reproduced by die() or
>> error(). I daresay that we do not have a single case where it is intended
>> that this data is intentionally multi-lined, like a commit message. It can
>> only be an accident or malicious when it spans across lines.
>> 
>> I know we allow CR and LF in file names, but in all cases where such a name
>> appears in an error message, it is *not important* that the data is
>> reproduced exactly. On the contrary, it is usually more helpful to know that
>> something strange is going on. The question marks are a strong indication to
>> the user for this.
>
> Yes, exactly. Thanks for explaining this better than I obviously was
> doing. :)

Yup.  In the "funny filename" case, the updated code indeed is doing
the right thing.  So one remaining possible issue is if we ourselves
deliberately feed a raw CR (or any non-filtered control code) to
error() and friends because their native effect (like returning the
carriage to overwrite what we have already said with the remainder
of the message by using CR) to functions that go through vreportf()
interface.  I personally do not think there is any---the progress
meter code does use CR for that but they don't do vreportf().

I do not think we write "message\r\n" even for Windows; we rely on
vfprintf() and other stdio layer to turn "message\n" into
"message\r\n" before it hits write(2) or its equivalent?  So I
understand that this should affect LF and CRLF systems the same way
(meaning, no negative effect).

So... can we move this forward?

