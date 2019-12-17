Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3403C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765312082E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bQ0w9AiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfLQSgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:36:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51387 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLQSgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 13:36:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D89A03B61D;
        Tue, 17 Dec 2019 13:35:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=il9yX5jl/GrLC3Qwb9NF3qtM2VI=; b=bQ0w9A
        iGdHmC6aQimSPEiInMkKs0PIfGa7N3mjXDFZSwbyuortyENPVjuwLcIezm1Jf5pf
        R1ebsJP6cnO/3oCjxnkqMKevF78tDkvUnM7Q6pxM7VlGN7L3jTwSQ602xYUJJFEx
        5MDWjI8NsNp17LjjM6gzKoPz74r+B6MeOAYNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BnicI2KdnEqUw8V1HufOxbnA8h+ziVw/
        XFpsSN2cnDNJbZ8mrjyZDGEchfKXfgdTYkG8t8xvd0rvkUOHTZKYXFieKqs1iK2g
        FTBgUtS2bf1znv7aHyeAdgxDKnRFd1EMtEjg/CoY+h8wvM+P4jKtBBT10DNbCwpA
        iQTZCeeALRg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFA9A3B61A;
        Tue, 17 Dec 2019 13:35:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 339083B619;
        Tue, 17 Dec 2019 13:35:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 04/15] t0003: use named parameters in attr_check()
References: <cover.1576583819.git.liu.denton@gmail.com>
        <f1acb2a0dfb39a4ff047d721edde821e9e296e72.1576583819.git.liu.denton@gmail.com>
Date:   Tue, 17 Dec 2019 10:35:56 -0800
In-Reply-To: <f1acb2a0dfb39a4ff047d721edde821e9e296e72.1576583819.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 17 Dec 2019 04:01:29 -0800")
Message-ID: <xmqqsglihkab.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10B3C5FE-20FC-11EA-81C7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> We had named the parameters in attr_check() but $2 was being used
> instead of $expect. Make all variable accesses in attr_check() use named
> variables instead of numbered arguments for clarity.
>
> While we're at it, add variable assignments to the &&-chain. These
> aren't ever expected to fail but for stylistic purposes, include them
> anyway for stylistic purposes.

That is OK but do so like this instead for brevity?

 attr_check () {
- 	path="$1" expect="$2"
+ 	path="$1" expect="$2" git_opts="$3" &&

Giving (temporary) names to incoming parameters is so common that
such a convention to save vertical screen real estate may be worth
it.

It is sad that you can pass only $IFS-free things in $3 due to the
way it is used---perhaps it is sufficient for the purpose of tests
in this script, but it still looks sad (just a comment without
anything that is actionable).

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t0003-attributes.sh | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index 71e63d8b50..c47d4cfbcd 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -5,19 +5,20 @@ test_description=gitattributes
>  . ./test-lib.sh
>  
>  attr_check () {
> -	path="$1" expect="$2"
> +	path="$1" &&
> +	expect="$2" &&
> +	git_opts="$3" &&
>  
> -	git $3 check-attr test -- "$path" >actual 2>err &&
> -	echo "$path: test: $2" >expect &&
> +	git $git_opts check-attr test -- "$path" >actual 2>err &&
> +	echo "$path: test: $expect" >expect &&
>  	test_cmp expect actual &&
>  	test_line_count = 0 err
>  }
>  
>  attr_check_quote () {
> -
> -	path="$1"
> -	quoted_path="$2"
> -	expect="$3"
> +	path="$1" &&
> +	quoted_path="$2" &&
> +	expect="$3" &&
>  
>  	git check-attr test -- "$path" >actual &&
>  	echo "\"$quoted_path\": test: $expect" >expect &&
