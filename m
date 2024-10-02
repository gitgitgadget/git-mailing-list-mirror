Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97D1D1E8B
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877851; cv=none; b=YBAdteg2V80jszeMjUA9igqgFyDpO7aeq3dYrdwqQd+nAG6cFjVae2hUGs04eSD9/e+rMIvbyITsR7fIu4e2VXuwGsnyEhBdKs1Mlp8yGbzf4hdwlh2+kq8qwa7AfJNgorIN8/hfwINWPuWw3psaobMsty7moj40nt4nXiK0oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877851; c=relaxed/simple;
	bh=b6VCv8BkJQ0nqja2KQ/ei+FCUqlDMKSW3knKPlS63jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JFOtoACPq5qH93ZGl+Hd3q8QrRj+T/FANqhaSOTViVPrFZWp2EO9q4UPZys6YXfVhkj5PhYK/IpFSzT/MUVa9cQWHp5tof/nnLoGYWbKw/cg72VrQ49j35m354sgsgIwkXTBPDl5p+0MlaguyqJ5wOL/Pd9jACToQlMhsUvDSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESWBzx/b; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESWBzx/b"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86e9db75b9so1234022966b.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877848; x=1728482648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b6VCv8BkJQ0nqja2KQ/ei+FCUqlDMKSW3knKPlS63jA=;
        b=ESWBzx/bOLYIWz7b6FxSCp5ZOd+fVmLFnXt8gTJt8a26Gxm+aONValB5vi6UE7KJYM
         UDr5uAsXi07euitt2mngSCMXeB+7GCU+khEmWAKZZ/SwGO8aeCVeM1DrOuz41Q70PqBI
         Sy1Bxcf/cOlSrpyzcU/bSGgs9DiOh+tHl/dI1638KovmB+5DIl3JyTi7lPuSV4zAEvbs
         9Gj7uYi+9BrkHF/m44K6E0YeYQA7KThVCBEd1Qj9kkB4LP0WOw2xYlzfxMdjOv7QHP0Q
         FEmczmVDb7zZ1tx+Xfb25zNaY13yeHPz1r8pEWWrANOkgCohCwNoTBtWXyoB7848Tdd0
         cLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877848; x=1728482648;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6VCv8BkJQ0nqja2KQ/ei+FCUqlDMKSW3knKPlS63jA=;
        b=NWaR46DiQnEEkyefWuE/Keq+S+WxFjhQCZ7jd3eGej5PRHIQCCgTBQ3PfkmjBf64Al
         hpxVV8MXQqq3Ukiq1juHsaTWcFNyD/a5+8l+pvRzHKwl20gM2xrklNY6DDmWYZo4J/Qu
         QN1oxfNwW3OnpgWF4LE4Su47NmivJOAomCd5pCDyT4ZOmD2pVDSUso5zCpa4721NK9kY
         Y4tXOuJvVJ5sEHt4MFMOwinOOdSiMor8/wqJn3iqfijpPbzOzwkEoTaklI/z5kV9uWyd
         SH2uILsbu1mYUvDF85Kn28XUO2XaQ3W5HJwBV9zqsPnG5QIQnuh4rCD2IhPsz/2dJYZ0
         eiiw==
X-Forwarded-Encrypted: i=1; AJvYcCUiDjcUwD5M24vFxhQa5Uf6oGw8hDjuSwlhg8cMsEnZ6KloGpmgpCrdqBfl8yyCHwlu+jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMBATmGeOJ/0PjxvIRpTDrdplIsJ9lRoKNBZaUzypA3AyEc3j
	7/qZKOqnA7cglvmImg32UYAAIz8onl719xgQaHM+n2oB3m36tK7cMrui7A==
X-Google-Smtp-Source: AGHT+IFtZSI/N/GTcRQp6isvf/Kjcl1bWxwLsbLnSKxyAztkOngY5dgdDN1PmzVkeUzSW0bo2eP3tA==
X-Received: by 2002:a17:907:1c95:b0:a8d:592d:f5c with SMTP id a640c23a62f3a-a98f834ba48mr411177666b.43.1727877847344;
        Wed, 02 Oct 2024 07:04:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947afesm871852366b.120.2024.10.02.07.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 07:04:06 -0700 (PDT)
Message-ID: <834250ef-46ec-4667-8e41-e427472fd623@gmail.com>
Date: Wed, 2 Oct 2024 15:04:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy]
To: Abraham Samuel <sammymore50@gmail.com>, git@vger.kernel.org
References: <CAO1n884e13_9FZDBtcFrwU8oCyv+0_WUT-c16qN0W9c+D6k2PQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAO1n884e13_9FZDBtcFrwU8oCyv+0_WUT-c16qN0W9c+D6k2PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Abraham

On 02/10/2024 04:04, Abraham Samuel wrote:
> Hello, I'm Adekunle an Outreachy 2024 intern. I am most excited and
> eager to start making valuable contributions to this project. Thanks

Happy to hear that you are interested in contributing to Git as part of
the Outreachy projet. To help us mentors, could you please clarify which
of the two approved projects you are interested in?

Other than that I would strongly recommend reading through [1] and [2],
if you haven't already done so. They should give you some ideas for how
the Outreachy application process is designed to work in the Git project
and lays out the expectation of us mentors.

Let me know in case you have any additional questions.

Phillip

[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/

