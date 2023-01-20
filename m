Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43115C25B4E
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 14:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjATO44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjATO4z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 09:56:55 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43D45F50
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 06:56:53 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k4so5914887vsc.4
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 06:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qQWtHKKgQk307wOu9WZo8XuyoQJ/RDnRouiLAWqsYw=;
        b=fOUeKAHR+Jj+gvuuiIHlKBXU1qsupNGir6lJbELBGaRr9vUb1dwNEvKHX2YMgbsh/K
         6PmTOdLjMSF3AyyyZXymMVEh9IHkx5jY44g0+sWtEUqKgZF4e3soDkUhBf+2ia5sS0sN
         gZig8Vujjzc6fatPdujADA2u2pJrN45S4M4IqDPPDlKKHMkOusgF/1aT5Cx6wVSxb//s
         Tr48hPLYFz0VoLQ2/F3FFJnmpSsWuNZgnUnLP6z4zeLjegXJqEoIHkG3vU3So0LcPUBz
         rJHLaFQ5rW+We69l1t7VSL/t/rRXmkPN+GNmZ77CbXIuNWIme3bX9gh+pTbG2YDis3i4
         l7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qQWtHKKgQk307wOu9WZo8XuyoQJ/RDnRouiLAWqsYw=;
        b=r0ZOzoYvsWX2cLeo866oG8dp4HzJgqjob7xrdHS8Vpq2RhQq2hFreXg1opTncly4FH
         GE7VkyEsGnWL7ctBetG2nKuD+0XWyidfPhJofVm5PZ9ujxQS/NNidOmF5R9X3bYY78Vm
         qjWXjyiYWXsWojBBDjkyvjzriQYHnV25kiMl2hxMKiF3W7dWjOype7ToLf/Hs41ReZc2
         b5RcbzsPF+Ki34hPT4LeadgS9rUF4279m1Um7a+vt/nq895A7QumraelokEbQSgwtLXz
         EsIYUFGvkBStj4LaUnFX4A8+/QcQgZNF/vh+CA76vc2hCSnba1/QYxxe94rmMesr9tPr
         0Hbw==
X-Gm-Message-State: AFqh2kqDtHxToakPDWNo6c/AU4/IRPKZYUL5sFjDWUAWc8slSM61AMxR
        xvjzcBzaopXU0FbJiw9ZNOqo
X-Google-Smtp-Source: AMrXdXs02maVuRdDxVpIrQvc/6bWjjVSehDdJCUS00gWYUcBoLefH/aYlAUfx7qNeW1Rx28HRFCkUg==
X-Received: by 2002:a67:fc06:0:b0:3b1:3a0b:50b0 with SMTP id o6-20020a67fc06000000b003b13a0b50b0mr8657465vsq.24.1674226612665;
        Fri, 20 Jan 2023 06:56:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ede7:6bce:9af7:733c? ([2600:1700:e72:80a0:ede7:6bce:9af7:733c])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a248700b006ff8a122a1asm10339478qkn.78.2023.01.20.06.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 06:56:52 -0800 (PST)
Message-ID: <1e787073-a1f6-58cd-ec5a-f99f2879624f@github.com>
Date:   Fri, 20 Jan 2023 09:56:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/8] bundle-uri: download in creationToken order
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <57c0174d3752fb61a05e0653de9d3057616ed16a.1673037405.git.gitgitgadget@gmail.com>
 <ede340d1-bce4-0c1d-7afb-4874a67d1803@github.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ede340d1-bce4-0c1d-7afb-4874a67d1803@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/2023 1:32 PM, Victoria Dye wrote:> Derrick Stolee via GitGitGadget wrote:
>> +static int fetch_bundles_by_token(struct repository *r,
>> +				  struct bundle_list *list)
>> +{
>> +	int cur;
>> +	int pop_or_push = 0;
>> +	struct bundle_list_context ctx = {
>> +		.r = r,
>> +		.list = list,
>> +		.mode = list->mode,
>> +	};
>> +	struct sorted_bundle_list sorted = {
>> +		.alloc = hashmap_get_size(&list->bundles),
>> +	};
>> +
>> +	ALLOC_ARRAY(sorted.items, sorted.alloc);
>> +
>> +	for_all_bundles_in_list(list, insert_bundle, &sorted);
>> +
>> +	QSORT(sorted.items, sorted.nr, compare_creation_token);
>
> So, at this point, 'sorted' is ordered by *decreasing* creation token? With
> the loop below being somewhat complex, it would be nice to have a comment
> mention that explicitly so readers have a clear understanding of the
> "initial state" before entering the loop.

That's a good point, but also in my local version I have the following line:

	QSORT(bundles.items, bundles.nr, compare_creation_token_decreasing);

The comparison function was renamed based on Junio's feedback. After making
that change, this line is more self-documenting. Do you still think that it
needs a clarification comment if this rename occurs?

>> +	/*
>> +	 * Use a stack-based approach to download the bundles and attempt
>> +	 * to unbundle them in decreasing order by creation token. If we
>> +	 * fail to unbundle (after a successful download) then move to the
>> +	 * next non-downloaded bundle (push to the stack) and attempt
>> +	 * downloading. Once we succeed in applying a bundle, move to the
>> +	 * previous unapplied bundle (pop the stack) and attempt to unbundle
>> +	 * it again.
>> +	 *
>> +	 * In the case of a fresh clone, we will likely download all of the
>> +	 * bundles before successfully unbundling the oldest one, then the
>> +	 * rest of the bundles unbundle successfully in increasing order
>> +	 * of creationToken.
>> +	 *
>> +	 * If there are existing objects, then this process may terminate
>> +	 * early when all required commits from "new" bundles exist in the
>> +	 * repo's object store.
>> +	 */
>> +	cur = 0;
>> +	while (cur >= 0 && cur < sorted.nr) {
>> +		struct remote_bundle_info *bundle = sorted.items[cur];
>> +		if (!bundle->file) {
>> +			/* Not downloaded yet. Try downloading. */
>> +			if (download_bundle_to_file(bundle, &ctx)) {
>> +				/* Failure. Push to the stack. */
>> +				pop_or_push = 1;
>> +				goto stack_operation;
>
> Personally, I find the use of "stack" terminology more confusing than not.
> 'sorted' isn't really a stack, it's a list with fixed contents being
> traversed stepwise with 'cur'. For example, 'pop_or_push' being renamed to
> 'move_direction' or 'step' something along those lines might more clearly
> indicate what's actually happening with 'cur' & 'sorted'.

s/pop_or_push/move_direction/ makes a lot of sense.

I'll think about describing the strategy differently to avoid the "stack"
language. Mentally, I'm constructing a stack of "downloaded but unable to
unbundle bundles", but they aren't actually arranged that way in any
explicit structure. Instead, they are just the bundles in the list that
have a file but haven't been unbundled.

>> +			}
>> +
>> +			/* We expect bundles when using creationTokens. */
>> +			if (!is_bundle(bundle->file, 1)) {
>> +				warning(_("file downloaded from '%s' is not a bundle"),
>> +					bundle->uri);
>> +				break;
>> +			}
>> +		}
>> +
>> +		if (bundle->file && !bundle->unbundled) {
>> +			/*
>> +			 * This was downloaded, but not successfully
>> +			 * unbundled. Try unbundling again.
>> +			 */
>> +			if (unbundle_from_file(ctx.r, bundle->file)) {
>> +				/* Failed to unbundle. Push to stack. */
>> +				pop_or_push = 1;
>> +			} else {
>> +				/* Succeeded in unbundle. Pop stack. */
>> +				pop_or_push = -1;
>> +			}
>> +		}
>> +
>> +		/*
>> +		 * Else case: downloaded and unbundled successfully.
>> +		 * Skip this by moving in the same direction as the
>> +		 * previous step.
>> +		 */
>> +
>> +stack_operation:
>> +		/* Move in the specified direction and repeat. */
>> +		cur += pop_or_push;
>> +	}
>
> After reading through this loop, I generally understood *what* its doing,
> but didn't really follow *why* the download & unbundling is done like this.

The commit message should be updated to point to refer to the previously-
added test setup in t5558:

# To get interesting tests for bundle lists, we need to construct a
# somewhat-interesting commit history.
#
# ---------------- bundle-4
#
#       4
#      / \
# ----|---|------- bundle-3
#     |   |
#     |   3
#     |   |
# ----|---|------- bundle-2
#     |   |
#     2   |
#     |   |
# ----|---|------- bundle-1
#      \ /
#       1
#       |
# (previous commits)

And then this can be used to motivate the algorithm. Suppose we have
already downloaded commit 1 through a previous fetch. We try to download
bundle-4 first, but it can't apply because it requires commits that are
in bundle-3 _and_ bundle-2, but the client doesn't know which bundles
contain those commits. Downloading bundle-3 successfully unbundles, so a
naive algorithm would think we are "done" and expect to unbundle bundle-4.
However, that unbundling fails, so we go deeper into the list to download
bundle-2. That succeeds, and then retrying bundle-4 succeeds.

> I needed to refer back to the design doc
> ('Documentation/technical/bundle-uri.txt') to understand some basic
> assumptions about bundles:
>
> - A new bundle's creation token should always be strictly greater than the
>   previous newest bundle's creation token. I don't see any special handling
>   for equal creation tokens, so my assumption is that the sorting of the
>   list arbitrarily assigns one to be "greater" and it's dealt with that way.

Yes, the bundle provider should not have equal values unless the bundles are
truly independent. That could be clarified in that doc.

> - The bundle with the lowest creation token should always be unbundleable,
>   since it contains all objects in an initial clone.

Yes, at least it should not have any required commits.

> I do still have some questions, though:
>
> - Why would 'unbundle_from_file()' fail? From context clues, I'm guessing it
>   fails if it has some unreachable objects (as in an incremental bundle), or
>   if it's corrupted somehow.

You are correct. We assume that the data is well-formed and so the problem
must be due to required commits not already present in the local object store.

> - Why would 'download_bundle_to_file()' to fail? Unlike
>   'unbundle_from_file()', it looks like that represents an unexpected error.

Yes, that could fail for network issues such as a server error or other
network failure. In such cases, the client should expect that we will not
be able to download that bundle for the process's lifetime. We may be able
to opportunistically download other bundles, but we will rely on the Git
protocol to get the objects if the bundles fail.

These failure conditions are not tested deeply (there are some tests from
earlier series that test the behavior, but there is room for improvement).

> Also - it seems like one of the assumptions here is that, if a bundle can't
> be downloaded & unbundled, no bundle with a higher creation token can be
> successfully unbundled ('download_bundle_to_file()' sets 'pop_or_push' to
> '1', which will cause the loop to ignore all higher-token bundles and return
> a nonzero value from the function).
>
> I don't think that assumption is necessarily true, though. Suppose you have
> a "base" bundle 100 and incremental bundles 101 and 102. 101 has all objects
> from a new branch A, and 102 has all objects from a newer branch B (not
> based on any objects in A). In this case, 102 could be unbundled even if 101
> is corrupted/can't be downloaded, but we'd run into issues if we store 102
> as the "latest unbundled creation token" (because it implies that 101 was
> unbundled).

You are correct. bundle-3 can be unbundled even if bundle-2 fails in the
test example above.

> Is there any benefit to trying to unbundle those higher bundles *without*
> advancing the "latest creation token"? E.g. in my example, unbundle 102 but
> store '100' as the latest creation token?

I will need to think more about this.

Generally, most repositories that care about this will not have independent
bundles because between every bundle creation step the default branch will
advance. (Of course, exceptions can still occur, such as over weekends.)
Thus, the latest bundle will have a required commit that only exists in the
previous bundle. This algorithm and its error conditions are then looking
for ways to recover when that is not the case.

When a bundle fails to download, my gut feeling is that it is unlikely that
it was completely independent of a bundle with higher creationToken. However,
we have already downloaded that bundle and it is a very low cost to attempt
an unbundling of it.

The tricky part is that we want to avoid downloading _all_ the bundles just
because one is failing to unbundle. If a failed download would cause the top
bundle from unbundling, we don't want to go through the whole list of bundles
even though they unbundle without issue. I'm thinking specifically about the
incremental fetch case, where we don't want to blow up to a full clone worth
of downloads.

This deserves a little more attention, so I'll think more on it and get
back to you.

>>  	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
>> -	git -C clone-list-http-2 cat-file --batch-check <oids
>> +	git -C clone-list-http-2 cat-file --batch-check <oids &&
>> +
>> +	for b in 1 2 3 4
>> +	do
>> +		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||
>> +			return 1
>> +	done
>
> If I understand correctly, these added conditions would have passed even if
> they were added when the test was initially created in patch 1, but they're
> added here to tie them to the implementation of the creationToken heuristic?
> Seems reasonable.

They probably should have been added in patch 1 to be clear that behavior
is not changing here.

>> +'
>> +
>> +test_expect_success 'clone bundle list (http, creationToken)' '
>
> This new test has the same name as the one above it - how does it differ
> from that one? Whatever the difference is, can that be noted somehow in the
> title or a comment?

The title should change, pointing out that the bundle list is truncated
and the rest of the clone is being fetched over the Git protocol. It will
be expanded with fetches later, I think, but it should be better motivated
in this patch, even if that is so.

>> +# Usage: test_bundle_downloaded <bundle-id> <trace-filename>
>> +test_bundle_downloaded () {
>> +	cat >pattern <<-EOF &&
>> +	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/$1.bundle"\]
>> +	EOF
>> +	grep -f pattern "$2"
>> +}
>
> This function is the same as the one created in 't5558'. Should it be moved
> to 'lib-bundle.sh' or 'test-lib.sh' to avoid duplicate code?

It's slightly different, but that is just because we are using the advertisement
and thus we never download a bundle-list and always download .bundle files. That
is not an important distinction and I expect to replace it with the
test_remote_https_urls() helper discussed in an earlier response.

Thanks,
-Stolee
