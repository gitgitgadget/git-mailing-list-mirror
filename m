Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAB4C433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F7F60240
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbhCASos (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:44:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53730 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbhCASm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 13:42:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97E74AA9B4;
        Mon,  1 Mar 2021 13:41:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5I2YI+KPOLaiVNBtxCHbl/jwYVo=; b=i0Fm/D
        oJkaxAUWikkslikrjG7n6ihhhGPqy4PEGXRY4ReNV6sk+qFJi7d1oCNTNgeaYlaN
        epX+h2lPXQ+QRksPp+y10uC61Ds2GF2nInXwoNeo7fMvX6SO4e0HByMz2XROtsNS
        4VDR56T/s20Z7NXpfcxZCylQpcNE/5Sw+Qd7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bZ95a+V8Fp5PEoJ8fgiBsmJV522sea/m
        vzhRTvd86Bjnkm2LJLYE/2ZmN7pGWSAV02l9VG/dbnWGmVxOZ3+W35hsf31QcJVK
        ksbmUVg5Ikl0lgMcbAIKPp1SpzkJfoqy4p2fqwSEAh/Y+9vLxc62XSPjoruzGhmb
        HZ19klUGDos=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FB0FAA9B1;
        Mon,  1 Mar 2021 13:41:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18B98AA9AF;
        Mon,  1 Mar 2021 13:41:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 3/6] commit: add a reword suboption to --fixup
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210301084512.27170-4-charvi077@gmail.com>
Date:   Mon, 01 Mar 2021 10:41:44 -0800
In-Reply-To: <20210301084512.27170-4-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Mon, 1 Mar 2021 14:15:11 +0530")
Message-ID: <xmqqh7lura1j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5D1DE78-7ABD-11EB-A550-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> `git commit --fixup=reword:<commit>` creates an empty "amend!" commit
> that will reword <commit> without changing its contents when it is
> rebased with --autosquash.
>
> Apart from ignoring staged changes it works similarly to
> `--fixup=amend:<commit>`.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
>  builtin/commit.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 200ef83cc0..a4d18d96df 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1186,6 +1186,27 @@ static void finalize_deferred_config(struct wt_status *s)
>  		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
>  }
>
> +static void check_fixup_reword_options(int argc, const char *argv[]) {
> +	if (whence != FROM_COMMIT) {
> +		if (whence == FROM_MERGE)
> +			die(_("You are in the middle of a merge -- cannot reword."));
> +		else if (is_from_cherry_pick(whence))
> +			die(_("You are in the middle of a cherry-pick -- cannot reword."));
> +	}
> +	if (argc)
> +		die(_("cannot combine reword option of --fixup with path %s"), *argv);

I think our convention is to quote '%s' with a single-quote pair.
See other error messages.

commit.c:			die_errno(_("could not read '%s'"), templat...
commit.c:		die_errno(_("could not open '%s'"), git_path_commit...
commit.c:	die(_("--author '%s' is not 'Name <email>' and matches no e...
commit.c:		die(_("Invalid ignored mode '%s'"), ignored_arg);
commit.c:		die(_("Invalid untracked files mode '%s'"), untrack...
...
