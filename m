Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF033993
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317846; cv=none; b=BZD87AVG02vR1dOqy/18RTsDYHuEeMEZLbNop+msq35gThJHOlL+ubeurYS3p/Rb7VL9HDxEe2WTwh81wsDFKY+sWM1J4saBTUqPD+IucOjeT8mA9j4sLHBLvYZNAWW5+A8RdEMmR6Kl4qxw6Ac3rMAyLmcVvldYbigtEbSglpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317846; c=relaxed/simple;
	bh=F8EMPs+753RAc6ttNLGxpp3iHVZB8JAVFmton0EMkLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7/xdXJ++dms0Rf4FAviRA2Rc+ce2Z7gdTFWxXgGDdhi41CNQ73y1sEd0UnhhsJ431PLgTLUIxyMb00crTyhQfKy12kC5LCh1EpRe9WV8sUwLdB5f4bFfy+UhrDGi5lVELqa3GZoCPcFuoDO+dWBndWSMcGloG4/9991DUqq1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=ZR1qtd0p; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ZR1qtd0p"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34356f794a5so1749197f8f.1
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 04:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1712317843; x=1712922643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUGeDtHiZ0mdpEt3P/G931QAClnDoaxOYfdNg9scskY=;
        b=ZR1qtd0poocO7PA7RO3d9zLEGOSV2KR0QIe4jeuX5TOzC8R7MOnXdJyJq+/IoXCxjE
         WkBYWFaR8TlgbDllik8d0ik8h2QYkaHDTjetAgdg9625ljt5kbIDSN2wvkvcPgp9aE3s
         gJC355EwAr3br9qbS6+A4j+FdaObQQH5vN5AEqaOKpBFTtUfPbNCko0Z/kGpvD0Oyilv
         hitcV6QPSuMftsrwIy/jNQzINANXaVax4d3ZB+5oq/LIkvInaGM+4NgAizYDuagmU0mR
         90AvPxmiNeLc+eCZ87IYlu6QOEqJk2GVm9POXZ09n6g/P8/aHHecAONaPZ4AdeJSR31i
         KxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712317843; x=1712922643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUGeDtHiZ0mdpEt3P/G931QAClnDoaxOYfdNg9scskY=;
        b=SS1f6lJaWAsaB/Vkr/QIt6a/Y7nzv0+T5u4uno5QII7V6Ss2vVLEZxae53Kfh5mgFg
         GNVSZo+iF19ED0wUpuASqhem40sipXoq89gDdKpvnLe0Quf11f2ZgzG43sB1VyRTZxK4
         3h7fygmRiq7o6HlEZMrSoeP0OXjdOXOS0+AQJ1TAhTEbwAkBRL8Wuolpu8wCY86Beu72
         M3t/EsKkXtLcQrKkGoOfE8feOdYcSGqt2BYY3oi6qHQcRar5iH4Qvhgkku7Br+f+ChRz
         kx2DnjVrn6bkva7qtfVC9IHTBfzodA/FDvDM5tigHzveI2NN2gAl1+zmkFVooHRIS232
         CjLg==
X-Gm-Message-State: AOJu0Yzm93Bvp59sglqnVotOsXB/6TVqqs1wbCE6D9RDcQaOn2JSVXnl
	N4L9eu00tjKdbn/W7bOgm/PZe0Yu4gMKobrLi7MX7V+NzROnBmG9dxtOLR9p0sM=
X-Google-Smtp-Source: AGHT+IF66ySEWHU7j6wI8Mg+cVo/Mcv5ReibtAIrxfItJyNSM06sKn2ZId85LQEy7z8E+c+rVWqOuw==
X-Received: by 2002:a5d:608a:0:b0:341:e367:e7bf with SMTP id w10-20020a5d608a000000b00341e367e7bfmr1166844wrt.69.1712317842657;
        Fri, 05 Apr 2024 04:50:42 -0700 (PDT)
Received: from ?IPV6:2a02:168:f656:0:3ff1:2631:ae27:b706? ([2a02:168:f656:0:3ff1:2631:ae27:b706])
        by smtp.gmail.com with ESMTPSA id t20-20020a0560001a5400b003434c6d9916sm1833050wry.110.2024.04.05.04.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 04:50:42 -0700 (PDT)
Message-ID: <6e40f19c-21c3-4a7b-876f-b8161a85e603@isovalent.com>
Date: Fri, 5 Apr 2024 13:50:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sequencer: honor signoff opt in run_git_commit
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
 David Bimmler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1707.git.1712223572933.gitgitgadget@gmail.com>
 <xmqqzfu914jc.fsf@gitster.g> <a80a5aa9-34f4-4bfe-9e32-7b5e878554ba@gmail.com>
Content-Language: en-US
From: David Bimmler <david.bimmler@isovalent.com>
In-Reply-To: <a80a5aa9-34f4-4bfe-9e32-7b5e878554ba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.24 21:21, Phillip Wood wrote:

> I think it is more complicated than that. We do not use the "--signoff" 
> option of "git commit" because we do not want to append the 
> "Signed-off-by:" trailer when processing "fixup" and "squash" commands. 
> The trailer is appended to the commit message by the sequencer in 
> do_pick_commits(). The problem is that when we commit a conflict 
> resolution we end up using the original commit message rather than the 
> file containing the commit message that we would have used if we had not 
> stopped for conflicts. I've got some patches which need their commit 
> messages cleaning up at 
> https://github.com/phillipwood/git/commits/wip/fix-rebase-signoff-with-conflicts/ which use the correct file when committing conflict resolutions. I'll try and clean them up next week.

Took a look at that series, I agree that they fix the issue too. I 
wasn't aware of the intended behaviour for signoffs in squash and fixup, 
I'll thus not pursue this patch further.

Thanks for the context and review,
David

