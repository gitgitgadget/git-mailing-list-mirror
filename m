Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F4C1F7A5
	for <e@80x24.org>; Thu, 26 Jan 2017 18:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdAZSw1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:52:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56837 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751804AbdAZSw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:52:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FCAD62880;
        Thu, 26 Jan 2017 13:45:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6rsJFVGUBtgm0nD3BAnIR8SMKj4=; b=w/qY+j
        i+JgykIQ7/8hBw/JVjM9Cokn75W6n2338m+++rYlpxwkSQlv1+Fh2pa9iu6ayUym
        hMaUZ4M5ARz5mAyD6XAD2DH5SELOdON64udbZtHbvg6RUf7P3C3GeUMl1pOtFtc0
        tlJ5oIlKzGwGgxkYF2QxTHXGjrJzKElSgA/Io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XuZSs2xempNsWGZvvTjfBlcXRytdcXa+
        L0sThwX2IbXwmStrefcKR7WdGuIDZb9t7lP3Q6YWJFuMZuNFEgzWS59ZqgKql31n
        IyT8MKAIr7okZW+LOBYBh8Hjpn+Lq1QM8J2JMqZE8m5hvWUShn5RhLByc/CMP7rN
        oyAe2kpk1zE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F33726287E;
        Thu, 26 Jan 2017 13:45:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 155146287B;
        Thu, 26 Jan 2017 13:45:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] mingw: allow hooks to be .exe files
References: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de>
        <20170125211529.jq4halip4ndbff5k@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701261321010.3469@virtualbox>
Date:   Thu, 26 Jan 2017 10:44:59 -0800
In-Reply-To: <alpine.DEB.2.20.1701261321010.3469@virtualbox> (Johannes
        Schindelin's message of "Thu, 26 Jan 2017 13:21:20 +0100 (CET)")
Message-ID: <xmqq4m0l64pg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BAB4E52-E3F7-11E6-9225-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Peff,
>
> On Wed, 25 Jan 2017, Jeff King wrote:
>
>> On Wed, Jan 25, 2017 at 05:58:42PM +0100, Johannes Schindelin wrote:
>> 
>> > -	if (access(path.buf, X_OK) < 0)
>> > +	if (access(path.buf, X_OK) < 0) {
>> > +#ifdef STRIP_EXTENSION
>> > +		strbuf_addstr(&path, ".exe");
>> 
>> I think STRIP_EXTENSION is a string.  Should this line be:
>> 
>>   strbuf_addstr(&path, STRIP_EXTENSION);
>
> Yep.
>
> v2 coming,
> Johannes

I think I've already tweaked it out when I queued the original one.
