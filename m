Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8815E5AE
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984444; cv=none; b=toY/NNG3IXVxI43Nes2CzuBFh4t4qFpDa3ZQfpZ6kFiy3QWNCGSiXjTG8L+igA8/b19RlNTdP8VuIwbFXhgVwuj4NdJl8R7cfR/cTexD+Kp+40aIqYGqjWCJOWkLPe9BcbCMP+RDxE6iC3qNnl31VfBKzPavSn15QitLqNGONn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984444; c=relaxed/simple;
	bh=T5+Mq0mW3ISDLVt7Rp8lSQrRtFm5EHz8j4Cw4s/CKmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=piDg+1ogD3ehxDnRRBc+rz0CP8iumN45krJd4x9vM9PwgFvFGlMLecZ1bbf3hC2kfx5RihYqsBBQpmIuc7ht8eE6bK1TzRjtzyGBkiFhr/7u6wtd0BAZLFoDlheMF8FzOVgX11xPjyTWv+d990et7BSK/ETk1M5KC47aW/ytKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdyG9nuG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdyG9nuG"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39ac56756f6so2468040f8f.2
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 03:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742984441; x=1743589241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aUezLDVxZsIP9Ylio12IDr44vNch8U9VUhgP0LSLXDo=;
        b=UdyG9nuGBUkpml2v3WfyFoJg6p9DRunhv5tfaUbhxe9lTRhysrzoWPw2uYNniAQ2d4
         mOKOCeYXAZ1/qfKcgaZwQ2YDnKkSCzJpr3ci+W95iarLOZnBzJYbl7yn+tt/CfGtM2Bk
         Z/Z7v/1fQm7gypqG9bXaoTf/obF/7+YwT2RZIYrh+HnHFA5DJfzE2sok4prbJtmVt5oU
         g/69szB+nSlmiVYAY16NKNxZJldOOnxxUpHwbwBYfUv9M9JprSrOMk4YKhdebiU911n5
         IY8YenB/XQ5EfKmFzKrhNMf/68PbDQm/p7hiRIt971edY8p3eWzTxAAoOh2loKOMVSdr
         pohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742984441; x=1743589241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUezLDVxZsIP9Ylio12IDr44vNch8U9VUhgP0LSLXDo=;
        b=J+ajjxO+LeTLcujSxwMFc2qM+Cz1tPOWWKFrfeLq7giLA+12xD1/urIeACyhmA/7sE
         N8H6bj3wpKZyjR9BvO0ZHYidb4j83tUl63B8rnpbpc7q+YLVxyQ8TKYTuAo4rm8loolS
         +QSBMWd4H3M3fcZISvoWOQ7BSWjfT735b+pXhiHg7kmRPKveOMSneESQDWAls3xBKHn2
         +LiD733pKhXkPeqegzTutMQwQ4iOEMFG7mDqZghXkaDYhRnrRnM+H0x3eF3wWnP0/Inr
         NxWFCVgceX8xoz4ky0cmUrD9x4oK5Fl1nG/3rdBhj/mjuwA7mEOuMH7U2OKh7TByTjin
         gNJg==
X-Forwarded-Encrypted: i=1; AJvYcCX85ZdHfjTuLevj6AE+eAzYCza1JjW3yZiexeQgb4y+ev/hp7g+f384EzfxLTPFyUxO/e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPq4ODtBBS7jznNVFH3tTDplWh/faWcNFXXMU1T87YqvkhXxsv
	H1+vpGTqJ0q5qRnuWK14D44i/aCBMo0CCXGoJCCyLBCpY/PQ6fOq
X-Gm-Gg: ASbGncuV0ynhzz3uRV7y2+siOxHqYd/xy6S2AVYS6dGG6FEX1xNHmNZj0nPrg2TvFwd
	+oHeF5W+6vFjFu8ETdg2pBcwuA/Cm/xzKm/p8jR+Su9ME4eZpa5FNeeVJzrjCmHM3EjsO0R43os
	xbg/Dj5MCkrrqpCT/JRYqvhlLVZ60qSCQrTtXthAVMLJDThDCHCEwTS140Jabdihpm7WznGFU09
	Mrvuk7NF3TkNlS8i8dfMcSgFvpzNr3gIpiqFiFf+uvbBI0fXwr3THqg7CzOZFIbDwcB9YlWGkEg
	UaJ5rDI78LWS7Mdlhz3rbYcme8304RDNL34Ua2a36emL7ti8OmGgPhVC/fsoasn5KLhQFPDVidU
	bTGZaF2vkQnzJ8saM7HNH
X-Google-Smtp-Source: AGHT+IGSVuVPNHK0N6eI4TuHRK5IA7fTb9Icg8Iph25Fy3v1yrUZSEB85plDtFMAMC365iWp0SCfXw==
X-Received: by 2002:a05:6000:4108:b0:38c:3f12:64be with SMTP id ffacd0b85a97d-3997f9366c7mr18817835f8f.35.1742984441077;
        Wed, 26 Mar 2025 03:20:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb0669sm176549005e9.34.2025.03.26.03.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 03:20:40 -0700 (PDT)
Message-ID: <3b09226a-8281-4560-aa23-74aeaa3ff41a@gmail.com>
Date: Wed, 26 Mar 2025 10:20:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: error: could not parse 'Drop' when rebasing
To: Jarno Suni <jarno.ilari.suni@gmail.com>, git@vger.kernel.org
References: <CAOqj8L0hknJ2aYGSmXdUvRgzHZRWBTMgSvywGpc=TUZL-Dqnmw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAOqj8L0hknJ2aYGSmXdUvRgzHZRWBTMgSvywGpc=TUZL-Dqnmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jarno

On 26/03/2025 07:17, Jarno Suni wrote:
> git version 2.43.0
> 
> $ git rebase --edit-todo
> error: could not parse 'Drop'
> error: invalid line 1: r Drop option --figure-soname-bumps

It appears that the object id for the commit got deleted when the 
command was changed from "pick" to "reword" and so git does not know 
which commit this line is referring to. The commit subject is there for 
the benefit of the user not for git - after all many commits could share 
the same subject.

Best Wishes

Phillip
  > error: could not parse 'Drop'
> error: invalid line 1: p Drop option --figure-soname-bumps
> You can fix this with 'git rebase --edit-todo' and then run 'git
> rebase --continue'.
> Or you can abort the rebase with 'git rebase --abort'.
> 
> "Drop option --figure-soname-bumps" is the commit message.
> Git doesn't seem to accept any command for the commit. First I tried command d.
> 
> Workaround:
> I did `git rebase --abort`. Started new rebase, used r command for the
> commit to rename it to not have "Drop" as first word. After that I can
> rebase again and use d command for the commit.
> 

