Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F360AC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhK2Xe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:34:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61067 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhK2XeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:34:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CFC1161958;
        Mon, 29 Nov 2021 18:31:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mgGWORe/1xOwn+/HcyTYUgUiMEOusEahKiRKYl
        xdhq0=; b=MWG5gfZg8+HMrGnRi0shXrU3qmDM9TZ+5Yk7sj9uw6ZGfYX6qR7zKG
        JulVr+NCm2xGXrGbWW5XMOsFxupdfguAn5HFPEXt4CM6miZNJOQpduENk/Bg+kw2
        RlnlhHNXAjSOfkw3Y2F6at9s9fUCmTC7AgSSAbQUxN4Bp+7bpvqSg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55A4F161957;
        Mon, 29 Nov 2021 18:31:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B150161953;
        Mon, 29 Nov 2021 18:31:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 4/6] refs: add REF_SKIP_REFNAME_VERIFICATION flag
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <0a297f0c3e884c2d4cfb24a6d3b9f1973fc83125.1638211786.git.gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:31:02 -0800
In-Reply-To: <0a297f0c3e884c2d4cfb24a6d3b9f1973fc83125.1638211786.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 29 Nov 2021
        18:49:44 +0000")
Message-ID: <xmqqbl224k09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B01612C-516C-11EC-983B-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
> +	    ((new_oid && !is_null_oid(new_oid)) ?
> +		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
> +			   !refname_is_safe(refname))) {

So, if somebody passes REF_SKIP_REFNAME_VERIFICATION in flags, we
will not do the check.

Again, like 3/6, this new bit is flipped on by test-helper
somewhere?  Again I do not see anybody doing so in these 6 patches,
but I should double check.
