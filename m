Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A7520281
	for <e@80x24.org>; Fri,  3 Nov 2017 01:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934695AbdKCBrv (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 21:47:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62678 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932285AbdKCBru (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 21:47:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42B1B9A11A;
        Thu,  2 Nov 2017 21:47:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+tqUSAEg9ZPSjIcERtzZdVtPRP8=; b=YqkTlG
        gFHOGeFIthnCp1JWf6pqYaYOv/HvI9q3pB41qaNYR6NhBEUGW4OAAkuBaF5nPAjN
        LmdldyyiYolJkA/yl0vLj6xQDHDL0Cejbxy0/J7OqY3f65PnG1w3CqEJXilBMoTx
        z6ODZKVRTtiEfYMJmIT3kfb9d1JmO4i1cDtdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SNbq/FXLdJwbBz4r6OrwnY3R2DvnNyYK
        4I6aBGV/YPbl4zwQUxhxBp2RjAOzMVA0ohJPKkG1ArhrrdGPOm8DZ5SvYty1dc/Q
        HwmzFNW95tZyE1AMI08rofLV8AlslJhA40uUj2MMC6a/38mjVMmyw2PHIg9nof3d
        P4huQPh78DM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ABDB9A119;
        Thu,  2 Nov 2017 21:47:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B279A9A118;
        Thu,  2 Nov 2017 21:47:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] wrapper.c: consistently quote filenames in error messages
References: <22afeefa-cdd5-cd32-0a7c-6bad4de79f05@web.de>
        <32c515d01d4257c1532004d0bf21b2c330f6b81b.1509547231.git.simon@ruderich.org>
        <xmqqvaitqon6.fsf@gitster.mtv.corp.google.com>
        <xmqqlgjpqmyj.fsf@gitster.mtv.corp.google.com>
        <20171102102031.v266n6nf6vftglu6@ruderich.org>
Date:   Fri, 03 Nov 2017 10:47:48 +0900
In-Reply-To: <20171102102031.v266n6nf6vftglu6@ruderich.org> (Simon Ruderich's
        message of "Thu, 2 Nov 2017 11:20:31 +0100")
Message-ID: <xmqq4lqcqgjf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF9FF038-C038-11E7-BC86-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Ruderich <simon@ruderich.org> writes:

> On Thu, Nov 02, 2017 at 02:16:52PM +0900, Junio C Hamano wrote:
>> Junio C Hamano writes:
>>> This patch is incomplete without adjusting a handful of tests to
>>> expect the updated messages, no?
>>
>> I'll squash these in while queuing, but there might be more that I
>> didn't notice.
>
> Sorry, didn't think about the tests.

Heh, tests are not something you need to think about, if you always
run them after making changes.

> I've re-checked and I think those are the only affected tests.
> The test suite passes with your squashed changes.

OK.  Thanks.
