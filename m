Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8F84D25
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340255; cv=none; b=UQI/7crYE+lOFHgxUc0yNDkenGr3VaCuLFpPmIiHpbic9AVi6Hf90JdXRqTVLg+gns/5uW06P+fcQmlXYj9z/begcmZ9aFNtat8CnzZj1y7gE7zRxYSb1c80RflYhPOkIDb/gucC6yN2BahfiFNn4WFjCcSOTw9/imyiPNsNOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340255; c=relaxed/simple;
	bh=+s4fyqUTWMy+z7b7tZ5iN2D7oPTgumOhhToV51zCBHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WufEydEFMZAmpnK81Lu8xa2l5P6rYMrSbaSZE1J831D8D+i9gkMtVTh7IzkqsOy4BDX/L3YKOdiJiHSTDl1vgqNLQ3s2yD0vn4dkm0AhxM4w5EsllPCveJzuqqg9UNME7MDrHQ52Mm/Z+sTg07VhCMo1pSZcV9ObLdsNDlzd+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwuB08kt; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwuB08kt"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e38ebcc0abso4866357b3.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 19:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730340252; x=1730945052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9qE3WHQXM0A3/GPYNaqQmgaoWVUBUErYIJgGeIUgkQ=;
        b=TwuB08ktTppFuQyY5OlVqK6oJd8qqh4F9xSvMjHsRYAchI7J17LwPxd7MlMs+zjzza
         Ey5zVyV50dhLjIbGipD7CRZZF2171+9WSbIDFaQfLHM0kH3rz0AmC9KHAGQrADl53dai
         2aYuSC7QcK9y5AnbMLYK/jB0d7ut0LtXaqsnVHIXf/8D59WMJCR3hc+grx2VL/0+ZsYN
         CFBVeT2zESkMsje9OcV5mU1lioo9RZYNHTbv9eFaBsLf8z9n2vec3G+RIab010mDDHiK
         G1s3FwBgnxt4v1lNdu6n/6zxOrR77NdfAXCu1lJAOfzWXJL4XGiDFzeW/M/67SbNj1rH
         UrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730340252; x=1730945052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9qE3WHQXM0A3/GPYNaqQmgaoWVUBUErYIJgGeIUgkQ=;
        b=QU0CyOghxtJ47DH11SAOtZePsgQx6qWlXuZUpyz6t+ZI8gmeO4Qi0CiAheq+nqTs+8
         wTmWczPwFVIkAbxpv8R4WumLAIKiOwvuAzPUzP5TjEbqNGx61HSKRDoiyeabiiEFNCBF
         HhRrQmOGmAl658eDpwWHxduTI/N08877FGLB9e/3a68eHfnojGEtqGVTDt5yiG2M/NNk
         0guhBcmMhM7LskNA2I9ekwyaQFuIL6fv3x5x49rTESRJ+jrnGKJsBklBX4xS7Z1xoYN4
         TzfCiLyc5p27rpSmEyyT2ZYCNjVd+PGmyHuiupqzWjdJM1LxCydOPOhR+GJH6en7U6cd
         l0fw==
X-Forwarded-Encrypted: i=1; AJvYcCWFeYAxJ/W0h8JOUcS99h0hdRn/dwIKBm02pKCjQukQ9mDTnVSxggHm+EItK+PsD8iFWnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1alh4+DOrz9h01pMP3cJR1Hb+5XHoWyKxTTnF4kNeMwRnn+rJ
	D5r1DLXEehUXA1jvsAnTy3uB+44qPQUQQe+u4eJ2vOp8fxTMjose
X-Google-Smtp-Source: AGHT+IGbM8HUiS+aX1aqE17lSiLAGdI5shQrbQQWL49l83/tmVQttXoIJZTZ+lApR0lalc1P/mS0Eg==
X-Received: by 2002:a05:690c:6e01:b0:6e3:a7b:49b3 with SMTP id 00721157ae682-6e9d8ad571bmr197195157b3.41.1730340252148;
        Wed, 30 Oct 2024 19:04:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c963:384a:338d:bad6? ([2600:1700:60ba:9810:c963:384a:338d:bad6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c45c68sm892227b3.96.2024.10.30.19.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 19:04:11 -0700 (PDT)
Message-ID: <eff447c5-fa0b-446b-989e-b3e34a685811@gmail.com>
Date: Wed, 30 Oct 2024 22:04:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] pack-objects: add --path-walk option
To: Taylor Blau <me@ttaylorr.com>, Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
References: <ZyEkWyB/C/lGb36b@nand.local>
 <20241029213657.1303762-1-jonathantanmy@google.com>
 <ZyFet+Gamc8g7Hg6@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZyFet+Gamc8g7Hg6@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 6:16 PM, Taylor Blau wrote:
> On Tue, Oct 29, 2024 at 02:36:57PM -0700, Jonathan Tan wrote:
>> By incompatibility, do you mean the incompatibility between bitmaps
>> and the overall --path-walk feature as implemented collectively by the
>> patches in Stolee's patch set? If so, I suspect that we will need a
>> parallel code path that takes in the "want" and "uninteresting" commits
>> and emits the list of objects (possibly before sorting the objects by
>> path hash), much like in builtin/pack-objects.c, so I think there will
>> be some effort involved in making the two work together.
> 
> I am not sure yet, in all honesty, because I haven't had enough time to
> spend yet reviewing these patches to have anything intelligent to say.

I think that the --path-walk option is fundamentally incompatible with
the --use-bitmap-index option (using reachability bitmaps to reduce how
many objects we parse to discover reachability) but is not necessarily
incompatible with writing bitmaps. But it would require testing to be
sure that there are no surprises due to something like an object order
changing or something like that.

The feature is also not currently integrated with delta islands, so
that would need integration and testing to make sure things are
grouped together and delta chains go in the right direction.

These things may be something possible to overcome in the future, but
the lack of current integration points and testing makes me want to
leave this version with guard rails that prevent users from getting
into a bind.

Thanks,
-Stolee


