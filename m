Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B909C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C963A2072A
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TzT9T7X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgD2Qzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:55:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62711 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgD2Qzh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 12:55:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C396E45680;
        Wed, 29 Apr 2020 12:55:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uBAbFnTlXgoBFJoo+6GtKbIBTLY=; b=TzT9T7
        X9IhLF2Qw8FUBe0XEkrC7TXQvvn6zBIBi6CvZUsurqraXzdDu9910hJ2M6Q4hw4j
        i2Y+WjBHpmctTO84pEhw+0F1vvdIAN4gMxLb57kWLEK6ad5gDACdadiks4hyCokE
        UpddT7pcv2aYBsNmCU6CsV3FJ+6ZgGOBWUkbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FsROMsVnvuogaWKEHxiGnM22Ip5ItnKv
        RlT5eYl6ZoOIJtYDY0HnRiHAIe0Ck4BUT6hNWdlhzq7X5DmQ+38WVS/3iAzaz6ip
        fVzSxVeT+3m3Rzy7Xi//7TUJl0RVdgO38UC0GriFi2CdFjWprk1jDz9RjjtqpRpq
        pa16bv3sMZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B94A94567F;
        Wed, 29 Apr 2020 12:55:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39F024567E;
        Wed, 29 Apr 2020 12:55:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 1/4] gitfaq: files in .gitignore are tracked
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
Date:   Wed, 29 Apr 2020 09:55:35 -0700
In-Reply-To: <20200429093811.8475-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 29 Apr 2020 15:08:08 +0530")
Message-ID: <xmqqimhixmd4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F46E070-8A3A-11EA-A969-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add issue in 'Common Issues' section which addresses the problem of
> Git tracking files/paths mentioned in '.gitignore'.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 1cf83df118..b1e758ffd1 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -223,6 +223,15 @@ a file checked into the repository which is a template or set of defaults which
>  can then be copied alongside and modified as appropriate.  This second, modified
>  file is usually ignored to prevent accidentally committing it.
>  
> +[[files-in-.gitignore-are-tracked]]
> +I asked Git to ignore various files, yet they are still tracked::
> +	A `gitignore` file specifies intentionally untracked files
> +	that Git should ignore. Files already tracked by Git are
> +	not affected. See linkgit:gitignore[5] for details.
> +	To ignore and untrack the files appearing in the staging are
> +	it is advised to use `git rm --cached <file>`as well as make
> +	the file pattern is mentioned in the '.gitignore'.

After trimming down, it got a lot more readable.  The last sentence
is not quite, though, with riddled with typos.  Also the order of
untrack/ignore and steps to achieve these two things should match in
the description.

	To untrack and ignore files, use `git rm --cached <file>`
	and add a pattern to `.gitignore` that matches the <file>.

may be the minimum fix.

Thanks.
