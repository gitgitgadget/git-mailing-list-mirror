Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAFEC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 20:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiGMUUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGMUUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 16:20:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEDA20F5B
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:20:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02F0B1AFE42;
        Wed, 13 Jul 2022 16:20:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gh9cIuXkYXy4ve64Z1CawJf1rW8LCuLB6IPT+u
        9RjOA=; b=rBUhGX0NVo524+lrard9kdP0n1vEGrg8Z/4dWAcImaKteyP7d6a4gE
        soqoth1b3jV4qksm8rrgVbYPGRZil+R8d5Hwl6plMPTn4teqqYo/f2IzUXUo1vJy
        iVubPrcXSsGPAkVYW7FxtCBjBg1IlSrB6ZSa1Rhq2Fq8eVJ/wUXyk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFCC11AFE41;
        Wed, 13 Jul 2022 16:20:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8590F1AFE40;
        Wed, 13 Jul 2022 16:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] Documentation: use allowlist and denylist
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
        <ec81aac05c40318755f5311a20e8f9cc55d289fc.1657718450.git.gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 13:20:10 -0700
In-Reply-To: <ec81aac05c40318755f5311a20e8f9cc55d289fc.1657718450.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 13 Jul 2022
        13:20:48 +0000")
Message-ID: <xmqqk08gbw91.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32767444-02E9-11ED-AD03-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -313,7 +313,7 @@ circumstances, allowing easier restricted usage through git-shell.
>  
>  GIT_CVSSERVER_BASE_PATH takes the place of the argument to --base-path.
>  
> -GIT_CVSSERVER_ROOT specifies a single-directory whitelist. The
> +GIT_CVSSERVER_ROOT specifies a single-directory allowlist. The

Nowhere before this documentation there is mention of white/allow.
They consistently say "list of allowed directories".

It may probably make the resulting text much easier to read if we
avoid the non-word "allowlist", which was recently invented only to
avoid using the word "whitelist".

    GIT_CVSSERVER_ROOT specifies a single allowed directory.

IOW, the original did not even have to say "whitelist".

> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index fdc28c041c7..ff74a90aead 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -33,7 +33,7 @@ It verifies that the directory has the magic file "git-daemon-export-ok", and
>  it will refuse to export any Git directory that hasn't explicitly been marked
>  for export this way (unless the `--export-all` parameter is specified). If you
>  pass some directory paths as 'git daemon' arguments, you can further restrict
> -the offers to a whitelist comprising of those.
> +the offers to a allowlist comprising of those.

"a -> an"; but I think the same suggestion as cvs-server equally
applies here.

    -for export this way (unless the `--export-all` parameter is specified). If you
    -pass some directory paths as 'git daemon' arguments, you can further restrict
    -the offers to a whitelist comprising of those.
    +for export this way (unless the `--export-all` parameter is specified).
    +You can furtherrestrict the offers by passing the list of allowed directories
    +as 'git daemon' arguments.

would be much easier to understand, with or without s/white/allow/.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 302607a4967..384718ee677 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -887,7 +887,7 @@ for full details.
>  	protocols has `protocol.<name>.allow` set to `always`
>  	(overriding any existing configuration). In other words, any
>  	protocol not mentioned will be disallowed (i.e., this is a
> -	whitelist, not a blacklist). See the description of
> +	allowlist, not a denylist). See the description of

As I always tell contributors in my review, whenever we see "In
other words" and parenthesized follow-up explanation, we should take
it as an admission by the author that whatever the author wrote
before it is badly written and should have been expressed in a more
clear way.

    In other words, only the protocols listed on this variable are
    allowed and all others are disallowed.  See the description of
    ...

without "(i.e....)" would be shorter and easier to read, I would
think.

