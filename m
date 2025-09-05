Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31923285C99
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066808; cv=none; b=F+A3ntH8qBmVSWPRzk5w/b/nF1Z7+8IPzi2LQO904OY8//DJiU2LAUBy1fb11kYnb6bBTl+c2LM0zVwWN5mD2x1q6sYgP6Sm6W8FutZYVOzzqCjc1atB5Iuak7jgsFr6n8HMWtYAkAAFT3VFpw9jCybF3WknvkYyw4gHKBBH3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066808; c=relaxed/simple;
	bh=TaztsgBb1/JRguDkkW2iP/vPHAAc0cly/jBPLvGdAjc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CupSSwOwZwC3Seva0frzKvk9mCbB9t7t85+0Iah1tfNlzqEv1jbmF/oXGr6Uj2MMaSsNlqURZiciajVWMCr2i7mi2vIRIeisrQYBg9yRnaX8NbQXG/ARJwwAfXpptSBq0FoVCM32iw+jm4JddK5rrX4Vq1JUMLisIuq9/XALPjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPL1QfCq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPL1QfCq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so7210515e9.3
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757066804; x=1757671604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=153F9Y6oa9lvzqtxBI5eXi4ClbBlReBEsZ+bszWFM8M=;
        b=bPL1QfCq6SPAYGIKFSBHsydeOM4ZEUzKvnt7fAK57Ofz2+4S4aHlmMz9wR+oMhTwZO
         TdCJqpsNYp0i+YqHYn3+l6i1vLWCozQbgh6pEKRpDp1Z5qk5RwirVfAardxpqGJub/Ox
         q7yElfmQuHa/I2bkfxKkN0ZNa8BK/gViuXVeQLUw0E5vulh50yPH+ZuVp9BeYM1isC7n
         ijECHo0GtU4g9LykAM6VI3dJmTc3nKqUO1kX+vr15WkT7kNNB82td7X9v50QwaQM3Msj
         kXRw2bQqaF+6MZKgThEFb6+O4V2CweI59Kz36jtSgo+YvJx8lHWHh7s5LewUUSEuDGnn
         bdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757066804; x=1757671604;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=153F9Y6oa9lvzqtxBI5eXi4ClbBlReBEsZ+bszWFM8M=;
        b=wWP/GmlIkeo61FVqxxqdwoIk/c40gp9ANEv5h8atRSNN+hJBZOlES/GKc/zhAI8uL2
         kkYBiJUYW0+SMS1+ksylswRen7XH+Gm5uYIYbJdUY1wBnSe6qt7jGDqBputbEOY2OEYy
         T/eg+YQVh442fiHl8ZbqWzEzNoyMyxhJoVB/HLe8h0uXJvTkZ4wlmqQQ9apZKegsaeJR
         21tFQQApvvDn26cHiWaIO688NeVtNfmNcT2v5FFt7peLiY0/jHGMeEe20lX+E9MRH7gL
         /DuD1zRSCXuWy/qBZ5cULGc7ekINlqG4AmKpTmZwG42k7LhivdPOVRkgD0bf6sPz5Dv3
         qAvQ==
X-Gm-Message-State: AOJu0YzxWf6F4aAcNfrmcBmmdJc6pbA3x+H7vp1dprtZ1mY/0yWRhgsi
	LbEehG149hjzv/aIiyACsBrUBnGJLNW1tPFg4/Hja2Tu5Y5i7Qvf9RHn
X-Gm-Gg: ASbGncs5WT1/ReeA9bgV60dmnFwX2h8C/jqiSJvFrpA2vzzI1xxY0UtjFs549xFf8zt
	4W2ubPvtocUM7iisF4Wc64+fES4PTeymDjie0WwJC/dpysUW8VWg2yZUadYfTF9h0YNeFH6AA9Y
	CfiCG9iCJLBb22AfvGRLxaPyvbeSTCvOouWtY74qDdWyvBvQfrgdtzz37dvDjayEYo4GYyQxwgY
	sc9e91UVfNIpQwlhR/kQmVg5vWQte5fu1lBFrJiGZUpm1QumNRB/LswdWh8ZWKqEXmmDbbINrjt
	GVP9s2qghYRFALjnThcUbAsRbMJicoXfhvVeXwAsXYvdoT7lKLI/tE5kPadOsEgScIZfMDqPANh
	dNw6Lu0WuvoIUrYnLgpDSByPAkqPO3Fl2Rq4yt9aBuustMJ2spfUBM4Cv56YAR35+ngguSYvarc
	ujm78h
X-Google-Smtp-Source: AGHT+IE7Cd5z8kzO6VSqZ30cFSZ0ewQykM+BGy1fObB3MlKWDiFXh9XiHNh3bFsdZ4nAN5fmEmqP7A==
X-Received: by 2002:a05:6000:649:b0:3d7:eb95:b1e1 with SMTP id ffacd0b85a97d-3d7eb95b67fmr11383989f8f.32.1757066804174;
        Fri, 05 Sep 2025 03:06:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e411219ddfsm1537558f8f.57.2025.09.05.03.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:06:43 -0700 (PDT)
Message-ID: <f43c3e61-01c8-47d8-bf0d-7cfa13cacca5@gmail.com>
Date: Fri, 5 Sep 2025 11:06:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] breaking-changes: switch default branch to main
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <cover.1756992089.git.phillip.wood@dunelm.org.uk>
 <6986375dc379a646bb184be3cf7a018b2eb3eec7.1756992089.git.phillip.wood@dunelm.org.uk>
 <xmqqjz2e86b7.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjz2e86b7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2025 18:40, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
>> index f8d2eba061c..eb92e6f6a7d 100644
>> --- a/Documentation/BreakingChanges.adoc
>> +++ b/Documentation/BreakingChanges.adoc
>> @@ -165,6 +165,11 @@ A prerequisite for this change is that the ecosystem is ready to support the
>>   "reftable" format. Most importantly, alternative implementations of Git like
>>   JGit, libgit2 and Gitoxide need to support it.
>>   
>> +* In new repositories the default branch name will be `main`. We have been
>> +  warning that the default name will change since 675704c74dd (init: provide
>> +  useful advice about init.defaultBranch, 2020-12-11).  The new name matches
>> +  the default branch name used by many of the big Git forges.
> 
> As I am not a native, this is a mere question and not a suggestion,
> but my reading hiccups when I see the lack of comma after "In new
> repositories".

I agree a comma would be good here
> "used by many of" -> "used for new repositories by many of"?

Sounds good
>> diff --git a/advice.c b/advice.c
>> index e5f0ff84491..48c49ee4145 100644
>> --- a/advice.c
>> +++ b/advice.c
>> @@ -51,7 +51,9 @@ static struct {
>>   	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
>>   	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
>>   	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
>> +#ifndef WITH_BREAKING_CHANGES
>>   	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
>> +#endif /* WITH_BREAKING_CHANGES */
>>   	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
>>   	[ADVICE_DIVERGING]				= { "diverging" },
>>   	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
> 
> Would there be folks who type "git init" to get a 'main' branch,
> while trying to follow a recipe written in pre-3.0 days that assumes
> the initial branch is called differently, and get confused after
> seeing many commands written in the recipe for them to follow , like
> "git checkout -b next master" fail?  Do they need a different advice
> message to help them, i.e.e.g,
> 
>      $ git init
>      Initialized empty Git repository in /a/b/c/.git/
>      hint: Since Git 3.0, an initial branch is 'main' these days.
>      hint: If you need its name to be different (e.g. 'frotz'),
>      hint: you can immediately rename it with "git branch -m frotz".
>      hint: Disable this message with "got config set advice.foo false"
> 
> or something?  I dunno.  In any case, that will have to be a new and
> different advice message, and defaultBranchName should not be reused
> for that purpose, so the change in the the above hunk is fine.  I am
> wondering if we need a new entry protected by the same #ifdef on the
> #else side.

Personally I find the current advice pretty annoying and would be glad 
to see it go away. Are there really that many people who want to 
customize the initial branch name that it is worth adding some new 
advice post Git 3.0? Although I find it annoying, I do think the current 
advice serves a useful purpose as it informs people the default that 
they are used to is changing and that they can override it. Given how 
long we've been warning people I'm not sure we need to say anything once 
the default has changed.

>> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>> index 01823fd0f14..a21834043f3 100755
>> --- a/ci/run-build-and-tests.sh
>> +++ b/ci/run-build-and-tests.sh
>> @@ -9,7 +9,6 @@ run_tests=t
>>   
>>   case "$jobname" in
>>   linux-breaking-changes)
>> -	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>   	export WITH_BREAKING_CHANGES=YesPlease
>>   	;;
> 
> OK.
> 
>>   linux-TEST-vars)
> 
> We have been very careful to make sure that none of our tests
> implicitly rely on that the initial branch name will still be
> 'master' with the above.  Now we should make sure that none of our
> tests implicitly assume that the initial branch name will forever be
> called 'main'.  In the post-context, linux-TEST-vars arm has
> something that forces the initial branch name to be 'master', and we
> probably should keep it for a while to serve that purpose.

That sounds sensible. I'll wait a few days to see if there are any other 
comments and then re-roll the the documentation tweaks you suggested above.

Thanks

Phillip

>> diff --git a/refs.c b/refs.c
>> index 4ff55cf24f6..149a8d1cec1 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -627,10 +627,12 @@ void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
>>   		strvec_pushf(prefixes, *p, len, prefix);
>>   }
>>   
>> +#ifndef WITH_BREAKING_CHANGES
>>   static const char default_branch_name_advice[] = N_(
>>   "Using '%s' as the name for the initial branch. This default branch name\n"
>> -"is subject to change. To configure the initial branch name to use in all\n"
>> -"of your new repositories, which will suppress this warning, call:\n"
>> +"will change to \"main\" in Git 3.0. To configure the initial branch name\n"
>> +"to use in all of your new repositories, which will suppress this warning,\n"
>> +"call:\n"
>>   "\n"
>>   "\tgit config --global init.defaultBranch <name>\n"
>>   "\n"
>> @@ -639,8 +641,9 @@ static const char default_branch_name_advice[] = N_(
>>   "\n"
>>   "\tgit branch -m <name>\n"
>>   );
>> +#endif /* WITH_BREAKING_CHANGES */
>>   
>> -char *repo_default_branch_name(struct repository *r, int quiet)
>> +char *repo_default_branch_name(struct repository *r, MAYBE_UNUSED int quiet)
>>   {
> 
> And if we were to introduce a new advice to help people who still
> expected the traditional name, this MAYBE_UNUSED would not become
> necessary ...
> 
>>   	const char *config_key = "init.defaultbranch";
>>   	const char *config_display_key = "init.defaultBranch";
>> @@ -649,14 +652,18 @@ char *repo_default_branch_name(struct repository *r, int quiet)
>>   
>>   	if (env && *env)
>>   		ret = xstrdup(env);
>> -	else if (repo_config_get_string(r, config_key, &ret) < 0)
>> +	if (!ret && repo_config_get_string(r, config_key, &ret) < 0)
>>   		die(_("could not retrieve `%s`"), config_display_key);
>>   
>>   	if (!ret) {
>> +#ifdef WITH_BREAKING_CHANGES
>> +		ret = xstrdup("main");
> 
> ... as we will have the same if (!quiet) advice sequence here,
> protected with a different ADVICE_ thing.
> 
>> +#else
>>   		ret = xstrdup("master");
>>   		if (!quiet)
>>   			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
>>   					  _(default_branch_name_advice), ret);
>> +#endif /* WITH_BREAKING_CHANGES */
>>   	}
>>   
>>   	full_ref = xstrfmt("refs/heads/%s", ret);
> 
> Thanks.

