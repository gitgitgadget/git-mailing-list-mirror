Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52096C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C8460FE8
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhJXUtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 16:49:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64340 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhJXUtI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 16:49:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DB82F0D88;
        Sun, 24 Oct 2021 16:46:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CVAAZsz4wdn5HpCon4AwD0tjmiC82w+9ns6pFG
        Fz1Dg=; b=gAecH2g+TxweOFOLzSiap8B9SIsW9s+aJNnrHmk2PeuB6l83A6wL3e
        DI7borrV21hNoZkd2WAlxfyc0rnvCPWeW31M7FuU2RNnx7bXaC5hDzaiXWOtqtns
        HOmKbkpAZFPICXxvZ0Q9BzOe+bL6uuJ4unt1V9Lf7pCwUFcVs53YY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45CB9F0D87;
        Sun, 24 Oct 2021 16:46:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E68CF0D86;
        Sun, 24 Oct 2021 16:46:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kalyan Sriram" <kalyan@coderkalyan.com>
Cc:     "Matheus Tavares" <matheus.bernardino@usp.br>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git" <git@vger.kernel.org>
Subject: Re: Git submodule remove
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
        <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net>
        <xmqqbl3ihu6l.fsf@gitster.g>
        <CAHd-oW5PfygyNsRWGg4_W2pxR_HbePvguKRf-bK9RtY3cuAX9g@mail.gmail.com>
        <xmqqee8egddw.fsf@gitster.g>
        <0101017ca60e5ffd-9563fafd-86f6-443d-9cbe-e07203caacba-000000@us-west-2.amazonses.com>
        <xmqq4k98en01.fsf@gitster.g>
        <0101017cb4026947-7e22d019-674b-4d1c-b229-b10328252341-000000@us-west-2.amazonses.com>
Date:   Sun, 24 Oct 2021 13:46:45 -0700
In-Reply-To: <0101017cb4026947-7e22d019-674b-4d1c-b229-b10328252341-000000@us-west-2.amazonses.com>
        (Kalyan Sriram's message of "Sun, 24 Oct 2021 20:33:49 +0000")
Message-ID: <xmqqo87e40cq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80FDB3B8-350B-11EC-9092-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kalyan Sriram" <kalyan@coderkalyan.com> writes:

>> So "git rm" seems to be doing exactly what "git submodule rm" should
>> be doing, nothing more, nothing less.
>
> That makes sense, thanks for the clarification. So it looks like there
> isn't any work to be done here after all?
>
> What are your thoughts about aliasing git submodule rm to git rm? 

It is unfortunate that "git rm" learned these "extra" things that
are integral part of "submodule removal" if you believe that the way
"submodules" are handled in the current "git submodule"-style design
is the only thing all Git users must follow.

Unless we plan to eventually make "git rm" unlearn these hardcoded
'git submodule'-way actions it does (like editing the .gitmodules
file) and move them to "git submodule rm", I do not think it is
worth the engineering effort to add an alias so that "git submodule
rm" would be a synonym to the current "git rm".

Thanks.
