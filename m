Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE62C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 23:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4538024125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 23:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nhlPtCBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAUX0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:26:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54396 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgAUX0V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 18:26:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D62F238446;
        Tue, 21 Jan 2020 18:26:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2BcAsFyYpOUndvsX6sGUOY8aFjE=; b=nhlPtC
        BOm+WB7ppbYN90CJ2Z/c1JZj4EUl6hpNvZqRIhTGNUrNXQPUNEZPzZ+DTy1g5I79
        yFKETf4gPLZUTTfunokkkg84aWPxHwLZTVKlKKFRKAzPW6UounKqvbdK7wu1bFuY
        1xqZ+zLoJYEjdKzIkyKRu/mFBWn3XjnBXGE3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GIB26wngoPPLXDyDEZRCfhtxE5XraC8H
        9mXRVhqEGh8bk1o+N4a1p4B8ZKVbg01vxKpcfeAZs69NamfEONF2AOeJFlLqwaGK
        JA58Qjhw+qXj1PxIGmf4+gTz8gnQzrGWB1fxjY6G8b1kDx7E4khWaiiI3kNGAlXt
        tfJH8unDn5g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE79E38443;
        Tue, 21 Jan 2020 18:26:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40C5638442;
        Tue, 21 Jan 2020 18:26:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] pull --rebase/remote rename: document and honor single-letter abbreviations rebase types
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
        <f9da9aac7edf6f682592592fe8f450a5801fb012.1579598053.git.bert.wesarg@googlemail.com>
Date:   Tue, 21 Jan 2020 15:26:15 -0800
In-Reply-To: <f9da9aac7edf6f682592592fe8f450a5801fb012.1579598053.git.bert.wesarg@googlemail.com>
        (Bert Wesarg's message of "Tue, 21 Jan 2020 10:24:49 +0100")
Message-ID: <xmqqv9p475ns.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BB975E2-3CA5-11EA-A155-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> When 46af44b07d (pull --rebase=<type>: allow single-letter abbreviations
> for the type, 2018-08-04) landed in Git, it had the side effect that
> not only 'pull --rebase=<type>' accepted the single-letter abbreviations
> but also the 'pull.rebase' and 'branch.<name>.rebase' configurations.
>
> Secondly, 'git remote rename' did not honor these single-letter
> abbreviations when reading the 'branch.*.rebase' configurations.

Hmph, do you mean s/Secondly/However/ instead?

> The only functional change is the handling of the `branch_info::rebase`
> value. Before it was an unsigned enum, thus the truth value could be
> checked with `branch_info::rebase != 0`. But `enum rebase_type` is
> signed, thus the truth value must now be checked with
> `branch_info::rebase >= REBASE_TRUE`.

I think there is another hidden one, but I do not know offhand the
implications of the change.  It could well be benign.

>  /**
>   * Parses the value of --rebase. If value is a false value, returns
>   * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
> @@ -45,22 +37,9 @@ enum rebase_type {
>  static enum rebase_type parse_config_rebase(const char *key, const char *value,
>  		int fatal)
>  {
> -	int v = git_parse_maybe_bool(value);
> -
> -	if (!v)
> -		return REBASE_FALSE;
> -	else if (v > 0)
> -		return REBASE_TRUE;
> -	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
> -		return REBASE_PRESERVE;
> -	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
> -		return REBASE_MERGES;
> -	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
> -		return REBASE_INTERACTIVE;
> -	/*
> -	 * Please update _git_config() in git-completion.bash when you
> -	 * add new rebase modes.
> -	 */

I see all of the above, including the "Please update" comment, has
become rebase_parse_value(), which is very good.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 96bbe828fe..2830c4ab33 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -6,6 +6,7 @@
> ...
> -	enum {
> -		NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
> -	} rebase;
> +	enum rebase_type rebase;

Good to see the duplicate go.

> @@ -305,17 +304,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
>  				space = strchr(value, ' ');
>  			}
>  			string_list_append(&info->merge, xstrdup(value));
> -		} else {
> -			int v = git_parse_maybe_bool(value);
> -			if (v >= 0)
> -				info->rebase = v;
> -			else if (!strcmp(value, "preserve"))
> -				info->rebase = NORMAL_REBASE;
> -			else if (!strcmp(value, "merges"))
> -				info->rebase = REBASE_MERGES;
> -			else if (!strcmp(value, "interactive"))
> -				info->rebase = INTERACTIVE_REBASE;
> -		}
> +		} else
> +			info->rebase = rebase_parse_value(value);

Here, we never had info->rebase == REBASE_INVALID.  The field was
left intact when the configuration file had a rebase type that is
not known to this version of git.  Now it has become possible that
info->rebase to be REBASE_INVALID.  Would the code after this part
returns be prepared to handle it, and if so how?  At least I think
it deserves a comment here, or in rebase_parse_value(), to say (1)
that unknown rebase value is treated as false for most of the code
that do not need to differentiate between false and unknown, and (2)
that assigning a negative value to REBASE_INVALID and always
checking if the value is the same or greater than REBASE_TRUE helps
to maintain the convention.


> diff --git a/rebase.h b/rebase.h
> new file mode 100644
> index 0000000000..cc723d4748
> --- /dev/null
> +++ b/rebase.h
> @@ -0,0 +1,15 @@
> +#ifndef REBASE_H
> +#define REBASE_H
> +
> +enum rebase_type {
> +	REBASE_INVALID = -1,
> +	REBASE_FALSE = 0,
> +	REBASE_TRUE,
> +	REBASE_PRESERVE,
> +	REBASE_MERGES,
> +	REBASE_INTERACTIVE
> +};
> +
> +enum rebase_type rebase_parse_value(const char *value);
> +
> +#endif /* REBASE */
