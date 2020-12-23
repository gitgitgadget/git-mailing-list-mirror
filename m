Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3610C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 09:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50EF5207A5
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 09:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgLWJPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 04:15:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65293 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgLWJPK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 04:15:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DF9D114FC6;
        Wed, 23 Dec 2020 04:14:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=VSPP2D5t8ELncBTDoC7L+bt7iMM=; b=Z9ufRlRLWpDNhpySxDW5
        VmJyAst0jmZ3Urhp/2c4+XciiuQKcac16szbl1GxZhaCQHleoyvArJR4BgZkJHl7
        0hrVYEaAg2h27pKL+eGQAcUxhZR16parWuZGEF+snJw1tma/ipYKQkLf3zOoNUqe
        JW2f3nOr+yqrvaZRkQP4ebY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=AQdrxtjEw9x5Fnu+Ihqxj6hdzopVpd6sqHI9DxQepLZjKg
        Tp9GlnAzJMq6MYT012FBSYpAnzIqkjD9VGGwsaVBBWrT49Zy7HsVSfu/uCKD5lh4
        sm/GG2T4ZK1dYzKiPk90wUU42eiBFnEi9Qxwyy3HcGV80ecDSDNl6XUuWVEN0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39C3F114FC5;
        Wed, 23 Dec 2020 04:14:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7EF45114FC2;
        Wed, 23 Dec 2020 04:14:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH try2 0/4] completion: bash: a bunch of fixes
References: <20201219140621.1961760-1-felipe.contreras@gmail.com>
Date:   Wed, 23 Dec 2020 01:14:23 -0800
Message-ID: <xmqqy2hoanps.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 408E50E6-44FF-11EB-B747-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is just the bug fixes from the previous series.
>
> These should be pretty obvious and straightforward.
>
> Felipe Contreras (4):
>   completion: bash: fix prefix detection in branch.*
>   completion: bash: add correct suffix in variables
>   completion: bash: fix for suboptions with value
>   completion: bash: fix for multiple dash commands

It seems that this tickles some platform specific glitches in the
tests (the detailed CI report can only be seen when logged in, it
seems):

    https://github.com/git/git/runs/1597682180#step:5:35614

The expected output lines have a trailing SP each, while the actual
output lines do not, but this failure happens only on macos job and
not others.

