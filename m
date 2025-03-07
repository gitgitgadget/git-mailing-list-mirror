Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E881F3398B
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343691; cv=none; b=gmoEq5YbPiuRPRB5aU1y/oIzObjTDX2OVaC6RsK1Cr7K/hTTSstYJI5H4ersv4bXPe14jWVCiaOoSoftuYwqYKFxtj1hMIv+X3rWgXtRKow+gYoTtWFebp/m3W1iRhwi4PpNQ0UG8ZH0ddAeC3zccsk2VUO6Z509+7Kahw2aQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343691; c=relaxed/simple;
	bh=LSHq43JzWGI0H5w3PnJY49BgS5qsR1Kzv7XiSojBeBs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FNwWY5CwCE3tKWyScXLLd/GN05jhbpFt8lE+3RBn3P43H1Q+omurG3djmGI4LSSqynF945NHI2xJeQUImaCtGU6qk7cPGcNmIwQuadkmEw2kf+nZ+lve6EgLYO0/VvVqaJ7e7YF44nkZH2WGB9kwwU+wQMgHLSe29MkXLd5aJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QamXhPSV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QamXhPSV"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec61d0f65so341063966b.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 02:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741343688; x=1741948488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KC78xXrNAoVdsx9N61frNSWU3W/FlVnLVGGCzANdz64=;
        b=QamXhPSVP6M0fR6bss8xpXK4YaWh2h634HCCgGOIuzb1w5kqKG5QGpw6HmKc39Jpzn
         OQGLAw/7cSWknVEXwmAghc5dexyCZuq+dxZ+3Y6OrEi3LiG3Qq78yJgNxrsSljHR5P2I
         JOUpS6QteUm1S8x5TlJKxht3wFJaQCNW0EPLJtO8OHcfWbOVCGDaFfAi/LqFgH9mvzWQ
         DcVPkPB/VKx9CTfLIXjQ+BV9wyrWMgzYb9WaOiGtB7v88Ij4KNEwwRv7E3NvVEmhy97J
         Rm+0G7rts9c/yaqf53B59hqxtu/bdIbN8X5FPEXVoACuoXODCLQiiaTNYHfBGvWaP6OB
         K6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343688; x=1741948488;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KC78xXrNAoVdsx9N61frNSWU3W/FlVnLVGGCzANdz64=;
        b=S/yXc2uNEo7Qr3rUYOjW2VkedDIdJny8a4OIFstOyjezADn+gmaKXfI0GKPu1o7nsU
         oKa9B9eeWHjzdnhpjwxmpUbinKZd7My6igeKYX0yG76adU6561DK53HTl+VUU+zcRjQL
         8B6ieU+UevzhoP4eOvapAPmuUwiL8jJqzwqPu6pUUAFMvVCMzeTQT2Ay6CrkeYVXwbuF
         2YwhHZE/wxYuRGDyuqr8oPB9ob3a0aVtrk30BO9OTkqnG0xWd6yDciaayTdI8cUO31Mn
         L1b4HWOK8lDzQBLpalo68w7628P2KLRjYl00KgDAiym8TaSKKq/TbtjK+UaP+vPVMbrq
         xsJg==
X-Forwarded-Encrypted: i=1; AJvYcCXb7NUk21eyaNCBqN5HnMgA9AlifBR+gUuP3ZfuyhrVKnjicnwKwtCpbelySVIoj5+BVMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PirchISEqU3Z5LM9eX7puilCTcEBLN0oew0mjU7JlFfO5JL0
	KRa1U4GNV5jJff/L/viQaA42S6zdfFh/NM4cmEPhvLthdEh5Bc0q
X-Gm-Gg: ASbGnctpmubrhOkuxnLbZvpX2BVgs29mL+GYWlxZ7TxbUNS1ZU3xXMkC+N1PBPdu9lT
	r2xj3vDs8saDAw94wVrAysdInmhjYQBRjt2tnLkGYGWtO8xyW+h1+cLafh1gsSZd82f9Vezqbnr
	FkQt+Yr/cjVshFUucJiGMFrpwWopfQv9AtJjsoNUtaukAs/h5CR/1QJzrNfzPCdpGvSXGAq79Vz
	PzYYZJT5wOkEyxRO8RUIC2cEkN90tojXy+melpSQz7uDZ9WUfn5a6iBDoHb4Vhjq+pQGmwtkBjs
	XVb3CZFkM1OmL8ciheypEuTRwt3Pkl8tkYMdbxKLV2iqXaEPjbrnuw06cmydt0WfvpvwgKk6mUF
	nulaHUpJKtNVK0fr5hFtgmhs=
X-Google-Smtp-Source: AGHT+IE458TnVg+r0tVWAVs7n/ysbP9uUcqrB8n9tuXUSifJWZsQ0Dj1TzQlcDLejCjiv7tGcOy3dw==
X-Received: by 2002:a17:907:7f92:b0:abf:49de:36de with SMTP id a640c23a62f3a-ac2525b9adfmr287320666b.1.1741343688003;
        Fri, 07 Mar 2025 02:34:48 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239482f0bsm252266566b.41.2025.03.07.02.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 02:34:47 -0800 (PST)
Message-ID: <f68f4c5f-1bbc-4c4a-95c1-63799af6991d@gmail.com>
Date: Fri, 7 Mar 2025 10:34:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 David Mandelberg <david@mandelberg.org>
Cc: phillip.wood@dunelm.org.uk,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
 <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
 <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com>
 <42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>
 <CALnO6CBDjQgc2TNaXbBWiUNqWV=RgrL2Ry-7HzRu3Ozuqazzvw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CBDjQgc2TNaXbBWiUNqWV=RgrL2Ry-7HzRu3Ozuqazzvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 06/03/2025 20:24, D. Ben Knoble wrote:
> On Mon, Mar 3, 2025 at 2:25 PM David Mandelberg <david@mandelberg.org> wrote:
>> Op 2025-03-03 om 11:36 schreef phillip.wood123@gmail.com:
 >>
>>> Thanks, I'm not familiar with bash's extensions to parameter
>>> substitution. The completions can also but used under zsh (git-
>>> completion.zsh is pretty much abandoned I think) but it looks like bash
>>> and zsh agree on this expansion.
> 
> I don't think "abandoned" is the right characterization—at least, it's
> the completion script that Homebrew-installed Git users will get for
> Zsh, and it does re-use the Bash completion scripts (which therefore
> ought to stay portable between both if possible, otherwise we get
> stuff like 8776470cf3 (completion: repair config completion for Zsh,
> 2025-01-06)). The Zsh script has seen some fixups over time (such as
> my own 3c20acdf46 (completion: zsh: stop leaking local cache variable,
> 2024-04-30)).

Thanks for clarifying that, I'd misunderstood the relationship between 
git-completion.zsh and git-completion.bash.

Best Wishes

Phillip

