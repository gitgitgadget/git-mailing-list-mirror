Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0201F461
	for <e@80x24.org>; Fri, 12 Jul 2019 16:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfGLQr6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 12:47:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51838 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGLQr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 12:47:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3948F151AA6;
        Fri, 12 Jul 2019 12:47:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rsQHR6t8e8KX2elzcPCmTXLAt20=; b=yDh37o
        9+TihzwhYYLcZ5YKjfZPBe9mgyt/VY1oLXEbFgrqVZ1/GKsUMC41FkqsUjXv8Bza
        wqBZQWF0Z2V3M6rqG9hdQwXHhGjJ2jhiTeGUOVLfuq14X7XSdoYnaRwe0BeiCCPc
        zPrGVuUXei8ohKSLQ1HekAZkwoe01oVH6u5Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H/RS8/eGs91LvbsSll7Uqzj9F3a0dOgL
        oyjhwn3gofiKuuHjlWAgZbxkREadLk2tsg4YdkmJMkg3ceDIf0aXm4ZlXACl7uRn
        5KmV8Hf5Omm+hw+HeD9mM+L5fkfjsgLlw02ibBcDCnMx1xoT/25eUk1og5ERpO5q
        Fiwhq3IRAyQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31A0F151AA4;
        Fri, 12 Jul 2019 12:47:56 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98D22151AA3;
        Fri, 12 Jul 2019 12:47:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Morgan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Robert Morgan <robert.thomas.morgan@gmail.com>
Subject: Re: [PATCH 1/1] gpg(docs): use correct --verify syntax
References: <pull.285.git.gitgitgadget@gmail.com>
        <e2daf21f1f2574a79f83d4e66591f67b1c937efe.1562945635.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Jul 2019 09:47:54 -0700
In-Reply-To: <e2daf21f1f2574a79f83d4e66591f67b1c937efe.1562945635.git.gitgitgadget@gmail.com>
        (Robert Morgan via GitGitGadget's message of "Fri, 12 Jul 2019
        08:33:57 -0700 (PDT)")
Message-ID: <xmqqtvbrp5c5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC1B614E-A4C4-11E9-84D0-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Morgan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> index f999f8ea49..cce2c89245 100644
> --- a/Documentation/config/gpg.txt
> +++ b/Documentation/config/gpg.txt
> @@ -2,7 +2,7 @@ gpg.program::
>  	Use this custom program instead of "`gpg`" found on `$PATH` when
>  	making or verifying a PGP signature. The program must support the
>  	same command-line interface as GPG, namely, to verify a detached
> -	signature, "`gpg --verify $file - <$signature`" is run, and the
> +	signature, "`gpg --verify $signature - <$file`" is run, and the
>  	program is expected to signal a good signature by exiting with
>  	code 0, and to generate an ASCII-armored detached signature, the
>  	standard input of "`gpg -bsau $key`" is fed with the contents to be

Wow.  Good find.

gpg-interface.c::verify_signed_buffer() takes a detached signature
in core, writes it to a temporary file and runs 

    gpg --status-fd=1 --verify $the_temporary_file

and the payload that is supposed to match the given signature is fed
via the standard input, so the above documentation is the only thing
that needs fixing, which is good ;-)

Thanks.



