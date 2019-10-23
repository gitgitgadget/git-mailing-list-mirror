Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07041F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 02:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbfJWCSU (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 22:18:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65066 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfJWCSU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 22:18:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D36CAFAB7;
        Tue, 22 Oct 2019 22:18:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vKkHVH7BhMMuB3xkyorKzm13jH0=; b=vGA0qD
        HqpDvzXPETj3P6EO7C2ARIrInUv9ppt7BGgsYeNGP/RyuXLMuD3M/RfLz0SMCNYE
        b4M5dURjwlGUcFilQIDGLFjy+WqlSU5rvXR0v9gTR05N5nZ1gqVIzPlRUNZAJz4E
        9vHBOmaGoC7W3A/FlO7qE6/TqYEwN9s9fTyro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S0EnsZeZLlP1ZDi/++uXc32ec3jr1C5/
        AdTKAeW65Cs5cOcb8AKAOaFeIKGAZ/QGzZESTAn7EX42Jl4eBv2gfT5oBq/dOBUP
        1me5hjQ9Na1/EDhuv67jmR4T8gtEKN5NLdZ1QUvweuo2txZYUwkGtkIUPxxyVBjm
        pWasqtFAGXQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 857D4AFAB6;
        Tue, 22 Oct 2019 22:18:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA4F9AFAB1;
        Tue, 22 Oct 2019 22:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t7419: change test_must_fail to ! for grep
References: <6b788f92d2ef6f6cdaf6ea9f2bbe448ce19b2f58.1571737787.git.liu.denton@gmail.com>
Date:   Wed, 23 Oct 2019 11:18:13 +0900
In-Reply-To: <6b788f92d2ef6f6cdaf6ea9f2bbe448ce19b2f58.1571737787.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 22 Oct 2019 02:57:01 -0700")
Message-ID: <xmqq4l00jjbu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EFEC566-F53B-11E9-97EB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> According to t/README, test_must_fail() should only be used to test for
> failure in Git commands. Replace the invocations of
> `test_must_fail grep` with `! grep`.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> *sigh* Here's another cleanup patch for 'dl/submodule-set-branch'. It's
> inspired by Eric Sunshine's comments on the t5520 patchset from earlier.
> It's definitely not urgent, though, and can wait for v2.25.0.

True, but they are trivially correct and removes the risk of
inexperienced developers copying and pasting this bad pattern to
other tests that was added during this cycle, so I think it is a
good idea to take it now.

Thanks for being extra careful.
