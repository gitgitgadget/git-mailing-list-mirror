Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449B64A8F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303954; cv=none; b=SXbvFUqQetcrnLZPYjie1IbvLZpYClULoUi8RUIfPIPxReGSrykAbgy8y5CH2rqIm0/N1Y1f7Z5oRO8jnlFESNWMFm1dTJy6uuRES8kPfl9kiX1jUDdbNOtjLUXB1N1LPz0QkLXSRhpto2WLQieB1R4eSn0HL6sC/U4fZmo5aok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303954; c=relaxed/simple;
	bh=QM4L5Nb1Hb9IYpL6gR+N163h9M7RMqAqvnjWwutE/UU=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZKZQw3BAvZK7Ncx2ufikJNI2WVFqJbt+ZHvF9dsfKvR6KE0d8rLU0Xjjyg+a5qyivujBMTAcnnjYoOUt21CnfGNcJjDcTzNkN4lrN2Svg1TNH/2RjLiOhtPbr/NNuyIeSC6fwlPfEtiNMqKEWuOdZnFZvBrQizlGeYtX6BXyAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgjVjq99; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgjVjq99"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b1474b1377so158645885a.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732303952; x=1732908752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/J3WeVOYJMBBZsjk3G730CsGKUsSurrFzgDMoWeJUc=;
        b=mgjVjq99HB3fRkaUecT31B1tppA4+rwljbqGQx2I7M8YIMV+FPNhuXC8EeRixIPq1m
         +RgxJYPgrc3s0kxyjgJ4kXs/s2EzHjifmT1UiKg3ZJnCNzpYWfuXFnlW0pM2RRzr5xdi
         QLIyxrG1j5P3lC2YynlKxFG1GCSAcWLH5iqsoUHdHflo4oBnzCT9CsCCKNjzucCxQV+d
         RTiJd8QVCFtoNJnNMuxOQ3OxU/Zmmjew3dDPVMt69CIkw3nkke0FGCsLoZ3mmtID9DrR
         mzJFAoVBGXdzaS+me1muYA0K+qvea6S/vvsoabM4lRL0qctJeZjlOe9vn4O923ExiBdy
         z7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732303952; x=1732908752;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/J3WeVOYJMBBZsjk3G730CsGKUsSurrFzgDMoWeJUc=;
        b=slVDnu3v/KCUWwkntOGnmfgXhs4tH4f+MkcrskO7Y9vJUTKXsDtScimL8THzNfSo1O
         HUi23jAoaJSsDu7jqXyFb07XDLQA/9d3C9ajVAfiE1WyMXjmYOJamimLzdYdAPnSrGpR
         RDqp3sEHZduavC0OPEuM018+4SnrNcreNoYphF8716+cJ3urAiG0GfEFGVOus7N5BJBp
         goHkn/w6uV1dLEpym9mURcOXdUHDzR71oAvGkmWBnoY6l4/8cWRVYG0xj7Xn+gJdCeia
         yv7a37Qj6/8oC2UXeHPSY5qRU/vqKXZV9McyzKZNxTkgSMix3v6mIGYMCKB2eA0eXuYn
         GlHQ==
X-Gm-Message-State: AOJu0YwF/tNQBkqjESUE36/bkafvlF5fS24r2g2nd5BUp6uF8mHCQvw+
	eTrix3uOuAXt4ARvWkhCvpXO/n6QqMSUmCvnQ04JJcsVDCL3HtgG
X-Gm-Gg: ASbGnctWG1LwXGu0D4/R3EYaffXxqtTDTeMa8jCmU19esUTw1srGhwy0I+YWJ0VsQF6
	nw8dTNIL50+4dTV7aAUVuk827dYG2g/uAHC1LvE/d6RdTOiqnjzc0aIdL3Gbv0jXXOCPwN0yvbt
	DcWS8iVeHvRwPDyz/LTPbc1iPv1GGnV3z0LbKsfEaMkC72exqAlkytvEkkr8Z4XYVanXTZQ/sos
	amuiy/FWLMUcdeywHU+EcT0xuovPFdKEHJtjyNRc7/hcHSEhQQSOANuE7HX6MN/pRM3FJJ50mWV
	LwJB7al4wtFOD/D2cDTpKR727+Qb+VFXhKydhzmox5tU4MCHPQ==
X-Google-Smtp-Source: AGHT+IEdkhOGz9c9+SnqrXMgiAsUvTc0nWDLGNEm+Yd1D5IyUkO3vIKa+KgdaV00Q3CgNPxzKvKVow==
X-Received: by 2002:a05:620a:294d:b0:7b3:5858:1286 with SMTP id af79cd13be357-7b5145fc0d3mr501073585a.47.1732303952085;
        Fri, 22 Nov 2024 11:32:32 -0800 (PST)
Received: from ?IPv6:2606:6d00:15:40f8:689a:b10f:19f5:4246? ([2606:6d00:15:40f8:689a:b10f:19f5:4246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b51415380bsm115789885a.106.2024.11.22.11.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 11:32:31 -0800 (PST)
Subject: Re: [PATCH 2/5] git-mergetool--lib.sh: use TOOL_MODE when erroring
 about unknown tool
From: Philippe Blain <levraiphilippeblain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Seth House <seth@eseth.com>,
 David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
 <6f7f553b283078ba3c81190686b150a87d901240.1731459128.git.gitgitgadget@gmail.com>
 <xmqq34jv3ou2.fsf@gitster.g> <c6d95106-e2d9-37d7-211c-b23199ceb258@gmail.com>
Message-ID: <ee32f2fd-7b82-2c63-5607-a2ce501856e7@gmail.com>
Date: Fri, 22 Nov 2024 14:32:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c6d95106-e2d9-37d7-211c-b23199ceb258@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Le 2024-11-22 à 13:57, Philippe Blain a écrit :
> Hi Junio (sorry for a late response),
> 
> Le 2024-11-12 à 20:27, Junio C Hamano a écrit :
>> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>>
>>> In git-mergetool--lib.sh::get_merge_tool_path, we check if the chosen
>>> tool is valid via valid_tool and exit with an error message if not. This
>>> error message mentions "Unknown merge tool", even if the command the
>>> user tried was 'git difftool --tool=unknown'. Use the global 'TOOL_MODE'
>>> variable for a more correct error message.
>>
>> Makes sense.  Is this something we can easily test to catch future
>> regression, or is it too trivial to matter?
>>
>> I wouldn't mind if the answer were "the latter" ;-)
> 
> With the changes in the next commit of the series,

correction: with the changes in 3/5 and 5/5,

> this particular error
> becomes hard to trigger, as setup_user_tool will return with an error
> before the error message change in this patch is reached. So I would way
> it is not worth to add a test for this particular code path since it seems like
> it becomes unreachable in the next commit (but I could be wrong). So mostly
> "the latter" is my answer.

