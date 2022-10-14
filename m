Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14F4C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJNVZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJNVYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:24:50 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9798DDA2
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:24:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF7521C2366;
        Fri, 14 Oct 2022 17:24:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DzBGat7vUZLjVxscjg8FFvZFaP2sw8Ut4Iy76F
        AIAxQ=; b=Jy1SvGhOQBAILheCMh9vvr9Zk6xzMrP2P8TRrj+QzB8KWAPta0i72/
        VD2lZ+DdcBk0JTL6ZctbwPM8I7QuRJEPJ6Rsg0OsSpanDWQCt7g/PHnLniiO4Goe
        UDHOqgHpK02E3HTcFTMmH2ETzdqw1Dae40Sv2bI2U89dNo0bxKZps=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8D2C1C2365;
        Fri, 14 Oct 2022 17:24:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DCB9A1C2362;
        Fri, 14 Oct 2022 17:24:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH v3 5/7] builtin: patch-id: add --include-whitespace as a
 command mode
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <bbaa2425ad0cbb4b945cdce3402c6ed5fab381ec.1665737804.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 14:24:15 -0700
In-Reply-To: <bbaa2425ad0cbb4b945cdce3402c6ed5fab381ec.1665737804.git.gitgitgadget@gmail.com>
        (Jerry Zhang via GitGitGadget's message of "Fri, 14 Oct 2022 08:56:42
        +0000")
Message-ID: <xmqqbkqe6qv4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EE40FF0-4C06-11ED-BE3A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +--include-whitespace::
> +	Use the "stable" algorithm described below and also don't strip whitespace
> +	from lines when calculating the patch-id.
> +
> +	This is the default if patchid.includeWhitespace is true and implies
> +	patchid.stable.

This seems very much orthogonal to "--stable/--unstable.  

Because the "--stable" variant is more expensive than "--unstable",
I am not sure why such an implication is a good thing to have.  Why
can we not have

    --include-whitespace --stable
    --include-whitespace --unstable

both combinations valid?
