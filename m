Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BFAC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CF561B95
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhKOV0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:26:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58710 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352176AbhKOUn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 15:43:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 501A515C2BD;
        Mon, 15 Nov 2021 15:40:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BPCyDjoVQM+zS+cDUk6TXQd8jT1kopwQpO6vkB
        piepo=; b=Oz1T50rsNH5s6IG1FoJXeLOMgybeyUb8d6LMHSkAawpJpKTyn8NuYO
        lnIKFmpTuFZYcTvJW0X0Vtv1g3C0NRgEJCzy2EWpswtM2ca2cfUKUbB/V2w9VsTs
        erem4LODqO+PnPkPfn++QEkYHXfeC07U4CI4Ir6442jQgx4TRW+6U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4910C15C2BC;
        Mon, 15 Nov 2021 15:40:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9D9B15C2BB;
        Mon, 15 Nov 2021 15:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Erwin Villejo <erwinvillejo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git pull bug report
References: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
Date:   Mon, 15 Nov 2021 12:40:21 -0800
In-Reply-To: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
        (Erwin Villejo's message of "Mon, 15 Nov 2021 15:42:15 +0700")
Message-ID: <xmqqfsrxdufe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 413930A4-4654-11EC-8B17-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erwin Villejo <erwinvillejo@gmail.com> writes:

> $ git pull
> hint: You have divergent branches and need to specify how to reconcile them.
> ...
> hint: invocation.
> fatal: Need to specify how to reconcile divergent branches.
> ```
>
>> What's different between what you expected and what actually happened?
> I expected no failure and no-op since local is ahead of upstream.
> Instead, `git pull`
> fails because it thinks the branches have diverged.

I think this was fixed at 361cb523 (pull: --ff-only should make it a
noop when already-up-to-date, 2021-10-20); it was broken between Git
2.33 and Git 2.33.1, IIRC.

Thanks.
