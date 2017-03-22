Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D993220323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdCVVaC (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:30:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58475 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751159AbdCVVaA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:30:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA7F47FEBA;
        Wed, 22 Mar 2017 17:29:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/6rhQKQlXxZpPtir4Qk6Gop+jfY=; b=IULlEp
        GyQEv370XEc/kKDsHqz1V26mVtp+9fb5kItOenWbwyEwtGJ+An/yr/2M/o+0fgsM
        3ikLlcPwex9FelX0Q+0TVTh9/uep70rgw2WWE8lhe5EVEvwp3pSg5H38tpcK+Vk7
        X5n6CS6JOvw8QHbUhoSo12x02tBLD00kFgbCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=geaUG9K9w+0wKl2OBdOpLEuJTuC2XlCp
        nZLyOw5h30/axtiXqqfoJV5rI/Qsn44r0FqRNXkbjdiEqqG3Gz3e6lzCO9gzMb1G
        OOMAKfPsF4xfkN3LvhGVyt/ze5kH7wzvITqJ05wBEGuknx6UoEjzWcpRXwzHwuUm
        lLouFk6+vME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2A3B7FEB9;
        Wed, 22 Mar 2017 17:29:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 252287FEB8;
        Wed, 22 Mar 2017 17:29:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/6] thread lazy_init_name_hash
References: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
        <xmqqshm5je4d.fsf@gitster.mtv.corp.google.com>
        <xmqq60j1jalv.fsf@gitster.mtv.corp.google.com>
        <1a23fa5d-3b80-ca47-fcaa-56f794699aab@jeffhostetler.com>
Date:   Wed, 22 Mar 2017 14:29:57 -0700
In-Reply-To: <1a23fa5d-3b80-ca47-fcaa-56f794699aab@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 22 Mar 2017 17:04:49 -0400")
Message-ID: <xmqqk27hhuei.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2E68ED0-0F46-11E7-936B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 3/22/2017 4:54 PM, Junio C Hamano wrote:
>>>
>>> Thank you for an update.
>>
>> One notable difference I noticed since the previous round is that
>> this no longer adds precomputed hash to "struct cache_entry".  As
>> you are aiming to manage an index with a large number of entries,
>> this is a welcome change that makes sense.
>
> Yes, this completely isolates the changes inside the name-hash.c
> code.  And it eliminates the need to update/invalidate the precomputed
> hash values as entries are changed.

Thanks.  Having a summary like that for differences since the last
round in the cover letter would help during the review, but this is
an example that lack of such a summary would be one way to make sure
that reviewer(s) are paying attention ;-)

