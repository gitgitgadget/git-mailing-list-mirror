Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3B15B1
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710004946; cv=none; b=LILOpC2EQ98Mk+6U5dMm3Rcq02XvUePexUrGImRA0qsNZQl35cXugP9VcwVq1SUszKtWGU8nPjjBA9WQDyzM6RzuZIc+fbFt9waojKVZ7QI1D3VKA2chdjb4DBgKevsFvRDdteJCyE4/yGKgVQaq2GEatGfgxNJbYDyX2iwJuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710004946; c=relaxed/simple;
	bh=DnMk+3tax4JOVFYvz13CUAE4VDv4jPdZJ6kPALSxpaM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NtlBq7SFb8SEo2lqQ5Eb538xew7/Dlt5ajSjlp87vWaWusW1xtDWNA8oD5Y7sU9c9ZKg6cWwyhPQLqxlUHBBPRYFJgt9ubA2kvmLs93CGH74wgpJ3nCcivph5uEaSrQHnezCxzR/l3WgPb9Y4ZnUgV9xE5Vn/lr5JJzw1xWNDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvlGwIUq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvlGwIUq"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7882b1e87c4so140496385a.1
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 09:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710004943; x=1710609743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3R8vf+uMM3nGh+NGjwYesxJsqdcjPRZnNJfJjgDZCE=;
        b=CvlGwIUqPx+a+1Cl3dmXulqk2eYrAQLmVBThRWrllg5HsFTY/Ff/WSvpM7imWl23yV
         mPygm2paxbr5qp9YtH2nhH+Ps30O7ywa91lhE/l7sOcGPbxasanoe3U+H2K8zc6FdMwM
         QFdSC3M1uXlVEyEqkP8ivXsOBOjS44mhtnZ/EoXkvh1xE58gt6DeQaQKq7bmOvKNBrx6
         ItbQySkLNsZbEadXxdL5o1777eGHdYQFD/B5IKgGyOmY4giD8bRX0/WVYG947FRCQ5YO
         CbnXFf7x+ee9TgCtdHQGPQYII7inrZDLaN7HsWhch/CdTMFCq6V+t8M0Io6YyyeDbIUt
         E6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710004943; x=1710609743;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3R8vf+uMM3nGh+NGjwYesxJsqdcjPRZnNJfJjgDZCE=;
        b=SOXkvV010k6bqqJjlZ0QlTf4vmE9UDQrzOiKcblC9AqMuH3/2obkeaTMAqBU8uHEp6
         ywdVZOzDqUixPUa+SOMlnpJh07lz6VCviRTwucTrUEiqgL8XEYxv5fxtSGAVpNouU5x+
         R1MKm/SSBd3HbSB0m4pALTFtVq5l7RLBkwBg3TKZsZJwipYMO2grHizQmYOkFTpEuodw
         znQVkOM2SL3pcMeSGtar/slNyfuYOX36Ptazb0zYWFUYpPCW/eZYjYOckiaoM1cbho4A
         s0dL+h46lP6MuzzTC+Zm9K+6anm81txh+2X7aOz/DZfyrVcwibnlRX9Zh+GET17cK5S3
         9oUQ==
X-Gm-Message-State: AOJu0YwP9mQZp+R+0dgwwljhkA7bdiFTgIlCkFpJAv8YZ1LOQLZqR8+6
	InBLYucsvhsiHFljPMSvuJThKP9ranUgF1S4omX4auq5Cs1kIu7tAAtI+sKP
X-Google-Smtp-Source: AGHT+IGg2V6D5z6Td157nmJn2SIQ9q/rj0YG4CReBYDaaO1KzoI9T9Smp+aYxLwp/io/K9jctmbdjQ==
X-Received: by 2002:a05:620a:4493:b0:788:2c47:2a71 with SMTP id x19-20020a05620a449300b007882c472a71mr3602043qkp.30.1710004943128;
        Sat, 09 Mar 2024 09:22:23 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ff90:b1b9:ff9c:b8e:3049? ([2606:6d00:11:ff90:b1b9:ff9c:b8e:3049])
        by smtp.gmail.com with ESMTPSA id bi39-20020a05620a31a700b007883687ef00sm1102174qkb.69.2024.03.09.09.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 09:22:22 -0800 (PST)
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
To: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <xmqqwmqiudna.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <6ef490d2-ce0a-f8bd-8079-6b4ef3e37eda@gmail.com>
Date: Sat, 9 Mar 2024 12:22:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqwmqiudna.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-03-03 à 17:57, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  	if (msg) {
>> -		advise("%s\n", msg);
>> +		advise_if_enabled(ADVICE_SEQUENCER_CONFLICT, "%s\n", msg);
>>  		/*
>>  		 * A conflict has occurred but the porcelain
>>  		 * (typically rebase --interactive) wants to take care
> 
> This hunk is good.  The block removes the CHERRY_PICK_HEAD after
> giving this advice and then returns.
> 
>> @@ -480,22 +480,25 @@ static void print_advice(struct repository *r, int show_hint,
>>  
>>  	if (show_hint) {
>>  		if (opts->no_commit)
>> -			advise(_("after resolving the conflicts, mark the corrected paths\n"
>> -				 "with 'git add <paths>' or 'git rm <paths>'"));
>> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
>> +					  _("after resolving the conflicts, mark the corrected paths\n"
>> +					    "with 'git add <paths>' or 'git rm <paths>'"));
>>  		else if (opts->action == REPLAY_PICK)
>> -			advise(_("After resolving the conflicts, mark them with\n"
>> -				 "\"git add/rm <pathspec>\", then run\n"
>> -				 "\"git cherry-pick --continue\".\n"
>> -				 "You can instead skip this commit with \"git cherry-pick --skip\".\n"
>> -				 "To abort and get back to the state before \"git cherry-pick\",\n"
>> -				 "run \"git cherry-pick --abort\"."));
>> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
>> +					  _("After resolving the conflicts, mark them with\n"
>> +					    "\"git add/rm <pathspec>\", then run\n"
>> +					    "\"git cherry-pick --continue\".\n"
>> +					    "You can instead skip this commit with \"git cherry-pick --skip\".\n"
>> +					    "To abort and get back to the state before \"git cherry-pick\",\n"
>> +					    "run \"git cherry-pick --abort\"."));
>>  		else if (opts->action == REPLAY_REVERT)
>> -			advise(_("After resolving the conflicts, mark them with\n"
>> -				 "\"git add/rm <pathspec>\", then run\n"
>> -				 "\"git revert --continue\".\n"
>> -				 "You can instead skip this commit with \"git revert --skip\".\n"
>> -				 "To abort and get back to the state before \"git revert\",\n"
>> -				 "run \"git revert --abort\"."));
>> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
>> +					  _("After resolving the conflicts, mark them with\n"
>> +					    "\"git add/rm <pathspec>\", then run\n"
>> +					    "\"git revert --continue\".\n"
>> +					    "You can instead skip this commit with \"git revert --skip\".\n"
>> +					    "To abort and get back to the state before \"git revert\",\n"
>> +					    "run \"git revert --abort\"."));
>>  		else
>>  			BUG("unexpected pick action in print_advice()");
>>  	}
> 
> This hunk can be improved.  If I were doing this patch, I probably
> would have just done
> 
> -	if (show_hint) {
> +	if (show_hint && advice_enabled(ADVICE_SEQUENCER_CONFLICT)) {
> 
> and nothing else, and doing so would keep the block easier to extend
> and maintain in the future.
> 
> Because the block is all about "show_hint", we have code to print
> advice messages and nothing else in it currently, and more
> importantly, we will not add anything other than code to print
> advice messages in it.  Because of that, skipping everything when
> ADVICE_SEQUENCER_CONFLICT is not enabled will not cause problems
> (unlike the earlier hunk---which will break if we added "&&
> advice_enabled()" to "if (msg)").  That way, when somebody teaches
> this code a new kind of opts->action, they do not have to say
> "advice_if_enabled(ADVICE_SEQUENCER_CONFLICT()"; they can just use
> "advise()".

That's true and makes the changes simpler, thank you for the suggestion.
I'll do that in v2.

Philippe.
