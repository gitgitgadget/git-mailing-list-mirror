Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C0BC433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 22:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6FC61279
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 22:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242738AbhDFWQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:16:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64585 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbhDFWQe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 18:16:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89CD411E93C;
        Tue,  6 Apr 2021 18:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ItzNj3gyTAD4
        4ubFMoNWEgMmnGk=; b=ky2Q64Yn3kMTfuB6ddagvHnPZy9oHao4/yjQ5gCB9JSf
        cLu6MKg38KsKzxoxh69ZF3kC10tzepiQ/z9IcMaYKcaNWd0ATtaBd/IT3XZhmFns
        g0p0L9cNL+Mug0uYbQJ/s7FXdCTYUBDRRdEnDq+0V04GFOuqnB/j2yRMqXjxuIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=p6Bazc
        i0XfrQiStvXPJlsZ6Uoz73DkFmfAZSls2N8hgYwqYGl+rTYIlIKluBsXPY8V7JFD
        fnKMVrP/4Jt4KRJhHBduCdPYa5npchn/0u2iBqQ8DnD47M7W1eRbmX/kkk7Mqb4U
        MdHULIvP77wb2x80jwYag/rlPKRN5/gqqV2OA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8188311E93B;
        Tue,  6 Apr 2021 18:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C802011E93A;
        Tue,  6 Apr 2021 18:16:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: treat unset GIT_COMPLETION_SHOW_ALL gracefully
References: <20210406181247.250046-1-ville.skytta@iki.fi>
Date:   Tue, 06 Apr 2021 15:16:21 -0700
In-Reply-To: <20210406181247.250046-1-ville.skytta@iki.fi> ("Ville
 =?utf-8?Q?Skytt=C3=A4=22's?=
        message of "Tue, 6 Apr 2021 21:12:47 +0300")
Message-ID: <xmqqo8er12kq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B867FAB8-9725-11EB-A814-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> If not set, referencing it in nounset (set -u) mode unguarded produces
> an error.
>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.

$ git grep -h -o -e '\$GIT_[A-Z_]*' master -- contrib/completion/git-comp=
letion.bash

gives a few other hits.

$GIT_DIR
$GIT_COMPLETION_SHOW_ALL
$GIT_TESTING_ALL_COMMAND_LIST
$GIT_TESTING_ALL_COMMAND_LIST
$GIT_TESTING_PORCELAIN_COMMAND_LIST

Have you gone through all of these hits?

I just checked that the reference to $GIT_DIR is safe.

        elif [ -n "${GIT_DIR-}" ]; then
                test -d "${GIT_DIR-}" &&
                __git_repo_path=3D"$GIT_DIR"

In fact, after checking "is this non-empty?", the form used to see
"is this a directory" does not even need to be "${VAR-}".

Among the two references to GIT_TESTING_ALL_COMMAND_LIST, the first
one does not look safe to me, and that is what made me take a look
myself.  It probably wants to follow the same pattern as above,
doesn't it?  Or am I reading the code incorrectly and the use there
is safe?

Reference to $GIT_TESTING_PORCELAIN_COMMAND_LIST is safe, as it
follows the same "if test -n "${VAR-}"; then use "$VAR"; fi"
pattern.

So, this patch definitely looks like an improvement, but if there
are so few remaining issues, I'd prefer to see that (1) the proposed
log message explain that the patch author audited all usages of
variables and updated all "-u"-unsafe ones, and (2) the patch
actually does update all remaining problematic ones.

If I am wrong about TESTING_ALL_COMMAND_LIST, then (2) may already
be true, but then we want to describe that fact in the log message
even more.  It would ensure that future developers understand that
${VAR-} constructs are no accident and we are striving to make the
script "-u"-safe.

Thanks.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index e1a66954fe..6d77f56f92 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -427,7 +427,7 @@ __gitcomp_builtin ()
> =20
>  	if [ -z "$options" ]; then
>  		local completion_helper
> -		if [ "$GIT_COMPLETION_SHOW_ALL" =3D "1" ]; then
> +		if [ "${GIT_COMPLETION_SHOW_ALL-}" =3D "1" ]; then
>  			completion_helper=3D"--git-completion-helper-all"
>  		else
>  			completion_helper=3D"--git-completion-helper"
