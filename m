Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AB28850C
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760504506; cv=none; b=VD2IiyceQ8WDMwWySprC1ET4r8N6mvU9EY9cr3olnhSOTQza0E2dFdB9yITW9Ox2WMLF0yQu98/7fZCnFRhc5D7AosVdWlG0YecZhdiNPG0BC3L/OqrYdGAyoiMb/xfCbfNs1POehkPOj13huQYbeeSw4BQn7lZhAtqGza2AIu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760504506; c=relaxed/simple;
	bh=BOLU/Cs8O17SPmsreHbc0EXr8k8vcGcPnNQgIRAeaQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNhi+BP/NrXEHpTY0wc2701gnyfv3h9aRAvG2NYDE3Iy4fFAbN2BWO+YvLDoZl0Ke/E8X6JYIeg8HoEuVt3vgFX7KOiBGb//3f2r6UrEcUjrBiIkqEyElVYLH906ENmPXnVR3Oh8xrP7Uy3RZNu4YznweOfZ4/nzbIbFjOKVoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MibZ4Xyr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MibZ4Xyr"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-330469eb750so7661035a91.2
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 22:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760504503; x=1761109303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQGQ7NbvCphEEmFixQeoftTyzNm0fRukKYQr1VRrI7I=;
        b=MibZ4XyrmHyOQtI4+vWKL2m2z86SKcHz9xOLgD0z3GpzSaT544luZgNQB9OuYxxfFP
         mIzlJw9zkauy55G5zORrnlY7swszY8efJRdXRqMWLLL5IM11J0ArzafYaUKvWkolq+UT
         zQLZaT6DUo1YzxckFo4fXaV5e/f0yfMd86AWbn05KFj9CQLFy5TTLhMgd7vsSoYVJQ59
         s9yiK6K9imfeR0XsP4P5vO3bo2mjfW8qdXdCeCUKu6vRxgWrj6g0nweSR+B/iOAMhCDU
         4s593IExTrKQbz5NCUQd/Zsf9+wgfj9kBH6l8g+bdNC7NOJa0bssSEn4tL99FgKHvCFu
         boCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760504503; x=1761109303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQGQ7NbvCphEEmFixQeoftTyzNm0fRukKYQr1VRrI7I=;
        b=oy3dgAWc8Ov1jzW3xFggwHiEIdrCtq7iBiZQuKM2Vj4wTqwV0mBQil1vsDjz5o5Z2S
         83WJDmsojFKupIuqQqChOYit7Op1bY6l8+k1e2pPjmHzU3Be8HansUz0wMmi5z6Wo+Hs
         zBm5Agt9oCMuVkc7uKUC7a5I1em6e7D/OEq8BVRmLZvXx6Nc1gsNermTDjX85Tx/aY7r
         H1i9w1VfvDlhb1HygZGB8+y1bSEp1hew0CV7fM+Lv46BjP1v/QXFQaUQ5mDTElLkeilM
         g+WLcsdgmL/oB64hnBYpi6juKKZgwJPZvpbH2DL31XZYVHbg/Xe5Wobj5EBZLvnOt9fV
         Pjkg==
X-Gm-Message-State: AOJu0YztxE1Dfh0UAJhZ6kiKSry0wJXAJOpWCEbZ0OMvvZNUuDbYWBtt
	kPAbgA4IOLt5ROljAHxD+dpIh2xhWhd+snQ/dyywfssS5uEhozj/h7r+
X-Gm-Gg: ASbGncvnRikl5YJ68Kifr7vUlyWLczcKX3Kg/2LzUmPRqzPKAcwBxT7Zk6pfUJxXZfh
	Pzt/1c+c17DELbDqNERKyhflTaWMelUORBUtFQn8xjs/wGNLEwMp7EnQXgG90WcS3E5HfA4QcnV
	ZBg7oGXd1WvXZR81OTS825x2OS9aa1sL4AVeAPbbA9XBEHddqD+J256WR1mJBAwuP/abCSD85nX
	H+dHW2cgwSCuAvZRoxMlrT3UqOpO/I5m0a7CiY/LuuflCgtSYmXCZc7LaKWlIdYRCveNta98VA2
	GBaBYXZzj8dmn4L95EHMCux4S5iDmWPHpO1g4LZHK6zSpjTPA7r/4U2eMOD7Cratd04Q7EfZXv6
	Y3dC/me+PW4iwG9xlx2x4ekCMVENi5ToZomw2eww1XmVQOmrnRysTWBv7ITlRIttLB9Noy4cN20
	i8qdA+2hZ0+PgYQSkx/fqRoJAIAjjByjJ2AMa+Q4f4CPImqgElX31EgBfRSJ2VSzccDvZI1SOU/
	0yjI4uWlWmGVE8IaYwVz0jw8eiRA8I+FlApl3miAuUrS6T+y3799+o=
X-Google-Smtp-Source: AGHT+IEzRqxTpDyV46IFPAvaEOMyriamCMXerP9zHfCxapvVC2P6kj7XTixlTNNRbFX+ku+wyl0/gg==
X-Received: by 2002:a17:90b:224a:b0:336:9dcf:ed14 with SMTP id 98e67ed59e1d1-33b51375a05mr39196353a91.23.1760504503208;
        Tue, 14 Oct 2025 22:01:43 -0700 (PDT)
Received: from ?IPV6:2401:4900:4bc5:7e6f:8524:7259:99ff:16ed? ([2401:4900:4bc5:7e6f:8524:7259:99ff:16ed])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9788457asm787400a91.21.2025.10.14.22.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 22:01:42 -0700 (PDT)
Message-ID: <1065906e-01d2-4b1d-9b43-ce53c5ea9d1b@gmail.com>
Date: Wed, 15 Oct 2025 10:31:35 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251013183311.33329-3-siddharthasthana31@gmail.com>
 <xmqqms5uzcd7.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqms5uzcd7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 14/10/25 03:35, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> For users needing the traditional pipeline workflow, add a new
>> `--update-refs=<mode>` option that preserves the original behavior:
>>
>>    git replay --update-refs=print --onto main topic1..topic2 | git update-ref --stdin
>>
>> The mode can be:
>>    * `yes` (default): Update refs directly using an atomic transaction
>>    * `print`: Output update-ref commands for pipeline use
> Is it only me who still finds this awkward?  A question "update?"
> that gets answered "yes" is quite understandable, but it is not
> immediately obvious what it means to answer "print" to the same
> question.  When the user gives the latter mode as the answer to the
> question, the question being answered is not really "do you want to
> update refs?" at all.
>
> The question the command wants the user to answer is more like "what
> action do you want to see performed on the refs?", isn't it?  The
> user would answer to the question with "please update them" to get
> the default mode, while "please print them" may be the answer the
> user would give to get the useful-for-dry-run-and-development mode.
>
> Perhaps phrase it more like "--ref-action=(update|print)"?  I dunno.


That's a really good point. I was thinking of it as "update refs? 
yes/no" where
"print" meant "don't update", but you're right that it's actually asking a
different question entirely. The real question is "what should we do 
with the
refs?" and the answer is either "update them" or "print the commands".

`--ref-action=(update|print)` is much clearer because:
- It explicitly asks "what action?"
- Both values are verbs that answer that question consistently
- It's immediately obvious what each mode does
- It aligns with the config name discussion in the cover letter thread

I will switch to `--ref-action` in the next version. This also means the 
config
would naturally be `replay.refAction`, which makes the relationship obvious.


>
>>   --advance <branch>::
>>   	Starting point at which to create the new commits; must be a
>>   	branch name.
>>   +
>> -When `--advance` is specified, the update-ref command(s) in the output
>> -will update the branch passed as an argument to `--advance` to point at
>> -the new commits (in other words, this mimics a cherry-pick operation).
>> +When `--advance` is specified, the branch passed as an argument will be
>> +updated to point at the new commits (or an update command will be printed
>> +if `--update-refs=print` is used). This mimics a cherry-pick operation.
> I do not find it clear what the reference to cherry-pick is trying
> to convey.  It is like cherry-picking <something> while the <branch>
> is checked out (hence the branch advances as the result of acquiring
> these commits from <something>)?  Let me see if I understood you by
> attempting to rephrase.
>
>      The history is replayed on top of the <branch> and <branch> is
>      updated to point at the tip of resulting history.


Your phrasing is much better. The cherry-pick comparison was trying to 
contrast
with `--onto` (which doesn't move the target branch), but it ended up 
being more
confusing than helpful. I will use your wording:

     The history is replayed on top of the <branch> and <branch> is
     updated to point at the tip of the resulting history. This is different
     from `--onto`, which uses the target only as a starting point without
     updating it.


>
> But what's the significance of saying so?  Did you want to contrast
> it with "rebase --onto <branch>", i.e. merely specifying the
> starting point without <branch> itself moving as the result?  If so,
> it is probably a notable distinction worth pointing out, but just
> saying "mimics a cherry-pick operation" alone is probably not enough
> to get the intended audience understand what you wanted to tell
> them.
>
>      Side note.  I casually wrote "is updated to point" but with the
>      option not to update (but show the way to update refs), we'd
>      probably need to find a good phrase to express "where the
>      command _wants_ to see the refs pointing at as the result",
>      without referring to who/how the refs are made to point at these
>      points.
>
>> -To simply rebase `mybranch` onto `target`:
>> +To simply rebase `mybranch` onto `target` (default behavior):
> "the default"?


Good catch - I was trying to emphasize that the atomic update behavior 
is now
default, but in the context of showing example commands, "default behavior"
doesn't add clarity. I'll just say "To simply rebase `mybranch` onto 
`target`:"


>
>> diff --git a/builtin/replay.c b/builtin/replay.c
>> index b64fc72063..457225363e 100644
>> --- a/builtin/replay.c
>> +++ b/builtin/replay.c
>> @@ -284,6 +284,26 @@ static struct commit *pick_regular_commit(struct repository *repo,
>>   	return create_commit(repo, result->tree, pickme, replayed_base);
>>   }
>>   
>> +static int handle_ref_update(const char *mode,
>> +			     struct ref_transaction *transaction,
>> +			     const char *refname,
>> +			     const struct object_id *new_oid,
>> +			     const struct object_id *old_oid,
>> +			     struct strbuf *err)
>> +{
>> +	if (!strcmp(mode, "print")) {
>> +		printf("update %s %s %s\n",
>> +		       refname,
>> +		       oid_to_hex(new_oid),
>> +		       oid_to_hex(old_oid));
>> +		return 0;
>> +	}
>> +
>> +	/* mode == "yes" - update refs directly */
>> +	return ref_transaction_update(transaction, refname, new_oid, old_oid,
>> +				      NULL, NULL, 0, "git replay", err);
>> +}
> Hmph, would it be easier to follow if the above is symmetric, i.e.,
>
> 	if (...) {
> 		what happens in the "print" mode
> 	} else {
> 		what happens in the "update ourselves" mode
> 	}
>
> I wonder?
>
> In any case, do not pass mode as "const char *" around in the call
> chain.  Instead, reduce it down to an enum or integer (with CPP
> macro) at the earliest possible place after you saw the command line
> option.  That would allow you to even do
>
> 	switch (ref_action) {
> 	case PRINT_INSN:
> 		printf("update ...");
> 		return 0;
> 	case UPDATE_OURSELVES:
> 		return ref_transaction_update(...);
> 	default:
> 		BUG("Bad ref_action %d", ref_action);
> 	}
>
> to future-proof for the third option.


Perfect, I will convert to an enum right after parse_options(). This 
approach is
much cleaner and prevents typos like "prnit" that the compiler can't catch.
Something like:

     enum ref_action_mode {
         REF_ACTION_UPDATE,
         REF_ACTION_PRINT
     };

Then parse it early:

     if (!strcmp(ref_action_str, "update"))
         ref_action = REF_ACTION_UPDATE;
     else if (!strcmp(ref_action_str, "print"))
         ref_action = REF_ACTION_PRINT;
     else
         die(_("unknown --ref-action mode '%s'"), ref_action_str);

And use the switch statement in handle_ref_update(). This also makes it 
trivial
to add new modes in the future without string comparison overhead throughout
the code.

Thanks for the detailed review!

Siddharth


>
>> +		OPT_STRING(0, "update-refs", &update_refs_mode,
>> +			   N_("mode"),
>> +			   N_("control ref update behavior (yes|print)")),
>>   		OPT_END()
>>   	};
> This one is fine, but then immediately after parse_options()
> returns, do something like
>
> 	if (!strcmp(update_refs_mode, "print"))
> 		ref_action = PRINT_INSN;
> 	else if (!strcmp(update_refs_mode, "yes"))
> 		ref_action = UPDATE_OURSELVES;
> 	else
> 		die(_("unknown option --update-ref='%s'"),
> 		    update_refs_mode);
>
> so that you do not have to keep strcmp() with "print", which risks
> you to mistype "prnit" and no compiler would protect against that.
>
