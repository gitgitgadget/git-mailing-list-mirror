Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3929AC4332F
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 01:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiCRBZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 21:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiCRBZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 21:25:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188B32B3D67
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 18:24:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE34912CC15;
        Thu, 17 Mar 2022 21:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HL3Ff1yWYKbn
        lnzi8SqTINO3PCZegcx5L7BEvwYgK6Y=; b=mSf8lzFU/jYYc/KF9nRCgUy3RwfD
        Nc73SiBY76zp6Pq+a9DR0WuJgcPfJad6p4UuEy4ECtUOzzvewlfiFJW0qXn/TY44
        fZZDe4XyOLn86cZ7br5j/uZVQoJVqJbSvvLEDgHhP2eCOB2zTihD8Oo+SwRa72g8
        UE4jk68auhEeFsA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5CFF12CC14;
        Thu, 17 Mar 2022 21:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28E3F12CC13;
        Thu, 17 Mar 2022 21:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 5/8] git reflog [expire|delete]: make -h output
 consistent with SYNOPSIS
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
        <patch-5.8-130e718722b-20220317T180439Z-avarab@gmail.com>
Date:   Thu, 17 Mar 2022 18:24:28 -0700
In-Reply-To: <patch-5.8-130e718722b-20220317T180439Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 17 Mar
 2022 19:08:37 +0100")
Message-ID: <xmqqczikcasz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28B4ECF6-A65A-11EC-A30C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Make use of the guaranteed pretty alignment of "-h" output added in my
> 4631cfc20bd (parse-options: properly align continued usage output,
> 2021-09-21) and wrap and format the "git reflog [expire|delete] -h"

"(expire|delete) -h", I think.  Does it matter who wrote an earlier
commit, by the way?  You do not name who did 33d7bdd6459 you refer
to in the later part of the proposed log message, for example, and
it feels simpler to consider all the past commits as just "ours".

> usage output. Also add the missing "--single-worktree" option, as well
> as adding other things that were in the SYNOPSIS output, but not in
> the "-h" output.
>
> This was last touched in 33d7bdd6459 (builtin/reflog.c: use
> parse-options api for expire, delete subcommands, 2022-01-06), but in
> that commit the previous usage() output was faithfully
> reproduced. Let's follow-up on that and make this even easier to read.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/reflog.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 25313d504a9..458764400b5 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -6,14 +6,13 @@
>  #include "reflog.h"
> =20
>  #define BUILTIN_REFLOG_EXPIRE_USAGE \
> -	N_("git reflog expire [--expire=3D<time>] " \
> -	   "[--expire-unreachable=3D<time>] " \
> -	   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] " \
> -	   "[--verbose] [--all] <refs>...")
> +	N_("git reflog expire [--expire=3D<time>] [--expire-unreachable=3D<ti=
me>]\n" \
> +	   "                  [--rewrite] [--updateref] [--stale-fix]\n" \
> +	   "                  [--dry-run | -n] [--verbose] [--all [--single-w=
orktree] | <refs>...]")

OK.  This makes the line folding match what we write in the synopsis
section of the documentation.

>  #define BUILTIN_REFLOG_DELETE_USAGE \
> -	N_("git reflog delete [--rewrite] [--updateref] " \
> -	   "[--dry-run | -n] [--verbose] <refs>...")
> +	N_("git reflog delete [--rewrite] [--updateref]\n" \
> +	   "                  [--dry-run | -n] [--verbose] <ref>@{<specifier>=
}...")

Likewise.  Looking good.


>  #define BUILTIN_REFLOG_EXISTS_USAGE \
>  	N_("git reflog exists <ref>")
