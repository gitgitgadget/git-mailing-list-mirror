Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AADE1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 13:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfDXNqg (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 09:46:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52288 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDXNqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 09:46:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAED5148981;
        Wed, 24 Apr 2019 09:46:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xuVQOYHWjbLbJBM3+7ADFVkK8ck=; b=t/X4wN
        xcaJidhWF3GzUt42bx+9VjrwprS5TiwcaOFmhzsS+tgyvEynLJWhIqaSBVEaAz4x
        nFoPSzb76+PJFTCmDExAwazgy0l03FWN7bFj6gCUD7xYtOa7I0Bqeuc1KqPp8gxU
        v1sRVXxMpNVEIwA4YGYWjfALy/qUwaOVIpcwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h24TLtwucSM5TV5A78TfxZjUu3fvWnU8
        pLLvxGW7EoDCpSBoGNV4NAW9Y44k7PUIxtr0HRCEeeuICHuPuolC8Gb7EXkKGQQ5
        Q4LHDFGMXcwY/cW+HrD8z+plIKHi/HYnM/4onoPzEdGr9/4fysZ8UwiTCM5+N6Jc
        IDrX27T2OvU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D415814897F;
        Wed, 24 Apr 2019 09:46:32 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44E3314897A;
        Wed, 24 Apr 2019 09:46:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Checkout file without changing index?
References: <CAA01CsoJZMJ86mpybukqT0hVnvXi0FuRjZ23akM5kNPBdT754Q@mail.gmail.com>
Date:   Wed, 24 Apr 2019 22:46:31 +0900
In-Reply-To: <CAA01CsoJZMJ86mpybukqT0hVnvXi0FuRjZ23akM5kNPBdT754Q@mail.gmail.com>
        (Piotr Krukowiecki's message of "Wed, 24 Apr 2019 15:37:05 +0200")
Message-ID: <xmqq5zr31poo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E800D4E-6697-11E9-9D0B-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> I was familiar with "git checkout revision -- file".
>
> But it updates both working tree and index. I had some changes in
> index (staged) and "git checkout HEAD -- file" silently overwritten
> it. Well, probably my mistake, it's documented.

We'd invite you to live on the leading edge and try

    $ git restore --source=<revision> <pathspec>

which by default checks things out only to the working tree, but not
to the index (you say --staged if you want to restore to the index,
and you say --worktree if you want to restore to the working tree,
or you can say both, which would be the same as "git checkout").

I think the new command is now on the 'pu' branch, but in a few
weeks hopefully it will appear on the 'next' branch.
