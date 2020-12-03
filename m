Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F361FC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC2C207D0
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgLCSXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:23:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63717 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLCSXT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 13:23:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA370A6581;
        Thu,  3 Dec 2020 13:22:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gv9izaAsqWuDsamXLjJTZCIMBYI=; b=xqlU5b
        Wd1th4s3xupEwXhwTUJKI3IurgeJUbgjz04/Y8U16B26NDa6OFIBTyfu/BwZt5E9
        FWOw5dY6IymrQkhtlHyAIgP62uuxdMrcEDNalonCsGqmGoQoQThGLaw3VHwcyREX
        rXraSliunWfdGKwJ46srdUQHPjNv3xvOO3opk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fB/nEUoi4NAFXmynzveJfD9aDXJswCdS
        kOGnMkjb0M8vuGec78N10/iv6gKyfY8JAUkcfdplrk9IG3l/605jxNH+EANg7DAz
        k1rIE1ZZNB+NLGxMeWNpIG+s+DNz5hnotiZJYR64TOb/UQDrep2nGMGM1GFrRExv
        Wve2R077Fe8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2BB4A6580;
        Thu,  3 Dec 2020 13:22:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C946A657E;
        Thu,  3 Dec 2020 13:22:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] style: indent multiline "if" conditions by 4 spaces
References: <X8ibEpkel8OMS/hV@coredump.intra.peff.net>
Date:   Thu, 03 Dec 2020 10:22:35 -0800
In-Reply-To: <X8ibEpkel8OMS/hV@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 3 Dec 2020 03:00:18 -0500")
Message-ID: <xmqqv9dihhqs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84BC2F42-3594-11EB-9478-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit 6dc905d974 (config: split repo scope to local and worktree,
> 2020-02-10) made some "if" statements multiline, but didn't indent the
> second lines in our usual way.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I just happened to be reading nearby code and saw this.

Can we rephrase "by 4 spaces" to avoid misleading new developers,
though?  It's not like our rule is to indent continued expression by
4 spaces---it happens to be 4 in this case only because the second
line is aligned with the column inside "if (".

If the expression were

	if ((A == X && B == Y &&
	     boolean_expression_on_the_second_line()) ||
	    C == Z)

we would have indented the second line to align with the inside of
the opening parenthesis, which may end up with "by 5 spaces", but
four vs five is not the important part of the equation.

Thanks.  

> diff --git a/remote.c b/remote.c
> index 8a6dbbb903..8b9d090ae5 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -355,7 +355,7 @@ static int handle_config(const char *key, const char *value, void *cb)
>  	remote = make_remote(name, namelen);
>  	remote->origin = REMOTE_CONFIG;
>  	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
> -	current_config_scope() == CONFIG_SCOPE_WORKTREE)
> +	    current_config_scope() == CONFIG_SCOPE_WORKTREE)
>  		remote->configured_in_repo = 1;
>  	if (!strcmp(subkey, "mirror"))
>  		remote->mirror = git_config_bool(key, value);
> diff --git a/upload-pack.c b/upload-pack.c
> index 5dc8e1f844..a85d4ec502 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1302,7 +1302,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
>  	}
>  
>  	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
> -	current_config_scope() != CONFIG_SCOPE_WORKTREE) {
> +	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
>  		if (!strcmp("uploadpack.packobjectshook", var))
>  			return git_config_string(&data->pack_objects_hook, var, value);
>  	}
