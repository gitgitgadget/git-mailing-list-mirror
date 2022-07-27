Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66675C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 14:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiG0OvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiG0Ou7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 10:50:59 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC003ED5A
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 07:50:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDC0F1B2F0F;
        Wed, 27 Jul 2022 10:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Xa6cGIh6dEHaGoXTc0O4vh0u72iLzUAUqXJoh9vfDwI=; b=UF0M
        7eWfeXVOu5pKvYnFb7pdA/uB+ohO5Els0Je9pCjOi/C3vFvhYeUcSn/pag8l/18B
        53lbnqwa1VXvb+8pV+V/qfLmL1qGvjsxCFosdqQL2buubHPNA9N/LCmInlOqqukG
        svBrOhWekN8Uu6UHUnqbf1tlC547mcnJnVOLvHo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E504D1B2F0E;
        Wed, 27 Jul 2022 10:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A33FF1B2F0C;
        Wed, 27 Jul 2022 10:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/3] maintenance: stop writing log.excludeDecoration
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <84fbf16613daa0ff84e1f07d23654a96bd1a8315.1658844250.git.gitgitgadget@gmail.com>
Date:   Wed, 27 Jul 2022 07:50:53 -0700
Message-ID: <xmqq7d3ytxrm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 843B0222-0DBB-11ED-8E1F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> This reverts commit 96eaffebbf3d0 (maintenance: set
> log.excludeDecoration durin prefetch, 2021-01-19).
>
> The previous change created a default decoration filter that does not
> include refs/prefetch/, so this modification of the config is no longer
> needed.
>
> One issue that can happen from this point on is that users who ran the
> prefetch task on previous versions of Git will still have a
> log.excludeDecoration value and that will prevent the new default
> decoration filter from being active. Thus, when we add the refs/bundle/
> namespace as part of the bundle URI feature, those users will see
> refs/bundle/ decorations.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/gc.c           |  6 ------
>  t/t7900-maintenance.sh | 21 ---------------------
>  2 files changed, 27 deletions(-)

Nice.
