Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6418872A
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037550; cv=none; b=p0wtURKN3PwsplcTdmjmQk+5gu/GNHw1vxe15+5geDbRWzZ8jACbThJ0Sb08DrLbTekbb7w6TxjsQ2qWwC52vrtViIJU9+0KLlLdnR9Ct46v8LpS2oPfduNsRKdjyjPl0uusSK8EwTHHmBG2yitUqjo7VkDxY6fxfSJNsftF5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037550; c=relaxed/simple;
	bh=bIh8Pm5fCw5nvBUpAZ4Rjvebo87b/aPWkeC+9RJ7Sxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GA9hHUjRY5vS2Kob5VeNdmRvb2FZoisxFV5T0z81OKI46KBpMZt6HoIa1TtyUObl+6xtBullGjqTRoogr2fMXA45lh65QGvHtADYgImYZIjq76YlcTRw4JFXI0peDYh4Z/HIcg/9tRfyfMl5GEpiMfaD0RAEtDtgfdwWZ2pKQCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODxNC68P; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODxNC68P"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b8f92f3db6fso1144025366b.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772037547; x=1772642347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zw63xfXH1zzOaLkz3sN/btq7NO2EZYrCDNHhh8u2Z2E=;
        b=ODxNC68PxBgFeSWnkwkTdFJEwse8BcbmhGK+0rsmzIjPqQm06/Qoa2iVUZKOSBx/cw
         RCkXZoIWWOf7G8tcAf0fiZSmSoW9LaaBnM5hKcXPn4LG0iOTvMMaJwRWbPP3wk5msSUS
         nTDJ5nYxW4+qpF5v9vNuLqg7A5eYUT+DrRqCzpXum6u0Zwx3QR7SW9rjKDoywimZTQpG
         1MrGJCDONyieXK/wIzRn2+4LGpkK8heNmXu796Z/fdht2PXWmMaJxDlUjNQZtsQzJ0oT
         PzvT9kOmYmFOHdh7cPtF43Y7lvUQjRYofPRdZiXQ1da+fd9JKKyAdNlIaX5e8zvAP9Br
         KXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772037547; x=1772642347;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zw63xfXH1zzOaLkz3sN/btq7NO2EZYrCDNHhh8u2Z2E=;
        b=AsBpEuri9Uex+CRtPw4LMtrgkJAB4lye4K350GoMSDOJOy2YxRbS4gJJpHs1Sdlyuu
         xmk3CW4CVTt7vL0RpB2e5ede9wM3QOkPWqSheulRFpcCSUYW/a4p3VznptPBgovGRauG
         U1RvLOIhHKMg9DOVcM5a4s2nSnyZB61Q/SP9sERjueq06xWpF8cTlI0alqmwIG0uPh9p
         9a6AWOLdHCrN45LmKVeOAqkNtpF3xZXO7FzYVn+RjdOje8vafSCDeaajjBuklPrz0Wjx
         gpNYLUzRYH2JYCxZMP6PNPYKBPc6/84d/RI/socGzHr0N+0a09sUtPvIqLL+iU8xYFuC
         LmFQ==
X-Gm-Message-State: AOJu0Yx5uEc0DNhI/xg2Xij26ThTGakePSKGRNhEkMV+SHfLiit/MIog
	CA00c5aDT8m6ItUXbWHFomO77/NSaE6fIr7FNnm4yq6zl2ac/AgDcqzu
X-Gm-Gg: ATEYQzzMx7pOrUYUYg4ZyotqqLSpsZzkQ2D+dnf/jvkyiy2yVQCzgeG8m1x4DIl9Mmt
	iW9hc73jvCUk520hITm3piJcgt5kUCABjp+Pe8C9RkNtFs00yjLUad4FHiELUmR7NQGyWWZUdmI
	09C2wpsD6eaS3cz5FxhZywfqbKEpXnYFlRNGYLoAlPEYjpJDIyhj1Hvnsp4T27HwOPAzfWQTnFv
	fIODz4O/vfR22hX/qh2O2aB0R3x1vU3ZmiNf2Di5kzJ0i9VBDbmPXrfiBhb9wq/cBqKQnrFclpP
	VNkegEGH+aB9UcWvx1+fawmlaJAQxV93PySqrTdgBD9p5HhxUbwmvLoTd8T8yFtouW87bYnA7Iy
	l9ko/Q+3x6K/JH8n24dIhqi21qlzKFsza+VAsCaLK1cq7GI/fFPNzty+80+kfKWgSBu3o3vLqmB
	KqqPUSUiCQvI0wAcgpTa0bUpL7rqMHIUSBuZOso5bWau3qgwUWcrilmp/zvTiXyVumE3CZpFuie
	obTSQ==
X-Received: by 2002:a17:907:9615:b0:b86:f194:9eec with SMTP id a640c23a62f3a-b9081a1d6efmr1224076366b.18.1772037546654;
        Wed, 25 Feb 2026 08:39:06 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e4ba17sm537507566b.33.2026.02.25.08.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 08:39:06 -0800 (PST)
Message-ID: <8397f971-39dd-4a18-b520-3157ae15324f@gmail.com>
Date: Wed, 25 Feb 2026 16:39:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] wt-status: avoid passing NULL worktree
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
 <cover.1771511192.git.phillip.wood@dunelm.org.uk>
 <902295b87146e5cb5358cebab51f8d66701290a8.1771511192.git.phillip.wood@dunelm.org.uk>
 <xmqqv7fs4jlp.fsf@gitster.g> <xmqq4inc4ghg.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq4inc4ghg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2026 20:37, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> In other words, the function is_current_worktree(wt) may not take a
>> repository and always compute things relative to the_repository, but
>> once we wean ourselves off of the_repository, we would/should have
>> repo_is_current_worktree(repo, wt), making is_current_worktree(wt) a
>> thin wrapper for repo_is_current_worktree(the_repository, wt)?
> 
> Eh, in light of 2/2 of this series, since wt knows which repository
> it belongs to, what I wrote above does not make much sense.
> Allowing callers to give repo that is different from wt->repo to
> that function is a potential foot-gun.  In other words, isn't
> is_current_worktree(wt) using the_worktree and not wt->repo a bug
> already, I have to wonder?

I wonder that too. You, Karthik and me all initially assumed that the 
current worktree would be defined by wt->repo->worktree matching 
wt->path (the code actually compares the git_dir of the worktree and the 
repository to accommodate bare repositories but the same principle 
applies). The use of "the_repository" in is_current_wortree() comes from 
replacing get_git_dir() with repo_get_git_dir() in 246deeac951 
(environment: make `get_git_dir()` accept a repository, 2024-09-12). In
get_worktree_git_dir() it comes from replacing git_common_path() with 
repo_common_path() in 07242c2a5af (path: drop `git_common_path()` in 
favor of `repo_common_path()`, 2025-02-07). I suspect the replacements 
were mechanical and not much thought went into considering whether, in a 
world where there can be more than one repository per process, they 
should use the local repository instance instead of "the_repository".

The current situation seems counter intuitive and I don't see what the 
benefit is in defining the current worktree to be per-process rather 
than per-struct-repository instance.

This series isn't in next yet - shall I re-roll with an extra 
preparatory patch changing is_current_worktree() and 
git_worktree_git_dir() to use wt->repo, or are you happy to have that as 
a separate follow up on top of these patches?

Thanks

Phillip
