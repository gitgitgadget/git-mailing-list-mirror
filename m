Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37EEA202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 00:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbdJ3A35 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 20:29:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751429AbdJ3A35 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 20:29:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32DC7B9C7C;
        Sun, 29 Oct 2017 20:29:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k8JN6k75/+Qa54UBUXKOWwdSi5c=; b=SKIq9m
        +t05M2SZhs+3apPbhAZ6Yg19a/VQAsN+1zRswj1O9Lo0Ha9P83ka/ryiXX3uveGk
        nSCvNZRrxn8rsfSLU7hwmdpjaDEB4tbVQjS+AyZz2hvIdJ0f2Yd0GtH/hHSnUSTS
        +VyHufYs2WEBPb+HYBikTIUAPYGR/+gccqqlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rPUJUUk40Wb7ghNNOrOdMW9gf/a3rrsq
        Xv7MOE78FtWaT1WSPV7YuGJJtt8swXPQcaOgXiwUXc3zedjxF91cRMSVMuXqglG5
        RPYo25ZzrtFMtyVsfzfbngxGsenbQ534HLrHfTZHOn4Ma8xTDt4YJTbw1gtZZU8e
        guxeC9rHZkM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A90FB9C7B;
        Sun, 29 Oct 2017 20:29:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F4AAB9C7A;
        Sun, 29 Oct 2017 20:29:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff: convert flags to be stored in bitfields
References: <20171027222853.180981-1-bmwill@google.com>
        <20171027222853.180981-4-bmwill@google.com>
        <xmqqk1zeafaq.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 30 Oct 2017 09:29:52 +0900
In-Reply-To: <xmqqk1zeafaq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 29 Oct 2017 10:55:25 +0900")
Message-ID: <xmqqzi898olb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72CF5F18-BD09-11E7-A66F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I still haven't brought myself to like the structure being passed by
> value and the singleton diff_flags_cleared thing, but I suspect that
> we may get used to them once we start using these.  I dunno.

Just bikeshedding, but I just had to prepare an evil merge to add a
new use of diff_flags_cleared to a codepath that evolved in a topic
still in flight, and realized that I really hate the name.  Perhaps
I wouldn't have hated it so much if it were named diff_flags_none or
diff_flags_empty, I guess.
