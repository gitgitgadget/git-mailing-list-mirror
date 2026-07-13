Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADBD31F9B5
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956489; cv=none; b=aZvk0ViguU6+DRCfQu4UH9qLc/pfsKjPpZ4sa/BoZZgFk9VoD9kz2+vH1yoJgIMXkLa7B7dAJMeFwink4K0c8lQSbF8S5Nu9TOpIDbAAhQg9KnBYyyJ02bhEVcRbFPFLl9xR4sQJtuFMtzuRnRYFzY0aR9VnolWDexfM5Ungb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956489; c=relaxed/simple;
	bh=R4KQirAyrQWG8tqdoVpZSzviUnhhGEuENknewNUbceQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fJFZr9XKoxvwbqMQcJJSkubOYOhYK/QCyb7oREl8MFUs0pOw0/QQs/iv3whoPoXSMzbdiQ4IQBtY+z13AOZSo3skzbt859v5t9GzTOO9KpL0D4KiG0ASPBoGVKRHOR4Vi2ZLkg5dakivZLR3W+2n9HNIGA8rHZkviT0UoE1o3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb1LmATz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb1LmATz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b7612475so26161805e9.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783956487; x=1784561287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PlYtxA4txq+PJkgT2mzPO1fj9egfcxWAmmin0TG+vn0=;
        b=Eb1LmATztnt2WQ6aAvVhMnaxF3aci5ml25MhDsdUTJOcQjwF0+yFMnrZ/UsJh9txPV
         QswKWOBjHMuwCxFwTj5qidAveridct/GjAf9fsdfLoTYj0oBWzMwZ2XuJxMdgKYbCqVa
         Ta5c/n/YsLVJzDjRzaJjpHm8BQlPkmMhzKuXoL778Os/pudZ5Iqvs7BsCXofjoTW5pdm
         PrpDfup8etE20p5Mz5VMO33jGl+dl88MiqpNUiAfwC60WQvdZfEr3OrDpFzpJfn/yVHV
         1RLRZgqXfXBdonW2b15JlDhEIQ4Nmuy9aOdwRoiqlowPsRsXBBDWHPeoAkEnI8Q0TAY2
         rUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783956487; x=1784561287;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PlYtxA4txq+PJkgT2mzPO1fj9egfcxWAmmin0TG+vn0=;
        b=KNU+NyqxxhPp0Q0wrq0E2ndDR0vFoVBetjI5Lstgy4EtM8bPGmXaV6cZs/Qg6fycZ8
         w8W8rLVeaMNIws3S66Ecja5TMGQh9/9F2otUw3GR1lLBsRanAeJVapPghgbwX33yE26p
         ICXU1REWd7eboWS/DCDFzMD1JNuAAg5vrhSoTKnHRoA8y+OprXUdm9bxlmzb/MYvLevW
         /MKmnNu8ugOM/0MgW7+3ipIzLuSuB0U4k1Z+XtIZXb9F2wHPd+Wcd9fd0kmaErkoesTr
         Mjil990jx5NDVUMBTMMnMOPG4IMJ5xxY9h8M2fdhfM1ifrbQfXD9aN2g+e4oqQ6MHgjc
         sRpw==
X-Forwarded-Encrypted: i=1; AHgh+RrBJVk4lOvXKfaGuR8kXSFYAHJ236XLnYH/nndbUVEyqsUkw9EMj6T7ZRHoJ9VVVnzFgcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQmeNUqo7FDL0TF5p0aHN6cARo1AHYtFny4EySuBsxCrCcRygg
	TlAfglkr4zSiVRRnScf/+w0v9hYIdu3fUiSOd1DyOI4KclIu0FzxRDFG
X-Gm-Gg: AfdE7cngWDLvG4TshIHqoSgxVOT8P+u2M7K2cS0J6ea3OdEDJc/qsVnJ/23VjL2xCXt
	jPfby9fU/xD0Zvqk/ZGNDC0nlJkMghk2Ccj8aVItUrY5qFR5lPTGgTjNns8pJ6QMyGe0lr2dB9k
	xoBsGySb/hEL1UDyGUN7p1DHqg8KXnalNXFfa5mNyqYvLdNUihNldPj7SGStW6IvAmejq9cn0ys
	SVQTUFeViBVuE08zzEmRbOEjlUlA1czGFacnSGig+Y66mk9bkgQHKi3Lr7eINb43PozHtFXnzte
	HxmzqPKC9XbqIQVwxvZmIjebrkbw706nyrVgVBpc9yqfy/ShswrAZj5lyM5zAdX5Nv62cbrLSQL
	gqodpuKJpViMiK8sXZul4eVUgT5ZUeHDqBh5iNWy6DhKLnw7jlIMHnbi93bYLBCrf+3LzraXG27
	0TiB+gF0nwp2MGMcf3JGQdVqT5gx+rxZJKpfNJZysO+Ln7rmi7INt564+bVrJNwVzQgPM=
X-Received: by 2002:a05:600c:4ed4:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-493f8780525mr111328075e9.0.1783956486559;
        Mon, 13 Jul 2026 08:28:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495087384casm3148465e9.8.2026.07.13.08.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 08:28:06 -0700 (PDT)
Message-ID: <dd92c389-ba8e-4704-8464-1fcc274bb05a@gmail.com>
Date: Mon, 13 Jul 2026 16:28:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v18 2/7] branch: convert delete_branches() to a flags
 argument
Reply-To: phillip.wood@dunelm.org.uk
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <cdd4fea4a73e39a1f88127037d806c9b6182d01e.1782338106.git.gitgitgadget@gmail.com>
 <ed72dd31-5d68-4e78-9123-7061b388ecaa@gmail.com>
 <CAHwyqnV6kS8ZmfXm+9JttoJ=kWP4kYdLGX2giASVMSRXVKL-Pw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnV6kS8ZmfXm+9JttoJ=kWP4kYdLGX2giASVMSRXVKL-Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 10/07/2026 18:25, Harald Nordgren wrote:
>> This means we have two sources of truth because we modify "flags" later.
>> The idea of replacing the old function parameters with local variables
>> only works if we're not passing the flags variable on to another
>> function so I think we should replace all instances of "force" and
>> "quiet" with flags & DELETE_BRANCH_FORCE/QUIET. That way we have a
>> single source of truth and should avoid any future regressions like the
>> one we saw in an earlier iteration.
> 
> Yes, it makes sense.
> 
> I just hope we remember this discussion, so another reviewer doesn't
> push in the other direction later because it seems like low-hanging
> fruit.

If you explain why we're using flags as the source of truth, rather than 
replacing the function parameters with local variables in this function 
that should not be a problem.

Thanks

Phillip
