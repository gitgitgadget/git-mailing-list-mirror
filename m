Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3485C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBEF60F6D
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhJHJGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:06:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63536 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhJHJGN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 05:06:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBCBA147BF2;
        Fri,  8 Oct 2021 05:04:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=IjBKfxz6M45XhRMP7SlU0O17Y
        abPWlhDPW5eSCKnSTk=; b=j1wCPJrTK3JZyn2eTkTa5o9GcdVhrm28ikjhfyqZc
        evP4cRpTmfQKVs3cQe213BG6BI4J11kxRbPi7/H0MkyOuxSgDq+g48tLpcp0F5pY
        9KZgyY0f5rZPyYZbKV+/c1SlGfOLAU1ZmRi954NuftINuOC0NxcxJC+riONob6Ba
        7w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7526147BF1;
        Fri,  8 Oct 2021 05:04:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 003CD147BEF;
        Fri,  8 Oct 2021 05:04:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Robert Leftwich <robert@gitpod.io>
Subject: Re: [PATCH 3/3] read-cache: let verify_path() reject trailing dir
 separators again
References: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
        <5e6fafa9-f155-61af-6906-05fec27808e6@web.de>
Date:   Fri, 08 Oct 2021 02:04:14 -0700
Message-ID: <xmqqwnmnlwfl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B6A309B6-2816-11EC-B63A-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> 6e773527b6 (sparse-index: convert from full to sparse, 2021-03-30) made
> verify_path() accept trailing directory separators for directories,
> which is necessary for sparse directory entries.  This clemency causes
> "git stash" to stumble over sub-repositories, though, and there may be
> more unintended side-effects.
>
> Avoid them by restoring the old verify_path() behavior and accepting
> trailing directory separators only in places that are supposed to handl=
e
> sparse directory entries.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  read-cache.c                       | 6 +++---
>  t/t3905-stash-include-untracked.sh | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Makes sense.  Thanks.
