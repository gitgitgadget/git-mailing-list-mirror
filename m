Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668FA33F8A5
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729275; cv=none; b=WRqsDzQcp5fvfyPTSG4wC1RCNqCrOLZ2ycmjCtw+ojXEQfLX8J0L9ItTnKxGcP5uclym7udZktPmDQYV22QHICyyuXoRCIfSBuzAyc1sXQzvtvXTBk75px7RQfnunDpE9QuxAyAqDkh+4Qm2vvbwb7jsJzxtmlLq4BGvpem4gZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729275; c=relaxed/simple;
	bh=nY0icGOdGoXe7BSh+ObuUebN2DCFwzvTlY+a8o0mv6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPKzKGNJ4fLqUi1/W0xu/hB2/QF4yGKcVg7Y3hRHj+j3I7vTmVsfyuMVZISQHi1j9UBVIovxVdugeLKJMgNEf/Elk6k1rY64qznpLpZ5vLBDkC5UofTJ2MBs+zy/RbSUAm6JKJZZxgr2kcik7XLVXWRwFnHDKVFbCtfAZIA7HRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y341Jk7g; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y341Jk7g"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-88f79ae58f0so377437785a.2
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 12:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760729272; x=1761334072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nY0icGOdGoXe7BSh+ObuUebN2DCFwzvTlY+a8o0mv6o=;
        b=Y341Jk7gqmw6TBqAobRo+4PRjpvZJWXy1nORxe0AgUHBSCDEIfmT1fi3VHuKonKBZ1
         dEDAZpACrPp4euxQqibVUR88Dp4VBqqTat6wK6OFc/wVeDl7E+/dkFt/Y+pbQmk/TPl3
         fXNQBKrqZ6T6bTSrYxAAcLJwtmpwobpTIpumlBRJEkmiIL29A5+Va9Fw8ApOK2oR9vR8
         v5Q0wpLnKh2OX0lUrl3oCVVjbQ1leo+DJsm6/oyZw3x73kGRzZPrI61IQ2Z9G9Fvnm3I
         by2duTTmHpi+53NteOIDK29X//Bg+IR08x+/HC5VsMR/N8x++NcEj6d4z9J635jdo1nT
         3nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760729272; x=1761334072;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nY0icGOdGoXe7BSh+ObuUebN2DCFwzvTlY+a8o0mv6o=;
        b=ig8fnfJ6vnwIRSLK50gIXAwsSc3QqUmQsk494+N2RIty8Zzhy+1xmlAFaMnrUMX0tm
         TDgSuDLlu0F5OKb7gjUKxMBxu8pEsXVq2sjywsheKP6zUXGcpqJfE4Ng431mcS/PIutF
         YAz0z5G0BhxG2fgDqAcmBEXL6DJgLQk1fMWaOOJhs3Obm7XArgd+l0SOb8NkNNl0eLwR
         yR+VqdaCQ/D6K4CPSVZLhmMxM+GHDGS1hK8z0jKCyLKs3xn8+IujVe/eL+woMLn+9muf
         N9HMQ4GMjcA3Fui10Ug7neu90MBxIG5cQDYL3x1fttnA+a+GWmtFqe4TBls6q+gnHCBp
         mxDg==
X-Forwarded-Encrypted: i=1; AJvYcCWlbNiKmeumFPinqZa8Z+o2g8bdR3e/97Png2IvZzSJGjd6LExoJ0wHy8CZvGSteCvQDro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDQ/2F3j8OqBjyxUpXwwYbR+nIz8JyZdnErqXz7KvyBgnSmj9
	9RatyvJIABrzbVw4IVSSXmIm0g++WO2kjj7J5s2mrCZo/JClQtmZ8vKhRqhwl2mF
X-Gm-Gg: ASbGncsvyMXUJ88m3Hv+AbG0I1uad1v1aUP2cMe+AmTXJEli2PPsqHUcA+9WFDeTrj1
	Lul9UfiCMZ+1x94rkETMHicCFiM5QS6fijMit4PphZmnHdpTuiTtTL3WPStIVv5RnDU+gKpnkSR
	DNssMTkEhnPIaDg1dG5dPavuoLSTy1TzFyEf64Xv5K3ssPWQNvpRisGMR+J/qSbWAcJjHnKmJDS
	+GqlRHLsxwZpEzg9zkIv/XqVIG9SY5Wz3YP7UusEI3wwebuy3BcLl/I3FS6VetoWe9VRvlIceGa
	PxWYMRosCE8+6aTxO/ad6YasfSA/FfIt88js7MvP73T07YlaBccLpTd/7ezKHUMrKikda5WaDUF
	snFLdCNjKl9jw+pFG+difNwKX6+kJwac6vycY4EljXtA3AWLOqR4cZO2HJDTIPh15DZlaYPhYzx
	7qTKc9tqIG4m5lrzKeJbtNQA==
X-Google-Smtp-Source: AGHT+IG3thcOvt/m7pplfDX8vWX+OemGVgTrdtawc6qqS7hZxwvs+qBRaLAQfNN4KYdo8LRh8rPNOQ==
X-Received: by 2002:a05:622a:20e:b0:4b5:e8c2:78d2 with SMTP id d75a77b69052e-4e89d3a74e9mr61581201cf.62.1760729272195;
        Fri, 17 Oct 2025 12:27:52 -0700 (PDT)
Received: from ?IPV6:2600:4040:266b:6300::387? ([2600:4040:266b:6300::387])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028afad8sm3933076d6.45.2025.10.17.12.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 12:27:51 -0700 (PDT)
Message-ID: <534bfdd4-319d-4421-a650-42c65af9011c@gmail.com>
Date: Fri, 17 Oct 2025 15:27:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Revert "gitk: Only restore window size from
 ~/.gitk, not position"
To: Johannes Sixt <j6t@kdbg.org>
Cc: Michael Rappazzo <rappazzo@gmail.com>, git@vger.kernel.org
References: <20250928135435.59623-1-rappazzo@gmail.com>
 <20250928135435.59623-2-rappazzo@gmail.com>
 <be1e6cba-c94d-4c2f-ab68-e368ffe9daa5@gmail.com>
 <fd4437c2-ca62-4221-b426-f3c3dc3d2a47@kdbg.org>
From: Mark Levedahl <mlevedahl@gmail.com>
Content-Language: en-US
In-Reply-To: <fd4437c2-ca62-4221-b426-f3c3dc3d2a47@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/25 12:36 PM, Johannes Sixt wrote:
> Thank you for the hint. I found the thread, and after reading it I
> notice that the opposition is based on that restoring the position
> doesn't put the window on the desired monitor. I can't test this right
> now. I've rewritten the commit message as follows. Whether or not the
> position should be restored seems to be a personal preference, and the
> patch applies my and your preference, but obviously not everyone's.
> Please let me know whether I understood the situation correctly or not.
>
> -- Hannes
>
Your commit message accurately captures the issues as I understand them. I also cannot
contribute on the multi-monitor setup, nor about the broader context wanting this patch.

Mark
