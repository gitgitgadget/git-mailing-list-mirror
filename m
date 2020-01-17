Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F6C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 18:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8D12083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 18:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tGPhPt4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAQSsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:48:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55832 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQSsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 13:48:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EB1F3832F;
        Fri, 17 Jan 2020 13:48:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r0rlSiBGzro9at7pjY271dsxAy8=; b=tGPhPt
        4dne8H6PXLOcSWa+rQyGpvsuGONeB5RGLXdp4D3aEnc1Bke65QfWldVU9fGV9nok
        jlk/KuvjJC+Dqn1z15TKHhimvr/r3aeOHk/iHh85OhBNdYmB52WH6/GHV6oHJxCE
        656WMmcyYPuaLwmqMVzZqzpKpqQlFgHdzxc5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HS+kkkMysjRSfVlO+3UZLDc/Lqs4UwFN
        MY9/kFV78mqcGXuUPo6EOtQpwB0AMdnSNr9pqlexE/vg54ShbREC+8d0mrfKOONF
        5f0YFBuc7Meq8v/Bld4EUWE2J0XbH+Jk/e3j9KCBOEryIx0piEKv6eZy2VT7wiJb
        NWlUi2FTwhs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94FE03832E;
        Fri, 17 Jan 2020 13:48:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 010D83832B;
        Fri, 17 Jan 2020 13:48:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] remote rename: rename branch.<name>.pushRemote config values too
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
        <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com>
Date:   Fri, 17 Jan 2020 10:48:09 -0800
In-Reply-To: <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com>
        (Bert Wesarg's message of "Fri, 17 Jan 2020 10:33:07 +0100")
Message-ID: <xmqqeevxex7a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8E2A506-3959-11EA-A360-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> When renaming a remote with
>
>     git remote rename X Y
>
> Git already renames any config values from
>
>     branch.<name>.remote = X
>
> to
>
>     branch.<name>.remote = Y
>
> As branch.<name>.pushRemote also names a remote, it now also renames
> these config values from
>
>     branch.<name>.pushRemote = X
>
> to
>
>     branch.<name>.pushRemote = Y

This makes sense now.  Thanks for an updated description.

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

> @@ -305,7 +309,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
>  				space = strchr(value, ' ');
>  			}
>  			string_list_append(&info->merge, xstrdup(value));
> -		} else {
> +		} else if (type == REBASE) {
>  			int v = git_parse_maybe_bool(value);
>  			if (v >= 0)
>  				info->rebase = v;
> @@ -315,6 +319,10 @@ static int config_read_branches(const char *key, const char *value, void *cb)
>  				info->rebase = REBASE_MERGES;
>  			else if (!strcmp(value, "interactive"))
>  				info->rebase = INTERACTIVE_REBASE;
> +		} else {
> +			if (info->push_remote_name)
> +				warning(_("more than one %s"), orig_key);
> +			info->push_remote_name = xstrdup(value);
>  		}

This is perfectly fine for now, as it follows the existing "now we
have handled X, and Y, so the remainder must be Z" mentality, but at
some point we may want to make sure that we are protected against
seeing an unexpected 'type', iow

			...
		} else if (type == PUSH_REMOTE) {
			...
		} else {
			BUG("unexpected type=%d", type);
		}

as we learn more "type"s.  Better yet, this if/elseif/ cascade may
become clearer if it is rewritten to a switch statement.

I was about to conclude this message with "but that is all outside
the scope of this fix, so I'll queue it as-is " before noticing
that you two seem to be leaning towards clean-up at the same time.
If we are to clean up the code structure along these lines, I'd
prefer to see it done as a preparatory patch before pushremote
handling gets introduced.

Taking some other clean-up ideas on this function, e.g.:

 * key += 7 should better be done without hardcoded length of "branch."
 * By leaving early, we can save one indentation level.
 * name does not have to be computed for each branch.

the resulting body of the function might look more like this:

	if (!skip_prefix(key, "branch.", &key))
		return 0;

	if (strip_suffix(key, ".remote", &key_len))
		type = REMOTE;
	else if (strip_suffix(key, ".merge", &key_len))
		type = MERGE;
	...
	else
		return 0;
	name = xmemdupz(key, key_len);
	item = string_list_insert(&branch_list, name);
	...

	switch (type) {
	case REMOTE:
		...
	default:
		BUG("unhandled type %d", type);
	}

Thanks.
