Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4EF4CA295
	for <git@vger.kernel.org>; Mon, 11 May 2026 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528696; cv=none; b=kKtvZlVDs/KJpG2pJZ7oo1dm+qKqaHCzx1LBCLJxPjXafTviAl8cmfOw6GyEib/3Tfr9nbvfzIsjbvQ//0jewBy3I61FP+t+1t79nAm/N1bsCUieCBNqod3rIVDdrKAMwa5iipczUh+2AEDgLSxxVceafL/SVK8MeoAvI63zRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528696; c=relaxed/simple;
	bh=mJQX1ckxuzCDIUFPp8JXB/G5uyQUEcj97SYxGoopOoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVWbPH8o9YKDy8dQNNvm+IxLyvP479yPHX4jm+YJ7yhoA+Jd2Xl5PLNPqsOqNZp5Et2GGluDUsvFJ9+naRWGmmLlPfUucuLdThodq1yelaCXuWaLeuQYStSAqObg5jqy9csVEBrahv/QaYyu8qtJ+7g5TolQB4CBsaMOUpsge0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rK+oH86b; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK+oH86b"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso62857696d6.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778528694; x=1779133494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unK9ell3guKAc1IacjTzyPYRtzuooYkbTfcQ/CmVcRY=;
        b=rK+oH86bUxeEZKnPqtZwq7vvMYE8ura9I66AtVgUUbuWPHqxl70D64nx9TKDZ6C9tY
         WpZdUWEijtpjr3O9j5OTfe0waWRiUH0D4zBYmMT2xhLAeV08qqZwZfNXstC1+E6eujat
         ZwqUBe4GscKc3RLJZBWNsUDEPCvdTbKPz87f7zCzCHijtLk3vHjPaj2kPqReCf1ixjg0
         qPrt2cKJmcKUdvYqfFykwMhtoCiTS+S64lrvIzsmwknuNFg3MIyLNB0k2uy58qfNGhE3
         05aHPXzbYE0bV+K+qB5nWZCz9D8smG3WbdXd+Xjxaaqv1mohlK6EYlcSTExraZPGTpcY
         xaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778528694; x=1779133494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unK9ell3guKAc1IacjTzyPYRtzuooYkbTfcQ/CmVcRY=;
        b=CjNe+Jzymf1UBDKw4ZZ9bPdTJGFlA7dj3FSZtUr9Ib5FCbdersbbEkO1Z3e7pQYQAg
         2mv2HgMMsYsQBr6mg0pIA9Bn1Qvg7NefUnud3XVcb6zG7sv2in5iuXWkgePzkVrM7z6g
         3qWuLHl/Iyjt0DVt8ac+I57bPnMgSI6tIHLXJVvadkMOksJLcYRZ2SfJdtEmVEL18EsL
         9Z9mnvVktu4FX+PXAVmTEz2b0WWaOOZSDbbti/PzoBZRRWsEl0eI1t4xL+e3BDV+UhWV
         kbafjBOkzR+5SJQsGVoAf7dAE1QWHqJg3bebiWuQQEt2T0MLiZLKOZoEmPT80ssvhlnS
         wlcA==
X-Gm-Message-State: AOJu0YxAb635FkupDdIcvkoBaP5Viu3RGv63uQNsngObgs4ZEQGSPzcP
	cw0ENqT27G4UtA9RVgfw0Bu6c88XW4pxr9w1LUiztXSZ5lbWUF6vQtHVJgmjh0iE
X-Gm-Gg: Acq92OGpFs63p/67OmkphJVOWdwKtgJopA7eiYhAI8M0eUEVGsP5fIWfDvwU26mKCOH
	M/m68H6k7LnxO2/N+PkfOKM/SsFctMR+Vz3p6lgllG9KTyYE0qgEQ/fjO0JH3Er5XFFkoBMUAA8
	pQQolxGdGtJ16J6cULcPYD6LbgpMp1D00CeTLHpM+B3rNFA8SZXMVBe8ovDxXKOdx7dSWqSLU3t
	hprkN/hRflWUcP90AMH0RFYxwb94Bldn09u/ww9nYPJu03e2Eh3OuoRESmUEncLqXY4JP/ihuVS
	9fdq1aypXJfAc2dZnLhRs6fUXFWNzuJZ0Sx0kU7bDg3ALBUrDKohjMqxU1jKusNjBx+o01znDSY
	0uNz++PGm3qAxhyUO9uSJMUJyJZHVhYPt+bFnha3m7GFXt96zRWANnG3ct6mHAJu3oPSKGsO/+r
	pFWaStNfX6QKnbwKXXO8DvbvHC5Vca1t3JIgCk8vZNZPjExM7/lpyquE5R+rEY8NczfjF7Eg==
X-Received: by 2002:a05:6214:4288:b0:8ac:a976:f8d with SMTP id 6a1803df08f44-8c662176523mr1445606d6.22.1778528693849;
        Mon, 11 May 2026 12:44:53 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d0702aasm339329156d6.43.2026.05.11.12.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 12:44:52 -0700 (PDT)
Message-ID: <0b4a8595-63e3-427c-8920-af4271ae1714@gmail.com>
Date: Mon, 11 May 2026 15:44:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] path-walk: support blobless filter
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <b2deb7f81939d6ed03f0ea5c8be5ec515c1c99ab.1778523189.git.gitgitgadget@gmail.com>
 <agIiL3jBvBBLHJWD@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <agIiL3jBvBBLHJWD@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/2026 2:38 PM, Taylor Blau wrote:
> On Mon, May 11, 2026 at 06:13:02PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
>> index b78175fbe1..917045d5c3 100644
>> --- a/Documentation/git-pack-objects.adoc
>> +++ b/Documentation/git-pack-objects.adoc
>> @@ -402,9 +402,9 @@ will be automatically changed to version `1`.
>>  	of filenames that cause collisions in Git's default name-hash
>>  	algorithm.
>>  +
>> -Incompatible with `--delta-islands`, `--shallow`, or `--filter`. The
>> -`--use-bitmap-index` option will be ignored in the presence of
>> -`--path-walk.`
>> +Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
>> +ignored in the presence of `--path-walk`. Whe `--path-walk` option
>> +supports the `--filter=<spec>` form `blob:none`.
> 
> s/Whe/The/ ?
Yes, of course. This typo will follow the remaining patches in the context
lines. Will fix in v4.

Thanks,
-Stolee

