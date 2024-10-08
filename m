Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D62139C6
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412371; cv=none; b=p5TRKytXfqteBvu5g+V5y6RTMxvxositL9UCpHbS/0KeqV4AWk1eMshVyhbteYoD1xXVSuOa/BBDuqfREeJgCToaqVs8cl5oLGILI8GZPrHrHlWOsCyiuhwfo9NJ/NOBYCzVJ3us8Q7NtcoQ7hyoJYtxmgmghyQXx+eAV0v0+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412371; c=relaxed/simple;
	bh=leYyRBK1iU6fd76fsdCKCIfQIjk2cpe0Tid3bMdalF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raMkBN/4ZDDH/tQpcXh5JzqK5M/LIR5VwLFBGbWWu9si1GM6W9/3A5Fl79z1ga14fQ2h/rhez06APseYnT+kmCKp2AXg7sYP1YazdW1dtMOBBSE38F/nCF/1694arAEiqmWO/F2A76Hw+JjFKpRO8XdEV8vTNGk+ULK+w0hPA1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec8n+sxT; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec8n+sxT"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e25cc9c93a9so5582114276.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728412369; x=1729017169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+duynAYC5AppsDxZIYLQb2BYR9ATSwKn0RWbx091Mc=;
        b=Ec8n+sxT9tzYfHBat+lmeLfc2bLhoVPlV/XDxI77LzRq6/mAwIHkgmKmQyZbymu/wT
         EJxaqFWb35SvmB0V7UmNUR+x27DBPLLxS5B5jeUdI8NyLgPr49Z9tlZJZhLiLJCUFMeg
         YA39hpSnLC3O+YBnurmewoKVxDWJna0/qFjXJSxTl5hPThO/Du83Ggd4iQnBtFDViY7s
         fWMUZ72TXhNVLYqH28m+/K3u5h43oVjZSSbt1Vw7mhlJimF4ZPjno9k/Lb/dOzH81kpp
         CXPLL+wzm2VWjG88J6BcVtzgXsHE7qSYPHlrICny8DYdz5wvJ+AwJkKe1wCCJMp2yt2Z
         Dhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412369; x=1729017169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+duynAYC5AppsDxZIYLQb2BYR9ATSwKn0RWbx091Mc=;
        b=RZcGnlfn5nz6ZdUgWGXsQQ0cCQKw637PkrVS34uxR1EGFDpU5DI/u6GwNyFt56hQLt
         yIhfpZ2Kdo3IeflDRPWy3q/PJhjawCURlP/66Le/Kn85YQvWja98kzfuzLwy9/8IKdP+
         4NHkmPCV8i1LN/AJoGxZet/eP0QH+mH5F+2xRjTp+Xn3OYzB95Gh6Jwo50+4OeCU3x9P
         EG9e+bd+WqZNC+fEijYqJFEDWQcIeOGYe5/wtgDyy8+u4vApd0eOaV7l8ZEyQJqNmxng
         E3nBw8HdEKLQl0e3KOJndFbe+Kta0+aoi5POYIFYpBgdGQ7lPsErtKTaY3g3CNAWvYbR
         RZRw==
X-Forwarded-Encrypted: i=1; AJvYcCU0g4kI9IQi/+Vc1YnBFnAPpqkj+v95WRPgYh6hmQrRb/ah0mBhG/9oWpo8gB8+KezkPc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHkiAFzdhhasToxD4Jux7QynpXRAcpLzvNMWTWZboCFpH5REg
	1AcC8quIAXpYJr8Gw5Rem4qEyXTdpj5gTy6o+JLx4CfCOqVY6YbW
X-Google-Smtp-Source: AGHT+IF/+UvcD5XFhLykmOY1Tu+pzWP1+gCPyHp5gFicHdOwYfpzbuJbjcbn27ajPao+0qFFs7bZCQ==
X-Received: by 2002:a05:690c:3347:b0:6d3:d842:5733 with SMTP id 00721157ae682-6e32217d153mr368807b3.35.1728412369054;
        Tue, 08 Oct 2024 11:32:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:799f:a786:d66d:649f? ([2600:1700:60ba:9810:799f:a786:d66d:649f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93f8f43sm15092287b3.140.2024.10.08.11.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 11:32:48 -0700 (PDT)
Message-ID: <b5c65c3c-ae6d-4b56-aec6-846a1118c59b@gmail.com>
Date: Tue, 8 Oct 2024 14:32:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] pack-objects: create new name-hash algorithm
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/24 4:46 PM, Derrick Stolee via GitGitGadget wrote:
> I've been focused recently on understanding and mitigating the growth of a
> few internal repositories. Some of these are growing much larger than
> expected for the number of contributors, and there are multiple aspects to
> why this growth is so large.
> 
> This is part of the RFC I submitted [1] [2] involving the path-walk API,
> though this doesn't use the path-walk API directly. In full repack cases, it
> seems that the --full-name-hash option gets nearly as good compression as
> the --path-walk option introduced in that series. I continue to work on that
> feature as well, so we can review it after this series is complete.
Based on the discussion in this thread, I recommend pulling this branch out
of 'seen' and instead focus on the --path-walk option which is now available
at [3]. If we choose to revisit the --full-name-hash option, then that can
be done on top of that feature which is probably a higher priority.

[3] https://lore.kernel.org/git/pull.1813.git.1728396723.gitgitgadget@gmail.com

Thanks,
-Stolee

