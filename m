Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6151714CB
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291622; cv=none; b=Glyw+a/IDLD5fAWfvQEEzvu0/GgGncDsddSg7hy12l/ZUoAGN/ShGszrDm5P1p0W3Oydwv23VEvR4y6vcr2pewXW7V6f2qGMhxAji/IJGxatyNRNMhc0TeE/9MrfVqOelAthcoM8MA+APRFpmNOqs0thtWEUYHKNC3bs9pzFcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291622; c=relaxed/simple;
	bh=B5Wv08IXSIHWIJRjIo2J0nU3QpIVWKUhBM8FGxXvYro=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wh3TXKVtftfbJBtqvv1zLppiEbA6wiePg9YRyTdcJNWzaT7AHvs81CKISRp1CAxyC/tAp33jY/UeAPOuhaS9701bJUPkeLrMEOXuwCnROmJd9Ad0KRIGw6MtWmEIKTo5nWsZdiLO+8kyjznPpQ/p3kTmTB44c9F4Bl/hd5R2zrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwPm4nuv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwPm4nuv"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c89e66012aso5589266a12.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728291617; x=1728896417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QM6CGM+t++SgU8nmT6I/Qn5zZZKK/DHZxxQ+Pq3QQVM=;
        b=fwPm4nuvu7DbIrCzCsgRhF34gWyDzyocOINc371CLtrCuZkzTuOqK9opK0LH81LSFn
         bMH36e6psneSb5iiHKCHHuuqx9Y09xG8iL7Y5I18cjmqFguTmJ2XnuHLDmaq8A7SqWTr
         /32+zYLf41ruIJQULCiNPODCJzSNpIzY214PqMdsdielDGC/Yuxvm/ensj94B/uf6gga
         3jezXWhG3GU8Ftr7nwZoggQh65mARkyjpw4dkee0B1cMxzLQcArJDMZtuE5xW3LHS2Oa
         QK2SKVdt920SX9V79IUEjmc2WwQlk//9LR7bvj3KUkbN/WBWo9xQVsLWn+skGabTKSfl
         O6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728291617; x=1728896417;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QM6CGM+t++SgU8nmT6I/Qn5zZZKK/DHZxxQ+Pq3QQVM=;
        b=Y1vsgTuVJnzxTyUqMATM3UPGfptt9W4xOwciQSARBReiVUXA28ZwMIz3KLsgSVXnd0
         5+LiN+aGugtBAk5lUnjuUjRJkmGb8rNw+UVI93TQse2qaOlmAlgNgQgHzamD07oDD7PM
         2JW6pvYWX3O5f1vYlI/MaxXugoO2jnMOzl5k1VGSmxrnpQ4OhdKBdtHsIknGcJNzBRvk
         CxnU92JJ9h/+QL/MXzLNJMFEmJdGE/VCcVJNhux8fj3M7/3UWQEDgL4nOjNzwKhqi3li
         aJCf87KD9AOLH++/ettMQDYu8HtWFQXF5aICil4iIdH09H7Su5ZALUeN3Jh0fXXF5oqy
         6DMQ==
X-Gm-Message-State: AOJu0YxvJcUtZGqTD+Nr/XWsizpeT/1fuPHzpuEgD8sB4R8YRqYXNmCa
	E9haMRRBS4oNRtnTLBNd2WMpuG4a1UUx2nfRDbpWAZclQvkqKsmM0PfYJg==
X-Google-Smtp-Source: AGHT+IGRwFW1qbsc/6y2Ba/nMcWArxyfJ4bVq/EOX4cfq3AmALiEmmqi3r4BxOsrK7Z5WVfr80tasQ==
X-Received: by 2002:a17:906:c111:b0:a99:3abc:52eb with SMTP id a640c23a62f3a-a993abc53c0mr838704166b.30.1728291616607;
        Mon, 07 Oct 2024 02:00:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9941a697cesm269487166b.173.2024.10.07.02.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 02:00:16 -0700 (PDT)
Message-ID: <75485b2f-4ce4-40f4-bed2-343b3adc830e@gmail.com>
Date: Mon, 7 Oct 2024 10:00:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] [Outreachy][Patch v1] t3404: employing
 test_line_count() to replace test
To: Patrick Steinhardt <ps@pks.im>,
 Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>,
 Eric Sunshine <sunshine@sunshineco.com>, shejialuo <shejialuo@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
 <37b1411ee2c420f1a8578d27a2f7d54ccd3f329f.1728230769.git.gitgitgadget@gmail.com>
 <ZwN6D_-Ak1FoE0ix@pks.im>
Content-Language: en-US
In-Reply-To: <ZwN6D_-Ak1FoE0ix@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 07/10/2024 07:05, Patrick Steinhardt wrote:
> 
> Oh, you already do the change I proposed on the first commit. It's a bit
> funny that we first change things one way and then touch it up again in
> another commit as it leaves the reviewer wondering for a bit.
> 
> But I guess that's okay, especially for a microproject. So overall I
> don't see a strong reason to reroll this series, thanks!

It looks like Eric suggested making this change in a separate patch. 
While they could perhaps be made in the same patch fixing the pipelines 
and using test_line_count are essentially independent changes so I think 
splitting them into two patches is good practice and makes sense from 
pedagogical point of view.

Best Wishes

Phillip

