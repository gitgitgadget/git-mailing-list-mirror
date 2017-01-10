Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33CA320756
	for <e@80x24.org>; Tue, 10 Jan 2017 22:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755192AbdAJWPQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 17:15:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64793 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754481AbdAJWPO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 17:15:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDE655F666;
        Tue, 10 Jan 2017 17:15:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y+12Vfqotvi2O0sRCNi+erUWPCk=; b=bhyD20
        xwbwCVqcFdrXz58eessAXDSwh0mw6GRM+HHy03b/KQCWUcOIgaiBjrC0EgqykHoS
        FiMncnMP3W0BLGBpX1xOQwCk1+Yx+sFwv/xyBiETBLWHlcPs5JbeHhvwSgCfqilH
        mHG66u/hMtnX2bpi4N6W5Qk70eY5OxzdcBC3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aGJ2dzHlezXCpGnBZnu3LtzYx04RFga+
        2ZJZqTQotqGy7j2kE01Bo7bZPAzfxtqKKdFyZ1OIyZ5DQBBj+mxOxRQIqYW8iZfr
        8IQ9j7PH73sRRv9VKqLqqXJ4qn0dTtfTpJjWLV0kLOn3gnxk8m4XRLcUWBhD5++S
        TC2VkRUBmW0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B58FC5F665;
        Tue, 10 Jan 2017 17:15:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21EBC5F664;
        Tue, 10 Jan 2017 17:15:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: document behavior of relative diff.orderFile
References: <20170110004031.57985-1-hansenr@google.com>
        <20170110004031.57985-2-hansenr@google.com>
        <20170110065816.pu325sxajbyuqpj6@sigill.intra.peff.net>
        <e100d30a-5ee8-8485-5012-f9b1c6961ffa@google.com>
        <xmqq4m16sm5v.fsf@gitster.mtv.corp.google.com>
        <xmqqziiyr7e9.fsf@gitster.mtv.corp.google.com>
        <9daa70e4-82b0-a82a-67b9-e893546638a7@google.com>
Date:   Tue, 10 Jan 2017 14:15:11 -0800
In-Reply-To: <9daa70e4-82b0-a82a-67b9-e893546638a7@google.com> (Richard
        Hansen's message of "Tue, 10 Jan 2017 17:01:22 -0500")
Message-ID: <xmqqtw96pno0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41D4800E-D782-11E6-9168-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Hansen <hansenr@google.com> writes:

>> A related tangent.
>>
>> I wonder if anything that uses git_config_pathname() should be
>> relative to GIT_DIR when it is not absolute.
>
> I think so.  (For bare repositories anyway; non-bare should be
> relative to GIT_WORK_TREE.)  Perhaps git_config_pathname() itself
> should convert relative paths to absolute so that every pathname
> setting automatically works without changing any calling code.

Yes, that was what I was alluding to.  We might have to wait until
major version boundary to do so, but I think that it is the sensible
way forward in the longer term to convert relative to absolute in
git_config_pathname().

Thanks.

