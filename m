Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C697920756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031469AbdAJUT2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:19:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63536 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758491AbdAJUT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:19:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C37BC5F807;
        Tue, 10 Jan 2017 15:19:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f+Y8ao9vn+SiYwGnU8PK4KOHYsU=; b=s+IqsN
        vsYBt3Bsh5gcNI6K+pTABtZ6p/9ZhsH62C3XksCAlgdcGO9RIpWG52Q8iZo/6uEV
        TvSF4LUd69C7d5I13IeHrhlI7FzAG2X4HDxtmDUJtFP7kczrfaZv9RuxMaANZXjG
        coGDYKJaNJE7a0itI3Q1ERhm0GmkbMkfNGBwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nVhil5+9lQDJfaMC5ncU6tkYhsG3a8vO
        nQpbH6EDN/r/bqFeoucebffGov2pU6u1WuHp1pjegW3+W2D68t+LyjD5QMwuHzAJ
        HTzAtazjr/9eq9iFJ4Z+X3GzVt628mXrV83eVmYmSnQJCplRlc8JCDDqwzqsi+qX
        KBbTQL5DPmc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA70B5F806;
        Tue, 10 Jan 2017 15:19:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20F8D5F805;
        Tue, 10 Jan 2017 15:19:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: document behavior of relative diff.orderFile
References: <20170110004031.57985-1-hansenr@google.com>
        <20170110004031.57985-2-hansenr@google.com>
        <20170110065816.pu325sxajbyuqpj6@sigill.intra.peff.net>
        <e100d30a-5ee8-8485-5012-f9b1c6961ffa@google.com>
Date:   Tue, 10 Jan 2017 12:19:24 -0800
In-Reply-To: <e100d30a-5ee8-8485-5012-f9b1c6961ffa@google.com> (Richard
        Hansen's message of "Tue, 10 Jan 2017 12:27:41 -0500")
Message-ID: <xmqq4m16sm5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15184588-D772-11E6-9AF8-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Hansen <hansenr@google.com> writes:

> On 2017-01-10 01:58, Jeff King wrote:
> ...
>> What happens in a bare repository?
>>
>> I'm guessing it's relative to the top-level of the repository,
>
> I just tried it out and it's relative to $PWD.

That is understandable.  When the user says

    $ cmd -O $file

with any option -O that takes a filename, it is most natural if we
used $PWD/$file when $file is not absolute path.

