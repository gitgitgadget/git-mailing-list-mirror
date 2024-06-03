Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B5C7A140
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406557; cv=none; b=FLb2vYgKH2GVrgLpimCAL1FseGmzCQSNnh0kKLaKbwgwLZMz0ww8YHOBVHlQa3GlwrPqGpGJ40QQ9iNo/ZMJteuSFqd2qEUiCXutsaLld+QbgB0MOfBCn4Qu1H3QjmIP7aoZzUXgU0B0glSnH97x6T3lcFwUivVA+/wpLNnu7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406557; c=relaxed/simple;
	bh=BW0Nbv8VKm3A8x8x/xcQZjykYZOVihzinRE2VWfa+x0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dLJcxdjimWNOP/0AV0r3PRUeTBNWFLdLS34Fifx4ekVD1DzHU6fvx3/HzokwXuMgCuetwJDa9/gadbZNUvJSAxwlJvKZQ+/++1jb6dSSdCFDIAgmyG1auS/8cDB5mULliQxf3nTACkREGUzKLZsAFuJqCFRN5rHbY/UEPfzOzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSHcwipa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSHcwipa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42108856c33so23664505e9.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717406554; x=1718011354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+sxoHuimPIWinZAMR74i2RUCF6Ch4506SE8avHFW/M=;
        b=cSHcwipaYVG5P2wpcNO3vNHLQOGn1hQBM3hw2yJAOo3Gq+b8GpU96ZMCxIquUpmJnZ
         W0KKYH/kOn924YYjJbl/W9PFJxO1NLtRswSZA8vu/0LtwCAHgj/ji2JYm45DAtnM1Jua
         /+T+e+CYTTWDy6calVDnlsmpPh3DZflBlXB41UW+ISuHoEgQV3YVtm1bHwVZa5HeHSnI
         mQumMvIHqOZUJcW6ytK1lYhko6ZBHV5sOD/ckS7s1yAaQGSN/MLRMAGoQUYaPKWWbtH5
         Kn4rLDBUuaE1gwIuEn+z/j6CDig3WtXaF8ngMfs7WHwPI/t1oLdF9pCSultkUPcgvLkI
         9VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717406554; x=1718011354;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+sxoHuimPIWinZAMR74i2RUCF6Ch4506SE8avHFW/M=;
        b=g4NaKl/kBDozBkO43jAZMa0CcghIbQ8/f5xGgYVcObP9vE4I9QgDKGmwGU9HDK69NA
         iKmQGjaymhtWz8zRtI9OCBhHTsecLcjeY0whIfdH714gzrCanrEvlLLk+zxlIN5qxqkw
         1CYYP6pb60pKzk5aX93ZWY6WQ+zeDvFPOafkkMuLPJ+85KWvA3NaZPwY7nuMinK5JC3o
         +i0sUpYAUDQIqZujQeyGozF3dj+D90TXbmxI477YGxxaDWmqJMOipSIuouDQWTnQkZlC
         ZHyB6mo3lW7afwg5E2mKXJpy5ALHcmdssiM7av48jXb0VHy9WhA8wiDGdLPCJg8crKZL
         q+lw==
X-Gm-Message-State: AOJu0Yy1CqaM3SJwBvOnKFJ4qKctqVByc77RR2XAM1ISlCHxn7PmAd0M
	LG9oEoUoxwTxS93OjBIyIdVBT/qx0nSTRlizzxLSJYzYrNXOcfLtqo6vzg==
X-Google-Smtp-Source: AGHT+IEmAWOw6XP/BY57eUIZyyh2ie/0ZMZ8a1jEPLi6H1wEWr77PgtKRDeCoHD0KAtWLo5xIEqt3g==
X-Received: by 2002:a05:600c:1c9f:b0:421:2c02:977c with SMTP id 5b1f17b1804b1-4212dca1eb4mr71694305e9.0.1717406553776;
        Mon, 03 Jun 2024 02:22:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42123458a5bsm77364415e9.1.2024.06.03.02.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:22:33 -0700 (PDT)
Message-ID: <28796edf-65eb-4f28-8651-af97e00cabc9@gmail.com>
Date: Mon, 3 Jun 2024 10:22:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/2] rebase -i: improve error message when picking
 merge
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
 <pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>
 <xmqq7cfbp6pb.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq7cfbp6pb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 30/05/2024 18:09, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>   1:  1bcf92c6105 ! 1:  91c6f2f1b45 rebase -i: pass struct replay_opts to parse_insn_line()
>>       @@ builtin/rebase.c: static int edit_todo_file(unsigned flags)
>>        @@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>>         		error(_("could not generate todo list"));
>>         	else {
>>       - 		discard_index(&the_index);
>>       + 		discard_index(the_repository->index);
>>        -		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
>>        -						&todo_list))
>>        +		if (todo_list_parse_insn_buffer(the_repository, &replay,
> 
> OK.  It would probably have been unnecessary to rebase only for this
> update.

I agree the conflict is easy to solve but GitGitGadget gets upset and 
refuses to run the ci if it cannot merge the branch into master

>>       + ## Documentation/config/advice.txt ##
>>       +@@ Documentation/config/advice.txt: advice.*::
>>       + 		`pushNonFFCurrent`, `pushNonFFMatching`, `pushAlreadyExists`,
>>       + 		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
>>       + 		simultaneously.
>>       ++	rebaseTodoError::
>>       ++		Shown when there is an error after editing the rebase todo list.
> 
> This thing is new.  It is unclear to me if this description is clear
> enough to readers that we are checking the edited todo list for
> errors.

I'm happy to improve it if you have any suggestions - I had hoped "after 
editing" would be clear enough.

>  It is clear enough from the actual code change, and the
> readers come to this list after advise_if_enabled() triggers and
> reports that the rebaseTodoError knob allows them to squelch it, so
> it probably is OK.
> 
> Thanks, will replace.  Let's see if we see comments from others and
> then mark it for 'next' soonish.

Thanks

Phillip
