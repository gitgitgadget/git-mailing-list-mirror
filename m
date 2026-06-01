Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F342D7814
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321976; cv=none; b=DmdTpYSGTO7FUyIGLgLPk6PnNcHls5+L0CWmYJMNS9FhdvlebcR+RcD+xAckf7KSeUk6GYK76ajxSEjPcwdGiJIBedmyr5eqzIUPUo5e4hzbNi1lwEMSW8WfXzimW7unEyMagZHJfhL5JKBCS2AyAOSr3bp8plzABtGt21zy3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321976; c=relaxed/simple;
	bh=l83VF5PjM8sJdH6+dA48QiaEH/4qWjmsSGPzYsUEMoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhTCPSfgr73HygwhAun0lTI3LsRMnI0wDvAAgVxeOoQtrC8W9/obVn9EJ7y1T++vYSxy9wDqTZOLZZX+peAK3GsiVATygzptsv1MzesCnkatrwosX5Or9AZ4UWgxI8sCNLtpqaACZDimci6rg7tUzocjgHWg2cGN7iHDzvSaimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKZzJBj3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKZzJBj3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45eeea039ebso1781749f8f.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321974; x=1780926774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6OkCmZthgK7RjB9r3NbqlUullEI4OklovQ/CxkQTKak=;
        b=kKZzJBj3sVFjDgcJTU3X+MIix1RnnM0hwbpd4cgbCSEaGZyKw5OzimlXmmAhWr42IZ
         SqHBSCso0a5w3KypccGy/v9WreekkYp17e5XkKPmXTR1DWhOHHRvHCquuyJtwcE2PoFw
         MRDySHCa/6Fk/Cqn0ChLaaGgiyuiNRuRB62U0jAgR3AZ13S1dpxwkdVmaoMEZvLtRhzZ
         ryxVxSB8UavGjCAnPRlMgsQcSQsmmFrqte2R9HI0dYo/7NiBUrvohsr+1F0tIVgT2fzv
         2HiyQ2gxguDlNUeYtD29NUUJggAc+6ApFaAGkGkV9az1xpYD9gkRX1cpgECkwrX+U32g
         4Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321974; x=1780926774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OkCmZthgK7RjB9r3NbqlUullEI4OklovQ/CxkQTKak=;
        b=CHAbh0ZjHtuXDaJYjpqPdFngFhYmMGceqZcJ/rPqWQUj+cVLXSgxQnOB46tGQjnr3N
         73sWilBGAIbp5DGcY4gPRw/YThM9MLttvns1KdItDzUOCQ+oWIsa70NpVMZ3Ire9ufhw
         pHjPjaddarJ+ZBHxtqclDcWa88g6IFTjYPvOlQL//vNYiayEwMVKeN7WKbkIplpms9cO
         uVPLdVU+JQxbX9ckFj1zkIx7w3RR/geesr5FTK2cglhumSO7UgUIkXZODRXnuqp4svUi
         tyl6e0iYTBmc1JdZmE4JH6Sqi6zUufjVvsayDS3bBBURuMi76Mn4Mi++gXcFytE0ge6H
         x/KQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bUrW4Qh2B/y/pTlS7qPoGV43LIM+zKsJXSPRmM102zKIhAv3ZWCSz/ixQwXa4VxlBCnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyheXaxXvNYU/jhq4OYUwC4/lLkLyv9FCLUmGI/7Z97EfLhioa
	UOTpFEg1BZz9AQqhBbLO71ltcilwyGk4xbIkhX24ve1AcqUsvjY5jOee
X-Gm-Gg: Acq92OFXmRpL85KgHzfamklpgsNbDrYwqRzhmyDYZXnQoU+TqsqdV7O/MfW0qS1IFWU
	2oesTBDjoQZjrF/uAIbD6jza7ScruyMWoB8rtNwUT5XWI9uMDIRvHTg6R/gDTkOPp+Tb9lKXoex
	KI2g0fDrLOXHf8ZroubyWi7pBTpB5TJUjfynkCA/qZuG89cVAfUF2HaftjHD13Ei+tjE17QJNF7
	iBSLuclsq6Sfpb1IQWyDhCUaA1k2DBuh03GmdIEzykRfHS1QwB8jclPvU7OsWViw2QsL2qe9ByD
	DPntMGbPL6+SU1HUyRLaC7DkKkzSZHt4xb+VINDjeHpnr3ZJ8TqcWfRGgq1G477zGbA0gRE861r
	CztIjLQBOcwVBJamP1O3s2AsMKns1y7wJDYjfD2RCMJbin8BWEKyHTbz3wdz44Ll22goKvBdsIG
	r5I9/bhp1qTpsyNLLksq4XdTvaDjACG5qLF4AWanDW6DyboXRgeu5pKfbHPZnhEgs8DvcxoPykb
	ycT7Kv6mLVjvA==
X-Received: by 2002:a05:6000:4685:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-45ef6bad806mr11683967f8f.39.1780321973750;
        Mon, 01 Jun 2026 06:52:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34bd896sm24337995f8f.14.2026.06.01.06.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 06:52:53 -0700 (PDT)
Message-ID: <67e1a735-4f7b-476a-8841-09649290dd51@gmail.com>
Date: Mon, 1 Jun 2026 14:52:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t3404: add failing branch symref test
To: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
 <a550923440a233daea0b9819e05d6c380de00d09.1779946921.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a550923440a233daea0b9819e05d6c380de00d09.1779946921.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2026 06:42, Son Luong Ngoc via GitGitGadget wrote:
> From: Son Luong Ngoc <sluongng@gmail.com>
> 
> rebase --update-refs queues local branch decorations by their literal
> refnames. When a branch such as refs/heads/main is a symbolic ref to
> the current branch, the normal rebase path first updates the current
> branch and the queued symref update later tries to update the same
> referent with the old value it recorded before the rebase.
> 
> Add a known-breakage test that exercises this case so that the fix can
> flip it to test_expect_success. The expected behavior is that the branch
> symref keeps pointing at the rebased current branch.

Thanks for adding a test, I'd find it easier to review this series if 
the test was added in the same patch as the fix which is our usual practice.

> +test_expect_failure '--update-refs skips branch symrefs to current branch' '
> +	test_when_finished "
> +		test_might_fail git rebase --abort &&
> +		git checkout primary &&
> +		test_might_fail git symbolic-ref -d refs/heads/update-refs-symref-alias &&
> +		test_might_fail git branch -D update-refs-symref update-refs-symref-base
> +	" &&
> +	git checkout -B update-refs-symref-base primary &&
> +	test_commit --no-tag update-refs-symref-base symref-base.t &&
> +	git checkout -B update-refs-symref &&
> +	test_commit --no-tag update-refs-symref-topic symref-topic.t &&
> +	git checkout update-refs-symref-base &&
> +	test_commit --no-tag update-refs-symref-newbase symref-newbase.t &&
> +	git checkout update-refs-symref &&
> +	git symbolic-ref refs/heads/update-refs-symref-alias refs/heads/update-refs-symref &&

I think we want to test a symref that does not match HEAD as well. 
Rather than adding a new test, can we instead add a couple of symref 
branches to the test "--update-refs updates refs correctly"?

Thanks

Phillip

> +
> +	git rebase --update-refs update-refs-symref-base 2>err &&
> +
> +	test_cmp_rev update-refs-symref-base update-refs-symref^ &&
> +	test_cmp_rev refs/heads/update-refs-symref refs/heads/update-refs-symref-alias &&
> +	test_write_lines refs/heads/update-refs-symref >expect &&
> +	git symbolic-ref refs/heads/update-refs-symref-alias >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success '--update-refs updates refs correctly' '
>   	git checkout -B update-refs no-conflict-branch &&
>   	git branch -f base HEAD~4 &&

