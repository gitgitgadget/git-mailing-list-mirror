Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE9F26D4E5
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315401; cv=none; b=flPrOIa9eAmIGCfRDVJx9E5G9QHV8Zq5tfoENzBLVyjTpQXHtLkZf4+6ObSMdpKE7WD49dJpfHPyZmug7NykMMdgMyCSKl5humSRuDvwtfPxGa95s7+MFOhYOkf5TOkDgE5V3B/jhD6Es80vxH5aUiaSszjkot+e6w6I9lPWel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315401; c=relaxed/simple;
	bh=KgQqDh7R9DrDtSXXRo6e7AQX6FpdP+EKiD27ecdCW0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4C943xN+DLkFZJ9dvI4D9Ooyf43JrrrZp8ZpfGS267jZetsDKxt5cUvEFVhIy6yc0Efv0Rd4OgZWBE8MSVQWZ13qC+k2kCLe0q31D4m+bkFpUTY9tOylFR0yVMVlOskoDla6WaGIOvk1ssP8E+UzGirOh2fIE4Bp13iO7xfsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qy/oNMO+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy/oNMO+"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso3039730f8f.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754315398; x=1754920198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss1AfKzNofCyjZI+b1/eVTeWRZ4HBRJwIQUiP0LzYf8=;
        b=Qy/oNMO+ZRRMOsuiEeoNjpAJ9s5Z+xNfcLaGF/+oMDKUkqE+7k4roFnoz0N0PJc7Jb
         eTk6vQQULpRnbYQF/CowByngl36IdFKwS3naGo6fVcReDH410cBHspGEiHoJLtSQjy6S
         KBuMvb+QIg6PrBvnIS0jdQgELS1hrMVfDfmS61eD1eEQoevY4aMGOIRcjARCkXOMGSc0
         BGwXUgmo4Kf725Cni1KwgC0/AomEJ8GHKrk/dsXAK4I0FDGiv0eqCB/dbwjdcbF3SoO4
         ny+A02uMlkQr0wCPFG3ISdiOalr5XuX7sTI+sb9CF/U5/NB6V5BpzSYd/KFK83Lm/64J
         Cz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754315398; x=1754920198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ss1AfKzNofCyjZI+b1/eVTeWRZ4HBRJwIQUiP0LzYf8=;
        b=YE040sqLdg/qIYosH6ZbGsxbU2V0HfLgQbLF6gHlec4MPXVCHw/loi8NgbtCajtmSL
         X1+d5/Pze0kLQdplhbLiTujRDcn9xwDSUmGgIjKP0BTj9yX5stO8JFjEoWums9rWxUPJ
         3sOwoJxuPYvIdJocXXsn+PFLPUhGxvLtuO/N5rhm5J2BeGFpQiNEi3Xtp8iKAuLMs9TH
         Wi276ANFr6E3RalI3SDmRjT4nWqMKd0mKmt4hYs1PLOzfO9RCZ3uRFz9aKzkMcbuQPOB
         ND5zE97zxD+SEN6zUCEhSeq2ta5Kgr+ibv/Q5+00ajE1DbVPeFuhhHs8m5ZDnnkgUPzU
         kAow==
X-Gm-Message-State: AOJu0YybdDgeOgaLMiTmQUrr+FicNeT8mTO734D82bGQjzAAdghBql7B
	8SpqBlSvRCurLuTxr9Nw5c1cLNTMMCuXyURmDNpL4m/DNS4i1KZBvNAs
X-Gm-Gg: ASbGncvQTj48+JjuUmZ8raqA23+kkVmbBnZrHzjFcF4QB01Pn2wsTe5bWQNzY/ki8pb
	WoaI6lzNLUr52n7E3wNVUcW1fp81uVsHJxEQexP38eZXEffXV2iwcc3SZJR/Xm2yuKFCTDibux2
	v0E2IJXeuSXBWcYb0evKBvpMGrM3bTw9R+V4Ga/dn/mvxj2Cs+kZ7LsO0me9qxmZsWQ29APe59d
	STfWJ3p/SmFLYEd39zMVShb4X8BXHlZbY0Psm5vwClL7TGuh8XpZZOTIcdYBTOOSzf2h9u6723A
	DDY2Wkcqf4p5xCZ9l7xW3e7TPxvZoCrTTerLza3MzylWOxojQk4Z9cmoAITL6hjAyTV09ME8Wak
	2UjiNQ5ebqPsVdAVPvk7GKEkEsb7Xj2Q70QhEKGWF+FjfRhk70/Fs6KDZZ6vJL7P2TsgwdWGngG
	wABaSeBzj31bU=
X-Google-Smtp-Source: AGHT+IGDKeO1RTIKM+999HDTipSYOtz0MoMWJ/42acsi+lB6WEb0W6TtNwIYMXw+RTFiWL8+Jk9wyg==
X-Received: by 2002:a05:6000:2c0b:b0:3b7:9703:d98b with SMTP id ffacd0b85a97d-3b8d95aaff0mr6379313f8f.28.1754315397456;
        Mon, 04 Aug 2025 06:49:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a6ff7sm15888297f8f.75.2025.08.04.06.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:49:57 -0700 (PDT)
Message-ID: <d62a30f6-af30-489b-ab55-4c01ed3f60c9@gmail.com>
Date: Mon, 4 Aug 2025 14:49:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] status: add --json output format to git status
To: Junio C Hamano <gitster@pobox.com>,
 Tach via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Tach <tacherasasi@gmail.com>
References: <pull.1937.git.1753856826464.gitgitgadget@gmail.com>
 <xmqqo6t1n2sm.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqo6t1n2sm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2025 15:58, Junio C Hamano wrote:
> "Tach via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This provides a robust alternative to parsing traditional output
>> formats, making it easier to build reliable tools and automation
>> around Git status information.
> 
> The writer is obviously biased ;-) but I find this a bit hand-wavy
> and unconvincing.

I agree this isn't a very convincing reason. To me a more convincing 
reason is that virtually every scripting language comes with a way to 
parse json and base64 so if we emit json with path and ref names encoded 
as base64 there is no need for script authors to write a parser to parse 
our porcelain output. To me the fact that we have to encode names using 
base64 is a sign that json is not particularly well suited to the task 
but it is widely supported format.

Thanks

Phillip

