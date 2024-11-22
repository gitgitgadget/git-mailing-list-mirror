Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852681632C8
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732301873; cv=none; b=qP2Nj+bVhmZcTeG1eqfnl8SxHaqHoScT/oU1UPn8+cjiehTRwygwXF/2iP1zDuTxOO0+uA/L4ve7U4v3MvVuZlpgqBlJ26UvvH5ReEsaxPgOQXZV1mTnXF3D/VrZgodR9WOUsspD3Zt17jWO18HpY4w98w4P/lgoZBQRZlfNzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732301873; c=relaxed/simple;
	bh=P7DOS6E4WFViW1FEcvlWQ8UWvgc1eLveUlvey2f/N5s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=owFsFi5RjotAr/jO9qVgXygNA7dVLpmspS24BdkHzT2EJAoFBlKiOAAy5iqN4jB5oHvtGFdx+u0X2MElFZUEWYy9RikLMPFtGaACqlYYYtFfUwMptAwPp/aQq9PJxHPBA1yuj0HN0LQSqnZM1TtFLNROtJ9yDm2brJaWd4khR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcoAQWvZ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcoAQWvZ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1b224f6c6so161403685a.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732301870; x=1732906670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2jro9IgA+5JiCzpnekkf5eXMsRd8kFUTUUqvydqcHY=;
        b=CcoAQWvZY2/N9L44TiBPXQbp8eoAxGYwHOxQcAtgfIsOem1qdcydRoMvF995XVsmZJ
         ZJo4aB5hbamjstXhV/GDOqE6fFikfgLC0xA888GyJUUvUBxMepSIu+uAA2DDabG4Q17V
         t9KQh7sLGvym1yH6wnFVcOCvjsQNq5ERP5MJL1y01ybFOhZW0skp4f09AkF+dcab0mzQ
         oXqi1k3woOmZpHUUYniUgxeXy1lhspGQ4ba8zGZi9+76j1jWOW3UQlzFn1pc4g4ix1lS
         /c5u7TAw6y65xnr3Mo07Lf26WxRiz0VRDDyD0Ce80rHJIVRKlqO2huQs+FNjMAdvVPjb
         gcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732301870; x=1732906670;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2jro9IgA+5JiCzpnekkf5eXMsRd8kFUTUUqvydqcHY=;
        b=MX5UqdSAx4c3/7zC9hWAKzvbdRdaM+ggmkjMgB6ZJVaAdSAfYZ32YJtXbdgSe7aEc0
         fgIxdXkipsEvF71aQOSstA70SnjAOK95Xi1R4zXaipnA/KIz06vM1tapPOTEoTWCTDvG
         Hg2pHikfrDqYKovNhf9w8atsyehNmazEId0ese4E+IjS3tEk+dS0szAuwj2XXjWT+eOG
         sBUPQwCmSWN/beWRbHbhgNhNPmFFOBCtHREyd47y6uhQC2w+KCnflzNEp+RtYQ/YJIqx
         oO5QNgGnYFWcdclZFAsKvlcz2kIU1G270C/VWeWys7gWlL4diVrAwfTmLh+JIGDhYdVx
         Kgug==
X-Gm-Message-State: AOJu0YyNgE9FKcB4UJJdZPiuSYMwX2OeHIh5fst9NsaqdyLa90HqJc9L
	UFu1FbSt4pdGHlZMvPOxLvRXEtYtOttlTtoWjC1+tpppNmRfpSqW
X-Gm-Gg: ASbGncu+XXZVXY3at/aPbsjHB+LvcUmwc2a/c9rZmiB0md+LKBfcpH6kW5WilrjoOPu
	KziG21cyWOtB6wj5S81SYpVSVmgefRurB1OHuqFSPdsz6WVsuil76vVqS2tIqW+QwdRSeaJbkBK
	KylUhX643daulIQrVjt7UdLcp/OhmmX++7+aSFocG4RUloIE7FuCyVqQTXMwIxrsJbzILrjOeKD
	nO5cOjD/y6wykQdi/nyLVPZOiJz6h2+F/vMswHIFRctGsT6D3xvmBgmOxi33TxXg0bVsR5P/TTW
	jV26zbdy1VMY0c5Gk2rqXtrk1YD2tbzNHHU2dlE56T1l3AACoQ==
X-Google-Smtp-Source: AGHT+IGkjtkczJJX5kFCyY6oda5z8JOM+omNJ1MGw3EuAJBHMRam2oLgwKOgD7ckXBBAB+0yWAMAKg==
X-Received: by 2002:a05:620a:17a9:b0:7a9:c129:5da7 with SMTP id af79cd13be357-7b5144f4c37mr478845485a.29.1732301870215;
        Fri, 22 Nov 2024 10:57:50 -0800 (PST)
Received: from ?IPv6:2606:6d00:15:40f8:689a:b10f:19f5:4246? ([2606:6d00:15:40f8:689a:b10f:19f5:4246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513fc4153sm113435885a.66.2024.11.22.10.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 10:57:49 -0800 (PST)
Subject: Re: [PATCH 2/5] git-mergetool--lib.sh: use TOOL_MODE when erroring
 about unknown tool
To: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Seth House <seth@eseth.com>,
 David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
 <6f7f553b283078ba3c81190686b150a87d901240.1731459128.git.gitgitgadget@gmail.com>
 <xmqq34jv3ou2.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c6d95106-e2d9-37d7-211c-b23199ceb258@gmail.com>
Date: Fri, 22 Nov 2024 13:57:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqq34jv3ou2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio (sorry for a late response),

Le 2024-11-12 à 20:27, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> In git-mergetool--lib.sh::get_merge_tool_path, we check if the chosen
>> tool is valid via valid_tool and exit with an error message if not. This
>> error message mentions "Unknown merge tool", even if the command the
>> user tried was 'git difftool --tool=unknown'. Use the global 'TOOL_MODE'
>> variable for a more correct error message.
> 
> Makes sense.  Is this something we can easily test to catch future
> regression, or is it too trivial to matter?
> 
> I wouldn't mind if the answer were "the latter" ;-)

With the changes in the next commit of the series, this particular error
becomes hard to trigger, as setup_user_tool will return with an error
before the error message change in this patch is reached. So I would way
it is not worth to add a test for this particular code path since it seems like
it becomes unreachable in the next commit (but I could be wrong). So mostly
"the latter" is my answer.

Thanks,
Philippe.
