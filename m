Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91535E95F
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774197260; cv=none; b=girFvDzVkXEMMjcz58w/3jsw0F/7BKBVixLqo1juDM8JAOzY8CahUlpJFYU2zSaT7sY61wUTBhqi9dwB9H8zAde1aAGpNFlIscdycN6R1BL/3a//CsrGNMTARSNYmwKOwTUFQo+0L1BYxNqi3VdxKT6mn2ziUvq+jtyZZDNMfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774197260; c=relaxed/simple;
	bh=oLS3l5XciteVyEebIwGY9gtWgxnrI9gyiR2fgoiNJUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVF6qK01qBP4Juiwvlf7kWPYovgNOS6vJZ0jEh5/f+TyOo2GWJ+5/rK1+QPDjAVDjWmiQLd40T9WftXfUrCaqOefIyVY+BEA2LbubSvXtgfBnzq33LiD3JTOnkhuZoRspYmfnXzPQwuWBaxjecV4NQ6yzXLuK6eGVq1A4TBsNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMkV0oOe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMkV0oOe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486507134e4so42142595e9.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774197257; x=1774802057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kYxUo96FsuLvnoFkS1euSr6vpB0tM9xybtoqXSSkCNw=;
        b=jMkV0oOe4altHp7iwq5JzmZgckGeKe4d0Z1jD1phu9Hay5JgcgRrMjBA49o1phCOpL
         L7XRNJbKDANTWs66Z4d9KylKqr3FhKdNw4fY54pEMKpHwcN2gOQfJ4/0XPs79/UeOj7l
         2PTWIuOg6EuGhjzNRP8gJfLwYIxFR5vnFqKZmbGkJBvTgJhWxcCLavOa7sk5VAS4LiVn
         9dKRRgKgnWvrSWD+ie8iWMzVR5zGc2hW/bixJT8ZKnAEffxOb8QodxsHOF+omSfFrGzO
         udZBGZwIfyVyja+W0ECHiFtPqZYGmUrXJgworQfVpNFms1EdwxctP2l/wjeknnCwx8ie
         4YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774197257; x=1774802057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYxUo96FsuLvnoFkS1euSr6vpB0tM9xybtoqXSSkCNw=;
        b=oPV+jezhbxxhAMRxT8M0h3ARrQbzWTRpn9PrY2rRo3b4+Qr4nXKmIJyL8sJWdR+lFp
         pecBXTgssKisf+Eh73W+HMQUtDC6yjZUmPDYFBPKpmsXb4gLLtKOv9/FCjUqffvrjBjw
         Dn6teOl+AUwsx29x38lXwpYiDJpAY4meKmNPNUsDZdu8d1sTulkPKbE0k+d6gHqzweAB
         kPeYHvnQE7sW9lQWdFAApmgvsFoQmC+0Ev2Rcp67RYk3D6fz3MpbcLz/vOdam1wuHYLI
         F97bU3+fsdm2F3f25xc+9QrobLfH78RXsqZj83UwR03nrofJGwmHmjiZiBM2hya9Un5j
         Ylew==
X-Forwarded-Encrypted: i=1; AJvYcCUWJ0YHk8cuwuOlfaBz1UbETnnzntL0JZq8s9DKhTiDRFXiTb1xVhFRThdhAbTwfYLSZfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZBfwLtNQsXUPnrGz0h4rUv8caiW28mDMgsQqrxyliJ54R4+2
	9xpSYWL9aISBy2p6DVs5Md09XLYI6v/nkcj11eS3hoDU53Mn8awEdEIZSZO4mQ==
X-Gm-Gg: ATEYQzye6nK5MulSEdZ8AW0pdNO19YISwV5PNdNuR0TPb/p9L4QeeaYqtZRyLCxgRDM
	wmNp8qnerDmHv5pg+REqvDhQ3O/jYIEjIToBsbRjJBomGKMgklU3lJOfblSIYHBgBw0vz1bNQ7L
	iNQD8176gjRxF9Q+DsrOXHrfJtXZbzo9uvhvO7f3rghr3f8DB1qpMT12wVWb28QdYobVZKSFbR8
	5P6mae/3Mdd9EzIuXLsDj1Q+ENAOFEBrFvLjQGTegFLKqgf79eDPENGo041mbykY0gH7omefZyk
	l1ck6EjEzYEb2qUXgWAXRyP1wp1bUPwm872JAqw4K3HBAo7LMVdyrlLU6962TC+TuEJLYHbttf7
	lASyUZR7fRgs6/TzJ9vNGK2U64GVlwHxpwSXmSLECmB0LX7zwRsnjLkRX6AdL72vqjwdzZcUpsK
	9m4vZFi7Ihqiu0FtizMPYc97IZScNe5pPaSjMHllg0xJHD4nNuxM2OxTTSoKniFTt3RXtVH7Z+V
	A0Tkd5JX33yTY7k
X-Received: by 2002:a05:600c:3b07:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-486fedab705mr130534765e9.6.1774197257269;
        Sun, 22 Mar 2026 09:34:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm26599873f8f.12.2026.03.22.09.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 09:34:16 -0700 (PDT)
Message-ID: <bf5b0901-fc44-4fbc-b66d-5eb062ccd324@gmail.com>
Date: Sun, 22 Mar 2026 16:34:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] branch: reject --show-current with -v
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20260322060705.53491-1-jayatheerthkulkarni2005@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260322060705.53491-1-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/03/2026 06:07, K Jayatheerth wrote:
> The --show-current option doesn't know how to handle verbose
> logic. In such a case, we want the program to die when both flags
> are used together.

Is there any reason why --show-current couldn't be made to work with 
--verbose instead of dying?

> 
> Acked-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
> I only changed the title of the commit message.
> The previous one (i.e remove unnecessary verbose flag) sounded
> like we are nuking the whole verbose flag.
> 
> The acked by tag exists here because this was supposed to be queued,

That's not what the Acked-by: tag means - you should remove it

> I am resending this to remind.
> The originial discussion however is here:
> https://lore.kernel.org/git/20251226032804.596058-1-jayatheerthkulkarni2005@gmail.com/T/#u
> 
>   builtin/branch.c  | 2 ++
>   t/t3200-branch.sh | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index a1a43380d0..cab22e1538 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -861,6 +861,8 @@ int cmd_branch(int argc,
>   		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
>   		goto out;
>   	} else if (show_current) {
> +		if (filter.verbose)
> +			die(_("options '%s' and '%s' cannot be used together"), "--show-current", "-v");

It would be better to use die_for_incompatible_opt2() here so that the 
message is consistent with other commands.

>   		print_current_branch_name();
>   		ret = 0;
>   		goto out;
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index c58e505c43..5bb49de9c2 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1716,4 +1716,8 @@ test_expect_success 'errors if given a bad branch name' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'git branch --show-current rejects -v' '
> +	test_must_fail git branch --show-current -v

This checks that the command fails but does not check _why_ in failed. 
It would be better to redirect stderr to a file and use test_grep to 
check the error message matches what we expect as well checking that the 
command fails.

Thanks

Phillip

> +'
> +
>   test_done

