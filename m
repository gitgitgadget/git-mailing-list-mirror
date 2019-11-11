Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01191F454
	for <e@80x24.org>; Mon, 11 Nov 2019 02:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfKKC3C (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 21:29:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63242 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfKKC3C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 21:29:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F2CB8F536;
        Sun, 10 Nov 2019 21:29:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AH20arijAE1cj01RAJnzoOdr+5k=; b=A0Hcv2
        6E0H16/tP7FIoyCk/raNHTnYMcmB+duQTNXoy9bffk9o5HdqWA15eOkG3cnZj0bt
        5j9+hH04SAGcjT8bYN0o2ctLLgiAt1qAXN3GXmJfa/PXkX2CDNZ3aVdZJEKilgMH
        lNaCf3xvGsV5ed+vZAh+1mkobqwEX7CzMvnT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bJ1ixTeF5QjXnbGour3mg0vCfbxvF1HO
        N031ETKQwY3rVIxw6y2x6F6TEszGIW0s3629zl5FHJ1u7IkGTIlZI4EY2n4Jwoyh
        eEbDXz9xi/QybjelJECtYvELL8pGZBMzGl6ygtpbmAzYjgHCZUfPPmUzxZKlTTr+
        Y0QBtASi688=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37C188F535;
        Sun, 10 Nov 2019 21:29:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6472F8F534;
        Sun, 10 Nov 2019 21:28:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Holland <anowlcalledjosh@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: support Python async functions
References: <20191111010148.2812-1-anowlcalledjosh@gmail.com>
Date:   Mon, 11 Nov 2019 11:28:55 +0900
In-Reply-To: <20191111010148.2812-1-anowlcalledjosh@gmail.com> (Josh Holland's
        message of "Mon, 11 Nov 2019 01:01:48 +0000")
Message-ID: <xmqqpnhzi1so.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 035591A0-042B-11EA-B9C0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Holland <anowlcalledjosh@gmail.com> writes:

> Python's async functions (declared with "async def" rather than "def")
> were not being displayed in hunk headers. This commit teaches git about
> the async function syntax, and adds tests for the Python userdiff regex.
>
> Signed-off-by: Josh Holland <anowlcalledjosh@gmail.com>
> ---
>  t/t4018/python-async-def | 4 ++++
>  t/t4018/python-class     | 4 ++++
>  t/t4018/python-def       | 4 ++++
>  userdiff.c               | 2 +-
>  4 files changed, 13 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4018/python-async-def
>  create mode 100644 t/t4018/python-class
>  create mode 100644 t/t4018/python-def

It seems that there were no test patterns for Python ;-) The change
to userdiff.c part (i.e. "where we used to expect 'def', we now
allow it to be prefixed with an optional 'async' plus whitespace")
makes sense.

Thanks, will queue.
