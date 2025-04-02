Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E94A1E531
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743599373; cv=none; b=r5s4mb4VpUwyUg/C8kjy+FefGI7kTcZWJLQXTxtjY+/XkY9/AR0k/kQ56gOMnvoTg81vLCuPmAuAEjUyZRUEW6MCTkZsPUz7bEtpiXndOcOtoArhhva0QKEjSBl6nPVrXExSy6Z8y/qQ6fVsUwI8OJ5EFxvBpFaSdtw6h8t+1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743599373; c=relaxed/simple;
	bh=W+/P7Izpbxn9+BqkLY+h/fTIQOAhM4wmaFer8bqLfZA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DyzESUNU+ZJHXZN3S+m9+Q8CV8NeTmJsmJuOLTM23vRf0D/1JxIsYSZGVsTArm+cOH/79EV6XUorYP1R8w0DybJxQlDPL9sJdIfPUIt1vqGHF7Tpkm5a0Q65i6DMYwRnOh9B8QqAMgcVxYCmB7nuK+oOKtKRPpJyCgjCRPETpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpTZnep/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpTZnep/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso523655f8f.1
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743599369; x=1744204169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSFvS7zDwAfqKi1aIqwkZhLUtOv3hBLyoTStMO4uvGE=;
        b=bpTZnep/+41cvLVjWm+pLzI3+aT1qFwCvE67gxOz8VYS0oP4jvl1ocyCPerHMdIFwL
         +ivSBPMSnep8aIh61FNTyik0mQvnB4wPKYCtow4UWp/exJAOlLk0M2MZoKiD9mlu3xEX
         tnbl8En5WJ/XCqs8NxCI53+sKAfJl45mgGp9Z83x9Qg3RnDuyOmyYuHMVdaUH9kZBaaS
         TSO/VFCBhvT9MXkRrhTuO2nrRABzSD1jX6nBiuzYXu9WfiKxw/KhtLh3kvrM5lJhi22B
         8fbvpzleMUZ1qGsXsyPE9ybthOumYseVmndSg9tdM+zpyYNiaE3wrv5AXL79ln4OQKnH
         Fm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743599369; x=1744204169;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSFvS7zDwAfqKi1aIqwkZhLUtOv3hBLyoTStMO4uvGE=;
        b=mdCCuBiV28mRii8kFWIw5I8RVK0U10eTCekJodnUULqh1l6TIQFRHOjUY51XXDYxni
         GusQ0ErYScyDi/3H3eIjea1Dkdw3VhNrTdE30EOuvNQy84mgSjSALwveMjEyydw2uwf2
         Y0eHaQLjsfAvR6tiiB5Tk4a0eJV31zYVruN7F7+7K3cOXGdT6PR0zmW6OvvVlAkXCVMr
         fnDC77vxwK8ddRq0KDJxuM0oTO5sxilsp3UvIPBxqm0gCivI5yuZdK11IzF5/cxl6+U2
         yTdcvhiSSZji2iVqLClDrH6e5Keni3sbHIfDjgpGbhI+tc9eQTORi9V5ELkIMhkPyDf4
         esJQ==
X-Gm-Message-State: AOJu0YwfyzdXLlE+MGORfadXeHDre4hhRcINzUF8a1F/dXdWraMIZjHr
	bvwyZeMMIDo4S4j1F+a98/m6CdAPp625gqOl88ALCfwtyk2dpGs3
X-Gm-Gg: ASbGnct6aEr0EXzqcg/kq6G/CRcHr0b8lDlFYZOq0Ky/phwMX8pDDVW0CNp+YnDcuB0
	m0WGF+04BWMVGeT32EUCrv2RrfjV1r/OELWVjo1XUOSU5JVqIs+u1WfGZIw2BuL70pIHQImp8qu
	1da/iCQG02fRSizROrI9mzAqy45B4BVsPcDEluH1U9zIzPghsxdGMr37ZvICB3y+eFK9GH0eMBw
	x7/fiBSV29sfA/2wFuGnfN/52V0T9qNQQY3rfJatAD8JrPknF6kXDJgmbnLK+pzxzWumGkFP1wi
	7dGVL4ec9xzi7vzJiMOVZ0LTEySWHX/hcx4ggI9VgWnG/1HdmS0pQdjZ5m/LQxZWJFEt8kA5KLT
	EAmwQzYZWFrvGMULFP+LF
X-Google-Smtp-Source: AGHT+IGvCq7+yS5CnRB2REtcoX7k7aEoYGgoZ45Nez/bPllrPagJM0nZoszqABPRoS8iwXEX2NU7kQ==
X-Received: by 2002:a05:6000:250c:b0:391:bc8:564a with SMTP id ffacd0b85a97d-39c2a387086mr2158050f8f.22.1743599368551;
        Wed, 02 Apr 2025 06:09:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb619062fsm20841515e9.28.2025.04.02.06.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 06:09:28 -0700 (PDT)
Message-ID: <a81dbb21-b50b-4358-b2d4-7f804b66bcbc@gmail.com>
Date: Wed, 2 Apr 2025 14:09:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] wt-status: suggest 'git rebase --continue' to
 conclude 'merge' instruction
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
 <db01acdd062a17b1cca62428eba8c3ed62ca7c6a.1743181401.git.gitgitgadget@gmail.com>
 <0bd7e0c1-fe73-9e16-0737-d6b175a60dd3@gmx.de>
Content-Language: en-US
In-Reply-To: <0bd7e0c1-fe73-9e16-0737-d6b175a60dd3@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 01/04/2025 17:22, Johannes Schindelin wrote:
> Hi Philippe,
> 
> On Fri, 28 Mar 2025, Philippe Blain via GitGitGadget wrote:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Since 982288e9bd (status: rebase and merge can be in progress at the
>> same time, 2018-11-12), when a merge is in progress as part of a 'git
>> rebase -r' operation, 'wt_longstatus_print_state' shows information
>> about the in-progress rebase (via show_rebase_information), and then
>> calls 'show_merge_in_progress' to help the user conclude the merge. This
>> function suggests using 'git commit' to do so, but this throws away the
>> authorship information from the original merge, which is not ideal.
> 
> It is unfortunate that we cannot fix this, as `git commit` with an
> interrupted `pick` _would_ retain authorship, right?

Unfortunately not. Running "git commit" rather than "git rebase 
--continue" to commit a conflict resolution when rebasing always loses 
the authorship.

Best Wishes

Phillip

  (Why is that so? Can
> we really not use the same trick with `merge`s?)
> 
> Ciao,
> Johannes

