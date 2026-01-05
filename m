Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984834253C
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625234; cv=none; b=NBdyScBTjyyi+ibhSUTroFg0kx5zw/T79uQtqc+o24Nj3z8FtpDf86ar4s0+1hm6OB2iVJRdZUjGsWMMaWEvp7SOkm+9qyYICO0f401rIlOf7JRWDJAv7+tgrA3+VNLE8et/ovychiHwXEU7Fo+gWFYZr4e6xvNPuEzDNA95K+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625234; c=relaxed/simple;
	bh=Xp/A5dqmG0tcSr0znXMg+HdAhnp30//HDydUUmBZgaE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RZJLJK23ftghO1QCSwsK4Ia7xXqVs4ugCr29XbnxtNPf6dxZ+nKZueZHco5hnGGGNWaAnKPHLExM0/YcIVs8px7VRoI3KiZ65kh5es4s9subWk63OMbPmCcFvNQ3qoPBNOi5dqwVWeIaWySG2dUvdTr3ZqZTTrFXA6E2/XGI3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF/HdmIx; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF/HdmIx"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso6304766b.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 07:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767625231; x=1768230031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D85GP6/g93pBKGdwPup2KpoGLd2Z9N/kQpKBRrwPPJs=;
        b=cF/HdmIxEXAm8uIv+ZqI9hmM3YScKo9HnLMdSfRpZBE8A42AcgjFqmEVfDCVqAdb8n
         ffjjecxcTmWnGD4yL09vyVll/NWeaJVkSQlGKZPH6yOq4Fj/AsbVibjLC2SNINM4vjjY
         ++yBoTVP6C9uM0CXb5jvNKJlHyi8uI28R63InfNmMhhpsxSkq5hy06UFOtMyukbkDMyN
         hSsFcJqDp+YVt/XVnod5Ngh43Ge1mSepCXezr8+cfPjPDh55XKwIhNkxJdr/2mezj5iA
         yTfjg1C1jPSzII1XTWiFr2Qbm+BCQbSsehtfc+JPVBtJb6OMYtaQGUqlO+a9RsdAFv8K
         nSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767625231; x=1768230031;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D85GP6/g93pBKGdwPup2KpoGLd2Z9N/kQpKBRrwPPJs=;
        b=vGHA5MloA87iaTV75y2FyeZqDnev5w+n2Hhw4I+aToSdo5m8F7ZAYEcH2/1+GNfyet
         wM7ec+WmOTEaDojrcdmKrgST/CXERrdddy494pAvRmKpAevW8YjxK+F9YLJi4WdqV++W
         soCXXUEwfZrfu7LNYOAlq0D/7OrngmmS3A1I0kF69s9NY9hUtrCLrjufHRlp3KY0op3d
         rbjDJVtS/qx96tmpX/+ILiRyMaowrDKXaUCHvU6gPgQehqlDZaDR31i0rhF+2DIvk8le
         80gHlh9/Ret8h6+tzwBtyuQ/BM9SslOEfdb+p1TTiYfFPx6+wvWywbEUnId6GYfU8+T8
         g44g==
X-Forwarded-Encrypted: i=1; AJvYcCVx1m218OuyPgFcF2MaAf50kzdbqt1QfZWtTBPFapJTb77fW4CgjO32e0ZFbvNcVdpW1xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzteKAKCynA8QLjhzfS5U9+Rqta5k19tP2K75XQgzFtHeM8TmVW
	itJoke2cGR+2Lwn45j5QInfKnuS/+cQsvs88h3innxYMrPP2iNqowMA3
X-Gm-Gg: AY/fxX5crVZZxC63XMGLYrAk1myzYX69YEOXQ+ulkwqcZqR4JOKUdbUfA0cB98zYdl3
	2/UZSKMOBmlmsoWYYGaA0LH10ZYBmcqmrUM0zUN9eS3kWcTsJaZFuNpVvFK0eTftEL1x0QvJPem
	vE4bgcxlwJ6NaO3gdRaRw3JK4JvN1JJDARhxIqt0qwifcNZkCC3lOr3sIY0Kk7w0DnFACIrXwlk
	z1Rrb0DYIFi8K0Jg7VcKvduGV9TZHHSlmygGViTxcfqEoqEz00AqGKrmiP4WRHnc3I6obN994mo
	Mn0/RbB7WZuw+YjMBfqaumfy1GTimLPBQCjb3/1n8at7AaRZVSKUjCyVFeOQFy8y7/FONfduIEP
	R8zSKMdoa1EKl8+heUcrzpg1jSO+k0WsZa8pD2bxR06on1l/yYEL/uCDIPLM2Ec2vC7tbK2G/n5
	ame4rY4ouTardNnyigy+pp36szMbB1WSTQ/df7Ix3l82QIxCqohPGBd3AsQ5ngn5MP4Q==
X-Google-Smtp-Source: AGHT+IGtL9UaFU1xEAtZx9cUS3W4foJ5uj0oR8fVJ6tyPJF9l5e1LgljW8FT/n3WRe11UtRYw44k+A==
X-Received: by 2002:a17:907:d94:b0:b83:e7e:3732 with SMTP id a640c23a62f3a-b8426bb9433mr5468066b.30.1767625231025;
        Mon, 05 Jan 2026 07:00:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b84267a5063sm9075666b.69.2026.01.05.07.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 07:00:30 -0800 (PST)
Message-ID: <3947f777-e08a-4c17-81e3-c4711fe666a0@gmail.com>
Date: Mon, 5 Jan 2026 15:00:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into
 repo-setting
From: Phillip Wood <phillip.wood123@gmail.com>
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, Christian Couder <christian.couder@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau
 <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
References: <aVfzMsN2ouY3UBFG@ubuntu>
 <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
Content-Language: en-US
In-Reply-To: <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/01/2026 14:23, Phillip Wood wrote:
> 
> It is quite common that moving from parsing config settings eagerly by 
> calling repo_config() at startup to parsing them lazily via 'stuct 
> repo_settings' causes regressions like this. We really should find a way 
> to address that before moving more settings into 'struct repo_settings'

See 
https://lore.kernel.org/git/d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.com 
for some discussion about a possible solution.

Thanks

Phillip

