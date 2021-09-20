Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E1BC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 17:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF54F60EE4
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 17:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349403AbhITRXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 13:23:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56337 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348945AbhITRVC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 13:21:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2CA7144F27;
        Mon, 20 Sep 2021 13:19:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7z1+SdaDUzct1KSzD9kgqifqrmtz4Od779W7NF
        8wwKY=; b=DZ6ODrEEW4b0xPFWoTdZHdw+klx6wpm4JjSG+ijEfF8tdI6S9U2u/I
        lyoRi6xByNUxrLq/HdZdqK4CEuizVghO1xkkCe8fAUyeWgicvDI+X2rWL96sJY3m
        mqF3pGPo/4hh/feMvBz/SOmH6/hgKxci7VVAp4AzGqLVZ6Q3He68A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AED7144F26;
        Mon, 20 Sep 2021 13:19:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0716D144F25;
        Mon, 20 Sep 2021 13:19:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v2 7/8] submodule--helper: remove unused helpers
References: <20210907115932.36068-1-raykar.ath@gmail.com>
        <20210916103241.62376-1-raykar.ath@gmail.com>
        <20210916103241.62376-8-raykar.ath@gmail.com>
Date:   Mon, 20 Sep 2021 10:19:31 -0700
In-Reply-To: <20210916103241.62376-8-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 16 Sep 2021 16:02:40 +0530")
Message-ID: <xmqqfstzcggs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBEE9E52-1A36-11EC-8920-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> These helpers were useful back when 'submodule update' had most of its
> logic in shell. Now that they will never be invoked, let us remove them.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---
>  builtin/submodule--helper.c | 135 ------------------------------------
>  1 file changed, 135 deletions(-)

Makes sense.  I briefly hoped that print-default-remote could go
after 2/8 but there is another user that is in the cmd_update() that
is not removed until 5/8 and removing them in a separate step after
we are all done like this patch does makes sense.  I am not sure
where and how the line to separate the two "remove" patches is
drawn, though.  Is there a reason why they need to be two patches?
