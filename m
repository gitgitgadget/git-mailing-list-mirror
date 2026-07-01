Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1D3F39DB
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901890; cv=none; b=KkeffoUMniXp7XfDli/v99KenNIb+3TMZ7PdtGSudHOrREjZYRIfITEPUDFavdgck8oWgJ6QH58lEUv5rxofx4Ar5/8f73Alrg82B7pYwMnNuQIBpC3sffZgbT/Z/zmfcC2cZ3Gv2AhP646z7hF1uQxkfrzSAf68NVSrJ0Q9lis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901890; c=relaxed/simple;
	bh=6e8/ibO8LFcmVKxBo6V7MX04Dl/RTIahXjrUQNsGItU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zt2FQqIBnq9jvR8TeBdDFXUlcNPAksvAgEPbRr3p/48qH/wnJuRULq/T7L59sZQZSw1Z5antV+1TIRCfr3i+fCx/Qg/bzrMeHe4QT4TiSoE08+Dymm6bfEXbADiuN3uoMxQzv2qQ4UsHJFslsauTRyESnIfXH0BEp6A68djP0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY7tBX/j; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY7tBX/j"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6987cd38a64so970500a12.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782901886; x=1783506686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leueRkDGdd2bqtnrsUn2KXCpuVr+cpgxMyd0a6l9spA=;
        b=XY7tBX/jKXhv3ZRTG3zRtHfrS2hShjaoQmUxVE2mP5ROqwFNgHW0IORO+k467JOb6x
         XrXxCZLQzOsNxrGbLbvu7DkO/8S4W227wY2RK2BRGeN58YRc1WweVT2/NziWwmoyu+9k
         aPxuYXrjkYlpzrvpcprr51HjfVRuuiNI7eO5kMEnbSnXMdZwqKHfX363Ujc1PnFuHPdp
         JPzH76EzxnWCX30dc4FmMza3cqYMUa6f3XMWTlUp7iz++Rw0ydpQg3oKjAZ9F2qq1vI6
         1n8UcZ1DXyXmtww2xvQ1BKNrssCasQOdA3Js/qBBMc09EG7AMSDviHdEKxV621mqBhvD
         BqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782901886; x=1783506686;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leueRkDGdd2bqtnrsUn2KXCpuVr+cpgxMyd0a6l9spA=;
        b=OFLpiWRYvFZclH+bLafzW6SfJIALinzZ9ymofIqP9ILEvi6hs54WcIiTTHPHzl9rXr
         eutu4W+Lr7YMI4s+QMwHZgRZZXaXxgKSrGgwqwe44/qswFyPsZ5LW/GeqWBtU4G/dUCJ
         vWtnNPgdJXoqW8pQLLBF1FX9mAnuJt0xmU5mZEdJnyPKKsgpLzixoqVXb1w8AtxgJY5w
         Kdn0e5Nw3uv7e9qxtI1Qy6QZLyRcchPpSAeTuv3RU/6VKTCiwuLnvcN+n9nY/9eFYRCu
         PK+vBw19f0WPnmcht3hBlRjaBxz+p/L7H4zwluzJulQYWsjqjH3QZx3/8JYVq+svsliv
         phCw==
X-Forwarded-Encrypted: i=1; AHgh+RokMNgEuHpfwvNuuR2M3yg3OHo1QrsE4HLu42CdU+ThmO8jJgy5KeBExC06otYpQeppE8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbE5FCx+8Oj+pM/j+DkLbUkNYO7jZe2NvjhPIYYUb9zu8zo2z4
	rH1VJqvT5ksqbPVGgmaGim+KdFZvspejPWD2TPHaT+Ni22mogQ0tmdQN
X-Gm-Gg: AfdE7clcovgklHDYPxxBsPejYOmemF+s+XBjzXsG360IDhANpiEpZaTVoe26kTpZk2F
	hqYOqsa+eMlBHYiSxClczsqCcCEG+8Ufc3suzzqZldKHAiZDQ5WerScgRqS4AqM2eeOKTEh/8Mc
	6AaXxyVxEf7vWiywcx7/YmJxRarJcEBEb/VQ6MDPWeV24foNwNwq0Y+POJpxkj4LdKmgGms+gKj
	uWLd0x7QE0ixHuL7T+12Kpg6e9tTyInCzbKkzgd6ypn6+yiELklaNqGHRzVdaaCbyhCmOnsicQF
	6BiweLoai9LzSjtF7YAPX6MxRL8lcu6bNxJoGIRbo+vskFpSSm1HgYBT7yhjQv2PwTrt+APOFVd
	aHlb0jU37XDFC5wsBRmlph7jDNHN5dLKcyNAt+XXGQai+hfjH8LvQ/e//xC3q4/IgB8ypeYecnc
	0h6/7Aa5UJJzToPVyrYJW9cYE3PSCMPj9TREh6MIRie55JRpyEna35B9dpkcTpLkvLqwI=
X-Received: by 2002:a05:6402:a589:10b0:698:ff3:85ea with SMTP id 4fb4d7f45d1cf-698819cd1aemr2089813a12.5.1782901885467;
        Wed, 01 Jul 2026 03:31:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c98921asm2405587a12.31.2026.07.01.03.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 03:31:24 -0700 (PDT)
Message-ID: <f15456d2-d8b2-4edc-80b4-3a9d8fc77da9@gmail.com>
Date: Wed, 1 Jul 2026 11:31:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com> <akIQLM6xZTHBudWT@pks.im>
 <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
 <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
 <CAHwyqnVN=McZjtQGcPnoVOHAd0+VDNPXy_N949VMsqZty3RDjQ@mail.gmail.com>
 <4b505228-4846-4a48-9255-e249f4e70a1f@gmail.com>
 <CAHwyqnXoqZYHodWXHtwnk0_PiZcCYSVL+WgL3h5nWiYx_cSZLw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnXoqZYHodWXHtwnk0_PiZcCYSVL+WgL3h5nWiYx_cSZLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 30/06/2026 19:38, Harald Nordgren wrote:
> I want to avoid creating drift between this and the format of 'git
> rebase -i', so if we want to change this, maybe better to change both
> at a later point instead?

The reason we're introducing the history command is to experiment with 
providing a better user interface for rewriting history without being 
bound by the limitations of "git rebase". So I think it would entirely 
appropriate to try a different format for the squash message here. If it 
turns out to be a success then we can see if we want to use it in "git 
rebase" as well.

Thanks

Phillip

