Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FC36828A
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648151; cv=none; b=lg7M+ZPW8mbCbuRgmX9pqexzZTbI9XVXxWnHIYYQoqkaui4tZ3pFOK4/iMTNDIXHNeKGjJrcXgA925Iuy+XYTqh18f1iuhIGxcNFmIeIK5+b2Yrmi76GYpnonlnZSp3T0LorNKcrPejXF5BJ2A12BOYe51ekjVmWoAsjbg27g5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648151; c=relaxed/simple;
	bh=QO3DnNua3Ou6cVriTuf4BJSEg6+qTrHwoUtf0k6bP8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGUjaaPuo3cdViYlwb/HYk2HUyDUupNnpXlwJZ+rkAqvY0l6nBHL5GbvZEkVdznR+CZ47evI1oxYZB5AluwZEl64TIrY2hUVaeRXdz3Xp4OWbF6qV/Mb47D1UeGPSaT6tewbbK9Jq0fkWsF8s387mGigTrWJ+DlPeJYzW9yvuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZPFemfV; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZPFemfV"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-896f632d206so14266446d6.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 06:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770648150; x=1771252950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QO3DnNua3Ou6cVriTuf4BJSEg6+qTrHwoUtf0k6bP8w=;
        b=YZPFemfVXe4iSEL05cY25Ua4hZUcx1pokWQfKQPYbH/OxRhlhveo76E+8U6L8h3rA6
         FByuZKZ/8CQln23jmoWwuVjeLYBRFr9dl+FuXjQdyvS+RIq9Nrf9uHWZFwQ4WhG0f+0u
         qAVEc/ct8hbbX3IRS3glwj/CQoxYylHQqv+neQW0gzs+jVBM4BZ1K0et3OsSoVt+iftY
         /H2+sePTJD45PVFFEqVyn34IW+z9itoRO6XUrxjQYZCFAIND6GMKwr6VZoFXClZKF2Zy
         pX1CKIxKPfkDBIT5JqXc/3OyviqMMHtyTO5/DuqK4sup+sZ6WlL4h2UVNpTQG2I1PULT
         j5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770648150; x=1771252950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QO3DnNua3Ou6cVriTuf4BJSEg6+qTrHwoUtf0k6bP8w=;
        b=jc4lOxbxbPEd0eO7n2zqxf9odre/OSyFxJ4jVmm6/TgR8NKPdK5Q4JLl3jaHmXwQpL
         vW3SdWBUp5+mYpis3+KZv9G2Ef1/NgKV/U5h1vIkg2QHb+d2/+Q0z9hkw5+kGPjkUmei
         3c3ycN47f/pRNYL7IWhi6dPdE4m29m4hdopNJxqU26CWCsoTLVI21mJGJLEN+rTSh+G3
         2Xll+wAukL0kxVsSS7IG/+lCtMiiEqj6EgBB72LCr1WUGs2q5mWFChbAIYjBAwenwQHS
         53UFOEOI+wRV8JV6NHN3U7RY9mIu7wD2vgnWODsXRPH6C0BvEni2fNJr6CaVcmPj6Fa+
         y3vA==
X-Forwarded-Encrypted: i=1; AJvYcCUy6ew9aptAfiOHTwAeUJo7lMVa+9YIWFhn0nQktHUdh00fTYzX/DtORtl98OZyFCeqhj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwt9b4cPpAvPOBIvD9g1mdt7npUSfvFnagknrZbXnPe7dd7R7
	wzzfORGn/WnAIsLVSto0qqP/bGbr2s0JmXM0VCzWE7hS0SUJKlhWOXZkJSXOLw==
X-Gm-Gg: AZuq6aIHAJPFYiXA8Gg0+1HdiY06guVTSkZCEpURwxGJC6elvd6A/FJCvoQqJ2miAIn
	h5DYEuhSMcGlGoEOoXkLYzESlFpDY0nUQ3lej8mmcN/MfV4oJsEWL7VlZ67aFj253LL+Ez4LYDM
	yMH+UYGH6jW+oeO/B+yfVVwUjc4TE5teQ2U85nAqIrsi0bhuEYTEBqlFwEkTOfq91hYI4mNbg0r
	x+UPn4/n05dLTyYWlpiYLswWIl3AX4p9dRB+YafJtkSgxHSeNJ9Pmefo+tfejMuDw6G9F8CvZZ5
	e5ST9l3Tx9HnmxYvV1FWOgayt1dmY1ireWmZ8vXSXdEwKs3yqgfGyX0O0JjS0BjqTG1w8WNOHrP
	w/hkMh7CmQFZhsU0u+sbknObiYthujEgI0RYkmKp1K7MzfLSmqMgHo+5MVkO8ybYjU/YddUltiL
	5XttZeA7c2cUpmr8nTQKEXmdPnnw7N8cBvAzV7UUfqbFMnbSJ/sZM3O+hc2g==
X-Received: by 2002:ad4:5aac:0:b0:896:f42f:bf15 with SMTP id 6a1803df08f44-896f42fcb95mr73796456d6.10.1770648149925;
        Mon, 09 Feb 2026 06:42:29 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c03fc95sm78425446d6.26.2026.02.09.06.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 06:42:29 -0800 (PST)
Message-ID: <86a56091-edb7-4f94-b894-63b987eb1ba9@gmail.com>
Date: Mon, 9 Feb 2026 09:42:28 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] trace2: emit cmd_ancestry data for Windows
To: Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
 Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
 <a06344dc753698ece37f8d066b0a51931b7fa16f.1770307510.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a06344dc753698ece37f8d066b0a51931b7fa16f.1770307510.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/2026 11:05 AM, Matthew John Cheetham via GitGitGadget wrote:
> To not break existing consumers of the data_json "windows/ancestry"
> event, we continue to emit the ancestry data as a JSON event.

This is the important compatibility statement. When this merges, we should
make a claim that in two major versions we will drop this compatibility.

Thanks,
-Stolee
