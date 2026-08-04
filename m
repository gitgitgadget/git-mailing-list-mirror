Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847F28D831
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836202; cv=none; b=pQhDtd29JlkLO0eUYijD6rzAiIN73nJvXT9Pdch6Cg+E7j6D26iMfl7IYatb6lsk5EtRV6KursgvnOPwlMjHar00jqq6J/P3koW+fvIes9z7I2Tsrz/h+iL1VvIvlfW7ChPZtGV21x/vOyozN1zpSX1xZsX9GLStOYJ+BmXLXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836202; c=relaxed/simple;
	bh=LuvGnc9GUxqJnK+aS+08BWZAwwGEG2ybl6KmS8qnw2I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K+fKqXGdI0IqSAF/jHDm6p9wbIT1jVZ5BXY18kOMXKXfUZ21vMVyyS7xeNsa0jsAfQyrs+vjq6+5n41LCWfIum4AbJqpSse25f57Eappr/PBUxSWPta2DnbKCd4L0+MRUDgQHQLKKldnhvAMbkp8TW/0naPqF3wwF0n6uTbbU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+bSUa3V; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+bSUa3V"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15cd3fd760so473364466b.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785836197; x=1786440997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t3333bzWH/6jrPim7XQ1nPiEIuKKjsUmwXmnaYD563I=;
        b=P+bSUa3VNLeYo1cXH7yOGNWQR3F1wKJWaSLjmD7EaXgTCcZMK7AN4sA4BPrdy4DI5T
         rxtXrAzdUPYjlSOm3kc89GrJSl+JHBcP6FH4cEKI7+Lu6uBr37dAcCXut7LGBMMWygPE
         fnmbpqjFCVqiu0hYdstAc62PLj84qPfENWwHCDekdi392g3soJ/lO5uBFEcGHfjQVzzv
         IVLMK1TSU/n5In8Y9NcUilOSjmYBYcKJacL2bf/w6DevvLd35MSYYefyB5LZ98iiVkkL
         2eA3c1RzVqG+BaV3szFTTlCTTZ03nTEZ5GVwV6e2MYwVbMo6Rvft0lQpil20omLApH1Z
         +Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836197; x=1786440997;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3333bzWH/6jrPim7XQ1nPiEIuKKjsUmwXmnaYD563I=;
        b=H8Gj6wwOKrYr0v9FzfxZpreyUb0zHXLWw+C+1DiIl4JH80qX61jae95JlMOn5Z86uZ
         XXvnc+ks2FzFkVCS43NhHvywrqcQvVVDnZzdVKNu5O1/uj1+xX0QQEM/zGxb4sCJTPPM
         gwE4N7rWOfCGztk20cLXAXdHcVXS1hT1fNb8DjOdXBN6fxSP6bgLYl3uR3DobyavvrmN
         o/JVnKuIKkJcQyPtqqnkLHsctONTPtC1NFxRBWawYBtl3dH5xKG2fHmHKH8n7bX8QgGn
         n29QQk8Se+ofMkLTixlQUtmxXQShPds90h2hy59T76k9RBGlw6FSVsPe9iNZybHbpqUe
         ECGw==
X-Gm-Message-State: AOJu0YwLyJMKJM7zRdwVgYN78j4BzlcPPa9So82ErCpnn+/4FdlAy5iK
	c9LQvJMSMLzN8Z8SapaZ+L1+P2wZEgDrQYFcscmosL0iWq6lb3zcMBfN
X-Gm-Gg: AR+sD128sfqSav24EnhBZX9lFrVA+E/KXi9q04rgnUY8YXWrJzt4SLYhwR7W8zw/iA7
	QU3VsUDP+1UP6WUNx9kP5pPuelIfxKdjgDagf69Ra8iBpg+UeriTTT6bqd2/s8kA+0Jxp2qT3EH
	M7QQSZU3UZU1PGfRe3J2Ej3JimqgZEcBrFDCegQAIWQzEb1Dj0oHUvc2l13HOWxBsWDmEebZFX+
	LL1WWLGF9qlg6orGRBSgIBrWDjnoU+oJb5blcKPUzV93XhRFxx0hH1JsC4vBgI40adfD1gTUSWV
	wPGJYcLCzhlmWKUVNk2ubXaLfLdS3J/0mmyqpMkQDIg1wgTDCIaDvbv7co+zHjDf57tCvChF9v+
	qRC1AKBrxSunARYd6IOjSuOGoR5u02r0GvAbIuM3jF7ZfXdPpAdcipbAky3O/k/ZgsoreXnCUU0
	cokKFgCmpAXvBpaAlhuH6FP2QAY0WbsQV2WCNzIUIlUMfCy6uA4aIZm/o1d3g+zLhKlrpMkpRGi
	wdV+ObuvI87HUFPm6uc/zVEw4oIAIix45+87y2XWcQ=
X-Received: by 2002:a17:906:34c3:b0:c16:209f:d48e with SMTP id a640c23a62f3a-c1fe8250ff3mr1018231166b.30.1785836196772;
        Tue, 04 Aug 2026 02:36:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4537702sm664403566b.53.2026.08.04.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 02:36:36 -0700 (PDT)
Message-ID: <49186d54-f7a4-40ff-a88f-62d9f44fdbcd@gmail.com>
Date: Tue, 4 Aug 2026 10:36:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a range
To: Harald Nordgren <haraldnordgren@gmail.com>,
 Phillip Wood <phillip.wood@dunlem.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Matt Hunter <m@lfurio.us>, Patrick Steinhardt <ps@pks.im>,
 "D . Ben Knoble" <ben.knoble@gmail.com>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
 <cover.1785750108.git.phillip.wood@dunelm.org.uk>
 <CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 03/08/2026 17:35, Harald Nordgren wrote:
>> These patches can be fetched with
>>
>>    git fetch https://github.com/phillipwood/git wip/hn/history-squash/v10-early-part
>>
>> note that they do not support editing the commit message of the
>> squashed commit.
> 
> Thanks, what should I do with it?
> 
> Is it a replacement for my branch, or should it apply them as fixups
> (if so how do we handle the lack of re-edit support)?

I'd start by reading through them and asking any questions you have 
about the implementation or the reasoning behind it. Before you send a 
new version patch 3.5 needs some work to print the branch names (that 
shouldn't be difficult the ref-filter has functions to handle sorting 
and printing the contents of the ref_array) and patch 3.6 needs tweaking 
to work with editing the commit message (I'm afraid I haven't given that 
any thought yet). We should also think about how to split the series up 
to make it easier to review: the last patch in v12 is over 1500 lines of 
new code and tests. It would be better if we could split it into a few steps

1 - add the skeleton command with option parsing and the checks for
     rev-list arguments and BOTTOM commits.
2 - walk the revs and add all the error checks for multiple tips, merges
     outside the range, root commits etc.
3 - add the check for branches that point into the range.
4 - add the code that creates the new commit and its message when it is
     not being edited.
5 - add support for editing the commit message.

That makes each logical step easier to review and gives you the 
opportunity to explain the rationale for the design and implementation 
of each step in the commit messages.

I see you've sent another version already - it would have been helpful 
to wait for a response to this message first. The mailing list is 
asynchronous so you wont always receive an immediate response to your 
messages. Each time you send a new version you should think what it is 
you want to achieve from that iteration. Simply sending a series of what 
are in effect works-in-progress without any indication of what feedback 
you are looking for just clutters the list and makes it hard for 
reviewers to keep up.

Thanks

Phillip


