Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B554CC432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7156F20732
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u6eMLBwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfK3RZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 12:25:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51850 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3RZP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 12:25:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C497636076;
        Sat, 30 Nov 2019 12:25:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lNYtvNe+i9OUiecc58eyNkP4CJU=; b=u6eMLB
        woYV0a2sZUZVv+AMVCmcnZOH7tm/kAzsNRatHvKn/qv6rjcyUTlK8XSL30ExtO0x
        8D5zlGKkY65xFnRhYQvZmHCwrcAzGwZ7yYTMRkbMWkHyKttJMflcZelSvGPJdZDZ
        PkCfR1ZDLM4PtDTM+05hRw3J8DzA+iBwoTs40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fsruU6WV0AsQDP4pOjaz0bv17S5hTgtn
        uQ9qOPc3fqgHd5lBMS3gxdV5FdDKpHElYQn07tc9mh+j+/PgukQggK8PDqbI9GXp
        zWBoZSvSHsGsWSTni2/huTYuEofoy0motVbAA/GmQ3LifjG1/rugEYOTrsyTv5O5
        B5XWk7kce78=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB9B336074;
        Sat, 30 Nov 2019 12:25:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B9CC36072;
        Sat, 30 Nov 2019 12:25:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Biesinger <cbiesinger@google.com>
Subject: Re: [PATCH 1/5] t3400: demonstrate failure with format.useAutoBase
References: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
        <cover.1574820308.git.liu.denton@gmail.com>
        <a1741e54346a387a65e272f0210118ce81475358.1574820308.git.liu.denton@gmail.com>
        <CAPig+cTqRcZ6R7bFqeNG_bvwqgAKP7NVEHBSQxgpVk+PgGVMVg@mail.gmail.com>
Date:   Sat, 30 Nov 2019 09:25:10 -0800
In-Reply-To: <CAPig+cTqRcZ6R7bFqeNG_bvwqgAKP7NVEHBSQxgpVk+PgGVMVg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 26 Nov 2019 21:26:58 -0500")
Message-ID: <xmqqimn12s5l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D5D8DEA-1396-11EA-B905-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Nov 26, 2019 at 9:09 PM Denton Liu <liu.denton@gmail.com> wrote:
>> Ever since bb52995f3e (format-patch: introduce format.useAutoBase
>> configuration, 2016-04-26), `git rebase` has been broken when
>> `format.useAutoBase = true`. Demonstrate that failure here.
>
> What specifically does "broken" mean here?
>
>> Reported-by: Christian Biesinger <cbiesinger@google.com>
>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> ---
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> @@ -159,6 +159,12 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
>> +test_expect_failure 'rebase works with format.useAutoBase' '
>> +       test_config format.useAutoBase true &&
>> +       git checkout topic &&
>> +       git rebase master
>> +'
>
> Having read both the commit message and the test itself, I'm not wiser
> about what is actually "broken" or what this is demonstrating.

True.

The tests must be crystal clear what kind of brokenness it is
demonstrating, not just "this test is expected to fail", especially
when the "expect failure in one step, fix and flip expectation in a
separate step" pattern is used; otherwise it becomes doubly puzzling.

Thanks.
