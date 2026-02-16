Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6E29BD87
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257747; cv=none; b=lyGp04uiDFXihAmm0jp5RXntqEakDqON/MVqAWaDy/vtN2AxWnVXDdtXQmPaBdtKzT+oaqRcbn2mzpHqya0OPZWlXTY4KCmr5XOFFakChXNqRiyctID1ZeV+v0R1nJuHn6+QNRQuCDrVEfihwqFSpIqw9SdpJd6fCTHVxg/595Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257747; c=relaxed/simple;
	bh=q4lsX/bhoexjh1b5ZqNdyQM5qRzGii00Ya/eqpUpopg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bv+V+eGQDFSu/CB30qLIiT0BekibN13BMjSqL6E9g25+D+fYh51/xj2zAfIoXudAZD+9RDnzKXGKwcJ/GTcygyvXUi84AGbYd3nFCL8j6Sf2QufT/U2vX3PzsD2fvcB/bb9L074bYXNMYgkrnKZbIMBMuxoI1UxM9u+oOO894+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XarWhEVC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XarWhEVC"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c634be422b2so172654a12.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771257745; x=1771862545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1dCFNkjtzbsFJkQ3Eu3Be1akboOnCLlZrTbbAJwDWY=;
        b=XarWhEVC7rhxPk7Gr2eBaBKAlnQaYC9X9GdOjkgoyxDWnv27w61ShhXv/pGKK2+Xt+
         sDfPx8XCblsv7JuIYUXsgP4ZrSCUTjwArBcpacJxlTEI59o+iIOIcSC6rJgrExLN7IuL
         EP7J7M+r40V+iFYEBW/67TXTDRke5X3mqie/4j2jKElHXVmk0D5bMXV3mD2oGsaX5lqm
         5CadSaaqY2ZG8t6u5kMAMf+sIDk9Jr9iTs+6zq/coa2IoZmqPP7hFj2Zfl1oaUPfuHKX
         s2AcnmUrMe6utezc55Zqcqih1uB7ojlqRDS1rshCEFi8xddkhzLcT+5VxCbyfBx1ydAy
         wQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771257745; x=1771862545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1dCFNkjtzbsFJkQ3Eu3Be1akboOnCLlZrTbbAJwDWY=;
        b=nhR23QmutSce6PcFr54p245K9hiyDdkApFB6ITQujQN6t8vX1jAHOHvw4D3S6/c84o
         0ixF2z8PteFSDEaGX7DS9pJy0xFuZOwJu3VC4pvHWd63G/IPHjPigfuX+22txbC86Nfp
         AUDd11Q/QtKRL13Cc6SWsnc8OqIcl2HB12NHT7c1ComfwkTEeNkGLZEGmH9PIfXSztee
         5bp1iyOavXDKJ9thtBC6vogq6rkmdJT7r9RDVSuZB5HOO52Uq+mV8/0I8u8wZWFL7XTQ
         uluGbiNjoeRmfo5oqxWqiMcEwzhvhZflfcaVTdUYIJa5gS27pIHASDMtZvko9tuRy7VI
         WYig==
X-Gm-Message-State: AOJu0YzKaVMPpeo1ZS1WqxLW6lHxU+JI47NA9NBqjC4U6u+LkDX6rp46
	gICa3oKkse645yo67eucimEBcoD7lvVrQQokZk3I1mjW+NDBRKZhV4YSNZEm7m6w
X-Gm-Gg: AZuq6aJSKisEsGnRwWDjmcQPiAsgb9JmDIFjK5ys6+c3zxWeklbNPiU7Cd8GYeB3QSv
	65ilqSnhbTlMTXqNTGHaiE+rsbnd46t+3gY4shwd7LyKnGtFgh+oY9sH/Q+68kQaR5ndocgqPqE
	zNPm3q0YDiWr3FU5wNpcsLJfdru/xuz9py+0HmGCNp8kTczAQvTkSJWPBJ1peKn6vwtyv8GYqyA
	iHQpvL0BjGXAa8VygZ2SEx7s8p9WpoG7gl8hdE309UbbppTt2hrOKittiBGik2gtcLT59W/JgdH
	aY5iw6AHLYO96LGexbrRQVI5SB1H0TWYM1wXPHV48KXVoyHry1Bo7Wic/0agBJrJF7JFn2hjjiF
	X49tjjMHxFHgyqFfRAs8U+WtFOobfqRqhXWZlDURdw9yDnxZy0FQ+ukjYJvhcB0DoDn65R2NMKJ
	en3jQUlkZuLjU9nCoTGs/BOCg3XN0=
X-Received: by 2002:a05:6a20:a11d:b0:341:730a:ef54 with SMTP id adf61e73a8af0-394670ad83cmr7858322637.1.1771257745136;
        Mon, 16 Feb 2026 08:02:25 -0800 (PST)
Received: from [192.168.0.105] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a626bfsm10548253b3a.28.2026.02.16.08.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 08:02:24 -0800 (PST)
Message-ID: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com>
Date: Tue, 17 Feb 2026 00:02:22 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] setup: fail if .git is not a file or directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260212172405.48614-1-a3205153416@gmail.com>
 <20260214045247.118013-1-a3205153416@gmail.com> <xmqqfr72flga.fsf@gitster.g>
 <f7426def-dce4-41d4-81de-91388fb41997@gmail.com> <871pil76sd.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <871pil76sd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/26 10:37, Junio C Hamano wrote:
> Tian Yuchen <a3205153416@gmail.com> writes:

> 
>> Sorry, I didn't express myself clearly. I meant I tested it myself but
>> never add a test script. Test script will be included in the next patch.
> 
> I see.  Thanks.
>

I am currently working on it. However, this is my first time writing 
test scripts, so I can' guarantee they'll be perfect right away. Please 
feel free to leave your suggestions when the time comes.

>> On the other hand, if I understand correctly, state flows should be
>> categorized as follows:
>>
>>    1. Nothing there (ENOENT) ---> ignore and go up one level
>>    2. Directory (IS_A_DIR) ---> check is_git_directory
>>    3. NOT_A_FILE ---> die
>>    4. *REAL* error (READ_FAILED, INVALID_FORMAT) ---> die
>>
>> And I mixed 1 and 2 and covered 4 in an obscure way (!= STAT_FAILED). I
>> don't think this code is "unrunable" but indeed the logic flow is
>> GARBAGE. I'll fix it.
> 
> The above 4-bullet list makes sense to me.  It makes me wonder what
> the current code does and more importantly what we want to do when
> we find a directory and is_git_directory() says that it is *not* a
> valid one.
> 
> Thanks.
> 

If we find a directory but 'is_git_directory()' reports it as invalid, I 
believe we should treat it the same way as 'ENOENT', isn't it? This 
ensures that a random empty directory named '.git' doesn't stop the 
discovery process.

So, the logic for case 2 becomes:

  - Found a directory;
  - Check 'is_git_directory';
  - a. Valid? -----> Stop, we found it;
  - b. Invalid? -----> Ignore, continue the loop.

Regards,

Yuchen

