Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8F6C001DF
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 17:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjHDR4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjHDR4e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 13:56:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C718195
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 10:56:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC92B1A4D03;
        Fri,  4 Aug 2023 13:56:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jn5DJTmXNoVnxLiSJFIwg2s+1Ux0fEdi6+Mp8q
        /QLoI=; b=TwmviES6HLn6qvMGRKa+Bc4OwIQdoP9f/2Qa3ux/TpiiB4IQvRDp/N
        HAgn4sOP5DFx1YZ6ZdiMugfBin0iL51UBvET1ojTN0630L6daKxFMJHx2KTEBUYO
        SUGHQOb+lEqh+g3C+5QrpRTw4fPQDe+g7U6iZnWTX1bknQjKhEJoc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C39BA1A4D02;
        Fri,  4 Aug 2023 13:56:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 343961A4D01;
        Fri,  4 Aug 2023 13:56:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] gitignore: ignore clangd .cache directory
References: <20230804171328.1737188-1-sandals@crustytoothpaste.net>
Date:   Fri, 04 Aug 2023 10:56:31 -0700
In-Reply-To: <20230804171328.1737188-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 4 Aug 2023 17:13:28 +0000")
Message-ID: <xmqqwmya1yk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3ECE15B6-32F0-11EE-A1A1-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> From: "brian m. carlson" <bk2204@github.com>
>
> In at least some versions of clangd, including version 15 in Ubuntu
> 23.04, a directory, .cache, is written in the root of the repository
> with index information about the files in the repository.  Since clangd
> is the most common language server protocol (LSP) implementation for C,
> and we already support it using the GENERATE_COMPILATION_DATABASE flags
> to make it functional, it's likely many users are using or will want to
> use it.
>
> As a result, ignore the ".cache" directory to help avoid users
> accidentally committing the data.

Thanks.  Let's fork from maint and queue it directly on 'next', and
fast track it to the upcoming release.

> Signed-off-by: brian m. carlson <bk2204@github.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index e875c59054..5e56e471b3 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -222,6 +222,7 @@
>  /TAGS
>  /cscope*
>  /compile_commands.json
> +/.cache/
>  *.hcc
>  *.obj
>  *.lib
