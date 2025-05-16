Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D836224F6
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413348; cv=none; b=qA55HBDHU9RZ+lJC8fVfeadWqrVB71LNIejyA8iBTjD80GntyVVY/WLtvABirH4xyBVtWAt7QfbX8Xo0Iue+0m7k2G9bwite6YHkl6ZGbjuH9wkeS3utpYcudfg37MJfnf8g8/PcWXJ0Dl1AEN1nPuo0OGop0cRe9RgP/YiRMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413348; c=relaxed/simple;
	bh=jhzs/k52Hgy/wevweHiu+iimIqDxhajFjjuGdHVj94M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIV0uk/H39faFyNqr9uiOpmCXzj9OurTYcJE4M7F5yCdm+PFte1HKQXe26h01qLeudqQZ/HcjrDalH1gFMZx9as0wbtEmqa3vD2E6SwkgY65q7ISarBnyLbW4eviU+f/v6cBiyjVkkw3LJmBvY/CXi10V56kFnoFS/ToAYoqXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kISgVBaZ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kISgVBaZ"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7b7dd0ec01so466412276.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747413345; x=1748018145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HghHiWH98AcrB5/UVyIfxTmV2iiaTWlRdZ8dkUlu6jA=;
        b=kISgVBaZlgbc0UMz7ylFSiAKQM7+WXKBuVy5RkVRv9AjEXzIKdIuZJjlWIaVy/0p1g
         jaVmjmlqV6ejHXRHKb/4xa8eHn4m6H/of8TRWRf3UzGk/OPSYYpL76jO7Qp0pj4UzEbu
         aOJ89G0H4hhnaEcLWsb5W1aCwt+wzWUGUatlZA+eZe5uB9mOaH5FoAc1pYj+oVZvyRWK
         W345pokyNCSHU5T2XeubJj++S0beKAhHbbAVgDxaEKVQiLVPqvDJ5UMR5+nxt57nsimm
         2606xRjobFeHKo57z2q9MRkBIFpntBHokLj5qtLj6L9oTUSSfHnIcCTUOPaaXvMC/50P
         hcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747413345; x=1748018145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HghHiWH98AcrB5/UVyIfxTmV2iiaTWlRdZ8dkUlu6jA=;
        b=ECR0ev+Pz1q+VUXKMfJBcYLdm7zi0IHIzRP8zQbDrV8fyZS02hQs3t9pEpN+ZivrzJ
         JHNFix6Kg28gsi5uvZ/hIXq2ZR8u9NQDxDLEevwirimF49M9zFoPNx7HNMw1BMkRnMwO
         0cMDHCR9+R61sjFy0NWXAMM8QYMiKiBjLKFaVpG1F/WSMHoSSueE0UkHdjX28omovKAX
         HUs85U1A+hgJmQuOx8uHuB6QKpG1AGps7IDbK6DUlMwekCXXUaAZpPZRP5stEEzB5MDX
         wlj0cocHSrsGkqX3DSS3XZx4xjpofJsgoH4syMQ4/Hv36Aj0eJqqfa9qha2ibf0BQSAm
         GIvQ==
X-Gm-Message-State: AOJu0YyV5CY9DTQc9KaxB1Q7ROAeWJo99Rx6226jHcLG6vMbHWKkefD1
	H2EG37EUKChAKwA+b37PFq+6A/90VuLlZPbeVQpqglH/5vKX9eawaYbvVoq8Ng==
X-Gm-Gg: ASbGncsVE5eHYUPmw4+2dvt+T2Ofl7M+oY27F0Jnjm/EyAZ+VtsrAJDdoYY8AOL53v1
	W3LkAowiTyXYAW3VrEEfCrRNzrR02ySXeO6oFn7XkyP7IAhUYBcQ0419/8Y+E5H7Y7UmNG5MOXL
	33BxOT9BTz5GGcaiuKSh2W450VoXbxdEfn1NeeIRYDxVdnfUzibs0HYEcLLejR1NKM06Kwo5vfi
	Fp673r1hsTCMSb+zjPj6DctX14v5A/vOukrcxR0EBdGBL+KXSNUHPwheLQy5BLELBHDnuJlXKiQ
	iVxV5iOvSWImnVLyvsSWv8nQ5l+IPNZWxbxMxnoQN8VmPJpzaJ5aVoH+Kweaa3XG8oNgbNAaI6c
	7rNmKoUktKT2YEQvL/902klcw3bnj4p5X0FHrlw0=
X-Google-Smtp-Source: AGHT+IEWfKeHcpiZh494OqiJd+83+QjEH3WzWQY2O0TOwtYx3t/eytDVriMikX1bw0vTQrETbGQZMg==
X-Received: by 2002:a05:6902:a81:b0:e75:c6bb:3414 with SMTP id 3f1490d57ef6-e7b69e94a87mr4553733276.18.1747413345311;
        Fri, 16 May 2025 09:35:45 -0700 (PDT)
Received: from [192.168.1.237] (70-237-88-18.lightspeed.rlghnc.sbcglobal.net. [70.237.88.18])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6add03d6sm654278276.52.2025.05.16.09.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 09:35:44 -0700 (PDT)
Message-ID: <6d26d262-612d-4231-8bea-799ae8374d69@gmail.com>
Date: Fri, 16 May 2025 12:35:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Integrate the sparse index with 'git apply' and
 interactive add, checkout, and reset
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
 Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
 <pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
 <CABPp-BFmgAsps=Y+YE=dTUxnGSKj+49jNxODdQDOnvuF7XzKZA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BFmgAsps=Y+YE=dTUxnGSKj+49jNxODdQDOnvuF7XzKZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/16/2025 11:32 AM, Elijah Newren wrote:
> On Fri, May 16, 2025 at 7:55 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>

>>      -    Add more test cases that confirm that these interactive add options work
>>      -    with the sparse index. One interesting aspect here is that the '-i'
>>      -    option avoids expanding the sparse index when a sparse directory exists
>>      -    on disk while the '-p' option does hit the ensure_full_index() method.
>>      -    This leaves some room for improvement, but this case should be atypical
>>      -    as users should remain within their sparse-checkout.
>>      +    Moving that integration point earlier in cmd_add() allows 'git add -p'
>>      +    and 'git add -p' to operate without expanding a sparse index to a full
>>      +    one.
> 
> Was the second 'git add -p' meant to be 'git add -i'?

You are right. The second one should be 'git add -i'.

And regarding 'next', I do expect my v1 to be ejected from 'next' while
review continues on this v2. If instead it gets merged to 'master', then
I'll prepare a new series on top that applies the learnings from this
review.

Thanks,
-Stolee

