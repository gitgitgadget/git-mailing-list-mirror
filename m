Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4672AD51
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762608227; cv=none; b=Xqm2AiUMNnr2KdZ9YGsqGc2qJP7DLiHgn6AWMT7EXLpF68c5uxb03ftdrTVTlP72Fy9jSAjrsgSH8+fxIMB9ssOM2iCYvU9LBOusgWp7aFxe1K/iEb/jYIrCD8SvXg+X5bhsh+kLsuHlH2asvZfwCWOonsg5TuXzO0mi7ZwLpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762608227; c=relaxed/simple;
	bh=jb/IBbvAg21jWOfBQdFLw/oqXLIkuACkb2Myr/D4a3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifAcbPw8km8WVyYnK7DkRUPsy7SBMAmNuAXQ1Ir0yUM2jIzM3w4i4yQrgiaz/cCBhgHmHopP6rYlc7LI2hHebnhbrFQd13TSi1iz0VxefDMrTXw031eNLO94SkrD2g1xALoopUx/754vGyfTuXjXRCGtub9UMy8ydrXqFDJZHyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neOj11Yy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neOj11Yy"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7af603c06easo1508520b3a.0
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 05:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762608225; x=1763213025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNaV7TSHQDDqRFFbjzpr15fM356GVsX6/NeUi47aHAY=;
        b=neOj11YyF4IYCnNHmtYSkLPRMUIcth8UstJKjMgVAMYcgyDKrfL9rlX4x4GHd5vRbW
         jutfeljpMa3aYOH0qyHddoVvslJVl8QWu01JoMmf9eBpzmcO9rkr21pmgZ3xu0FvHNYL
         t420ovNwgHc9KCOi5EuhlH4pmWdt8E0sg1nU/MB9Sw8G/hweRtemIrysattY+H/qf5N+
         4OFHkop2QCd4hE5RkF6Q/40Eb0Ic8xKcaZSw3QoYon+toW77HGXLBqEbcyqyqJS7ZB9n
         bdNeBWbCj67I9qX1zlcn19k0i8oc39lv3LA+5kWtYSQfnZl9fFw9ZufPS2ljNuHhUnJO
         MNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762608225; x=1763213025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNaV7TSHQDDqRFFbjzpr15fM356GVsX6/NeUi47aHAY=;
        b=EcdWyJCjIcLh1M9Z0RmnY2Vbiw/BlBZZYQCt9QjYwHdR7rgR0201Ki6qR2AnCKWhzF
         Sc3nd/sF8v+Fke6vlXjvOeyZElH/FCTGZBIjDv3FkDqAKyHIYC9GorLSqW+MIE+T8hgd
         Ec+H8U9VdskqYdKvR06OIlbyG6FvwOfXc26P977qCGxXzHioQIQ7wv5K4EKp/msU07wA
         VlIzq7JIjqlpCBV3OxcBstxUY6zmQdZzS5cK+ABKs0XIoVnn9jI13yrcS3Ii347jABwV
         wJKsw5vM5UEe5UF+V/yjgzS5Ue20QiMb/RtXKfnAg/X0JGNEVhPfytFesyPCKQ48q0B3
         4BPw==
X-Forwarded-Encrypted: i=1; AJvYcCVrUQ7OMBS3+sc/SEIg6kOkgqZLvOfkbjTiMUGqyE7HkgjDfGfX1PgqCyUftMS5t/jHznA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUWCEK2QS9Jzmg35nFj+eNF+aixc0IJAKUAqakyHAJGfZvK5kt
	SYZ9ghS70pmWMP60q7q9ib4/0IZTv/HkMun+aQZetinjbVYlcgWKiQzc
X-Gm-Gg: ASbGncs583iMJpnzlxu6kiUW+AKpPiwbC1+SWgHDiOkRVnKNycWc7fItFRoNe0TEPgw
	CP2QqBfIRvhBeW8WKFcc+IZdqtEJ4btDGrwU1SmIPH+P1phU8ySl+HGmgPK6PzUweXY5TopRoSd
	I1mGj7/rb2D2qNqDJlBSv8btquPo4wUuUhMGuXOLMIuAy7uPzjCXwRaf8rJMDQ/EJRD5U0s/qk7
	No182S313fi25ZL/OiMOGRmefKW3hfDE3LFvV+HJb8bW69vTR1K4LbzzrLY8pfKI517ShygwTG2
	I5TexLJmBKKPXaPUavjS9mE6w0PLPJPcxlhzr/qVFMC/1ySr+sskDRTmGF/0VYggcC6pk08Ycuh
	Xs40NkfCCxhenMk3MSCnsv3YikpVjYRjAyFd5oej6WOMsjB+ZCgMHT0QMHV2Al93rSUjWJMNpQr
	Z7wIclFDzjCnGctPAXqSzL6wii6tQPb6ltu/2AnZwONc/SomIdgp6201H7ISJx7NxikW4iOGmYV
	W7zezvUM4BHn4PZ/d0QBspy1N2eRxdDzNPkeMKD4cG2Kg8MoMYZSlkSzV96NteHIQ==
X-Google-Smtp-Source: AGHT+IGZbkFI38pxaWcvDYSBbmEv9DOiMHdF1WKdLKUmRfQr2EtLF9OUcMkNn3E2wHOlmM0K7O6YaA==
X-Received: by 2002:a05:6a20:a121:b0:334:a854:64a7 with SMTP id adf61e73a8af0-3538882fd6dmr3985737637.3.1762608225153;
        Sat, 08 Nov 2025 05:23:45 -0800 (PST)
Received: from ?IPV6:2409:40e3:177:42ef:1944:c2f8:4a03:72f7? ([2409:40e3:177:42ef:1944:c2f8:4a03:72f7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c6951633sm6247982b3a.0.2025.11.08.05.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 05:23:44 -0800 (PST)
Message-ID: <00a5a8f3-f761-46e8-84cc-4bd95db68b49@gmail.com>
Date: Sat, 8 Nov 2025 18:53:38 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] replay: make atomic ref updates the default
Content-Language: en-GB
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: christian.couder@gmail.com, newren@gmail.com, gitster@pobox.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251105191650.89975-1-siddharthasthana31@gmail.com>
 <906fba13-fc84-411c-a43f-baaa2b90ed95@gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <906fba13-fc84-411c-a43f-baaa2b90ed95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 07/11/25 21:18, Phillip Wood wrote:
> Hi Siddharth
>
> On 05/11/2025 19:15, Siddharth Asthana wrote:
>
>>      @@ builtin/replay.c: int cmd_replay(int argc,
>>            determine_replay_mode(repo, &revs.cmdline, onto_name, 
>> &advance_name,
>>                          &onto, &update_refs);
>>             ++    /* Build reflog message */
>>      ++    if (advance_name_opt)
>>      ++        strbuf_addf(&reflog_msg, "replay --advance %s", 
>> advance_name_opt);
>

Hi Phillip,


> This appends the name of the branch being advanced, rather than what's 
> being picked. As this message is written to the reflog of the branch 
> that's being advanced adding the branch name to the message is kind of 
> redundant but we can always change this later when we have more 
> experience with "--ref-action"


You are absolutely right about the redundancy. I went with the branch 
name to match what users typed on the command line, but since it's in 
that branch's own reflog, just "replay --advance" might be cleaner.

Happy to adjust this in a follow-up if the current approach proves 
confusing in practice.


>
>>      ++    else
>>      ++        strbuf_addf(&reflog_msg, "replay --onto %s",
>>      ++                oid_to_hex(&onto->object.oid));
>
> This looks good.
>
> Thanks for working on this, I think this is probably ready to me merged.


Thank you for all the detailed feedback throughout this series - it 
really helped improve the implementation!

Siddharth


>
> Phillip
>
