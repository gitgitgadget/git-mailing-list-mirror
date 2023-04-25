Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D9CC77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 19:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjDYTm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 15:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjDYTm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 15:42:58 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6337B658E
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 12:42:56 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54f8d59a8a9so75074517b3.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682451775; x=1685043775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAGf0NYJzp+X6fqKONQz4Ty64oLVTlQOz4Yjgl76DpQ=;
        b=NVK3PB+6PxG8PRUK00WH+2eNAL6sJF1t/+puJ/MRSEB0yQQwFyfvBpKhmfrCclKxWc
         lHl9O/Zb2Jzvsafk2o/XjrNWsRwh9o82wHR0qF1G3flPs1C6Xn1F97agSY/oTcnRodXl
         rGcN8AbwS4DN1Sh5FIm4qynWtD2bb85TeBhDCubGfLLXmIzad9Jqo1G7y8VYivMRp2J1
         JCOMiqItwRdq+mlsDwKlJ4mYIkEm6i1/GPfHvwRprOt7v9/O/aNtD07DMR1iZedL7b0e
         CG3Bl4SlXJTMgsC2b3+E0YLUF5BaVYvnGny4ofU565mYo7Tr+aZImJUu3uHeX4bC8+VQ
         wiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682451775; x=1685043775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAGf0NYJzp+X6fqKONQz4Ty64oLVTlQOz4Yjgl76DpQ=;
        b=kM5OCOwlvVypJlvYN3+zsbxDropx+ds8/bkmuJvUG9JY5HYLBLxGNshnqGOCWoaMNa
         3q7RMcQWcmaCfewvELI1O/8vTAX41/XUZHu8BtcMDEMd2BsfwJAcHS9E5my5JBDHlTbR
         vnIHFjB8AoudHWtFBpJ3y6IJ0V+dehYNoWdFSha3XgMa+5jC8JkMoNjyv4p9TLtPutAi
         mnk6K6DKF90K+kEZEBoVqynzyX2o41hMrtYhW0Rl/tX5eqBIrNRdF7r/2rChWrWXckn7
         LpHl82kqichdq2bJ6/ti7ioaiGFrBMDHUTshLVIgbSBE33kz2OBYXvMJbtdEG5+ACayt
         AO7A==
X-Gm-Message-State: AAQBX9eqJ9iE7osp+zWpan6oS9UyTURnMhatnr1VVaN1MthmhL3KP/Vs
        nj3H+s3bvp21Jw4+gX604bqA
X-Google-Smtp-Source: AKy350ZWhxWn2iFbT8REDunT1Ax/5UVzQY9uh23D7UYgGnDYE72ScALT1vLqJ3FpUvaCmjxN2NQEMw==
X-Received: by 2002:a81:9385:0:b0:541:8b94:68c7 with SMTP id k127-20020a819385000000b005418b9468c7mr12349371ywg.23.1682451775400;
        Tue, 25 Apr 2023 12:42:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9117:8293:39bd:7100? ([2600:1700:e72:80a0:9117:8293:39bd:7100])
        by smtp.gmail.com with ESMTPSA id k187-20020a816fc4000000b00545a08184b9sm3744433ywc.73.2023.04.25.12.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 12:42:54 -0700 (PDT)
Message-ID: <4ba5eec2-dfbb-b918-147a-d6e03c2748b2@github.com>
Date:   Tue, 25 Apr 2023 15:42:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] builtin/pack-objects.c: introduce `pack.extraCruftTips`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2023 1:27 PM, Taylor Blau wrote:
> This patch introduces a new multi-valued configuration option,
> `pack.extraCruftTips` as an alternative means to mark certain objects in
> the cruft pack as rescued, even if they would otherwise be pruned.

> However, there is no option to be able to keep around certain objects
> that have otherwise aged out of the grace period. The only way to retain
> those objects is:
> 
>   - to point a reference at them, which may be undesirable or
>     infeasible,
>   - to extend the grace period, which may keep around other objects that
>     the caller *does* want to discard,
>   - or, to force the caller to construct the pack of objects they want
>     to keep themselves, and then mark the pack as kept by adding a
>     ".keep" file.
> 
> This patch introduces a new configuration, `pack.extraCruftTips` which
> allows the caller to specify a program (or set of programs) whose output
> is treated as a set of objects to treat as "kept", even if they are
> unreachable and have aged out of the retention period.

One way to think about this is that we want to store a second set of
references to objects we do not want to prune, but those references
are not useful for _any other Git operation_, so polluting the ref
space would be too expensive. And reflogs are insufficient because
deleted references also delete their reflogs.

These "forever" references can be kept in a completely different format
if we use a hook interface. This helps us in particular because we
already have such a format on our systems. This may be a common
scenario in other systems, too.

> The implementation is straightforward: after determining the set of
> objects to pack into the cruft pack (either by calling
> `enumerate_cruft_objects()` or `enumerate_and_traverse_cruft_objects()`)
> we figure out if there are any program(s) we need to consult in order to
> determine if there are any objects which we need to "rescue". We then
> add those as tips to another reachability traversal, marking every
> object along the way as cruft (and thus retaining it in the cruft pack).

I initially wondered why we would need a second walk, and I _think_
one reason is that we don't want to update the mtimes for these
objects as if they were reachable. The next point about the reachable
pack is also critical.

> A potential alternative here is to introduce a new mode to alter the
> contents of the reachable pack instead of the cruft one. One could
> imagine a new option to `pack-objects`, say `--extra-tips` that does the
> same thing as above, adding the visited set of objects along the
> traversal to the pack.
> 
> But this has the unfortunate side-effect of altering the reachability
> closure of that pack. If parts of the unreachable object graph mentioned
> by one or more of the "extra tips" programs is not closed, then the
> resulting pack won't be either. This makes it impossible in the general
> case to write out reachability bitmaps for that pack, since closure is a
> requirement there.

This caught me off guard at first, but the important thing is that
Git allows objects to be missing if they are only reachable from
objects that are not reachable from references. This "the repository
is not necessarily closed under reachability when including
unreachable objects" is always a confusing state to keep in mind.

There's another reason to keep them in the cruft pack, even if they
were closed under reachability: their presence muddies the reachable
pack(s) so their deltas are worse and their bitmaps a less efficient.

> Instead, keep these unreachable objects in the cruft pack instead, to
> ensure that we can continue to have a pack containing just reachable
> objects, which is always safe to write a bitmap over.

Makes sense. Also: don't update their mtime so they could be removed
immediately if the external pointers change.

> +pack.extraCruftTips::
> +	When generating a cruft pack, use the shell to execute the
> +	specified command(s), and interpret their output as additional
> +	tips of objects to keep in the cruft pack, regardless of their
> +	age.
> ++
> +Output must contain exactly one hex object ID per line, and nothing
> +else. Objects which cannot be found in the repository are ignored.
> +

This only indicates it is multi-valued by the word "command(s)". It
also doesn't specify that we execute them all or stop when one
completes with success. (see code)

> +static int enumerate_extra_cruft_tips_1(struct rev_info *revs, const char *args)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	FILE *out = NULL;
> +	int ret = 0;
> +
> +	cmd.use_shell = 1;
> +	cmd.out = -1;
> +
> +	strvec_push(&cmd.args, args);
> +	strvec_pushv(&cmd.env, (const char **)local_repo_env);

I'm surprised this is necessary to include here. However, I see
one other use like this is for core.alternateRefsCommand, which
serves a similar purpose.

> +
> +	if (start_command(&cmd)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	out = xfdopen(cmd.out, "r");
> +	while (strbuf_getline_lf(&buf, out) != EOF) {
> +		struct object_id oid;
> +		struct object *obj;
> +		const char *rest;
> +
> +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
> +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
> +			goto done;
> +		}

Reporting an error on malformed output from hook...

> +		obj = parse_object(the_repository, &oid);
> +		if (!obj)
> +			continue;

...but skipping over missing objects. Good.

> +
> +		display_progress(progress_state, ++nr_seen);
> +		add_pending_object(revs, obj, "");
> +	}
> +
> +done:
> +	if (out)
> +		fclose(out);
> +	strbuf_release(&buf);
> +	child_process_clear(&cmd);

This cleanup looks sufficient from my reading.

> +	return ret;
> +}
> +
> +static int enumerate_extra_cruft_tips(void)
> +{
> +	struct rev_info revs;
> +	const struct string_list *programs;
> +	int ret = 0;
> +	size_t i;
> +
> +	if (git_config_get_string_multi("pack.extracrufttips", &programs))
> +		return ret;
> +
> +	repo_init_revisions(the_repository, &revs, NULL);
> +
> +	revs.tag_objects = 1;
> +	revs.tree_objects = 1;
> +	revs.blob_objects = 1;
> +
> +	revs.include_check = cruft_include_check;
> +	revs.include_check_obj = cruft_include_check_obj;
> +
> +	revs.ignore_missing_links = 1;
> +
> +	if (progress)
> +		progress_state = start_progress(_("Enumerating extra cruft tips"), 0);

Should we be including two progress counts? or would it be sufficient
to say "traversing extra cruft objects" and include both of these steps
in that one progress mode?

> +	nr_seen = 0;
> +	for (i = 0; i < programs->nr; i++) {
> +		ret = enumerate_extra_cruft_tips_1(&revs,
> +						   programs->items[i].string);
> +		if (!ret)
> +			break;
> +	}
> +	stop_progress(&progress_state);
> +
> +	if (ret)
> +		die(_("unable to enumerate additional cruft tips"));

If we are going to die() here, we might as well do it in the loop
instead of the break. But wait... this seems backwards.

I suppose what this is saying is: try each possible hook until we
get a success (in which case we stop trying). If we have a failure
in all attempts, then we die().

I was expecting this to be a cumulative operation: we execute each
hook in order and include all of their output. This implementation
doesn't seem to match that (or I'm reading something wrong).

> +	if (prepare_revision_walk(&revs))
> +		die(_("revision walk setup failed"));
> +	if (progress)
> +		progress_state = start_progress(_("Traversing extra cruft objects"), 0);
> +	nr_seen = 0;
> +	traverse_commit_list(&revs, show_cruft_commit, show_cruft_object, NULL);

Hm. I'm trying to look at these helpers and figure out what they
are doing to prevent these objects from being pruned. This could
use a comment or something, as I'm unable to grok it at present.

> +	stop_progress(&progress_state);
> +
> +	return ret;
> +}


> +test_expect_success 'additional cruft tips may be specified via pack.extraCruftTips' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		# Create a handful of objects.
> +		#
> +		#   - one reachable commit, "base", designated for the reachable
> +		#     pack
> +		#   - one unreachable commit, "cruft.discard", which is marked
> +		#     for deletion
> +		#   - one unreachable commit, "cruft.old", which would be marked
> +		#     for deletion, but is rescued as an extra cruft tip
> +		#   - one unreachable commit, "cruft.new", which is not marked
> +		#     for deletion
> +		test_commit base &&
> +		git branch -M main &&
> +
> +		git checkout --orphan discard &&
> +		git rm -fr . &&
> +		test_commit --no-tag cruft.discard &&

Could we store this commit to make sure it is removed from the
repository later?

> +		git checkout --orphan old &&
> +		git rm -fr . &&
> +		test_commit --no-tag cruft.old &&
> +		cruft_old="$(git rev-parse HEAD)" &&
> +
> +		git checkout --orphan new &&
> +		git rm -fr . &&
> +		test_commit --no-tag cruft.new &&
> +		cruft_new="$(git rev-parse HEAD)" &&
> +
> +		git checkout main &&
> +		git branch -D old new &&

Do you need to delete the 'discard' branch here?

> +		git reflog expire --all --expire=all &&
> +
> +		# mark cruft.old with an mtime that is many minutes
> +		# older than the expiration period, and mark cruft.new
> +		# with an mtime that is in the future (and thus not
> +		# eligible for pruning).
> +		test-tool chmtime -2000 "$objdir/$(test_oid_to_path $cruft_old)" &&
> +		test-tool chmtime +1000 "$objdir/$(test_oid_to_path $cruft_new)" &&
> +
> +		# Write the list of cruft objects we expect to
> +		# accumulate, which is comprised of everything reachable
> +		# from cruft.old and cruft.new, but not cruft.discard.
> +		git rev-list --objects --no-object-names \
> +			$cruft_old $cruft_new >cruft.raw &&
> +		sort cruft.raw >cruft.expect &&

Ok, here you list the exact object set you are expecting post-prune.

> +		# Write the script to list extra tips, which are limited
> +		# to cruft.old, in this case.
> +		write_script extra-tips <<-EOF &&
> +		echo $cruft_old
> +		EOF
> +		git config pack.extraCruftTips ./extra-tips &&
> +
> +		git repack --cruft --cruft-expiration=now -d &&

So, at this point, it seems we are not including the 'discard'
objects in the cruft pack because they are still reachable. Or,
am I reading that incorrectly?

> +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
> +		git show-index <${mtimes%.mtimes}.idx >cruft &&
> +		cut -d" " -f2 cruft | sort >cruft.actual &&
> +		test_cmp cruft.expect cruft.actual

One thing that would be good, as a safety check, is to remove
the pack.extraCruftTips config and re-run the repack and be
sure that we are pruning the objects previously saved by the
hook.

> +	)
> +'
> +
> +test_expect_success 'additional cruft blobs via pack.extraCruftTips' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		test_commit base &&
> +
> +		blob=$(echo "unreachable" | git hash-object -w --stdin) &&
> +
> +		# mark the unreachable blob we wrote above as having
> +		# aged out of the retention period
> +		test-tool chmtime -2000 "$objdir/$(test_oid_to_path $blob)" &&
> +
> +		# Write the script to list extra tips, which is just the
> +		# extra blob as above.
> +		write_script extra-tips <<-EOF &&
> +		echo $blob
> +		EOF
> +		git config pack.extraCruftTips ./extra-tips &&
> +
> +		git repack --cruft --cruft-expiration=now -d &&
> +
> +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
> +		git show-index <${mtimes%.mtimes}.idx >cruft &&
> +		cut -d" " -f2 cruft >actual &&
> +		echo $blob >expect &&
> +		test_cmp expect actual
> +	)
> +'

It would be helpful to include a test for the multi-value case where
multiple scripts are executed and maybe include an "exit 1" in some
of them?

Thanks,
-Stolee
