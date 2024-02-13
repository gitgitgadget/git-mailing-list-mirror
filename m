Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A0626A1
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863896; cv=none; b=pCOH7xBB0LaXoRoIju621xojAZJRjHWKqregKyKSWtcIPgdl0LanEVfUP8FDlwAmJVLt+N/CDtomYbzWOcAajSVsBzGzWeOLNUIiUnaZ2Id7mEiUEWSlXczdA4aV8nEb/y+Iboo6yNGCDgbWFHFIgdjP/mInhgNEh+/Gdc5Ff4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863896; c=relaxed/simple;
	bh=9ZiGi9oDw5/I99zWpeYw+ktWZW8Y+f3KNlr5Sbq3pOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OZNH3knpz7YPc+Tc5FDADOTQUqy/fzJQuZ4MOJxV/tJqhVOuXl1aMoTV6D71E9SpnVdUjRb/Igxjur3tZk1tZNmCjLmHj57XqTTTf76XAZ11MYCl/EkP/tLpLbx3PJHV/jtPUi3dPRpX37ApM/jI2A9l6N4NVqjgghJePxtd93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GU7t4WIP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GU7t4WIP"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so8960475276.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 14:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707863894; x=1708468694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nz6rXuM2rr4/qkONXIkNPuTqzpQsgy43nfVfnvMqtZY=;
        b=GU7t4WIPkNRsxmWT3ERLy/9FZIB+sn23mU6cFPngAfBpsbJCIOzG1H9qiHhAgLhalg
         w45LSqUUHuPTm58dUzZebboQmVrvpIhUlRjOGjEVJR0JRtLKV/Fz7v2nyhiKIrWh0SWd
         DacndhX4FFECJckYO/N2B10SuBtKxCsIKLhOcbKeIqzUNwiqA87SGwAezdAcMx2XIB1x
         jdUpCj/034TH2S21kgsYa8fCcY2Ygwh6EeSxasOkUYPq0H8dm8/Eke4ncgZn8r2yjGa2
         it+G6MXIeYz9RvqiGPE9RJIVe2xODVd1L4PgX8+9suaCvo/PXdFYB3s1HZj+qk/zn6/6
         RBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863894; x=1708468694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nz6rXuM2rr4/qkONXIkNPuTqzpQsgy43nfVfnvMqtZY=;
        b=tzTUWRSSPKd9aF408Vw8TLPCXHN7WBTviDMKg4iTN1xdRwO2nyeEpbcpJQdDqMBd+9
         gLcgmXXvoSN4S5yENunJZzEu6fJLoZ1DQrgJgkhbJdIEXdaWbbxkvpRFUc+t1KogbtGq
         x2tDSRF0/uXht8pr+xzxA/NMYyN4eVWkdbk6eV5jpbn24dIYnbwv4TV6OE8c73g9xw6G
         WJv6TGebejIXuZoghI1RYdGsCi7yCDjIS1e5o43laQh/NTXZz1bqlMoM/OPsq+kLdrss
         3ULgFHW5OvuwpI8TsyANWwJVaCf9cEgvMATGpe4dlQ+IL23/Gu4Pj/30wkynBMNrZ7/X
         LJGg==
X-Gm-Message-State: AOJu0YzmSe8r8hK+bSkmuhjHp6CD/g8jWA88a1nm/HlCZdkcYmQ3WwUY
	nr5Ssc9vHWRCR5N2rc5J4yQ2bqkcTVHaK9W4LDQiur2P6q/8rgLUkQMhK4Xjj0huzY0MgAakkuc
	++A==
X-Google-Smtp-Source: AGHT+IG0eVW6VSKudjk2oPDgOWT60PRjQk7/nOOHKyidy2NTJ6e4L2gv5hq5m6CqzhmztvWaSyWVDVdcH5w=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1102:b0:dc6:d3c0:ebe0 with SMTP id
 o2-20020a056902110200b00dc6d3c0ebe0mr172275ybu.0.1707863893995; Tue, 13 Feb
 2024 14:38:13 -0800 (PST)
Date: Tue, 13 Feb 2024 14:38:12 -0800
In-Reply-To: <xmqqeddmonq0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240208135055.2705260-5-christian.couder@gmail.com> <xmqqeddmonq0.fsf@gitster.g>
Message-ID: <owlyfrxw9ei3.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 4/4] rev-list: allow missing tips with --missing=[print|allow*]
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> +	 * mechanism to allow and disallow some sets of options for
>> +	 * different commands (like rev-list, replay, etc). Such
>> +	 * mechanism should do an early parsing of option and be able
>> +	 * to manage the `--exclude-promisor-objects` and `--missing=...`
>> +	 * options below.
>> +	 */
>>  	for (i = 1; i < argc; i++) {
>>  		const char *arg = argv[i];
>>  		if (!strcmp(arg, "--exclude-promisor-objects")) {
>> @@ -753,8 +762,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>>  
>>  	if (arg_print_omitted)
>>  		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
>> -	if (arg_missing_action == MA_PRINT)
>> +	if (arg_missing_action == MA_PRINT) {
>>  		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
>> +		/* Already add missing tips */
>> +		oidset_insert_from_set(&missing_objects, &revs.missing_commits);
>> +		oidset_clear(&revs.missing_commits);
>> +	}
>
> It is unclear what "already" here refers to, at least to me.

It's grammatically correct but perhaps a bit "over eager" (gives the
impression that we get these missing tips all the time and is a common
"happy" path). I do still think my earlier v1 comments

    Did you mean "Add already-missing commits"? Perhaps even more explicit
    would be "Add missing tips"?

are relevant here.
