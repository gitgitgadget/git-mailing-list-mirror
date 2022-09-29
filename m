Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58936C433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 15:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiI2P31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbiI2P3S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 11:29:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D7515D66E
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 08:29:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 019E615EA47;
        Thu, 29 Sep 2022 11:29:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dc5BfgM8lf2Iv+XHgjAWM5Oadr81rSyQVjuCxN
        w0hbc=; b=QqZDw+rNA2l6uLIH/ncURuIt6REKlg8n6X+iuUIYuGA+sb4v3ZiZJ8
        8/BUH9vDD+foFXOa/kSQCQPSXUBN+aezE8WT/TGo7iiPiJ/5Y3tWcfCecYo2/bO3
        E5wlrIQp7zhqduzvDqiAtBcgk80DFJQl9TfUwUM1mNtXIUPImPOdE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED32D15EA46;
        Thu, 29 Sep 2022 11:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6426715EA43;
        Thu, 29 Sep 2022 11:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] test-lib: have SANITIZE=leak imply TEST_NO_MALLOC_CHECK
References: <patch-1.1-e31681731b7-20220928T095041Z-avarab@gmail.com>
        <a013246a-777c-acf8-d2c1-3bf9b78aa9e8@dunelm.org.uk>
Date:   Thu, 29 Sep 2022 08:29:13 -0700
In-Reply-To: <a013246a-777c-acf8-d2c1-3bf9b78aa9e8@dunelm.org.uk> (Phillip
        Wood's message of "Thu, 29 Sep 2022 10:09:58 +0100")
Message-ID: <xmqqill6p5bq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 796BD952-400B-11ED-9339-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Oh so the LD_PRELOAD breaks both sanitizers but only one of them complains
>
>>   # Add libc MALLOC and MALLOC_PERTURB test only if we are not executing
>> -# the test with valgrind and have not compiled with SANITIZE=address.
>> +# the test with valgrind and have not compiled with conflict SANITIZE
>> +# options.
>>   if test -n "$valgrind" ||
>> +   test -n "$SANITIZE_LEAK" ||
>>      test -n "$SANITIZE_ADDRESS" ||
>>      test -n "$TEST_NO_MALLOC_CHECK"
>
> The indentation is dodgy, also it would be nice to keep these in
> alphabetical order. Other than that this looks like a sensible fix.

Thanks, both.

Will re-queue with a local fix-up for the indentation.  As to the
ordering, I usually prefer to have new ones appended to the last
unless there are other reasons, and "keep them sorted" is such a
reason, so I may do so as well while at it.



