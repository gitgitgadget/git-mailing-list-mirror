Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B315D5A2
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966766; cv=none; b=l4Z3aZObC1WEsRiPSGJsAB8f0E+Eeh9snMUUVQHm7wcDgvzpELVGoUiba0Y2Uhxiuas+Pesr1mjg0K2VU55EcsW6y4NvzAwJzPJUmCyeH/GuKQyvtPt3uY+IGrIhFzxkXEpvQLgMmiMP5+ar4HEiZb/tW1a12ZXxk5kBcDI9+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966766; c=relaxed/simple;
	bh=vCKXIu6ff3VuZOR/lLFCQKTStKdm5HGYH8h7fvY+eMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tr/j3Pmm0xnK0k5XBnYooDJxeEXMDZvneVSKi8ZvQPIG+C6v+M9aPViN6Kb0zBhaYp9332pNqEtXiL8gUvkEgspuQLSYBkENjwGbDyMVH9Vs3vuJGMnx0yOJ7KFGKhEEvTe/8LZgqckENBPkF8i91yy2aA3+1b9eQ1Nx5zCzOr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqXOe3gZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqXOe3gZ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41adf155cffso10864765e9.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713966763; x=1714571563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KOOcDJI1aQ0Dt1JtBWYzmP4qPh78rcdf2Papyr8y74k=;
        b=MqXOe3gZnXPn3XifUISbjhpz8tubsd0kF3St2tS+cDm4p9iVNZdfPaun6XnQOl8emW
         RXs/uxUeTQ/H9gXOWxqwbpXmxESFbLaqXlpNI+KEMjfLmHqHxbuTWqBAYR4wngRU8etq
         /aLnKZL9/3TWFC/MjZj3QxfyCChg4T9loYbHkYt4DcPP6P3+HPg87myMiPXK0Wed9Wce
         YBngWlreYb/yt7nRjlRATMK950INAEVDSner6TBJa6LNeWHeU7jntsuBGY5hxSgAayoL
         J0BgbpqP83j7k5w668NmBhg2Qe65bVoo391O0oVHIyJDikB01dRcoSZL13QETV+4g7Lu
         GQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966763; x=1714571563;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOOcDJI1aQ0Dt1JtBWYzmP4qPh78rcdf2Papyr8y74k=;
        b=rLUv8lr7lhZa/Mz/P5S+Q43XIXnITfo4isxxcQVciYaWghV3cuu/iokGau3+uEmav4
         oEihMdtoIE9NXWW50zstaxlTZlQJwRdJZsrnkj9gxpY6SWRFD7EBFRyXuJHD1/cXMseH
         WmKnzAL4TTJMPACg8xD/HHQhC8pwH6S1/plxVQEKLqUlN5u+hVgZyapHG/YajKnv1z4k
         KNlbYBpm0iaQnXFpu4M/Dn5ZI42ZSdo/PFJiiHp06ea+EQWbHn9zPDBOGiOVX/F81isf
         X2mASTCSH0KEswD3SMyJ57C5cKBUHYfC6o6VY5inxMFoQTkClK0Z5b+GeCuPmEBn6EZ3
         gj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWH80F2bCx+iSMcCw3FxvvlOy3iyGs7TRFjObqQK3Ny3VACd7PRKkKgc7m+9v5uSzkP9Msfv1YMCotZU+RFNj6q8yX2
X-Gm-Message-State: AOJu0Yx3y9B/uTf5TnLFybDqdsNiAJxlyKviyn7q8THRp3kinVmeyHDW
	K18DMRUyYkCmJ4sU2a7u2n8nxahX6iWBWyslASS+t7GwI4hseJrt
X-Google-Smtp-Source: AGHT+IFkJcEuKd4C30YLTH/QImRUhiWnrNa/OhtDjnAIeA9fG0yW7pJVC7Ri4kAe9yLKclMKn61pmw==
X-Received: by 2002:a05:600c:4f93:b0:419:cc9b:420a with SMTP id n19-20020a05600c4f9300b00419cc9b420amr2022303wmq.1.1713966762840;
        Wed, 24 Apr 2024 06:52:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00418729383a4sm23697913wmq.46.2024.04.24.06.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:52:42 -0700 (PDT)
Message-ID: <7d1d2892-d486-4e91-b100-e44c1d76893c@gmail.com>
Date: Wed, 24 Apr 2024 14:52:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: James Liu <james@jamesliu.io>, git@vger.kernel.org
References: <20240424035857.84583-1-james@jamesliu.io>
 <xmqqo79z2s24.fsf@gitster.g> <ZiirKgXQPLmtrwLT@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZiirKgXQPLmtrwLT@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 24/04/2024 07:48, Patrick Steinhardt wrote:
> On Tue, Apr 23, 2024 at 11:28:03PM -0700, Junio C Hamano wrote:
>> Do not close that communication channel on us.
> 
> While I agree that it might not be a good idea to set it for our users,
> the usecase mentioned by this patch series is scripting. And here I very
> much agree with the sentiment that it makes sense to give an easy knob
> to disable all advice (disclosure: James is part of the Gitaly team at
> GitLab, and that is where this feature comes from, so I am very much
> biased).

Maybe an environment variable would be a better fit for turning advice 
off in scripts?

> It has happened multiple times to us that new advices were introduced
> that then subsequently caused regressions in Gitaly because the output
> of Git commands now looks different. While addressing such breakage is
> easy enough to do, it does add up if we have to run Git with every
> single advice that we may hit turned off individually.

I'm sure you've considered these suggestions but (a) would it be 
possible for Gitaly to filter out lines beginning with "hint: " when it 
captures the output of commands and (b) would it be possible to have a 
script that parses advice_setting in advice.c to find the list of advice 
names so Gitaly can disable them? I think (a) would still leave some 
advice output from code that uses advice_enabled() rather than 
advise_if_enabled() but it should get rid of most of the advice messages.

Best Wishes

Phillip

> Now one could say that we shouldn't execute porcelain tools in our
> scripts because it is kind of expected that their output may change at
> any point in time, and that is certainly true. But the reality is that
> there aren't always good plumbing alternatives available.
> 
> Furthermore, we are often forced to parse fragile error messages from
> such porcelain tools because Git doesn't provide a better way to dissect
> errors. Error codes are mostly meaningless and there is no other data
> channel available to us than the error message.
> 
> These are problems that run deeper than "We want to disable advices",
> and we eventually want to address those over time. But it's a long road
> to get there, and meanwhile disabling all advice would be something that
> helps us make our scripted uses of Git at least a tiny bit more stable.
> 
> Patrick
