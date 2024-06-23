Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3D2F24
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719179800; cv=none; b=mduWeAlPKsMdABcDS1Z0265NkwiMeELWKBZvxV+dLQVV2ZTqWnhTqVq9woECu+S8n2hUPlpIXU/3qTb457mZfijiFhacxfXw32x0Ej74ytEjFhEhYr0Z0tDcsOanT2a8oO9xqpQDUxzUnpHls/yuJnzkj7H8jsYgmNhfQmZe1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719179800; c=relaxed/simple;
	bh=cmI6JsgKtn4cRyzK6ijo4sp644hgP863BEwIPwNy5Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2EhG2eja985/HcWDGE8JllRM8SI6RhHvstCAXIvxjKfk/irFhrt1hBj+UvXIMhbXt+OrXmXtCIVrF9lCTuc2QT+h7edKpPw2HL/TCTNm0cTmIwGXZSX88Zq0ZzZdMQ6kCjhr5eDb+DrT/ON+kbtTadjY2LkWPphwbQIT6jr8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBr62uiC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBr62uiC"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c7a480c146so712723a91.2
        for <git@vger.kernel.org>; Sun, 23 Jun 2024 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719179797; x=1719784597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tI0v8n7+ma0BaZAw2qb1T1yG273GTDYVRpavZjik4HI=;
        b=fBr62uiCqUgsPCqM21QEtzXKtDRrFGKyHauq2K/uX9ltvG2oYCfQdE+yGWt9y7oUJA
         7lB42Ph1XfZLStbLANysOpRdf71/0lUCQPGqcby4rJZArYOrLRTlsqlQTkVUA9bRTIoL
         QNlgUwSZ2es58Xj1bwTzZ1lGyDie3AhmzXexc7T/B4eyl6L3tyW/Y52Bv3MGaP6pMWil
         V7UkX/FGssXdD+zcOHskLwjrR2P66NGK/MUQ5uX3HBVP4pq6UrkbZ1QbmAaNst/MRIdb
         NBkx5Ptlnp/pz4CPFm43OabhPyUMNckPK+J5EkQIE5noCZvcIsBUL2vzzCOOJSECr5vu
         8wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719179797; x=1719784597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tI0v8n7+ma0BaZAw2qb1T1yG273GTDYVRpavZjik4HI=;
        b=t24ERMtRYER9y7jXGMoXlNCKVK5TfoGQC/MD9Mm/JG11HILjb09vQPUnU1sPE81Vx6
         2EZyul/E0TQPN3GcRmDFl6HslBynMrvVylfp8NDP2OBWkPQWIIAq+4h1I2O8tFZo3pts
         IxlZWTCQsZww7TzEn/XrtUeVw7qz2JVwnNWe2yXirEmraSG3Wy8SoIBPnbloZEA7G9sL
         ia44nbJzLfpmwPGUW2j4O5oKy4/nrSPAOMcjw8Fc6mGrCj9jcdyTg9q2OMokei4U8eER
         GYxzJaFqflmfdbZlyc5kHmo6hcNBuXbmdSJazBG2MxQx0lTZxiXwKkOeFk0wbATJmyHG
         OTxA==
X-Gm-Message-State: AOJu0YwjGgHxzmePUzgLGxfq7O5eQmcUDLoqbupIrRIeJg0xba6mZZuC
	66xAAqIX0KRSW9kj0cmUVzgxGTYQdX14MrKxvgv8bBt/wOtgPIMs/azao/yccBM=
X-Google-Smtp-Source: AGHT+IEKD5+iTZKVLvksz37+jOFZArnzuZtqTzB2hh81YtM+TWB859rxgeG/U6swWO5ZfEqXqtYT6w==
X-Received: by 2002:a05:6a20:432c:b0:1bc:e987:493f with SMTP id adf61e73a8af0-1bce9874c7amr5907888637.1.1719179797509;
        Sun, 23 Jun 2024 14:56:37 -0700 (PDT)
Received: from ?IPV6:2409:40c2:200e:9e9a:d72b:4d57:4251:125d? ([2409:40c2:200e:9e9a:d72b:4d57:4251:125d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107ccc0sm5054897b3a.10.2024.06.23.14.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 14:56:37 -0700 (PDT)
Message-ID: <7e3ba9fc-1ff4-49aa-8e73-c50202477719@gmail.com>
Date: Mon, 24 Jun 2024 03:26:32 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] describe: refresh the index when 'broken' flag is used
To: git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
Content-Language: en-US
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is my first ever patch submission and I am excited to contribute
even if it is such a little thing! Please let me know of any etiquette
or convention violations, I will do my best to uphold them moving forward.

Thanks

On 24/06/24 03:12, Abhijeet Sonar wrote:
> When describe is run with 'dirty' flag, we refresh the index
> to make sure it is in sync with the filesystem before
> determining if the working tree is dirty.  However, this is
> not done for the codepath where the 'broken' flag is used.
>
> This causes `git describe --broken --dirty` to false
> positively report the worktree being dirty.  Refreshing the
> index before running diff-index fixes the problem.
>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> Reported-by: Paul Millar <paul.millar@desy.de>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> ---
>   builtin/describe.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index e5287eddf2..2b443c155e 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -645,6 +645,20 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>   	if (argc == 0) {
>   		if (broken) {
>   			struct child_process cp = CHILD_PROCESS_INIT;
> +			struct lock_file index_lock = LOCK_INIT;
> +			int fd;
> +
> +			setup_work_tree();
> +			prepare_repo_settings(the_repository);
> +			repo_read_index(the_repository);
> +			refresh_index(the_repository->index, REFRESH_QUIET|REFRESH_UNMERGED,
> +				      NULL, NULL, NULL);
> +			fd = repo_hold_locked_index(the_repository,
> +						    &index_lock, 0);
> +			if (0 <= fd)
> +				repo_update_index_if_able(the_repository, &index_lock);
> +
> +
>   			strvec_pushv(&cp.args, diff_index_args);
>   			cp.git_cmd = 1;
>   			cp.no_stdin = 1;
