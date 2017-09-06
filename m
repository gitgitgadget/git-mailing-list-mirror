Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730D9208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 03:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbdIFDfF (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 23:35:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58588 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752353AbdIFDfE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 23:35:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCF2B96E9C;
        Tue,  5 Sep 2017 23:35:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5tGXZmRY5oU3KjHzpAMwysA0H7c=; b=Er4HEpH4+fZrn+H28KFI
        LKDBilrmAdFiTK659+dMiCv3ky7R7e4k1Ie3InNxIUOIulFbkH6kGX8SN05fXvcC
        gW8FSAGK+5hLFWolE9/yLLKKyWJo4xo68iF8D/gdO2PkjN7Jamy2CCGnG+KVUPkO
        CIUfzPaqDrF9tex5KXtUcWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=BLoIWtVwCY4eU5TiwhXmr4UraUOXMZ63uLTj4DVwzUoAU5
        87E6bWV/TOBiH4dy3vOG/RaOwwVGDg7iN91NBdYOgT/Sup2qceXXMCF3+Q6GpNk3
        toO4Xvu6g//ZfgdK5UmO8rFhnSmKoKUb4UbfiQWmbdkBWf+ZAkNp6FIQTAzj4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D37F696E9B;
        Tue,  5 Sep 2017 23:35:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F93D96E98;
        Tue,  5 Sep 2017 23:35:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] name-rev: change ULONG_MAX to TIME_MAX
References: <ef9aebb63227c36b8b72a65240a416a0271cc618.1504086318.git.git@grubix.eu>
Date:   Wed, 06 Sep 2017 12:35:01 +0900
Message-ID: <xmqqbmmo8pp6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E59FFB8-92B4-11E7-8979-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Earlier, dddbad728c ("timestamp_t: a new data type for timestamps",
> 2017-04-26) changed several types to timestamp_t.
>
> 5589e87fd8 ("name-rev: change a "long" variable to timestamp_t",
> 2017-05-20) cleaned up a missed variable, but both missed a _MAX
> constant.
>
> Change the remaining constant to the one appropriate for the current
> type
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---

Thanks.

I think this (and the earlier 5589e8) was caused by an unnoticed
semantic conflict at 78089b71 ("Merge branch 'jc/name-rev-lw-tag'",
2017-05-30).  Merging is sometimes hard ;-)

Will queue.

>  builtin/name-rev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index c41ea7c2a6..598da6c8bc 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -253,7 +253,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
>  		struct commit *commit = (struct commit *)o;
>  		int from_tag = starts_with(path, "refs/tags/");
>  
> -		if (taggerdate == ULONG_MAX)
> +		if (taggerdate == TIME_MAX)
>  			taggerdate = ((struct commit *)o)->date;
>  		path = name_ref_abbrev(path, can_abbreviate_output);
>  		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
