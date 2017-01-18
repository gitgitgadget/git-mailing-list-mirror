Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15BE31F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbdARVi0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:38:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56635 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751887AbdARViQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:38:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3882062F42;
        Wed, 18 Jan 2017 16:30:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j/GE2BnRqL8ZsFD+tTmlD5ZSZ2w=; b=XV0lVF
        tUmAZtzQr3kq2su1BEHcJQwpqt6nJZMGupNPZuCq2CjbG5lx4j4OZn/BaHbRizPY
        tT0Vs+3TJaRNw28OK/UAyXvbVGvVTZFzGfWatrdK08/EQV66/9NLuE8knPhYCSpc
        WQY3QN5HHsRwbA7ZxYemo9GmGhgSy+1Duanjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QeGPNLNkaVJ+0/2VExCFCADkUm1wdUEg
        4PKZDiOV/nzTd3F7d7Hgt3f3YD2j77cj0Q+ycgZYmLuqge8rT3jUpeVrp+1w1ASp
        Uwe41IkEKneMELZozFH1xMz4hAmMssrTzfguD9ltp2BJHjRth25bxCkm2klSy7ly
        b5ABFjjlH+o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F58262F41;
        Wed, 18 Jan 2017 16:30:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 884C162F40;
        Wed, 18 Jan 2017 16:30:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH] mingw: follow-up to "replace isatty() hack"
References: <867bafbe582df549b10729a5d688458bb6a98d51.1484741665.git.johannes.schindelin@gmx.de>
        <xmqq7f5s9nvt.fsf@gitster.mtv.corp.google.com>
        <c329c981-2b92-13b5-0561-d1d2e3fa2803@kdbg.org>
Date:   Wed, 18 Jan 2017 13:30:41 -0800
In-Reply-To: <c329c981-2b92-13b5-0561-d1d2e3fa2803@kdbg.org> (Johannes Sixt's
        message of "Wed, 18 Jan 2017 22:16:28 +0100")
Message-ID: <xmqq37gg3vjy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D58104A-DDC5-11E6-AA1A-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>>> -	dup2(new_fd, fd);
>>>  	if (console == handle)
>>>  		console = duplicate;
>>> -	handle = INVALID_HANDLE_VALUE;
>>> +	dup2(new_fd, fd);
>>>
>>>  	/* Close the temp fd.  This explicitly closes "new_handle"
>>>  	 * (because it has been associated with it).
>>>
>
> Looks good and obviously correct (FLW). I can offer a
>
> Reviewed-by: Johannes Sixt <j6t@kdbg.org>
>
> but it will take a day or two until I can test the patch.

I think a Reviewed-by is good enough, as the original

<2ce6060b891f8313cc63a95a9cba9064b7f82eb8.1482448531.git.johannes.schindelin@gmx.de>

already has "Tested-by" to indicate that as a whole this have been
tested.  The "follow-up" we are commenting on was made out of that
original to incrementally update the older version that was queued
and merged to 'master' 3 weeks ago.

Thanks.


