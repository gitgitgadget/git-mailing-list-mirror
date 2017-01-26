Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D171F794
	for <e@80x24.org>; Thu, 26 Jan 2017 18:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbdAZSaF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:30:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57832 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752695AbdAZSaD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:30:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FEA56394B;
        Thu, 26 Jan 2017 13:29:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9n7pe/58vx0BUZtMqn/2MnUyo8E=; b=PfwVDC
        /cfQPA65T+Y34hHeMecTH0kzySyw7H8cf1Mf/Kh3z2HdrqykAcsgBqFA7HDb8C+m
        mCjZ0pYdgsVCO+PrhUh9UdBTRmyjwGK5O6CC9Xrm5Q7MBbXhJZpZMnug0IsnP/nk
        iFjxdc56g7EJkUbRLFAbR0h26LsRZMTowfq0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DM/nF7TZhdE40ioqguqskscTnqLRK87f
        huAwk0YrWmxLKw/2KtIYJAq7uNV7vyT6qsQO0ySt06MliUiNrUNviFKJbANCTGIL
        ycmVA/8YF/XNjbm23wyt7jwZgFOw4qcbX9vKZ8bRb03X1Kd0BRCqY+vZE6s75MmT
        rquuU2r1gdo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 770676394A;
        Thu, 26 Jan 2017 13:29:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D178B63948;
        Thu, 26 Jan 2017 13:29:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Add some output from gpg when it errors out.
References: <20170125030434.26448-1-mh@glandium.org>
        <xmqqtw8m7ncp.fsf@gitster.mtv.corp.google.com>
        <20170125235410.byxwmo7o7zdszzot@glandium.org>
        <xmqq8tpy7dh8.fsf@gitster.mtv.corp.google.com>
        <20170126025530.r4fesye447do5wdx@glandium.org>
Date:   Thu, 26 Jan 2017 10:29:16 -0800
In-Reply-To: <20170126025530.r4fesye447do5wdx@glandium.org> (Mike Hommey's
        message of "Thu, 26 Jan 2017 11:55:30 +0900")
Message-ID: <xmqqh94l65fn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58DCD9B6-E3F5-11E6-B982-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

>> With that information recorded in the log (or in-code comment, or
>> both), if it turns out that some lines with the prefix are useful
>> (or some other lines without the prefix are not very useful), they
>> can tweak the filtering criteria as appropriate, with confidence
>> that they _know_ for what purpose the initial "filter lines with the
>> prefix" was trying to serve, and their update is still in the same
>> spirit as the original, only executed better.
>
> Come to think of it, and considering that mutt happily signs emails in
> the same conditions, maybe it would make sense to just ignore gpg return
> code as long as there is a SIG_CREATED message...

I do not think we want to go there.  If GPG reports failure, there
is something funny going on.
