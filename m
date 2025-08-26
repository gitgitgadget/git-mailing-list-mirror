Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CC230BDF
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215605; cv=none; b=p7FZpcEPbc2mrpwK0T0Boq28HdGQiyX6sVsjgBbouhKiqsWG5opHItjpx3goTRxLtY2U2jE24dC+er1p9cvLT92BS45Jw1CT8BPzoQFn+78jVIEd2ZXrRPDdrRmlnOZ11yrgMb1nZsGRtVDUbR6Iqr8MXNkTiZiiptzKD5fwJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215605; c=relaxed/simple;
	bh=QpkWHgVRwXbOkF3Nx12uCx7eHim0jAaVqAohmRoPir8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GF0rpMpiOktACwkPl8mccCyf+2EqEuhTQgdKeOTuFqtYt3AdlXfCmtrDLtUXTcBw1THk6DkZVPs4Tr2dtaC2WXZCrIuCsYNcUzBGzK1OeqASUuoAD1zsmvv6rIL4M/+G81bI1eBHbu4szpOiC4tCXW+v1VD4muhBZq/Ya3ahaBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laRMKwwy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laRMKwwy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c73d3ebff0so1193716f8f.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756215602; x=1756820402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m+bwcyaXWEAyqttTthzXbUcU0JaEvJwSqvxte68mA9U=;
        b=laRMKwwynkJQCpz+C2THaOeea5IpdZlkMhrBRy1vLUFQxm+ZHDLiM0FW8paDrHahh/
         fXL38MLxNsld8hD2FZIcj+Qzp37l2QmxlGKUtL/Qxs3Mmte7BjeQAt+WI0j8VMVKk9X6
         8Xojto7EA7MZuf/G+J0VzmHyx6ed+sDO9JcJLAbCycaCXOkqEtEHVht+QADfzbKI/xTN
         2fY85d9y6JSu+9DRIV1xQezO2LB5vTiJ/HK4An9H5N3PZAdUt9g+46tax1kHy/s4l8r+
         jCheCwxIeZErHlbyzN0++7VeIkq9mU5gN7MxIIFHHhQOr+HNBrVosUOfKtoMqE0KXPCO
         Pw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215602; x=1756820402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+bwcyaXWEAyqttTthzXbUcU0JaEvJwSqvxte68mA9U=;
        b=b8YJu0Ch+0RG3XxT+ZL2lsz888rw/4BcKTyFh4+C/n4BBXp2IpiXpyd5C5FRORu+uR
         T1EhMD1oVbdG1Q7kPWiPCLVe1T+4xQzwrOMcjdIjTUuew4PxUr85XgQ6sylEXu/OBeQ7
         dDwYD/PJwVCohj07S+SgAzIP9BkoLYvGT4iQHcevH9lT/ltRIHmYwVruN0slLn3YkOVM
         NV+9+PKQ7p2lBnZ1Ms8yVlGa/in1RdAoSpqSPAQU4b0d4zB8c5YVK1Md7Xw9UwDQUWt1
         zFU9BYKFgaKQ81ZUVfoVJSJEtuuOdJMaeqQsYO0X1KGhUdWUVhFCI2uAVBBrm/KJB0OS
         N2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCW21RQprHKW4m2WPBTt/C+f59mUS4U8UZU1YHLGu+B4oSPCNX6V53EwmlVzwAJG96pd0Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjasE8CWh38qUlLHMkJteeCj6s6qaUwox4pAM8VhR86DAQ+pgh
	fdC8sTtfyXU7IWB8CgUus7T8k03uqhR5gGfRZdaCuMxoJRrRakh3LVt1Ym1Btg==
X-Gm-Gg: ASbGncsn0vc6dVIPnU2+mXoSG1Nn3rPqfQXYBfwVbHyXs8VIVJHlhCJIgZ+x/K9lOQ7
	4UKrrFqSKyz1wqAUX78XY4PJPUTSA8IIssWYBpKHfgiMk14JbkgWn0S9SZ41D4nF878qztduUfd
	ZC9Zvqw5O2rkZgleEpRMSJyIQF5jyuLMobk/9TYzTEmw31OVk3J+8rozyq52tCdI7OMTMFIACDA
	/a+dCXOXPEc+iRuMcj5alE4f5OWfQGol7HWW2KXL6knRziv882vESSJMcjI4lrhzDwpb2WtoPwt
	Ugyd08166rPfNLp97MWmXVjrUx2VpB3bHkSHe2KiLYcG+O0jz2bMicxRTNzpG16FWYV6eY9Jr5A
	E1a0gy6KGwm4BZ4w+YTm/DmEjX6ZTfGZFA3EEU0LqVxZ+93mzTaSfFNZ2K2EZgOXnDrLUdxTTJq
	4CYQ==
X-Google-Smtp-Source: AGHT+IF9pLgsHpPjk3UXVkUescr3tjcIn3xcHR7GJ1XIEkeld37IXbVO6Rgdc34Tn7ZedGGic8M6Fw==
X-Received: by 2002:a5d:64cf:0:b0:3ca:5f27:46d0 with SMTP id ffacd0b85a97d-3cbb15ca4d8mr1326009f8f.4.1756215602048;
        Tue, 26 Aug 2025 06:40:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm17718210f8f.14.2025.08.26.06.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:40:01 -0700 (PDT)
Message-ID: <2b903c39-719e-47b4-a8a7-157acf421627@gmail.com>
Date: Tue, 26 Aug 2025 14:40:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Aug 2025, #10; Fri, 22)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsehivqxi.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqsehivqxi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/08/2025 01:10, Junio C Hamano wrote:
> 
> * pw/3.0-commentchar-auto-deprecation (2025-07-31) 4 commits
>   - commit: print advice when core.commentString=auto
>   - config: warn on core.commentString=auto
>   - breaking-changes: deprecate support for core.commentString=auto
>   - Merge branch 'ps/config-wo-the-repository' into pw/3.0-commentchar-auto-deprecation
> 
>   Proposes to deprecate "core.commentChar=auto" that attempts to
>   dynamically pick a suitable comment character, as it is too much
>   trouble to support for little benefit.
> 
>   Will merge to 'next'?
>   source: <cover.1753975294.git.phillip.wood@dunelm.org.uk>

I've just sent v3 with some small cleanups as 
<cover.1756215326.git.phillip.wood@dunelm.org.uk>. There was some 
discussion about the best way to warn the user when core.commentChar is 
set in a submodule. I've left that for now as I think it would be best 
to get some feedback from users before deciding if it can be improved.

Thanks

Phillip

