Received: from mail-ej2-f24.google.com (mail-ej2-f24.google.com [74.125.228.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C7334C155
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085448; cv=none; b=oZDuE4CBlrj0QgP83o7eqKgXg4dw0JCyiS+1/qxn1tyz/83mTzPfLf2f09zVW5Fr+ltHTBWrx8AgbWuw4vG1QJ2WPOWWQpZphy88Ca3W5np7qj+LCdBayUoXxbu+ypd3d+mPyjhMUFFZIK6+jhGYbIqT50eeXC0zQYU0oz0FLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085448; c=relaxed/simple;
	bh=PZhz3sRWclV9VxekIJZ2FU8WX2YOY2vMJq0xrpZx/As=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J6KWmZEwArVCcbl1fh8i4boTv3RYHzreFMcTcF85qcdK+xfVYJgSSstxfSzuYgS2JVzwmKzY4S3g/pKyHbpatRRnZEpneBHEWoKQUb8s8haKLSzszQm1tZBCTlVvHefOILtwdelvw9SDONHzGvd2UdpruB3yQOWtby/U8zZICOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAlm8g/3; arc=none smtp.client-ip=74.125.228.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAlm8g/3"
Received: by mail-ej2-f24.google.com with SMTP id a640c23a62f3a-c29d33431c8so548998766b.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790085444; x=1790690244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B22UVgcJUkT04o3V7jovoJgKfM8nW0Bs1pk4Ks0aEy0=;
        b=gAlm8g/3EF/e2L7kixyytVoSnnW7IMXni6rOyydSiHWnoT9LIRmzUuJMXH/c+CRZgk
         57OKds7RyxKZDGo1FStwH3gFYvfrbwfcfgWyqyiA3HrEi72tWqODZa3u9qdPNoAh7FYp
         z3HLxCE1RjKqkBxucTLOFhMot6E1YxqBCfZcFXQhYtXYDGHrim8UV5FW48LFmmRaAqqC
         Ts5NdsDv5eApjd2tBOn6gYv7HHlOMgo2VxDbl6UQTOA+Epa1JCo1y5MUO1kULMalv7RS
         NUqlj0Q/umBdHSMwgZT/ImjqY0uBMvGM3vRSaUXnlVA0bfpbVn5WJAkcLcyGCc1bDlW+
         1wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085444; x=1790690244;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B22UVgcJUkT04o3V7jovoJgKfM8nW0Bs1pk4Ks0aEy0=;
        b=XJ8TlHcvSYYReNaTWSRgrrjZbx7Jqm/qACBxsrVKQGNUzeOozHSxYndPLw8zhczymr
         XoxgS9xBuQIcV2nrJUMDuYZTHuORCbPjm8x3WMWxQFo/ZeHypyDy2aQiglAetjoacNkd
         FM0tdQxPvky9JXdcTbSmw/NEnSvbRXQaO1kU/wXLqqXAsY1ZQnNbpjV+LRH9NApMTpFE
         UYShq0SrLuk9qi2p00teereaPi3GKgt5hfmjKZG+CUgvmZi2pEdoIUFBsA8PA4uMsVgn
         X+d61lMLk2z3oj41fWNlfQFHyvWvHTQUEeAAxO5Zq+iqSx1M3iAyaFVCGC/uJYhfYSqw
         IG+w==
X-Gm-Message-State: AFuF++laaGgKw4cKEhwTCfpEKt31JpDG4+tB26eTaBzeBpoA4D54qPEH
	ergzqfnyr764GO5ZVIn4Ecl3HYg06W8ezDZj5De0qG7VbBvLD8wAzpwy
X-Gm-Gg: AYBFou14kZmj2CN73ag9+g7Z6/DNjp1IfT7EUiGU9XH4S/xOLauehqWIdXYOB6TWe3T
	+uFtYc+ZbBzCYyV8waenUOJElWXT5oeqrGprtC3VOWAyDOvjA+O5FQf31gYLzE/FU7SiBzQPM/D
	PqcK4pJYaUPxAPkJWlddT7RAxWxM/zcIiUcDWf41aCYa4YPghD1fuCWbZOGI5RxCePGlfuj5RI6
	yGfRe+vAL44Fb5bl3AmItCBe8OM3MxFocm5p+AiHmrcgQOX4lBzAWWRE4bhA6F6JC+yUJWOMDNE
	vf5cRpopZKptAoz5UqO6fREw3rffVKTOB/UbrU+Z08Zryhto2xCibq935Ygah4LUGFxXz3N1lGl
	Imc6h8kmAaz18pUn4hSDvBRNaT50kkVPfwl56TegGQ3KQ0qW0lNxX+TeOiC/MMB++z3704Met0p
	UEeW9qpqdmqr22v2NNLD5/VVogYL7ZMXB2IEqydsSnzQ85ECP1A2/Mb2PiFxamkT1FzwXjjx3/O
	0ASib2/cmNB/UZ1EmfrZIrKJKt9S/NBco03AazcCc1iBEsk6i4BIQ==
X-Received: by 2002:a17:907:720b:b0:c29:53eb:9913 with SMTP id a640c23a62f3a-c2a157fbe1emr1203911666b.38.1790085443418;
        Tue, 22 Sep 2026 06:57:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c54f30dsm96324866b.17.2026.09.22.06.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:57:22 -0700 (PDT)
Message-ID: <41d28f9d-b86a-4d65-9a85-656ea9d216e9@gmail.com>
Date: Tue, 22 Sep 2026 14:57:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] builtin/stash: merge index in-core
To: "D. Ben Knoble" <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
 Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee <stolee@gmail.com>, Adam Johnson <me@adamj.eu>,
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Victoria Dye <vdye@github.com>, Elijah Newren <newren@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <782fe91251111fbb28359574d860e4a6d2e45fc0.1789853192.git.ben.knoble@gmail.com>
 <2551b801-4cb3-4880-ac01-7d14a188ddd4@gmail.com>
 <CALnO6CDG4Emny7xESxN8GObaXb_P9gPHBZ857hrAvDjiMSqsKQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CDG4Emny7xESxN8GObaXb_P9gPHBZ857hrAvDjiMSqsKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 22/09/2026 13:43, D. Ben Knoble wrote:
> On Mon, Sep 21, 2026 at 9:17 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 19/09/2026 22:26, D. Ben Knoble wrote:
>>> Fortunately, we can achieve 2 goals at once: avoid round-tripping to the
>>> file-system (and invoking expensive subprocesses) by performing the
>>> merge in-core. Since the results are never seen, we don't need to set
>>> the usual branch and ancestor labels.
>>
>> When the merge succeeds without conflicts we use the result so it is
>> seen. It would be clearer to say that "If there are conflicts we discard
>> the result so ...". The rest of the commit message explains the problem
>> nicely.
> 
> Indeed. This is what I get for (unusually) dashing off the commit
> message up against the clock. Thanks!
> 
>>> @@ -669,29 +625,25 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
>>>                    oideq(&c_tree, &info->i_tree)) {
>>>                        has_index = 0;
>>>                } else {
>>> -                     struct strbuf out = STRBUF_INIT;
>>> +                     struct merge_result result = { 0 };
>>>
>>> -                     if (diff_tree_binary(&out, &info->w_commit)) {
>>> -                             strbuf_release(&out);
>>> -                             return error(_("could not generate diff %s^!."),
>>> -                                          oid_to_hex(&info->w_commit));
>>> -                     }
>>> +                     init_basic_merge_options(&o, the_repository);
>>
>> This means we potentially use different diff algorithms when merging the
>> index and when merging the work tree, let's use the _ui variant here
>> instead.
> 
> Yep, you know I'd spotted that and wasn't expecting it to make a
> meaningful difference. It's an easy swap, but I thought that (like
> above, since we don't show the conflict results) the diff algorithm
> wouldn't matter too much.
> 
> Maybe it affects the actual merge-ability, though, in which case I
> agree using the same is important?

I think there are wierd cases where one diff algorithm results in 
conflicts and another doesn't because they generate different (but 
equally valid) diffs so allowing the user to tweak the algorithm we use 
via init_ui_merge_options() is probably a good idea.

> 
>>> +                     o.verbosity = 0;
>>
>> Looking at the code in merge-ort.c it appears the verbosity option was
>> used by the recursive strategy but isn't used anymore so I think we
>> could drop this.
> 
> Intriguing. (Assuming the default "2") There's a "< 5" check in
> path_msg() that wouldn't be affected by dropping this, and a "> 2"
> check in checkout() that… also wouldn't be affected?

The former is not affected because we're cherry-picking so never have an 
inner merge from merging multiple merge bases. The latter is not 
affected because we don't checkout the result!
> But it might matter if something is setting the verbosity elsewhere
> (config, GIT_MERGE_VERBOSITY), and I think we really want this merge
> to be quiet? I seem to remember reading commits in this area quieting
> "git reset" and so on to keep the noise down.
> 
> So I'm inclined to leave it for now, especially in case it later does get used.

merge ort does not print anything - it just adds messages to an strmap 
in struct merge_result() which we ignore here. I guess setting it to 
zero might avoid a little work generating the messages.

> 
>>> +                     oidcpy(&index_tree, &result.tree->object.oid);
>>> +                     clear_merge_options(&o);
>>
>> Looking at replay.c:replay_revisions() I think this should be
>>
>> merge_finalize(&opts, &result);
> 
> Hm, possibly. It does look like that does more with the "result,"
> which is probably needed.

Oh, we definitely want to free the strmap in the merge result.

 > But it doesn't actually clear the merge options.

Isn't that because there are no allocations in that struct? (obuf is 
unused - it looks like we could clean up the struct by removing the 
members that were used by merge-recursive but are ignored by merge-ort)

> On one hand, I thought it could be important not to reuse that struct
> between merges. But if we do use the "ui" init, it might be ok?
> replay_revisions() does use the same struct between calls to
> merge_incore_nonrecursive().
> 
> Oh, but one other thing: we unconditionally reinit the merge options
> later on in do_apply_stash(). We could conditionally initialize there
> ("if (has_index)"), I suppose?

I'd just move the call to init_ui_merge_options() above "if (index)". As 
far as I know it should be fine to reuse it - any state is stored in the 
result

> 
>>> diff --git a/merge-ort.c b/merge-ort.c
>>> index c410a5d353..f69a49d48a 100644
>>> --- a/merge-ort.c
>>> +++ b/merge-ort.c
>>> @@ -5035,8 +5035,6 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
>>>        trace2_region_enter("merge", "sanity checks", opt->repo);
>>>        assert(opt->repo);
>>>
>>> -     assert(opt->branch1 && opt->branch2);
>>
>> This, and the hunk below, make me nervous. Normally assertions like this
>> exist because the pointers are unconditionally dereferenced later on.
>> Looking at merge_3way() it asserts opt->ancestor is non-NULL and
>> dereferences all three labels. t3903 does not appear to have test
>> coverage for the index merge failing (if it did I think we'd see a
>> SIGSEV), we should probably add a test that checks the command fails
>> leaving the index and work tree untouched, and verifies the message on
>> stderr.
>>
>> Lets set some simple, fixed, ancestor and branch names in
>> do_apply_stash() above.
> 
> Funny, I was getting aborts before removing the asserts because I
> hadn't set the labels, aha. Looks like we've come back around to
> keeping the labels.

Sorry for that detour

> I'll probably keep a similar structure as the
> working tree merge uses, I think.

I'd use fixed names and not bother with all the conditionals around the 
label text to keep it simple.

> A fail-to-merge test also seems like a good idea. Let me mull on that.

That's great

Thanks

Phillip

> Thanks for the review.
> 

