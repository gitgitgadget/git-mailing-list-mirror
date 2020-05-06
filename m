Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0250C47256
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB378206B9
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eqp7Vdl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgEFRDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:03:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59295 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEFRDN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:03:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0D11CEA2A;
        Wed,  6 May 2020 13:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=10nF6XA1D+6jZCKl+kiQ9KLYWk0=; b=Eqp7Vd
        l3TghuFd/nI8NG5Z2QmT5H8hM2TJyiaE6UkNgJKt1rL51XWivxFJNh/JXujoODEL
        gPJwYkXTkpf7ZpwG+1C40eRpZ7FxqU/qAa8JFUu0SjlyBNU3ZIN0kr/xRbVeg1PG
        lK5fNp/ULx5kurp/F88NsiapY/S/Z3epvD060=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TC6yiiinVWmg/7bsQ3w5O1GxsIdDto4a
        9V050ePmn/4paNun3CBbNHnNrF/yLU0uwAY38QGAybehhqErVzI2mPMoN2qKnFbh
        ORKhUGtg/6LyKppXfhtGXkQ5o1lSqtyXutB8KJ63M9bvPaWPKMvnCA+yljjjpzDT
        GdkwUTUtrfs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8B8ACEA29;
        Wed,  6 May 2020 13:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DF3A3CEA25;
        Wed,  6 May 2020 13:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] midx: apply gitconfig to midx repack
References: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
        <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
        <21c648cc486cf1abee51076d21e55649b1464516.1588758194.git.gitgitgadget@gmail.com>
Date:   Wed, 06 May 2020 10:03:04 -0700
In-Reply-To: <21c648cc486cf1abee51076d21e55649b1464516.1588758194.git.gitgitgadget@gmail.com>
        (Son Luong Ngoc via GitGitGadget's message of "Wed, 06 May 2020
        09:43:13 +0000")
Message-ID: <xmqqy2q56lo7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 743211FC-8FBB-11EA-B775-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Multi-Pack-Index repack is an incremental, repack solutions
> that allows user to consolidate multiple packfiles in a non-disruptive
> way. However the new packfile could be created without some of the
> capabilities of a packfile that is created by calling `git repack`.

It may be clear to you who wrote the patch, but it is quite unclear
to readers how `repack` gets into the picture.  The first sentence
talks about what "git multi-pack-index repack" subcommand.  Unless
you mention that that "git multi-pack-index repack" subcommand calls
"git repack" under the hood in order to create a new packfile, the
second paragraph can be read as if you are pointing out a problem if
the user did

	$ git multi-pack-index repack
	$ git repack

and the explicit "repack" initiated by the user may create a
packfile that is somehow incompatible with what the previous repack
wanted to do, or something like that.

> This is because with `git repack`, there are configuration that would
> enable different flags to be passed down to `git pack-objects` plumbing.

And this does not help to clear the possible confusion, either.

I think all of the above is clearer if you rewrite the above
(including the title) like so:

    midx: teach "git multi-pack-index repack" honor "git repack" configuration

    When the "repack" subcommand of "git multi-pack-index" command
    creates new packfile(s), it does not call the "git repack"
    command but instead directly calls the "git pack-objects"
    command, and the configuration variables meant for the "git
    repack" command, like "repack.usedaeltabaseoffset", are ignored.

Now the problem description is behind us, let's see the description
of proposed solution.  We write this part in imperative mood, as if
we are giving an order to the codebase to "become like so".  We do
not say "I do X, I do Y".

> In this patch, I applies those flags into `git multi-pack-index repack`
> so that it respect the `repack.*` config series.

    Check the configuration variables used by "git repack" ourselves
    and pass the corresponding options to underlying "git pack-objects"
    in this codepath.


> Note:
> - `repack.packKeptObjects` will be addressed by Derrick Stolee in
> the following patch

This definitely does not belong to the commit log message.  It would
make a helpful note meant for the reviewers if written below the
three-dash line, though.

> - `repack.writeBitmaps` when `--batch-size=0` was NOT adopted here as it
> requires `--all` to be passed onto `git pack-objects`, which is very
> slow. I think it would be nice to have this in a future patch.

The phrasing makes it hard to grok.  Do you want to say that the
repack.writeBitmaps configuration variable is ignored?

I think Derrick gave you the reason why bitmaps is not compatible
with midx in general, and that would be a better rationale to record
why the configuration is ignored.  Perhaps like

    Note that `repack.writeBitmaps` configuration is ignored, as the
    pack bitmap faciility is useful only with a single packfile.

or something like that?

Do we need to worry about the configuration variables understood by
the "git pack-objects" command to get in the way, by the way?
"pack.packsizelimit" may cause "git repack" to produce more than one
packfile, and if this codepath wants to avoid it (I do not know if
that is the case), it may have to override it from the command line,
for example.

> Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
> ---
>  midx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/midx.c b/midx.c
> index 9a61d3b37d9..3348f8e569b 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1369,6 +1369,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
>  	struct child_process cmd = CHILD_PROCESS_INIT;
>  	struct strbuf base_name = STRBUF_INIT;
>  	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
> +	int delta_base_offset = 1;

By default we use delta-base-offset, so if repo_config_get_bool()
did not see the repack.usedeltabaseoffset configuration defined in
any configuration file, we still want to see 1 after it returns.

> +	int use_delta_islands;

What is the reason why it is safe to leave this uninitialized?  Did
you mean 

	int use_delta_islands = 0;

here?

> @@ -1381,12 +1383,20 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
>  	} else if (fill_included_packs_all(m, include_pack))
>  		goto cleanup;
>  
> +	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
> +	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
> +
>  	argv_array_push(&cmd.args, "pack-objects");
>  
>  	strbuf_addstr(&base_name, object_dir);
>  	strbuf_addstr(&base_name, "/pack/pack");
>  	argv_array_push(&cmd.args, base_name.buf);
>  
> +	if (delta_base_offset)
> +		argv_array_push(&cmd.args, "--delta-base-offset");
> +	if (use_delta_islands)
> +		argv_array_push(&cmd.args, "--delta-islands");
> +

These look like good changes.

>  	if (flags & MIDX_PROGRESS)
>  		argv_array_push(&cmd.args, "--progress");
>  	else

Thanks.
