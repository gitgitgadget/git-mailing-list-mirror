Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BE5C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FE56103B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhI0Qh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:37:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58851 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhI0Qh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:37:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6C52E8F63;
        Mon, 27 Sep 2021 12:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TrT8kFDQhY7D
        LdxJIcyEemE4Hpy676GKxfAX0ZCBwjw=; b=rxcjmmnbwdp+jcW2bBN+fUKPTAof
        Qm1n3PLAOKOqE/5Ua3+Q8+2QR+cqOrwVkFxriaFpylJVOn03OQ8csFyz6dHAEE7p
        JMkLFuT4SujW2nKQoNc0QZVi+IXeNPKiz3AMxEHJ4oaKgA1YuQjZONOpW0zXyiIL
        BeHK8LR7Pi/0gvg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCBB2E8F62;
        Mon, 27 Sep 2021 12:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 384A3E8F61;
        Mon, 27 Sep 2021 12:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org
Subject: Re: [PATCH v3 2/2] lazyload.h: use an even more generic function
 pointer than FARPROC
References: <20210923065251.21363-1-carenas@gmail.com>
        <20210926100512.58924-1-carenas@gmail.com>
        <20210926100512.58924-3-carenas@gmail.com>
Date:   Mon, 27 Sep 2021 09:35:48 -0700
In-Reply-To: <20210926100512.58924-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 26 Sep 2021 03:05:12 -0700")
Message-ID: <xmqqk0j2q8m3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F8EAC552-1FB0-11EC-974B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> gcc will helpfully raise a -Wcast-function-type warning when casting
> between functions that might have incompatible return types
> (ex: GetUserNameExW returns bool which is only half the size of the
> return type from FARPROC which is long long), so create a new type that
> could be used as a completely generic function pointer and cast through
> it instead.
>
> Because of the way the function declaration was done in the previous
> patch the order of variables that use it had to be adjusted so that
> it is the last variable declared, as well.

Is it clear to everybody what this paragraph is referring to?  It is
not, at least to me.

>
> Additionaly remove the -Wno-incompatible-pointer-types temporary
> flag added in 27e0c3c (win32: allow building with pedantic mode
> enabled, 2021-09-03), as it will be no longer needed.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> v3
> - removes unnecessary variable moving after fixup in previous patch

Thanks.
