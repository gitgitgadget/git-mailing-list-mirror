Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938D4CEE47
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848083; cv=none; b=GjSlcGbyPUM1NHAsRu4qD/XGvuCy3HcNzWGOVnIvtn2+feR8keIQOR+iONVrHNZiUPel1u5FEWlwshP+TKjqOUwjF6sr7M6956VwphjdWezwNtI7N7gqrTGKY9u42UrUeztQc2Cw1qshCXbH5oaV1XtfznoVziww1SGahq/ITZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848083; c=relaxed/simple;
	bh=Kw/fxm36v7k34LNpXLBr6PEk6APwhBE7wEyisqQpdLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2n0Wh19lPtmcqGJ9vfsWd0L8BG+1w9JHNYjS7Fd762/VgxCMq2FRwrFdsDHZjVM1qTVBoBULk0efZVshauSm3tbV++FL8JIvWTKImXteYz66FQ6aLCfPL+6lVUcy1PPZXyLziOtRwEagv8BcXhMWfI/DMQCTL3AGHoK5f6nPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxNVOQkO; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxNVOQkO"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae1f2cedfso8362324a12.3
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790848080; x=1791452880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=31mSmqY1iEu4nXAYqnAXjBUWph7LfDYAKs72WX8ram0=;
        b=BxNVOQkOw8IcdCC1PK2oBfvG9wiQ7YK/v72L+E5xtOTOLiDp8Eh+jy5I2P0YvWYYzM
         R9TajpKT0A6+kHmRPSD9kK1P0crGpXumd5hlLI67N/zLvdOg6OizlOQAq/QPuZwTbGwv
         twTsWJY/N0vXJ3E3ZeDkayC8iKr5PMhOqYvK7oP9rrNFqTWWDUZv6LBMjF0NcWb+KWFV
         GF0qmLBDzFeviQkvtD4/Ncnij75mmyRL46QZeIixiHS7Mn/3Y4mhqpOI0j+1Tj8Y2KQd
         4phmya2Uf7/QPYAvcFOwCg47vB8tRbXCrEMKHQs+8TyEcEJcFSU3m3ovEktyq3WBikYF
         /Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848080; x=1791452880;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=31mSmqY1iEu4nXAYqnAXjBUWph7LfDYAKs72WX8ram0=;
        b=rlqA0u+TwCmizndePyNUtVNkhQ28VhETg+OvDcDUyPGsOKfXQhtXAI++aOzWCgWc0n
         Htxk/z4IkfSDNWwFobDKUoF4k0jQdbZxzuEHCx/8LhQ5ZJbmVZWgVHk61biH+/rH94+f
         t2g6PCVPIePQYuIPTozIx72Mt8nZts7M1DM23Hpaz8je9dpqiaQhcYIPrXVE8oxmw2SL
         2EgRhJ+rS6AdTxLlLwwSzxeq3uEFDRngiF6DnUR4+ON3Ga/dl4wU3K4S791JbCW6ITdK
         sbrByUCjRpsHk87lhiCshRZiE00ZUhijH7BntWLGmriBjnjFFWbI9qpnfJoDfPiaURhE
         14FA==
X-Gm-Message-State: AFq9FYIAUFkR7VZpcawhOid45d80T43NjYBJmrfCtfXFNhY/oVgmDMPt
	oCskD3og1b5gCPOXz6HbbeS1yQPkjEqSdjyhrbjowowT0Oc5oVEyTupDUx6xhq4W
X-Gm-Gg: AYBFou1s/o3+m0vHIvqKh0dvP5DIXYyQL4Edz7K0n/pdcSvLgHegTk/j8krorpHQbKV
	nZ+TXUIUPHXVIBH93tllVTHJTFdNw/Xz+biTzVSS0c0XVX/t9asFCz1NoRGtbf1/nwwHhqwnNfD
	8veE24NAromn49RN/1BLD3F8cK2UAIiVMztRhmipWpRqY1h+o5at3Rj4NX1xa/byJuylylRmqQe
	aq6wsZF2EG1ECc8sSiKfGonkSrT4gR7X8hE8eV6WK05OzlUtcqrsra1KPdOGDXN5q7Ev6Wx95AO
	riEGMehV+yuwUWP4lyWKIE6WnXx5wLZy+5QTq719qQAJOLFIJrHNXi8JxZfZJ4ZVxds0D5BTA+8
	2RWECDvt/0SzHr6unUnGDj3VP6i2BPrZY340F31O/g1oGFIIkaKp8ZYP/T7/G6Hrv8cqefiOdrc
	7sq0GTjqFNU3K2/QPiGy/1r7KI1zh9PkpqN7Zi6VdahBuELVLXQ0COSUSuY0UDWdBWny5XTFqx8
	9h6nrkk2E+mp19jzcNmN1rPJxMBekfCHGAaKFYsNyYYJ6RYOGh6g4siANakd8XI
X-Received: by 2002:a05:6402:51d0:b0:6ac:689e:ad5f with SMTP id 4fb4d7f45d1cf-6ae19914711mr2973488a12.23.1790848079785;
        Thu, 01 Oct 2026 02:47:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae5ca74f82sm800002a12.28.2026.10.01.02.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 02:47:59 -0700 (PDT)
Message-ID: <93321573-2164-4bbd-b884-7d6287c400b3@gmail.com>
Date: Thu, 1 Oct 2026 10:47:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] stash: allow custom conflict labels for pop
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2430.git.git.1790801929375.gitgitgadget@gmail.com>
 <xmqqfqyq8lwj.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqfqyq8lwj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2026 22:33, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> This is not a new problem, but is it just me who finds this
> "feature" more about "because we can do it", not "because we need to
> have it"?  Stepping back a bit, why did we add these three options
> to "stash apply" in the first place?

So we could have meaningful conflict labels for "git checkout -m".
> If there is no good use case, perhaps what we should be doing is to
> remove from "git stash apply" these three options, not adding the
> same to another command.

I think having better labels for commands that are autostashing is a 
good use case for adding labels to "apply" but I'm not convinced there 
is a good use case for "pop". As you say below is anyone really going to 
type out the labels when they pop a stash? Scripts should probably be 
using "create" and "apply" rather than "push" and "pop" so are already 
covered.

Thanks

Phillip

> I know that the underlying machinery to allow different labels were
> invented for "checkout" that automatically stashes and then pops
> while switching branches, and the "checkout" command wanted to use
> labels that are different from what "git stash pop/apply" uses.  So
> I would not question that there is a very good use case for the
> underlying machinery to allow us to use different labels.
> 
> But was it really helpful and necessary, beyond "Having the feature
> exposed to lower level component command like 'stash apply' makes it
> slightly easier to debug", to add these three options to the "git
> stash apply" command in the first place?  Who in their right mind
> would type
> 
>      $ git stash pop --label-base=B --label-ours=O --label-theirs=T
> 
> every time they unstash a saved change?
> 
> Maybe I am not seeing an obvious use case, but I would blame the
> lack of justification in the proposed log message for that.  And "We
> can add the same three options" is not it.  "A caller that wants its
> own labels has to..." is not it either.  Why does that caller want
> such a strange thing?  What we have in the proposed log message is
> exactly "because we can" and not "because we need them in order to
> do X".

