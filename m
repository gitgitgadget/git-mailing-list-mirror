Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B7334372
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734009; cv=none; b=V2OxNJbMuvmRoYDS7AAsqdz01KFQjdjsF262qV6k4vJLVLrBFbd6u5XWDtbaZx3fhNui2t+n7Qd1RClDcToIYDWxK9Z1KN8qauXfeYO+57DqonsqTVqA7zE+SkGUnb4RleINMzqnc5UXyRSQE98rRK+9K1HjGyky9zTtMKuRmkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734009; c=relaxed/simple;
	bh=lCq92qLoI2/Djg/lo3F3QLONmCGHkKEL97nkC8NjPo4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9kgkdyUlSv8LX3MG7BvNiRcx17nRG4YdvgetVPd30voLStxWqh95jTCMzczoEZbGOQdVxB3UiETkGGsflwVGNH197UNOs/sz5tZi7HLigIhaKrbHBxiK4vR8IYoj803RivSyKAVMgLxAE341CbhVhLnN3g75y+Ut3Z9LDYVivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLKP3o7a; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLKP3o7a"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8960a3fb405so1180422241.1
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756734006; x=1757338806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkPfz8Czs8As+uBBw5RCcTHyAg7tkwMuFe5LhD11Fyo=;
        b=lLKP3o7aBerNAj+rC7I83KJoA111fGEb2zxgdNFPoFI+36IxpJuQ8NC5h4bk4r9/YU
         NcvZ+MlaHpZvypbzj+Z6BxvrpU9kONWTk1HzvdymQR4ukKvm/DDP0I3kA9Sll08q4CRx
         Nkxu+CctJQ38U0WWNe8B7Nrq1RUW4B0YTlgwrJv1UtBQmNkbQyil41m2I2zBxyKPDbrk
         srKJfZ15w36k/33b3u/d9kTQ5ebFHc8s4/gtqcjsUQpbx09glVqxjNbgycmzjqCeSR9u
         kYzXAF3+a4zJj9J//hlH/4JUmWi/dNtpOdK8yeUCHYOUCOzzrvnWOEBf9oKYOV3g99n3
         3tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734006; x=1757338806;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkPfz8Czs8As+uBBw5RCcTHyAg7tkwMuFe5LhD11Fyo=;
        b=fT+b7HEWU7dQcZnhS17o7eTZR7vj5LV4C2+u4vSR7OJTQ2LjQDJzbieCWqlR4q3Lyx
         vjBp6oyEFT5C1BfXEjW0prJrBwV+w6nvsZGv8Mfq5CTA4Pi+FzJv7VEyqE/VR3S8cQMA
         ocimuc6k7oRZchKqArxeQ7v5ANjtATPvNMuZimslPsQBENYo1mDFkNhMMlSGNJCZPVC8
         JazAWvvZv/TZc5pQDM+q0ZY9lTfiLlTtcS7lprzNHkvTymypftr9wIVA6YX9iwOpNTbg
         oowtse5XIMkZWnM7iI2+IyO0QQndvaCQY14UNBlSsP/SOxMNb9zTBf+2jt/CsQMGxTeF
         nTbg==
X-Gm-Message-State: AOJu0YxeStRy4lwoAu8Ib8u5g65zRxvTHIqs6xqTjN5ZyBl6pj/Dp6Y+
	ysrw+NM+Jzzh1wetS/Mh/TTGQ38eqOiA+5EXnu3wL0HhtokLkjFZFKtr6jpzFQ82QI9Oi7b7FI+
	lC+ccN2AMFLSlbPpLOqBDAP5IQhs1KT4=
X-Gm-Gg: ASbGncvaWWo3KFbu0nBXdn67RM8xaJvSq6I4M0Fb5sw3hzylTDrOVlmZCZ9eIfxHFfV
	3aEL0CdQrK9NR1S8+43RLw8SVC18BwLWPk6XQjjNbLPZpt/so/zmSF2s9qRkQPO8OOOQ/SlWCMZ
	5epfRywe3TgeiZjZaIaRktnSYxuINRMsDsXWnePGL7cPS9TbisICoGrdKjI+Q3d7cej2q6r+j3m
	nD1W/2AJ6tpqbiNWpr0yKT74jPOdiLXUu3EPhUrQQ==
X-Google-Smtp-Source: AGHT+IFQChhBll7phWcjM6piWk8gKI1S5hMMUMd4olg/xUTJelaM18h5ceUNcis74gs1KngBw9f3zN26aA/7wrEr8bU=
X-Received: by 2002:a05:6102:32c1:b0:529:c3dd:d601 with SMTP id
 ada2fe7eead31-52b1952979fmr2679548137.3.1756734006212; Mon, 01 Sep 2025
 06:40:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Sep 2025 06:40:04 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Sep 2025 06:40:04 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aK3hwQbO3YwdXa3q@ArchLinux>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
 <20250819-228-reftable-introduce-consistency-checks-v1-3-8b8f6879fa9e@gmail.com>
 <aK3hwQbO3YwdXa3q@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Sep 2025 06:40:04 -0700
X-Gm-Features: Ac12FXz8rt0soJnUTKAPwI0pZVVZXUpECklljEVsD1MPjEGTPDs7VPB0pJ27BUw
Message-ID: <CAOLa=ZTuDtWC9bCQ4h+tvwGXoL7THxV5fLPxi6a1Z73B=7y+4w@mail.gmail.com>
Subject: Re: [PATCH 3/5] refs/reftable: add fsck check for number of tables
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000067d5bf063dbd82ce"

--00000000000067d5bf063dbd82ce
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Aug 19, 2025 at 02:21:02PM +0200, Karthik Nayak wrote:
>> diff --git a/reftable/fsck.c b/reftable/fsck.c
>> index 22ec3c26e9..e92a630276 100644
>> --- a/reftable/fsck.c
>> +++ b/reftable/fsck.c
>> @@ -2,6 +2,28 @@
>>  #include "reftable-fsck.h"
>>  #include "stack.h"
>>
>> +static int reftable_fsck_valid_stack_count(struct reftable_stack *st)
>> +{
>> +	DIR *dir = opendir(st->reftable_dir);
>> +	struct dirent *d = NULL;
>> +	unsigned int count = 0;
>> +
>> +	if (!dir)
>> +		return 0;
>> +
>> +	while ((d = readdir(dir))) {
>> +		if (!strcmp(d->d_name, "tables.list"))
>> +			continue;
>> +
>> +		if (d->d_type == DT_REG)
>> +			count++;
>> +	}
>> +
>> +	closedir(dir);
>> +
>> +	return count == st->tables_len;
>> +}
>> +
>
> The above logic is clear to understand but I think we should our
> internal interface in "dir-iterator.h" to implement above logic.
>

Since the reftable library is treated as external one. We can't add and
rely on code outside of the library. That's why you'll see some
duplication here and there.

>>  int reftable_fsck_check(struct reftable_stack *stack,
>>  			reftable_fsck_report_fn report_fn,
>>  			reftable_fsck_verbose_fn verbose_fn,
>> @@ -44,6 +66,18 @@ int reftable_fsck_check(struct reftable_stack *stack,
>>  		}
>>  	}
>>
>> +	verbose_fn("Checking reftable tables count", cb_data);
>> +
>> +	if (!reftable_fsck_valid_stack_count(stack)) {
>> +		struct reftable_fsck_info info = {
>> +			.error = REFTABLE_FSCK_ERROR_STACK_COUNT,
>> +			.path = stack->list_file,
>> +			.msg = "mismatch in number of tables"
>> +		};
>> +
>
> When reading here, I somehow understand the reason why you define this
> data structure in the loop. But I still think we could just define only
> one `info`.
>

I tried to rewrite it like you suggested, but I think it still makes
sense to keep the error definitions separate. They help provide
localized context. Otherwise, we'd define the error at the start, then
set individual fields later on. This causes some confusion.

>
> BTY, I wonder whether we should define some auxiliary functions for each
> check instead of adding logic directly in `reftable_fsck_check`
> function?
>

Post this patch series we'll dive into block and reference checks, which
will be isolated into individual functions.

>> +		err = report_fn(info, cb_data);
>> +	}
>> +
>>  out:
>>  	free_names(names);
>>  	return err;
>
> Thanks,
> Jialuo

--00000000000067d5bf063dbd82ce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c586d21d99360b22_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pMW9qTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXZzQy85WlVRaXh2b0I1VllhTEZDb2hwUTZ2UVcxYwpEUHZRRzVqeGZw
djh4QWRiU0NjUk1KcHBwdTB0aWt6eldJREtrc2ExVHRFbGY0Z0p1M0lKYzlEb2xmY2VoSndjCk1O
M3RhaHJjL3pRMUMrZXNNUHdrbDB2Sm5FQ2NpV2RTU3ZPVkZtZHZWQnlXZHlHZVVzcmxsTUs3ZHdj
VEhlQzgKVFJZc1pXWkl1OFdydFhvWjMvRExHTStnTEJCM29jTk4vM0doWkk4QmIrWG5QMHR3d2Fm
RHpZVy9UV29kNzNOdwp2czRyQzFkRmQ3ZzJXWlRObUV2NEIwTW5WcXpkN3R5UkkyV0RNdkpTZXhE
MXE3SThJRnRwT0d4SVdJTzhsSGMyCkRIR3lzSkRmNDZKVUQyL0ZoUHYzL3pMVWZ4anFkVk9KR042
R3J5cjR6YVNjRWU5NDJ4NEw3ODgwYkNhZ2pJMjcKcDFGUmphTlVRYkxZSGNTRWFycExwRWFNTXVw
WnUyQmpMRlZQSXVWVjlweUgvc203eEN2Sk1QK2tleW5YTTlFVQp1TkdiNk0za203cnV1MVlzTkpO
bExFaTArd0NFVVcrNHNiZUYyOG1MMktVZGJVMWt5cDdVb0E2SGx6THpIU0ovCkdhVEd3WGxRc0lB
OWxhdkdsODQ0T2NCeTVkUDJhSEdzS1h1N3YvST0KPTZXNEQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000067d5bf063dbd82ce--
