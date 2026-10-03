Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A336C0CD
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791054135; cv=none; b=GOqfqdfe92j9caKTpD9ELMGwd7h/E0QFWoJOaDskydxfczUx8h0sXW4t1NuPJ+ryHM9JZLumpNYqZcgHiWik9RAUVZvtcMbEgw/QRT4VSarqTZ81i7c2q3PKXYdnGiuK1eNB0wEvQekm8Tfxo+wiuSElYs1tJg60XIJ7tViCOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791054135; c=relaxed/simple;
	bh=QpOVrCCfxRzk/JAVVO6sAC09H1OPp6YZvhGFNpP7Qpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkKYpwQx4q/sa6X0HZk8cmxlOhD6wuBraQzXvxS1JZvc/u0FKb1PPis7miiN5alrUd6syNrXEbmgdh3FyWAp2VtgrgXUAAoMDolbaipln9yqw1BPgZFrudDRLL1Kv+A8JdhkGfx9/1gG/kq87SUHQfTVQbXpzePOz4K0WE9TFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9XJZkXr; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9XJZkXr"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48b104f6aa3so244612f8f.0
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791054132; x=1791658932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OtGk5x1j7JskCQFOqRFoF4b+/de48WojVg+W2EueAIg=;
        b=i9XJZkXrPOjDVEB6D+qa4VuN9yAjmO9BSbfNsXXP3cVdcmwR8MT2XB3//2cE00J6vS
         o2xg8Y2cvyRLyy0Cc3kEK/ctaQMxuyeRCyoaFRoHT0nnXRA9qUQbZwTUsz6D6c1tS7Eb
         Nk2xkcYV94tbxrs57EfxFbV7kjx033LK74LBs/9ZHIoZWje6GJUkVoHBXt2ilCDad9Tg
         MBiVKVKcTTttMP7/uRiwmbD1kVU/gJtMHGw40qkpVA46hRvAKarGIG+VkamHHPBFIBOo
         yNmJWPDcAQSligs2ZeS4J4GRUhvHNDgGi8iSalnC1wWDNigzk7x50BqfufDL28OnlzRj
         BwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791054132; x=1791658932;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OtGk5x1j7JskCQFOqRFoF4b+/de48WojVg+W2EueAIg=;
        b=CzOR3EQbSG0Sjgiau30XQRa3ycUJHOHMvEKtrw+4rrAxLUyzQz5ig1HMq8Izv6IHyy
         skLThidfNJCjor7mMMowESCt7rYCpve8RO7t0W8noghQKfE2HKQuQxzTC/zdRbeJEaoN
         U1r797GAudZBWOZ0acnYPTrgbFh5w2Qjzh1Mby2FQ6MYf+evbm66J0Yy6pIu4SKxZeZa
         QypSZbLi3EneNUGjxPA3Z1XTvWL6tURq9HwtN4ukATmVr0a2PzbOq919IaVCUGFBoa3I
         LZgO28e+XPVwmTzsogi8peTi/Lm8TIfQjJQu9MCaNT1Ry+5xCH8MxHlYJ/3WdGS9hbiy
         e0YA==
X-Forwarded-Encrypted: i=1; AKwUvBwYNzOu94LoVHINvk1yyKTYHE7+WiS1o3Spk3o8EzyZK8G0E3KGUbFXVGqCs2Zq6m+TL+c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQ+37XYmIVvAnliJ7IcL7oai8Hbbz+xBfrLCPlBRf1fP4E/Do+
	1gnsH1n64Tpz0qgp5G+2SXOpBfzyoAUArBDUbZHmm63OJ7490QntP0nW
X-Gm-Gg: AYBFou01KL5L1u4dkGmXsHevkR6euje9bGrktSZYMVr33NWxPOQjly8QP6fz1IZj4UB
	5Eg6xXKvrFti1X1z5ckgvjsDsLnqz/gKG/1rFd/Tt+on7VULGUsqTkNAw1+EavSZu8YlSE7Ew2J
	TPRM4Ya5VMdt4eAkTcDD7hIuGvZ2mZemFCyRvFv/jVF1W+k+5BSSrQFFRLKdtbUs25eHQtFBgmv
	/oHltE5i2XUfKpcZoM0EsY7HS/UZ+I3PeMPTYKIPS/wEQCLbNr86ej6Fn6HzjnizhrkqdbiCM9W
	RAckBCCp0cDZH6tvLq1bAgVPbP7+3MJYgwLaATVuzvoYxxKRPDvvgriwPkoB2GOddqs3CwNPaZX
	volYiOdfM7UKXfIXE2hDCSlBMX1WpCJwQaWPuv7LV2aa3XG+gx64c0Rn/JaFqqZkKsicHq2BrO0
	UnYSxu3MJCA9EoIzlo3/KQGrxhWiM5YEBJH/dKzVBFGVxs/lpYck1b0K4Iil1U6PLxFI+ZBrDjj
	Eg7iF4Zx0PS008fg+I2qoZNNKi7g//IdnCT8u2KliXkW5iG8DTjp3Q=
X-Received: by 2002:a05:6000:40ca:b0:487:ab6:bc1b with SMTP id ffacd0b85a97d-48b12754456mr11957926f8f.9.1791054131618;
        Sat, 03 Oct 2026 12:02:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f04e2sm12250571f8f.15.2026.10.03.12.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 12:02:11 -0700 (PDT)
Message-ID: <8b873f2e-b395-4044-ab15-f1eab4148447@gmail.com>
Date: Sat, 3 Oct 2026 20:02:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/2] ci: link failure and leak annotations to the test
 script
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com>
 <3587bf44-1b3b-422f-a926-f8481104dfd8@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <3587bf44-1b3b-422f-a926-f8481104dfd8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/2026 14:03, Phillip Wood wrote:
> After spending some time clicking around in Github I 
> think what that patch changes is not the test output of individual jobs 
> which you linked to above, but what is displayed on the summary page at
> 
> https://github.com/git/git/actions/runs/36979818141?pr=2426
> 
> That page shows a list of annotations with links to the changes in the 
> failed test file. That is a useful improvement

But it seems it is only useful if the test changed is in that example. 
If I look at the summary for the CI run from v3 of this series [1] then 
I can see a test failure in t1022

     linux-leaks(ubuntu-rolling): t/t1022-read-tree-partial-clone.sh#L8
     failed: t1022.1 read-tree in partial clone prefetches in one batch

If I click on the link [2] it does not take me to that test file though, 
because it was not changed. That makes this somewhat less useful than I 
initially thought. The current behavior is that when you click on those 
links in the summary page it takes you to the test output for the job 
that failed which seems more useful. For example [3] is recent test run 
that had a leak and clicking on

     linux-leaks:(ubuntu-rolling):
     failed: t1092.58 submodule handling

Takes me to [4] which where I can click to expand the output of the 
failing test.

Thanks

Phillip

[1] https://github.com/git/git/actions/runs/36537917146?pr=2426
[2] https://github.com/git/git/pull/2426/files#annotation_82189987516
[3] https://github.com/benknoble/git/actions/runs/36033463504
[4] 
https://github.com/benknoble/git/actions/runs/36033463504/job/107747745741#step:9:5333
