Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FF7DA6C
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753480213; cv=none; b=o3fU5etQndWf4M8rUy2PFP1LsJdo8mL11mATisIWfVLaQK1pz3ruz9yIS6I/la9XcgNkjOO6LmXCiqxJ4ZcQEIFPUgSlBE++JIFG1PosqH1q0h5XVPdm+WIO9SpmiSkdr8bV7/YXAh1f0QyAqGhiWQjvkK9++4zeW7nyfMU+Sis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753480213; c=relaxed/simple;
	bh=13/+3Egv38ue06Dhx7fUGn17kQk9p7bLsE0i3exSXW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPjdrcURx9KYvX/GDKIB/Zj00zkx6IbXFZFFti3KqkHzb0IvGZR806ODBT5GBvFT3S0/7Uc72r1ggN0WhZAb5jpVpx1t/6sXBMjSAbUxKBYkPnTHlMJALOyG2fjiY79/CIFLpgfHKBOfvv+/rOXrwqPhBjL6z+kWDHv5nBn2I98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/+oyH8I; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/+oyH8I"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74af4af04fdso2823914b3a.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753480211; x=1754085011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFd545Zh0nWb8tjbIsvWCgDepGU9AdTUu5V0ib1N7WU=;
        b=R/+oyH8IswC1puSrwsgAZ/Jr+uK2LNP67BOts3NxSEohlTcQZFuhMWmrXEc0RTDyaY
         6qndHJWgOXrn2lVJ9QLiZUgD0TZZ3dlIbfxTQbrf0OPbrk30k4iuoWT+kf42q40ucFcT
         TtSxJJNGI6RDVLr3Y8dlXCBRsOZRAqgBoUeQ4oepu5KismANTcoQ/yC3YGJAPXPg6m0H
         HSWeU3JEsx185Y+rMzwXME288eLAsXr0C6LxwY5XiUK6QT/7Cbsr6WngQDCsZDO6uP/e
         sqcxnIZT0PFFByg8hLPZ7T80i1xyJLc+4heR4JG6l9qstA5hFxJty/wfeyKkyEjeFZoh
         SB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753480211; x=1754085011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFd545Zh0nWb8tjbIsvWCgDepGU9AdTUu5V0ib1N7WU=;
        b=Hnl1OcUyTheY6cCscsuINBeb5OQtxsvhE2nH1DrrFwJr5+tHPvQYhQ1H9NdMfYr5UY
         ku+nkdENF8gkJzsiWsJd6yGBN9kRgSv269AeckUl8K+kFTlF1lyG8WVR2Xk+lZ2qBWeN
         p7COkMOIO9fvlvavT1cxRajdVUbSc9ofpozMv9gC5JsbCEycNtfo00URk8nCIALnEvn7
         sFvKKmmYIpdJniEwYkQPVOT4nJFtNa0A78Gn7V4449xZEl1yAvZqLm/4iuBCxKgZftdL
         vuqfnvtSmOhoMroqVkHRHCfOBU4JXOcQw1rpEJTzLUG153VI7KupEuiaDhTKtALnVDRd
         z5cA==
X-Gm-Message-State: AOJu0Yx6bCXsOsjhbF1z4hDoD9Twp4oJIdQ6izvqgL5tAHWXF1FU8VY1
	qFf5c3Kltlqqag3lTYgpt7Hd5QLP4F2Ey5DqIAhR7L+sylKFZGdxpc67
X-Gm-Gg: ASbGnct5XqTLi2BGGvnAjd3JM4zDMy7X8k/WUANkUUJt5ogslekIxGsIWn6SJQBtTq/
	v64d5K0My/9TdON9NQbRYaDO/0tCi7ipBYM73Q2FFGK7EfVXu774O4VT2v1R7FF2ovqVqCcfqHw
	KnzK6+x7fXzlBhLMVVbDHi/Va72cTYn7XQE4Q15Yd09bjBm00kyfbKGUXRmt1UGoU1j2nlwbYQr
	ORp+JbpOh8Aw8CcThHDutzwl26h0ndaa0o/sSrSgScrbK7eWfaz2buEDeWERk+BL7DRldhzG58F
	MwL6kxwFqt3a1bMaKkSQrBCnOQibvR0VSPreDwOwzn2YqIPFam7ktE8gUOMEyHw2KeL7Flfn5R5
	9cU8dn1efEwfDBbLfbR0gWBAsVuQkC5A7z2Y/rKrkzejhzKRq7Fsl2lNEWvYHaz0UHcQ1
X-Google-Smtp-Source: AGHT+IHtSnvPdFnjhuehzfooDKH8nRiWMd9ZCKf3j6TvNguy+x4kGs8F/vcd5AlizfrbcJiOC8dg9w==
X-Received: by 2002:a05:6a20:7d9f:b0:238:abe:6363 with SMTP id adf61e73a8af0-23d5b705b80mr14050718637.14.1753480210929;
        Fri, 25 Jul 2025 14:50:10 -0700 (PDT)
Received: from ?IPV6:2600:100f:b06e:4b24:a34d:6d4a:f5e1:7b6? ([2600:100f:b06e:4b24:a34d:6d4a:f5e1:7b6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569a0asm529742a12.10.2025.07.25.14.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 14:50:10 -0700 (PDT)
Message-ID: <c392bcce-c845-4e28-98db-6acc6f5800fd@gmail.com>
Date: Fri, 25 Jul 2025 13:50:09 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-phoenix - repository recovery tool
To: Skybuck Flying <skybuck2000@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <DB7PR02MB42650FA1779D5A3608949423B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Daniil Iaitskov <dyaitskov@gmail.com>
In-Reply-To: <DB7PR02MB42650FA1779D5A3608949423B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/25/25 13:09, Skybuck Flying wrote:
>      ```
>      Hi Daniil,
> 
>      I saw your message on the web about `git-phoenix`.
> 
>      > [ANN] git-phoenix - repository recovery tool
> 
>      I am curious how this accidental rm rf * typo happened on your system ?
> 
>      Could you tell us more about it ?

I am an active nix user and develop all my projects under nix-shell.
The tool does amazing job for isolating builds, but /nix/store folder 
tend to grow and GC launch is required from time to time to reclaim disk 
space, but it causes lot of downloading later and/or rebuilding of 
dependencies.

Once I decided to remove unused projects instead to avoid the hustle 
above and was interleaving 'du -hs *' and 'rm -rf 
<some-dir-name-form-du-output>' using bash command history to type less. 
At some point after repetition I mechanically rewrote du command into rm 
but retained asterisk :(


>     
>      I guess the user/you was trying to remove a folder or so ?
> 
>      I am wondering if I should disable this rm command, but the AI seems to like it a lot !
> 
>      Best regards,
>      Skybuck Flying.
> 
>      P.S.: This is an attempt to send a e-mail directly from windows 11 outlook to the mailing list/reply functionality, manually, wish this mail luck ! :D
>      ```

