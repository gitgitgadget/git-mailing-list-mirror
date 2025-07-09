Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29E2868B4
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054038; cv=none; b=FEQrkDSUVMQCHr7d6Q5uUrH6NB8cWB0yPyD3DMXi8hg3Fwxx1GE4z/ehU50ee549kx7XjlAVawwpNiBFNBtVpwLSHucciEWVfGsEtb8gJVJ2D8YDFGoriNvYa+csmsqRNaLJP/Npzm91wcvApv08S2IFGeR6M5VfSiEHoi5h0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054038; c=relaxed/simple;
	bh=4XJ/TK+6gm2bUTutvkti++UsTzUjZ5YsalpAKnfuwI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCT+nOM+39qAeEoliqmWadwVUH1oR5mj8JJIcCSMo2tCWtw/9T/ANn2Ii6fRXZydcGsJqcKRDZsnhxPIhgBtabtqM32UuHSSrnk6z44LYnuTw8LBwsKFncbu1NOD1MJ8Ii/6fdeO3lPrgd+0W5BTdf8YHrut1YmQ6S8MNRdpBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCrRz0KQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCrRz0KQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cf214200so42118235e9.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752054035; x=1752658835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CdINw8QVRgl/ZadkJXjTkwuKdGwtENJOe2K/tPhhP3o=;
        b=KCrRz0KQsF3wpUB+46M72hpH5OiDdfBitsAaYhWHLohHZma+DOH6yEO/ve0FTDwvnz
         L/lwp1hJGysEodoT9gLQ51yoBNQaoHc2zlhTkq8gGlF0/htFFguvUDj36Mxf5XInUv5G
         84eZ4UtadvME+RhgnV4YeJi6aQW4B9ASVEifmd2hw3Ub8rVk8OFiC8vc5pPfIjES78Vm
         v0TbnthO+vQcRV/FGSLW8NGEhU8mJerqBT2RqZYBfwCQedC5FjmdQQk8SLuV8/R+qN39
         jnrFDB61UrUHCdN9JpbO7MHgO2O4blaLe9gy/Gx8Cn9EMPu0wuWZlzQENVEOEjQ0ZBSg
         HB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752054035; x=1752658835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdINw8QVRgl/ZadkJXjTkwuKdGwtENJOe2K/tPhhP3o=;
        b=TnXWQJ84UGd25R0VrLbG6v+gqZAx9styOUyuy8qTlowScoEWfs34GTznXKzdF5ha5E
         t7UV9OZklO7qb+/ilnPhgvPv75c/NjBa5+Rh1k+tlqRlF9hhlRB/xT9h/WOboQodiRo3
         ALoqDADno8PU0T7+GLz16E73G2nGr4eMbNBmoOiSnYfqaIoCH1y4RRw4cDgEvYfSvOms
         CV22S4OkHRy58vZs2lo0YBAtmaI6DOqlr+SaXsxka51DlTZCqoexQR2w2m5mukxn8FRP
         YhjECXB3/wAXylQr4P7AByZtR0TMCZgIbYdDXDTbT5WwXL0GEXHANnZa1LHzNZwDPw6g
         Cfog==
X-Gm-Message-State: AOJu0YwCDOkafYZkx4NQQYUq/jx9qRwIkN3yxt8alepGknz4hynvLKlj
	yxgybJoxjh5XU8Hnr+fn/kIH8+NPaFfKo9FrQ/T0ONjO5JaeS+MVPSwp
X-Gm-Gg: ASbGncub5CqqsG3yNdkzgICAxF+78xYNXlfMcGm+G+bRQ2eRx2mnZBsLcjPM/xV6Nyn
	Fa3ng6ABYt7QNEmuQFYthiYmo+bVpZVjWYKjRdzibhHL5KAfz79H4DAswNZ5g6n4loQjXHgwASq
	p7EOPJsFAEcduu/pr4W63pqWOvdG846gbwMn6TwANyk/jgNkRwxtPY+CZMax1Fvi0Mn1uC2JYcx
	GZRS5X+AlrK4EcpR1Rv6O/LfxwYHjNOLVKiF1OK76oaMVlwraNZ0Sf2dXqpUBCn7CK3nJETO/IQ
	K5HSpG0yfrKEAbqzyPubjdsBsvo9zSO8irUXQqY3NUXAKMOMRHTMYbpvH/rLVMoXzSr90B0RSiN
	FQv3YBDrEyP9F8EdBP9CgatKSMnFqC89vluW9tQ==
X-Google-Smtp-Source: AGHT+IEhX9f1i5GEu+iwuDo6AELtOwEqpjNC/egwS6W3bwIvmwXcCnAduIfQCh+rMKbC03Mn9BctNA==
X-Received: by 2002:a05:6000:2410:b0:3a4:ed62:c7e1 with SMTP id ffacd0b85a97d-3b5e44deefbmr1331376f8f.12.1752054035357;
        Wed, 09 Jul 2025 02:40:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0af7sm15618847f8f.35.2025.07.09.02.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 02:40:34 -0700 (PDT)
Message-ID: <2b0ddaf6-9242-47b5-914a-73fdd1dde4a4@gmail.com>
Date: Wed, 9 Jul 2025 10:40:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] breaking-changes: deprecate support for
 core.commentString=auto
To: Ayush Chandekar <ayu.chandekar@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <3747a1f77f03bf2572e195673d021dcf827ae59b.1751983009.git.phillip.wood@dunelm.org.uk>
 <CAE7as+YyKHzHjpCn2fFym0e5JquhroeDPHo_FHtdNCCb1HVSgw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAE7as+YyKHzHjpCn2fFym0e5JquhroeDPHo_FHtdNCCb1HVSgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ayush

On 08/07/2025 16:28, Ayush Chandekar wrote:
> On Tue, Jul 8, 2025 at 7:27 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> When "core.commentString" is set to "auto" then "git commit"
>> will automatically select the comment character ensuring that it
>> does not the first character on any of the lines in the commit
>> message. This was introduced by commit 84c9dc2c5a2 (commit: allow
>> core.commentChar=auto for character auto selection, 2014-05-17) The
>> motivation seems to be to avoid commenting out lines from the existing
>> message when amending a commit that was created with a message from
>> a file.
>>
> 
> s/that it does not the first character/that it does not appear on the
> first character?

Well spotted - I was trying to change it say "that it is not the first 
character" but edited the message badly

>> Unfortunately this feature does not work with:
>>
>>   * commit message templates that contain comments.
>>
>>   * prepare-commit-msg hooks that introduce comments.
>>
>>   * "git commit --cleanup=strip --edit -F <file>" which means that it
>>     is incompatible with
>>
>>     - the "fixup" and "squash" commands of "git rebase -i" as the
>>       comments added by those commands are then treated as part of the
>>       commit message.
>>
>>     - the conflict comments added to the commit message by "git
>>       cherry-pick", "git rebase" etc. as these comments are then treated
>>       as part of the commit message.
>>
>> It is also ignored by "git notes" when amending a note.
>>
>> The issues with comments coming from a template, hook or file are a
>> consequence of the design of this feature and are therefore hard to
>> fix.
>>
>> As the costs of this feature outweigh the benefits deprecate it and
>> remove it in Git 3.0. If someone comes up with some patches that fix all
>> the issues in a maintainable way then I'd be happy to see this change
>> reverted.
>>
> Nit: s/benefits deprecate/benefits, deprecate.

Good idea

Thanks

Phillip

