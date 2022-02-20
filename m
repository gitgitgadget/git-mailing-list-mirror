Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C7EC433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 20:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbiBTUWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 15:22:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbiBTUWd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 15:22:33 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C706D64E2
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 12:22:11 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 261301799FF;
        Sun, 20 Feb 2022 15:22:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Xy0K24LHkPRU
        RbNIaq2UmIakOvIdUPgmsIEFbOVW2Ac=; b=YkLCQ1FPqOdchMVV4WbI1E07F/VU
        Ywsl4kPgnTSWXKr28P+WwZpmKfCQOYcmVvUGN/ZKlknknvB4JsCXUzzn+5/syM0v
        Rn0t8Y1PnYYi1eqyCue/Gwi2kmp61IrsMIKJP3nlao5tP7CpIrLQ4rEiNlH8bvsS
        m1uVWrkcQ6RHS1k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E78F1799FE;
        Sun, 20 Feb 2022 15:22:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E3441799FD;
        Sun, 20 Feb 2022 15:22:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 01/11] worktree: combine two translatable messages
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <a113ed9a8449b57e2a88a24244f3e45b24a01862.1645379667.git.gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 12:22:07 -0800
In-Reply-To: <a113ed9a8449b57e2a88a24244f3e45b24a01862.1645379667.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Sun, 20 Feb 2022
        17:54:17 +0000")
Message-ID: <xmqqley5uw40.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C71C0FAC-928A-11EC-9A2B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

[jc: bogus CC addressses stripped and retyped; did something change
at GGG recently?]

> From: Derrick Stolee <derrickstolee@github.com>
>
> These two messages differ only by the config key name, which should not
> be translated. Extract those keys so the messages can be translated fro=
m
> the same string.

Makes sense.  Not just the reusing the same string is good, but this
will also make sure that translators have no chance of making a typo
on the variable names themselves, which is an added benefit.

> Reported-by: Jean-No=C3=ABl AVILA <jn.avila@free.fr>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/worktree.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index c6eb636329a..7c272078dc9 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -384,11 +384,13 @@ static int add_worktree(const char *path, const c=
har *refname,
>  			    bare &&
>  			    git_config_set_multivar_in_file_gently(
>  					to_file, "core.bare", NULL, "true", 0))
> -				error(_("failed to unset 'core.bare' in '%s'"), to_file);
> +				error(_("failed to unset '%s' in '%s'"),
> +				      "core.bare", to_file);
>  			if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) =
&&
>  			    git_config_set_in_file_gently(to_file,
>  							  "core.worktree", NULL))
> -				error(_("failed to unset 'core.worktree' in '%s'"), to_file);
> +				error(_("failed to unset '%s' in '%s'"),
> +				      "core.worktree", to_file);
> =20
>  			git_configset_clear(&cs);
>  		}
