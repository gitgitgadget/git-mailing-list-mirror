Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B0DC433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 22:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiERWFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 18:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiERWFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 18:05:20 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D825550E0A
        for <git@vger.kernel.org>; Wed, 18 May 2022 15:02:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D57D18B05F;
        Wed, 18 May 2022 18:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=80dC+LbWJUkx2oUgI9qe1YzpFtFErPanHB3LX8
        /x+2c=; b=b3RabkkuOedrJ5O2tbzL/OMYbMLrKhzV8tcHI9+gzxYkjF207NmyyI
        pEsJB92MXOw3ZSP5FrNhrN1xtj8yVojp4o1Gg6rPwjCoPClqAuqxaeVjqnNaRVoM
        G4SQbVC0AJSRHMtpgATrrYVEpMC8hwm/rAYOIixl/dWAP8Qx1CZew=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2621818B05E;
        Wed, 18 May 2022 18:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4C25C18B05D;
        Wed, 18 May 2022 18:02:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Yuyi Wang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: Re: [PATCH] Add pcre2 support for cmake build system.
References: <pull.1267.git.git.1652846305514.gitgitgadget@gmail.com>
Date:   Wed, 18 May 2022 15:02:47 -0700
In-Reply-To: <pull.1267.git.git.1652846305514.gitgitgadget@gmail.com> (Yuyi
        Wang via GitGitGadget's message of "Wed, 18 May 2022 03:58:25 +0000")
Message-ID: <xmqq1qwqts6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 410C39C2-D6F6-11EC-A02C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Yuyi Wang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yuyi Wang <Strawberry_Str@hotmail.com>
>
> This commit fixes one of the TODOs listed in the CMakeLists.txt.
>
> There's also some small fix to ensure it builds successfully.
>
> Signed-off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
> ---

I haven't worked on the CMakeLists but is the above description
sufficient to tell what is going on if given to those who are
familiar with it (I ask because it is not clear at all to me).

> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 185f56f414f..99d6cb963c4 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -54,7 +54,7 @@ set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>  
>  option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.  Only applicable to Windows platforms" ON)
>  if(NOT WIN32)
> -	set(USE_VCPKG OFF CACHE BOOL FORCE)
> +	set(USE_VCPKG OFF CACHE BOOL "" FORCE)
>  endif()

Is this "small fix to ensure it builds successfully"?  To those who
do not need/want to use pcre2, is this hunk still needed to "build
successfully", or is this something that becomes necessary only
because we have other hunks in this patch to add support to pcre2?

If the former, then perhaps the change deserves to be its own patch
with own explanation why it is necessary, what breaks without it,
etc.

Thanks.
