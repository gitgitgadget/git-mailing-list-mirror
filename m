Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BFCC433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B0423884
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbhAUF4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 00:56:45 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61476 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732654AbhAUD3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 22:29:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE2C6101802;
        Wed, 20 Jan 2021 22:28:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RlIcgP7u8Xg2+4EioO0zIZYXCn0=; b=TOApTe
        Sp1Y0aWM6fsEjystoGQE3XHVYk1tuux1Zzk0c62n8CE72ilnxwiak6oMh/+byEiq
        XIYOA3NOy4vjx0tW6iwHzvbIPl7ycTXnu+xO5fHurSo0MAzrmOCmM9Tqry+hQhJn
        wnHuTT7duf7Ps4p6MAMRXNGLHEB9BB7XguW8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vGEC1K2awlMm6fOqb6QrQmqxavWMlWyY
        TWn4ftvkZ/NzrXNC0H3L8c6vLZ5F8PIQJ7c3lkCewSm/QveZ15rhe0HDGQ1nbR7g
        9ft4/IxI0df0OZEabWJtAKsrEwS2/KtIlFQQCtwe6K5nmNc2OWM8Aoczo++3YsD3
        tSe9hG3p15M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4FD1101800;
        Wed, 20 Jan 2021 22:28:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0951B1017FF;
        Wed, 20 Jan 2021 22:28:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 6/7] worktree: teach `list` to annotate prunable
 worktree
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
        <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
        <20210119212739.77882-7-rafaeloliveira.cs@gmail.com>
Date:   Wed, 20 Jan 2021 19:28:18 -0800
In-Reply-To: <20210119212739.77882-7-rafaeloliveira.cs@gmail.com> (Rafael
        Silva's message of "Tue, 19 Jan 2021 22:27:38 +0100")
Message-ID: <xmqqo8hjc6jx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5587604-5B98-11EB-B4E4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> writes:

>  Documentation/git-worktree.txt | 26 ++++++++++++++++++++++++--
>  builtin/worktree.c             | 10 ++++++++++
>  builtin/worktree.cc            |  0
>  t/t2402-worktree-list.sh       | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 2 deletions(-)
>  create mode 100644 builtin/worktree.cc

What's the h*ck is that .cc file doing ;-)
