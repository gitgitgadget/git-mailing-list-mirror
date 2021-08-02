Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B1C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1936660FC1
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhHBQ2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:28:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55030 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhHBQ2m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:28:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D52E1CFD4D;
        Mon,  2 Aug 2021 12:28:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=GTu7KDL6jYzXPN4AsB3VdukRlOq14tg+k53yur
        u2BUg=; b=xBXs3KD4539sHKFQk78IHv1KfRcebpisMPt5ZVdrjf6yf5W5+mHvRe
        A5UeyCAR4fp3xggHBeEqCJo4MIEp8PHrEP7DENmNXFwe8cqf6FjLls6GXprOlnRY
        jZjG2qhdPppQYtYcqGUZlV774rntJwE5PFjBN8Cs37z+IXPFUH9OA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC6BFCFD4C;
        Mon,  2 Aug 2021 12:28:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 506F9CFD4B;
        Mon,  2 Aug 2021 12:28:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 00/11] Fix direct filesystem access in various test
 files.
In-Reply-To: <CAFQ2z_PjEuy2Ngr_i7c8rT6xb4w2HBEUARqwR7azZO4zor-w7g@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 2 Aug 2021 15:38:15 +0200")
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <xmqqbl6tncw7.fsf@gitster.g>
        <CAFQ2z_PjEuy2Ngr_i7c8rT6xb4w2HBEUARqwR7azZO4zor-w7g@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Mon, 02 Aug 2021 09:28:31 -0700
Message-ID: <xmqqr1fbx13k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD5E8368-F3AE-11EB-B0DC-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, Jul 23, 2021 at 7:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > This fixes a few test failures in the reftable series.
>>
>> The early part is already in 'next', and the new ones looked mostly
>> good.
>>
>> I didn't quite understand what was going on with "ls -1" though
>> (what does it even mean to "ls -1" enumerate only the filenames in
>> .git/reftable directory)?
>
>
> By listing the files before and after, we can make sure that the ref
> storage wasn't changed.

Meaning that we rely on the fact that we never append to an existing
file?  A comment here would have helped.

Thanks.
