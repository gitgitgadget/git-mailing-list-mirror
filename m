Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B801C07C3
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586162; cv=none; b=GRLiPsYNmPTqOvvjLG6E63rX27Mo588x3FIMuhFXWRCAdmrW3Z3cJQQ5LB5hY/QvnR2VqViwVzR1VSZ45wS6cCRVtOrKUMK1fNAqU2itaUevgcmhPPBssUx4CRuDZ1kW0Wizhns0omQSeGTDXnOXlMoQuDOuORXlk7APiA3bkR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586162; c=relaxed/simple;
	bh=ku959tBScn5uWaMF9Rb7bo33P1cgYvWtPrZePgLbw4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gL4mcNWUZ/cDD81aV/GOWpWX52LhCdQcYQtrhe6CRANUZC2RieD7GnQlhda19lLsBqRoqs1MKYg+JwIhKDu/p7dJ8TDsvMbyFol0eswax4dFK6K7VWL8LLzMTB0fGNLqGy89Ei2kDfQlj/MZzaP0WVBQ79vZ5XAM8Ll7XluMW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqeqgSqQ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqeqgSqQ"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d948ce7d9dso2255275ab.2
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751586160; x=1752190960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ku959tBScn5uWaMF9Rb7bo33P1cgYvWtPrZePgLbw4U=;
        b=cqeqgSqQIBH25DjGD728TdoKe/2Z+KdJ4aaoVy9+9F1YaKjV6dVvvy3tr3YOfn0mjI
         n6895M64xVUdoTN4fOFPZQAKA3kTzFu/MND09HRRNZ7QHZ5fCOvIwwaIGrbr0zvVYhLr
         ZsRgS14wjK3hr47iv3Hjtk/+wHP+XLQ6PX+fQDrF/KzlMiWK7kEFu6c4/WqGG7iX7Gpu
         /N5ywxYYJyUT7jq/XqQ1Cb7RtuowddqEE0L75bd2YVH0R5hc0CjufJP2bnHgTZcH2rxM
         sA4nSpNljcJrTDtFqYCIbmvLstorcfnjD/teYijs1nQdBDg6DHCWt1sPBosIVRH0sc6p
         89sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751586160; x=1752190960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ku959tBScn5uWaMF9Rb7bo33P1cgYvWtPrZePgLbw4U=;
        b=tSmWmVEMNkZbOUpFcwlEkwznRPzcTZX9ZI9mmoutiwxHHimD9NXZBPfuORZKPC/6lr
         Fld6zqIhikb4xafBRobMrpZTT700A+4XZHusMeiX5d/EY+0iUfc8WtQfH6DlrsxpiZV/
         O7NGLRhyKiyYFvKXzzmxC8mgaZAyW+zHxgHCo1cmG4wrNRsTyxAIjgTl9rcuR5JEdvgQ
         b0/tDZ7kJojKKcKhzCu23Fn1LRCUy7zk3tZE3G63aj1o13a0heIi+iqHhHPshAz2aY+Q
         ocsX+z+gK2ngqcfa1CV5F9jFA7F0juDFPKc+59ZzqgNzMcW5NQPsvxchunh+5KiIG45b
         zJxg==
X-Forwarded-Encrypted: i=1; AJvYcCV/jFq1gxxYti6VvomkUVt40FvExCS54cZgGT20NjukrIDhZWuv2yoqrX0Hv//4xmHJgds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnuWuXBDdPidrklipaV04EvAJs1cQLwvo+QMMp6lEDHC0tbWCC
	/xCcOT+3D4Zvbm/+qYSXpISB8ijtJB9+cOvqqndloI9fm6df76IFN2JH
X-Gm-Gg: ASbGncv1+gqFwLsUeZ25XhIGCb10FVY3/BkMP2/lNZn2lxc30Du075e9Ih6qvMnuYPQ
	fT0Cjh+bV4R/l8hy+M2vNQxR8CIaLM7/kJ0UvFjq9FApFK2KhpIw7YaUYabNcIx5adOdH8/xyy3
	TtVPihRJn105+O41VphmaMBlmyfPxK8ToGnTQa8234BvZ7g2WiL5JDDSbweeSbULmRSMFFj7Yj5
	7RQYC9AF+i6PKrGSJg4X5J9Xq1tlgGsnV8fAdGayy71tmgX87JaoUbuiSJY3vfHqrha0hYxPUGr
	Bg2bN0Rw+IFY8vU8o8JOMsZ6BHjv4J23d4FyvefhBiY6h6Z+e1zmIuIzuefHA5EY9tA/e73usCN
	7khlubJxI/ErnYjv1j3NLeWWVlY/aLu5LmpMr8bY=
X-Google-Smtp-Source: AGHT+IGnzha6tIUU/nGLpVMpAliz+soKE4iQJLX2XAY/ikh8tOaql3giu2kOHRaNEBEBQ6+WTCs9uA==
X-Received: by 2002:a05:6e02:12ed:b0:3df:52fc:42ea with SMTP id e9e14a558f8ab-3e1355ec4a7mr3231815ab.13.1751586160121;
        Thu, 03 Jul 2025 16:42:40 -0700 (PDT)
Received: from [192.168.1.105] (c-73-176-204-61.hsd1.il.comcast.net. [73.176.204.61])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e1004b78f0sm2603455ab.53.2025.07.03.16.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 16:42:38 -0700 (PDT)
Message-ID: <cb8eb906-b0eb-43fe-b7c9-3fbf8c84f4d1@gmail.com>
Date: Thu, 3 Jul 2025 18:42:37 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] setup_revisions(): turn on diffs for all-negative diff
 filter
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
References: <64308d3f-281b-49a3-bc10-57878903bf4c@gmail.com>
 <20250703153438.GA1309870@coredump.intra.peff.net>
 <20250703224428.GB1909836@coredump.intra.peff.net>
Content-Language: en-US
From: Eric Salem <ericsalem@gmail.com>
In-Reply-To: <20250703224428.GB1909836@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 5:44 PM, Jeff King wrote:
> Argh, I forgot to add Johannes to the cc. Fortunately since then I had a
> moment to look at this, and the solution is pretty simple. So here it is
> as a patch with a test.

Patch worked great for me. Thanks for fixing it so quickly, Jeff!

Eric
