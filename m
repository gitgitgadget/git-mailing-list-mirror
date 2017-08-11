Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A430420899
	for <e@80x24.org>; Fri, 11 Aug 2017 22:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753704AbdHKWXI (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 18:23:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51719 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753581AbdHKWXH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 18:23:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 379DDACE4A;
        Fri, 11 Aug 2017 18:23:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=67FGxIRvRAGF52AsUgecfMMu0/c=; b=VO2zox
        vntc67Jb6Yzr605HvAP+MD7CXUjSao5UbnQSaBqz1mUPLlWAO1KiZJSrrD454/kK
        KP8+2+ktqawTRGQ3PwX+bmpnHx0aqUQu20YbperH0TMIJUY8t+cFcTDLJb44OLz7
        mmx8MF/hTvKBdArvBEoiAKvqzRrOo37Cje6UM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K+L00sxALFdfQUg/9XiqTd6dfH8ct/Hr
        Phe/mOF4FAi1PpC9Cxmk2AsrfpaGtprfP/hP6HKZX2ZG5/BXi9nMdKT5H9+geFlV
        vat2C5kpz30Cmw7/I02SS4Xu5Ygy3R/JPsnelyFkL0QYnXtPW37sKDmR8lDywMA9
        eMuYqd9H3zk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDBC3ACE49;
        Fri, 11 Aug 2017 18:23:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECE8FACE45;
        Fri, 11 Aug 2017 18:22:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 2/2] rebase: turn on progress option by default for format-patch
References: <20170810183256.12668-1-kewillf@microsoft.com>
        <20170531150427.7820-1-kewillf@microsoft.com>
        <20170810183256.12668-3-kewillf@microsoft.com>
Date:   Fri, 11 Aug 2017 15:22:58 -0700
In-Reply-To: <20170810183256.12668-3-kewillf@microsoft.com> (Kevin Willford's
        message of "Thu, 10 Aug 2017 14:32:56 -0400")
Message-ID: <xmqqshgxycal.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2122C06-7EE3-11E7-BB5B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kcwillford@gmail.com> writes:

> This change passes the progress option of format-patch checking
> that stderr is attached and rebase is not being run in quiet mode.

    Pass the "--progress" option to format-patch when the standard
    error stream goes to the terminal and the command is not run in
    "--quiet" mode.

Thanks for posting a refreshed version.  Both patches make sense to
me.

>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>

We want to see our authors and signed-off match.  Do you want the
employer address appear in our "shortlog -e" output, or your
personal gmail address?  I'll tenatively "fix" your author address
to match the one at @microsoft.com while queuing.

> ---
>  git-rebase--am.sh | 1 +
>  git-rebase.sh     | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 375239341f..ff98fe3a73 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -53,6 +53,7 @@ else
>  
>  	git format-patch -k --stdout --full-index --cherry-pick --right-only \
>  		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
> +		$git_format_patch_opt \
>  		"$revisions" ${restrict_revision+^$restrict_revision} \
>  		>"$GIT_DIR/rebased-patches"
>  	ret=$?
> diff --git a/git-rebase.sh b/git-rebase.sh
> index f8b3d1fd97..ad8415e3cf 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -74,6 +74,7 @@ test "$(git config --bool rebase.stat)" = true && diffstat=t
>  autostash="$(git config --bool rebase.autostash || echo false)"
>  fork_point=auto
>  git_am_opt=
> +git_format_patch_opt=
>  rebase_root=
>  force_rebase=
>  allow_rerere_autoupdate=
> @@ -445,6 +446,11 @@ else
>  	state_dir="$apply_dir"
>  fi
>  
> +if test -t 2 && test -z "$GIT_QUIET"
> +then
> +	git_format_patch_opt="$git_format_patch_opt --progress"
> +fi
> +
>  if test -z "$rebase_root"
>  then
>  	case "$#" in
