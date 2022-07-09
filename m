Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED5C433EF
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 21:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiGIVGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 17:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGIVGf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 17:06:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C5F5AC
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 14:06:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A83F718F2D0;
        Sat,  9 Jul 2022 17:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PfJkKAKS7Ni0
        aK6Hk+nAUA2l5pRF2CEuzbOPYA1cMh4=; b=Anv1m+mXY9jgQidERoQp+3ylQrkC
        i+O61nJscEfHCmzfT1j96qxcyUfUeeP6l9Q9gbwz087vMSz8Vm/ML/AA8UTJTXGt
        rI6n0XRr7wBbj5UQEvTkS/uWyZkUxXn953vzgKd83o3a0dBcuDRfekl3O9fKVqgc
        SAI/CWzO5+J/tHI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A12FD18F2CF;
        Sat,  9 Jul 2022 17:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5252918F2CC;
        Sat,  9 Jul 2022 17:06:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
        <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
Date:   Sat, 09 Jul 2022 14:06:29 -0700
In-Reply-To: <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
        (Philip Oakley via GitGitGadget's message of "Sat, 09 Jul 2022
        16:56:21 +0000")
Message-ID: <xmqqilo6t2qy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 011975C0-FFCB-11EC-8A5A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philip Oakley <philipoakley@iee.email>
>
> Bug report
>  https://lore.kernel.org/git/AM0PR02MB56357CC96B702244F3271014E8DC9@AM0=
PR02MB5635.eurprd02.prod.outlook.com/
> noted that a file containing /r/r/n needed renormalising twice.

Did you mean backslash, not forward?

> This is by design. Lone CR characters, not paired with an LF, are left
> unchanged. Note the lack of idempotentness of the "clean" filter in the
> documentation.

OK.


> Renormalize was introduced at 9472935d81e (add: introduce "--renormaliz=
e",
> Torsten B=C3=B6gershausen, 2017-11-16)

Does this need to be said "HERE", rather than leaving it to run "git
blame" for those who became curious?

> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  Documentation/git-add.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 11eb70f16c7..c4a5ad11a6b 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -188,7 +188,8 @@ for "git add --no-all <pathspec>...", i.e. ignored =
removed files.
>  	forcibly add them again to the index.  This is useful after
>  	changing `core.autocrlf` configuration or the `text` attribute
>  	in order to correct files added with wrong CRLF/LF line endings.
> -	This option implies `-u`.
> +	This option implies `-u`. Lone CR characters are untouched, so
> +	cleaning not idempotent. A CRCRLF sequence cleans to CRLF.

Lack of verb BE somewhere.

Do we expect our readers all understand the math-y word?  It is not
too hard to explain it to math-uninitiated, e.g.

    This option implies `-u`.  Note that running renormalize again
    on the result of running renormalize may make it even "more
    normal".  A CR-CR-LF sequence would first renormalize to CR-LF
    (the first CR, a lone CR, is left intact, and CR-LF that follows
    normalizes to LF).  If you run renormalize again, the resulting
    CR-LF will normalize down to LF.

