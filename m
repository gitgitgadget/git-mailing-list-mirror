Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F26610B
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443611; cv=none; b=aD7eeSzF8rNNNGVdyLD00URttLlioQBnfJvfvj15EKSf94JGwFauestNsnBol3Ac0SM92BfGj+EEKb7wmSQSklit/5070XdBsUI3PSpBqOpv/60c2CvYJ4drUzxMTDRW/Yq7Mj5NjNoBN1VRS9eu0FzBXz7eqGKn7+XZrAP7hs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443611; c=relaxed/simple;
	bh=pkMhqAaQj4FwVjB/pYnqS22qLs+updcY971FQ+Gds3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6Jwu1v4Jj1FWbzaMwtqGQS2pG6pVio4IMUR+WuRnL/x90hfG3PuK9w+y4C5U7Ee4tKaYTRqw7CRrcl/fQujtCjoWoPOhzk48+GH31ZXeD+sclvUmSVxg/6ecAgfNP7+LKsdoNvqa7duOgx94FePO3IfI0aIr6YEJT0jV8oVgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrdB16zf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrdB16zf"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7835321bc98so1673581b3a.2
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759443609; x=1760048409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWE2LNT7i1ItEDHPftdc0sDGKlXQWIcByVMhvc9BB/8=;
        b=VrdB16zfRYqPj/NEfeDRNE8xEb35aH0SSD0DWQWHcBOMXMcjpTSkdwi3nLE4BoUJeB
         xoZfnoYgFpPnHiijtb59XrWWR/ZvXLi9RGrqq+uoK8Rft9sNX7x19vx0gBYg0yW3Qdsi
         i0b67nPJ15la55JjMrDKHJ+lo+oM6039tX/9xQWrOT+t/PkMK+vflS9Rbescpd8h2Mcj
         zTW05go2pLRZfsAyrGOE6BOxh6vNKBrEbJnD3aq/MssShEx4GptjlUaF50tYeVxmL3o4
         F7r1gQcjGUjAC5sEHAGayWjENJyG2PAg3RUstfBC5F4BBBXXLoErTjyuA1R07Qb0+MRK
         2wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759443609; x=1760048409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWE2LNT7i1ItEDHPftdc0sDGKlXQWIcByVMhvc9BB/8=;
        b=JnKTvKpW0npJw/ZXioS49tGX7ct92UVTrW+CQbHjE4PDnBQPb6LcOfvVnjHlY0Uqru
         S6dZJKpXIZfWKa69ce4CRtMcZkQLtNGbPiUSbOqkJlfpCqDXtBZTNs+THcr/j93/iUec
         WsO0KjZAZJJpVnf050rOnFq40meM+4q1/t4phYBuoAi6TlGGlY31PVbg7TTNSVg2KtYE
         pq1z99hkOfbQVwEUZz+pgoIN6XqeZqyOqKJnC4eSrwBy6Z+9uZmacQSFZ3YxAWQ55hAz
         ZHazwX9ZkiT4343HAjqNrAuguGRpF+qo0nleN/b/Lkvc7IZKVFkOjV1INYGNZhHP2zuQ
         k9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgznnv9FG5TmyPHDXTh+C0p6VnFx8Quh93VfHLo2ayLFE4ObA7mS8H0PGmYyA79Dl84i8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1cuPxlgi+o9TB1ao9PVZMsPVfultQSEmq3xiHRTxW6VP+pfDq
	DDlwSEEGYd3vKAMgP9+sWv/08oxL4TqdiNWtIHwRJHN2vx207AIv4aKfF6jk1Q==
X-Gm-Gg: ASbGncsHJvZMt2D8xgCXz5GiuVXez2fkGx5VPhIWxA0TmYiXfMfmmoaLMnBoyE7MAt4
	cx0TP0VCLIKHIAUAfkZR0GuLf54npgy8ORyapwEv5kZwQ0JDD3vuk3WDk2B38hFn8TFt6EskPuD
	iPhsCN9YPYmXY6NBsBPqP76NqWFBK1iMK+1AwJScOCAGw6cBtjpaVG4YH0cIo4TQ28osh6RxhZB
	lpbNzykVnYEsGJC3Ee5ixIo4mwGwVe1uYuzEhpvsUkvKxBVZ+531o1r+RVw5R2WOznJMnZ17gr7
	c9sNPMr4VpbZXW33Dag++M6n3FqGxsmLf7WYtH5ytPQECCQ+/Qz+S6O1wHzfg0+kHsZq1/VAS0l
	ginFlQkvDmFpo0Nz9wt8srs/7HDuhIPRyH62YhpohL+AerEYd3LpMrjr0GoSdpj8/DHbdpzhBGM
	+gL4p+WU0ZoiQ2V63aZ/wZ50rMjy4TP3VK2ncKfKozbCrxl/a9SyVdZgcCxiKq2LEuOUya2iFFM
	d4eet1I2sQ6Tq3DIZS/fY7EQFAci/U8Ew==
X-Google-Smtp-Source: AGHT+IFTOJC6a1JglN+SQfM8hYcaHDL8LWr6331BVo22q5KHXEOxFsQISXTOpMGvsZZdhflD1wUi8Q==
X-Received: by 2002:a17:902:ea0d:b0:269:603f:420a with SMTP id d9443c01a7336-28e9a5cc5e8mr10987335ad.5.1759443608538;
        Thu, 02 Oct 2025 15:20:08 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:b4ff:982c:6a19:d5f4:4acb? ([2406:7400:56:b4ff:982c:6a19:d5f4:4acb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1108adsm30695255ad.21.2025.10.02.15.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 15:20:08 -0700 (PDT)
Message-ID: <9d310bd5-453f-43a4-b477-ba02baa7a664@gmail.com>
Date: Fri, 3 Oct 2025 03:50:01 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 karthik.188@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <9052eccc-1121-442f-ad51-4fe9217024a0@gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <9052eccc-1121-442f-ad51-4fe9217024a0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 30/09/25 15:35, Phillip Wood wrote:
> Hi Siddharth
>
> On 27/09/2025 00:08, Siddharth Asthana wrote:
>> The git replay command currently outputs update commands that must be
>> piped to git update-ref --stdin to actually update references:
>>
>>      git replay --onto main topic1..topic2 | git update-ref --stdin
>>
>> This design has significant limitations for server-side operations. The
>> two-command pipeline creates coordination complexity, provides no atomic
>> transaction guarantees by default
>
> Are you sure that's true? Maybe I'm missing something but my reading 
> of builtin/update-ref.c is that it when "--stdin" is given it starts a 
> ref transaction, reads the commands from stdin and applies them to 
> that transaction and then commits the transaction which will make the 
> updates atomic.


You are absolutely right, and Karthik confirmed this as well. That was a
significant error in my commit message. git update-ref --stdin IS atomic
by default.


The actual advantages of the new default aren't about atomicity (that
already exists), but rather:
- Eliminating the pipeline for the common case
- Better ergonomics for users who just want refs updated
- Simpler server-side automation

I will rewrite the commit message to accurately reflect this. Elijah
provided a good suggested structure that captures the real trade-offs
without false claims.


>
>> , and complicates automation in bare
>> repository environments where git replay is primarily used.
>
> How does it complicate automation in bare repositories?
>
> Christian has given detailed feedback on the rest of the commit 
> message so I'll not comment on it further.
>
>> diff --git a/Documentation/git-replay.adoc 
>> b/Documentation/git-replay.adoc
>> index 0b12bf8aa4..e104e0bc03 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -9,16 +9,16 @@ git-replay - EXPERIMENTAL: Replay commits on a new 
>> base, works with bare repos t
>>   SYNOPSIS
>>   --------
>>   [verse]
>> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | 
>> --advance <branch>) <revision-range>...
>> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | 
>> --advance <branch>) [--output-commands | --allow-partial] 
>> <revision-range>...
>
> Please wrap this very long line
>
>> @@ -42,6 +42,20 @@ When `--advance` is specified, the update-ref 
>> command(s) in the output
>>   will update the branch passed as an argument to `--advance` to 
>> point at
>>   the new commits (in other words, this mimics a cherry-pick operation).
>>   +--output-commands::
>> +    Output update-ref commands instead of updating refs directly.
>> +    When this option is used, the output can be piped to `git 
>> update-ref --stdin`
>> +    for successive, relatively slow, ref updates. This is equivalent 
>> to the
>> +    old default behavior.
>> +
>> +--allow-partial::
>> +    Allow some ref updates to succeed even if others fail. By default,
>> +    ref updates are atomic (all succeed or all fail). With this option,
>> +    failed updates are reported as warnings rather than causing the 
>> entire
>> +    command to fail. The command exits with code 0 only if all updates
>> +    succeed; any failures result in exit code 1. Cannot be used with
>> +    `--output-commands`.
>
> Rather than having two incompatible options perhaps we could have a 
> single "--update-refs=(yes|print|allow-partial-updates)" argument. I 
> think the name "--allow-partial" is rather ambiguous as it does not 
> say what it is allowing to be partial.


After thinking about this and Elijah's feedback, I am leaning toward
dropping --allow-partial entirely since I don't have a concrete use case
for it. That simplifies things to just: default atomic updates vs
--output-commands for the traditional pipeline.

Would you still prefer a --update-refs=<mode> style, or is the simpler
--output-commands flag sufficient given that --allow-partial is going away?


>
>> +static int add_ref_to_transaction(struct ref_transaction *transaction,
>> +                  const char *refname,
>> +                  const struct object_id *new_oid,
>> +                  const struct object_id *old_oid,
>> +                  struct strbuf *err)
>> +{
>> +    return ref_transaction_update(transaction, refname, new_oid, 
>> old_oid,
>> +                      NULL, NULL, 0, "git replay", err);
>> +}
>
> I'm not sure this function adds much value. I think it would be better 
> to instead have a helper function that updates refs or prints the ref 
> updates so that we do not duplicate that code in the two places below.


ood point. I will extract a helper like:

     static int handle_ref_update(int output_commands,
                                  struct ref_transaction *transaction,
                                  const char *refname,
                                  const struct object_id *new_oid,
                                  const struct object_id *old_oid,
                                  struct strbuf *err)

This eliminates the duplication and fixes the over-long lines you pointed
out at both call sites.

Thanks!


>
>> @@ -434,10 +481,18 @@ int cmd_replay(int argc,
>>               if (decoration->type == DECORATION_REF_LOCAL &&
>>                   (contained || strset_contains(update_refs,
>>                                 decoration->name))) {
>> -                printf("update %s %s %s\n",
>> -                       decoration->name,
>> - oid_to_hex(&last_commit->object.oid),
>> -                       oid_to_hex(&commit->object.oid));
>> +                if (output_commands) {
>> +                    printf("update %s %s %s\n",
>> +                           decoration->name,
>> + oid_to_hex(&last_commit->object.oid),
>> + oid_to_hex(&commit->object.oid));
>> +                } else if (add_ref_to_transaction(transaction, 
>> decoration->name,
>> + &last_commit->object.oid,
>> +                                  &commit->object.oid,
>> +                                  &transaction_err) < 0) {
>> +                    ret = error(_("failed to add ref update to 
>> transaction: %s"), transaction_err.buf);
>> +                    goto cleanup;
>> +                }
>>               }
>
> The lines here are very long due to the indentation, having a separate 
> function to update the refs or print the ref updates would be much 
> more readable.
>
>>               decoration = decoration->next;
>>           }
>> @@ -445,10 +500,33 @@ int cmd_replay(int argc,
>>         /* In --advance mode, advance the target ref */
>>       if (result.clean == 1 && advance_name) {
>> -        printf("update %s %s %s\n",
>> -               advance_name,
>> -               oid_to_hex(&last_commit->object.oid),
>> -               oid_to_hex(&onto->object.oid));
>> +        if (output_commands) {
>> +            printf("update %s %s %s\n",
>> +                   advance_name,
>> +                   oid_to_hex(&last_commit->object.oid),
>> +                   oid_to_hex(&onto->object.oid));
>> +        } else if (add_ref_to_transaction(transaction, advance_name,
>> +                          &last_commit->object.oid,
>> +                          &onto->object.oid,
>> +                          &transaction_err) < 0) {
>> +            ret = error(_("failed to add ref update to transaction: 
>> %s"), transaction_err.buf);
>> +            goto cleanup;
>> +        }
>> +    }
>
> Putting the code to update the refs or print the ref updates into a 
> single function would avoid this duplication and over-long lines.
>
> Thanks
>
> Phillip
>
>> +    /* Commit the ref transaction if we have one */
>> +    if (transaction && result.clean == 1) {
>> +        if (ref_transaction_commit(transaction, &transaction_err)) {
>> +            if (allow_partial) {
>> +                warning(_("some ref updates failed: %s"), 
>> transaction_err.buf);
>> + ref_transaction_for_each_rejected_update(transaction,
>> +                                     print_rejected_update, NULL);
>> +                ret = 0; /* Set failure even with allow_partial */
>> +            } else {
>> +                ret = error(_("failed to update refs: %s"), 
>> transaction_err.buf);
>> +                goto cleanup;
>> +            }
>> +        }
>>       }
>>         merge_finalize(&merge_opt, &result);
>> @@ -457,9 +535,17 @@ int cmd_replay(int argc,
>>           strset_clear(update_refs);
>>           free(update_refs);
>>       }
>> -    ret = result.clean;
>> +
>> +    /* Handle empty ranges: if no commits were processed, treat as 
>> success */
>> +    if (!commits_processed)
>> +        ret = 1; /* Success - no commits to replay is not an error */
>> +    else
>> +        ret = result.clean;
>>     cleanup:
>> +    if (transaction)
>> +        ref_transaction_free(transaction);
>> +    strbuf_release(&transaction_err);
>>       release_revisions(&revs);
>>       free(advance_name);
>>   diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>> index 58b3759935..8b4301e227 100755
>> --- a/t/t3650-replay-basics.sh
>> +++ b/t/t3650-replay-basics.sh
>> @@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
>>   '
>>     test_expect_success 'using replay to rebase two branches, one on 
>> top of other' '
>> -    git replay --onto main topic1..topic2 >result &&
>> +    git replay --output-commands --onto main topic1..topic2 >result &&
>>         test_line_count = 1 result &&
>>   @@ -67,9 +67,30 @@ test_expect_success 'using replay to rebase two 
>> branches, one on top of other' '
>>       test_cmp expect result
>>   '
>>   +test_expect_success 'using replay with default atomic behavior (no 
>> output)' '
>> +    # Create a test branch that wont interfere with others
>> +    git branch atomic-test topic2 &&
>> +    git rev-parse atomic-test >atomic-test-old &&
>> +
>> +    # Default behavior: atomic ref updates (no output)
>> +    git replay --onto main topic1..atomic-test >output &&
>> +    test_must_be_empty output &&
>> +
>> +    # Verify the branch was updated
>> +    git rev-parse atomic-test >atomic-test-new &&
>> +    ! test_cmp atomic-test-old atomic-test-new &&
>> +
>> +    # Verify the history is correct
>> +    git log --format=%s atomic-test >actual &&
>> +    test_write_lines E D M L B A >expect &&
>> +    test_cmp expect actual
>> +'
>> +
>>   test_expect_success 'using replay on bare repo to rebase two 
>> branches, one on top of other' '
>> -    git -C bare replay --onto main topic1..topic2 >result-bare &&
>> -    test_cmp expect result-bare
>> +    git -C bare replay --output-commands --onto main topic1..topic2 
>> >result-bare &&
>> +
>> +    # The result should match what we got from the regular repo
>> +    test_cmp result result-bare
>>   '
>>     test_expect_success 'using replay to rebase with a conflict' '
>> @@ -86,7 +107,7 @@ test_expect_success 'using replay to perform basic 
>> cherry-pick' '
>>       # 2nd field of result is refs/heads/main vs. refs/heads/topic2
>>       # 4th field of result is hash for main instead of hash for topic2
>>   -    git replay --advance main topic1..topic2 >result &&
>> +    git replay --output-commands --advance main topic1..topic2 
>> >result &&
>>         test_line_count = 1 result &&
>>   @@ -102,7 +123,7 @@ test_expect_success 'using replay to perform 
>> basic cherry-pick' '
>>   '
>>     test_expect_success 'using replay on bare repo to perform basic 
>> cherry-pick' '
>> -    git -C bare replay --advance main topic1..topic2 >result-bare &&
>> +    git -C bare replay --output-commands --advance main 
>> topic1..topic2 >result-bare &&
>>       test_cmp expect result-bare
>>   '
>>   @@ -115,7 +136,7 @@ test_expect_success 'replay fails when both 
>> --advance and --onto are omitted' '
>>   '
>>     test_expect_success 'using replay to also rebase a contained 
>> branch' '
>> -    git replay --contained --onto main main..topic3 >result &&
>> +    git replay --output-commands --contained --onto main 
>> main..topic3 >result &&
>>         test_line_count = 2 result &&
>>       cut -f 3 -d " " result >new-branch-tips &&
>> @@ -139,12 +160,12 @@ test_expect_success 'using replay to also 
>> rebase a contained branch' '
>>   '
>>     test_expect_success 'using replay on bare repo to also rebase a 
>> contained branch' '
>> -    git -C bare replay --contained --onto main main..topic3 
>> >result-bare &&
>> +    git -C bare replay --output-commands --contained --onto main 
>> main..topic3 >result-bare &&
>>       test_cmp expect result-bare
>>   '
>>     test_expect_success 'using replay to rebase multiple divergent 
>> branches' '
>> -    git replay --onto main ^topic1 topic2 topic4 >result &&
>> +    git replay --output-commands --onto main ^topic1 topic2 topic4 
>> >result &&
>>         test_line_count = 2 result &&
>>       cut -f 3 -d " " result >new-branch-tips &&
>> @@ -168,7 +189,7 @@ test_expect_success 'using replay to rebase 
>> multiple divergent branches' '
>>   '
>>     test_expect_success 'using replay on bare repo to rebase multiple 
>> divergent branches, including contained ones' '
>> -    git -C bare replay --contained --onto main ^main topic2 topic3 
>> topic4 >result &&
>> +    git -C bare replay --output-commands --contained --onto main 
>> ^main topic2 topic3 topic4 >result &&
>>         test_line_count = 4 result &&
>>       cut -f 3 -d " " result >new-branch-tips &&
>> @@ -217,4 +238,131 @@ test_expect_success 
>> 'merge.directoryRenames=false' '
>>           --onto rename-onto rename-onto..rename-from
>>   '
>>   +# Tests for new default atomic behavior and options> > 
>> +test_expect_success 'replay default behavior should not produce 
> output when successful' '
>> +    git replay --onto main topic1..topic3 >output &&
>> +    test_must_be_empty output
>> +'
>> +
>> +test_expect_success 'replay with --output-commands produces 
>> traditional output' '
>> +    git replay --output-commands --onto main topic1..topic3 >output &&
>> +    test_line_count = 1 output &&
>> +    grep "^update refs/heads/topic3 " output
>> +'
>> +
>> +test_expect_success 'replay with --allow-partial should not produce 
>> output when successful' '
>> +    git replay --allow-partial --onto main topic1..topic3 >output &&
>> +    test_must_be_empty output
>> +'
>> +
>> +test_expect_success 'replay fails when --output-commands and 
>> --allow-partial are used together' '
>> +    test_must_fail git replay --output-commands --allow-partial 
>> --onto main topic1..topic2 2>error &&
>> +    grep "cannot be used together" error
>> +'
>> +
>> +test_expect_success 'replay with --contained updates multiple 
>> branches atomically' '
>> +    # Create fresh test branches based on the original structure
>> +    # contained-topic1 should be contained within the range to 
>> contained-topic3
>> +    git branch contained-base main &&
>> +    git checkout -b contained-topic1 contained-base &&
>> +    test_commit ContainedC &&
>> +    git checkout -b contained-topic3 contained-topic1 &&
>> +    test_commit ContainedG &&
>> +    test_commit ContainedH &&
>> +    git checkout main &&
>> +
>> +    # Store original states
>> +    git rev-parse contained-topic1 >contained-topic1-old &&
>> +    git rev-parse contained-topic3 >contained-topic3-old &&
>> +
>> +    # Use --contained to update multiple branches - this should 
>> update both
>> +    git replay --contained --onto main 
>> contained-base..contained-topic3 &&
>> +
>> +    # Verify both branches were updated
>> +    git rev-parse contained-topic1 >contained-topic1-new &&
>> +    git rev-parse contained-topic3 >contained-topic3-new &&
>> +    ! test_cmp contained-topic1-old contained-topic1-new &&
>> +    ! test_cmp contained-topic3-old contained-topic3-new
>> +'
>> +
>> +test_expect_success 'replay atomic behavior: all refs updated or 
>> none' '
>> +    # Store original state
>> +    git rev-parse topic4 >topic4-old &&
>> +
>> +    # Default atomic behavior
>> +    git replay --onto main main..topic4 &&
>> +
>> +    # Verify ref was updated
>> +    git rev-parse topic4 >topic4-new &&
>> +    ! test_cmp topic4-old topic4-new &&
>> +
>> +    # Verify no partial state
>> +    git log --format=%s topic4 >actual &&
>> +    test_write_lines J I M L B A >expect &&
>> +    test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'replay works correctly with bare repositories' '
>> +    # Test atomic behavior in bare repo (important for Gitaly)
>> +    git checkout -b bare-test topic1 &&
>> +    test_commit BareTest &&
>> +
>> +    # Test with bare repo - replay the commits from main..bare-test 
>> to get the full history
>> +    git -C bare fetch .. bare-test:bare-test &&
>> +    git -C bare replay --onto main main..bare-test &&
>> +
>> +    # Verify the bare repo was updated correctly (no output)
>> +    git -C bare log --format=%s bare-test >actual &&
>> +    test_write_lines BareTest F C M L B A >expect &&
>> +    test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'replay --allow-partial with no failures 
>> produces no output' '
>> +    git checkout -b partial-test topic1 &&
>> +    test_commit PartialTest &&
>> +
>> +    # Should succeed silently even with partial mode
>> +    git replay --allow-partial --onto main topic1..partial-test 
>> >output &&
>> +    test_must_be_empty output
>> +'
>> +
>> +test_expect_success 'replay maintains ref update consistency' '
>> +    # Test that traditional vs atomic produce equivalent results
>> +    git checkout -b method1-test topic2 &&
>> +    git checkout -b method2-test topic2 &&
>> +
>> +    # Both methods should update refs to point to the same replayed 
>> commits
>> +    git replay --output-commands --onto main topic1..method1-test 
>> >update-commands &&
>> +    git update-ref --stdin <update-commands &&
>> +    git log --format=%s method1-test >traditional-result &&
>> +
>> +    # Direct atomic method should produce same commit history
>> +    git replay --onto main topic1..method2-test &&
>> +    git log --format=%s method2-test >atomic-result &&
>> +
>> +    # Both methods should produce identical commit histories
>> +    test_cmp traditional-result atomic-result
>> +'
>> +
>> +test_expect_success 'replay error messages are helpful and clear' '
>> +    # Test that error messages are clear
>> +    test_must_fail git replay --output-commands --allow-partial 
>> --onto main topic1..topic2 2>error &&
>> +    grep "cannot be used together" error
>> +'
>> +
>> +test_expect_success 'replay with empty range produces no output and 
>> no changes' '
>> +    # Create a test branch for empty range testing
>> +    git checkout -b empty-test topic1 &&
>> +    git rev-parse empty-test >empty-test-before &&
>> +
>> +    # Empty range should succeed but do nothing
>> +    git replay --onto main empty-test..empty-test >output &&
>> +    test_must_be_empty output &&
>> +
>> +    # Branch should be unchanged
>> +    git rev-parse empty-test >empty-test-after &&
>> +    test_cmp empty-test-before empty-test-after
>> +'
>> +
>>   test_done
>
