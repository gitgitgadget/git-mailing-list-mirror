Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DE2153DA
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027757; cv=none; b=gThA6j5ixdc53oAg8Bam3agnZnDFUtqZk928AydU/L+8tEebyTBeitlNCMuftEC5st/3fLceiPuJPT4o3KjjCiQUz0kpLedb5uufWy77Klndt+41ttPrDoENCEOOjFxAc3zIuqLdswu+Th9dGumfWo8B/gzr79uEYsP8Y+DFUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027757; c=relaxed/simple;
	bh=5ND1q9sCb0+qwx9r4KEBZytlj8fRclJpLOSxKuMIIlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9JbbdS/BLXSuIlDh0PgWNOzzXjmXD7iABQmBvwQmrLuYhzQjv0SdNbWar1zW+fq9CNone+QEO8bZ8jJVzif+BYz2NZSKvSSzbU9Gnf0XgAuBVx8sU6kaHf03sNTQkZJ/5c3v7WIheY138F9sJZJKaT4m70ofICFfwluJLamtPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1OukPCb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1OukPCb"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fd6f7f8df9so13951177b3.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 10:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741027755; x=1741632555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihVBeZki4ne4pH1cQQ2EyaM+2FGz3yj72aNXJ7wP28M=;
        b=X1OukPCbdppaf8QqJ7v0ARKztP1onpWHaRjW7qtYp9+W4iyS0l3mxmx6TNbtmhQUwA
         YM3eaXzI99U/35FZV89daIRATeiEU/m8R0tBEo2Ami5hNvL1ib3KX952xkU9JmiDrZI1
         xkwH/dcY4AkUdBHcHKiC5gw9bhPqhb8BXo4h+ceKWHDlxK0plOYXqEXBMD03dTWdCyAG
         ZGHxqoWIqS+Fk99eulMezmYwlMgb3E3nCDTXAE3gwhLCEgwPUv2LIzNodCrp19CxqFXl
         qbu/rZd8fySLRS7ueDLNopZ8ttPTLoT7tZafA6zPHQh4csi7Wr2dF/uHLbBFhGAervW4
         POIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027755; x=1741632555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihVBeZki4ne4pH1cQQ2EyaM+2FGz3yj72aNXJ7wP28M=;
        b=eeypCCgO2Y/v2vTwICfF+TUPGpKVG3oyUPym3r+i0sqK6eQ7i4RIvptk65OAEbTlGv
         yiBUY0z78l3wwZW20LGt/TxpWOWHz9dwZqfBkYkr4KnpIZZv0HZWaYUP2uSgpBsV16fO
         tZqokmHUkl1Kz7lnC4ZkQS4xQ3HwC4wlqJZmOpqq5KWQYSZ/zRaC20pL1xqVf/HDZnDQ
         ZJedGTHF/FLJODYyCQ3YPYktTqgviJJMrnFPOAkaqgJ9JdZKR1kd5QI70myEsRpWcfBi
         +MtN/a0E3VuSm1y+m3wpY3zkwrIjek/ng1gFC1EGR8wAIr5tYyKFjHK4fO0RkUostPWN
         fGKg==
X-Forwarded-Encrypted: i=1; AJvYcCX/E1Odefzc/X18yVBgcL2S+QQXWxbr+nOTjgLvng5BAolpdB/5RuZEWPP8mCHbbeXLXU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLt5lIjY6DGuvsVR/HEdc1YVtvKdtESiVXxyYajmqhGD98WP5
	UoDxaxIuhysMaXXw13EuP0zyerHYsrvq0x3Cpz3GRmrAc0qjeCap
X-Gm-Gg: ASbGnctsxVxHM1s1C2t5EliJ0lWra8tadkIzsmYZXMxkwDEB2eSS3JANNZKHw9EPcpO
	jmNvmeLaZkNKUCQ32uLppbp9zqvTdEuB5HN3JhtIhtY7YxbK0BAjLDXaCjJhRFLNORycZ/0HawM
	TEPfUwyTWVEAO/cbLKxtwt4rhJj9BgamND7QTAHQ++na4wubPYn9wmxT9Nm+X1jUuQgaNfItUbm
	x5GHc1z8s2DP8qWsLEHcEc7zCZrLtwYLA75C6ErFZNkfz3Q97gM8p14UfFZ7vqEVG2zkBpMW2bN
	JpcGbJNo8166sTRGGz7tMlXSrSDz/gZA/2URJQKRMGonHblXI70SpJXho5c7KT90g1qwIf8thEG
	qmP+1s6VvA1js9dy+QypzmJRjQFtWa+ji
X-Google-Smtp-Source: AGHT+IHy2UyRNLcdpuleSWXfiwWBeD83/Jnc96m8FiUG6vzb5UwH7ojYo2htMLIzcvNREuOPkKXoKQ==
X-Received: by 2002:a05:690c:317:b0:6fc:ed3e:ec3a with SMTP id 00721157ae682-6fd94145d6fmr5372727b3.5.1741027755183;
        Mon, 03 Mar 2025 10:49:15 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:2827:b04f:966b:a6d1? ([2600:1700:60ba:9810:2827:b04f:966b:a6d1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3c7f3803sm21412187b3.0.2025.03.03.10.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:49:14 -0800 (PST)
Message-ID: <6bd6f655-4726-4f59-add4-643190a2d086@gmail.com>
Date: Mon, 3 Mar 2025 13:49:14 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] bundle-uri: copy all bundle references ino the
 refs/bundle space
To: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>
References: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
 <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/25 5:33 AM, Scott Chacon via GitGitGadget wrote:
> Updating the series by fixing the tests to look in the new space that heads
> are placed and added a small test to check for tags.
> 
> Scott Chacon (3):
>    bundle-uri: copy all bundle references ino the refs/bundle space
>    bundle-uri: update bundle clone tests with new refspec path

Thanks for updating these tests. While I appreciate a small commit, we do
want to make sure that each commit passes the test suite whenever possible,
so these two should be squashed together.

>    bundle-uri: add test for bundle-uri clones with tags

This new test is good to stay isolated into its own commit for easier review.

Thanks,
-Stolee

