Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121E2ECE85
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092888; cv=none; b=j7mdPrbD0S1JQmT5wpPR1U8ZbsRlNDWu1NeF5a4OyirPNozO2bDY7mkLTKkeY7Us3khxh+4jyZBc4u4atjEKfQ7jnT6q3FSgiJBPW2KB9+d/pE+mQrfC0nqAecHSrix432/QBHI2X+KLTngr4Nrvg0GbMKBQ9c+iBupndn1vCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092888; c=relaxed/simple;
	bh=zQ9CYIfVibCrdoMZcbhFbcctUzxHM7gbOBkbKU2mL7k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xr0bDdVevNPY41iRl8mMH0D4SPyswCEH8sxI6MQQFfcb+hNuYUGvpYfv5tpGK2sC2+tadytL9msPbuSCAYi/nD2bzYGJxW0QuYuwk4z+ZqzHiQ9BXMsdTjFuAc8K50pETm93f41zdUD6HYA9RlCxsipg2TJsMxM8zQr4s9acGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz21aJf/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz21aJf/"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so72887566b.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 06:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769092885; x=1769697685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gI7567tzEbFwXPl5DmRp00LTdoOK5T+/sRMIpnAoQ8E=;
        b=Cz21aJf/Z1BM8ocoi+JeRfBuSzkaYHkIHYLVI8Jnc1I+6NUfFIxj+g5kAADAY8lF17
         HBBlleHb4qaQtqDnauoe5OupvgT3zZlo6x+IGNqpSclKLJQw1s67iUuHm+r1aVpc830f
         Xh4Lw4+u6QA8aeaNG5+SIOyGGUxIk5L5D6tDtD0Je9tnVuL1nAd6OvBiCU6sxOmgR36K
         ZMNAFz9YlgJVi1wrmngjYGd9QJ31EidF0yvE7BHU3YC4jDFMmttW52uuGGxMyBPd7EQG
         VTVEMHG6YK/uXWuQ7VnLNFN4O/4RLP7A18wjRaacigB9L80/PV/XQI9CIC4Obdycvrgu
         tn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769092885; x=1769697685;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI7567tzEbFwXPl5DmRp00LTdoOK5T+/sRMIpnAoQ8E=;
        b=tk3zCzPiKBV3faL74SB4i3AqTFv5JOgKofS8dHOfvyKMf6B1kLQX3lwr9HY2JhSn63
         qCMWRgo7a3MmwzW2YC5liBt+RT5HWOat3uQzdtQY8TRDSk0dqMgYf9Hzqa6gLZqE/hgG
         D1qhW5fEQxoeLXY5XdYspUEp0XqYBza/NruM0quiqwbTuDNMU0PlLrC4oSUDYujjXazj
         588g8MIM8YuXt7geZ73x2uqmQBnhULph4PAV0On10gA2hCSNxk6uadUpCpd0Fp5Rzwlu
         mNu8YYzOUjBBM6TnuDF+v4qnxf0iJZ5GLqRUpRPVjvO887rjhgnpi3mLlHHr+pqce0nc
         KBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbYGgKxkcvhWMWupGVJ1v9Un7wD7u9hgMUz32ggCa6FYh5Aff/FUEdu6Yn0M/lR5jFzAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygGRhckyg2bVZceqVkZoqP0xWHm4J2r9bXV7cgDN+2/O+w8yqO
	Hne0mx8/LXjnQdzLxcDQU1b7vCt2OqIRFVhAt7Fk/Gq0UiJOpVaidsu7
X-Gm-Gg: AZuq6aKXJrV9+YqVjZTuSnubmau+If+lGUjgUZV4wKYIg9hm+Jn1XioEak+6AMeUXnl
	m4gtoXOZ6e9YEnKKlddwibiVWvJ5th2tciOB/7xKOs20upUmfPBcaoMkyf/+iNe43tLdbAiWJT5
	x5pMkx63EgVjxgFpfKtF+e8o539aIDLkzyYAwACr8e9shegTFhdVal3lRjYs1rRfsWV+2qK26f3
	ZUE8h9nI3DMNkFwk2lIa5KtU+mF5/vvC+hXO4mpxqmnWakUhzS8L6u3Ok8D90piPu8KQt5emTYm
	mT80TCIwk7lQORi2stWl9CIgHP7eBbISjh2C23UMCZGN0jbTbR+zRG7QY2m7VBNnHdvZM+/tugy
	3hHp71dC0fgdOIQzGs2fG6/rx7cRZBaU1Cw9MVwsiBDM0ggdqHmsuuBUuvGBv+IcG8T5iYAmcRw
	K6lkTU1T1Nz/7NoL4G7hKv+6GNkpVqPAb+M5ge8ROFVcuv7jODeSat5lcWWSSDh+Mo5Q==
X-Received: by 2002:a17:906:fe09:b0:b86:f558:ecad with SMTP id a640c23a62f3a-b8800236e57mr702428766b.7.1769092884240;
        Thu, 22 Jan 2026 06:41:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a18c3fsm1682101166b.58.2026.01.22.06.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 06:41:23 -0800 (PST)
Message-ID: <56ac85bc-8e12-4cb9-ba22-db021c473110@gmail.com>
Date: Thu, 22 Jan 2026 14:41:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [Outreachy PATCH v3 3/3] environment: move
 "branch.autoSetupMerge" into `struct repo_config_values`
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com,
 karthik.188@gmail.com, Toon Claes <toon@iotcl.com>
References: <cover.1768681947.git.belkid98@gmail.com>
 <9a411db9f8f9df37c7a5f100d97c8d5ff5f6ba97.1768681947.git.belkid98@gmail.com>
Content-Language: en-US
In-Reply-To: <9a411db9f8f9df37c7a5f100d97c8d5ff5f6ba97.1768681947.git.belkid98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Olamide

On 17/01/2026 20:59, Olamide Caleb Bello wrote:
> The config value `brach.autoSetupMerge` is parsed in
> `git_default_branch_config()` and stored in the global variable
> `git_branch_track`. This global variable can cause unexpected behaviours
> when multiple Git repos run in the the same process.
> 
> Move this value into `struct repo_config_values` to retain current
> behaviours while achieving repository scoped access.

Same comment as the previous patch about repository scoped access.

> diff --git a/environment.h b/environment.h
> index 3b5ff7094a..bfcdffe836 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -2,6 +2,7 @@
>   #define ENVIRONMENT_H
>   
>   #include "repo-settings.h"
> +#include "branch.h"
>   
>   /* Double-check local_repo_env below if you add to this list. */
>   #define GIT_DIR_ENVIRONMENT "GIT_DIR"
> @@ -89,6 +90,9 @@ struct repo_config_values {
>   	/* core config values */
>   	char *attributes_file_path;
>   	int sparse_checkout;
> +
> +	/* branch config values */
> +	enum branch_track git_branch_track;

We could probably drop the "git_" prefix now that it is not a global 
variable.

Thanks

Phillip

