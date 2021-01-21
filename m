Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C67C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F828206CB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 18:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbhAUSg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 13:36:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57894 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbhAUSgu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 13:36:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 772809DA2D;
        Thu, 21 Jan 2021 13:35:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jauir8k3AH0u0YfwMgmFhExQZpI=; b=E0yQYE
        8gLVtYkVbWNTFUiLQgkwSCYBuj/70ZsVOloa2kuwpBDVsPJZy3OVC9d9uo6Dsx+O
        9mnY011/qbR9OrZnE+s299o1dNtCL9QLxNBi4RwkTrNeSMDCrTMAWV04NnlNth6F
        tJXojJuleGCTBLTT+m1iR6jqyNjCZPknYY5TM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K3AiB8JU37KwvRJ8EooYHdzVRyXFoQWs
        OwCNPpgrutKcRdouujfONJYRC2LoRSey91mDRTW1EEuZ4wQLhGb5lk6GFN/MyIYy
        MIbgcQnkKScECN1dPpm6Cq9OOQFMpHN304/6czQ96epE2u/lBHYqHfsDc2oHba7p
        RGWLvJ9Xw2Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 702929DA2B;
        Thu, 21 Jan 2021 13:35:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F14AA9DA2A;
        Thu, 21 Jan 2021 13:35:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #04; Sat, 16)
References: <xmqq8s8so84r.fsf@gitster.c.googlers.com>
        <CABPp-BGHpvmx-hdZ==MdODKEDVTr92m3rs4T2d_w9Aa0d0zanQ@mail.gmail.com>
Date:   Thu, 21 Jan 2021 10:35:18 -0800
In-Reply-To: <CABPp-BGHpvmx-hdZ==MdODKEDVTr92m3rs4T2d_w9Aa0d0zanQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 21 Jan 2021 08:25:33 -0800")
Message-ID: <xmqqft2ucf4p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 699101DA-5C17-11EB-B2FB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi Junio,
>
> On Sat, Jan 16, 2021 at 2:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * en/merge-ort-perf (2021-01-15) 4 commits
>>  - merge-ort: begin performance work; instrument with trace2_region_* calls
>>  - Merge branch 'en/ort-directory-rename' into en/merge-ort-perf
>>  - Merge branch 'en/ort-conflict-handling' into en/merge-ort-perf
>>  - Merge branch 'en/diffcore-rename' into en/merge-ort-perf
>>  (this branch uses en/diffcore-rename, en/merge-ort-3, en/ort-conflict-handling and en/ort-directory-rename.)
>
> Any chance we could merge this down to next now?  In terms of pre-requisites:
>   * you merged en/diffcore-rename and en/merge-ort-3 to next already
> (and marked both as "Will merge to master")
>   * you previously labelled en/ort-conflict-handling as "Will merge to
> next" (and it was reviewed by Stolee[1])
>   * en/ort-directory-rename has now been reviewed by Taylor[2]
> Also, en/merge-ort-perf itself has also been reviewed by Taylor[3].

This one is a bit unfortunate in that it is so small a change by
itself, but sits on top of en/ort-directory-rename.

Even though I wanted to merge the en/ort-directory-rename down to
'next' yesterday, it has just got updated and I had to rebase the
ort-perf branch using the material from the old thread, so neither
is in 'next' as of now.  That's the cost of building on top of too
many things that are in flex X-<.  I'll see if I can find time today
to give it the last read-over before mergint the ort-d-r in 'next'
but I am not very optimistic right now.

> But I'd like a stable commit identifier to place in the '??????????'

Well, we'd all like a stable commit contents in the first place ;-)

Thanks.
