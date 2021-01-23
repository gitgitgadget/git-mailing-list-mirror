Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9791BC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FE822CB3
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhAWVnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:43:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63341 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbhAWVnd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:43:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50DB81182C7;
        Sat, 23 Jan 2021 16:42:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=greA7blSR3+JDW6nl+wDmbuhTP0=; b=L6ScUI
        heyFn9LlNPRdA91XUanQ+K8Ob1xOLx2Uq9jvQI8/xj/i1+5y3tWbf3k9H4w8JE62
        3tidjvBdc45JJ92V9nusPaWLBtxlbUYIjnAzFaGjyzT+o/ZZ0LkxLSlgmtSJ+GUb
        aveqsFf3cGIr1EJc5uNs8FxCmRpF78lg/LjUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IcknyP+fo6i4nKsvtJb8FIUf4TMrUSW9
        uodjkGGrQcurE5CccQjoFs0Oib5Xb4hAepuGO7zSrol2p6vL8okJI8xr+jHfudTe
        CnvXfevl8qWHsDxTeoPsdtQjqOJGyFTS/XUmlobOS4aOOFcbRYUtbcX6Of4KdMpI
        w+zii2+lOcI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 490901182C5;
        Sat, 23 Jan 2021 16:42:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9979F1182C4;
        Sat, 23 Jan 2021 16:42:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/9] More index cleanups
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
        <CABPp-BHFiXLOS4Vbm156+JxZw=t2P_Fzf8E3p4u0iwCv28_Rdw@mail.gmail.com>
        <b4a4df78-fb36-5a27-7ec0-79d752de73ae@gmail.com>
Date:   Sat, 23 Jan 2021 13:42:47 -0800
In-Reply-To: <b4a4df78-fb36-5a27-7ec0-79d752de73ae@gmail.com> (Derrick
        Stolee's message of "Sat, 23 Jan 2021 16:05:51 -0500")
Message-ID: <xmqqczxv2uug.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFB31F8E-5DC3-11EB-A337-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>>      -+ if test $exitcode != $expect_exit
>>>      ++ if test $exitcode != $expect_exit = 1]
>> 
>> Same comment
>
> Wow. I am sorry this snuck in. It's an artifact of what I was trying [1]
> in response to Junio's comments, but then did not completely undo.

Sorry about that.
