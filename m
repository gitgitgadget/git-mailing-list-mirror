Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A5131BDE
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258515; cv=none; b=CzJoGsdwuoPOMp9xN/MIvNQyK1RZ3RQOvfG3eA5GFrCwItXH/dBdsD34KPtIr837h2jvNbyutPsUs9gn2sEGng7535rfNCLZLtygPLAhy36LGMZ3Cu6Ag509QIhlhwiM1zOgfoNLodysHGuk0NPlB5A1PMgd/qNL1Q2q/ZAMGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258515; c=relaxed/simple;
	bh=ufjXhmjxU+1zrUPSbMq5KZEig4uS3pO8D/qq0UuVWE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtTCmKCrVWySQhM1SmkK5ameHw5MIy3HXvoO7YxbYfnpFWXBlKflTR7YK/bZ1ieT2tF1OqIIR7WL7U+57MxxTdttZ3npIdRR0A3QiYteKtRon6cKEreg3D5w7/9oJtq5/jX9mprmhXIlqBUxzQ1ohqS91Ez0dDzOtNemoSf/sjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjreDdhD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjreDdhD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41629b9b85eso8833745e9.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712258511; x=1712863311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y3t1wpPPNTGFSL9I5aN7NC+TSeHRlA1TkHyhHVyvWzQ=;
        b=IjreDdhD5/7oB7wwOAWRO7VVeSef8bqQEtMFwhLPX5EqrQQa6hLI5BHZdtqeuJX/+i
         mBhOzolUP7f8TGQBqkYfs80TmsEAv6dSemW42Jvd3ZmVHeWBxOdKHqeW80AG5HHie+ed
         ST8NB0RAt6nfAE3NXuLjpZDkfRx7s0gbzoNkdwlgzaH51BBGTuhn403xgp7QpFrgVYOu
         Q+/cp9WIPLl56B82BqzyCcoxpL7DA20MS5oizPQUh+a5XMjzW5OZdjYHlSAlAnP7vnIM
         m+UwY9UzHzt6gjCxAGEnEBqEU81177FM3l/LJwSpY35f9yfUeHgZ8H6tf0oUB098Aa/9
         nnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258511; x=1712863311;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3t1wpPPNTGFSL9I5aN7NC+TSeHRlA1TkHyhHVyvWzQ=;
        b=Phx/M4ZjvGXKU19pZr7XQB1zN4niQ6ousNFuUBkfTwGIUTRCZMMAGFwIOlt8Humrkc
         vHQnkpPn/kHTw4P0DsUu+bhJ2zeXeOQYl9C1PtzDEErtyA3XPPqBdqrxdv9VT5h5d2S0
         sJ5ZHaNvxyUAokF6T45+dsrwhZns6rHJUi7euN+KxxKMgaV0u8NSJeLXc8iPyxxo2Jiv
         Z2xxz5ztC/VTHMOdC0cxh83OKwDD2Y/DHopWuNEljzLMKZGIyVlmuWzUki3ZtkSymn5n
         LVLKOK6/JLEQR5wl9RNNIIX8hTJM4scCznN+DwUGFYKBmh/gpjiJPL/Y95dVWTc64D/f
         1r5Q==
X-Gm-Message-State: AOJu0YyM1F7UG/XNWYZp5cFkaAYjaz5vvsnMDjkqaZ6bA6hV66ssOI8g
	b1gT5AXJYGpsCuXeiiTTm03IM6fTi3gpGCnTuh09X2fhF8LmMDe2
X-Google-Smtp-Source: AGHT+IE/iNUfW1+5iQ/J66Y4jccSK6dK1lcHlf/mqvfHM+WjSDYb0MX68Yc9yi2VbHBWi96qVYI9OQ==
X-Received: by 2002:a05:600c:3ca7:b0:414:d8f:4399 with SMTP id bg39-20020a05600c3ca700b004140d8f4399mr2834332wmb.18.1712258510793;
        Thu, 04 Apr 2024 12:21:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id jg24-20020a05600ca01800b004162d5233d5sm160611wmb.42.2024.04.04.12.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:21:50 -0700 (PDT)
Message-ID: <a80a5aa9-34f4-4bfe-9e32-7b5e878554ba@gmail.com>
Date: Thu, 4 Apr 2024 20:21:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: honor signoff opt in run_git_commit
To: Junio C Hamano <gitster@pobox.com>,
 David Bimmler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, David Bimmler <david.bimmler@isovalent.com>
References: <pull.1707.git.1712223572933.gitgitgadget@gmail.com>
 <xmqqzfu914jc.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqzfu914jc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2024 17:22, Junio C Hamano wrote:
> "David Bimmler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: David Bimmler <david.bimmler@isovalent.com>
>>
>> When rebasing interactively, --signoff would not take effect for commits
>> which conflict. That is, commits applying cleanly would be signed off,
>> but commits requiring intervention would miss the sign off trailer.
> 
> Good finding.

Yes, thanks for posting this patch.

>> The reason is that run_git_commit did not check for the signoff replay
>> opt, and hence even though the option was picked up and passed
>> correctly, the actual committing dropped the ball.
> 
> We record and read back the initial "--signoff" given from the
> command line (and options.signoff from the "options sheet" when not
> REPLAY_INTERACTIVE_REBASE) in opts->signoff, but that piece of
> information is used only to decide if we call append_signoff().
> When do_commit(), after try_to_commit() punts, calls "git commit",
> the invocation lacks "--signoff" on the command line.
> 
>      Side note: the "let's avoid spawning 'git commit' and duplicate
>      it in-process" codepath in try_to_commit() does not seem to pay
>      attention to opts->signoff at all, and it does not do the
>      append_signoff() to add the trailer.  Is this something this
>      patch needs to fix as well, or am I misreading the control flow
>      (e.g., perhaps opts->signoff is set we somehow refrain from
>      doing the "let's do it in-process" logic)?

I think it is more complicated than that. We do not use the "--signoff" 
option of "git commit" because we do not want to append the 
"Signed-off-by:" trailer when processing "fixup" and "squash" commands. 
The trailer is appended to the commit message by the sequencer in 
do_pick_commits(). The problem is that when we commit a conflict 
resolution we end up using the original commit message rather than the 
file containing the commit message that we would have used if we had not 
stopped for conflicts. I've got some patches which need their commit 
messages cleaning up at 
https://github.com/phillipwood/git/commits/wip/fix-rebase-signoff-with-conflicts/ 
which use the correct file when committing conflict resolutions. I'll 
try and clean them up next week.

Best Wishes

Phillip

> If we forgot to tell "git commit" that we want the result
> signed-off, of course it would not add the trailer.  Perhaps
> 
>      -correctly, the actual committing dropped the ball"
>      +correctly to run_git_commit(), it failed to pass it to
>      +underlying 'git commit'
> 
> is less misleading.
> 
>> The patch adds a test specifically for this case, as well as amending a
>> squash test which codified the broken behaviour.
> 
> "The patch adds" -> "Add"
> 
> I love this kind of test update that corrects a mistaken expectation
> after a careful analysis of how the commands should behave.
> 
> Very good job.  Nicely done.
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index fa838f264f5..16595e26a17 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1121,6 +1121,8 @@ static int run_git_commit(const char *defmsg,
>>   		strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>>   	else
>>   		strvec_push(&cmd.args, "--no-gpg-sign");
>> +	if (opts->signoff)
>> +		strvec_push(&cmd.args, "--signoff");
>>   	if (defmsg)
>>   		strvec_pushl(&cmd.args, "-F", defmsg, NULL);
>>   	else if (!(flags & EDIT_MSG))
> 
> This is straight-forward and obviously correct.
> 
>> diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
>> index e1b1e947647..fcecdf41978 100755
>> --- a/t/t3428-rebase-signoff.sh
>> +++ b/t/t3428-rebase-signoff.sh
>> @@ -27,6 +27,13 @@ first
>>   Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
>>   EOF
>>   
>> +# Expected signed off message after resolving the conflict
>> +cat >expected-signed-after-conflict <<EOF
>> +update file on side
>> +
>> +Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
>> +EOF
>> +
> 
> The t3428 script uses ancient style to prepare these expectations
> outside the test_expect_success blocks, and following the pattern
> is fine (until we clean-up the style of the whole script).  Cleaning
> it up is better done as a separate series, and when the dust settles
> after this fix lands.  #leftoverbits
> 
>>   # Expected commit message after rebase without --signoff (or with --no-signoff)
>>   cat >expected-unsigned <<EOF
>>   first
>> @@ -82,4 +89,30 @@ test_expect_success 'rebase -m --signoff fails' '
>>   	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
>>   	test_cmp expected-signed actual
>>   '
>> +
>> +test_expect_success 'rebase -i signs commits even if a conflict occurs' '
>> +	git branch -M main &&
>> +
>> +	git branch side &&
>> +	echo "b" >file &&
>> +	git add file &&
>> +	git commit -m"update file" &&
> 
> Have a SP between "-m" and its value, imitating existing tests.
> 
>> +	test_tick &&
> 
> Why?  Does the rest of the test depend on commits to have different
> timestamps?
> 
> If you want to use test_tick, the pattern to follow is to call it
> _before_ creating a commit, not after.  Up to this point in the
> original script nobody calls it (or test_commit that by default
> calls it), so "test_tick && git_commit" would be OK.
> 
> But if there is no dependency on exact sequence of timestamps,
> letting the commit share the same initial timestamp (hardcoded in
> test-lib.sh for better reproducibility) is more preferable, as use
> of test_tick sends a wrong message that the test results may be
> affected by the exact timestamps.
> 
>> +	test_must_fail git rebase -i --signoff main &&
>> +
>> +	echo "merged" >file &&
>> +	git add file &&
>> +	git rebase --continue &&
>> +
>> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
>> +	test_cmp expected-signed-after-conflict actual
> 
> Running any git command on the left hand side of a pipe is frowned
> upon, as it will hide exit status from it when it fails.
> 
> In this case, the primary thing we care about is that we have added
> the sign off that did not exist in the original, so I wonder
> 
> 	git cat-file commit HEAD >actual &&
> 	test_grep "Signed-off-by: " actual
> 
> would be sufficient?
> 
>> +'
>> +
>>   test_done
>> diff --git a/t/t3437/expected-squash-message b/t/t3437/expected-squash-message
>> index ab2434f90ed..d74af0bcf6b 100644
>> --- a/t/t3437/expected-squash-message
>> +++ b/t/t3437/expected-squash-message
>> @@ -48,4 +48,6 @@ edited 1
>>   edited 2
>>   
>>   edited 3
>> +
>> +Signed-off-by: Rebase Committer <rebase.committer@example.com>
>>   squashed
> 
> This defines the expected outcome from
> 
>      git rebase -ik --signoff A
> 
> in t3437-rebase-fixup-options.sh; I am not sure if the location the
> sign-off is inserted is sensible, though.
> 
> Thanks.
> 
