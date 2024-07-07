Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A638DE8
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720364695; cv=none; b=G2/N6WXyg4Ol0sXrBPRZJLZ+kGWvQLyzr+0ftfDCiub7adYb3sm5u4hT6BrGO6RloFZjXuzatEvpi34xRvXgK9hPhueiQjwKgqBXD1V4wInSkjxdxjD6bR5nJHkjCANslCU6xcpzEopvAZxG9Kw7s07puvqaWNs5kB5mMVBhxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720364695; c=relaxed/simple;
	bh=Xzw4IYB9D+hUoiREtcnEW6OutuER/DH0lmFY7HCW8eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBe3vKOcmkowkTiMy2J6Edm8Vhghiq8bQBOfs6g4/U/OEQ8eHCcvg9U5WYmvP3CuXfPYDilYuUiQ6pzkW+UOfnd52LKDXdQOvaVbTCFbs7fyS4sezJYZCUdCrKaV4p5C6PS2qhEBZGcrmOKxMAQJ/XJQY9AmiQTbeO3UM9HzbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSoJFqBT; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSoJFqBT"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7036daa0704so13596a34.3
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720364692; x=1720969492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19GfXQ4gCSpV5JWwULkcpnq78IfaiOil9XAtPHvwLyg=;
        b=bSoJFqBTCEBw2ccgm+uzdppifurkp4B8kzu6u/02gVEU9g5/0a2kY6WcWYRe/4A0Zj
         8XG5cZse319xHJkXDJ21FKU6SRnbJAfLFCU2F8q5tsNqJ42Dxvf72CBX5uMPJnAU1vwp
         R1rXo2UQM/kFnvA+p6g3cW6cUYekeB1pkrtYqBBLaikAqNYLak3eQWdgJAV6V1vfOQLi
         OqhXOIuCnNCnS3h2R06n3vCcSn7XANo4lyd1VcyLrCWYaHkAfyo/iEZGVTfdENT7cwDa
         vhJ8C2Y9Jf0wTnx7LA6uxkaSOzKgooTVs63jguZi8+uKxIN9PArmwgP/Xf8lMegIBEO4
         9VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720364692; x=1720969492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19GfXQ4gCSpV5JWwULkcpnq78IfaiOil9XAtPHvwLyg=;
        b=ajh7WUcO7Aqq/l+PGWU7YdyR8Hc4b8F2GsQA2OUxTdHsm55a6XV0vqVHdm3+uUI+9i
         yMn/BPswfw3ZL4Arr3kcp5dkSMbf2sba40JhMH5E3tdbw6V3XYWRUnKpbXcVMOr3i83L
         JWkwUgqtFDAYeDIY4qo38BCZyaNEfcSVkbtf/YEWw2ZVfpmkNSdBx3Zn1i1N4ZTRg06x
         ktDWTxHLjXR0FSeYpj5A04FlZ1B3YZ9ZpdAWApL0l7NUxSGS4lWkBI3oxKDnC7v5N+JD
         2NepSv0LlLy+mDSqoXGR7O9Hkaoo5Exm5O7xCabkE5sese7nwjXVnhsewse374dRTnF+
         a84A==
X-Forwarded-Encrypted: i=1; AJvYcCWP4MpL6O+X9eGWsyAebWw8EfyEv8i+5chovhW709uGfYcTWO9x91VjDEJiF2agxIvy9hhkxfbZyJyppzGHDa8bhsNo
X-Gm-Message-State: AOJu0Yw7hd+POBm1IjiGQPiiSpviW3JK7dQiBzVmwhyj8WGEk6IX43YW
	ztGP6eJIu39r4TtDx/shRkRCjWcGPCrR/8WosBaO/TasynQCePtZ
X-Google-Smtp-Source: AGHT+IFFLwxVl414au8wv99D0JGMks/VT4ajP8CATyTDkTY7UvL47fYRYadw54BgxzcMi8vQNcP+Nw==
X-Received: by 2002:a05:6358:988e:b0:1a6:1ed1:2366 with SMTP id e5c5f4694b2df-1aa98c244b0mr941061355d.16.1720364692460;
        Sun, 07 Jul 2024 08:04:52 -0700 (PDT)
Received: from [192.168.208.37] ([106.51.25.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-75daf9b7da5sm5571400a12.85.2024.07.07.08.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 08:04:51 -0700 (PDT)
Message-ID: <12ce5c39-a7c5-4abd-a558-a789bde4de22@gmail.com>
Date: Sun, 7 Jul 2024 20:34:46 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC] Blog: move and improve reftable tests in the unit testing
 framework
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder
 <chriscool@tuxfamily.org>, git@vger.kernel.org
References: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
 <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com>
 <CA+J6zkRzM33MbMr4-U56M1SFLykx029+SzEeo8vBicBd9Xs8RQ@mail.gmail.com>
 <CA+J6zkSFCUYLRTRE0Gwug4-fF9f9-YbfRz_atArmMLLCtQDr1g@mail.gmail.com>
 <CA+J6zkSxcogPXdAdr7VL0B3MnQxQNYwOT5Kw2iK_YfPLW7CMcg@mail.gmail.com>
 <CA+J6zkTyVDJcOoZC-thRAOYNudVWB1wgye0Ezj3o1AO_5HOS6A@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CA+J6zkTyVDJcOoZC-thRAOYNudVWB1wgye0Ezj3o1AO_5HOS6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chandra,

On 7 July 2024 12:45:53 pm IST, Chandra Pratap 
<chandrapratap3519@gmail.com> wrote:>Hello everyone, here is my blog 
post for the sixth week of GSoC's
 >official Coding period:
 >https://chand-ra.github.io/2024/07/07/Coding-Period-Week-6.html
Thank you for consistently writing up these blog posts!

It gives a good overview of the progress of your GSoC project. That 
said, it would be even more helpful and interesting if you could also 
elaborate on the technical aspects in your blog. For instance, you mention:

 > I did face some roadblocks but was able to get over them due to the
 > experience I accumulated from the work I performed in the last few 
weeks.

You could possibly elaborate on what the challenge was and how you
tackled the same.

To add to this, Patrick gave a helpful overview elsewhere on what could 
be covered in these blogs. I'm sharing it here just in case:

 > The intent of the blog posts is to document what you have been doing
 > in the past week. So questions like the following:
 >
 >  - Did you learn something new?
 >  - Did you read through particular parts of Git?
 >  - Do you have questions and/or blockers that keep you from advancing?
 >  - Did you manage to remove any blockers that you had before?
 >  - Did you make progress on the implementation?
 >
 > Communication is of huge importance in GSoC as it helps the mentors,
 > but also others to evaluate your progress overall. It helps us to find
 > out early in case there's anything that you need help with and makes sure
 > that you're on track overall. Overall, it ensures that you get the help
 > that you need to make the project go as smooth as possible.You may want
 > to search through the Git mailing list. Past students in GSoC always
 > announced their new blog posts to the community, so you should be able
 > to find some inspiration when reading through their blogs 
:slightly_smiling_face:

Hope that helps!

--
Sivaraam

PS: I hope Patrick will excuse me for posting this here without his 
consent :-)
