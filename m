Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C73D6CD4
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553225; cv=none; b=GcMTkfuBik2Z1UPIJ3bRc5AxxlqW7dpuJvkaAvHpWz0nnq7+VWoyYrdeBeZwMaJWOocj5tGWb0GcOu8hTJR895U14uEQE1ZcucM63/m3JCSJXXaGMhhX/KOt+pGBPrRA7IZl1uTOAn8Cq7qYfs+VelbmjAWyER5sQwXWc58dlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553225; c=relaxed/simple;
	bh=OJEiRqKhEJ8b8ceqUITo1FlLM5SCb3D2PmwsL1TlnZA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V0Fc3XoGSdLY8kMMTL0lGUurk7dj+2g6ab4G+ROcseYZFrDFHp/xdKdFOcK2gc/iiq2qlrmwhYlDwrXhDEyhpd2Z7OOVpgX8ulErVGwm04z3Vr/ZBQw7CpXzOpn8VeA5AOfVyz+m8dBztcdt27VGZ6yzfUNyXz5tELiqLQ07Emc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuFOIJc6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuFOIJc6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso10879235e9.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791553222; x=1792158022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Q6cGKOCtoHMFJ78xtqEYfn+Sor6KLkLgTuvC8jSUSY=;
        b=SuFOIJc6Q4VCkcSxGiRbJPDSWalkZ+fsrEFIoTlqE4q6HEzsTMgC6yEE4Hv/IR8hFB
         K+RZtR0avPO/WhSLM/mAqRsAAqExrvLpOUobm6DzbmpPKWoa/2NjMpr548Tvmg4zwxN6
         TVNIcpzWY7rcxx58jfuMQZWbNRmNJ0SLiGGDlxSMJauUKhfdx99hyBEG4hjrcse4Ho66
         VlJ6YwspKgRXEEh/PdWyzXhf3fQDSGyNCqwxI2q3uAi4cn/vOoyt0HLjTi2MrWCBoC4n
         kRq5N/dp7S7gzZRu8yNwQufcJ0PbYnshBxwTIm5bXT5zz06pown2ubdLo2fZaKxn5TgI
         MY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553222; x=1792158022;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Q6cGKOCtoHMFJ78xtqEYfn+Sor6KLkLgTuvC8jSUSY=;
        b=fYoWL/NZALqpGZkDLIjCHhUm+KTNo3+kB+8MeHsv4q4OEn8/fD6T9P7OdKVkYBg2Fb
         1/+QBd4uQcNZFqLuUTl8qq8Wqe7PCK2bDxxJqN1IVnKfvXsKRk6J1qouPTjd5u/XZkeD
         uTD0k7ABT5v1Ye8OzksH3XS+/12JjSuwGezQ0m3KiOk0kxeoRkVG+r/pEQoxi8/dSUEM
         2wuGlgb1sA9U9QGEGlES2bmPaYl3oI/L6QWZ1lgY7/0USY1HTjEF4q9lxJWW++y+OjJy
         Mc2c25hrUl9F1x8DKvYFRMgjGoZx+XWEt49Y7dwu+Uwd6CtfAEkfGfTFqrci+oKM89ye
         7+mg==
X-Forwarded-Encrypted: i=1; AKwUvBzmagpjT9GKwgWvFPzUi6TOUPgHZxkcaEPeXWQXgSfWweM8Skkh9iMIV1UF3zE/T0f5cj8=@vger.kernel.org
X-Gm-Message-State: AFuF++m6f8VQqwNScSlZSp/PAn7WgIeNSynrckbZ1lrIMEQZup3Sy7Hm
	C7dmZaX3Otu8RY+B5wvrpKdRJ7LsL/epnXmz1K74r3ZB37LfDUwZqtHH
X-Gm-Gg: AYBFou3FZ1fXljXsJgaQ1RIR6hhngjfmbMDOR2NobsXC+j/ZEmzwfaooiL9KqQuTdjI
	L452KLMzWzeXn6/0C9XbZcsmHCcJb83w8VsleATCXl3OjrLgzGbqOdhydB7mJjPyrgf6whRCab7
	NnUrHsejuXr3nboiY8mYR4BfRx3tpd/ekZAIOPM2toSBLM6+KlJMikWCGLkuZAWwE9DN0yjWZj1
	rHeY3xHws8hGvlMZzeeGU9tbgtJvUmhslxEIg8p9LeVKGmFJmudwWvgA8AIfdMTe1VvT3GFj8P2
	aexoyfMH55LBVpfXH9oZ9P3ZjxEJttoGtAmVjsvHAwo29/p/kVHgjsdRTTWWRPqN+ahv4Wuw8cy
	0Hs2ceWXP50ZElU/0qzGXXwQXzXAkftfKqoJPWeKLmIsu0oeNGknG2L9b28qKUsS8C8MjZNbBoa
	aCOeTG2n5ioanFEYmdYzqXAsgK1/AgxWsa7BlHMsmgU4Muj8a93ycTbPZnatdeUFKOLZxRhH1Z7
	Owja3BMYllRPh+MKzDD2t1dQ6zW8rS5CJlE823NmbskExwrMKIq
X-Received: by 2002:a05:600c:3e0b:b0:49f:fbad:29ae with SMTP id 5b1f17b1804b1-4a18e4b1311mr37041655e9.17.1791553221783;
        Fri, 09 Oct 2026 06:40:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm96287355e9.9.2026.10.09.06.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 06:40:21 -0700 (PDT)
Message-ID: <8f0ec8ae-5622-4d07-a4cc-753cf7e64982@gmail.com>
Date: Fri, 9 Oct 2026 14:40:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
 <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com>
 <CAHwyqnVoMnO_fYGJ0N29bQv=Lh5naZ0jc5uSpiS2urQMZVG5-Q@mail.gmail.com>
 <61ae371a-225c-4400-b878-8547547d1269@gmail.com>
 <CAHwyqnWkTvicU+U99j0MzzUUXeVnUj=FJJwUDR1F7DGk1hmtrA@mail.gmail.com>
 <CAHwyqnWmXM0fEn2X9p7g3fpzmXhfAJAqAj9SG0=6kOpunqfVUg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnWmXM0fEn2X9p7g3fpzmXhfAJAqAj9SG0=6kOpunqfVUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/10/2026 12:18, Harald Nordgren wrote:
> Interesting to note is that merged branches inside our repo change
> when Junio signs off on them. So without this functionality they are
> not cleaned either.
That's true for a patched based workflow like the one on this list 
whether or not the maintainer signs off the commits. It is slightly 
different from the squash merge case because you need to look for the 
individual commits upstream, rather than the combined changes from the 
branch.

Thanks

Phillip
