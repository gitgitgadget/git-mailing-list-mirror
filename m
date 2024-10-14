Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFEF5672
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913709; cv=none; b=Sj4olRDptGxMn2/tvOz0isyECEo8HKHWENrfsQlwFdZmWrRiVWJ+zLC6kkXLULUm0uNVo5VaJ52RYKZH32KXp3juLYvNkigDK7WuxWdAYMi5DtB6wb6X2+gPwKB+mtc+llEoRvdmUkU+bqwaJihcogpSSipqM7chts4ZmNYrRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913709; c=relaxed/simple;
	bh=yOLJLAF/Vs2NvEtibbz568Ned1eZKY9ryHa5K34HVFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKauMvZJdtf1Vyp85lPUWZ0u4WpYkjUDIPyGsCOXic0gjK7SIJjE7cJtSj19m0v3qZi7Uxe7uSwnEAoL56+S8p0IH+jKw/YFxZDLtOyoNUgApi6g2dX1UM5w4dLnDLQu2WEcPk+x7sr7uoB3741+AWVcW/PjF3BCxW8MFXQiQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTLhoK2s; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTLhoK2s"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so5039532e87.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728913705; x=1729518505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CYDoYz9B2OyI62K48BZ5Q6qoF9U60M4TE+XdOLzqGw0=;
        b=mTLhoK2sdaNa77JRyzIoXrgDUCWrM7ahldn+E6NzU38IfqNbIT4nku5uTPSYMCCgJT
         AWlYExXwxUXg78B8RkdAH3NLtsClhMgyd4q4YTn9Bg5y1TqTks4WHW5jUYCL9Wlix/kp
         a8HEV8pjDMCkaA74qx672xw7H6aS0Xvt07LaWnYsm66iYETnS+2a7oY9Xvq4Byoca3X8
         eT7Fdqd1SovY2jIMynzWsmmwDT+FDeBbZk2AWz/eDoz5OjOYoxGd6ONVI8ZoMZNs4+7B
         C1hl7PIOCn/bZo3HLocqrr4Ls++xgfqZyy+1fHteDHFWIxPFiOReh5nhQG2/F2sHsaAj
         ahjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728913705; x=1729518505;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYDoYz9B2OyI62K48BZ5Q6qoF9U60M4TE+XdOLzqGw0=;
        b=Z60legHmCfBvZOJiTeQHAN12l/onY6C3paLdJMH0Juu1CL7ksFzHBO4G24g20KR+QM
         xjRTACCutxYItTkHL7VTaPDtlYENy+fe/eo4RNVV2JxV2mzqs194mKCbCNTNAXcT4q1v
         MWNw+Tgqf4Hdi/r7g+k9Uxvuza1jsPCJkHvDqcafZifSThswhPU5ePUPL0tHDvQ3VOM5
         8iwBtkj6ibUhrJA0Tzm/JLLMpA8O9EbwKL0gNhosG1DORzD09pKTzOA86XQyEBhnDsk2
         HVgLdrJo1RMsotmDQMzOU+iU0mwqObuY3J+8/W/Ivns8WyasUj/NKAi9aGqsYCJuUStX
         VEig==
X-Forwarded-Encrypted: i=1; AJvYcCVQHfH5PreN7gyMQwFHKFVsDZ0XcddDVGAhBEPng5YLxicjfsEoa/961mAFLq0JDXBVYig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBalPbQW/iPeXe2ZWNA1TKK1c7Oz1yh1F3Aoe3eqgv4THHakIh
	mab0ZN5HVJ7/nJf1gpKhvTe/7mat1EETMugHZc3ki63Qa6HEAz1KaA8okw==
X-Google-Smtp-Source: AGHT+IGuVsFlAuwxh4hgZf7F6yMzM1cyx8w0Ef0vo7bwzUUPvnL7DcnTaGUswlbngg2RFX3NBIrOHQ==
X-Received: by 2002:a05:6512:3351:b0:539:e38f:28e4 with SMTP id 2adb3069b0e04-539e571dad0mr2564861e87.45.1728913704998;
        Mon, 14 Oct 2024 06:48:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d885sm156111905e9.46.2024.10.14.06.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 06:48:24 -0700 (PDT)
Message-ID: <4d178731-b530-4806-84da-abda50b2ecd4@gmail.com>
Date: Mon, 14 Oct 2024 14:48:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <6875cb49-becc-4562-ace8-9f07848a345c@gmail.com>
 <63b3f6e1-d076-4522-9dee-79516200b8c3@app.fastmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <63b3f6e1-d076-4522-9dee-79516200b8c3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 14/10/2024 11:06, Kristoffer Haugsbakk wrote:
>>> Cc: gitster@pobox.com
>>> Cc: Patrick Steinhardt <ps@pks.im>
>>> Cc: phillip.wood123@gmail.com
>>> Cc: Christian Couder <christian.couder@gmail.com>
>>> Cc: Eric Sunshine <sunshine@sunshineco.com>
>>> Cc: Taylor Blau <me@ttaylorr.com>
>>
>> We do not tend to use Cc: footers on this list. Also note that as there
>> is a blank line between the Signed-off-by: line and this paragraph the
>> Signed-off-by: will be ignored by git-interpret-trailers.
> 
> I thought that gitgitgadget checked for missing sign-off.  I’ve seen
> that message before at least.

I'm not sure what the DCO check does as I can't figure out what code its 
running, but it looks like the commit lint just uses a regex on the 
whole commit message[1]. I think the check could be tightened up to 
ensure there is a Signed-off-by line that matches the commit author as I 
seem to recall we've sometimes seen SOB lines with another identity instead.

Best Wishes

Phillip

[1] 
https://github.com/gitgitgadget/gitgitgadget/blob/7726b025bfaa18b72c889ae01f053d77d34f199d/lib/commit-lint.ts#L142

