Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7004F206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 16:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbcLLQqu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 11:46:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59834 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752186AbcLLQqt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 11:46:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D14B55A45;
        Mon, 12 Dec 2016 11:46:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y8uODA5Rz/eQbaatVl5sKXUMiDI=; b=kCEHD5
        TUxTBLc8YVYrA1k+E9/PSiVj3jESJ8NWhHHnlFM3sDZJz8Vc5vXpoo30GhWsOXPh
        w9/40iqrLk2VLPy554QGawDKOYUWWThx6Di39KEp1tkbeUpLGqMxTK9CvBwY12io
        aeJL1YAroNsNLKf+npnsvunQQ0VJm2P0kEM+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K890XO8jhl3Ow500MvUnaLSNFu06zcXW
        KTLniYWJs0Y+uiRjMdRNVwt+/v7hby0wDy9O1cZ8BaQq4BTSztTq28u0oej261gX
        gYFio3qXY8X5/NsVv/iTg3XSDr3M9BRQwpnFJ9JViVCgP1gxZQEBte54GEafi6ii
        EjKVgHMl3JQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6455C55A44;
        Mon, 12 Dec 2016 11:46:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEDE755A43;
        Mon, 12 Dec 2016 11:46:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 0/1] Fix a long-standing isatty() problem on Windows
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
        <xmqqmvg2nyo6.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612121052310.23160@virtualbox>
Date:   Mon, 12 Dec 2016 08:46:44 -0800
In-Reply-To: <alpine.DEB.2.20.1612121052310.23160@virtualbox> (Johannes
        Schindelin's message of "Mon, 12 Dec 2016 10:59:01 +0100 (CET)")
Message-ID: <xmqq8trlnlhn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9294D3CC-C08A-11E6-8F40-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This is a great find, and a very impactful fix, as redirecting from
>> /dev/null is how we try to force a "go interactive if talking to
>> tty" program to realize that it is not talking to a tty.
>
> Can we fast-track this to maint?

Yes, "fast-track" is a good phrase, as there is not much point
cooking a subsystem specific fix like this one that came directly
from a subsystem maintainer in 'next' for 1/2 to 2 weeks as usual.

Let's make sure that the first maintenance release won't ship
without merging this.

Thanks.
