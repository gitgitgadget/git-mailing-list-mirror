Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F503A5E79
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412791; cv=none; b=J9pdKjhiscKDxooSZx5GJyq8u5zBAsAlu+gRHQwXY1Ee09bkWig557yQrZhLoJCo6MihcI8WRndEvsXpF+Ed8hV9lw+aawUqgYXJk6L4tCajsVURI3cvMLrqM3qczAxoprKddQ1NQ+PxKYe4WwdrA7LwSfCaLoWmTlVnY6zDdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412791; c=relaxed/simple;
	bh=h8daBG5MggDFkcXhqK9G0kcX7LDpffIFzqoD+Vx/+ic=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=joA7Opdu2U2DwTkPZP4VK9+4Q2duZBVCOhwGFqXlTvcEsMY2rMoxmxpw8LBbaB1S76AAUJrROur+4e1w+8T+qvjvSqe8Mxq2YHLVRdl0eLlluSlAeuoJOgqr2KOlE+gs4Nqmf3DgwvurowkmvNdrL+1pyF+a9bPhV+nsG+z+n5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyb1dlvH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyb1dlvH"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso2350339f8f.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773412788; x=1774017588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nunWrkO+NvqpPF+t9xI1GiLX0ZEeq/zH8mhD4NOk8Xg=;
        b=Zyb1dlvHIH47uhOmOrPlqK8Wc3SH/0ra7zVFih53hlz4227Vouy7U3LliN++SQJNm9
         m3/ZK44u6/UMuhlB2HbijHhplHKZ4PZmIyzfCaGUImv5BCw2ngdR+D/M/ZPTwVXkewfF
         STXXAQ/wGlK07oS24qMWlkFEx5bpiWnzPQrOBUJREC4jPO/HS6sR9eRa9GXz+cNnlk/v
         POFe3cWJOATFc8m251Fag3etnmO0oyeruI9YbzEa4e3DasK0oyBVUpkGP1Gc70/H9mV/
         X9KhYV9P26x0BQZF1nHbEMPWHDHSwraef56QN83oxSwqN8B6eXNVnZ8kQkaqtzp761EU
         GWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412788; x=1774017588;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nunWrkO+NvqpPF+t9xI1GiLX0ZEeq/zH8mhD4NOk8Xg=;
        b=Nim8GpW8cUYz31uamixyw8xuQDqC//26HxQvTIsB6HGXXjczJPA1g91YwPceQXiC9g
         zuBaufUzUSTx54iWFMFpRVf0AbK6MnFqgwV92W2UfBtyZ6hGiqvGkOjUw1pGF504qbAb
         zD9z5N5D8FSoHvYxr8z/OlAtZ0qP3cMY1rN/m9gW8qTWYXvWZB+uf+KrOH9qh3P2U0iT
         eBd+7l2c3TXTxyHFwjsLedlWezK+0YipFc791ghQcSamgUKvZROn25ppoKdC0dNMj+px
         7II9S5fRtkNV+sMaxo3i9w1x0dlT2xaoFv7oCvosXARYtB2hZXpwz2c1bFmNXCU096TE
         Hubg==
X-Forwarded-Encrypted: i=1; AJvYcCW/7VnTeUK7zhjVIW8wKEPYYe0yaghCwp08RL95GTGfsZTnp0cR3J94L2KcMXnAqVeYSSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIaBU0eDXye5soFxu1gguUo7iCUUJseLr4Rg0bUU45kHvj2dun
	LjL0wgiYEitoKZNahKA8z5swZfItVxUsmVLgqN3/5TA9fLIcozPVyY2msO4ZEg==
X-Gm-Gg: ATEYQzzoDIurdMoj2v9/ht1daGW6SSHNKW2EFEY7YasFo6DUIrFsNDgQqxqyM4MPcVi
	/cdAOeTsIuU5+vppzH38xgcNCahcmCBuHN/Cc0wfjeuuByi+ch7eNtX/FqjmCYVL2fhIUa6oBk3
	c5xv58ExARUOEkvs4HDLdmU7Xr8kILaYg3KzX4DQVS7e5sQuVgHADv4FgUwWhyMpImMuBiiWNQC
	KdWtfXaxPUrgc7B/nibhM39yHNUdMpUwaBrD6FIcPa/WbNCssopwP0XRtfZLDcz0Tur1yPYp5VR
	OBl9ek3eo2FBqC+430TrBEiJ8skz92hb2nU8p3G4Zu9ywvA5ogGI3MoN/nA6JyfJGFeXqUbTlIH
	PNAOPHAntygaM4DI51mNGDYevIf+L0rlq+lBdQsM23G75yO+ePukhiP643Ejuzrt6AKVpg1ixSP
	i+ZgTFYu0ea2KcKDlO2oZP66o5yfxNt4gfpVvrGuNOMFRJ2LAWIdVd+Fn6yVALCGE99deuRc7sf
	ZMXMQ==
X-Received: by 2002:a05:6000:1a8f:b0:439:b7c9:2ef0 with SMTP id ffacd0b85a97d-43a04db4b7amr6874684f8f.33.1773412787686;
        Fri, 13 Mar 2026 07:39:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19ad9asm18780722f8f.7.2026.03.13.07.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 07:39:47 -0700 (PDT)
Message-ID: <3b2b67b1-3748-4a95-9882-30e4ba349922@gmail.com>
Date: Fri, 13 Mar 2026 14:39:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] add: support pre-add hook
Reply-To: phillip.wood@dunelm.org.uk
To: Chandra <Chandrakr@pm.me>, Junio C Hamano <gitster@pobox.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org,
 Ben Knoble <ben.knoble@gmail.com>
References: <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com>
 <pull.2045.v5.git.1772714253412.gitgitgadget@gmail.com>
 <87o6l2xuku.fsf@collabora.com> <xmqqwlzq2i96.fsf@gitster.g>
 <Mas-XsZDLQf822y8cXTnllJLDJcd9vU8jRd7i4tj-7pCw90hurfkTos1piH-zF-g9A-IPM2sIZoXac1MB2yHn9oU-nX9kaLeuI9bXWp3Fbw=@pm.me>
Content-Language: en-US
In-Reply-To: <Mas-XsZDLQf822y8cXTnllJLDJcd9vU8jRd7i4tj-7pCw90hurfkTos1piH-zF-g9A-IPM2sIZoXac1MB2yHn9oU-nX9kaLeuI9bXWp3Fbw=@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2026 02:20, Chandra wrote:
> 
>> I'm struggling to see how it is helpful to the user for "git add
>> --dry-run $path" to succeed when "git add $path" will be rejected
> 
> The --dry-run on commit also skips the pre-commit hook
 > (builtin/commit.c returns early at the dry_run check before
 > run_commit_hook is reached). Pre-add follows the same convention. As I
 > understand it, --dry-run answers what would be staged without side
 > effects, including hooks.

I was surprised that "git commit --dry-run" ignores the pre-commit hook. 
Looking at the history before "--dry-run" was introduced users had to 
run "git status" to see what would be committed. When "--dry-run" was 
introduced it was intended to replicate the output "git status", then 
"git status" was expanded to provide more information rather than just 
what would be committed. That explains why "--dry-run" does not run the 
pre-commit hook but the end result is that it is less useful than it 
could be and I don't think we should repeat that for the pre-add hook.


> I can see the argument for running the hook during --dry-run so users
 > can preview rejections. After all, git push --dry-run runs the pre
 > push hook. If the consensus is that pre-add should diverge from pre
 > commit here and follow pre-push, I'm happy to add that, but I think it
 > would be better for consistent --dry-run hooking to be a separate
 > patch series applied to both add and commit.

Maybe but as the "git commit --dry-run" behavior is sub-optimal it might 
be better to avoid repeating that. As you say it is already in 
consistent with "git push --dry-run".

>> The other options all use "git apply" to apply a diff to the index
>> so they could apply the patch to a temporary index which is then
>> passed to the "pre-add" hook. If the hook fails the user should be
>> given the option to re-edit the patch or re-select the hunks so
>> that their work is not wasted.
> 
> pre-commit has the same gap as `git commit --interactive` and
 > `git commit --patch` run interactive staging and then the pre-commit
 > hook runs on the result. If the hook rejects, the user's interactive
 > selections are lost with no re-edit prompt.>
> I think it's a good idea to add retry/re-edit UX for --interactive
 > and --patch, but it would be new behavior. IMO, it makes sense to keep
 > v1 of pre-add consistent with how pre-commit works today, and do a
 > follow-up series for re-edit support in both hooks.

The pre-commit hook is run for --iteractive and --patch though which the 
pre-add hook isn't so they are not consistent. I agree that the re-edit 
support could come later.

>> To me this hook would be much more useful if it also checked
>> changes staged by "git commit"
> 
> This is essentially asking pre-add to become a universal pre-staging
 > hook, which I was fully in favor of earlier in this conversation.
 > However, that is a much larger scope than intended for this patch
 > series, as each of the git commit staging integrations have their own
 > codepaths in prepare_index(). The pre-commit hook already covers the
 > commit-time check, and the default pre-applypatch hook runs pre-commit
 > for the same reason. I'm open to these changes, but I don't think it
 > makes sense within the scope of this patch series.

I can see it is more work, but I'm not convinced that a pre-add hook 
implemented with all the caveats that are in this series without a 
concrete plan to fill those gaps adds much value. It leaves us with a 
very confusing UI.

>> If we don't enforce them being read-only people will write hooks
>> that update them just as they do for "pre-commit" hooks.
> 
> True, while the documentation says it should be treated as
 > read-only, there's no enforcement here. On the other hand, if users
 > are doing this for pre-commit, maybe it's better they're not read-only
 > because there are use cases for that affordance? I'm not sure about
 > whether to actually force it to be read-only or to allow users to do
 > what they do with pre-commit hooks.
I think our comment to supporting pre-commit hooks that update the index 
has been a bit patchy. It would be better to either commit to allowing 
the "pre-add" hook to update the index (after thinking about the future 
implications of that) or enforce it to be read-only.

Thanks

Phillip

>> We should be explicit that the proposed index state contains all
>> the changes that would be committed so staging changes
>> incrementally will check them multiple times.
> 
> Yes.
> 
>> I would be more accurate to say that it is not invoked by
>> `git commit` at all
> 
> Also yes.
> 
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> 
>> Maybe add a test or two which define the pre-add hook via configs
> 
> I see now that what I thought was a redundant codepath test earlier was actually not.
> 
> The hook.<name>.event / hook.<name>.command config infrastructure is in `next` but hasn't graduated to `master` yet. I'll write that test once ar/config-hooks lands in `master` but I'm sure functionally it will work because of the switch you suggested from find_hook() to hook_exists().
> 
>> The turnaround in minutes between v4 -> v5 is also surprising.
> 
> Understood. I can wait for more review feedback before sending new updates.
> 
> I will note that I personally handtype every line of test, code, and docs that I commit although I use Claude and Codex for assistance and recommendations. They have been invaluable aids since this is my first contribution and I don't have extensive experience with git internals. I'm sure I make mistakes due to being a neophyte here (and frankly I wouldn't claim C or shell in the top 5 languages I'm skilled/experienced with). I believe AI Disclosure is an ethical requirement, particularly in an open-source code base like this, in spite of reputational risks. If it induces reviewers to be more stringent, that is good, because it reduces the likelihood of mistakes passing through.
> 
> I am grateful for everyone's feedback. I believe this change is needed and will help a lot of users (including myself) who currently use weird workarounds like aliases to shell scripts. Pushback is essential for quality and surfacing opportunities for improvement. Thank you for the time spent reviewing these changes.
> 
> Chandra Kethi-Reddy
> @archonphronesis:matrix.org
> 
> Sent with Proton Mail secure email.
> 

