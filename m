Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E914AD07
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127523; cv=none; b=oyqtfvrzMLXvligctsZUxP8wwn0CYL004zgAbv0+UUGPDZXVj2y6YBtgp3K79+CVflP+p81Fn0yFQm4QXk9FlUfZB4dQ/s1Q+LKKWMmoXqR/vAh+I/oT+I3p4lSo6xpsssWBkpNdNhPx0bXvcTgBUqnwDGpCKymkxG5nZoVR4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127523; c=relaxed/simple;
	bh=ijfFJw4pavqaKIg+gF0lwppuBinr3Y1aDsHszPCnSKA=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Wp7qyDnwaPhSrXbbTITeerbcAeo36BFfsc2pNL6UeIDpqsAQo17xjZLeSNF452J433Fc9YNOZncf8VgwuXyot2sv16HgZrZdmw08bO204bnofbHgzYUem4xQcK0bXIMMAv0zkMde3HYeTDY2fMPfTWDrYT4m3KWUFtfe91Rh1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIMp82IJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIMp82IJ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68f5cdca7a3so6150526d6.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 05:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709127520; x=1709732320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXMZF22yt1Vx0+U+Hgn4ZsIlDFFXkmibfHLAmYRQPtc=;
        b=GIMp82IJZFDXBSBKbNNUqHrLMOErcPVUB8pGkmHQ5cj+m2vugIWPmU9H9HsLfKv8vZ
         gwHeVhE+G8ReCWkSDcmIjD+JidSacPwVDAmGtXEago/G3vVEnvSpLqeAo1ohDapIc9F/
         ARsKymGzKWoHQsXYpY/isOkBn7Sdihlh6IDwKah1k82NJRZI5N3GLiL3V9kdg20LSJAq
         uf2xO8O7dirVMYGL5IoNk047Bvj1o33d76k61kc1BzCy8KVtpetWLqX2vwLa65Zj6gFH
         3Ma9k5RYu8gi3TTPWjzPDlk0woVjzU6XgFB9uPSsLrWAz+Y6MMmcqvB2mnuLXWUmqMMI
         4sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709127520; x=1709732320;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXMZF22yt1Vx0+U+Hgn4ZsIlDFFXkmibfHLAmYRQPtc=;
        b=Tue8RDJqwhDRZUbeAZ7RRRfX2ruXPYH4T797u2Ix/2t4UKVkq6UlgPZjLn7E7LRQ7f
         hFcCpQz4TRGNNbmxVqiM0Xpek+31xrmG9+kPKUYy2Q9+1Das9CF+aZak3Bl6gmcebWUr
         Ufaw6eUxX0VcQGuJC9dgbMlTy+SPtkmGEABMJJkxrzJ5gY0HM61HG37R63r+/WEow3on
         hgWQAAXMKRlm87m8ITB99+1Y1V/F0XWSY4b0bIBEY1XumnXvEUlz+C3vORxLu3ZwmTfM
         bhlidWU55neaHyTpsOaUhvm5FQPUy5lqbhgxqkS03HhI13D04P7GdwHnXlfrLSdyaV2z
         7bCA==
X-Forwarded-Encrypted: i=1; AJvYcCXJX77/3PRpYbzeglS0SCsjebg3fcG6kFQlykLuDLS/ZicmCAlnTxdAY6vr+OSkPzQfvvP9w3sotLpsuf6fIIjF4lE0
X-Gm-Message-State: AOJu0Yxwzi7FW0N6uraoeJowLlfVSMSKIG0qy/ST3ZqFq23KPyXsiDxI
	HvuiIGD4WhQenVzpW3CTwfIZKk4cwGsxz4ZkbGJg86y+cwSaglU1fYzvpqYz
X-Google-Smtp-Source: AGHT+IGtm2sjZ6XZYrUCrK+GdTkvvdWI436lww9z04xoGyDD7P5C3XU9uVzseMKwX0k/0UE+Jq8XxA==
X-Received: by 2002:a05:6214:449c:b0:690:20bd:7abf with SMTP id on28-20020a056214449c00b0069020bd7abfmr4732877qvb.4.1709127519985;
        Wed, 28 Feb 2024 05:38:39 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ff90:f134:2d0a:620a:ef80? ([2606:6d00:11:ff90:f134:2d0a:620a:ef80])
        by smtp.gmail.com with ESMTPSA id g7-20020ac80707000000b0042dfa55a3d5sm4546529qth.25.2024.02.28.05.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 05:38:39 -0800 (PST)
Subject: Re: What's cooking in git.git (Feb 2024, #09; Tue, 27)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqjzmpm9b8.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <dbfc2788-1a02-2b5f-bee0-6fae747ac92e@gmail.com>
Date: Wed, 28 Feb 2024 08:38:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqjzmpm9b8.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-02-28 à 00:44, Junio C Hamano a écrit :
> * ml/log-merge-with-cherry-pick-and-other-pseudo-heads (2024-02-27) 2 commits
>  - revision: implement `git log --merge` also for rebase/cherry-pick/revert
>  - revision: ensure MERGE_HEAD is a ref in prepare_show_merge
> 
>  "git log --merge" learned to pay attention to CHERRY_PICK_HEAD and
>  other kinds of *_HEAD pseudorefs.
> 
>  Will merge to 'next'?
>  source: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>

I'll send a new version with a reworked error message, so best to wait.

Thanks,
Philippe.
