Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F21FCF40
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301612; cv=none; b=dSEBq3kpPMQwknvnQTex/9chcY2UzaSmmFk5p38QsfuzaQGt5wUHYZCZc3DiUaPHIBzAI5FfLnLam0aEFIjauBlpsUJsmIZrbEfi8LcQmrSUnOaPkRXlcWttbn1cjhUEpm4BSzPEf1xPJbViEQBD5Fgy7hE8brData9Xba+3hbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301612; c=relaxed/simple;
	bh=To1LbJKj1va2MmaDuekm0ftufAvI7hY4NYJBvqYTgjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVKVrGzODrdvHbPcdzSK+inysdfPhJr4nryfoYgUw/UjB1Oygh6Sse2aMMtwmzHCblNAjeQ1OkY5YF7Y1Fk/mJwZLBHJECETir4hvVcRwGxSg51Czz0hQ+xY5NOvlqssSeTmDTudXsQdxBBH7dtgn+ma1zaA7Ii8RzoFY0mA1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S808Ni/V; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S808Ni/V"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so3697f8f.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730301609; x=1730906409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R5T4lo68wjxhimO2U5f0fUk0fi0fM8j/6h7LGVajVjA=;
        b=S808Ni/Vlqfk3SdH8xgY+3uhfjeypu/5fsxSvQzcd20bdNG24dYP8gpA7prS/3jBvY
         zj9DC95dPhZ1B9sY5Ntz+Wu18YpS+8KX0MgHJ/jsjxAw1eLb3r/JCz5mkR6wym1jG80Y
         YCbu+lXTvyDH50D748Zt5p6/MlEvHskDvGUo6dPuza9fxLUtO7Oo0U/xtExXLZa52UcY
         HBsLe01MGlqSlU3C8G0kHje7DICoYfU9Egr/9ddRtzMkp4vExXUDc1hVSrFrPa04NvtH
         YXf5iLYFPK/rDsIg71E7R8QfvnLneLT+n1mzkuhO52F6MfVMe1XaoywA/GAagOCsDjvt
         keBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301609; x=1730906409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5T4lo68wjxhimO2U5f0fUk0fi0fM8j/6h7LGVajVjA=;
        b=X72tdpFpqfAqyjL6B9OQhjLOwS4XvGlF8vcq/GJEBygYgGYQ5ih6tVp2v79JtJ9/I1
         53lba3oIl/wgQjbg5vrgRk20DpUTMDbC3hqECQ1a++UqQuvpAH3j/aPE+k19bcGfvzVb
         z6IDfIZbAVnXjRoV5FpwU0+JNMSmPoiZ00gSY1zXnl9DTlwDVkPTS+5gbE6jxOV0Q4mW
         WmANeAzsc/Js+rbpwmRVBLmz2cKNSbhGT+r85ZvQPmhmgiQTAsiF3fcZ62hY/s+I9fUX
         aCYx90o4eheqFUMdJEVP9igdeV5Ba04tynMMQjrgG+3ZdAPl5MKQJ/HRz6l6uPxmhoP4
         bj7g==
X-Gm-Message-State: AOJu0YwissgaN7lgbgqT419KUv2NId26J3xCgumfXZFRpJuBGXFFMRE6
	u0dw2kHxANvaMz1CH+pRg4aawSLDj97pOUsZlWurZjPXonBgft99
X-Google-Smtp-Source: AGHT+IE8/JDPqOnNOv4f7DDcFIct7PujyNyLcG9IY5DQzYQrqqwr7eNbQ/PN43EzPx4Vo5TuBIKHCg==
X-Received: by 2002:adf:e312:0:b0:37d:3eec:6214 with SMTP id ffacd0b85a97d-381b710f80fmr2694850f8f.50.1730301608802;
        Wed, 30 Oct 2024 08:20:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70d31sm15622569f8f.86.2024.10.30.08.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 08:20:08 -0700 (PDT)
Message-ID: <e4a70501-af2d-450a-a232-4c7952196a74@gmail.com>
Date: Wed, 30 Oct 2024 15:20:06 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
To: Patrick Steinhardt <ps@pks.im>,
 Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZxZHH-oHE7g09xIR@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick and Usman

On 21/10/2024 13:20, Patrick Steinhardt wrote:
> On Fri, Oct 18, 2024 at 01:52:59PM +0000, Usman Akinyemi via GitGitGadget wrote:
>> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> These are a bit curious. As your test demonstrates, we retrieve the
> values from the "gitattributes" file. And given that the file tends to be
> checked into the repository, you can now basically break somebody elses
> commands by having an invalid value in there.
> 
> That makes me think that we likely shouldn't die here. We may print a
> warning, but other than that we should likely continue and use the
> DEFAULT_CONFLICT_MARKER_SIZE.

I think using a warning here is a good idea, we should probably fix the 
whitespace attributes to do the same. If you have

     * whitespace=indent-with-non-tab,tab-in-indent

in .gitattributes then "git diff" dies with

     fatal: cannot enforce both tab-in-indent and indent-with-non-tab

Anyway that's not really related to this series but I thought I'd add it 
as #leftoverbits for future reference.

Thanks for working on this Usman, what is queued in next looks good to me.

Best Wishes

Phillip


> Patrick
> 

