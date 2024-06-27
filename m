Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25B1CD3F
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719468096; cv=none; b=WIE1FhEWty/RMMpdNG+kHHGG/mbZUHbLtnMEZoRbWAWfvSQAETAv4/y7/xyUU/JLHLHoO6s0Q8YHmO7NDnidpTc0I7BZ0hmnnLoexw3cB6yjRA7cv6VKOBmaSpZ0miPc/okm7nVm1LVKrW08syvl3fsnvIiwEtn89m4TwTQ2HiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719468096; c=relaxed/simple;
	bh=qy3zOp95Hh0bOg6jVovzfyjcawGfgKmDrsHnXbO4ZSY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=WFic6GXlJ8KaidOOY2y9dsFMBbRYP4VioFMOhPD3ygZ5Jv8+id4RzLrTk3qkmqBHvFdjKPIhNDSizXASTtYcsbhilSTNKK88w6xUsSx2fFxTDUNq2fJ1j3eI/a2H3OsYCA7wK216XtrwXa2vTrhsuV/q9pvkshsvOa31q6TwTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1RqsAr0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1RqsAr0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706638d392cso426210b3a.1
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 23:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719468095; x=1720072895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AsxTsXxRt1w6ch85Lm/ESGnyytaaeT6qOnMEnLZ5YY=;
        b=J1RqsAr0H0+NeI1aaJYXS4f7WcqxbsV8PhbAJX5EDkonnz0Ea9AlUq8My/+vfk3l54
         N5vXcLl1rQ4UUirxNJm7Z6bOt74hlx1qL0tpwxo4pdHYBGdWcbgLwTaLcvSXfVfZd9zW
         RqwHaw+N++a793+1xJduxcGDYVEZYBFmCTYm5Oj+x6tU6FDvzcleXqvuDYVt1URp8+xv
         oe2BLiKDt2SxMsA+52mits/VYE1tHEs2x/vS6tbWZ678Loamqd0z2FbTtZA6i4Vr3pb4
         tck3PjHivb32IQ69sX57QGwTq/MLvgMZtZmCTl2JuUvPArbaZdj1yEGY3k8SRAwutu7t
         fJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719468095; x=1720072895;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AsxTsXxRt1w6ch85Lm/ESGnyytaaeT6qOnMEnLZ5YY=;
        b=VgTHvIrxeEfi+6Mb8TfnQAQKVPJNlIgrTBrSlOB1yIQBjPVYckCoAdgiBYRUUAKEVV
         e6OopSzPwHwinnj4qU1rdePu4gsTG06NYbkGIa1so+S1Oxpopvpkw3ygJmFZgkpV7Rep
         C9hcr3VkRz3A2trY9YBJcP2jKSk0eTG6YDKpSsdHshvwyJs+9G1NcmXLg++OQL+pHxPM
         IK0SA9T6p4GBle0ZN5mUZTEB59LxtjfssWRoJRuf21lSX5he45oRkqyzl4M+krj6Sv08
         PtWR5P/nVhf7fTBaQPCPkc5D1lwO/KHFfo33s3KNFNvmLxGvAtGNHcwlOiZL6yUa585I
         W+Tw==
X-Gm-Message-State: AOJu0YyQwE6MeYUykmGQMhozqDMW69Wk6TIaa5hFtiySfRBScLbjNyB6
	0P3YOflQ+lfiW+sBuvERZ1CVBjWod0p9jMO3QTL84X1TiJ655AP3eApHLUh4
X-Google-Smtp-Source: AGHT+IENUtM/HKA4YbO52U+VPSyodOdvMsRDad9OO7w5ILInWyEBWTEE2gR7iZcS8e4+qMDiFN8EIg==
X-Received: by 2002:a05:6a00:2d08:b0:706:a85d:bd60 with SMTP id d2e1a72fcca58-706a85dd2a0mr3924253b3a.3.1719468094625;
        Wed, 26 Jun 2024 23:01:34 -0700 (PDT)
Received: from ?IPV6:2409:40c2:205a:5198:b3fe:150d:3dac:4370? ([2409:40c2:205a:5198:b3fe:150d:3dac:4370])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b491f8ccsm488074b3a.69.2024.06.26.23.01.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 23:01:34 -0700 (PDT)
Message-ID: <1734a7ff-b169-462f-afc1-52a912d8d56c@gmail.com>
Date: Thu, 27 Jun 2024 11:31:30 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] describe: refresh the index when 'broken' flag is used
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
References: <xmqqpls3zhc2.fsf@gitster.g>
 <20240626190801.68472-1-abhijeet.nkt@gmail.com>
 <03628ece-4f47-40d5-a926-acce684a21e5@gmail.com>
Content-Language: en-US, en-GB
In-Reply-To: <03628ece-4f47-40d5-a926-acce684a21e5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/24 00:55, Abhijeet Sonar wrote:
> I have a question:
> 
> Why does --dirty code path also not call git-update-index and instead does
> 
> 	setup_work_tree();
> 	prepare_repo_settings(the_repository);
> 	the_repository->settings.command_requires_full_index = 0;
> 	repo_read_index(the_repository);
> 	refresh_index(...);
> 	fd = repo_hold_locked_index(...);
> 	if (0 <= fd)
> 		repo_update_index_if_able(the_repository, &index_lock);
> 
> I assume they are equivalent?
> The commit which introduced this --
> bb571486ae93d02746c4bcc8032bde306f6d399a (describe: Refresh the index
> when run with --dirty) seems to be for the same objective as mu patch.
> 
> Is this something you would like to see addressed?
> 
> Thanks

s/mu/my
