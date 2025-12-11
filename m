Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD302686A0
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765468584; cv=none; b=LQqmF29MCBkPrLbUKhDZqcIpcF+P7L7pjyXLLRGH04W2yveOFc18AMu6LPdO0xdvFLPDfV6cIEt+Xxrh+rD3/s37R2Wggv1Jq/JrEl2S3I2qqW9y2JxvAMKPNJnOhWwiY35zXLSuPi9BnDqhwj8DdXjVmwzEdmXIppbrVVZDbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765468584; c=relaxed/simple;
	bh=rsd2meHtVkjH+WV88SpvTPP/e815EpgkTeHOzh/Nk00=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KYW8nWvja9P4OeJmen81Fb2apOVuNQ8a/zKM46XqiHFVr9Tlyauh445M2i/lbccY8Vd3ZTCHsROkXT8SGW9sj39sKCCh/jQv+9c2dyJCDGz30sYMASt4PhYAnfRtXOP0fZJHEE26X2niG50IiH6dZIPgFohRlkBRTKHWdoXUH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWy9+Veo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWy9+Veo"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42e2e167067so140327f8f.2
        for <git@vger.kernel.org>; Thu, 11 Dec 2025 07:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765468581; x=1766073381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QToZ3ysVtlzbBAh6bKrD9UMw2D7AuvNL2cRclAFWdt0=;
        b=EWy9+Veoxnmi/1QYmmZKT2OVlyv/rq1QCoO4x2dBZm5xAlh7BgrwgGxI7tKAsy2IRg
         B+1dB70G+oADMC4FRlRyULBOxYkVdxhMnW2MUxPpws8hy7GfFS1YAehP5QLJdt2sGVnZ
         YGU5E9sg07r+yapfaSyqJVhe9Y6jHivz8ZEcfu5pgdwwCppbARv8T3Gnb3tknZLl9NwN
         cp1Mom7LJBaad1+KUjgQIVBycth/Se2A4ZdlBeNCo6CC1ypgtV4kr1Npir7ONygHvmKk
         uFdIt0wY/JHwqejjcbGLTsx9FUzo9MjRWFk6FN2B5W51u5b7TyC+BXcd4pQl2631/qFm
         DEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765468581; x=1766073381;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QToZ3ysVtlzbBAh6bKrD9UMw2D7AuvNL2cRclAFWdt0=;
        b=ewf2JrppRLg55EZnFoaClm7XdNKrZuVtHezzTP5/M7yQ8RMqhJBER6iOBnJCeXVtCO
         YjjyDEZ38mj1eG+Nnf2/1aV/6OQiiH9elVmhT+ErCt86DA2/pMt+jxAv3Z9RYvmwEoEv
         uDor31kOiQ48jU5aQWbmAmoBIAMq1TbLKUOs5bb2U0EDIEiz+EIxiZKsbdAl8xAL+5JU
         lxtntkNR0Nb1AF6Nl8CMhJt1j1d4de+x/rFvEBEc1y35P3sjuqyBx13Aw899chdM81Qv
         elm5bMD5A+i5O2t6v+L9K7ZWj9GASk16sDSsjEJzA6t/NG9/V+98C57RzgDDdoAXjAB3
         llAg==
X-Forwarded-Encrypted: i=1; AJvYcCUIoE3fftvIEh0P7+0pQkyq+ewy7cZIKmwsDVpr08kHwEe4fgplq4KU660ERUxVOsDFY0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMu6oTtIwGpVCKq3QqjVWHrZGbIvTH5JkXZhAk/4cQ6r1EVuWt
	iJQ638cmvFs/NRlNXu+R2aHyNaLSAweXuHGCW289pjEiW3F9szW7PYPc
X-Gm-Gg: AY/fxX6DMZVNU+RvmimXZsmCTFB1Tculxcj1X7HrmQy+vZvgdDhafPppl30rg0Bhkir
	IvRXVbWIthudIFzsKsEVJhPuLa7Gpj8O5L/ASmX7G4sKvY3NHo10ggpr6IH5eblUj5cfO/bw8zr
	4k69kA9fb8cKFNicNenQUD6NGLZgkbPBFOdmD2vwxB73KUc3a+WBtAWIt6IBQOC3y+sCetD61qR
	PETvlS7XiHJLtF1+rQ9acEEsx83ScjTAFqaQMzxWIjAUI3ouYxE6b2dTU/hnmnwfulLUafw3e7U
	wF0uRqDltFTGbqtuLC62zy8YD8WdsQz3NG9aXvkN/fwZtEfXLvXszDfnIEkYLRGypb8a5tpchF0
	4ckmgFuiUPi/a1jALTaRQWvM/VDpX5msC5xUzQ0ZxcJvIlRl+oZv9pURvh0K8AE5HaeG9A/mQxo
	ykpE9RBPK4gVcQikmUb7UVl8BGHuCoFdNIn6FLyCucgx6R8/2J5nGqN39Cd4cwZmNVfA==
X-Google-Smtp-Source: AGHT+IGOePONw90jYcoeeghK7MIdnKx+0DrM1/UhOlH0u57KhzL/jwfZ8GJhdO/0peuzA+0Skb3iwA==
X-Received: by 2002:a05:6000:1c6:b0:42f:a990:96c0 with SMTP id ffacd0b85a97d-42fa99097e4mr3162795f8f.29.1765468581081;
        Thu, 11 Dec 2025 07:56:21 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b85ff5sm7076616f8f.24.2025.12.11.07.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 07:56:20 -0800 (PST)
Message-ID: <177a25f0-7292-4ee7-8a02-9c90a5979313@gmail.com>
Date: Thu, 11 Dec 2025 15:56:17 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
To: Junio C Hamano <gitster@pobox.com>
Cc: Kartik Agaram <ak@akkartik.com>, git@vger.kernel.org
References: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
 <04cc0cc0-155e-422e-b723-b1115c918087@gmail.com> <xmqqa4zsliim.fsf@gitster.g>
 <61f61218-1945-4efe-961a-e6cb4ac8c6a9@gmail.com> <xmqqpl8lg0u3.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpl8lg0u3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2025 03:21, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> "git pull" already runs "git merge-base --fork-point" before it runs
>> "git fetch". The problematic reflog entry comes from a previous push
>> which pushes to a different server due to remote.<remote>.pushurl.
> 
> Ah, of course.  fork-point heuristics with a repository you yourself
> push into would not make all that sense, since you are in control
> when and what to push there in the first place :/.
> 
>> Because we've just successfully pushed the local branch the fork point
>> calculation thinks the remote tracking branch matches the local branch
>> and so excludes all the local commits when we rebase but we didn't push
>> it to the same server that we're fetching from. I wonder if we should
>> disable the fork point calculation when there is a pushurl set.
> 
> Tempting thought.  Or educate users with diagnoses and advise()?

If we do that we'll also need to provide a way for the user to skip 
using the fork point when pulling. At the moment I think there is way 
for the user to turn it off.

Thanks

Phillip
