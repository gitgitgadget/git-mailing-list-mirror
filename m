Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26CB125B2
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647769; cv=none; b=Loa+z2aRVXXUxGmAwodUUp2Qc4/Hs9O8lTrLEnMsjoQ92lxQSsYqS1Yx2D9vP8y6kZbVEOdrQwAsvTfUWXB3cVULXKyXAt2TruQJ4UknVmrEwyU6xHnakXlv2IFz6TEWJ1R1xNfr/+/xroWj48HN/LhrDGptyS49+AvkkOGUdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647769; c=relaxed/simple;
	bh=1b5neX8GId8dzgNQgQsyuVl+KDPWpID+aJReNTdeRIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1EYwkWIJOXNj9yMX+fGSXL4Np9opSoNU4r2w7btqYTpm2DxR/lNBFKtu7bvdrNiXhVPATpyLfdmD9d0U0D/2npKMCP5IozT++iTjtSMppNyc8NJ6FIkLR61K90wsyh7CQxPAATHKvBDhe5RodgpKfd4w3Cs0gLow/zzM7iZCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbYc5jf0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbYc5jf0"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6ac42b91eso537393085a.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 06:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770647768; x=1771252568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7pT70YnFhXH/0mJeamQtMm5/HyKpAqC7+NAgA9cY60=;
        b=KbYc5jf0sY4skYqy+UJlwG3mChzreqYmmVfPyvPi6SEAD45TLXRBBxQC4IZLbcGq81
         8GZ08vWnBLb94N1NjC7Hdmuq2TfN2LDVye7SG3xQo1pzz4wpDP5fY2OD+NszH0q6U13O
         WgymnR+cHN8W5JEh202iRGzgRP8g4FEX7izawq3/F9rj5ZO46oVwMeOwl/lGsgcF7KfW
         ZV5wABSUdBKhcRNr8xaV3Pv9b06GKAKRGRMG1EmYtaitBneAs3uiK3DfDYEhYv3YjADi
         E4gQxh7lrCd9XeFBB3FMyiUbyzL+Dh1CRoFuHzUDSee8zo2Fi3hDzrfSITz1LqkOWHhk
         bBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770647768; x=1771252568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7pT70YnFhXH/0mJeamQtMm5/HyKpAqC7+NAgA9cY60=;
        b=B/t9nvCEOk3cQIn2MWEKMM6c0CJ2olE1XYH5BwobQLTuoujxKznyfaXmFQ1LfAfoz5
         hbObpSiCiZRVG1V75HEJDJGwunJXsOejmpIX5uMK3ot/hSM9YbLStT0CC1k2w9rWVpea
         G1nfuZIpNbXclbE0T95/65mIsQMP+ZaB6gpin2kxEEO8pu/AgsmjqGzj1wVXARMjGCfI
         f9bzJHBkanN0KBOy+9MWafIy43zw++fcLKOKjCpy3ktntf9FCWNBDKP8vPj3a4X2s0J6
         Pv4ncEp99yY0Z/LTuJqBabPRCOryPoQ+f31Uxq1cg+vzMVgUKInHfyfX5TrRAiKEl/w0
         yfFg==
X-Forwarded-Encrypted: i=1; AJvYcCXiesT8Cy4Mfc8ds55bi5+jrPs1ANzE9ZZwXIDZ/LZo/xKF7FBL+93qFz6Z+MLOncYdWng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0YQP0Jagu/dpnjVVoYu1vFXSF61VAAE/owmuXRUaF40yqJTP
	yKsBrzPRpt+YD7ag6IGZvAvItVzcdOHjXmlAusWkDpQ7PN+2jirdVCbZ
X-Gm-Gg: AZuq6aIbJ+RmpBf5dRgPiefl4yfkC9n8/GLIA73gi7CshdI/NMT5YI04LuCL9snaT8F
	AXTsuhM7lKLIilM+lS59lIP/IFwfH02Wk29RLyeFSDJZP8B19Kibtc7h3Eunjsm3CzXrHYuF59M
	F9byXoea0JpcJICN+em5gtVgHKTcviJhpEZhmzvX6iuGkflM3AhWfnRzXL7WeEzJDhty/B/BICP
	/xDU2wkm2B1Z/gCmoNCFsDcji5h18b5VO+kJ8QWRk/28FMtAgwdh/oWaI6CnaoGeeqmKf7upVd2
	gseUN5zd746qup6c/k2wFt8Cr9KDnXgA/NDBTss7+oDz0/YDZOlAcaeTSiJagQ9g8qmLRbEVUou
	Wnhp4t6rp0L+oeI1YzodQycLn8mzkcOVRP7R8DZ9kuu011QGMjtti2ID0uYqvwXk5ryKy3E+RJ+
	0e2IaEVoDfLfNuVZIPQcN9e1cTO7aLD9/70Qi/XPY5qRQd9//i9IulIjS3ThegzxVxmuH3
X-Received: by 2002:a05:620a:bc6:b0:8ca:33d7:8be2 with SMTP id af79cd13be357-8caf1307435mr1597685485a.54.1770647768319;
        Mon, 09 Feb 2026 06:36:08 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f2ad5sm812931685a.9.2026.02.09.06.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 06:36:07 -0800 (PST)
Message-ID: <7390e189-16ac-43b3-a63c-a8b942d5934b@gmail.com>
Date: Mon, 9 Feb 2026 09:36:06 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] trace2: add macOS process ancestry tracing
To: Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
 Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
 <d99a30a1a77f0f23468dba987da08b32dd9a92fa.1770307510.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <d99a30a1a77f0f23468dba987da08b32dd9a92fa.1770307510.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/2026 11:05 AM, Matthew John Cheetham via GitGitGadget wrote:
> Teach Git to also log process ancestry on macOS using the sysctl with
> KERN_PROC to get process information (PPID and process name).
> Like the Linux implementation, we use the cmd_ancestry TRACE2 event
> rather than using a data_json event and creating another custom data
> point.

> +#define USE_THE_REPOSITORY_VARIABLE

If we are creating a new file, then it would be best if we avoid this
macro, which is intended for older code to still work until it can be
fixed.

But also it seems that you don't use the_repository anywhere, so this
can be deleted without consequence!

> +/*
> + * Recursively push process names onto the ancestry array.
> + * We guard against cycles by limiting the depth to NR_PIDS_LIMIT.
> + */
> +static void push_ancestry_name(struct strvec *names, pid_t pid, int depth)
> +{
> +	struct strbuf name = STRBUF_INIT;
> +	pid_t ppid;
> +
> +	if (depth >= NR_PIDS_LIMIT)
> +		return;

Here is the recursion limit check.

> +	if (pid <= 0)
> +		return;
> +
> +	if (get_proc_info(pid, &name, &ppid) < 0)
> +		goto cleanup;
> +
> +	strvec_push(names, name.buf);

This is copying the buffer, which is why you release it later.

Question: could we stop copying here and use strbuf_detach() at this
point? That would be a very minor improvement, so feel free to ignore!

I took a look and rediscovered that strvecs do not have an option to not
copy. I'm thinking about string_list. I'm not sure if there is any value
in converting your code just to avoid some string duplication at this
scale.

> +	/*
> +	 * Recurse to the parent process. Stop if ppid is 0 or 1
> +	 * (init/launchd) or if we've reached ourselves (cycle).
> +	 */
> +	if (ppid > 1 && ppid != pid)
> +		push_ancestry_name(names, ppid, depth + 1);

This kind of tail recursion could be easily converted into a loop. I
usually prefer loops to recursion when possible, in case we want to allow
an unlimited number of parents in the future.

> +cleanup:
> +	strbuf_release(&name);
> +}

I got a little confused by the lack of a .h file, but that's probably due
to the extra magic being done at compile time to pick this file on a per-
platform basis.

Indeed, trace2_collect_process_info() is defined in trace2.h.

Thanks,
-Stolee
