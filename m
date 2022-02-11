Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E10C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 16:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351859AbiBKQvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:51:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351856AbiBKQvp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 11:51:45 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F7DDAA
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:51:25 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37054111D59;
        Fri, 11 Feb 2022 11:51:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FpDJS/9Des7M
        m74WiaQmVkncFHMXuTxrE5LPw0jbgUE=; b=kJy2dLbcGGybq7yMYb2nWliGU90d
        zyKRHe42vkvNMCaySLydGzJnyf2L1yWjB9auSMrFMkntnj1keOOodRIJCF8kUvJk
        qZ9eipJSQDzaAeZzWf5R66NIRqEXxSttB7SmSzpZVlVbINDzO/0iOjEs1bpZuVlx
        9QZQQPVduGLgy5s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CCC8111D58;
        Fri, 11 Feb 2022 11:51:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DC24111D54;
        Fri, 11 Feb 2022 11:51:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: Re: ds/sparse-checkout-requires-per-worktree-config (was Re: What's
 cooking in git.git (Feb 2022, #02; Wed, 9))
References: <xmqqa6ez60l8.fsf@gitster.g>
        <f36712f5-28bd-42d7-3ea1-f4afa328be07@gmail.com>
Date:   Fri, 11 Feb 2022 08:51:23 -0800
In-Reply-To: <f36712f5-28bd-42d7-3ea1-f4afa328be07@gmail.com> (Derrick
        Stolee's message of "Fri, 11 Feb 2022 08:40:05 -0500")
Message-ID: <xmqqfsope48k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D8FBE918-8B5A-11EC-91F3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 2/9/2022 7:12 PM, Junio C Hamano wrote:
>
>> * ds/sparse-checkout-requires-per-worktree-config (2022-02-08) 6 commi=
ts
>> ...
>>  Will merge to 'next'?
>>  cf. <20220204081336.3194538-1-newren@gmail.com>
>>  cf. <CAPig+cRrRxuTeByhKkLs_KDaWY8-r4+jrwT83A-r+sBQsmebMw@mail.gmail.c=
om>
>>  source: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
>
> You and I have had a good discussion about the latest version. I
> think we've mostly landed on finding ways to improve documentation
> in other ways (including the patch you submitted), but here are
> the things that I see as still outstanding:

Thanks for a clearly written summary.  Very much appreciated.

With the maintainer hat on, I agree that all are good points.  From
a reviewer's point of view, I do not care too deeply about 1 or 2
myself though.

> 0. Eric mentioned earlier that he was interested in looking again,
>    but has not signaled that his review is complete.
>
> 1. You and Eric disagree about the use of "worktree" and "working
>    tree" in the documentation. I could revert the change to these
>    docs from v5 to v6.
>
> 2. You mention that the changes in config.c could be split into
>    two (first, create repo_config_set_multivar_gently() and then
>    create repo_config_set_worktree_gently()).
>
> 3. Jean-No=C3=ABl noticed an improvement to reduce work on translators.
>    The diff below could be squashed into patch 5 OR I could submit
>    it as a forward fix.
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
>
> Thanks,
> -Stolee
