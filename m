Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E118FC97
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707542; cv=none; b=BGROl3Mv930qVi2iSX0nk56PN0+sYa1w98/kUd1vpXjSG/tktt8hVD3RGGy85MCpOKsFAqQQWtMA8WuIIlHhsamP5X146acJukAeHsbsbrONBKP7aCimaL0DsmhVfPw/BnVfKGcg5HPlJkpm8nN131j2fEACyHQXByjla/+LoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707542; c=relaxed/simple;
	bh=3KYJN+QYf4zR7UC+BaW4OkPz4Ci8ybmR7hcO+vQllFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3xk+gV4b66kNZM/b+jPnKXpO1wSRiHdVfiC4rpRw2/v6qpUzQvoCB2ManFzAIqkKieJkFlILzEV5x4aiAbu8Jz+X7e8qsIpgwAzScx4EQ0urThnt15G4iG1ORGm+QxZxUiWJctNTeeA/PasOabITCtmoQvuNXQ8adwYehcmEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwqzvDg4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwqzvDg4"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3dae49b117bso1862194f8f.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757707538; x=1758312338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pxw7t1F7Y+rSyb2Uws6rSjTokjqQzpQuMET9GKWLEsI=;
        b=CwqzvDg4dS2AKAc78s1lpDYvzxEQP0dX0P242CNOA4MZCxANEZzy26lw6DSAQimiD2
         fh1LJ+AkaefSgIV9boaT0y10/8mU8NRN/d7AEp4VkAHtAYgeyEaiF7Hbcxc8J9d28HX2
         MDVh3ndqBMQeJd3h3LfjFgVUMO2ch6zqs9L5R9x0eJmtNoK4fkPVwX8JiGvXNlQQ9nQF
         dArK9pANAnWCsrFXKV8tZfQTtOJTWaaHf57xMcdtM0QUsi30kTiXr7QWHgZ3HAZ5V06D
         CGIbR1bOaOHQD+OOE+UWz5/igfSy91V2wD4rK4iSkUex/StKmK3/FULb3btKPOdKYkul
         dtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757707538; x=1758312338;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxw7t1F7Y+rSyb2Uws6rSjTokjqQzpQuMET9GKWLEsI=;
        b=lOYDA57y8nIQNkHGT+S1EW8ZMn5rI9iaec2fMB9yUPHOsDrDrK7+52k59+Y+o7453m
         dq9OfFaXgCVQcUFeb/l8EP6zRuDnUjK7hiYVk5t1Fj96rDv2fXQM9s8GX6goF/qh6Rcf
         jHI9OHm4ndOs/aiTtoYc2mtGU4Ar4Y/686YVryeaAuFS/zleZqCOanJBsqUfp/n6dBMr
         WozCSJ7SdJDNZhbNSsyRDQWTtDRFfBmaLdJLmr84Zn6WPuzVPuti48vXMnkVTSnSoCVx
         KkI2ZWXAPsduF0rnrERMe6tAKMllBTzCxQZxBJLZ9HX22Efp32ucJHGp3/B2gvz6k3xp
         /UrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ieZ2yfe1KQoTRcpZWUywB8i1Aitn+7+wN8Nax6EzKuIRokQWx6oRUpO/gmcnejaH1p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ipDaR1ht127+KxHT+Rk0CimJzuHh7h/zANQLT/Tf2tO2qOxL
	VUrYmtGTt4FYa07UdNMbDVNeOddLJgLr8F50UHviag6jjZEfRkU/5GRs
X-Gm-Gg: ASbGncvP0HSDXXEjfof4R2+drO6rpk3uA3MZSBg0nuayac2IudzxsdWRtFkPtu0/rYj
	QYH+YcFKkjYQftgWcUqqRGyhgrcGxS5FfQbRe/huX9pg9ppbf+5GOaGZRYoHNyTkmZSKjdTmalH
	H2LMVGl0SfBcgJoqcDvkWf8aJqD4SA7VA7hfwHes0/4HXxfhKohF3XJH8Ck5zOxeR8XAbx4+wjr
	iu46JwSNLx1UBTM6fjrCq+Y9WtAJ0xGkeP2usez6pCqtjCOrIaxbQqpEuG8MOqZoqMtj4jO6QNM
	XNexBSZWCc7bRmUvV7GeHka2i1uQGgExyEFiC5xHOll9meGBuOK/X9twv3DhtxDZYEvUkbR8XY5
	HofMGBm9AWEB30inNZSTyLnrjtIYCyA/j9ZVUiNxNJdd7z6OEVx351vSkhktBOXGP743i1b9S24
	o=
X-Google-Smtp-Source: AGHT+IEOjjf3JXr6j8132ZSJwsDlfGKM+HRS9ZEif+76lWiYCwp4PbguyxHpr/GbRHok0iHzfjOtDA==
X-Received: by 2002:a05:6000:1885:b0:3d1:61f0:d26c with SMTP id ffacd0b85a97d-3e765a0147bmr4368123f8f.54.1757707538201;
        Fri, 12 Sep 2025 13:05:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e84de17f9bsm437076f8f.49.2025.09.12.13.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 13:05:37 -0700 (PDT)
Message-ID: <4bd78e37-1d96-4d98-b77f-47520200376b@gmail.com>
Date: Fri, 12 Sep 2025 21:05:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/11] contrib: remove "git-new-workdir"
To: Gabriel Scherer <gabriel.scherer@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>
Cc: Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Todd Zullinger <tmz@pobox.com>
References: <20250512-pks-contrib-spring-cleanup-v3-10-32e151b0bfb0@pks.im>
 <5580aa89-09f1-426e-8483-c99481c998ab@gmail.com>
 <2b3c951b-0400-4cc5-b790-17ff77154ec2@app.fastmail.com>
 <e6003a2c-bc1b-4cf5-aae7-ef5aa9c82f10@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <e6003a2c-bc1b-4cf5-aae7-ef5aa9c82f10@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/09/2025 16:22, Gabriel Scherer wrote:
> 
> On 08/09/2025 11:58, Kristoffer Haugsbakk wrote:
>> On Mon, Sep 8, 2025, at 11:28, Gabriel Scherer wrote:
> 
> Thanks. I just tried this, but I think it does not suffice. The --force
> option is available to "git worktree add" to create a worktree for a
> branch that is already checked out. But typically my workflow is to
> create a worktree for a new feature branch, and there from that worktree
> temporarily switch to an existing branch using `git checkout`, and there
> I get a hard error (if another worktree has this branch) and there is no
> --force option to override the worktree limitation at 'checkout' time. I
> just tried to test whether worktrees created with --force would allow to
> switch to checked-out-in-other-worktrees branches in the future, but
> that does not appear to be the case.

If you really want to checkout the same branch in more than one worktree 
you can use "git checkout --ignore-other-worktrees". "git checkout 
--force" predates that option and will, amongst other things, overwrite 
uncommitted changes. Having a separate option avoids nasty surprises 
such as overwriting you uncommitted changes when checking out the same 
branch in more than one worktree.

Thanks

Phillip

> 
>>> I understand
>>> why its designers felt that this would provide better guarantees (it
>>> is not a good idea to mutate branch names that are checked out
>>> somewhere else), but checking out various branches to test them and
>>> inspect their code (before returning to the feature branch I am
>>> actively working on) is a common part of my workflow.
>> I agree, that’s a great use of worktrees.  But I never feel like I have
>> to checkout the branch itself.  I detach on top of the branch.
> 
> 
> I'm afraid `git checkout -d` is not part of my typical git workflow. I
> could retrain myself to use it, when I get into a worktree error, but it
> is cumbersome to know of this new complexity¹, and various things work
> less well in detached state -- for example my bash prompt tells me in
> which branch I am, and in detached state it only shows the commit hash.
> 
> ¹: it would be nice if the fatal-error message on 'git checkout' when
> trying to checkout a branch that is active on another worktree would
> suggest using `git checkout -d` instead to proceed. I may try to send a
> patch to add this information.
> 
>>> Getting a 'fatal
>>> error' because some other, independent worktree also checked this
>>> branch out is a hindrance.
>>>
>>> Note: I don't know about the `worktree` implementation and whether the
>>> [snip]
> 

