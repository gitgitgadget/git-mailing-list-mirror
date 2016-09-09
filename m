Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA331F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbcIITBA (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 15:01:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60578 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754674AbcIITA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 15:00:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 804AD3C7E0;
        Fri,  9 Sep 2016 15:00:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R0qicWuDAnMqs4Hz1QcsGaKgCpI=; b=ldYkTt
        io6WT9KZ6NfWQoSSuz6Q5Lq9ynpi0Vx2603v3Ct33eZbMhAV+B1/M4r0iHempBCe
        RbNu/NMVw38f70AHcVywlLFEcSrZg8LoGTaNZjowPa4hRH6xj/XwBGJffSaKksVC
        jmupjUyO1hkprQdPU9pbwJvUtEHE7MfxguqgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ggcty4Zeaa0vZtwUk9gJzyAOC8bvAWFz
        1xIPR2cHiZ4exII8gSmjCuM0lix8Nh934gfqRoRZMocbEhO5X9OIOJdMpFKZ6anm
        ICORExPZnM3kDrDETMFO0PNSqmu499DzbjVt3oEnXLoxynFKGnHgqj1AWjJPd+tZ
        271o9wo4+K0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77E213C7DF;
        Fri,  9 Sep 2016 15:00:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED2ED3C7DC;
        Fri,  9 Sep 2016 15:00:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" + "pull.rebase = preserve" - "user.email"
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
        <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
        <20160729181121.GB14953@sigill.intra.peff.net>
        <xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com>
        <20160729223134.GA22591@sigill.intra.peff.net>
        <xmqqvaz7x6vv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609091731540.129229@virtualbox>
        <xmqq7faldpgp.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 09 Sep 2016 12:00:46 -0700
In-Reply-To: <xmqq7faldpgp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 09 Sep 2016 09:09:58 -0700")
Message-ID: <xmqqk2ekc2zl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8A22A3E-76BF-11E6-93F7-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Thu, 11 Aug 2016, Junio C Hamano wrote:
>>> 
>>> Do you have a preference either way to help us decide if we want to
>>> take this change or not?
>>
>> I have no strong preference. I guess that it does not hurt to go with the
>> patch, and it would probably help in a few cases.
>
> OK.  Let me dig the change back and how well it still fits ;-)

Ah, I already had it in my tree lest I forget.  Let me mark it for
merging down to 'master'.

Thanks.
