Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AE81FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755450AbcH2TxE (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:53:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62877 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755269AbcH2TxC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:53:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B080539A61;
        Mon, 29 Aug 2016 15:53:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ufJc/Ct0oVvDJrMSeAVXPPFUR7o=; b=FgJwaL
        l0f32ahEbLrSUuwfL86xwsyl7qOoE9iIPEaIEjuGTmqFIKMsQ1BYXW/L4afwNFEk
        Uh4efXssjU87MyAGVu0fwK0ATs1QCDv2TvE9mYokclQtMPW4ki6nGbIXX2uXxcet
        KzS5Nn+HGx7zLXp+uXA4prkaIDh0rJXTPgv38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uxJjKB3dtSJ9KkW1NzCMtZC0DuYV/zGX
        F3sjgz9EbjjEwZduwPgbwiV0R0sllnGQP537z7FvTqV3HJr7+Z0v2s+W6Dyceqsy
        4b4RBncV71xsE4UwQkRgV6+59jYEjujxwqYoHJEMycziDto87domv6/Y8avJudnU
        bA5ePjDQfQk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8D6D39A60;
        Mon, 29 Aug 2016 15:53:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D22039A5F;
        Mon, 29 Aug 2016 15:53:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v13 00/14] libify apply and use lib in am, part 3
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
        <xmqq7fazbdmk.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 29 Aug 2016 12:52:59 -0700
In-Reply-To: <xmqq7fazbdmk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 29 Aug 2016 12:04:35 -0700")
Message-ID: <xmqqtwe39wtg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 310E4684-6E22-11E6-8B1F-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> Highlevel view of the patches in the series
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> This is "part 3" of the full patch series. I am resending only the
>> last 14 patches of the full series as "part 3", because I don't want
>> to resend the first 27 patches of v10 nearly as is.
>
> Just to make sure, you are sending the first 11 of these 14 exactly
> as-is, right?  I didn't spot anything different other than 12 and 13
> that replaced the "alternate index" step from the previous round.

In any case, I didn't spot anything glaringly wrong in the updated
part of the patches.  I'll wait for a few days and then mark it as
'Will merge to next' unless we hear comments from others.

Thanks.
