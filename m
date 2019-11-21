Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE780C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8730920878
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wmH0McnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfKUAjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:39:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52963 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfKUAjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:39:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EE22A0647;
        Wed, 20 Nov 2019 19:39:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Irk/thrMiurM/kbh+NizPk9DvDU=; b=wmH0Mc
        nHIefn8v2jLnE7wL2739uIzgRd0iq7mB3gsIIfQehiihJNGwMkXKG35ne2tcIL4q
        KtxnsEgWrwhOn3NxJdHmVYe5Q6mj4RDfqk2GTFZqXW8d7tJoDOPrTb+5W/CA7Lkf
        HvYJMCT5oX/HZ2SdaP2RPMtWQLzZsXVMq6YBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JdFN6gaZ3fTXg9szhRh88+nAChLzytun
        Rn52OJUBqooudbFrjtf1AlE9tfbSaFYh+aUzZy8yPvE/ohAldvlcgJX3r5XYQ26y
        j7FtWilr7IxTxJK8DPF7usGftXZA9If69ZuNjJA3qPVeWxhLXb8Mxb8PuqBwMyvS
        WrhTGbMlMl8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6814BA0646;
        Wed, 20 Nov 2019 19:39:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9657EA0644;
        Wed, 20 Nov 2019 19:39:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2019, #03; Tue, 19)
References: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
        <20191120233214.GA17235@generichostname>
Date:   Thu, 21 Nov 2019 09:39:08 +0900
In-Reply-To: <20191120233214.GA17235@generichostname> (Denton Liu's message of
        "Wed, 20 Nov 2019 15:32:14 -0800")
Message-ID: <xmqqtv6y9i6r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 556D9A86-0BF7-11EA-9E6B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> * dl/t5520-cleanup (2019-11-19) 14 commits
>>  - t5520: replace `! git` with `test_must_fail git`
>>  - t5520: remove redundant lines in test cases
>>  - t5520: replace $(cat ...) comparison with test_cmp
>>  - t5520: don't put git in upstream of pipe
>>  - t5520: test single-line files by git with test_cmp
>>  - t5520: use test_cmp_rev where possible
>>  - t5520: replace test -{n,z} with test-lib functions
>>  - t5520: use test_line_count where possible
>>  - t5520: remove spaces after redirect operator
>>  - t5520: replace test -f with test-lib functions
>>  - t5520: let sed open its own input
>>  - t5520: use sq for test case names
>>  - t5520: improve test style
>>  - t: teach test_cmp_rev to accept ! for not-equals
>> 
>>  Test cleanup.
>> 
>>  Will merge to 'next'.
>
> Any chance that we can queue this patch[1] either as a separate series
> or as a precursor to the above?

Heh, I do not recall seeing that patch attached at the end of the
message, even though I did read the message; I am not sure if it is
worth it, but I do not think it would hurt.

Thanks.

>
> Thanks,
>
> Denton
>
> [1]: https://public-inbox.org/git/20191114005215.GA24527@generichostname
