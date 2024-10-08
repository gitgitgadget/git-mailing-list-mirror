Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF7E1E498
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396700; cv=none; b=VJnnOUhzq+9WcqCLyDDGrtQsFDlyDR+D64uK9uYIDN3GsONf4r76Z1Cm4CJWrj6hCnqn84kAUEDFo2a9NJ5oGOTB9GhXf86oARE7SUK3UUUBTjb6rSg/+Yj7p5//ALDx4ezaAbcswsXysRt78GQ0FIV0Kk0TG90D5Zriqsg2nIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396700; c=relaxed/simple;
	bh=5oY+8AQSOj5PCMDoh89iQIWRLXuL637HJlvifF6jRYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLhY99rgvnahBS2hd2EFQX5J4C6kwY4FuZfzC0d/TovbxBftH5i1HTKl+WYfbdFAnHV7mjD17vXI9n+FWy5jORMsEwHIqbCXD/z0dmxqeEHIwg/qmfK63zyh0ogLIesN+nhOyKDm/9A0kYnXy7TTGqmuMLFQEMeNdqdWzMKhDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxOCpy3c; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxOCpy3c"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a994ecf79e7so342288466b.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396697; x=1729001497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zap8zIe0u9c/WYCSr8UHm/PLH2KBYdqtkyVWigInMb0=;
        b=HxOCpy3cFGM/YL6eK35j1Ah/VjWUN5Z3Ax6aXk8+oJj7bcsfeQzeCy+1ImHMndjZmY
         giOfzxbBB3lV8rb/sjbd6f9cSOG5OHiktb8g6kZYrj4OZbYCVO1XtqeHFMAX0jjtRB7O
         Qj7IULESMSGS2EeMorWcyw+eRXtV+na7ptQMbC3IuGw6md/X1s6iTFyObl1n63WyzhJD
         X9kq/7qAeEBXw7Okgwn2yXc/jeYvd7kb4lzKK6A+MNm/HdzAu9SmQIga2FAYNC4A9RK2
         jaieQKt1hJBhNGeGpSHbQDglyuZ0uNCnBMqs+KMMopiCu+WBsEZXU2WnPTvQAYs9tjew
         k3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396697; x=1729001497;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zap8zIe0u9c/WYCSr8UHm/PLH2KBYdqtkyVWigInMb0=;
        b=CBGhFOGWX/5eBdCWTOsvusTp80TNPf4RQnEl+pOBAQOIxjm7zHJ/A3d7rsJUQqrnoR
         2wOSMuwO9uRLLMjR4+oLzoG0JMyR1p7/BXK5snzPjWSQ2v1wtyZGKV2Ri0M3gwsVkFA1
         eUVkKVfHpO0vpzfE2l9jaUaHEatesjrfpblCKV0Ij0ZNHNv9In8LNK1FdGM8fwsUQDq9
         Bca2thk96i829f5dbGOw9g5hhoAK1rE5/yc1N4dyBzfq1Y2P75ECl3MvlFq7hpHcLiwj
         eT4MRSYHvGkVoASuLjxG3vDr4Mx1LOTOhqcapTG3h98FXRwo71x7pjtOdrsA7fBhhsif
         2tYw==
X-Forwarded-Encrypted: i=1; AJvYcCWgPV5QH4ox4b1/VKSYuGSo4fvGSW+jmXG026aB0F0NEMtWsvG5FK06hHECYenvZ+XpEDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylUc9rh3iZiIF8OWCJF4xaIQw/3FIu9TCcdmY0aYIIO0fcjFlQ
	OyAFOehP0kGoEX/5cRf4rSXwb+w/6vYeo+ybBs753DoM4nd2S9Up
X-Google-Smtp-Source: AGHT+IEJEvVcBTYf25AljeGy0+Y/TbRUqm/sjGjNBqDfOPGMpdTq/G/QO7LnXzYewj6GVZ0yfwqjZg==
X-Received: by 2002:a17:907:1c9b:b0:a8c:78a5:8fb7 with SMTP id a640c23a62f3a-a991c0314acmr1798789566b.45.1728396696932;
        Tue, 08 Oct 2024 07:11:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7b1d25sm512800466b.150.2024.10.08.07.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:11:36 -0700 (PDT)
Message-ID: <76540dc2-a65b-4d8c-a577-4ff5c188c347@gmail.com>
Date: Tue, 8 Oct 2024 15:11:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 00/21] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
References: <cover.1727881164.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1727881164.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 02/10/2024 16:15, Patrick Steinhardt wrote:
> 
>    - Patches 2 to 9 fix various different bugs I have found while working
>      on many different platforms. They can likely go into the tree
>      separately, and I'm happy to split these out into a separate patch
>      series if we want to.

These all look like useful improvements in their own right, splitting 
them out would make sense to me.

>    - Patches 10 to 20 refactor parts of our preexisting build systems and
>      testing infrastructure to provide better support for out-of-tree
>      builds. While we already have CMake build instructions in our tree,
>      they do not currently have "proper" out-of-tree builds as they still
>      end up writing data into the source directory. So while these
>      patches are written with Meson in mind, they should also help CMake.
>      As a result of these patches, Meson builds and test runs are fully
>      self-contained.

Patches 14-16 and 18 look useful in their own right even if we don't 
adopt Meson. The others all look sensible in the context of supporting 
multiple build systems and might be worth doing anyway especially if 
they simplify the existing CMakeLists.txt.

I've skipped patches 1 and 21 for now, I'll have a look at those later 
in the week.

Best Wishes

Phillip

