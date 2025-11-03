Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05CE1D7E31
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198333; cv=none; b=eMyA+QK0vPEwaJi3wQH3rOgZZ7Ulbx0gvLRill2ukLYNDvpQi08i4yAMI7YkCimwEOmjIfLQdLobg1eBb6OtajNcSeDKnYMGJAN24x3SD3gJ9mcD7XszPFcGrFzRRZzMx4YmOG2KnEul+EIdgD2CMGrYXquymo4lOfkuX2PeMA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198333; c=relaxed/simple;
	bh=kesSmZaPhtyhQpwWXGrUc/VHiO5jHrtOPqK4+zDYn24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9zpr0WY6ftDW3AyMKAuO2v+/da4nHA/roq0StM9h1QrUfqr7DmKU3exft0dnb0yRUOCRB3sR+0bjzTflEwP8lBRS67rfaj5duvOWoYKe70YEWDqrfhwWpJtQr+ATYZFb7LeZuE/AELFCRhQR49BEA4r7xqr18tvskwsDT+fS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQvaa8V8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQvaa8V8"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27c369f8986so48550785ad.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 11:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762198331; x=1762803131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7xap71DlTFMkHV5gy6cGPclti8Uz1eMZjIsJAkP5yo=;
        b=cQvaa8V80JSHzoJqPmKO3MFvVVKmDUPoiUV7ddJ4fl9MCuPcm+6BMdZcq1ZkD+sWRX
         4B+IXZlV6tLHrun0mPZtL0PT851Ek+tKxeOmMl8iv/BKkUtdtlTs5dVwjk49LiUTE2GM
         m0vpEUIVC9jX4THos0b9eivWAroXIzKZI4/sERTenHMZLutojVow6gZGtMsNK0LTiY4q
         DshDWQ3nwNo0LzIPSXeCSzSOUBU7adtwqLacBbJkomAadSkMTjy3OFk0EICa/kcrO4WV
         FMR5j8n/4nr5g1Z/70VlBi3jHVQEecv+uFF3epRfu3cMmq4HelbusOkTVlFzbaBQdn3y
         6GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762198331; x=1762803131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7xap71DlTFMkHV5gy6cGPclti8Uz1eMZjIsJAkP5yo=;
        b=c2wY8lqku71muUurFOoccaGEW+K2MVbVpHKYJHdYgUOreaaESLj+1StWalv7rUGqVg
         MFQ/qAdExLRiMv6WpeLjZSScx9cmQUmUsq0RnSKMpY+4vH+XuLSkwoAe1apZfVcGnkcO
         8uoDxqM5Iey3jfgpTdEb8rHrBHr3nd3elWEvkREzCEJbRgzbdcx+MWL6hxqRFFypakq5
         +7R8qqvNUM7C+tT1lP26Kx1c8JsKzLCmbCVuoWjilxI+kZos3sfup+679snmhzv2oPuE
         s/7uvGRDGhCpefzaX0cGRELiE1xzxiX/PKjFa0cL2vtToLqJyJU8mi0C/NYq27OXfjuJ
         EW5w==
X-Forwarded-Encrypted: i=1; AJvYcCVDUelDa+dDh1ZIXonaPGPnrAG6Q8migY+tWSUftjWHJsbYzqf8gIqeP+iD3KsHEGgHm4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq8Njy5MZsW8Pw2U0IampQ3EU+srl8dgVD0rmeOqVA9/1hWH51
	CmYRrg+NbTkGgdaWa9GexzCOt192Zh83rjMEVcB+yi6MKTkjsMJUDW7i
X-Gm-Gg: ASbGncvY/LX5WkdjHiOATJBfZAVkYJQLE2nrmEcrofdYQTsNqLaVu94zW01sTxYmJ8A
	HYTwEk8eWJzsjvMlZ2o/wGjdg4Fqx+Yx2TZLYZe6cF2WiO8K683lpX/kkPgRToGNRXGW8VcMNnH
	i2lKWiC74RAUwEFpo4NHav6wUuj7DhPJQqbq7V+c270/MLRPlCTC6JB8L+mc/9ead8YOje/n+Gg
	zTQlcc5mgT5rb2KATdcLMPh2nk0VQX06ayHlnOYitN78UrGUk5TAJG2vzwl9eGAJMuDRLo0b17o
	374Uwgzw0Ei1xkfpcYgG1rMfY5Sez3vLJ/aoppHCC20Xttx5eqlKwoJ6yukjdaz3TL9qjzzlhyI
	+tmbVBExUdoMB5vvZgydpTBFplKvLJPJ+tdBydOPaieO/Xpx7bto24VrgEqdXrW8Du9X54WuipG
	2kBlEPGDpm/vaChfFsS7v98eK3BkUUiLee6U0aR9aR6UdXsY7o+oTyJ3wvK6BMZHDh06z5BMPt8
	FbaW6y3MRGRRXqF1s/ZL5+nfyw3ujKFOsb74ZBOz1CJMR1cBaw4pm1lCPpHA9JLmA1y9lwBMGf4
X-Google-Smtp-Source: AGHT+IFCZdEG6DgY+ncQBg4s3jqdH6uM+oxbiSpFaxYyPOBUJCztV6SeaNASoWqthhilulqeIKsFRg==
X-Received: by 2002:a17:903:a86:b0:295:1a5c:355a with SMTP id d9443c01a7336-2951a5c36d6mr181984285ad.61.1762198330864;
        Mon, 03 Nov 2025 11:32:10 -0800 (PST)
Received: from ?IPV6:2409:40e3:177:42ef:ddb9:5107:4bd3:5bf1? ([2409:40e3:177:42ef:ddb9:5107:4bd3:5bf1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2953ea0dc8esm112951425ad.43.2025.11.03.11.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 11:32:10 -0800 (PST)
Message-ID: <55e6620a-bf38-4c34-8d52-75d838ba087a@gmail.com>
Date: Tue, 4 Nov 2025 01:02:03 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] replay: make atomic ref updates the default
 behavior
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: christian.couder@gmail.com, newren@gmail.com, gitster@pobox.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-3-siddharthasthana31@gmail.com>
 <a7f9c31b-2342-405e-848d-08b9de837dc6@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <a7f9c31b-2342-405e-848d-08b9de837dc6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/11/25 21:55, Phillip Wood wrote:
> Hi Siddharth
>
> On 30/10/2025 19:19, Siddharth Asthana wrote:
>
>> +    case REF_ACTION_UPDATE:
>> +        return ref_transaction_update(transaction, refname, new_oid, 
>> old_oid,
>> +                          NULL, NULL, 0, "git replay", err);
>
> I wonder if we should use a more descriptive reflog message here that 
> says what git replay was doing. For example "git replay --onto 
> <new-base> <revs>" could include the new base in the reflog message 
> like "git rebase" does. For "git replay --advance" we could include 
> the commits that have been picked. It would be helpful to test the 
> reflog message in the new tests as well.
>
> Thanks
>
> Phillip


Hi Phillip,

Thanks for the suggestion! I agree that a more descriptive reflog
message would be helpful for users tracking what happened.

I looked at how `git rebase` constructs its reflog messages (it uses
something like "rebase (finish): refs/heads/feature onto abc123def")
and I'm thinking of using a simpler format for replay:

     "replay --onto main"
     "replay --advance main"

This shows the mode and target in a way that mirrors what the user
typed. I chose to use the symbolic name (e.g., "main") rather than
the commit SHA because it seems more user-friendly, though I notice
git rebase uses oid_to_hex().

Regarding "include the commits that have been picked" for --advance
mode - would you prefer:
   - The revision range as specified by the user (e.g., "topic1..topic2")?
   - Just the target branch like I have above?

The revision range would provide more context, but it might make the
reflog message quite long if the user specified something complex. I'm
happy to include it if that's what you think would be most useful.

I'll add tests for the reflog messages in both modes.

Thanks,
Siddharth


>
>
>> +    default:
>> +        BUG("unknown ref_action_mode %d", mode);
>> +    }
>> +}
>> +
>>   int cmd_replay(int argc,
>>              const char **argv,
>>              const char *prefix,
>> @@ -294,6 +321,8 @@ int cmd_replay(int argc,
>>       struct commit *onto = NULL;
>>       const char *onto_name = NULL;
>>       int contained = 0;
>> +    const char *ref_action_str = NULL;
>> +    enum ref_action_mode ref_action = REF_ACTION_UPDATE;
>>         struct rev_info revs;
>>       struct commit *last_commit = NULL;
>> @@ -302,12 +331,14 @@ int cmd_replay(int argc,
>>       struct merge_result result;
>>       struct strset *update_refs = NULL;
>>       kh_oid_map_t *replayed_commits;
>> +    struct ref_transaction *transaction = NULL;
>> +    struct strbuf transaction_err = STRBUF_INIT;
>>       int ret = 0;
>>   -    const char * const replay_usage[] = {
>> +    const char *const replay_usage[] = {
>>           N_("(EXPERIMENTAL!) git replay "
>>              "([--contained] --onto <newbase> | --advance <branch>) "
>> -           "<revision-range>..."),
>> +           "[--ref-action[=<mode>]] <revision-range>..."),
>>           NULL
>>       };
>>       struct option replay_options[] = {
>> @@ -319,6 +350,9 @@ int cmd_replay(int argc,
>>                  N_("replay onto given commit")),
>>           OPT_BOOL(0, "contained", &contained,
>>                N_("advance all branches contained in revision-range")),
>> +        OPT_STRING(0, "ref-action", &ref_action_str,
>> +               N_("mode"),
>> +               N_("control ref update behavior (update|print)")),
>>           OPT_END()
>>       };
>>   @@ -333,6 +367,18 @@ int cmd_replay(int argc,
>>       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>>                     contained, "--contained");
>>   +    /* Default to update mode if not specified */
>> +    if (!ref_action_str)
>> +        ref_action_str = "update";
>> +
>> +    /* Parse ref action mode */
>> +    if (!strcmp(ref_action_str, "update"))
>> +        ref_action = REF_ACTION_UPDATE;
>> +    else if (!strcmp(ref_action_str, "print"))
>> +        ref_action = REF_ACTION_PRINT;
>> +    else
>> +        die(_("unknown --ref-action mode '%s'"), ref_action_str);
>> +
>>       advance_name = xstrdup_or_null(advance_name_opt);
>>         repo_init_revisions(repo, &revs, prefix);
>> @@ -389,6 +435,17 @@ int cmd_replay(int argc,
>>       determine_replay_mode(repo, &revs.cmdline, onto_name, 
>> &advance_name,
>>                     &onto, &update_refs);
>>   +    /* Initialize ref transaction if using update mode */
>> +    if (ref_action == REF_ACTION_UPDATE) {
>> +        transaction = 
>> ref_store_transaction_begin(get_main_ref_store(repo),
>> +                              0, &transaction_err);
>> +        if (!transaction) {
>> +            ret = error(_("failed to begin ref transaction: %s"),
>> +                    transaction_err.buf);
>> +            goto cleanup;
>> +        }
>> +    }
>> +
>>       if (!onto) /* FIXME: Should handle replaying down to root 
>> commit */
>>           die("Replaying down to root commit is not supported yet!");
>>   @@ -434,10 +491,15 @@ int cmd_replay(int argc,
>>               if (decoration->type == DECORATION_REF_LOCAL &&
>>                   (contained || strset_contains(update_refs,
>>                                 decoration->name))) {
>> -                printf("update %s %s %s\n",
>> -                       decoration->name,
>> - oid_to_hex(&last_commit->object.oid),
>> -                       oid_to_hex(&commit->object.oid));
>> +                if (handle_ref_update(ref_action, transaction,
>> +                              decoration->name,
>> +                              &last_commit->object.oid,
>> +                              &commit->object.oid,
>> +                              &transaction_err) < 0) {
>> +                    ret = error(_("failed to update ref '%s': %s"),
>> +                            decoration->name, transaction_err.buf);
>> +                    goto cleanup;
>> +                }
>>               }
>>               decoration = decoration->next;
>>           }
>> @@ -445,10 +507,23 @@ int cmd_replay(int argc,
>>         /* In --advance mode, advance the target ref */
>>       if (result.clean == 1 && advance_name) {
>> -        printf("update %s %s %s\n",
>> -               advance_name,
>> -               oid_to_hex(&last_commit->object.oid),
>> -               oid_to_hex(&onto->object.oid));
>> +        if (handle_ref_update(ref_action, transaction, advance_name,
>> +                      &last_commit->object.oid,
>> +                      &onto->object.oid,
>> +                      &transaction_err) < 0) {
>> +            ret = error(_("failed to update ref '%s': %s"),
>> +                    advance_name, transaction_err.buf);
>> +            goto cleanup;
>> +        }
>> +    }
>> +
>> +    /* Commit the ref transaction if we have one */
>> +    if (transaction && result.clean == 1) {
>> +        if (ref_transaction_commit(transaction, &transaction_err)) {
>> +            ret = error(_("failed to commit ref transaction: %s"),
>> +                    transaction_err.buf);
>> +            goto cleanup;
>> +        }
>>       }
>>         merge_finalize(&merge_opt, &result);
>> @@ -460,6 +535,9 @@ int cmd_replay(int argc,
>>       ret = result.clean;
>>     cleanup:
>> +    if (transaction)
>> +        ref_transaction_free(transaction);
>> +    strbuf_release(&transaction_err);
>>       release_revisions(&revs);
>>       free(advance_name);
>>   diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>> index 58b3759935..123734b49f 100755
>> --- a/t/t3650-replay-basics.sh
>> +++ b/t/t3650-replay-basics.sh
>> @@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
>>   '
>>     test_expect_success 'using replay to rebase two branches, one on 
>> top of other' '
>> -    git replay --onto main topic1..topic2 >result &&
>> +    git replay --ref-action=print --onto main topic1..topic2 >result &&
>>         test_line_count = 1 result &&
>>   @@ -68,7 +68,7 @@ test_expect_success 'using replay to rebase two 
>> branches, one on top of other' '
>>   '
>>     test_expect_success 'using replay on bare repo to rebase two 
>> branches, one on top of other' '
>> -    git -C bare replay --onto main topic1..topic2 >result-bare &&
>> +    git -C bare replay --ref-action=print --onto main topic1..topic2 
>> >result-bare &&
>>       test_cmp expect result-bare
>>   '
>>   @@ -86,7 +86,7 @@ test_expect_success 'using replay to perform 
>> basic cherry-pick' '
>>       # 2nd field of result is refs/heads/main vs. refs/heads/topic2
>>       # 4th field of result is hash for main instead of hash for topic2
>>   -    git replay --advance main topic1..topic2 >result &&
>> +    git replay --ref-action=print --advance main topic1..topic2 
>> >result &&
>>         test_line_count = 1 result &&
>>   @@ -102,7 +102,7 @@ test_expect_success 'using replay to perform 
>> basic cherry-pick' '
>>   '
>>     test_expect_success 'using replay on bare repo to perform basic 
>> cherry-pick' '
>> -    git -C bare replay --advance main topic1..topic2 >result-bare &&
>> +    git -C bare replay --ref-action=print --advance main 
>> topic1..topic2 >result-bare &&
>>       test_cmp expect result-bare
>>   '
>>   @@ -115,7 +115,7 @@ test_expect_success 'replay fails when both 
>> --advance and --onto are omitted' '
>>   '
>>     test_expect_success 'using replay to also rebase a contained 
>> branch' '
>> -    git replay --contained --onto main main..topic3 >result &&
>> +    git replay --ref-action=print --contained --onto main 
>> main..topic3 >result &&
>>         test_line_count = 2 result &&
>>       cut -f 3 -d " " result >new-branch-tips &&
>> @@ -139,12 +139,12 @@ test_expect_success 'using replay to also 
>> rebase a contained branch' '
>>   '
>>     test_expect_success 'using replay on bare repo to also rebase a 
>> contained branch' '
>> -    git -C bare replay --contained --onto main main..topic3 
>> >result-bare &&
>> +    git -C bare replay --ref-action=print --contained --onto main 
>> main..topic3 >result-bare &&
>>       test_cmp expect result-bare
>>   '
>>     test_expect_success 'using replay to rebase multiple divergent 
>> branches' '
>> -    git replay --onto main ^topic1 topic2 topic4 >result &&
>> +    git replay --ref-action=print --onto main ^topic1 topic2 topic4 
>> >result &&
>>         test_line_count = 2 result &&
>>       cut -f 3 -d " " result >new-branch-tips &&
>> @@ -168,7 +168,7 @@ test_expect_success 'using replay to rebase 
>> multiple divergent branches' '
>>   '
>>     test_expect_success 'using replay on bare repo to rebase multiple 
>> divergent branches, including contained ones' '
>> -    git -C bare replay --contained --onto main ^main topic2 topic3 
>> topic4 >result &&
>> +    git -C bare replay --ref-action=print --contained --onto main 
>> ^main topic2 topic3 topic4 >result &&
>>         test_line_count = 4 result &&
>>       cut -f 3 -d " " result >new-branch-tips &&
>> @@ -217,4 +217,32 @@ test_expect_success 
>> 'merge.directoryRenames=false' '
>>           --onto rename-onto rename-onto..rename-from
>>   '
>>   +test_expect_success 'default atomic behavior updates refs directly' '
>> +    # Store original state for cleanup
>> +    test_when_finished "git branch -f topic2 topic1" &&
>> +
>> +    # Test default atomic behavior (no output, refs updated)
>> +    git replay --onto main topic1..topic2 >output &&
>> +    test_must_be_empty output &&
>> +
>> +    # Verify ref was updated
>> +    git log --format=%s topic2 >actual &&
>> +    test_write_lines E D M L B A >expect &&
>> +    test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'atomic behavior in bare repository' '
>> +    # Test atomic updates work in bare repo
>> +    git -C bare replay --onto main topic1..topic2 >output &&
>> +    test_must_be_empty output &&
>> +
>> +    # Verify ref was updated in bare repo
>> +    git -C bare log --format=%s topic2 >actual &&
>> +    test_write_lines E D M L B A >expect &&
>> +    test_cmp expect actual &&
>> +
>> +    # Reset for other tests
>> +    git -C bare update-ref refs/heads/topic2 $(git -C bare rev-parse 
>> topic1)
>> +'
>> +
>>   test_done
>
