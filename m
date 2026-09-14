Received: from mail-pz2-f32.google.com (mail-pz2-f32.google.com [74.125.228.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2E421251
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378874; cv=none; b=mC3t1GT78khsWonhQzVMUnaDO+DfK0fs8PvYVn+a6qlNS26fLHUf0JH8aECcXT7AhVZLvcrVDrI/YprpOE8sKYbfBk3YPtPRC55Cssf9yrewv03XmLlJCoxI2cy97bK5burj6CGcM6nHKksLaqXAUBXw7PBZ4OgRFoZeCRT5ZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378874; c=relaxed/simple;
	bh=1FAJ76fssLOLRjCebvKhUeatJj2Fk5WIfAV/Aew/5aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcgWOBI8B1VYVZdkPuFngD0bbpXL+XiWF7H3v5wYyAl2y0RmPtG3n1J90o32um6N+fUdhtMhVMnxdXs+jOlIIIhY99Thy2igYGWTSJE8I9ctPyewLLkX9O1PXgcvl7PuBcWZz0HNWoJ3p3elK9EkHFa4DsBaQkp3Ola6nlptUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJRJilEF; arc=none smtp.client-ip=74.125.228.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJRJilEF"
Received: by mail-pz2-f32.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so1353735a12.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789378873; x=1789983673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4i6Wb0Ino2G3TMGzTJqcWpWc7D+3PtjpZfPiIDxk6+0=;
        b=aJRJilEFZL6haSaVk7wICpOcYO9rBxcqL8EeBeDAfCqdxBANV+ycWIGmvaMI/JOY5e
         Nu5B5BC3QB47l5pwV/oYMhBorNUW47FynfTrPIZHkG7BN1tw6DlY1QFoIH0xFzALJh9B
         mXnpGx+m6NSELzQNn0d6m5HIraQwkF8oWrGI7eXsZtBIXGgRmyZDgR3/eCQmx90TIIv3
         7/iLWW+MSYqbrCfmqvzdtSS9XY+Wx7wnB8iize8fIo9YpaNs3S6PmU3oqJInCrnhK3EC
         xh3fxvrtLOxEcebHjLtBRf41qS+vDAIuvlN93YTHKVPZsvW0qssOE3Xe3gZUoQEz8D9j
         7WOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789378873; x=1789983673;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4i6Wb0Ino2G3TMGzTJqcWpWc7D+3PtjpZfPiIDxk6+0=;
        b=dETaB2Di9PR00ya0e+bkH+ipbLO3a4v7R9jP7tT8oq5O7IrQ/8pPeTyWBwtwwq3UnA
         hSZJpI8OtpcV9GbQv44iuLbZ7dZLdDWu/88QawIm+u+WgQnGZ3zQUpZMlHWP6oDg3dED
         qLJXRK8+GbGkevmsJELK2G1aKf7yrZvXmghb1/3ejawfqc5AltQheyuIGJ5LSaX5iNBy
         1Y+7SSDEI5H8eELdTTWma7JO698jEt9gXBuv521/LBzHUCjdCudjlmY+WzaA2TOWTrp4
         ZAYLizkyna8pPDdH2QJc0yPAeNCugOtNOGugUvvjsiRvku6xJZovOAJtXR+DPgy9W01Q
         aL0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwO5IrduSBZAV1yVxM7MC+I/ED88SbnsmMuBkaxP3lCOxJLkVNw5nvy5Km7P1CwxgoXsPY=@vger.kernel.org
X-Gm-Message-State: AFuF++kVPYSwtEkon2AL2kiCm5c7Q+pTMkbxKu8Z6h/NqpmWYT70TxuU
	CTPwBuOnpy/g9hcu5WnLAjX/k2kvNlC+9fflJUQ9Zvrvcw+MaeNYfNME
X-Gm-Gg: AYBFou2f8he3n/XieuMlqIQmJOP1XYR5yVRSx/aWqyzgcP/7KoKwt29/z+uMySj+T47
	6R6kLJ7M042yhRycDA/s33meJllbyIdToSokt3yhv9NI/emI642YkYT+EUOy4KcvbwyHm3yRZE5
	DuN/9odtCQ0LnUYijGAi8RgYYQv6FJLgW0QisGTFJdxVSQGAGzXrFXZ8EaUw5mNmRmaQqtHmBgL
	OidpyhEmf+TcwaHjsDB6tfNgGnk99pOfTismnO8Lxuj4nkCUPj4oezTOulp4Wpdp/IZq+Dy00kZ
	P+wpujImCqQ4MSPW8tf5wMeMNEQq2d6UXOgThk+8QqNNKlXwI2m7Pnz/7fzqH3MIdNMXnfJiItn
	SZRgo1csGLKZg7UjCYE89xAgjLsaMo9VuVPA3LOVnZum9d1N1YTLB+xstBiBMQyMM8HrkfDz/1T
	Ok9BPvEGUT+MIn6Y+3ECnK8qM0WEroZit/c+mhHE2m4dUZNU5uildOWzTHCtVLGb8xjoAYjdhwX
	il00diYsVajYIjjzIHaLBx2vsco3IqeWH9FvuVQw8hDKTr0olatNhU=
X-Received: by 2002:a05:6a20:d090:b0:3b2:a809:1000 with SMTP id adf61e73a8af0-3db4039fa74mr3632608637.3.1789378872579;
        Mon, 14 Sep 2026 02:41:12 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:89b8:2267:1cc6:d572? ([2406:7400:12b:61a6:89b8:2267:1cc6:d572])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143659a9a06sm24621058c88.0.2026.09.14.02.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 02:41:12 -0700 (PDT)
Message-ID: <1b904e64-e681-4744-b83e-690f3ca94ea1@gmail.com>
Date: Mon, 14 Sep 2026 15:11:07 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Participating in Outreachy's December 2026 cohort
To: Pablo Sabater <pabloosabaterr@gmail.com>,
 Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>
Cc: Git at SFC <git@sfconservancy.org>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>, Tian Yuchen <cat@malon.dev>
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
 <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
 <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
 <DLEWITFIKFFK.NSANTRY5XBCB@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <DLEWITFIKFFK.NSANTRY5XBCB@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/14/26 14:07, Pablo Sabater wrote:
> 
> I've applied as co-mentor for the libification one, this way we have at
> least one mentor for each project.
>

Cool, Pablo. I've approved your application and also Usman's. Right now 
we appear to have 2 mentors per project:

   - Reduce Git’s global state to enable Git's libification

     - Usman Akinyemi
     - Pablo Sabater

   - Improve how command arguments and options are scanned and parsed

     - Christian Couder
     - Siddarth Asthana

Given that we already have enough mentors for both the projects and I 
have some bandwidth, I wonder if it would make sense to also propose the 
projects that we proposed for GSoC but were not actually taken up by 
anyone. The following are the projects:

   - Implement promisor remote fetch ordering

   - Enhance promisor-remote protocol for better-connected remotes

More details regarding the project can be found here: 
https://git.github.io/SoC-2026-Ideas/

Thoughts?

-- 
Sivaraam

