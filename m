Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25A1514F1
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384610; cv=none; b=Qen2yMOoCb7uU2OkXr9aOn7ruJHdIzJPH2SE+IDc+yIRKGXBaSQE/kVQSuYcUyiYfRMwMH40XKHtkaBdZEwn4ZGIMUwZb+/qbxBO3FxFSqyNnfC5Uz/wBG+QDMrSKLkPxvuJhLGXHqKtkR3uRTH/oYMVbHrZ2/AMWg/3BmfDmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384610; c=relaxed/simple;
	bh=myDPu2+XwEyeupWyGp9QiOyIL77MjiIHNgDJDKFjlPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwL0vx32kzzve7XlErlZoebXIbxPmRh5vNNXwhEZXwDEykKkcm8udCHaRod0khml0f6yy0ANSJBEGJ0JeCLE/e3Rp3U7heZmUqh0OL5Q7Sz07vH090XsfpYhqAUOq14wY2+YdmPBJvn8Y7iIluN6Gmm1vIz1TH21ipFhtdgDs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVjONg1k; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVjONg1k"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c7e2382b94so1118659a91.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719384608; x=1719989408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luHfu1fcAzW3dtwW96AqXY6cMgWbAukA6Xw/mYkvdUM=;
        b=TVjONg1kkS71PH90mEcsGQwJ9C9nOq8D5Kg7e1M+SGS9ck6+6nSN0HF2IVejYBS+og
         40BeK5uxDIxNd//I/evcWrYmxk2QTcO5TejQIbmV624sqMimxGQwCZJXPsEC+JO9iQ2c
         AHLV3fEAP42v+drdNWWXspGRpkMMHP+SZRPDgaTWYkId915U2Wu1RH20FV54ld2WpzTz
         C8s7DDGWSk+ijZIHpA4f8fwNMiUcWVxqLrrqXXinV0YAELYhkrNCfH9g+5LJ3nQZhrdF
         uP/0WrQZ0j3QVE+sAOBPVa1ZFir+8dfpfZIGqVtWsv3yprxAbq3Ne8udJ7AfxIPQQDdL
         AKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384608; x=1719989408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=luHfu1fcAzW3dtwW96AqXY6cMgWbAukA6Xw/mYkvdUM=;
        b=xM9fs5d7i1ol9OjU3fK6Q72Ve87E2ASAi6+e9ulVkCTRD/7wIZn3SNh0sbL+gJ9kGB
         PzMe2fIglckspPZyU0D3BEqBLv54nhEMZYDYjwvPmJdbyLgAP7t2NsY8uhN3lkpVtlEJ
         z40aOR8s38pqxI7Lbh/XPtOA/xCtp/LqQVtGMn2avim5D4cLu+8zrNo72Ukag7cOqsX9
         8ZWnlwhjTlU3F3Q+YBrGPJhZtvXPo4PYIlkmTsLT6pMgSVp/Y/RkCYveP2FtyTap5SDE
         mky4PHsof0c9KtHmyVN1Q0JxcLkdCUWl+Gf0BGYgfekCaEbtf/OOVhCn/77ORS43AP3R
         KCKg==
X-Gm-Message-State: AOJu0Yzjbt/xtw8l0XOWBodq51gV6gsEe4KYPjSeWrQup084LWPuOa+l
	mOygOGMk8Zrgz0kV+jtJKSreUH/dejPC7nZL3ZOhhMWLKb7HyxLbXl+9OhCQydY=
X-Google-Smtp-Source: AGHT+IFVnZha1nWlGlQVm9PuPVxZeXMiUhI8ZdCA02nkwutQm742UcXUxFsCGNjHzw6Lro1WrrO85w==
X-Received: by 2002:a17:90b:1a8f:b0:2c4:e2cd:996d with SMTP id 98e67ed59e1d1-2c845c56076mr10077839a91.3.1719384608172;
        Tue, 25 Jun 2024 23:50:08 -0700 (PDT)
Received: from ?IPV6:2409:40c2:205a:5198:5a00:e7e1:cbf1:679? ([2409:40c2:205a:5198:5a00:e7e1:cbf1:679])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d8072046sm838851a91.36.2024.06.25.23.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 23:50:07 -0700 (PDT)
Message-ID: <272afd08-e2b3-4d4a-81d2-8ccc80d87dd7@gmail.com>
Date: Wed, 26 Jun 2024 12:20:03 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] describe: refresh the index when 'broken' flag is used
To: git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>
References: <xmqq34p1813n.fsf@gitster.g>
 <20240626064143.18945-1-abhijeet.nkt@gmail.com>
Content-Language: en-US, en-GB
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <20240626064143.18945-1-abhijeet.nkt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Apologies, please ignore the above patch as it also includes the patch 
files I commited by mistake.
