Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA633BE632
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172738; cv=none; b=I4ctgoU77d8zTwBTp9hYQrk+KBLVE5K0WcXo1GMeG0EsQQ9kl6wGAAf77TQBZrt++JTaRSaZawaeN/Vt43S7Am8em/YmUw8dXGJAFqPDKn0w/2hBFgM/vxvtL9eZsdj9DnUEoqIiHEVCCV1iYC+/0qXc3C6hYttk2QIVs6WxY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172738; c=relaxed/simple;
	bh=i06xGlcRVA/Rcb/V3D02+TPESxqFppM/6ozmOXXrp8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=W5SPxl7NkS/c6lSL/zogRNMFEy9lMLzO9sU4KjLmbq5Bc0+QszWfMaAfNCO/rNo8dTmwQ224ayy5STyZGM5YJwasS3gehkgS2MqiMfPIC0NwIKo5KepZv1B0bxcAqAMHjvQ+x20xBrEtZ3sLIhvhXjApx4yM1XJJPxZl1rnlttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoWgz6kH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoWgz6kH"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82418b0178cso7108905b3a.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773172737; x=1773777537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDwlgYk0INFk/KAKYxu4PNqhvNirAUVXnQrsJhmh9kw=;
        b=XoWgz6kHDVPuzddoyCWkBIhXGQGXnOAmb47ZP6L8C9VeDIcZNQ8gjcXw94IyPNW4Bt
         oECdtnzNz/xgxG4aQZoQZuOcTy76eIQOo+BRT2vKccLrdl/asJXeMkTmlwOvkAkPS0Xf
         3yuDy3tz+LS87iPu7pWtdqYvwxR61WP6CMaRqG8E1Jy7enDwwE3J09ibRIxbk4RoWoi4
         1kFtXYFYuqLspU0fyV1FSNV/vBdUxRsc44gcu5/9XdhdAabtI8ltbbhyAnAAZZj/8IBn
         AW0xdI9xEeJxTCNlaVpt98uf/qx+oQJFcmML7ZCXNi/Rxjk8pesY2IPVjqKIorxGc/50
         aH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773172737; x=1773777537;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDwlgYk0INFk/KAKYxu4PNqhvNirAUVXnQrsJhmh9kw=;
        b=n7Wf9ZMvJ7FcNAQzLzrsVNEus8moC/wrhdowzu8oU6l8FuJ8PT63AvG/FL/KRQb9cj
         zjzdr2r/4pyWJ6W25DWAq9+zlPqW34dqiDsHcDgD4WSLBnUR0mbSKZEs5F8eKN3JEbh2
         TYVp6Yxo7OWPmHE/O9DgEUvKjpGa9pNWjj0bz18+aDITsKKzEGlI3rn1g/4VncJJNJR0
         yjX+BBCvEnaJNDaZzMYUSU/ZMCL9rDSjuMUCXHRgYqy0gbANrDiaIlSBT8uUGllaSqvT
         prEGlHRZsXeeMidGyjZIeZbyMOVa10IPlmUOD9QQxT7clbfntZG9VSoEWOlXp8nlZMXc
         HX0Q==
X-Gm-Message-State: AOJu0YwgoJAiL1yidp+ylJT4jG0wW4M3IpsogmtA/g39zJPkY+yh/VWh
	sfC+0FWJgirO0ezKgu6+s46yH7ewZvbRsbDyqI69AqyKLyg27fqmkEyKWZgwmA==
X-Gm-Gg: ATEYQzybpNZvXINa/nM6PHPqNePvpXSmtDZIMY5QavdSdaZsfs/yb385rJ5i9aLMlqF
	hunpvmhl/X3aMcFGfddZdJWWoh1F/zbcgQDouVgtBwwqXBFagSv4dcL5KvhWuimZU72IrC99KiI
	DXTjOTncaxI2t+mdflx1nRsw4jxnTmL9UZSTxJxgslf0WR5DsxuVYu6YZsFDyytHrphfBxm1ZMY
	4w0j0ib9XUXWMXCXaWDZEXVcd8EU0YUI/y8I7NcU3qpaaetZAYQuMxchvzYl2n9ejCoQQijVWsq
	fXbvcEAcY1HMAxFvNlWkRvFm7QVKdXdoTTrTcOUrvWk8JUkhnazX9fpC76FDj4/de1ICd/Ipc5J
	NWqxi+ggNgVSSr7Z7FO+DfRRo+3TKXe+c0+3p3OSXHdrkRrmc/778M9teSR9091a04encG6XcyK
	M0Do6/M7ueM+1Xyse3f0OUiCISxfax7huT7R+hh/OUKHtUqPEKIxFCFth0WHDk30oDMaJ8gW4t3
	CS+1FNSCw==
X-Received: by 2002:a05:6a00:14c3:b0:81f:3c34:fa83 with SMTP id d2e1a72fcca58-829f718bdc8mr97828b3a.57.1773172736955;
        Tue, 10 Mar 2026 12:58:56 -0700 (PDT)
Received: from ?IPV6:2401:4900:9157:ada8:fa14:a0a2:2118:65c0? ([2401:4900:9157:ada8:fa14:a0a2:2118:65c0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc15basm109108b3a.1.2026.03.10.12.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 12:58:56 -0700 (PDT)
Message-ID: <b65284f5-f1b7-4af3-a126-f373bf93da7c@gmail.com>
Date: Wed, 11 Mar 2026 01:28:52 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC] Discussion: git repo structure enhancements
To: Mansi Singh <mansimaanu8627@gmail.com>
References: <CAO_P5U2f4MD-URre+4ocC=YQ570hr03pZHDk1jvuSOKx4aLOCA@mail.gmail.com>
Content-Language: en-US
Cc: git@vger.kernel.org
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAO_P5U2f4MD-URre+4ocC=YQ570hr03pZHDk1jvuSOKx4aLOCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mansi,

Thank you for your interest in contributing to Git!

On 06/03/26 10:40, Mansi Singh wrote:
>
> I am planning to apply for GSoC 2026 for the "Improve the new git repo
> command" project, focusing specifically on extending git repo
> structure with metrics from git-sizer. The ideas page mentions this as
> a potential improvement.
> Before drafting a full proposal, I wanted to confirm:
> 1. Is this direction still desired, or is it already being worked on
> by someone?

We have a couple of proposal related to it. There is also some
discussion on the scope of the project. If you're yet to start working 
on a proposal and have other things that interest you, kindly pick them 
for the time being. We'll post shortly about the "repo info" idea.

--
Sivaraam

