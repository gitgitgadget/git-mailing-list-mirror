Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76D520756
	for <e@80x24.org>; Fri, 20 Jan 2017 23:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbdATX3c (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 18:29:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59167 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751125AbdATX3b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 18:29:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B8E563C57;
        Fri, 20 Jan 2017 18:29:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VucbDNOvU5yX41bjo5giKtSq8iw=; b=Mzx4Tf
        coY3WtqTPfczcaOUnX11cZPODyXTKnhitoZ+nY+34lF5f/gUQYgHXVz8w6Hh0nmt
        BSzKoJQyv4/16EB2jLTBFNJxta1zVvE1BF9yFltap+UNasZobiJhxpB6NUG1MhQ+
        iRMen5bL5GoXuW+S9sKgIRbv4dOAgotYfRik0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sFMoBftqql0iVDKa7/48VFmIteYxej61
        7XERrTEkZqUqryKVyVNNO0fA5Swj7I9qz7BiXf3OqO3EVKDUGREXAEH6PmydvE52
        rlfgXzkBa85bRVp5M+gPzz3T58iyKVvsdZ8KANKBPuuwpwQyGVhFvYUhAW3+i/cB
        Sz4sHUL0RsM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5397C63C56;
        Fri, 20 Jan 2017 18:29:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4E2F63C55;
        Fri, 20 Jan 2017 18:29:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Panteleev <thecybershadow@gmail.com>
Cc:     Vladimir Panteleev <git@thecybershadow.net>, git@vger.kernel.org
Subject: Re: [PATCH] show-ref: Allow --head to work with --verify
References: <20170120155015.4360-1-git@thecybershadow.net>
        <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
        <3b1d2717-dd7f-2add-b935-3ace6063b258@gmail.com>
        <xmqqshoduxnj.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 20 Jan 2017 15:29:28 -0800
In-Reply-To: <xmqqshoduxnj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 20 Jan 2017 15:20:00 -0800")
Message-ID: <xmqqo9z1ux7r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A4D958E-DF68-11E6-8E06-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If two codepaths are called "I don't see a meaningful difference",
> then it is really better to share the same code.  Today, they may
> happen to behave identically.  When we need to update the behaviour
> of one, we'd be forced to update the other one to match.
>
> IOW, something along this line, perhaps (not even compile tested so
> take it with grain of salt).

By the way, I have no strong preference between "read-ref, check
quiet and show-one" and "show-ref", so if you make --verify to
consistently call "show_ref()" for both refs/heads/master and HEAD,
that is also perfectly fine.

I just do not want to see the same feature/codepath to call two
different implementations that happens to do the same thing today.

Thanks.
