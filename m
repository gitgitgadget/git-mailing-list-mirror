Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9063DC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62780204FD
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBwtUPQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHNBqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgHNBqn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 21:46:43 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192DFC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 18:46:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m7so7080828qki.12
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 18:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5SYb5Gy8QYI5xig4Chlfh2rEP1PAmGtnDLWtn5+llxY=;
        b=dBwtUPQnIilNr4TBBy47cwMI5ulnO9cxNPWPnUFd4ok7obWdkL5wdcbwccxCggWwhL
         QS8qgiALBa1Ore/OclLhEFgijRz91pgT9LMEnRPey3tfHrcZcpCy7Y2AV0/WL8UfmPQO
         yYXBuRuj3Ntzyr4VGPuZ1W76ChvbcjDW8ftbyOlHDSmSpUxW86qxYRtCPVY90/ai8B9D
         PY0UjLDdI2K88qQ8tamQ+MS8qxtTOVL4RpRtTSkqGmHebWxenzeBYumPgDZEpQ+0Jd02
         SRBUXevord9glxe13MAsX6dqxti/n/vQQwydB+b+Au2AJU/uo4IQbk+qDrO+dg5Xe8ZA
         YFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5SYb5Gy8QYI5xig4Chlfh2rEP1PAmGtnDLWtn5+llxY=;
        b=M3CgTQDGaz57J3+eRBQOJ+zw4m79nqNvwAf0geQ++dnq5g1i7uA3f2mMWnEBoMP1/a
         PX3FW1TZykZ2rmBvG2fPHg5giUt2I19j/zDO1yVzVPqXgNEOmd1YeGQPVPo398AQLpYf
         3eCafNj7UPmh22P0h6APJYAOTGlNUwmzJ7dFNdNmqyIkRvXqTlrLY5KxLYnXGjkp63x2
         srxuav6jnnVrUWfP9X16HNdZUXGSSz7ZVCyNbe04cJ6xQkQvDXhE6gyb8+TYRdZdMhAZ
         fy2GP4sc6fAD1bYjGCblF2l466b7qEkzDIKHQGIiPO5R0eX9mRtMmATJ/2nGt41TmVUH
         aiOQ==
X-Gm-Message-State: AOAM531nfTdjxxiv2OlMmv75mFzb2qFuH9zDTDDtzgBgPhHFNXWde5j4
        6ocUXahZ3sVmab9evuYqy1y8iideAQgojA==
X-Google-Smtp-Source: ABdhPJx+TS3n0Z3P5B1zrIa1j+3SghwRkV3ZmGy4HwIkbH3NEwpy25iR/3xpCpzLflyYCMBkwl3KKA==
X-Received: by 2002:ae9:e857:: with SMTP id a84mr120803qkg.100.1597369600134;
        Thu, 13 Aug 2020 18:46:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id a6sm7397945qka.5.2020.08.13.18.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 18:46:38 -0700 (PDT)
Subject: Re: [PATCH 3/9] maintenance: add loose-objects task
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
 <621375a3c99014c48568660bde062b7330d5a662.1596731425.git.gitgitgadget@gmail.com>
 <20200812231053.GI2965447@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0fd9d838-657f-448a-f09b-6e431aebdf69@gmail.com>
Date:   Thu, 13 Aug 2020 21:46:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200812231053.GI2965447@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/12/2020 7:10 PM, Emily Shaffer wrote:
> On Thu, Aug 06, 2020 at 04:30:18PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
>> index bb0d5eded4..898aff4726 100644
>> --- a/Documentation/git-maintenance.txt
>> +++ b/Documentation/git-maintenance.txt
>> @@ -80,6 +80,17 @@ gc::
>>  	It can also be disruptive in some situations, as it deletes stale
>>  	data.
>>  
>> +loose-objects::
>> +	The `loose-objects` job cleans up loose objects and places them into
>> +	pack-files. In order to prevent race conditions with concurrent Git
>> +	commands, it follows a two-step process. First, it deletes any loose
>> +	objects that already exist in a pack-file; concurrent Git processes
>> +	will examine the pack-file for the object data instead of the loose
>> +	object. Second, it creates a new pack-file (starting with "loose-")
>> +	containing a batch of loose objects. The batch size is limited to 50
>> +	thousand objects to prevent the job from taking too long on a
>> +	repository with many loose objects.
> 
> [emily] What's not said is what happens to loose-* packfile. Does this
> get repacked and disappear, is it treated differently, etc?
> [jonathantan] This is treated the same as any other pack. Is there a
> reason to call it loose-*?

Auditing, mostly. When working with repositories that have
multiple pack-files as a rule, it is helpful to know what "kind"
of pack-file they are. I almost added a "repacked-" prefix to
the packs produced by 'git multi-pack-index repack'. It helps
to distinguish "reprocessed" data from "I got this from a 'clone'
or 'fetch'."

Of course, as these pack-files are repacked later, the prefixes
will get dropped. The name does give us some help when performing
diagnostics on a misbehaving repository. A pack directory filled
with many "loose-*.pack" files indicates that the 'loose-objects'
step was run many times without either 'gc' or 'incremental-repack'
coalescing those packs with delta compression.

> [jrnieder] It seems like unreachable objects will get stuck going in and
> out of this pack, right? unreachable loose obj -> loose-*.pack ->
> repack, unreachable becomes loose -> repeat

This is a good point. This task would probably interact poorly with
the 'gc' task in that regard. They are not intended to both be
enabled at the same time, but it might be good to point that out
directly in the documentation.

How does this sound?

 The `gc` task writes unreachable objects as loose objects to
 be cleaned up by a later step only if they are not re-added to
 a pack-file; for this reason it is not advisable to enable both
 the `loose-objects` and `gc` tasks at the same time.

>> +static int prune_packed(struct maintenance_opts *opts)
>> +{
>> +	struct child_process child = CHILD_PROCESS_INIT;
>> +
>> +	child.git_cmd = 1;
>> +	strvec_push(&child.args, "prune-packed");
>> +
>> +	if (opts->quiet)
>> +		strvec_push(&child.args, "--quiet");
>> +
>> +	return !!run_command(&child);

> [emily] Why not report the error code here to the caller? Is there a
> path to notify user of errors that require user intervention?
> [jrnieder] Some errors might be expected and some might not, so should
> we handle them differently?
> [emily] Probably makes more sense to revisit this in the far future when
> we teach 'git maintenance' to send us emails and flashing lights when
> our jobs fail, instead of worrying about it now :)
> [jrnieder] Imagine if we got exit 127 because the usage we are using is
> wrong - in that case, for example, we would want to BUG()

I was previously returning the exact error code, but received
feedback that these internal methods should have simpler return
values [1].

[1] https://lore.kernel.org/git/xmqq4kpyq8wh.fsf@gitster.c.googlers.com/

>> +static int write_loose_object_to_stdin(const struct object_id *oid,
>> +				       const char *path,
>> +				       void *data)
>> +{
>> +	struct write_loose_object_data *d = (struct write_loose_object_data *)data;

> [jrnieder] Since we are enlightened C developers, not C++ developers,
> you can skip the explicit cast.

Hm. I definitely _could_ but don't really want to. Perhaps I'm just
being pedantic, but I was just talking to someone today off-list that
they were disappointed that they couldn't compile Git in a C++ compiler
mainly because of these kinds of casting issues.

I was surprised the word "cast" does not appear anywhere in the
CodingGuidelines, because if this is a convention we want to follow,
then I have definitely been violating it for a *while*.
 
>> +++ b/t/t7900-maintenance.sh
>> @@ -83,4 +83,43 @@ test_expect_success 'prefetch multiple remotes' '
>>  	git log prefetch/remote2/two
>>  '
>>  
>> +test_expect_success 'loose-objects task' '

> [jrnieder] Unrelated to this change, this test makes me sad that we
> don't have better low-level test helpers to enable this kind of testing.> Makes me wish for something better :)

Do you mean you wish we had helpers for getting a repo
into a certain state of its object database? Or somehow
mocking the object database in-memory to provide more
unit-level testing? I don't understand what "something
better" looks like.

>> +	# Repack everything so we know the state of the object dir
>> +	git repack -adk &&
>> +
>> +	# Hack to stop maintenance from running during "git commit"
>> +	echo in use >.git/objects/maintenance.lock &&
>> +
>> +	# Assuming that "git commit" creates at least one loose object
>> +	test_commit create-loose-object &&
>> +	rm .git/objects/maintenance.lock &&
>> +
>> +	ls .git/objects >obj-dir-before &&
>> +	test_file_not_empty obj-dir-before &&
>> +	ls .git/objects/pack/*.pack >packs-before &&
>> +	test_line_count = 1 packs-before &&
>> +
>> +	# The first run creates a pack-file
>> +	# but does not delete loose objects.
>> +	git maintenance run --task=loose-objects &&
>> +	ls .git/objects >obj-dir-between &&
>> +	test_cmp obj-dir-before obj-dir-between &&
>> +	ls .git/objects/pack/*.pack >packs-between &&
>> +	test_line_count = 2 packs-between &&
>> +	ls .git/objects/pack/loose-*.pack >loose-packs &&
>> +	test_line_count = 1 loose-packs &&
>> +
>> +	# The second run deletes loose objects
>> +	# but does not create a pack-file.
>> +	git maintenance run --task=loose-objects &&
>> +	ls .git/objects >obj-dir-after &&
>> +	cat >expect <<-\EOF &&
>> +	info
>> +	pack
>> +	EOF
>> +	test_cmp expect obj-dir-after &&
>> +	ls .git/objects/pack/*.pack >packs-after &&
>> +	test_cmp packs-between packs-after
>> +'
>> +
> 

