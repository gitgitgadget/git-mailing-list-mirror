Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80BEC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 23:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378092AbiATXIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 18:08:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57383 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347833AbiATXIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 18:08:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BF31181CF1;
        Thu, 20 Jan 2022 18:08:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WaLYSsdC5ZcljgnVnJYaYo3mNnKiMLkutex97q
        aFJWQ=; b=W32qULkz4RQ5h4rbYdrKy9yYrh7ou2T0HPnzwGCbgQBecBiuRrgt3y
        JeFLv56LRk+JnnY/rQ+cMDBZA7s4LIpZ3ZTMf6ZOBfR2zJ4uIJ9aNPwqKSbXhOnU
        ppeCAyS4JcMvwssWvaICqUHBmp0FZYPBTFBitGE85qxJGoBygtGdU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 04F3B181CF0;
        Thu, 20 Jan 2022 18:08:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6FB98181CEF;
        Thu, 20 Jan 2022 18:08:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v7 3/3] fetch --negotiate-only: do not update submodules
References: <20220119000056.58503-1-chooglen@google.com>
        <20220120174942.94231-1-chooglen@google.com>
        <20220120174942.94231-4-chooglen@google.com>
Date:   Thu, 20 Jan 2022 15:08:05 -0800
In-Reply-To: <20220120174942.94231-4-chooglen@google.com> (Glen Choo's message
        of "Thu, 20 Jan 2022 09:49:42 -0800")
Message-ID: <xmqqy23af1ka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3B37ECE-7A45-11EC-9527-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 710f33e2aa..1b9023d3f0 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -628,6 +628,18 @@ test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
>  	test_cmp err.expect err.actual
>  '
>  
> +test_expect_success 'usage: --negotiate-only with --recurse-submodules' '
> +	cat >err.expect <<-\EOF &&
> +	fatal: --negotiate-only and --recurse-submodules cannot be used together

This also needs to be updated to match.  I've fixed up locally.

