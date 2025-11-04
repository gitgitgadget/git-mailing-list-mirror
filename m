Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0D32ED52
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272930; cv=none; b=eXLnLMqMm+q0ZLpDTCuaRsI+fqo+fwHF2ZhVqU3xZXwsSG+LmEvKHpJ9/wbeXX/3iRO+pi9osCtsUunT54KWxcr2QAuu0mHzZycuOhPQOMTMSdHP1ve9S3FzEBSsLUwCE4g2z40/FUYkQzuFBHFfGWsnzec2RD1V/OeagyD6Rh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272930; c=relaxed/simple;
	bh=/7KmQSgsEmhWYT0iFXRw4hiB6vOF/oBooGVIl8NUerU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cGZxW1g9M4YIaLzb6jdz2Ef75WQqJxaPgs5CzCbG11QnD3cXvJPyDOBozrN29cbRJ+aZK7HiyXFweVVjZ8K1CPZMIwMZNGTE8MOwAHRq0Yqe6qGzaevbK4NSVaM2JJiRkKTXWbEuDL9Rr9ce0N1+ijHdsLmwAvFdJQHUEjZaxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj5Olk7Y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj5Olk7Y"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475dae5d473so6661415e9.2
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762272926; x=1762877726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/eixHrIrF0zdl5KFcGFWbC+wl2hVexC2hOr0BPfgPo=;
        b=lj5Olk7YcvUWj8YYees1H+f9WEyP+hGVN+O8jo7RFJ6qW1KcbTyAHI/J5efLOAi8lc
         3ARQwk6xUC1jc5yNyuzLndUJUElLX9mRVdHMbjkvaK5JIsHXPo5x3Tj/DcpMY0aVXOTi
         80dURNDZB84t57tlyGd/85tmusdk+wUfoyPqWAqfAzb25qybDNI32Dbo9M3Lhq+maHkj
         Eao/9IIf/PbVgasdI36YAylEI5FNdDviqrhE13ClV9clfaDsFs7vGcNjz8HZs77hMV9r
         BClBGTnUajKfbjGoVoBbARWjXN2wfjLHL/F92b+MvJ37j0lAGLprqQQ8MXS96sU28sDI
         jP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272926; x=1762877726;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/eixHrIrF0zdl5KFcGFWbC+wl2hVexC2hOr0BPfgPo=;
        b=OgIFYy8AitpehkAB6QB/vXTsW/kiikB1xNl9eew7Yl1+dqb+NalvulMhQ1hL9kA7C8
         tGPHQWdqexSTQJclAQYclDMFTB8e+vgeqiAG6KsnL3hzx2M84Vwpf3xq9SvzrqQ7nAFm
         P5Z857TvB6bZUe1jUl5y32MX8F1RTe2Cad98M1IxhgOVv6yQTgMElTZ0Ln61MzyU8ijn
         WNkhsNMkULbZiZb1ShXKKmnNUIfU//qH+91F4mY0hZeUDveWCT1f1PzjB5JUH+Yo0YDW
         JcTQ2mJuivD4QnOakhja0gd7HUfTQqvRW+f5RQDe4JCrcuJnUvFDoGeRjJ7tCOWGPHOU
         9OWw==
X-Forwarded-Encrypted: i=1; AJvYcCW09hgIQ5Fg+QzYIpvVXblwtjFvgBurj9HEYS8OQOxABV3z1BgsDwE6gA6p1adPlfQyOAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9NH4rJev8aWMz+5gfd9cqEqgn2RL+jRaUkwVamxIwk5C/FQf
	6KRcJdUQ8CAQqpOVFwErYCtkiFmkC6u9gDVzvCojcFp6PbFjH2nlDYG3
X-Gm-Gg: ASbGnctA7Dy6rFSa2+NRzgmbtI4mYS7xi/G0xcILBGsPW/hEuRWTmCTjLDwq965GCGA
	MAPcS3fBWUwklMWu4ZvbtB5dNy4uhK2JrSqMhStmI3wxSr8QbQ3GNMowtzoANPu6kuctdYVKjAV
	tphQPshLajlTQxRkaPP4q3NW+zHCO8srQ5rz0KUnTZP3hcA6RcG1Oh++0XtBQUC/VZbwaHLRkbO
	l2b6a9vViM66CNr7klrcBVoQ5V5AGFzYzVXxm0QajFJMlCE+4ZBZ46KgR31gkNEoQZ40LQfV1CU
	LwDkmRy33m28omcDRTdHAa3uns3PN/Oyj6WbFVyXgBLylBV/iLfkFfkxdvzc5Q2kE7vnkk0VYKK
	fvxGx68rDCUpU2PHfvrTuiEM81cKNp/Y1v6+KQxBE9BRmE53K5Vz/t7wBwy6HdZam6/MBqRQ/lz
	K9rcZ+s5IiN+Cc4+Jw7ifUuavRjX8ZolA+Q6koCg2WIh/D9BzZraS2wjc+f5ZtqIg=
X-Google-Smtp-Source: AGHT+IGIOyb1RenUAEAPaB6PNebZmwHVmcRedE7xWFMTrrFziElQlmnrThENmCWWy6zo9akmFArFGA==
X-Received: by 2002:a05:600c:8b6b:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-477307c1fc6mr187115225e9.8.1762272925539;
        Tue, 04 Nov 2025 08:15:25 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec43sm258266995e9.9.2025.11.04.08.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:15:24 -0800 (PST)
Message-ID: <f5cc5082-d3d0-4ec3-ac0e-56e2ad4ef23c@gmail.com>
Date: Tue, 4 Nov 2025 16:15:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 2/3] replay: make atomic ref updates the default
 behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>,
 phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: christian.couder@gmail.com, newren@gmail.com, gitster@pobox.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-3-siddharthasthana31@gmail.com>
 <a7f9c31b-2342-405e-848d-08b9de837dc6@gmail.com>
 <55e6620a-bf38-4c34-8d52-75d838ba087a@gmail.com>
Content-Language: en-US
In-Reply-To: <55e6620a-bf38-4c34-8d52-75d838ba087a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Siddarth

On 03/11/2025 19:32, Siddharth Asthana wrote:
> 
> I looked at how `git rebase` constructs its reflog messages (it uses
> something like "rebase (finish): refs/heads/feature onto abc123def")
> and I'm thinking of using a simpler format for replay:
> 
>      "replay --onto main"
>      "replay --advance main"
> 
> This shows the mode and target in a way that mirrors what the user
> typed.

That makes sense

> I chose to use the symbolic name (e.g., "main") rather than
> the commit SHA because it seems more user-friendly, though I notice
> git rebase uses oid_to_hex().

One thing to note is that using oid_to_hex() tells us which commit we 
rebased on to. Using "main" means it is hard to find exactly which 
commit was used because you have to dig through the reflog for "main" to 
find where it was pointing at the time that "replay" was run.

> Regarding "include the commits that have been picked" for --advance
> mode - would you prefer:
>    - The revision range as specified by the user (e.g., "topic1..topic2")?
>    - Just the target branch like I have above?
> 
> The revision range would provide more context, but it might make the
> reflog message quite long if the user specified something complex. I'm
> happy to include it if that's what you think would be most useful.

The full revision range could certainly get quite long. "git 
cherry-pick" creates one reflog entry per picked commit which avoids 
that problem. I don't think we necessarily want "git replay" to create 
masses of reflog entries though so perhaps we should use the revision 
range if it is simple like "a..b" and something more general if it is 
more complex than that?

> I'll add tests for the reflog messages in both modes.

That's great

Thanks

Phillip

> Thanks,
> Siddharth
> 
> 
>>
>>
>>> +    default:
>>> +        BUG("unknown ref_action_mode %d", mode);
>>> +    }
>>> +}
>>> +
>>>   int cmd_replay(int argc,
>>>              const char **argv,
>>>              const char *prefix,
>>> @@ -294,6 +321,8 @@ int cmd_replay(int argc,
>>>       struct commit *onto = NULL;
>>>       const char *onto_name = NULL;
>>>       int contained = 0;
>>> +    const char *ref_action_str = NULL;
>>> +    enum ref_action_mode ref_action = REF_ACTION_UPDATE;
>>>         struct rev_info revs;
>>>       struct commit *last_commit = NULL;
>>> @@ -302,12 +331,14 @@ int cmd_replay(int argc,
>>>       struct merge_result result;
>>>       struct strset *update_refs = NULL;
>>>       kh_oid_map_t *replayed_commits;
>>> +    struct ref_transaction *transaction = NULL;
>>> +    struct strbuf transaction_err = STRBUF_INIT;
>>>       int ret = 0;
>>>   -    const char * const replay_usage[] = {
>>> +    const char *const replay_usage[] = {
>>>           N_("(EXPERIMENTAL!) git replay "
>>>              "([--contained] --onto <newbase> | --advance <branch>) "
>>> -           "<revision-range>..."),
>>> +           "[--ref-action[=<mode>]] <revision-range>..."),
>>>           NULL
>>>       };
>>>       struct option replay_options[] = {
>>> @@ -319,6 +350,9 @@ int cmd_replay(int argc,
>>>                  N_("replay onto given commit")),
>>>           OPT_BOOL(0, "contained", &contained,
>>>                N_("advance all branches contained in revision-range")),
>>> +        OPT_STRING(0, "ref-action", &ref_action_str,
>>> +               N_("mode"),
>>> +               N_("control ref update behavior (update|print)")),
>>>           OPT_END()
>>>       };
>>>   @@ -333,6 +367,18 @@ int cmd_replay(int argc,
>>>       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>>>                     contained, "--contained");
>>>   +    /* Default to update mode if not specified */
>>> +    if (!ref_action_str)
>>> +        ref_action_str = "update";
>>> +
>>> +    /* Parse ref action mode */
>>> +    if (!strcmp(ref_action_str, "update"))
>>> +        ref_action = REF_ACTION_UPDATE;
>>> +    else if (!strcmp(ref_action_str, "print"))
>>> +        ref_action = REF_ACTION_PRINT;
>>> +    else
>>> +        die(_("unknown --ref-action mode '%s'"), ref_action_str);
>>> +
>>>       advance_name = xstrdup_or_null(advance_name_opt);
>>>         repo_init_revisions(repo, &revs, prefix);
>>> @@ -389,6 +435,17 @@ int cmd_replay(int argc,
>>>       determine_replay_mode(repo, &revs.cmdline, onto_name, 
>>> &advance_name,
>>>                     &onto, &update_refs);
>>>   +    /* Initialize ref transaction if using update mode */
>>> +    if (ref_action == REF_ACTION_UPDATE) {
>>> +        transaction = 
>>> ref_store_transaction_begin(get_main_ref_store(repo),
>>> +                              0, &transaction_err);
>>> +        if (!transaction) {
>>> +            ret = error(_("failed to begin ref transaction: %s"),
>>> +                    transaction_err.buf);
>>> +            goto cleanup;
>>> +        }
>>> +    }
>>> +
>>>       if (!onto) /* FIXME: Should handle replaying down to root 
>>> commit */
>>>           die("Replaying down to root commit is not supported yet!");
>>>   @@ -434,10 +491,15 @@ int cmd_replay(int argc,
>>>               if (decoration->type == DECORATION_REF_LOCAL &&
>>>                   (contained || strset_contains(update_refs,
>>>                                 decoration->name))) {
>>> -                printf("update %s %s %s\n",
>>> -                       decoration->name,
>>> - oid_to_hex(&last_commit->object.oid),
>>> -                       oid_to_hex(&commit->object.oid));
>>> +                if (handle_ref_update(ref_action, transaction,
>>> +                              decoration->name,
>>> +                              &last_commit->object.oid,
>>> +                              &commit->object.oid,
>>> +                              &transaction_err) < 0) {
>>> +                    ret = error(_("failed to update ref '%s': %s"),
>>> +                            decoration->name, transaction_err.buf);
>>> +                    goto cleanup;
>>> +                }
>>>               }
>>>               decoration = decoration->next;
>>>           }
>>> @@ -445,10 +507,23 @@ int cmd_replay(int argc,
>>>         /* In --advance mode, advance the target ref */
>>>       if (result.clean == 1 && advance_name) {
>>> -        printf("update %s %s %s\n",
>>> -               advance_name,
>>> -               oid_to_hex(&last_commit->object.oid),
>>> -               oid_to_hex(&onto->object.oid));
>>> +        if (handle_ref_update(ref_action, transaction, advance_name,
>>> +                      &last_commit->object.oid,
>>> +                      &onto->object.oid,
>>> +                      &transaction_err) < 0) {
>>> +            ret = error(_("failed to update ref '%s': %s"),
>>> +                    advance_name, transaction_err.buf);
>>> +            goto cleanup;
>>> +        }
>>> +    }
>>> +
>>> +    /* Commit the ref transaction if we have one */
>>> +    if (transaction && result.clean == 1) {
>>> +        if (ref_transaction_commit(transaction, &transaction_err)) {
>>> +            ret = error(_("failed to commit ref transaction: %s"),
>>> +                    transaction_err.buf);
>>> +            goto cleanup;
>>> +        }
>>>       }
>>>         merge_finalize(&merge_opt, &result);
>>> @@ -460,6 +535,9 @@ int cmd_replay(int argc,
>>>       ret = result.clean;
>>>     cleanup:
>>> +    if (transaction)
>>> +        ref_transaction_free(transaction);
>>> +    strbuf_release(&transaction_err);
>>>       release_revisions(&revs);
>>>       free(advance_name);
>>>   diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>>> index 58b3759935..123734b49f 100755
>>> --- a/t/t3650-replay-basics.sh
>>> +++ b/t/t3650-replay-basics.sh
>>> @@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
>>>   '
>>>     test_expect_success 'using replay to rebase two branches, one on 
>>> top of other' '
>>> -    git replay --onto main topic1..topic2 >result &&
>>> +    git replay --ref-action=print --onto main topic1..topic2 >result &&
>>>         test_line_count = 1 result &&
>>>   @@ -68,7 +68,7 @@ test_expect_success 'using replay to rebase two 
>>> branches, one on top of other' '
>>>   '
>>>     test_expect_success 'using replay on bare repo to rebase two 
>>> branches, one on top of other' '
>>> -    git -C bare replay --onto main topic1..topic2 >result-bare &&
>>> +    git -C bare replay --ref-action=print --onto main topic1..topic2 
>>> >result-bare &&
>>>       test_cmp expect result-bare
>>>   '
>>>   @@ -86,7 +86,7 @@ test_expect_success 'using replay to perform 
>>> basic cherry-pick' '
>>>       # 2nd field of result is refs/heads/main vs. refs/heads/topic2
>>>       # 4th field of result is hash for main instead of hash for topic2
>>>   -    git replay --advance main topic1..topic2 >result &&
>>> +    git replay --ref-action=print --advance main topic1..topic2 
>>> >result &&
>>>         test_line_count = 1 result &&
>>>   @@ -102,7 +102,7 @@ test_expect_success 'using replay to perform 
>>> basic cherry-pick' '
>>>   '
>>>     test_expect_success 'using replay on bare repo to perform basic 
>>> cherry-pick' '
>>> -    git -C bare replay --advance main topic1..topic2 >result-bare &&
>>> +    git -C bare replay --ref-action=print --advance main 
>>> topic1..topic2 >result-bare &&
>>>       test_cmp expect result-bare
>>>   '
>>>   @@ -115,7 +115,7 @@ test_expect_success 'replay fails when both -- 
>>> advance and --onto are omitted' '
>>>   '
>>>     test_expect_success 'using replay to also rebase a contained 
>>> branch' '
>>> -    git replay --contained --onto main main..topic3 >result &&
>>> +    git replay --ref-action=print --contained --onto main 
>>> main..topic3 >result &&
>>>         test_line_count = 2 result &&
>>>       cut -f 3 -d " " result >new-branch-tips &&
>>> @@ -139,12 +139,12 @@ test_expect_success 'using replay to also 
>>> rebase a contained branch' '
>>>   '
>>>     test_expect_success 'using replay on bare repo to also rebase a 
>>> contained branch' '
>>> -    git -C bare replay --contained --onto main main..topic3 >result- 
>>> bare &&
>>> +    git -C bare replay --ref-action=print --contained --onto main 
>>> main..topic3 >result-bare &&
>>>       test_cmp expect result-bare
>>>   '
>>>     test_expect_success 'using replay to rebase multiple divergent 
>>> branches' '
>>> -    git replay --onto main ^topic1 topic2 topic4 >result &&
>>> +    git replay --ref-action=print --onto main ^topic1 topic2 topic4 
>>> >result &&
>>>         test_line_count = 2 result &&
>>>       cut -f 3 -d " " result >new-branch-tips &&
>>> @@ -168,7 +168,7 @@ test_expect_success 'using replay to rebase 
>>> multiple divergent branches' '
>>>   '
>>>     test_expect_success 'using replay on bare repo to rebase multiple 
>>> divergent branches, including contained ones' '
>>> -    git -C bare replay --contained --onto main ^main topic2 topic3 
>>> topic4 >result &&
>>> +    git -C bare replay --ref-action=print --contained --onto main 
>>> ^main topic2 topic3 topic4 >result &&
>>>         test_line_count = 4 result &&
>>>       cut -f 3 -d " " result >new-branch-tips &&
>>> @@ -217,4 +217,32 @@ test_expect_success 
>>> 'merge.directoryRenames=false' '
>>>           --onto rename-onto rename-onto..rename-from
>>>   '
>>>   +test_expect_success 'default atomic behavior updates refs directly' '
>>> +    # Store original state for cleanup
>>> +    test_when_finished "git branch -f topic2 topic1" &&
>>> +
>>> +    # Test default atomic behavior (no output, refs updated)
>>> +    git replay --onto main topic1..topic2 >output &&
>>> +    test_must_be_empty output &&
>>> +
>>> +    # Verify ref was updated
>>> +    git log --format=%s topic2 >actual &&
>>> +    test_write_lines E D M L B A >expect &&
>>> +    test_cmp expect actual
>>> +'
>>> +
>>> +test_expect_success 'atomic behavior in bare repository' '
>>> +    # Test atomic updates work in bare repo
>>> +    git -C bare replay --onto main topic1..topic2 >output &&
>>> +    test_must_be_empty output &&
>>> +
>>> +    # Verify ref was updated in bare repo
>>> +    git -C bare log --format=%s topic2 >actual &&
>>> +    test_write_lines E D M L B A >expect &&
>>> +    test_cmp expect actual &&
>>> +
>>> +    # Reset for other tests
>>> +    git -C bare update-ref refs/heads/topic2 $(git -C bare rev-parse 
>>> topic1)
>>> +'
>>> +
>>>   test_done
>>

