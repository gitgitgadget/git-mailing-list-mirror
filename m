Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241ED3A256C
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412192; cv=none; b=tK4pAyN7+sAG40YFfV3htGHEc/0zuZE3PsRg+5lsPpaoYijJWVCZFkIojmZRc7EKOCwaUYo5MzgBVT7Zb2QJgBwLV1CfVaDpd3alJmDrrR58aM1d+1bgF7WdNiqayUyCLXqP8gzKtZFp6mwWKD72myyyMaQMMC4MFzca/lt/g3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412192; c=relaxed/simple;
	bh=+u6L/dxJ/jVGBQPHhdqNM503awFab/qY3b6JbaC5+5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1jiBFyApv62owbxT3a8h3lflhBaRAPaGUzCc0QUtnv/jDVFlLKe4CEYmCca1GGlxwNR0Z3UCNKuTnYf1fawSipBsSUZO8R7pGIYRsZUlho1bZB+UyFe7JFxx7xJ7A4KXpYybqPEip7tXJy4PI+a5B7+wXjfyjsDOoKwTvV0W00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHcFf98A; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHcFf98A"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so25392205e9.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773412188; x=1774016988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RmUrLmUQoTlY37Mfs/Wb5VynsgvEShpfbEIwXnD6gAY=;
        b=SHcFf98AUIEgn3zNcg7W1EtSv+NqYoMXkRWCtyPAvORcx6BKy5rnYpp3XW1Gxi0jfW
         6Q8nD0AXZxipgHmjs2X/nVAOUwn858WiCqrTqFUqt3lKgPxpIbjJzr8n6coJ5mDNhC48
         UyaXW4F+quafZo4HfkTEZV10TIhLr6kb8lFN3MWVjVB75BjyUO8OkxvdP9L9tauzQhgn
         ibxglsK2MVkCpaIJS2JBDUkKD+QW3piysBBjDbNJJfMZn7XApIgeFpO0FMb0fTopQKPZ
         vjmkIu0DJglxkiGpkoCm1Ps01+TrdBTq2ldbXMFp4VUaC0telxJ1spN7f0nhY7+0htsY
         EZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412188; x=1774016988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmUrLmUQoTlY37Mfs/Wb5VynsgvEShpfbEIwXnD6gAY=;
        b=cgGYY3nHQZrZOF23uuT2I3rO+9rS0QaJzhGSaeURWWSAHovO3HCMqnaW1IUE2wcldN
         698vRgTJW+tuPJCh/o29WxwQUf/hPBwgggvPxPNcugh9pzknAo6puPJsAT4Dj8m5tTG4
         xz4B2KcQkqLH4h7isA7F6bezg+GkznqHPuhrUWYjQyPN9CR1YMbDVLbPxvNpFrcRBxNz
         VQYYB8mLn6YPPZlF080qAAfVxnBoH6x0CrZ7aCTo2VzY8/YDOiZjipzY8m3r+fpGP+3R
         k2NoiXX3PkyvHmnle8D6gpRhDQdzytYul5Hwbu/sVbwChP+CcTQP0CpOQOaV47+fOu1b
         DymA==
X-Gm-Message-State: AOJu0YyJsDfZhWNvlhPf828jBImzKai2LW2q7sXgMpVUSTD9lhyYNJNS
	p7ZkaW16Tgk4EKMo8OO2Gry2yrdGPwW/IlKaEs2RmeFyCPhjKdKPVJBH
X-Gm-Gg: ATEYQzwXe0TWdEPKgafdkWgucfXuZH18LkUJtufo++2DVak2ZPNhZJr6bZyNGdbK325
	y3Q+f0uW8MijmirlUlo6+MET+4ekYYcMlXq63tXw8DHtTcvIDpgKLD7Ue2CmBxH/+TXm6NQvRoe
	tsnL0ED1yUi8Ns0u6mJxwzhfexyl8ftZ+Ob2JaZ2g4djwJUSrGkGO055iU1TBI8B5WiDpdTcO/Y
	4xmJchodK6OlOnK6pKpqoxQFoueV2aqR7XOZtJgRXpRl3OWQ60VkKe1OpvlY1tsfHOaCn2r6A5d
	KIqRxlF9fEyUQhmxRoTWVlkoOZeg7OoPRvoXvS+PI9qIhY8jzhuv28v03YQHyXpfUPoX3zjiGRR
	MwKu2S4EpQ7yZe89/hQGplRiKbDPwv9dJeDymhOIMAGBWgmJTmUMVpD0QCjnx1prOu5dB+waKbP
	hgfhssLV3vZxdkV+mdqIxzMKFq45cCam91lA3Bv3mw21NUPwMh1dcSa6mMvtyPGKNYEYmxuBbhP
	WrnwgP9jXW0Jxny
X-Received: by 2002:a05:600c:a09:b0:485:3f72:324d with SMTP id 5b1f17b1804b1-485566ddac0mr61603735e9.14.1773412187998;
        Fri, 13 Mar 2026 07:29:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm571853415e9.2.2026.03.13.07.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 07:29:47 -0700 (PDT)
Message-ID: <953b5842-a4ae-40f6-8cae-c4f81239c903@gmail.com>
Date: Fri, 13 Mar 2026 14:29:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.git.git.1773321998854.gitgitgadget@gmail.com>
 <xmqqeclpi00y.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqeclpi00y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2026 14:40, Junio C Hamano wrote:
> 
> Perhaps doing it this way would make it more worth doing?
> 
>   - At the beginning of branch switching, ask a new helper function
>     that takes the branch we are switching to as an argument this
>     question:
> 
>     Do any paths that are different between the current branch and
>     the branch we are switching to have local (i.e., either in the
>     index or in the working tree) change [Yes/No]?
> 
>   - When the answer is "yes", save the local changes to a new stash
>     entry, and clear the local changes from the index and from the
>     working tree.  If not, do not bother with stash at all.

Can we avoid the extra check and stash if the user passed "--autostash" 
and unpack_trees() fails because it would overwrite local changes in 
merge_working_tree()?

> If we can sell it as an improved implementation of "-m", we probably
> can lose some code that the current "-m" implementation uses to do
> its merge; we'd be instead using the "unstash" code paths.

That would be nice but I think "git checkout --recurse-submodules -m 
<branch>" currently updates submodules whereas "git stash" does not know 
how to recurse submodules.

It would be nice to teach "git stash" to recurse submodules but I don't 
think it is completly straight forward as we'd need to store the object 
id of the submodule's stash commit in the parent stash.

Thanks

Phillip

