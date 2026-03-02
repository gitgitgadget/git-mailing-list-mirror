Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179BF33B951
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476656; cv=none; b=ZRXxwlE4lHY+OPf0taVXU+T0n62whEVyzm1wCcvN2NVC2EDlpfWykEUhHAfankfOnoAdMkdYab6g9pFOrw3YIB/M4ZqyA0muT+Vvc02bCcb09uW9a63pUC9/2GBkTwkgEf6gUG3Y3QjvqwZkGZapjNWoam8z6tSjf4Iy8+OLKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476656; c=relaxed/simple;
	bh=vu5aZtiMIyNqDRUQNwj+6tZNzacRyjf7ADE5yvcIFP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfnxeKN7FgoARyp30Sq6oYTbCvZE1bBzew5YgP+2jSlzE0rAseiHTW4GySirOjC4d6I2wYBiVrH6jaU9hlNLK48ZkAshab9Y2IvNm6/wghrm32I2oOYX6UxmfK2/k+BfeOLiAMaoJRWRsXEl47o71p/RIudl2d2+lp/sVSYf8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7oayUDW; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7oayUDW"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899b95707afso66310786d6.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772476654; x=1773081454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4UBz87CiNOA2Jkk5fCcYqvy+CdsMVNhDGoYVYDy8Qo=;
        b=D7oayUDWcwKII/626OSllK9qOS0BBWhg2xtNnKkuJGwiEvueneKibfrhHaY365ENni
         qFYlk+espBa7SnNOYMlcTdPKsO41obMgwe/bA2sD0STIQmHktErFwAQictVLukppVnS4
         2a2CFQSWm2vORwMH9W8v6kd3vMqpOEVaOmF9Q5eY/tT+Z/d2E6tFKTQijoHmnfmousYE
         kBj92W5IshPbJENcxUdRiHU+sPQG+yeyD7VeSYMZWQTgyZRkJIV1fWFHWhFIyg0B2rhY
         l+yDH+6Q7tB0UCKXR72j58jMP5aMMG4MBJxK/4FIwaKjFEjfOF3iq+qpS3U9ONbrH0Bv
         EIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772476654; x=1773081454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4UBz87CiNOA2Jkk5fCcYqvy+CdsMVNhDGoYVYDy8Qo=;
        b=bGYueGHID77CuqyviylKUikEt6myHO58Vb4eKaZQuqhBXkXy2mJVFvooE0FtODSN+v
         wTxxlx9e24OvU+EyqbxJjxijNzdgz0wUelvaOyuYtumb4YXYlNs+61TfpEh+px+CFAJD
         jbknwT5ZiPTRwZ192jy5mg6Cy9SHpLs9qSIbrYn70AffdKP8/WtloPh3iD3nG2iAe/e0
         dimkPwAgPHNPhnYJ66bdtFfBUl3QSaFmozoYmBsQmVMM4i3eg/7a758GHe2w88+2KMa1
         fvQaf3VXRnWkbNArPiggjcLdetqAVIVHWy1uhU93WLP1EBEBaoj1roAuTDpKK0+ME3Kz
         mEIg==
X-Gm-Message-State: AOJu0Yy6WUzzNi07bNPLW6NhwEAW8QlZtdG6VC9Oy5ml4U0yHresmrV4
	iVokaTdu/sH8okzQ3fMJs5k5lqS8EYa+ZynyDR9hI61NcumalL8uJyKy
X-Gm-Gg: ATEYQzzG3y5vDKgajdeKI3f/HVVBc/I69fuJ24bmyXdR68Bxcb4/4RPVhlCUmsIk4Qt
	XYzn/LiFWY8/k9yAzKF3U3zNb1WtsznHx63EcqdbEpZ9OyY9DE9nZ3ikyNSJAHauBrT2iaR/caG
	URfZfkaQ91IjG9YlG9fSA5QykX6xx9k+UaEHNJjV3Efd4ZZh3cWZs2nBHgcmsDW/+8sAhgf0Ca2
	JvV1+F3+ki5xDeHYq8VOAAgbSdzZRcx6D7BzjM7Ao+7T57UDPQPAq0k2Zl4mHvNZj9rutc0u8lg
	0e9iXnW+JOagudsDcilU0IefwLeOvKIH8JIU6TxSkjNkYQq5LJpSxA1uTgesQa0ls8cDJPeJIrp
	hFk6CsOxWXM/EIJ8GcJyqmLBmpNEvi69fwdQnxm5dc4AHQRz0q67q4n3DIjXF66MV0Y7jeN2Bw1
	TPLSvSWhj1ORZCBJa4H+0KOqHHeVIyGV6lodqpNpED3EE79kW6hD1UGafNx974V8LeAlhwCGY7R
	axDV8W0
X-Received: by 2002:ad4:576a:0:b0:899:fd7c:d467 with SMTP id 6a1803df08f44-899fd7cd723mr49298306d6.17.1772476653848;
        Mon, 02 Mar 2026 10:37:33 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ff659b75sm21114256d6.34.2026.03.02.10.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 10:37:33 -0800 (PST)
Message-ID: <17dea0d7-b67c-460a-a08a-1f3a2986c524@gmail.com>
Date: Mon, 2 Mar 2026 13:37:32 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] run-command: extract clear_local_repo_env helper
To: Jeff King <peff@peff.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
 Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood123@gmail.com>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
 <13d783dbbdd77b14fed651f0508fa0e668d98c63.1772465805.git.gitgitgadget@gmail.com>
 <20260302180324.GC28275@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260302180324.GC28275@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/2026 1:03 PM, Jeff King wrote:
> So what about squashing in:
> 
> diff --git a/run-command.h b/run-command.h
> index 76b29d4832..882caeccc8 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -518,11 +518,9 @@ void clear_local_repo_env(struct strvec *env);
>  
>  /**
>   * Convenience function which prepares env for a command to be run in a
> - * new repo. This adds all GIT_* environment variables to env with the
> - * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
> - * corresponding environment variables to be unset in the subprocess) and adds
> - * an environment variable pointing to new_git_dir. See local_repo_env in
> - * environment.h for more information.
> + * new repo. This removes variables pointing to the local repository (using
> + * clear_local_repo_env() above), and adds an environment variable pointing to
> + * new_git_dir.
>   */
>  void prepare_other_repo_env(struct strvec *env, const char *new_git_dir);

I'm happy to squash this in.

Perhaps Junio can do it if we don't need other changes to v3. (I haven't
read the rest of the feedback.)

Thanks,
-Stolee
