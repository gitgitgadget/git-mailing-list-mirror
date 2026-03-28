Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C52030A
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774672437; cv=none; b=M11wxfLQ9VeSARUuvjt2dqyA2ob/qtBmPihfB206rLHop5FBuxo8PuLIXrTUJQfG1qO8Khy+1jl7y/ngisthZO4mMUAUyZu+IDxB2OQRpqMLsK3lbpNyFNJ3UXXMeCL0/ir9ErfH71kcMYT2fdMWipC+FaalW9kXjxV5iHrTPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774672437; c=relaxed/simple;
	bh=SIWf07IMzL2jZvWsaaHgxunXbX6vZZSvOicUfVALHQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8aSlIaV5CmualSnXBFnOLWEh2FYKiJYKHF5xgjUWzCuFuQZVsb8GD/AX8VV/zNT/Mf/bR11MvPctuFokormvB6vZqKc2Su2ZYlKV35nhU7U0r0v4JTMZgaWXQMXOrj9dkgHUOBOLnud1dlyZdxY81NcbNqDgccEDJ2wA9eYglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SB5Fq6fh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB5Fq6fh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35c116887b9so447761a91.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 21:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774672436; x=1775277236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1R4r+6z/IOWikCzyEJOLwHNS1wDB9qsA3COKWViicz4=;
        b=SB5Fq6fhLUTYERqnI/e4Mr+may41KsC0xh8J7tlnMGCN4MNREs7DQtRfYl49C0QYZM
         ruO6aD9jHu/RBJab3p1kQr5IQd/euk0dGazSQirmq8Xl3wnjaSgnMrsJ/4ZV5k0Q+7v6
         IIeBYWwoCwykom2aBLcv1OlZNhioHjLSh3d6dxjLN3cqJ0ERZo86e0BoZ4Rdkns/r/gU
         IgZzZeXN0p+tdW2ftiIAtryZhYdeCKENtWLJS0eLBWuustO0ap49ZxeTvRKJKiKSdv2X
         Y9DDxQ6h8etKO/5rV4CK/31qQcbGeBKulYlU/Y/+FN9hZuuv9aI/27s78Od77sUiBfz1
         relg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774672436; x=1775277236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1R4r+6z/IOWikCzyEJOLwHNS1wDB9qsA3COKWViicz4=;
        b=IJb56LmF0re0nSF0nRKQi3NxDDPnbCOp3LZHKSLJJZun1s+4wE8Ra9ykIS1laVcNeP
         lQ0C4500oVPGviz5MBHQwvsq9tfT6h5E8XBqEugShQqw+5GtIcaGt+dgxM4tOFuFGMbR
         GH83qDoA27qAmmNq/Oty01j+Sm1i7lhC6NspsSiFo+D1lQ1EVMQ4Zjx7TdobIwA1oYQ2
         yBqouy5eEnZ0AOoDggscoQPg2zMmbmZsQP26Hsx8MdGaBigg8JKR6Z1xzP12Lzpt1kCp
         7jXQxT6r7p95+dP7+GyRpHDS0s6Jx4PzKbMX9wqxovLS0WHPyH0q6BoRMtgf1noeCOBZ
         8WHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOPwAQDZ/5jAQrbsA/oj7URVont8ZAh2eVkxEE0DugLprR5/ZxpK90uS8P1UvNsMTOzcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfPydbjqm8cGZXP47dTVESu/2u2JSq9yo3qclEYye0NL++FLTq
	UML0CnJLKDde5I+/SwLFcoXfyKw7u/N7E5iXkUP1KqXTn/2Z8F/Bd8kD
X-Gm-Gg: ATEYQzwvEaN89ic13qV7LOpQAI6gG5KMQMpqBlzW3wlvyQ4uadgPjFJFnRWoZv+EJm6
	vY4qSGozsnb8W6ekKS2sbhT5+tymhjXpzTqd/Pk45Grs+7gIZn7SUkuLjOW3MyKcQX3G8w8J1XF
	IR6s7ZnARSF5zJBj5f8SnaBd93bwdFbJeRTFG2JQelHj682s74Y8f6RSBIEkUOWN2QVUCIE5PZM
	+3LFlrnfINPCprTkx4/AtkIJFFy3XjFwrpSa7kVJQFGTV8Z/gQxSc1mw92x0+xG3+2FoIrI9zg8
	tMQrFV9+tdAuNP4uvtE68cNzIiEGOl6iNwV+GjcRUv4Wt2aKbULHdk8SewGd3xJx7ZcmWtnfEYB
	f6mHXY/npcMHc5k/4fX4jNNB67VQ2SqykROoP0HD4pEWYxe+4DCbVyIsn79M6vIlq4/YXkHskAt
	rTTmVKKDGZPUz8ZNFWb1gy9b7XoV9NvpsaeuIJcwW6ZhHJURfvWxBc5CCcIrpijoEzypfYA+Mzf
	0QSJR8mHDyFkXobAxdzHA==
X-Received: by 2002:a17:903:240f:b0:2b0:6f21:8270 with SMTP id d9443c01a7336-2b0cdd36ca7mr34068965ad.5.1774672435766;
        Fri, 27 Mar 2026 21:33:55 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afa57sm10213555ad.71.2026.03.27.21.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 21:33:55 -0700 (PDT)
Message-ID: <05959eb8-4b8a-421e-bf5f-9e6f0b59a313@gmail.com>
Date: Sat, 28 Mar 2026 12:33:49 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] replay: add --revert mode to reverse commit
 changes
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, karthik.188@gmail.com,
 johannes.schindelin@gmx.de, toon@iotcl.com
References: <20260324220401.47040-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-3-siddharthasthana31@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260325202354.10628-3-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Siddharth,

The patch itself looks pretty good to me, but I have some reservations 
about its functionality:

On 3/26/26 04:23, Siddharth Asthana wrote:
>   static struct commit *create_commit(struct repository *repo,
>   				    struct tree *tree,
>   				    struct commit *based_on,
> -				    struct commit *parent)
> +				    struct commit *parent,
> +				    enum replay_mode mode)
>   {

...

>   	extra = read_commit_extra_headers(based_on, exclude_gpgsig);

...


>   	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
>   				 &ret, author, NULL, sign_commit, extra)) {
> @@ -153,11 +188,35 @@ static void get_ref_information(struct repository *repo,
>   	}
>   }

It seems there isn’t a distinction made here between how 'cherry-pick' 
and 'revert' handle the `extra` header. But doesn’t the 'revert' 
operation actually create a *new* commit with the *current time* and 
*current author*? Is it appropriate to inherit the 'extra' header?




> +static void set_up_branch_mode(struct repository *repo,

...

> +	*onto = peel_committish(repo, *branch_name, option_name);
> +	if (rinfo->positive_refexprs > 1)
> +		die(_("'%s' cannot be used with multiple revision ranges "
> +		      "because the ordering would be ill-defined"),
> +		    option_name);
> +}

This is a fail-safe design intended to prevent users from entering 
commands like:

	git replay --revert main f1 f2

This operation is indeed undefined which should be intercepted. However, 
considering:
	
	git replay --revert main HEAD~5..HEAD~3 HEAD~1..HEAD

Is this operation also intercepted? I think the reason is that the 
condition 'rinfo->positive_refexprs > 1' is a bit too simplistic.




> +	if (repo_dwim_ref(repo, *branch_name, strlen(*branch_name),
> +			  &oid, &fullname, 0) == 1) {
> +		free(*branch_name);
> +		*branch_name = fullname;
> +	} else {
> +		die(_("argument to %s must be a reference"), option_name);
> +	}

I think it would be great if a low-level command supported something like:

	git replay --revert new-branch HEAD~3..HEAD

Even if it just saves the step of creating a new branch ;)




These are just my thoughts on the matter. Hope to spark discussion.

Regards, Yuchen

