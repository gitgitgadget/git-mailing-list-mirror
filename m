Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5776FC35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019AB206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TTXrW3KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgBVRRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:17:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57700 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBVRRA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 12:17:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95CF74170F;
        Sat, 22 Feb 2020 12:16:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s6hnWLAIrqsnnI9lhlzoHWkN8QA=; b=TTXrW3
        KXjBOifNhmAPy17GcyhCxQPufmaDDHedtrP7yI+YKVplN+Y99UiDA8HkFX5cUGqF
        KjyiwpT2vvZLSx6HeDwj4U15F2w2BIFHsbjqK1thKhl+06viXw8+Js8Jl2Fh/XQG
        4ehYldu4e0IQcVeD2ZTyNlubeUqHD3L22CNDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=df5arQ045VK0OQh+XST/syG7SJ+AcGB5
        Lw6lF0KCPsRh3kTQeScsK4Apcy+3D7mBCzwny8zuH0NzIOYNhj+FAQ0prL7bpIUR
        eIoTvQY9rdFg+S1TD8um8N1FXfQEWnYRI/uDk7NS3631fGmP2uUMViEA/OdVmtlf
        Neje+/Obpz0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DD054170E;
        Sat, 22 Feb 2020 12:16:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEBC84170D;
        Sat, 22 Feb 2020 12:16:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Feb 2020, #04; Mon, 17)
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
        <e9984c53-7266-c438-87f5-7f5474e3adce@gmail.com>
        <CABPp-BE_ktNmDB43N_qijzYzhXvsK8Fi7TJQ7goHu+MzGvdpBQ@mail.gmail.com>
Date:   Sat, 22 Feb 2020 09:16:56 -0800
In-Reply-To: <CABPp-BE_ktNmDB43N_qijzYzhXvsK8Fi7TJQ7goHu+MzGvdpBQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 21 Feb 2020 19:03:04 -0800")
Message-ID: <xmqq7e0e7d9z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 217F21CE-5597-11EA-9488-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > [Stalled]
>> >
>> > * pw/advise-rebase-skip (2019-12-06) 9 commits
>> >   - rebase -i: leave CHERRY_PICK_HEAD when there are conflicts
>> >   - rebase: fix advice when a fixup creates an empty commit
>> > ...
>> The tip "rebase -i: leave CHERRY_PICK_HEAD when there are conflicts"
>> needs reworking and can be dropped (cf
>> <7e1b92f5-48df-e202-ebcc-5b15987a7d63@gmail.com>). The other RFC patch
>> "rebase: fix advice when a fixup creates an empty commit" [1] could do
>> with someone commenting on it (I've Cc'd dscho and Elijah). I think the
>
> I'll try to take a look early to middle of next week.

Thanks, both.  I think the early ones except for those two make
sense by themselves, so perhaps I'll advance them to 'next'
independently of these two steps.

