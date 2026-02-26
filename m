Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585C439000
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141219; cv=none; b=a/nHgHseXz11XqHZjtZqNdWBvP1Ci3VKJD9zScjQDVyeDynDmllI5WWKgQHFEY2n9i6d1G6PUtwD0wzdLMZlARI7i30SCx4lG825oQ/JlNJmqoyCnFB3oqkyqrbF8EMAK44xF892A5rlOKVVsPU1WstKXHqRHpp06e0JX93Ba88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141219; c=relaxed/simple;
	bh=JVszMwQnaHb7+lpx0Ii2IZt6NEtPwPwdubDTr/mneME=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nKZtH5rjbwfMwbKILpPX72i55bm1Mi7SwOwHIASQBsVVKhPReZAoAzs22fov1SSWrreda/X99/Ol8z2NriVjfQMelIWD08+6/zlqJn3ebp+sKWwscSdHt9nTl0FIE13N+Z9h5ZsN/KnnbIbBAs6e8/LM+aPBRHRz8PrOyKZ7uEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVGVZ8pT; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVGVZ8pT"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5674cd243d9so1872568e0c.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772141217; x=1772746017; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49LcLc/bX+hR4QybT+NWUEjQooVKzdWxwae9Ao1AKi4=;
        b=MVGVZ8pT4F4wfaDUeyT6flz6STjWPoT95Lym4nCrOdpwn+dNpzvmqsd7CdHNLWOcx+
         WtM4PPWFRxfKt8mwlhOpeKOMeZqFRLuYPG70MSBHjz4XK4UjRVnp2ckSCIGU7g/LrO1O
         wQhDYneTqREaBqkLODciiPp7+frTEydFOkwSjB+1/1YegfHSAXWquRJvPgkd3fDVp8qH
         4GqkLM6WyrWccwmd16PSglNLdn6nia2QAWAH5JHmk2WXxX8DxdtlpmIHfgPhSL5VnbWR
         eS/s7arGRtv+PtgetpiO1oepWDMZQHROM2UwY6E6K3E5NelEntdtR4XkVKa5NaQZCkux
         FcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772141217; x=1772746017;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49LcLc/bX+hR4QybT+NWUEjQooVKzdWxwae9Ao1AKi4=;
        b=IMRImUKMyZ8f9qv8eYz2XLYUAzuITLHrpf8wcklDn+BTI65496lPGI9DRNfv+cj0XT
         uF8JIym9FWbiKubaJcpT5TCE+2RQoNR6tpqJJjSd+Yj3LiENKdb4kScRQlH8kgfiPT8s
         1/8tr1LRnAUNYYGbmTlSOfPYXzE23t3ev5e+WRmIzgWzdi4G53HoaoPHBDoVU3AwkFIg
         M7CunWZlVsV5+lZTcdfmknT1tpCe8DUqzM8FSGMJP9jisvjsTIbMV+cXRge1ucbSincW
         8ZmfZjLCrocDeEToWUW3NF+dzoXNjb8SDt+Vn7AncaWG/zXR2it+EVrJPKtSVaqmmSDo
         P/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgS18NXrn7Jx8/WbRNSO7+vR9+WZA16fs50abBsNMYjWe2wCH/2UhO7lgNveu/h3OIX6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63kMgisbQwOVqrXwU6VZgucRy6gvnRo74UaDxjOmVzZZhRlk2
	CG5NIEF0dd2yoJfU0xRuuCKvr+usElJHPotQ96Pboe32eEpgTnKOVWa1
X-Gm-Gg: ATEYQzwQR10CrAxLsv/IM6TSSRKganQJqYBYmNaf3viK1XnxcjgnOIWR/vIbFkgiA63
	85Nlc+60DRZnrO9uTf6/bnJDCtObV0YxiUOLg+tkDjli1378OzdZbhFhvE32M5B11SPsGh01+P1
	TtYJ+e6KBa7OwpJVcwqnd1KcUVRo9EHlBxt1UnOa2J9K2DkuU7lKCjEpCqKUHnpsM+MQw7WQAu9
	yLRw7Oshg8hzhMuzFXCNI5NBqPd25pNuWX7e2zbNnb9f8McHoatHsOy/yZJTGFceU506QPLp9RQ
	p1WL2TokiZW83ovwEjPkIL5gnslkkD431nlO+DJCt8nL1vOJV9J9b1BhsfrwKalVogrCDKsN/lH
	OEjwOjhvpmtqni/dxd4uTZG5RTHodw4e+GAcvoilRxY0UAycNr+mwvxHPxHCvJGm2wU/zYwSAX6
	ITY9d7paXUSACcxRuDzjD39R9nlvttPmojNgXkkFJPH5CpCsadINovaNmH9YrlJsKs
X-Received: by 2002:a05:6102:440e:b0:5ef:b32c:dff8 with SMTP id ada2fe7eead31-5ff1cda8e40mr2293563137.5.1772141217005;
        Thu, 26 Feb 2026 13:26:57 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df6437c19sm2881800241.6.2026.02.26.13.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 13:26:56 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [GSOC RFC PATCH] builtin/repo: add path.in-worktree field
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260226201643.5152-1-valusoutrik@gmail.com>
Date: Thu, 26 Feb 2026 18:26:41 -0300
Cc: ayu.chandekar@gmail.com,
 christian.couder@gmail.com,
 git@vger.kernel.org,
 jltobler@gmail.com,
 karthik.188@gmail.com,
 siddharthasthana31@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <BEE3B56B-F8E0-43B5-95EA-8506A84CB2EA@gmail.com>
References: <05C28DD8-251A-4990-BBB2-26C144CAD982@gmail.com>
 <20260226201643.5152-1-valusoutrik@gmail.com>
To: SoutrikDas <valusoutrik@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> I see. Very well, I was searching for something small enough to count
> as a microproject. If I may ask, can you give some directions ?

I don't think this is small enough to count as a microproject. A
microproject is something simpler than that. See the microprojects
page [1] for suggestions. They are more straightforward things that
have more chances of being accepted quickly. And since having an accepted
microproject is a mandatory step, you'll probably want it to be merged
as soon as possible.

> I though about doing the group key thing : 
> 
>> Use the category as key (e.g., git repo info layout would return all 
>> layout-related values)
> 
> But its already on the SoC 2026 Ideas , and I dont know if I should do
> it.

I think that this seems to be easy to do, but the reviewing process
may take some time, so it would be better if you stick to a
one of the selected microprojects [1].

>> Something that I would question here if isn't it possible to make
>> is_inside_work_tree accept a repository as parameter and then use it
>> here.
> 
> Like change the function in setup.c ? wouldnt that break every call of 
> is_inside_work_tree ?

Yeah, but then we would need to change all the calls to it, using
the_repository at first. But I really don't know, I'll leave this
discussion for more experienced people.

> Yeah ... I missed that. Suppose we were adding this path.is-in-worktree
> to repo.c , then would the below test be sufficient ? 
> 1: cd .git and then checking if path.is-in-worktree is false 
> 2: cd .. and then checking if path.is-in-worktree is true

You can take a look on how `git rev-parse --is-inside-work-tree` is
being tested today and use it as a base, since
`git repo info path.is-inside-work-tree` would return true or false
in the same situations.

[1] https://git.github.io/SoC-2024-Microprojects/
