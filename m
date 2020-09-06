Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A274C43461
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259EA207BB
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jaxqCVVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIFV7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:59:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51865 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgIFV7r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 17:59:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33BD0DC8E7;
        Sun,  6 Sep 2020 17:59:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=n+iw+MiAxWKfrcQrpjvliTOqW
        JY=; b=jaxqCVVMSQ7ifIZ1k46pGEkSsBFiTzhcn27Bdt9S88Jhmogi/qb15wqrv
        9J9iLnCLtkQIQJNHk5XFPOnWk7Z86C+QxqCI3YwB5YhBcTmOamhLPWwbW1Jqw0G3
        xx8iJ5VBGwAnQcbrOm4AkQOq7XS4tUHgPoxv0Rb4VfnASA14jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=ZwtN5ygvQOtWSA98Uyr
        o7St+JyL75IBI/Pe87aYvXhlbQi63MZbTPFnXFTXGajRos/RXaCORu7mJIRUcHhd
        6weKC0a/8CJqoFKK5RGuaqnjvvkelUfzKRvNFUPTJdKQfgLmCqafX4fdeomL34Ue
        PDuDR07vr2rclhl6/MyycATw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C799DC8E6;
        Sun,  6 Sep 2020 17:59:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69F2DDC8E5;
        Sun,  6 Sep 2020 17:59:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH v2] submodule: suppress checking for file name ambiguity for object ids
References: <pull.725.git.1599231196975.gitgitgadget@gmail.com>
        <pull.725.v2.git.1599370473141.gitgitgadget@gmail.com>
Date:   Sun, 06 Sep 2020 14:59:41 -0700
Message-ID: <xmqq7dt636sy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4527025A-F08C-11EA-B9EA-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> The argv argument of collect_changed_submodules() contains obly object =
ids

obly??? s/b/n/.

> (the objects references of all the refs).
>
> Notify setup_revisions() that the input is not filenames by passing
> assume_dashdash, so it can avoid redundant stat for each ref.
>
> A better improvement would be to pass oid_array instead of stringified =
argv,
> but that will require a larger change, which can be done later.

A na=C3=AFve way is to append "--" to the argv strvec, but since 6d5b93f2
(cherry-pick: do not expect file arguments, 2012-04-14) we made it
unnecessary by introducing the flag.  This is exactly how the flag
was designed to be used.

Good job.

Thanks.

>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>     submodule: suppress checking for file name ambiguity for object ids
>    =20
>     The argv argument of collect_changed_submodules() contains obly obj=
ect
>     ids (submodule references).
>    =20
>     Notify setup_revisions() that the input is not filenames by passing
>     assume_dashdash, so it can avoid redundant stat for each ref.
>    =20
>     A better improvement would be to pass oid_array instead of stringif=
ied
>     argv, but that will require a larger change, which can be done late=
r.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-725%2=
Forgads%2Fsubmodule-not-filename-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-725/orga=
ds/submodule-not-filename-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/725
>
> Range-diff vs v1:
>
>  1:  f12112cc88 ! 1:  501ce90e9a submodule: suppress checking for file =
name ambiguity for object ids
>      @@ Commit message
>           submodule: suppress checking for file name ambiguity for obje=
ct ids
>      =20
>           The argv argument of collect_changed_submodules() contains ob=
ly object ids
>      -    (submodule references).
>      +    (the objects references of all the refs).
>      =20
>           Notify setup_revisions() that the input is not filenames by p=
assing
>           assume_dashdash, so it can avoid redundant stat for each ref.
>
>
>  submodule.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index 3cbcf40dfc..9b5bfb12a3 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -840,9 +840,12 @@ static void collect_changed_submodules(struct repo=
sitory *r,
>  {
>  	struct rev_info rev;
>  	const struct commit *commit;
> +	struct setup_revision_opt s_r_opt =3D {
> +		.assume_dashdash =3D 1,
> +	};
> =20
>  	repo_init_revisions(r, &rev, NULL);
> -	setup_revisions(argv->nr, argv->v, &rev, NULL);
> +	setup_revisions(argv->nr, argv->v, &rev, &s_r_opt);
>  	if (prepare_revision_walk(&rev))
>  		die(_("revision walk setup failed"));
> =20
>
> base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
