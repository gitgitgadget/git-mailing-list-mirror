Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31730274B39
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765148470; cv=none; b=UHNH85XFNxuEKT/5nkHjR5VhfvmwpPik3RTIEbz2sDOGqbGK+8XHAYWbkhE++zQ4HrSipLAp+0DCIFhmbuzyrneHW5RocrV0NdZuDnpM91dfOyKeOwgjQIggsFfJr8sq3bG+i+QbchpB7zjCKtr69/cPGjIosF65meHV5wbJxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765148470; c=relaxed/simple;
	bh=YM5wQeYfvhNZtchlIrBnf5V5zxR1AMl3FkvK8x9bkgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+3SUuoBV/t0oTV9bytDDhafSQkmQ7qLphwNMABbx7Ah1QMMn0eXTYuP1gd9Of2iU+Pg8poBVgtUq2QC1+nVvYe7p3pVR0cRndpUn1CTraWUIsjkQxWbEuKUEBYkL3txOlFUhYua/Qz3A5NE7T4/ZbyGr77LkNmAizN9Al/tqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZTCw7FG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZTCw7FG"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso2948899b3a.3
        for <git@vger.kernel.org>; Sun, 07 Dec 2025 15:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765148466; x=1765753266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/saoqZXBzgey9Uo6Tsd4HWFpjPI5Flal2cBY2RVnRo=;
        b=IZTCw7FGj0wHVDNGBbsOwBKMb/wp1rl4en6cwZ40h8lF5FX3QUzCzPGZ1C4vlyuIOx
         NCPqragHUu2YlKFR7I/o27rZudW6bZyD0SMxEMGOQdI9jbDudi0SWazHCUhGAehv5DxA
         J1AEchg/5VY1eIoutoQX30iNYu9+++gm7oFqpXtHgVjms4+1Im0hpnV/1Fkg6cKuNmpv
         SNKynutl75OIw+4yiFVnsF9oAJ8kWub7EozoKcfeEeHMCUkZPHY7NoQsxXYUxhdKKN6g
         gM6yQYiIxpwRxXvL3OXCLiRIM2LIL2wQ9icRCZcPsZeMhl5g0PAH2n0CnFIcq0OswtmQ
         /LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765148466; x=1765753266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/saoqZXBzgey9Uo6Tsd4HWFpjPI5Flal2cBY2RVnRo=;
        b=C3nad4nb6sCYFQ3zSInWV/Een05LmovCMu/YeFHmTGJai4NPrGtRXh+2fLFKIkcVhy
         /YdbLLd/Phytkqc35olmhMcZnYqJ9PUDc5ISc1l/Iq67PyW3lByrxxjBnN/ZIDn+bAnH
         7RyIGmmhcBh2lW9rLd/JoxIE8o5ist4ddCFWW+nfq96ZV063iL6N3TEbj58riWVACMDB
         5ZzwkXxsiapswCfaQ3x3bkZNIeldzLKSUgaPGo65ayS0Hz+nMiIRe/PcQ3YTdlaTj9HK
         mhW+NvADsI8CfFC7Ijk+rhjKMgd13fKZvVeUW9hmSmgxeXx7fIye9Rm8GKXchfE+Lv8m
         gGNA==
X-Gm-Message-State: AOJu0YyEI9mLNAbUT6rnUmCWdAUJCPIPVsWK1yC9Pt0hBMPl02qk96sS
	d4b2oKka7WOT6vPPXpOJ272IcbfFA0HU86TDlMwqaJpo3gJo34g/iHNK
X-Gm-Gg: ASbGncsgL5NRhbQ53LANcMcUrZrxFNhsXxfBLjHcWv6kjhlOCAuQbz3MRtkfBl2LMju
	/haYs5dEUZ+Ihw7zCKrj/w6uUlzgy/PyaO28/+Kmt9phKHgSTWAttxvb7tNOqAgMaKnm6exxiHF
	BudyHwLgzYLbWIsyyksf6f0CUuU0c4A5DquQ//AJ3BT2LP9KTtJ58lcjZfvc6W4DMyu4G0I5rqd
	RakoHcPJh/G7wQEpFOx8xOeUPYHN/0ny6PMW0Fp4XXO8GdoXJOooo+wEQ4KUcsKSjo0rJT34TwI
	l43f6h8uSYESNYQR0uf1M9HWTpll1NQdyNTaf6FVv6qH0R+TcXsi1WxWd1dBWoHGYm5ZbWBt2yh
	dzDdkI3YlgVh5KW2+B6vQkjhcYRxnuJaUo5O313VuMphK0Jo9tjzV1zCTz39pmXaMdU75BQZA6e
	KsqCNf3p/uMuiJES3ESkSHpmNx7imkRGDeGe6qcwwDQnlNRbEaqCICZ4stxt8aQbgnGIXpmdc+E
	3ICNSEKNWndzHfl3Z+zrO0=
X-Google-Smtp-Source: AGHT+IGRNfhQMn6g766ah+6/rDX2m9lWhpRwHPh8zmdUSR9wbbzDUXJCgHWDalQd3cn55IGgjBEvJw==
X-Received: by 2002:a05:6a20:7488:b0:366:14af:9bd0 with SMTP id adf61e73a8af0-366182be663mr5010203637.70.1765148466240;
        Sun, 07 Dec 2025 15:01:06 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:2d5f:847f:53c0:cfd7? ([2409:40e3:30a4:b776:2d5f:847f:53c0:cfd7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6817395ccsm10131990a12.5.2025.12.07.15.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 15:01:05 -0800 (PST)
Message-ID: <ac12100d-4aba-4d15-8bcf-c50e6100c95e@gmail.com>
Date: Mon, 8 Dec 2025 04:30:58 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sequencer: extract revert message formatting into
 shared function
Content-Language: en-GB
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, johannes.schindelin@gmx.de, toon@iotcl.com
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-2-siddharthasthana31@gmail.com>
 <aTLDA11AKs0jlxFJ@pks.im>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <aTLDA11AKs0jlxFJ@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 05/12/25 17:03, Patrick Steinhardt wrote:
> On Wed, Dec 03, 2025 at 01:46:10AM +0530, Siddharth Asthana wrote:
>> diff --git a/sequencer.c b/sequencer.c
>> index 5476d39ba9..9f621aef4b 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2365,22 +2365,10 @@ static int do_pick_commit(struct repository *r,
>>   		if (opts->commit_use_reference) {
>>   			strbuf_commented_addf(&ctx->message, comment_line_str,
>>   				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>> -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
>> -			   /*
>> -			    * We don't touch pre-existing repeated reverts, because
>> -			    * theoretically these can be nested arbitrarily deeply,
>> -			    * thus requiring excessive complexity to deal with.
>> -			    */
>> -			   !starts_with(orig_subject, "Revert \"")) {
>> -			strbuf_addstr(&ctx->message, "Reapply \"");
>> -			strbuf_addstr(&ctx->message, orig_subject);
>> -			strbuf_addstr(&ctx->message, "\n");
>> +			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>   		} else {
>> -			strbuf_addstr(&ctx->message, "Revert \"");
>> -			strbuf_addstr(&ctx->message, msg.subject);
>> -			strbuf_addstr(&ctx->message, "\"\n");
>> +			sequencer_format_revert_header(&ctx->message, msg.subject);
>>   		}
>> -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>   		refer_to_commit(opts, &ctx->message, commit);
>>   
>>   		if (commit->parents && commit->parents->next) {
> Is there any reason why we don't also handle `refer_to_commit()` in that
> new function?


The `refer_to_commit()` function depends on `struct replay_opts` and its 
`commit_use_reference` flag, which controls whether to use abbreviated 
commit info ("%h (%s, %ad)") or the full OID. This is specific to 
sequencer.c's interactive workflow where users can choose the reference 
style via --reference.

In replay.c, we always use the full OID via `oid_to_hex()` since it's 
designed for non-interactive server-side operations without the 
`replay_opts` framework. Including `refer_to_commit()` would require 
either passing `replay_opts` to the shared function (leaking sequencer 
internals) or adding a format parameter which feels like 
over-engineering for current needs.

Happy to reconsider if you think there's a cleaner way to share this.

Thanks,
Siddharth


>
> Patrick
