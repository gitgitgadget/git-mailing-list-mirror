Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC93C77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243939AbjEOTsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjEOTsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:48:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D527AD2C
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:48:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B8811F6B77;
        Mon, 15 May 2023 15:48:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d9BHsyfEJi6VBzs04eWf9x+6+v8bphg6Ir7XdR
        el5U8=; b=AMbz9KYhGhTfNuemaByWuFaCIXZqYYWIVtmOU5MhKo+Mw71S5WU5rp
        7HIKphPNVIDCG3h4e+Zi9IG9Of2+tp/YGRhvkqWYNsyFwJWFitJd+0xs1WYTn8yN
        r+sc/9fMnA7L7927313EEvSiRaDIzuSBgvqS1YQ3HKHxJsmof4a6Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93F7A1F6B76;
        Mon, 15 May 2023 15:48:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C51631F6B74;
        Mon, 15 May 2023 15:48:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>
Subject: Re: [PATCH v3 1/6] show-ref doc: update for internal consistency
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <fe442c2041b01985a4ecb0f2e9651231af2a439b.1684152793.git.gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 12:48:26 -0700
In-Reply-To: <fe442c2041b01985a4ecb0f2e9651231af2a439b.1684152793.git.gitgitgadget@gmail.com>
        (Sean Allred via GitGitGadget's message of "Mon, 15 May 2023 12:13:08
        +0000")
Message-ID: <xmqqttwd8jg5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76265A18-F359-11ED-B0FF-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Allred via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sean Allred <allred.sean@gmail.com>
>
> - Use inline-code syntax for options where appropriate.
> - Use code blocks to clarify output format.
>
> This patch also swaps out 'SHA-1' language for the implementation-
> agnostic 'OID' term where appropriate in preparation for supporting
> different hashing algorithms.

Making the last one into the third bullet item, e.g.

    - Use OID instead of SHA-1, as we support different hashing
      algorithems these days.

would have been even easier to follow, but I'll let it pass.  

In prose, "object name" would flow better than OID (the original
would say not just "SHA-1" but use "SHA-1 hash" or somesuch in such
a context), I would think.  When used as a placeholder, OID would be
perfectly fine (<oid>, where we used to write <hash> or <sha-1> or
<SHA-1>).

>  -s::
>  --hash[=<n>]::
>  
> -	Only show the SHA-1 hash, not the reference name. When combined with
> -	--dereference the dereferenced tag will still be shown after the SHA-1.
> +	Only show the OID, not the reference name. When combined with
> +	`--dereference`, the dereferenced tag will still be shown after the OID.

Not a problem you created, but I noticed we do not explain what
"=<n>" up there does.

> @@ -96,7 +96,13 @@ OPTIONS
>  OUTPUT
>  ------
>  
> -The output is in the format: '<SHA-1 ID>' '<space>' '<reference name>'.
> +The output is in the format:
> +
> +------------
> +<oid> SP <ref> LF
> +------------
> +
> +For example,

OK.

> @@ -110,7 +116,13 @@ $ git show-ref --head --dereference
>  ...
>  -----------------------------------------------------------------------------
>  
> -When using --hash (and not --dereference) the output format is: '<SHA-1 ID>'
> +When using `--hash` (and not `--dereference`), the output is in the format:
> +
> +------------
> +<OID> LF
> +------------
> +
> +For example,

Let's consistently use <oid> in lowercase as the previous hunk.

Everything else looked great in this step.  Thanks for working on this.
