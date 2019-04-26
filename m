Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AAA21F453
	for <e@80x24.org>; Fri, 26 Apr 2019 02:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfDZCmT (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 22:42:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52329 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfDZCmS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 22:42:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8EA06743B;
        Thu, 25 Apr 2019 22:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JGXN3ti67vrU1jK9/Ix/MEIZ6IY=; b=BxDrtA
        +FAv+vyVU8NE4eoT2nFVkDypLS3SNpLdGLQqK1CZsP05sgsgP/MPIlfHiYZ9eHcF
        johSFztLur94Zb8MJ1cr7VHybsQB1NsxIWBdUqJMxZeq0fFaYGIcMyG/I9k0p+kO
        EDnU/ZQDMNtJwZGaiuYoXWXfU+RgvPL1KzMd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q5AMQxJeqTH5CQ4wrPfs0j/qTrjF9Zr1
        5NDXcaHvSw50f4Kqw6QLyC2XtQLoKCFm04DZXVkNmbWmhbdU9olsRqFRhSM4uoRw
        RfajfOl/6m0Br8ZBmvL7MdKsQoifiqO8FUgrA1F7qFvtPe/BpmUQst5rUx0hC3Nb
        E74Wv62fEE0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E13896743A;
        Thu, 25 Apr 2019 22:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F3DB67439;
        Thu, 25 Apr 2019 22:42:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH] trace2: fix incorrect function pointer check
References: <548a9b833f4569c526cf94c048ae115a76d54be9.1556211995.git.steadmon@google.com>
        <20ceb5c3-f64f-be77-2d11-cb41a7045642@gmail.com>
Date:   Fri, 26 Apr 2019 11:42:12 +0900
In-Reply-To: <20ceb5c3-f64f-be77-2d11-cb41a7045642@gmail.com> (Derrick
        Stolee's message of "Thu, 25 Apr 2019 14:46:40 -0400")
Message-ID: <xmqq36m5wkqj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E69B3718-67CC-11E9-9F50-D01F9763A999-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/25/2019 1:08 PM, Josh Steadmon wrote:
>> Fix trace2_data_json_fl() to check for the presence of pfn_data_json_fl
>> in its targets, rather than pfn_data_fl, which is not actually called.
>
> [snip]
>
>>  	for_each_wanted_builtin (j, tgt_j)
>> -		if (tgt_j->pfn_data_fl)
>> +		if (tgt_j->pfn_data_json_fl)
>>  			tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,
>
> Seems obviously correct. Thanks!
>
> -Stolee

Thanks, both.  It is embarrassing and sad that nobody caught it
before it hit my tree X-<.
