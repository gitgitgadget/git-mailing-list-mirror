Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62E748F
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099547; cv=none; b=CZHA7X0v3aPmKd0iuhq5DURb6cilxhYxcWAO2ElSwKHkEVxe9Eg9bzHdKc0AcsD4zPxfyiCkj1CpT3InCr7ToZjQljq6EdtFp88mjnQ2UKm4SLkAw6gs9qxtdZP/NPv+bkDjsCTvIskQE+Nqv22IaksKj66sOrK3xyDh546HjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099547; c=relaxed/simple;
	bh=P/uxj4DgCm74iUe24cd2yZkGtSycF/jn7diuMiz77/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhUDps9Uk4Hwa904kR5vVuKX/BoUQZIcJjIMNTYC8v4W+w2SszGLAO+zQ+8FYeyffVnwn0fks+oQqs6MBep+K+22Fy5+9Ta7yUrJ6lisMdX44mRGVpeDD9zynlz0MeG+qD8xdXtMPI6BbkN7j32lv69nGjoElAQ5VmbCcMwAPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqM1wpAO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqM1wpAO"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e70609e042so6977171cf.1
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760099545; x=1760704345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erLg+Z5CVEhl5GOqXYYKe1WG1SexRem3EUi0qO4uHb8=;
        b=eqM1wpAOOYVKreXHNhxYjOwHtneVZFUz+GWqTIcrq5pUJewfdrtYfkvcluYTYceE+A
         fVzXVMnRU1YDhahkKCzv8rtPOBK6Y2IMxbpS+oNYGtWkah7mYHfyKTd4cJedP+WioLUK
         yPzIsM5TxeS0y/Jj9EldCPLw97nSeBB/zTqKa8TR+Kav+1QocDRdVbf8xC4+FUetm0e8
         NheCKzLqqOVqTK3o0mw3Si7YOhE/c0OjLlGzXnc95hEsWvqasWAUmiGbZBUVBW8syH+k
         8azKm3IzFFuCtpd2+Z30oLMvNQ2NSLFWtlMwO6Y0cxTDOyxGleh/kl15n/RTf5vKlh34
         YuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760099545; x=1760704345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erLg+Z5CVEhl5GOqXYYKe1WG1SexRem3EUi0qO4uHb8=;
        b=NT0VTD0edvIyfllhRW0sPuPysHCtaF6G8oITBDisoq7XZStykaRPPR61WbE/D7ydli
         OvZsGhorNDWl1EtQGpBYeRoVgi3TG9NAW9zVugV/FYbuA7g0bjbtMCH8fHHi/5VYqXgS
         yjGmcR1yheFKN7DBPXydgZRdCRqoAIM/gEjBcte2BkrNiSaHUjnlAVXVhdc9lS4fuE7+
         LBhtf91L57HzgdfAC7NpsAznWZcKTknCLhGrgEfoWxvh3M4uXa+ZLOqWDpLEsXe6okjc
         5egdQW9XhTQolU6Q2bjEeLxWokArOivyr3lbI3ZwaWF5MfIDZfZcugGLbeck5RHZwLFk
         FLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKN+vVYdCqxhkAcJrA4dvrf58NRNoEO8FB4yloN2E4fpc6h9q7YG5zpWbWq8MJW8+1wdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOxzl/fDemQSutwH5tG12+x6De1xHSw4WQwDGvFdfsT42QRve
	3ZVqEMPvPdQuSa3wsfcqr7bSjfx4SrSW7xwGiQTdsuc1S1R9yUeKCSt0
X-Gm-Gg: ASbGnctc2IXAgmy5x4VXWIHhMpI5QXGe6TAnAOeCzfW1K7TQ8EcqDlkG26qVlXVrG9M
	DGRzMmPKBfL7w8BTCmF8ebaGLAYOdG9MDUA8iwiga/l96/tqbITtjO5bX6dkInyaZRjzvc6/Dmd
	LBHYcD4UBKiw9f6pFEoMHXBf02lGn/JZLGX7lqffoBgQtmB4O1YwGJinxXlj7WZ8AU5JQQOmc4r
	2fSJBLKAGUdGQZkYn+4V7MY7dq4kppny7FOh+BQSBC7zDLlACKo2fuPzc4C5Rb/hv0KgMBJbyAm
	Qe95hD2unTh3BTPofZMuviICAHhGmsUHcDPjSEah5hc6QAjYnet1rxH0La9ByqV+qUcTi+pR/jl
	tcIu5VWKgjMokfrbsK1slHMP4mAEvJNYAqvfm6M9kpnCcTbk/wEGeKv84NjStdiFOd3HePb7/n8
	TrqhqtkBCWvGw=
X-Google-Smtp-Source: AGHT+IFK6R/rslZKUQNHnWBYJ3Sam9RUkbIM+Oo1ptzyzlLZRyS03b0MAc0qMVpneB+D55UPMPVw0Q==
X-Received: by 2002:a05:622a:89:b0:4cf:c058:96f8 with SMTP id d75a77b69052e-4e6ead83c54mr154575211cf.75.1760099544469;
        Fri, 10 Oct 2025 05:32:24 -0700 (PDT)
Received: from [192.168.1.109] ([136.56.76.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc359377asm15151616d6.48.2025.10.10.05.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 05:32:23 -0700 (PDT)
Message-ID: <80ab806c-1a53-408b-9120-cae4faae0491@gmail.com>
Date: Fri, 10 Oct 2025 08:32:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit-graph: add new config for changed-paths &
 recommend it in scalar
To: Emily Yang via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, me@ttaylorr.com, ps@pks.im, newren@gmail.com,
 Emily Yang <emilyyang.git@gmail.com>
References: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2025 5:01 PM, Emily Yang via GitGitGadget wrote:
> From: Emily Yang <emilyyang.git@gmail.com>
>     Hello,
>     
>     I'm Emily and I'm interested in contributing to Git. This is my first
>     contribution to Git, super excited!
>     
>     I'm from Microsoft and spend most of my time working in the Office
>     MonoRepo (OMR, one of the largest repos in the world). Recently I've
>     been working with Derrick Stolee on Git performance related topics. We'd
>     love to propose a small enhancement on the existing changed-paths Bloom
>     filters feature to benefit large repos like OMR. Please kindly review
>     the code and provide your feedback!

Congratulations on your first Git submission, Emily!

For the rest on the list, Emily and I work together in support of engineering
systems at Microsoft, and her team is particularly interested in Git
performance for the Office monorepo. This first patch is hopefully one of
many to follow as we build up more people with the right expertise to make
changes to Git, especially at our boundaries of scale.

I've already done a "pre-review" of this patch as part of mentoring Emily in
her journey to Git contribution.

Thanks,
-Stolee
