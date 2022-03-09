Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4BEC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 20:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiCIUYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbiCIUYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 15:24:05 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5223D1CA
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 12:23:05 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7FDE180481;
        Wed,  9 Mar 2022 15:23:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XGAzXU5vSmQkyOsXZatns9p8ozeRuuzFUg6Y2y
        /fzJI=; b=x96sflFpsGY7qg1S8qRMbTdif9FqzZhNAlHZEZ5a63ZW6YzuMtL7rg
        rB0PYDu0tEzUJWOzUktjs5GoWMg2tAdJMdtYkMjeGt8m2FrKCgxWbAgpw0rTvO0Z
        ti2vUyHDZMXC7uk5hm5rB04yO06QcLQVXuYhmHzQdVWDDQrYbRffA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0BF5180480;
        Wed,  9 Mar 2022 15:23:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 491EC18047D;
        Wed,  9 Mar 2022 15:23:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated
 submodules
References: <20220304005757.70107-1-chooglen@google.com>
        <20220308001433.94995-1-chooglen@google.com>
        <xmqqr17dp8s9.fsf@gitster.g>
        <kl6lh7885mm3.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqfsnrkkhd.fsf@gitster.g>
        <kl6l5yom6h4j.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 09 Mar 2022 12:22:59 -0800
In-Reply-To: <kl6l5yom6h4j.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 09 Mar 2022 11:49:32 -0800")
Message-ID: <xmqq4k46nae4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B79809C8-9FE6-11EC-A46B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> To clarify, does this opinion of "don't use config values that aren't
> copied into .git/config" extend to in-tree .gitmodules? Prior to this
> series, we always read the in-tree .gitmodules to get the config - the
> user does not need to copy the settings to .git/config, but we don't
> pick a commit to read .gitmodules from.

I think we do, but I also think it was a huge mistake to allow
repository data to directly affect the behaviour of local checkout.

Fixing that is most likely outside the scope of this series, though.
