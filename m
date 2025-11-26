Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6D333E34E
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185217; cv=none; b=kwKJf7UqUUWIYhRr/5jXfD1AMGL5ArhA9YyCcVRXhFm2E6BG86SWY5azj3olnJF4XVUp7sISEpDPD4Eu4yoh5i2i2YGwh5J4JBjVbgMm8e7R8IKbcQdd389ju6WmJNI7GTENNKWC4354a2WH5FMvyvx0uzLMP3pqX2IE9RF0Z7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185217; c=relaxed/simple;
	bh=v1kLN+6v7iFXIrKyNYk/AdqCyYr2IHv8sogniMADzVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZ54xBt4jwUJBtO3jpt6IsiTUYP2jlwh63Y70IBNzG1ffjA2kVn2DKdNR6aN7dLLNNTtqYInWWu3Wc/PZAlVXTpTMdc2Zy+LDk6RKBrxAWGKfjprTcmbbMeH7cBWlD1pvcxxaB29D4ODNRdqoQSuVx0p1HEUHdF04KyJkP3asTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS3RAaEg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS3RAaEg"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297e239baecso9436125ad.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 11:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764185215; x=1764790015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2sGuRbq5zFp0KZ4HEaU7BcsVvD7MBjTRVluo2fn+Nkk=;
        b=QS3RAaEgTLyELwtejAUpmxFuk7/TMKSXvBnThOSfqklMI36XFEgFfJpno/HCVeizlC
         rhqUI8z8KwqE23+lvDatPpyKC4VtOsviKBg/DWnmUQes5VukyZ8PgW2aXjJPRQ5tWrnE
         kG0FctUqmhUVfs45kiyZbFOULnzD2ZasXzIRX4P9JyKF5XVVGz1d563idjq9EQKRAMRG
         wg2Rfr124xRrSpT2t0IUb/heUOKFHYAPIpEfp+1xDEqeeb7ETMwd0BzA5O2yRLD6oOsA
         kQPBIbBPF3mTXbRNgy90yn3RfwpC78UxetR7DjF51LskAGALZnFVpJwjDYdWL8uJa+iK
         HAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185215; x=1764790015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sGuRbq5zFp0KZ4HEaU7BcsVvD7MBjTRVluo2fn+Nkk=;
        b=WNC5k6bG0EFs6ppcEVCT3DCRtB2t7Oc0Oh6xWYmxlgX75FREQKSXyC71zg6+neQMyF
         G08vGIsuPoHq+RHcYixRK/lN+fUk1oLpUTikx8IzOcUnB6mWgtb9ciEHrE1ttBDS8A30
         UzkyWi1nfllQbskDxBLz6Ofcs15/5UpkPMVTcQWoEKMfBf25BtQchU5spXzSYPZcgDZl
         wWr0YzMC8JTlYXa36eGrMuHFZrjG+KQza0Y8VXpBPuV1SKbmiSStj34t/GMq8djKzqby
         5z0ZHEHd98X7mQb11ideeiOYoU83sg5ZMf47nToMJkl1/9G6Nibzwf1HHG22NjfB6lTj
         S9Yw==
X-Gm-Message-State: AOJu0YwKewC9wKtfqAS3uWDwXXBYSIT3L5WoNCSRWtYuMM1RES0hsrPj
	0RwaMyYDJl0tHVjmJQN8Rezb4fImEPW3H3ZrnadExxH+zo38xHjcZkFM
X-Gm-Gg: ASbGncspkVxFu6bhmqUsWwBbZGbI+8bISOk6Ao5e4T45YYmxDyD4Uv2Pp9OAFOPiLo3
	XpJgsm2yhkuMXzteluKQrPx95FNumu45XgX+pgNb3HfnNL7DH0q51ltWxr1xHpVnypKcNuxyB0p
	DLU47zx4l4hw6LX+8Ium42NaPn6SxKZqiG4nncegbMnC0tUP05bxcqvcuOJNgIOs1J20Bz5PpP+
	HnSzwmUX+HL2nexVw+p5J8/KCcB5iY6Y+7GhWSSSmmc5ulI2YIbWJTrBaWWk9c2TiNQaBoalAad
	LqJ9AKGZoYPPtDuAV9NbQCN/ffXXj6AvOA99BOrO2ToujiXUvqNBoA14ZoDq3vSNUJPW4Lwlgq3
	ChQEvyFdc2neidxiRLl6nY8+NhsaZm9rP5lC5Ket7zCfEA5YgGArXkbSn+KtuFSQyHyv0CR5hUg
	acNQDQO3hyXxR+/Ir3qoSvrQkiUM3SjEhWPlGw1KBThmVDsPY6D9ivOBMg/rTKK8D+ENCoOOB4L
	B317GKkkqBI/w7t2XbSoO4=
X-Google-Smtp-Source: AGHT+IGf0H76WR8Ix9RTlHRM5/Vv4ABUjxZGbuJoGswe4GZrKapY+d8mOdOyoqYcpTPTCYxlaYh3yg==
X-Received: by 2002:a17:902:dacb:b0:269:b2e5:900d with SMTP id d9443c01a7336-29b6beebec7mr245590795ad.5.1764185215042;
        Wed, 26 Nov 2025 11:26:55 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:bc94:4b73:d55a:67b2? ([2409:40e3:30a4:b776:bc94:4b73:d55a:67b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b105f79sm201332635ad.20.2025.11.26.11.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:26:54 -0800 (PST)
Message-ID: <706e2875-a3f9-447f-9f43-690990a2342d@gmail.com>
Date: Thu, 27 Nov 2025 00:56:48 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com>
 <xmqqwm3drk6m.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqwm3drk6m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 26/11/25 00:52, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> The revert message generation logic (handling "Revert" and "Reapply"
>> cases) is extracted into a new `sequencer_format_revert_header()`
>> function in `sequencer.c`, which can be shared between `sequencer.c`
>> and `builtin/replay.c`. The `builtin/replay.c` code calls this shared
>> function and then appends the commit OID using `oid_to_hex()` directly,
>> since git replay is designed for simpler server-side operations without
>> the interactive features and `replay_opts` framework used by
>> `sequencer.c`.
> When I review a patch that claims to refactor existing logic into a
> separate helper function to reuse it in more places, I look at the
> diffstat to see how many lines are removed.


You are right - in v1 I added the helper but didn't update 
do_pick_commit() to use it. I have fixed this in my local tree; the 
dedup change is:


     sequencer.c | 14 +-------------
     1 file changed, 1 insertion(+), 13 deletions(-)


> The logic for
> generating the message does not seem to be "extracted into", but
> rather "duplicated to", the new helper function.  It gives the two
> message sources opportunity to drift apart over time, which is not
> what you want.
>
> In do_pick_commit() where TODO_REVERT command is handled, we find a
> code block that is almost identical to what this patch adds to the
> new helper function; it should be rewritten to call the new helper
> function or perhaps a shared helper function is introduced and
> called from there and also from the sequencer_format_revert_header()
> function, if there is still some impedance mismatch.  If such a
> refactoring is done as a separate preliminary patch in a N-patch
> series, the resulting patch series may be easier to follow (and
> there may be other opportunities to reuse existing code more).
>
>> Mark the option as incompatible with `--contained` since reverting
>> changes across multiple branches simultaneously could lead to
>> inconsistent repository states.
> This, and the documentation part, does not seem to tell what
> "inconsistent state" we are worried about.


Elijah's reply clarified this perfectly - `--contained` is a modifier 
for `--onto`, and as he points out, `--revert` should be a new mode 
entirely, not a modifier. Once `--revert` is its own mode (like `--onto` 
and `--advance`), the incompatibility with `--contained` becomes clear:
`--contained` only makes sense with `--onto`.


> Is it just a buggy
> design of --revert can be implemented that produces wrong result
> when used with --contened, or are these two options inherently try
> to achieve contradicting goals?  I am guessing that it is the
> latter, but if so, can we make it clear why?
>
>> +--revert::
>> +	Revert the changes introduced by the commits in the revision range
>> +	instead of applying them. This reverses the diff direction and creates
>> +	new commits that undo the changes, similar to `git revert`.
>> ++
>> +The commit messages are prefixed with "Revert" and include the original
>> +commit SHA. If reverting a commit whose message starts with "Revert", the new
>> +message will start with "Reapply" instead. The author of the new commits
>> +will be the current user, not the original commit author.
>> ++
>> +This option is incompatible with `--contained`.
> I have never used the `--contained` option, but is it so obvious to
> those who have why these two have to be made incompatible that the
> above statement does not have to be followed by "because ..."?
>
>> @@ -141,6 +153,27 @@ all commits they have since `base`, playing them on top of
>>   `origin/main`. These three branches may have commits on top of `base`
>>   that they have in common, but that does not need to be the case.
>>   
>> +To revert a range of commits:
>> +
>> +------------
>> +$ git replay --revert --onto main feature~3..feature
>> +------------
>> +
>> +This creates new commits on top of 'main' that reverse the changes introduced
>> +by the last three commits on 'feature'. The 'feature' branch is updated to
>> +point at the last of these revert commits. The 'main' branch is not updated
>> +in this case.
> Is there any topological requirement between 'main' and 'feature'
> branches?


Yes, and I failed to explain this. For reverts to produce meaningful 
non-empty commits, the commits being reverted should already be in the 
target branch's history. I will clarify the examples to show this 
topology requirement explicitly.


>    Naïvely, I would expect that it would be perfect if
> 'feature' branch has been merged to 'main' (then you'd be reverting
> the top 3 commits of that branch), but that would be something you
> would do to correct 'main', and not 'feature', but the description
> explains this is a way to update 'feature' to lose the three topmost
> commits, so I am not sure what this example really does and when it
> would be useful.
>
>> +To revert commits and advance a branch:
>> +
>> +------------
>> +$ git replay --revert --advance main feature~2..feature
>> +------------
>> +
>> +This reverts the last two commits from 'feature', applies those reverts
>> +on top of 'main', and updates 'main' to point at the result. The 'feature'
>> +branch is not updated in this case.
> The same question.  If I assume that 'main' has merged 'feature'
> before, this I can understand and match what I often do quite well
> while working on integrating topic branches.  I may merge a topic
> that is not yet well cooked enough into 'next', regret that the two
> commits at the tip of the topic were premature, and revert these two
> commits out of 'next', or something.  This example can be explained
> well if there is topological requirement that 'main' has at least
> these two commits from 'feature'.
>
>> @@ -261,7 +286,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
>>   					  kh_oid_map_t *replayed_commits,
>>   					  struct commit *onto,
>>   					  struct merge_options *merge_opt,
>> -					  struct merge_result *result)
>> +					  struct merge_result *result,
>> +					  int is_revert)
> Are there other ways to pick commit imaginable (if not planned to be
> implemented), other than "revert"?  I am wondering if this is better
> done as "enum { CHERRY_PICK, REVERT, } pick_variant" for readability
> and maintainability.


Good point. An enum would be clearer and more maintainable. I wll change 
to `enum replay_action { REPLAY_PICK, REPLAY_REVERT }`.


>
>> @@ -273,21 +299,41 @@ static struct commit *pick_regular_commit(struct repository *repo,
>>   	pickme_tree = repo_get_commit_tree(repo, pickme);
>>   	base_tree = repo_get_commit_tree(repo, base);
>>   
>> -	merge_opt->branch1 = short_commit_name(repo, replayed_base);
>> -	merge_opt->branch2 = short_commit_name(repo, pickme);
>> -	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
>> +	if (is_revert) {
> It may be just me, but it would have been easier to follow if
> !revert case is given first, as that is the common variant the
> pick_regular_commit() function.


Makes sense - the common case (cherry-pick) should come first. I will 
reorder the if/else.


>
>> +		/* For revert: swap base and pickme to reverse the diff */
>> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
>> +		merge_opt->branch2 = xstrfmt("parent of %s", short_commit_name(repo, pickme));
> That is an overly long line (sorry, I notice these things when a
> line does not even fit in 92-col terminal).


Fixed in my local tree by introducing a `pickme_name` variable.


>
>> +		merge_opt->ancestor = short_commit_name(repo, pickme);
>> -	merge_incore_nonrecursive(merge_opt,
>> -				  base_tree,
>> -				  result->tree,
>> -				  pickme_tree,
>> -				  result);
>> +		merge_incore_nonrecursive(merge_opt,
>> +					  pickme_tree,
>> +					  result->tree,
>> +					  base_tree,
>> +					  result);
> OK.  These are applications of the standard 3-way merge trick to
> (ab)use ancestor to implement cherry-pick and revert.  Looking good.
>
>> +
>> +		/* branch2 was allocated with xstrfmt, needs freeing */
>> +		free((char *)merge_opt->branch2);
>> +	} else {
>> +		/* For cherry-pick: normal order */
>> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
>> +		merge_opt->branch2 = short_commit_name(repo, pickme);
>> +		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
>> +
>> +		merge_incore_nonrecursive(merge_opt,
>> +					  base_tree,
>> +					  result->tree,
>> +					  pickme_tree,
>> +					  result);
>> +
>> +		/* ancestor was allocated with xstrfmt, needs freeing */
>> +		free((char *)merge_opt->ancestor);
> And the "else" block has the original sequence of statements.
>
>> +	}
>>   
>> -	free((char*)merge_opt->ancestor);
>>   	merge_opt->ancestor = NULL;
>> +	merge_opt->branch2 = NULL;
> Not a new problem, but what is the point of setting these two (but
> not branch1) to NULL?


You're right, this is inconsistent. The intent is to prevent 
use-after-free, but setting only some fields to NULL is incomplete. I 
will either set all three to NULL or add a comment explaining the rationale.


> If a later caller misuses ->ancestor left
> behind without setting its own, it would result in an access after
> free, but if such a caller misuses ->branch1 left behind without
> setting its own, because it is not allocated, it won't be an access
> after free, *but* it is nevertheless wrong as the string in ->branch1
> is *not* computed suitably for that caller, isn't it?
>
>>   	if (!result->clean)
>>   		return NULL;
>> -	return create_commit(repo, result->tree, pickme, replayed_base);
>> +	return create_commit(repo, result->tree, pickme, replayed_base, is_revert);
>>   }
>
>> @@ -350,6 +396,7 @@ int cmd_replay(int argc,
>>   	int contained = 0;
>>   	const char *ref_action = NULL;
>>   	enum ref_action_mode ref_mode;
>> +	int is_revert = 0;
> Ditto on "revert,cherry-pick".
>
>> diff --git a/sequencer.c b/sequencer.c
>> index 5476d39ba9..e6d82c8368 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -5572,6 +5572,29 @@ int sequencer_pick_revisions(struct repository *r,
>>   	return res;
>>   }
>>   
>> +void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject)
>> +{
>> +	const char *revert_subject;
>> +
>> +	if (skip_prefix(orig_subject, "Revert \"", &revert_subject) &&
>> +	    /*
>> +	     * We don't touch pre-existing repeated reverts, because
>> +	     * theoretically these can be nested arbitrarily deeply,
>> +	     * thus requiring excessive complexity to deal with.
>> +	     */
>> +	    !starts_with(revert_subject, "Revert \"")) {
>> +		strbuf_addstr(out, "Reapply \"");
>> +		strbuf_addstr(out, revert_subject);
>> +		strbuf_addch(out, '\n');
>> +	} else {
>> +		strbuf_addstr(out, "Revert \"");
>> +		strbuf_addstr(out, orig_subject);
>> +		strbuf_addstr(out, "\"\n");
>> +	}
>> +
>> +	strbuf_addstr(out, "\nThis reverts commit ");
>> +}
>> +
> Dedup with do_pick_commit() where this was taken from.  Possibly in
> a separte patch before the main one.


I have applied your suggested patch and will split this into a 2-patch 
series: (1) extract and reuse sequencer_format_revert_header(), (2) add 
--revert to replay.

Thanks,
Siddharth

