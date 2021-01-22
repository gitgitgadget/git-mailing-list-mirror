Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D6CC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 02:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D4423136
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 02:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhAVCnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 21:43:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59992 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbhAVCnL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 21:43:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82E38A1469;
        Thu, 21 Jan 2021 21:42:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sYFRtdupYw659r1DV5TNe/itC8s=; b=v6VT2B
        bh6YKWVZk0MvCAyX2QDPaYbCNjQ4dkDEuhmdAlD8LcAGjuSaTpaz7TlHIjhTgXtw
        4yjRF3jJi452hGAXy1URlIl+zjBT2PnVLMnJxOrjFMozuO+RjuR5/Sb6plIhLn80
        L0q67HyM6ZTh/16Xs3LIjEowsj+A3AYAGbVSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ulUVVlNrTcFH5F5c72NPlmpZyzTy39pW
        /uQHycbgc6KE5591cCRJvjlJUtvA/KrRrSAl2Rl79gJhhNGMOW6kalKQkOZjhsw9
        galOjlf/DH+Xe+Ie/8id+UA08Oj5xjyM+ciZ3Nk3GvHPtYenBQA9gxVc9z4cgE8m
        LqiMQMw7Kpg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AC15A1468;
        Thu, 21 Jan 2021 21:42:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06628A1466;
        Thu, 21 Jan 2021 21:42:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] use delete_refs when deleting tags or branches
References: <20210121032332.658991-1-phil.hord@gmail.com>
Date:   Thu, 21 Jan 2021 18:42:27 -0800
In-Reply-To: <20210121032332.658991-1-phil.hord@gmail.com> (Phil Hord's
        message of "Wed, 20 Jan 2021 19:23:32 -0800")
Message-ID: <xmqqczxxae0c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 776E118C-5C5B-11EB-9CB7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> After deleting branches, remove the branch config only if the branch
> ref was removed and was not subsequently added back in.
>
> A manual test deleting 24,000 tags took about 30 minutes using
> delete_ref.  It takes about 5 seconds using delete_refs.

Nicely done.  Queued and pushed out.
