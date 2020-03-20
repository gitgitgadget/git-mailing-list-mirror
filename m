Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C07DC4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414C520739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 18:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VCdDStXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCTSEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:04:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59799 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTSEr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 14:04:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9AFB7C4DF4;
        Fri, 20 Mar 2020 14:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aADL2vG0QAr2TuET4+jg9RKcN3E=; b=VCdDSt
        XXjdNEIjLZ9DQWeBx8qltbKNbaUteCl77UXgKoA3S1ZT4fBQtnwA2NivRSrO4vbk
        sVR8TBuUDtLSa7ERisFrEHqA2AudpXEoHSJGMCverLmQpzz2zb8P0mf6GKH8LlKf
        MRK920GRwLUto3idWfFwKXZiqTQkc0ZgeFMpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wyj1FeXUNW0m/SpkQ+7WY8uU1H3g7yYY
        hBy1NyTAaryVYCSF6vMni2VxL2PB9Xnj0vw2rXnfN7Er7ktKnpKnx4Zx4tK5VIHq
        WZQJTCBefj/ytoGW8uxNlMTrmRrhixotjJMBnILT+/MmTIGTH/ei+33Mru2VV1ea
        so2GMLeQsh4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 933E0C4DF3;
        Fri, 20 Mar 2020 14:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 603C4C4DEF;
        Fri, 20 Mar 2020 14:04:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adrian Wijaya <adrianwijaya100@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [GSOC][PATCH v2] t1300: convert "test -f" with "test_path_is_file"
References: <CA+0Uiy-gtdn07=QOx3JcOH-zhMz5yAKOW6=9mNc8Zi+RdfWGyQ@mail.gmail.com>
        <20200320160723.15190-1-adrianwijaya100@gmail.com>
Date:   Fri, 20 Mar 2020 11:04:40 -0700
In-Reply-To: <20200320160723.15190-1-adrianwijaya100@gmail.com> (Adrian
        Wijaya's message of "Fri, 20 Mar 2020 23:07:23 +0700")
Message-ID: <xmqq4kuidhs7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 460D7FEC-6AD5-11EA-BF6D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adrian Wijaya <adrianwijaya100@gmail.com> writes:

> Subject: Re: [GSOC][PATCH v2] t1300: convert "test -f" with "test_path_is_file"

I thought the suggestion was either "replace with" or "convert
into", but the above looks a bit funny cross between them.  I'd
probably go with "replace".

> Convert "test -f" with "test_path_is_file" to give more verbose
> test output on failure.

Likewise, but the first part is already said in the title.  So

	Subject: t1300: replace "test -f" with "test_path_is_file"

	This way, the test will not fail silently, making it easier
	to diagnose.

or something like that, perhaps.

> Signed-off-by: Adrian Wijaya <adrianwijaya100@gmail.com>
> ---
>  t/t1300-config.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 97ebfe1f9d..d74554fc09 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1020,11 +1020,11 @@ test_expect_success SYMLINKS 'symlinked configuration' '
>  	ln -s notyet myconfig &&
>  	git config --file=myconfig test.frotz nitfol &&
>  	test -h myconfig &&
> -	test -f notyet &&
> +	test_path_is_file notyet &&
>  	test "z$(git config --file=notyet test.frotz)" = znitfol &&
>  	git config --file=myconfig test.xyzzy rezrov &&
>  	test -h myconfig &&
> -	test -f notyet &&
> +	test_path_is_file notyet &&
>  	cat >expect <<-\EOF &&
>  	nitfol
>  	rezrov
