Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB30C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 22:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiFHWyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 18:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiFHWyE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 18:54:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B30353B17
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 15:54:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56569192C67;
        Wed,  8 Jun 2022 18:54:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w1UxEROnI6HDRmf/HueyXvDZ6/XnADEBBUVsFM
        JX2HY=; b=K+xE3yne2OmFGTj2zgIrSWH3O6c0ceXK2G9CdXDG6M4/7kqAnTomjW
        taXKcqPFTuw8BEby4c33nxjp6zJsUbCX5i8I78BAYLpVA4iVwEVhtUoUkDxLIQYM
        iEqU2OrxOQ9iC4gdKHak0UjyN86SEEDe/U3o6dvNDFHkFoA472Z8E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FC8E192C65;
        Wed,  8 Jun 2022 18:54:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1437192C63;
        Wed,  8 Jun 2022 18:53:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Best way to update `HEAD` in mirrored repos
References: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com>
Date:   Wed, 08 Jun 2022 15:53:55 -0700
In-Reply-To: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com>
        (Rodrigo Silva Mendoza's message of "Wed, 8 Jun 2022 13:36:02 -0700")
Message-ID: <xmqq5ylapy0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0CB95B0-E77D-11EC-88E0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com> writes:

> What I've got that I think works
> 1. Get the ref from the origin that points to `HEAD`. Extract the ref
> from the output.
> 2. Manually update the `HEAD` ref with the extracted output prior step
>
> Like so:
> ```
> $ git ls-remote --symref origin HEAD
> ref: refs/heads/good_main_3     HEAD
> 0666a519f94b8500ab6f14bdf7c9c2e5ca7d5821        HEAD
>
> $ git symbolic-ref HEAD refs/heads/good_main_3
> ```
>
> Does this make sense?

Yes.  That soudns like the right thing to do.

