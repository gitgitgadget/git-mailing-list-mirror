Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEF2C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754C02074D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lw2J9qCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgCYGfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:35:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59824 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYGfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:35:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C676652008;
        Wed, 25 Mar 2020 02:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iyKmMywYURBLg75yQW19CAY2NOQ=; b=lw2J9q
        CeCBFYF+jB5aCZM92646G1+/9RSWj7SlJcAghaOomZsZupaZ2i7ki46g//GBXzqt
        MUfSIRmgD6XZUSAS+/qoU1Isgp6oE72z6WKPj39C/9GTxXt6tGCJQfbU3qv4S3Ur
        tgfz5RqrdANTHD+R2QtOs/m5wcdoTuzYMgu7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B6xBRUrrVre74xTTUeQQ3sk4q+D2o/EF
        Uh6kUTwJFckm+WBnJVYYMCV2yYwI8c8np5l+9MC3s1MDnhN0v/lpdt+gIA2mWWSe
        SOuyLT+oEpCTONOlikTTeCLHbgKtWbwsdAn1TLbbIUmPQtrSvZX1qaCx/NG+bPRP
        055sqD//IKA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCF2A52006;
        Wed, 25 Mar 2020 02:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 326B752005;
        Wed, 25 Mar 2020 02:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/8] t5550: remove use of `test_might_fail grep`
References: <cover.1585115341.git.liu.denton@gmail.com>
        <68c911e29b509d75e390aba573921d6ac385fcaf.1585115341.git.liu.denton@gmail.com>
Date:   Tue, 24 Mar 2020 23:35:49 -0700
In-Reply-To: <68c911e29b509d75e390aba573921d6ac385fcaf.1585115341.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 25 Mar 2020 01:54:51 -0400")
Message-ID: <xmqqr1xhx7p6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE376F54-6E62-11EA-8F29-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The test_must_fail() family of functions (including test_might_fail())
> should only be used on git commands. Rewrite the use of
> test_might_fail() with grep to remove this improper usage.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t5550-http-fetch-dumb.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index b811d89cfd..a06294ad8f 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -248,7 +248,7 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
>  '
>  
>  test_expect_success 'did not use upload-pack service' '
> -	test_might_fail grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act &&
> +	{ grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act || :; } &&

We can use

	sed -n -e "/\/git-upload-pack/p" "$HTTPD_ROOT_PATH/access.log" >actual

instead, but "grep for the pattern but don't worry if we found no
match" is also OK.

>  	: >exp &&
>  	test_cmp exp act

Having said that, if the expectation is not to find any match,
shouldn't the whole test be just

	! grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"

a single liner?  In any case, the use of sq in the original is broken.

>  '
