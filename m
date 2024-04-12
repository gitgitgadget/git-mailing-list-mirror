Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382E85639
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930035; cv=none; b=pFrMFHdn3+nR8u+joNgd3cwqRIPqTo4w+VDUoI8PoKWIlwP0kIJ6lkIiE8iRXDe7ZLAlxKiE+d0LvHvC3iEl8mXhqNRR9RGWQL1aKyR/8re2oEASzq5g+U2FzBVMGVd6nGbapoUIUHA0UAnuxqx/NBf05yOD77rOyO1JMmGqGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930035; c=relaxed/simple;
	bh=W25M73GoGVEIwnsKboKc2yjo2sdBhvZ+3SQAUvYK0/o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z6vaeoRd+MCeZDgkgF7cGC4COZEjhNU2muc6ezx/BBuDTqxlyo5rINTjt383EkSfOEY6N7tbDZj4WTiHJ09J0Gk5d5cPcsb1bOXWvaHlilr2gJCGMM712M/sd5OoNRmItq28giMYBZvPqZ8aTF/GEiapWwHL5N3KF4RPsF3c6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP2Xelvi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP2Xelvi"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343e096965bso550590f8f.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712930032; x=1713534832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDLFgiL3WEzZpSB79OEjEiE6sqhg211M4bVdKElWF+Y=;
        b=dP2XelviPyKMZULXUpA76i48xaPt+wXqQ/Sr3srfm+WoI6EG+Wk1yZ/W1dXKftG7BK
         uZZuInYIVpbcJMWjDFwmviXWqSxEcjMQNgm96oS5xSVPxtZ7P2uoMMPhr8hyhqAUMkZ9
         lydtLlpD5rt/U6ZahOIhMJ1s4syOf83FhKft7REE9yRCv7cpIPfJNEWSc67eCFEx1hN/
         aSCqRPRWL2wc6P3UYrwr7/2pWfFsHAz0Xcgzh3sqiZeVzp8K+FXT8DVUfVLcfktKk1lc
         QiAunRIUyeG09A7yJXCHB37po2IIW8XhnCuCDn1THQl6YgOAUcbKkU88UOAJxHcDpWOm
         LDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930032; x=1713534832;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDLFgiL3WEzZpSB79OEjEiE6sqhg211M4bVdKElWF+Y=;
        b=UAlACzN/wYb6UYR3y8O6+2xEVApBTAimHDLf/CH3jNOwCiBofvDzgHGgTOC8PYpPwj
         z9C+cmABNsR/5ahqnrZMOqyfXTDiNqVlADgbGMD7DbafF2dpueIEeWE/fiWWZ06DNlmV
         PGSdGA9jRllqocognk7zNU/IALd9DKcX0j0zJVeW8iCyj+AMz8JP/w9kZzf/500R8WR6
         FVjiBakI1cK+z8iC5qkbeNS8LlmO++60kaiQyIyPDab4//uQIUn9AFqwMLGq/ZdEyBjS
         MDO8sD5GMvI2UV5mTSdxxdc7DViJE60KExxetJY8nV88Su/S0v5cxGg505j2XPFwMJ01
         mHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzECqJ+jse55OKojeeuf5wcFflBfs5rM7zFfFt+dOQisC54uFibtYX7u/Jz9wXvmd8K2udGOQ4eUqaIeJHMv7VlLgK
X-Gm-Message-State: AOJu0YyX/oJKQkgT8J5ejXofh1Q2+3kgZKnGOFa3t/LqPOTZESRthqWe
	D+zplgrptLUZ2fIy5RAlnYm1SijE51BJR5Uz+5z/11fOGFSFphKw
X-Google-Smtp-Source: AGHT+IFrBmN704iUI6KcO0y5iz2Vg8O3kZddpq92QqFNzNjrlhiDlHnBdscGIe3EueQppVkSZwDiNQ==
X-Received: by 2002:a5d:5982:0:b0:346:ba70:82f4 with SMTP id n2-20020a5d5982000000b00346ba7082f4mr2797664wri.46.1712930032373;
        Fri, 12 Apr 2024 06:53:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id i10-20020adffc0a000000b003456c693fa4sm4319137wrr.93.2024.04.12.06.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:53:52 -0700 (PDT)
Message-ID: <a42bd1c4-1d44-427e-ab4d-76a72b02502f@gmail.com>
Date: Fri, 12 Apr 2024 14:53:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] t3428: restore coverage for "apply" backend
From: Phillip Wood <phillip.wood123@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
 <b45af37e3c0a22cc9e0514eb681300be0b968e02.1712676444.git.gitgitgadget@gmail.com>
 <xmqqzfu2yw00.fsf@gitster.g> <6ab115bf-7b78-4633-a64c-9a0925d68e3f@gmail.com>
 <xmqqjzl5z4a9.fsf@gitster.g> <5e0ec9eb-2e2c-4cb6-91e2-eef6b5c4300c@gmail.com>
 <xmqqa5m1w4ik.fsf@gitster.g> <33c6c944-e1f7-48e1-a9f2-8bd5027b7c61@gmail.com>
Content-Language: en-US
In-Reply-To: <33c6c944-e1f7-48e1-a9f2-8bd5027b7c61@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/04/2024 10:33, phillip.wood123@gmail.com wrote:
> On 10/04/2024 17:45, Junio C Hamano wrote:
>> phillip.wood123@gmail.com writes:
>> Perhaps we can write that in the log message to help the next person
>> who reads the patch?  Something like...
>>
>>      t3428: restore coverage for "apply" backend
>>      This test file assumes the "apply" backend is the default which is
>>      not the case since 2ac0d6273f (rebase: change the default backend
>>      from "am" to "merge", 2020-02-15).  The way "merge" backend honors
>>      "--signoff" is already tested elsewhere, so make sure the "apply"
>>      backend is tested by specifying it explicitly.
>>      Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>      Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Sounds good, I'll send a re-roll

Oh, it looks like this hit next yesterday

Phillip
