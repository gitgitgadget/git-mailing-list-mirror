Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8C3DA7F9
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905288; cv=none; b=pbclKJPPme5ERmPXp5qNCTKCwub12gvhuO6ENMq109ctQHFUmmXlkUL2M3A9ZMg3OpF6VMqqOts/m7lU1PC8YlV16u2f7jPGs5bJ3pNBxnS7HFMZhcCnvlcl2gw2ug4XiAxeQVBr/FrvUFkMx5Qq/Zou6wm7Yw1n+o7S9zsvhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905288; c=relaxed/simple;
	bh=6bB17oouGfN8eCLSIFA+NiV8iHRP8dCGfgU+JBzMH1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWV0x/FjKOkcupDvfH9NYaG7rrr6b9udRBFYN1LIMOQadcw8o4JNJSnKD/45LV56rp/sCvOrrFM2I5WLdlETMjk5HIqc3ChgzE99ph/DNWYq27Hi3KmRCW9XBujF3je1kMhMD0iDPPNcSn0SEV1cLugPGnGbrP4PlbWKdQ67VYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv0pD3lA; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv0pD3lA"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4359108fd24so235378f8f.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 02:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768905282; x=1769510082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=souJmMBLPMBsLDwuJyL1ZdRYg5jfnOCM3i/Kt7HRqMw=;
        b=gv0pD3lA2w/D3GMeD7wvHwioIJdxk2f63dpuH2kj/yk1sXSGYPSTS/CNAPR2unadB9
         ZPOgzY2CVP+bmXGz7+CrZq5oB2mXj2ewNGq4njRO2Pa5RW2+vp9m0yBD++frFIgP7zBw
         dkkDLMivQeRjNKhEpc393QijulwD1LWtaAtnWYEov36ZRxfWq2FNXPYG3plYP1d9UICy
         hxV0+GqyI4nKEfkpcApwKPYaAH8cfZkEBRC/rBcEstEWa77+bmYUptI9RWKIdOcsN9f6
         hRtgqcsznYArKviCaMWMdJwxd79ZJ4AiOiEP4Se6jeQS+Hiz+xjwmiULye4eWk0rnyJ/
         pC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768905282; x=1769510082;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=souJmMBLPMBsLDwuJyL1ZdRYg5jfnOCM3i/Kt7HRqMw=;
        b=saEJm9JdzlwVYKds9iro+sfoibpAEE8fTNRVRHj169eZUaZ8pwX8TeiFkUIoCvrm2K
         eTZ/r9eWVdMa2NInr5O+cR540WLSjybTIsIpSFylHVvCvD2NKRm9o5E09TDIrxF1j/mY
         hQ8uFFDPg5ElzZF7b6SEzUjUICn13vkgU5Mn4xhspkruLaLYBi7+Dh/jmpcK6id0FoL4
         0dlxQblPStzzF/ih/1cT1b4qndGoo2oNOxuKwEEXK2CemCbJglfWea+P+2qaaqHAcc2f
         IAbAXd59lIS1dQz+R7366wS3r8grAcjxw/OA1jfsqlAPt6TO5WZIvPPwAVqbTdP/2yoM
         Wgmg==
X-Forwarded-Encrypted: i=1; AJvYcCUkVt0PqpSV/DhwoOm38l2NaqBuW/ok7U2LqlSYbLpIdxLcgX73f0yReL3j+jAvHaSJqIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7HTTvkhAetdSR1I6JGAteEPgg7SHV3UXt0YyzjENLFJbuVKN
	b3ecEHAqXgjLafevdpglRVQg7RqAOZfX2trROnrOwL+GVfZ5BN5VqY1i
X-Gm-Gg: AZuq6aLgtI40DR2FAC7Efr5rGKV0IAtF5AvxQcNDJ2dkmmBWhcBb3sM5XEI4cpp9Q4K
	OjM2HVBiiJ2h3ZXlCCGQ3ue/R2wvk1cdsH+1T2Qsr98LkT//UnNvcELkRIxzUmfJhnl6o0z0s5g
	74F4bVMsLAi7me30J0EpFbUYpGwC4f5o5FqrFvomUm9yrIbkneB9drsfGnNp0+7NV27y75JMJzO
	FcWGBMQQkIgx3LvYZhMj+CXezh178wnLej6ddmGUIUnKv55P7ogOH9GHdP5wwGzJSma8ZRN/Sh9
	iWtuHaK1MUG7ZlIeiHUsHS5y2XaivKNU+cWSJLWuK9n3GhS37HwXDhobDLducUZyUY/ttw6kwiq
	dqClhhO1qLT4qqQOptPcZVACRlhcmjjzHqjzXogxud/1quuQdxqCqmq289TDrYU1a+KCk0kz+5j
	HLqttgWvsSQpy+TBIL4+Q0U7Tg9GlMB8Af+99RhD4DIfjLIwSq/fQ11oK8N2D5mv9Row==
X-Received: by 2002:a05:6000:178c:b0:42f:bb4a:9989 with SMTP id ffacd0b85a97d-4356999e3edmr18960373f8f.28.1768905282033;
        Tue, 20 Jan 2026 02:34:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569927007sm28474477f8f.16.2026.01.20.02.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 02:34:41 -0800 (PST)
Message-ID: <79c29032-dc32-4030-95ad-dfbd50d9b6ab@gmail.com>
Date: Tue, 20 Jan 2026 10:34:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
 <b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com> <xmqqa4yc5brq.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqa4yc5brq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2026 18:34, Junio C Hamano wrote:
> 
> Yup, I generally like this direction, and introducing NO_P4_TESTS
> and NO_CVS_TESTS would not be so bad.  Here is how it looks on top
> of Dscho's patch.
> 
> --- >8 ---
> Subject: [PATCH] ci: skip CVS and P4 tests in leaks job, too
> 
> Looking at the CI logs, the p4 and cvs tests account for another 24
> minutes of test time and they offer minimal value for quite a
> similar reason as the previous step.
> 
> Let's introduce and use a mechanism to skip these tests to save
> some resources.

The patch looks good to me, it is very convenient that we can put the 
test in the library files rather than each test file. Should we drop 
these tests from the ASan job as well?

Thanks

Phillip

> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   ci/lib.sh       | 2 ++
>   t/lib-cvs.sh    | 6 ++++++
>   t/lib-git-p4.sh | 5 +++++
>   3 files changed, 13 insertions(+)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index a165c7f268..3ecbf147db 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -356,7 +356,9 @@ linux-musl-meson)
>   	;;
>   linux-leaks|linux-reftable-leaks)
>   	export SANITIZE=leak
> +	export NO_CVS_TESTS=LetsSaveSomeTime
>   	export NO_SVN_TESTS=LetsSaveSomeTime
> +	export NO_P4_TESTS=LetsSaveSomeTime
>   	;;
>   linux-asan-ubsan)
>   	export SANITIZE=address,undefined
> diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
> index 57b9b2db9b..c8b4404888 100644
> --- a/t/lib-cvs.sh
> +++ b/t/lib-cvs.sh
> @@ -2,6 +2,12 @@
>   
>   . ./test-lib.sh
>   
> +if test -n "$NO_CVS_TESTS"
> +then
> +	skip_all='skipping git cvs tests, NO_CVS_TESTS defined'
> +	test_done
> +fi
> +
>   unset CVS_SERVER
>   
>   if ! type cvs >/dev/null 2>&1
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 2a5b8738ea..d22e9c684a 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -16,6 +16,11 @@ P4D_TIMEOUT=300
>   
>   . ./test-lib.sh
>   
> +if test -n "$NO_P4_TESTS"
> +then
> +	skip_all='skipping git p4 tests, NO_P4_TESTS defined'
> +	test_done
> +fi
>   if ! test_have_prereq PYTHON
>   then
>   	skip_all='skipping git p4 tests; python not available'

