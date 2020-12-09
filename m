Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876CEC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 04:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5763F23B19
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 04:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgLIEXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 23:23:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65432 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgLIEXe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 23:23:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E45FF81364;
        Tue,  8 Dec 2020 23:22:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SyDQ4d/5LGQdhTfsbvnhDZKNFts=; b=BUqbUD
        tUJsIHcwWI1q3J8TkVhVC5uVsEKY0U8mgfKIOWGNMc06GTC7WXEB0vB9A+3BJI7l
        mASpphFVvF7dJfYkSJB3B9sIUQCFNSutCoAeA9jeMoRE9yWLrPXWVtsLzV1mWWr/
        ugDDvnQAigVpVEH71pX12YLGRE1/gnU45/r90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qyn0nIeRz/Oa8k7v0BLUQQ2LJ/Mm2i75
        dVL0+UF3oHM/H+chvgo3jUvjofk0HqJWLK5PIwcvSjfjCvPSgSqDLfFG26xjsmkg
        75ASRUXSK+5rk78KbqU+AlUu/s9CPtgUVNHYFJk5AjxvTp6YzlayhOlDxzBFKLD5
        NgGXXOi23zE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC42181363;
        Tue,  8 Dec 2020 23:22:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47FE381361;
        Tue,  8 Dec 2020 23:22:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2020, #01; Tue, 8)
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
        <CABPp-BGcyRURykePOafjcE1z9J8U5awF=PZw1ufx+8Ow+k3j3w@mail.gmail.com>
Date:   Tue, 08 Dec 2020 20:22:50 -0800
In-Reply-To: <CABPp-BGcyRURykePOafjcE1z9J8U5awF=PZw1ufx+8Ow+k3j3w@mail.gmail.com>
        (Elijah Newren's message of "Tue, 8 Dec 2020 18:45:49 -0800")
Message-ID: <xmqqy2i738x1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3366EC9A-39D6-11EB-882D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Dec 8, 2020 at 5:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * en/diffcore-rename (2020-12-07) 5 commits
>>  - diffcore-rename: simplify and accelerate register_rename_src()
>>  - diffcore-rename: reduce jumpiness in progress counters
>>  - diffcore-rename: rename num_create to num_targets
>>  - diffcore-rename: remove unnecessary if-clause
>>  - diffcore-rename: avoid usage of global in too_many_rename_candidates()
>
> Curious.  I submitted 7 patches for this series.

Yeah, I wanted to leave the "hard-to-digest" one out, and queued the
"relatively easy to review" ones.  Even then, I ran out of time to
read these early 6 (and nobody else seems to have done so, either).

