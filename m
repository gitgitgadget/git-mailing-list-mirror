Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB828C433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 23:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C0D64DDA
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 23:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBMX5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 18:57:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65391 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBMX5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 18:57:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ACEED121A6B;
        Sat, 13 Feb 2021 18:56:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XIZxeppFDlg//ST9FL44CYxwmxQ=; b=AESgMM
        Z95bc+eB3OH53IvdW8OCfsvFIgX7wk/UML/cYCWO8hWCGAwcbGqwNtWh1UmbNQgY
        bRuCznylamdXXz9vZtZteyMP7peKSO1GWlLiEbW2gRLyGlaV/7fYuquzHXLxGF0F
        xgtbSGk0hRPsBRDMVXtmdhLKrHw+ufAmmerkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X90+sNv7OD5rBzYjUN+3DhfqKfHpWdeK
        1ERk3yQloEO20FeApjYpWjmjYT/Mn0Qcm4WNvkFT5JYhLwg/eo931DLnLfvz98Tb
        m4UIssJ8O6HSnqy/bE4lnGVTPVmRIGTB79vMuC5H0MHBh12L9hrW6qIgfGfLQ69J
        Duohsxcb5c4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4EDE121A6A;
        Sat, 13 Feb 2021 18:56:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB483121A69;
        Sat, 13 Feb 2021 18:56:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 1/5] t4001: add a test comparing basename similarity
 and content similarity
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
        <3e6af929d135ef2dc239e2f47f92a7e2e91cbd17.1612970140.git.gitgitgadget@gmail.com>
        <xmqq4kigvkct.fsf@gitster.c.googlers.com>
        <CABPp-BHyYOAw939vU20oA_tOSFRVm=EaLKuw+4M1oP1GDDV5cg@mail.gmail.com>
Date:   Sat, 13 Feb 2021 15:56:20 -0800
In-Reply-To: <CABPp-BHyYOAw939vU20oA_tOSFRVm=EaLKuw+4M1oP1GDDV5cg@mail.gmail.com>
        (Elijah Newren's message of "Fri, 12 Feb 2021 20:50:07 -0800")
Message-ID: <xmqqblcnttcr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12B1EB8E-6E57-11EB-9FBA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This is not true.  If src/main.c is 99% similar to src/foo.c, and is
> 0% similar to the src/main.c in the new commit, we match the old
> src/main.c to the new src/main.c despite being far more similar
> src/foo.c.  Unless break detection is turned on, we do not allow
> content similarity to trump (full) filename equality.

Absolutely.  And we are talking about a new optimization that kicks
in only when there is no break or no copy detection going on, no?
