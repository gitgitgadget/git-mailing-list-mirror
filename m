Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E253932C0
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113435; cv=none; b=JKXwL7RXWy9/UuqKw2gCQGa7WVOU/0EESaS1Wg9I+7Rvqg0KnxykKE3AVASs+/67lKK9hmtbnnujsxQo3jjJZwWA5h2nmMbOYPrKNJg0EQIFiDBSJY+1WsunNvAkDyOXFuzOQNdN/WVDS0ykLEPy0WbkVKmmFiynnk8gZlg2w9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113435; c=relaxed/simple;
	bh=vUUdPYgSYPTGEw6Xcwz3tTh723nGR+qY87fwlR1Z8pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYV2dFlX+oEOwYe8TFFrX8kgZ/l53DC01tdGSEXFi/UT+ctHMFguOhwqh8kaGKFE3QNUwcFlPKcsTcCXu/hPtvkdVrYF3a2fiVLmZdisqtUYybWEDIiSku+QdTfF+2qhfIX1BPPY/BwVwXy7PLj62pTQ+Lr9KvslOWfYUC/vPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDdBBbyA; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDdBBbyA"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso14851556d6.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113431; x=1786718231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jR1p6aHJtwBibaz4WQe0Qzs2z7uFIE0YXcxDuONx9U=;
        b=RDdBBbyAY6XICLjuGP36ihANY7fGDOYTeEg6GleFw0bDjl60kF6FIvAz5SZpmR8qSS
         1Z3/Dj1zC3BOjAkPrnH7rbT6c/uo9W4fSa16ghxZliyt9QrLz1aA+UCMw4eQ4HP5+X4P
         Jop67xeTo1TbeRlxHserLAw5cbavwhpPpFOXVT5zy6ssh25JxnsdmyezUuOfurMmBScC
         dNVPvf1EjBokWAFgNJqPYjPMzm2YHUa+rYtiUA0t2lmwbPvK2xg/kdOWo1GO9gtbFfRR
         s2miEygwYo6YjMlBYBEJtLvuRydue5ELd+vbCznNAupkPG/X0RzAMERKxCa05Trq3v+l
         xibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113431; x=1786718231;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9jR1p6aHJtwBibaz4WQe0Qzs2z7uFIE0YXcxDuONx9U=;
        b=snYKElRCTHqNVrv2s9wLzMIvbE2rk6M8sGxqWZ5ONSmObkAqkscqdqEdyReXNJaKSC
         jZFUxZtWkTNLeUY2fF1QvmllEsM9JW7qcHmeoe/MYQSCQjG9GYkYjd0FgweiZpKbes7w
         Ddn9VSvpkIRl2H2K2sITOkNlEVz68FD12t/Vee/3Oa8N5ss3Mpi4ghYHFFBURSNM7KyH
         np/NowmANlZMmnh1hBwoGJYX4Tzx4sj9/xkMDUQySiJTiWOTvexgF0H4g5QeXYrR85/K
         lsNXNPj7/S5fYUNIf2ou80wUDRz4magk/2YE7YVbjiAlH1s409SqOBeSxWFZhVp61Gja
         TrOw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4VpjtpEjt9HpkUksZHwpSjKOkV+RQ3NxYLhBdygt967Sh0irkxQ723MGHnSDlrmit2NM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4RSDJCHtwFmcwzYWxcBBL/rZBVtns9T5C8GDPi6Z8lpL/GDUW
	8LcwmWthUITWEX030ekMXQJixT1aVBPTaDrNvyNnsQlg6eS39zLJ/F9x
X-Gm-Gg: AR+sD1196ijQQGmCX2tM4FwfafGF/rb3EmsX+p8OeiYIK3HMsxjiMLB6vrxCVX28JFW
	/BgKGmkCdELY7ty+5LbcUAnDleWFTlZOsZf/3zzNsnov7awFDZrC1Ks0xRN7fJQG0Pvv77IPmHc
	64YYCsW2Kby2s7sd8Kx+dFOlCkuuJr5cZm59+aY+EhpTg1qsmjpOYRE34MxpQjgYUfjvbBl5TVb
	fGJrm1TFTSZSmcWozhRABWu8nm6WiLh/31YtRVhVHP/jMuo0P4F8tlDfrxqG7zP9cpv1dRgbXH3
	sI0f4IUGIkLmi62mkj52fJa4NutsfYxpJidgSpzAhuLJobBug6a98XGULIpdNMs3nvWh/rxgF8I
	yKAWY77XoRr6/diIzON/s4CmDqzJX77wg9CunbA3303knIhzfWS8fToBL7i0wky3qrMxyl+Uewo
	xq+UUfUczBFbQL8mTwnAHt9MUIt91nCDQX/v3Siupqvd98La/dB/uFWRB4DOznApOjhwJKC24Lq
	7uDP5oZLZzZDAgR8Llfzep3CldjFH6Y7OJhfVSG95Jiu+q5clVYm0MnMi4=
X-Received: by 2002:a05:6214:2309:b0:908:488b:14f with SMTP id 6a1803df08f44-9088f8d4a42mr170153976d6.5.1786113431363;
        Fri, 07 Aug 2026 07:37:11 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a91b5a26sm10078666d6.12.2026.08.07.07.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 07:37:10 -0700 (PDT)
Message-ID: <a2e12e20-ad46-4521-9d45-5b74730361f1@gmail.com>
Date: Fri, 7 Aug 2026 10:37:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] gitk: condense repetitive code around color buttons
 into foreach loops
To: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <edb567608e1bda16efbdb8d4ec359318cf105284.1785998419.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: mark <mlevedahl@gmail.com>
In-Reply-To: <edb567608e1bda16efbdb8d4ec359318cf105284.1785998419.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 2:40 AM, Johannes Sixt via GitGitGadget wrote:
> From: Johannes Sixt <j6t@kdbg.org>
> 
> The color selection elements in the Preferences dialog are set up in a
> very uniform manner. The code doing that has grown in the past by simply
> modifying a copy of a paragraph. Extract the varying parts into a list
> and then operate the repeating parts in a foreach loop. This helps a
> later change where we want to set up the UI elements in a different way.
> 
> Change the UI names "markbgsep" and "selbgsep" to drop the "sep", which
> has obviously been left over by accident when "hunksep" was copied.
> 
> Change the suffix "but" to "btn", which resonates a bit better when
> reading the code.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  gitk-git/gitk | 114 ++++++++++++++++++++++++--------------------------
>  1 file changed, 55 insertions(+), 59 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index f5eb963b86..137940defb 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -11832,55 +11832,46 @@ proc prefspage_colors {notebook} {


> -
> -    label $page.linkfg -padx 40 -relief sunk
> -    ttk::button $page.linkfgbut -text [mc "Link"] \
> -        -command [list choosecolor linkfgcolor {} $page [mc "link"]]
> -    grid x $page.linkfgbut $page.linkfg -sticky w
> +
> +    set coloruielems [list \
> +        bg          bgcolor {} \
> +                    [mc "Background"] \
> +                    [mc "background"] \
> +        fg          fgcolor {} \
> +                    [mc "Foreground"] \
> +                    [mc "foreground"] \
The list is computed and used each time a dialog box is started from all static elements,
no real change. But this cleanly separates the per item data from the boiler plate,
definitely more readable. Good.
