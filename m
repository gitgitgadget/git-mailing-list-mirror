Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F25B688
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707669823; cv=none; b=dh0sJLG52m6XIFO6gbtc9l07rrUdJqZe8BfuTLMyNRv23B7EC6N7swX9zy0iIPl7wfl40YMRnV5W2AQOs8Cn/VlebPccUkQKYYtrb8fgKVQLPlsnfJCIhBx/rXwT0XvQ3ZBbkSBIFvSPl3NaXCenJ/e+hfQcR5QRXEjrUN/G5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707669823; c=relaxed/simple;
	bh=BS4XsabXZL+s3H/5bHO8bPmnUOtV4ojyEOnT53Ek2kc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O4tmycWRUwIUQnfPoevrssPvdDVgwZm68ncr1QN3FOza0CZO2qgtmfx5/Z1eDbNFy32SgO3K04MWn+mvfvr4bvvvktN7QD/Nk8MW9EyITHinyGgC6j9YcorehgPfNpdnKUzvNA65X4ZYLUUyMT5iBT33KG86XH14v/l1A+Ky3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHSuQiPG; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHSuQiPG"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e2e5824687so137106a34.0
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 08:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707669821; x=1708274621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2nGRuLso9XKe/+4CHOm47lNCHI2THXaHcCoSDilB/k=;
        b=SHSuQiPGg/VTDo2ugu8AQZPe6MonHQjzZo2htUqAQyZn6kh1pUTqtIK7u5vwfvnU0a
         BergpwcVm3cZrt6xwtZpI/Tn/LHGtNZoLXdeZc2cQqJ5x4Z0MYh4kP6EBERj3Vnqo08f
         SuOWRRZmbsj5PyVqYmkmy9drAWtdn1AkJ3rqTO6WOCZk+6UAWl8M5/jmOYGsd9PtYt4c
         YD00boEmg/mKPKHnxJy83YhoyaygxqfKAjWnJFdNSNsmSjME0ISnrtr9y/f6Xbq3SjC9
         vidT/WFnV+Gy8Eh0GznDWduQNzjVI5t0LRhx/EY4zdDEXyuhE8iY4xrEkKMY2aHVylLG
         Wq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707669821; x=1708274621;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2nGRuLso9XKe/+4CHOm47lNCHI2THXaHcCoSDilB/k=;
        b=K78LLut+rloiDx2yAaKviuv6cTGHN7x9kR9w03nsMoyNUIGpLX0rCer/sGbfWzOBD2
         CggZz+HoXlxIB4aOYjIoqKyXpKIj3SPRZ1i6FCLSjG1xypk+T/Cau9btlRXvKbtHOHbB
         rLrLCg5OLxLmi0+fYRfHiMuBLa1qP9p9GToL+D4IVrojMvyWVLu3ItP+7JSeQ3BUjWeT
         1QM1sqp8khGWLfLnZ33EE6Bs5kRNxjTGALzXAwFAcv9JqAMRt0V1xUWHYo5QpmODbF9B
         //akbAFw7UZZeWle3pRvrw+1L7Q++JprPTPfYGpBty+fH42AAp4xDgOaNl99NVDuRr19
         TlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR3dq9Ah+FX2laNkOXHfH13NgoyxZYtR0QmckZzGiazq1W7qQNecqNZx/8obsesfMYOCr2czo01GIbi8bnrNZSYkpC
X-Gm-Message-State: AOJu0YxqmJz/j/NXyx5CndjoEkmwCSw8aS+r770rP7LoixGDM9zjHCrv
	lOaQeWzbq8ehBINrD3UteZ2nOo6nUxZaXDjpPdNc5rPqmBDbXx6S+Uqm92fYOMc=
X-Google-Smtp-Source: AGHT+IHWu9/4f0tbwLS0Eh1gaOwWaY69kQnL3wfX7KCLllkhBdc2cpPh9D0D2pp2ZyYJeLZC+5wOGA==
X-Received: by 2002:a9d:7756:0:b0:6e2:dfae:3eed with SMTP id t22-20020a9d7756000000b006e2dfae3eedmr1962833otl.27.1707669820722;
        Sun, 11 Feb 2024 08:43:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvnd5oNfF0ACNYAK4vvFA94smLqXzlHRGppU1WHrIiGauqrokzhWv/BjtlxnBympUGFRKfkvBSJMjw85fxt0262RO93sIkZ4oRRzZb+qnyVB4DNRJkU3OjHZLo9usrh+RnoiXrUJC/l9Q6AuMOeTU4arrfWdpwM3BBrVaYGWtuJA11WO2w6NYgZuHDlYHPkrmxz1kCkw5auuAqouiFswdWa3GR0/fipbSTb7bM0sE=
Received: from ?IPv6:2606:6d00:17:3855:859e:98ec:22d6:6e34? ([2606:6d00:17:3855:859e:98ec:22d6:6e34])
        by smtp.gmail.com with ESMTPSA id h9-20020ac87449000000b0042c7145fd19sm673134qtr.12.2024.02.11.08.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 08:43:40 -0800 (PST)
Subject: Re: [PATCH v4 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
To: Johannes Sixt <j6t@kdbg.org>
Cc: Elijah Newren <newren@gmail.com>, Michael Lohmann
 <mial.lohmann@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Patrick Steinhardt <ps@pks.im>, Michael Lohmann <mi.al.lohmann@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
 <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
 <2cf557e9-bf48-4bf3-be24-c1eeaa887418@kdbg.org>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <1c258037-cb08-5fbc-d473-743a60cd8eab@gmail.com>
Date: Sun, 11 Feb 2024 11:43:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2cf557e9-bf48-4bf3-be24-c1eeaa887418@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Johannes,

Le 2024-02-11 à 03:34, Johannes Sixt a écrit :

>> Adjust the documentation of this option accordingly.
>>
>> Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> Co-authored-by: Johannes Sixt <j6t@kdbg.org>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
>> [jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Signed-off-by trailers should occur in temporal order. Therefore, when
> you pick up a commit and resend it, you should keep existing
> Signed-off-by and add yours last.

Thank you, I did not know that. I guess Junio should be kept last though ?
Or maybe  I should remove Junio's sign-off if I send a new version of the 
patch ?

I'll resend with corrected order.


By the way, Michael put you as co-author but did not add your signed-off-by...


>> ---
>>  Documentation/gitk.txt             |  8 ++++----
>>  Documentation/rev-list-options.txt |  6 ++++--
>>  revision.c                         | 31 +++++++++++++++++++++++--------
>>  3 files changed, 31 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
>> index c2213bb77b..80ff4e149a 100644
>> --- a/Documentation/gitk.txt
>> +++ b/Documentation/gitk.txt
>> @@ -63,10 +63,10 @@ linkgit:git-rev-list[1] for a complete list.
>>  
>>  --merge::
>>  
>> -	After an attempt to merge stops with conflicts, show the commits on
>> -	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
>> -	that modify the conflicted files and do not exist on all the heads
>> -	being merged.
>> +	Show commits touching conflicted paths in the range `HEAD...$OTHER`,
>> +	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
>> +	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
>> +	when the index has unmerged entries.
> 
> Unfortunately, this patch does not help gitk. Gitk has its own logic to
> treat --merge and needs its own patch. This hunk should not be part of
> this patch.

Ah, you are right. I assumed it just used rev-list under the hood, but it's 
not the case for this flag. I'll remove that hunk.


Thanks,
Philippe.
