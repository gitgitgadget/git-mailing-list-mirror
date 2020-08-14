Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90857C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B37E20855
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl5l3An4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHNB2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNB2f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 21:28:35 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99812C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 18:28:35 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f19so1419432qtp.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 18:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+yXTVtCe/yt5kFniQbPBhBAMsP+qrOOOz9lcgInL9e4=;
        b=Kl5l3An4L9XfRxKdxTQMvLNmEFWtOIHujy63Yjf9q4Eh7VR8e3RJSsvn9kek5uj1fB
         ktkiARHXI3S8Mf/CFXViX+FJOW9/XuKkf9R+Yh02kCozT2yQIhiKdo3XMVlKJeSG9+G7
         LcThybVPK6qFcOzX60QK5EVERuqJcHveBzJqhDNLo+aDcTevHl94RDGiFpm7RlBFMFM/
         xNsZHMfsBe7nc1amyFwkSrdLMWz1QpYeXuYinKOZC6Yq2V4TBT5qnm3+DogaAhkCWxkd
         /3wdeooh9EhxtkX62tMjaarshLyLZmQSd9aF8kUMnpzNGknG5Zpm3keGLHnmwIx8ZbyI
         5RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+yXTVtCe/yt5kFniQbPBhBAMsP+qrOOOz9lcgInL9e4=;
        b=FLUbnHgKNUe7a8NJuagkMTWqvFp53neg4Va+ng0418QOiJH0uUJg8uGUx8VgRpnkC6
         iMM6j4IBxq+Ub7uC7Gomw2/ak9iXRsKeJhDDt9bsBPetT+LofzjopCy2secSJhRiqccr
         wHL69F9EUxg8ClM2ZoXp+NnUNmwk+UrpNS4xpMpeRT1FH6z4C+CL93X4wXm/NKVhfosi
         OEGHutSqlgwRGN3PXpH8KMrYNoOWt6rFZdYoY3m32wD/Hq6FkOZo12bAYr5zO18gL7b2
         lGedAOCiTQcKyckLzT77KhXumccHwTnSutcrWD1vWz9EGfgQBPsmhjm3lFB5rKAgg90Z
         P8gQ==
X-Gm-Message-State: AOAM530KqVuGUiNEFgiQbdk0l9JhjJPw1vmTWK/238B74BJS6s0zUDoG
        241kd+ueDItrbsJAwWq5Io0=
X-Google-Smtp-Source: ABdhPJzatVS6U8t0vAdzhFLng4cRAb6sl7v5zr9CR/RCzaFjR4TsaIPqRSuDu5mFvDFkdA1U1S4Bqg==
X-Received: by 2002:ac8:5685:: with SMTP id h5mr102114qta.378.1597368514667;
        Thu, 13 Aug 2020 18:28:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id 128sm6799614qkk.101.2020.08.13.18.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 18:28:34 -0700 (PDT)
Subject: Re: [PATCH 2/9] maintenance: add prefetch task
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
 <85118ed5f19468d5051dd1579e35cae3c3114d24.1596731425.git.gitgitgadget@gmail.com>
 <20200812231036.GH2965447@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e96b2eec-0746-1b00-4b8b-ce737cdce967@gmail.com>
Date:   Thu, 13 Aug 2020 21:28:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200812231036.GH2965447@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/12/2020 7:10 PM, Emily Shaffer wrote:
> On Thu, Aug 06, 2020 at 04:30:17PM +0000, Derrick Stolee via GitGitGadget wrote:
>>
>> 3. By adding a new refspec "+refs/heads/*:refs/prefetch/<remote>/*"
>>    we can ensure that we actually load the new values somewhere in
>>    our refspace while not updating refs/heads or refs/remotes. By
>>    storing these refs here, the commit-graph job will update the
>>    commit-graph with the commits from these hidden refs.
> 
> [emily] How does the content of refs/prefetch/* get used?
> [jrnieder] How does the content of refs/prefetch/* get cleaned up?
> [jonathantan] refs/prefetch/* will get used in negotiation so it is
> useful to keep these.
>>
>> 4. --prune will delete the refs/prefetch/<remote> refs that no
>>    longer appear on the remote.
> [jrnieder] this is what cleans up refs/prefetch/* later :)
> 
>> +static int fetch_remote(const char *remote, struct maintenance_opts *opts)
>> +{
>> +	struct child_process child = CHILD_PROCESS_INIT;
>> +
>> +	child.git_cmd = 1;
>> +	strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
>> +		     "--no-write-fetch-head", "--refmap=", NULL);
> [jonathantan] It would be good to pass --recurse-submodules=no.
> [jrnieder] Since we are specifying the refmap here, if we were to
> recurse into submodules, we'd have to be careful about making sure
> refmap gets propagated correctly.

Good point.

>> +static int fill_each_remote(struct remote *remote, void *cbdata)
> [jrnieder] Since this is a callback that happens for each remote, maybe
> this should be named to indicate it only fills one remote at a time
> instead. Nit :)

Sure. append_remote() is better.

>> +{
>> +	struct string_list *remotes = (struct string_list *)cbdata;
>> +
>> +	string_list_append(remotes, remote->name);
>> +	return 0;
>> +}
>> +
>> +static int maintenance_task_prefetch(struct maintenance_opts *opts)
>> +{
>> +	int result = 0;
>> +	struct string_list_item *item;
>> +	struct string_list remotes = STRING_LIST_INIT_DUP;
>> +
>> +	if (for_each_remote(fill_each_remote, &remotes)) {
>> +		error(_("failed to fill remotes"));
>> +		result = 1;
>> +		goto cleanup;
>> +	}
>> +
>> +	for (item = remotes.items;
>> +	     item && item < remotes.items + remotes.nr;
>> +	     item++)
> 
> Is there a reason not to use for_each_string_list_item() instead? This
> would be more brief and also easier to read (less thinking about what
> the loop is doing).

I just keep forgetting about that macro. Thanks.

>> +		result |= fetch_remote(item->string, opts);
>> +
>> +cleanup:
>> +	string_list_clear(&remotes, 0);
>> +	return result;
>> +}
>> +
> 
>>  enum maintenance_task_label {
>> +	TASK_PREFETCH,
> [jrnieder] Nit: Is there a sort order for these? Should we establish an order
> early on (e.g. alphabetical)?

There _is_ an order, and maybe that should be up for debate.
This one is really about fetching new refs before (possibly)
deleting unreachable data or doing a full repack in the 'gc'
task. The rest of the tasks are after the 'gc' task (in an
unimportant order) because they are likely to be no-ops if the
'gc' task does work.

Of course, users can customize this order using the
--task=<task> options.

>>  	TASK_GC,
>>  	TASK_COMMIT_GRAPH,
> 
>> +test_expect_success 'prefetch multiple remotes' '
>> +	git clone . clone1 &&
>> +	git clone . clone2 &&
>> +	git remote add remote1 "file://$(pwd)/clone1" &&
>> +	git remote add remote2 "file://$(pwd)/clone2" &&
>> +	git -C clone1 switch -c one &&
>> +	git -C clone2 switch -c two &&
>> +	test_commit -C clone1 one &&
>> +	test_commit -C clone2 two &&
>> +	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
>> +	fetchargs="--prune --no-tags --no-write-fetch-head --refmap= --quiet" &&
>> +	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&

> [jrnieder] In practice, why were all the \\ needed? Trying to figure out
> where Git is using a shell that would need the * escaped and finding it
> hard to reason about.

It's the 'grep' way down inside test_subcommand that will
fail if it interprets these '*' incorrectly.

>> +	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
>> +	test_path_is_missing .git/refs/remotes &&
>> +	test_cmp clone1/.git/refs/heads/one .git/refs/prefetch/remote1/one &&
>> +	test_cmp clone2/.git/refs/heads/two .git/refs/prefetch/remote2/two &&

> [jrnieder] Should we use test_cmp_rev instead to make compatible with
> packed-refs?

While that would be good, these are refs across two .git directories.

I suppose that I could fetch normally and check refs/remotes/remote1/one
versus refs/prefetch/remote1/one.

>> +	git log prefetch/remote1/one &&
>> +	git log prefetch/remote2/two

> [jonathantan] Why do we use 'git log' to check? I'm a little confused
> about what's going on; if you just want to check that the refs are
> present you could use 'git rev-parse' instead?

The main point is to demonstrate that we have the actual objects
in the current repository, not just refs storing object IDs that
don't actually exist in the object database. Does rev-parse check
that the object exists? (A quick check in my local repository seems
to say no.)

Reorganizing the test to work with test_cmp_rev results in the
following:

test_expect_success 'prefetch multiple remotes' '
	git clone . clone1 &&
	git clone . clone2 &&
	git remote add remote1 "file://$(pwd)/clone1" &&
	git remote add remote2 "file://$(pwd)/clone2" &&
	git -C clone1 switch -c one &&
	git -C clone2 switch -c two &&
	test_commit -C clone1 one &&
	test_commit -C clone2 two &&
	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
	test_path_is_missing .git/refs/remotes &&
	git log prefetch/remote1/one &&
	git log prefetch/remote2/two &&
	git fetch --all &&
	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two
'

Thanks,
-Stolee
