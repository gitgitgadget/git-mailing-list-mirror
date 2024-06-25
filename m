Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930B944F
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321760; cv=none; b=lL60g6NauZTLa4jrUeKROs9TGX424uxpzj8eBEBwTFZL6iIb3rRFPAd1foc/ll+UvvauT/g1PIxvELgiieBQySgv0VM8dcPtk6NnKpuI/3Y69XMR1+jOX9MIiy/zw42t+K1zHz3rVHw3qmZBCtQlMHW8KxJvXesNt2qFArz8d1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321760; c=relaxed/simple;
	bh=8n35KInriReLwZ1Lep/ZPKQSssFS9YAuPws9znF7Fns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5lxuwB4c+wOXAoRhyfCqjywVbw7e2R6/glt3QZuRfhMbw070x/rimyEdCkFO54mtrmykPWelofFTUZIiys0GhwLtE55fgnKcrZ4EqACOfWTWoyk/s18vjC46QrI2vaDLsLFh5TY6mgqdYbuO+sEkDMIusQrdt5sgMnrNUt2Ql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax0LW+cW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax0LW+cW"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7068ca5a807so53793b3a.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719321758; x=1719926558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8n35KInriReLwZ1Lep/ZPKQSssFS9YAuPws9znF7Fns=;
        b=Ax0LW+cWCq0Upovb0abOvyVREcPToco9IEMPTc9fmv9MPqcJdUzfS3AITNqXAvvX/g
         o4k4nPqUYTh4XChR3QBrTVEwBFGgJHcFDthn3gTiJGQa6G+Z+kAGjn92j0YwQys+IlJY
         TBiVfKdFwshem9t/f1nbqvwjAnYuQC5DWr8Co7aQoM3kwe7Y5OjkiOWxsbq99ChORsRY
         pBEFfyZPNN7oexYB5XpdNORxPjyGhhKGfgZDGwgDD0r3sZBNR2soeY+FiTA/wlaWvn/N
         UcLEZUQECvoaA+VxHi2puva8aCzHyv+UW0MqEWkB6N8Qlp0o6DfI2VYJvSweJmMvRh78
         anxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719321758; x=1719926558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8n35KInriReLwZ1Lep/ZPKQSssFS9YAuPws9znF7Fns=;
        b=m90j5gkZ1p4wavutZDkVhimzhYD11xnnu0ADE8IiyiEGdXmM6lA/jFJmqrLe2mNxFK
         C3enDBtDBrMELmRs9jOHLA82h9FPR3FtqdQSPh90Ma6DbZuga+Ffs6uqvNM2l33QC7VE
         sKQGKLeqkKSkcEwmuCdBVg/UOhiJU5iW9UHEW0DlOVXJZ3+Mhqgi0qjdkXqMib9vp+qy
         KM/LkHRmg4x0l0PpUNz7emMYtO0Hc7oOjh8FHyQdKDBYelUgfCFkQpMQ6ZVzEkUdrJGZ
         rYfsVEoDjb9dRGD7YX3xMeLqbGgj4rU9noqO1V+cnXnqkImfSfvvHTy9G8XJ9b93QlyX
         jK5A==
X-Forwarded-Encrypted: i=1; AJvYcCVkP9h57rraHEFMWlXiiLcKtSjoUpbxvvQLv7E0XsNSpJyIyFud5yrVE6JQHD5LOC+9fV7+9fScuBWsOjARq4WCRh5N
X-Gm-Message-State: AOJu0YzPyyXlUr9xAXXxRH2vd4CcVdyrmNu6aD9bQvP5gbvq7xNbIdjk
	5IjgVcccyvNXT6rv1NJVqfmsDLeX32dEys6BpOgVXtElmxsFmOwi
X-Google-Smtp-Source: AGHT+IEPBe0p2DLC9qZDAO1v3M/xxMFZfSTjDCalHsisDkRJ05pr5R8r17qHu4vMUG7m28u1p1CXnQ==
X-Received: by 2002:a05:6a00:408b:b0:706:5c2c:e202 with SMTP id d2e1a72fcca58-70667bd82ccmr9344885b3a.0.1719321758401;
        Tue, 25 Jun 2024 06:22:38 -0700 (PDT)
Received: from ?IPV6:2409:40c2:3e:f8f9:88a4:a18e:4f73:d7ef? ([2409:40c2:3e:f8f9:88a4:a18e:4f73:d7ef])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba5b5f58sm7124806a12.73.2024.06.25.06.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 06:22:38 -0700 (PDT)
Message-ID: <68eb8651-c56e-449f-8102-b82506607387@gmail.com>
Date: Tue, 25 Jun 2024 18:52:31 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] describe: refresh the index when 'broken' flag is used
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
References: <xmqqsex2b4ti.fsf@gitster.g>
 <20240625064504.58286-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZT5asAE8-=jY7iR2hsGGshjQtBvpjcVacQk5YFa0u3Sfg@mail.gmail.com>
Content-Language: en-US
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <CAOLa=ZT5asAE8-=jY7iR2hsGGshjQtBvpjcVacQk5YFa0u3Sfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Karthik, thanks for taking the time to review my
patch.

On 25/06/24 17:57, Karthik Nayak wrote:

> We should also call `strvec_clear(&update_index_cp.args);` to clear up
> used memory.
>
> Nit: we could actually `cp` for both the child processes here.

Will do those, thanks!

> It would be nice to cleanup the repo at the end of the test by adding
> `test_when_finished "rm -rf stat-dirty" &&` here

All the files generated by the tests in this file are
under `trash directory.t6120-describe/` which seems to
be automatically deleted when all tests succeed.  Also,
given that rest of the tests in this file don't perform
any manual cleanup, I am not sure if doing so really
falls under the scope of this patch.

> You want to do everything apart from the repo init in a subshell, this
> ensures we don't carry over the working directory to the next test.

Ah, now I see why other tests wrap all commands except
`git init` in parentheses.  Thanks!

> Can't this be merged with the previous test?

Having those separate looked nicer to me.  I will merge
them together.

