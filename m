Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89541CA683
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373039; cv=none; b=sbDnvVRVjC2ibXqQWtUoRgkSaJ6vlXgaSr4551jQAJ/fy1EUivxXZ8MYnIUplosMPZX9hp/DkNwaAyabJBp7Xt7GLiK/DWGKZxPnTKapBbAGOXdp3eFbfQudZ8QV+IzGWo4q2+RzHcH+lBBfjzRV02FDajue0+h+fCDJkeAnJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373039; c=relaxed/simple;
	bh=12zmXvsiI/FGfhX4nz0EjpJ68Wc89/xYMxRnIEKUHyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spAEFrDKDlPYfm6nLYjvYkVTV6v8SOElVLtKyHIIR0Gl6U2y2Rh2mZtG7lCQXyuRPS+bbFIzpTkuXqand2WqxZIXeqoyUQ9yZX0Mp+P7bYubaoeiWUR3XH56Xf3RVrGtA6Gz/aO3zWhcdWs47ZyHxwvkONQ/DKEjl77qWq/Udko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMIBan32; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMIBan32"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7148912a1ebso2989114b3a.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725373037; x=1725977837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o11MXxWhByGU81MlCTlRKWpDnbGPu/HWtB5nFYn+FjY=;
        b=TMIBan32piDiN4uYJ3KfRZzsS/cuguoSOZoyPGRR0oEuvlJGl46+DNL3m11a0UhZFG
         rUOLfTYl7WzAO3VvztXgCfn59dB78fbxOOFfBXuoGVSZN53ilvQXJ509rIHYfM5CKW3i
         TWEQKxiIouFDv/tfCs/JoWVdfGTxYYjcypEGbrxAHwMJia89yNQDEpY4U1Yu1VZmiUDw
         5o97Q1C7iSlFJCgXjVHYa77/5kQUncYOyp/1Ou519f/xBts986S6ux4tpODC0vbMJTtv
         e8s0eQkG6yC8aTyt9I9b6HNk+Xje5yOO6577bEvU7sZnKKCQ53LLz8nKzvIUstUxW7V0
         MYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725373037; x=1725977837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o11MXxWhByGU81MlCTlRKWpDnbGPu/HWtB5nFYn+FjY=;
        b=wrJ/pAj3aRFnkwF+6h8z3fWatHscmAP9QhKHux6l/u81px7eRGY6yI5VWLQdqYxyG+
         rmhe4XZ1anNjK5+clu8CYZqOVWpEa4CsmvkPEQQKKl8SiUp1WCnfk5PH53LPTMAIBVqL
         eS+D82r/4+mmKMT94VdExjZyduSXyGFRwSYNBDV8cS8MsvMC1Hm0XvqpQtNNCxId6EBE
         FTCGikjqbp/bS9vw63UHpycNBiN41Kp0zMcnZgFPHwn1fDxixXC2LV56/VAsp0OKpfsz
         up4bSvtqIInxAbvxaDIBAqtYSEMOPMsJDZ5ObL7Z179VhGrzSB5iVsvNd1pcHOf1o7ZP
         UJtw==
X-Forwarded-Encrypted: i=1; AJvYcCUPTWQIYWL6La1LPqdtN4DHtQ3nAjOA0wrEexdF3tP1GCgKC5DbOaJ5vAYoiciAfEbrFZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtI4wNX1PRgwRUafbT8v8HNHP001xw2E7FUZ2i5rTR1AJSlqhc
	oePMMHSOHN08KcacB7ey8mDp8+EfZKv8TIyYkkP4QqiCCQZU3qOF/s+L6A==
X-Google-Smtp-Source: AGHT+IFl9wnE/dHi/AqcNFGtGk6sPuK7nFq9W+V2qLU0DJwLQiatX96xoRTVuxNdk726unIe9OA1Wg==
X-Received: by 2002:a05:6a00:3a05:b0:710:5825:5ba0 with SMTP id d2e1a72fcca58-7173c1e0e87mr8776317b3a.3.1725373036820;
        Tue, 03 Sep 2024 07:17:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:ecee:9239:d237:3714? ([2600:1700:60ba:9810:ecee:9239:d237:3714])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569ef9esm8820838b3a.99.2024.09.03.07.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 07:17:16 -0700 (PDT)
Message-ID: <83ec9352-d274-4d05-a6b8-d33924f46205@gmail.com>
Date: Tue, 3 Sep 2024 10:17:14 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Mark 'git cat-file' sparse-index compatible
To: Kevin Lyles via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Kevin Lyles <klyles+github@epic.com>
References: <pull.1770.git.git.1724695732305.gitgitgadget@gmail.com>
 <pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
 <a92825e502f1795910b869165779279b89212939.1725052243.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a92825e502f1795910b869165779279b89212939.1725052243.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 5:10 PM, Kevin Lyles via GitGitGadget wrote:
> From: Kevin Lyles <klyles+github@epic.com>

> +test_expect_success 'cat-file -p' '
> +	init_repos &&
> +	echo "new content" >>full-checkout/deep/a &&
> +	echo "new content" >>sparse-checkout/deep/a &&
> +	echo "new content" >>sparse-index/deep/a &&
> +	run_on_all git add deep/a &&
> +
> +	test_all_match git cat-file -p :deep/a &&
> +	ensure_not_expanded cat-file -p :deep/a &&
> +	test_all_match git cat-file -p :folder1/a &&
> +	ensure_expanded cat-file -p :folder1/a'


There's one style issue that I missed in the previous version,
which is that the final single-quote (') should be on a new line
after the last line of the test. like this:

---

	test_all_match git cat-file -p :folder1/a &&
	ensure_expanded cat-file -p :folder1/a
'

---

> +test_expect_success 'cat-file --batch' '
> +	init_repos &&
> +	echo "new content" >>full-checkout/deep/a &&
> +	echo "new content" >>sparse-checkout/deep/a &&
> +	echo "new content" >>sparse-index/deep/a &&
> +	run_on_all git add deep/a &&
> +
> +	echo ":deep/a">in &&
> +	test_all_match git cat-file --batch <in &&
> +	ensure_not_expanded cat-file --batch <in &&
> +
> +	echo ":folder1/a">in &&
> +	test_all_match git cat-file --batch <in &&
> +	ensure_expanded cat-file --batch <in &&
> +
> +	cat <<-\EOF >in &&

nit: typically we would write this as "cat >in <<-\EOF &&"

> +	:deep/a
> +	:folder1/a
> +	EOF
> +	test_all_match git cat-file --batch <in &&
> +	ensure_expanded cat-file --batch <in'
> +

Pointing out the final single-quote here, too.

Thank you for updating the heredocs and other format things that
I noticed in the previous version. Also, thanks for splitting the
patch into two parts.

Thanks for working on this!
-Stolee


