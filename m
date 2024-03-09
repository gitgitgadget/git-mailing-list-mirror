Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54F286BD
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710010730; cv=none; b=VQS1+7peD8SnGeNKIgAf1U62qMefy7OJ60ucgaeC6AiHC7xmODZpXrvN6D3ixcnvJwOs/ODPf4wuc+Hl7m5kyrP6vKGY2Zi+xuteT94R+U6CNFmv4dsQtjojUpTEN6qv9CU+Y0w7+vqFKDV3AZtnSH6xqXksmTDTZLocV6Zdpc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710010730; c=relaxed/simple;
	bh=UdbQdienkfgYKR4YY7RW7LMOt+Xcjgrw9tsDSbKm0Jk=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fvn1v/BqT0owNtjysMauFcQI9QX5PnzcFtCqFj00FV+hmMihWTbfUs0ED6fD25/MJFKlPRZF3hvjXwADTGZ12OspMoFa7lr542YQ2I6PygfYjX4A/Y+7SSFBnBlh41D4+bsDJ0bTCad6n/qtT1u1ILS2dbgzbK1WZeXYUHU3ZhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4qUuZo6; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4qUuZo6"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-788598094c4so71469385a.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 10:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710010727; x=1710615527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3Lnfqyh5A8aV58akF9fifa4erK4qab5yLCeYI5E9lA=;
        b=F4qUuZo6jYemt3ocL4fbFcHwOpbL1NIIclZMTVQ+HxH7OeMPcjwxL3yGSx3RFxlgdF
         TGMAeEKfPbSPT3eqh5rfeh9RFBxxk8SmmpqORlIfvXQC4HyV9LqftJrJInijcpgWqCGy
         xsD2elJt+WmgPVs1UpEXhqKEfy/GJ2aTsWvRyrpEOxCEfpmx8fP4NoU/YkOSsOKRiBIm
         0krmQlTYa0Yw1R2hL73bqH6S9aWxL8ZgIkMHYtsYLhOe3Gh0AI07wwZj/DepzRGL5Bkl
         XC77Fj3Qt6TNsbjkO/7amdDuOPu+ZrAqVck2DeQBdda1TqQbPeAzGEH51J5fwrFzFMb/
         hwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710010727; x=1710615527;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3Lnfqyh5A8aV58akF9fifa4erK4qab5yLCeYI5E9lA=;
        b=fZW1vhgnRGO53pvpqmH/CCS1vzHMHIHkeNu/bHFV6ki8bxZd7N92lRdSza0ePMNctu
         xEyvLYY8mOP6rceXbPSb2KLUjMmDz9znysDhXiwVBbdzkXHebdU+g2W+wAPsb2D3EkGu
         D6aZX8W9HgnUuug4l9OJkk2R4Yt90WSmfYk5CFT52kFvKguzq96Zls/620s7hlu7CkM/
         pkbb5JHGWoRXvt4cyhtFRFB4sEn450raIaiv0pJAMlfwuZSnhevuNU95+qZqz2bVP5J2
         cYnepbkF0z2Y7Jq7/4STUNkabE4tr+WtHowiM3t8exCsSuNFj3DcSKbGbaVwCtnxciHf
         Ec6A==
X-Gm-Message-State: AOJu0Yx6Lsdbt6gGHfbbQCOYistEEkQZSfKlv51DWaWJ8H1xhhDjym6E
	fhb/9zKh0cNUbnNkRELsrikS8dNMEBudP2QO6bobVqN10gLZxpXf
X-Google-Smtp-Source: AGHT+IFdzlOu+wRk6DQn2zGNW6++zb301DUBIWn6lU2Ncwb4YFpkmVlrrNvPV5KOQR5BIwzlegF9AQ==
X-Received: by 2002:a05:620a:b41:b0:788:5240:8696 with SMTP id x1-20020a05620a0b4100b0078852408696mr2324645qkg.12.1710010727417;
        Sat, 09 Mar 2024 10:58:47 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ff90:b1b9:ff9c:b8e:3049? ([2606:6d00:11:ff90:b1b9:ff9c:b8e:3049])
        by smtp.gmail.com with ESMTPSA id b23-20020a05620a127700b007885cd1c058sm1141702qkl.103.2024.03.09.10.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 10:58:46 -0800 (PST)
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
From: Philippe Blain <levraiphilippeblain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <xmqqwmqiudna.fsf@gitster.g> <6ef490d2-ce0a-f8bd-8079-6b4ef3e37eda@gmail.com>
Message-ID: <570a8736-5552-6279-4aea-8acdf8af50df@gmail.com>
Date: Sat, 9 Mar 2024 13:58:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6ef490d2-ce0a-f8bd-8079-6b4ef3e37eda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Le 2024-03-09 à 12:22, Philippe Blain a écrit :
> Hi Junio,
> 
> Le 2024-03-03 à 17:57, Junio C Hamano a écrit :
>> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>>  	if (msg) {
>>> -		advise("%s\n", msg);
>>> +		advise_if_enabled(ADVICE_SEQUENCER_CONFLICT, "%s\n", msg);
>>>  		/*
>>>  		 * A conflict has occurred but the porcelain
>>>  		 * (typically rebase --interactive) wants to take care
>>
>> This hunk is good.  The block removes the CHERRY_PICK_HEAD after
>> giving this advice and then returns.
>>
>>> @@ -480,22 +480,25 @@ static void print_advice(struct repository *r, int show_hint,
>>>  
>>>  	if (show_hint) {
>>>  		if (opts->no_commit)
>>> -			advise(_("after resolving the conflicts, mark the corrected paths\n"
>>> -				 "with 'git add <paths>' or 'git rm <paths>'"));
>>> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
>>> +					  _("after resolving the conflicts, mark the corrected paths\n"
>>> +					    "with 'git add <paths>' or 'git rm <paths>'"));
>>>  		else if (opts->action == REPLAY_PICK)
>>> -			advise(_("After resolving the conflicts, mark them with\n"
>>> -				 "\"git add/rm <pathspec>\", then run\n"
>>> -				 "\"git cherry-pick --continue\".\n"
>>> -				 "You can instead skip this commit with \"git cherry-pick --skip\".\n"
>>> -				 "To abort and get back to the state before \"git cherry-pick\",\n"
>>> -				 "run \"git cherry-pick --abort\"."));
>>> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
>>> +					  _("After resolving the conflicts, mark them with\n"
>>> +					    "\"git add/rm <pathspec>\", then run\n"
>>> +					    "\"git cherry-pick --continue\".\n"
>>> +					    "You can instead skip this commit with \"git cherry-pick --skip\".\n"
>>> +					    "To abort and get back to the state before \"git cherry-pick\",\n"
>>> +					    "run \"git cherry-pick --abort\"."));
>>>  		else if (opts->action == REPLAY_REVERT)
>>> -			advise(_("After resolving the conflicts, mark them with\n"
>>> -				 "\"git add/rm <pathspec>\", then run\n"
>>> -				 "\"git revert --continue\".\n"
>>> -				 "You can instead skip this commit with \"git revert --skip\".\n"
>>> -				 "To abort and get back to the state before \"git revert\",\n"
>>> -				 "run \"git revert --abort\"."));
>>> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
>>> +					  _("After resolving the conflicts, mark them with\n"
>>> +					    "\"git add/rm <pathspec>\", then run\n"
>>> +					    "\"git revert --continue\".\n"
>>> +					    "You can instead skip this commit with \"git revert --skip\".\n"
>>> +					    "To abort and get back to the state before \"git revert\",\n"
>>> +					    "run \"git revert --abort\"."));
>>>  		else
>>>  			BUG("unexpected pick action in print_advice()");
>>>  	}
>>
>> This hunk can be improved.  If I were doing this patch, I probably
>> would have just done
>>
>> -	if (show_hint) {
>> +	if (show_hint && advice_enabled(ADVICE_SEQUENCER_CONFLICT)) {
>>
>> and nothing else, and doing so would keep the block easier to extend
>> and maintain in the future.
>>
>> Because the block is all about "show_hint", we have code to print
>> advice messages and nothing else in it currently, and more
>> importantly, we will not add anything other than code to print
>> advice messages in it.  Because of that, skipping everything when
>> ADVICE_SEQUENCER_CONFLICT is not enabled will not cause problems
>> (unlike the earlier hunk---which will break if we added "&&
>> advice_enabled()" to "if (msg)").  That way, when somebody teaches
>> this code a new kind of opts->action, they do not have to say
>> "advice_if_enabled(ADVICE_SEQUENCER_CONFLICT()"; they can just use
>> "advise()".
> 
> That's true and makes the changes simpler, thank you for the suggestion.
> I'll do that in v2.

Thinking about this more and looking at the code, using 'advice_enabled' in the condition
instead of using 'advise_if_enabled' for each message has a side effect:
the text "hint: Disable this message with "git config advice.sequencerConflict false"
will not appear, which I find less user friendly...

Philippe.
