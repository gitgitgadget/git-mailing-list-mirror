Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D159B55
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799401; cv=none; b=i/qDcjwLtvaJX1J2+OB0QTxzkhDnwxw148OZaog3oj/5aMAXy5SBSmX1LRZvQB1w9qNePGKre9PnE3i/M2bHSlHNt8wwMRIrvekyLvIahQeOsdLGdP+vAVO0gbLE7pe3wdF/M107kkj9s3VpwAFErVCzqhi/opLPO2qVG1K3zII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799401; c=relaxed/simple;
	bh=fqMOVwLBCfA4IggoTBiwPKYofa6rDf4QbNComo8yVJk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rz59aU3CT72WFH9VrVk19JJeK53gdL3ky0wB7IS43QiRvdSYhu0O5Kx62X7REg1oMXdCFwAEUMbYsSTGnkJ+4+xC9PPCsIfFk0zRAT1VnKDo7oXhpS6ez8MJGj/d5OQz7Z8jJAxADUljWiqeDY+N2HNOLlW/xpgEeLYS9Y6s2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ne7+rWUV; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ne7+rWUV"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710799397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tk4+EmgAen2nKuZ/C9xX7wtBRfBFUPDnwdAf+Y3mNyU=;
	b=Ne7+rWUVIjZTN2KurUESSymw+t+YKiQgJHPHsWQiM6yryHRmq9F3U3g/GsY7reE8CPyIww
	PTuGsVKSu104iDqyszJdbXbJZB/4/vpDdS/SQnSsw2oQIKJo5LlDZK2Y5F5QTF2lCVRgub
	l79yviF33xveB9HyiwQOsvMxIji6tXPF6Y2sGcdpBVEHCywbf9+wcy0Jb1gZRyNYRmbXiF
	tXO6Zqys9JXKtQvPWxiRKkvIhiYv9CojMRjGKeI7Nv0Iab+EfCPbpnXkJzblNnnXNeM0Ss
	sip20V/zHbQhthhje9EFEQe+WXmmZBw1QFWDgHwvdoAksC2EAL2WLTcQh/Okrg==
Date: Mon, 18 Mar 2024 23:03:17 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] grep: perform some minor code and comment cleanups
In-Reply-To: <CAPig+cQ6Y2oOaPkKFsD41beXLHjhD++nmf59xrcswpb6_Q-sdA@mail.gmail.com>
References: <cover.1710781235.git.dsimic@manjaro.org>
 <96b81f3573d3f29bb97e77d623be0d53cf8085b0.1710781235.git.dsimic@manjaro.org>
 <CAPig+cQ6Y2oOaPkKFsD41beXLHjhD++nmf59xrcswpb6_Q-sdA@mail.gmail.com>
Message-ID: <9642c7e2adc888d960ded71d79af882b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-18 20:59, Eric Sunshine wrote:
> On Mon, Mar 18, 2024 at 1:04 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Move some variable definitions around, and reflow one comment block, 
>> to
>> make the code a bit neater after spotting those slightly unpolished 
>> areas.
>> There are no functional changes to the source code.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> @@ -623,13 +623,13 @@ static int grep_tree(struct grep_opt *opt, const 
>> struct pathspec *pathspec,
>> -       struct repository *repo = opt->repo;
>> -       int hit = 0;
>> +       int hit = 0, name_base_len = 0;
>> +       int old_baselen = base->len;
>>         enum interesting match = entry_not_interesting;
>> +       struct repository *repo = opt->repo;
>>         struct name_entry entry;
>> -       int old_baselen = base->len;
>>         struct strbuf name = STRBUF_INIT;
>> -       int name_base_len = 0;
>> @@ -890,19 +890,15 @@ static int pattern_callback(const struct option 
>> *opt, const char *arg,
>> -       int hit = 0;
>> +       int hit = 0, seen_dashdash = 0, use_index = 1;
>>         int cached = 0, untracked = 0, opt_exclude = -1;
>> -       int seen_dashdash = 0;
>>         int external_grep_allowed__ignored;
>> +       int i, dummy, allow_revs;
>>         const char *show_in_pager = NULL, *default_pager = "dummy";
>>         struct grep_opt opt;
>>         struct object_array list = OBJECT_ARRAY_INIT;
>>         struct pathspec pathspec;
>>         struct string_list path_list = STRING_LIST_INIT_DUP;
>> -       int i;
>> -       int dummy;
>> -       int use_index = 1;
>> -       int allow_revs;
> 
> It's entirely subjective, of course, so no right-or-wrong answer, but
> I personally do not find that this change improves code quality or
> readability.
> 
> With my reviewer hat on, I spent an inordinate amount of time staring
> at this change trying to locate each variable's new location to verify
> that no initializers were dropped and that the declared type hadn't
> changed. Taking into consideration that reviewers are a limited
> resource on this project, I'd probably have skipped this patch
> altogether if I were doing this series unless these changes concretely
> help a subsequent patch.

Oh, I'm fully aware that the reviewers are a limited resource, and I do
agree that all this is subjective.  Though, I believe it makes the code
look nicer, which is the only reason why I performed and submitted those
changes in the first place.

Though, maybe it would've been better if I submitted these changes as
a separate patch, instead as part of this series.
