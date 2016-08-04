Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E15820193
	for <e@80x24.org>; Thu,  4 Aug 2016 17:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934138AbcHDRSd (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 13:18:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934067AbcHDRSc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 13:18:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B08F31AF9;
	Thu,  4 Aug 2016 13:18:31 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HAom+AEC1OByRyk8ioQxvrV3BaQ=; b=S0E/cj
	wYaavZjBhAB0/itI26kjcALa76zsztR9UtsrF61/NVJASmUSGQfLH3j+HgY+pq4I
	ZTku7+fOWWOuQo98thAVwZapA/wJ5LsvIZcTYwTdcQcEc2cDYsXEdDVT2qJFckt4
	WC/KnzUrK49cqgqHTm1B321X7LAtp5sM9XJ9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J91ZZI4Shmdl1ohXAK+n5UbIl/GifFAI
	ztV7breVgdJJACgOqr3M2nMGQhr+sA/PQOp004ZSkKuBxGx84/NOwz5Ec1nl+AJf
	o0lV8p8iNEYA6NZcaKeuiynMpAjOgC5T35WQ3qd/N6LG+aQkZbwJhFYhdlMAQ3Yu
	Tg9c5tknztU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2391C31AF8;
	Thu,  4 Aug 2016 13:18:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A2CD31AF6;
	Thu,  4 Aug 2016 13:18:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] t5533: make it pass on case-sensitive filesystems
References: <93e1fb21d1d24c5b751e2d9d25d9220704bae5aa.1470322425.git.johannes.schindelin@gmx.de>
Date:	Thu, 04 Aug 2016 10:18:28 -0700
In-Reply-To: <93e1fb21d1d24c5b751e2d9d25d9220704bae5aa.1470322425.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 4 Aug 2016 16:54:35 +0200
	(CEST)")
Message-ID: <xmqqwpjw4fmj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77069728-5A67-11E6-BBF9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The newly-added test case wants to commit a file "c.t" (note the lower
> case) when a previous test case already committed a file "C.t". This
> confuses Git to the point that it thinks "c.t" was not staged when "git
> add c.t" was called.
>
> Simply make the naming of the test commits consistent with the previous
> test cases: use upper-case, and advance in the alphabet.
>
> This came up in local work to rebase the Windows-specific patches to the
> current `next` branch. An identical fix was suggested by John Keeping.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/t5533-case-insensitive-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git t5533-case-insensitive-v1

Thanks.  It may make it easier to see to have a blank line here,
separating them from the diffstat.

>  t/t5533-push-cas.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index 09899af..a2c9e74 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -220,7 +220,7 @@ test_expect_success 'new branch already exists' '
>  	(
>  		cd src &&
>  		git checkout -b branch master &&
> -		test_commit c
> +		test_commit F
>  	) &&
>  	(
>  		cd dst &&

Thanks.

> -- 
> 2.9.0.281.g286a8d9
> 
> base-commit: 9813b109b4ec6630220e5f3d8aff275e23cba59e

A totally unrelated tangent.

This line turns out to be less than useful at least in this
particular case.

The fix is meant for jk/push-force-with-lease-creation topic, but I
had to find it out by the old fashioned way, i.e. running blame for
these lines in 'pu' to find eee98e74f9 is the culprit and then
running "git branch --with eee98e74f9".  The only thing the line
made easier is I _could_ start the blame at the named commit (which
is on 'next') instead of 'pu'.  When I took that "base-commit"
series, I was hoping that it would give us a lot more useful
information.


