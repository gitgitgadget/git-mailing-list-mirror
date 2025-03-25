Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E61A5BB6
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942461; cv=none; b=tqYRlrJDFP352e+sObLIxi71P9WQtnRO3WccELXFoZ2zKrINuCWlvIE0BSKeQvsV3yhHKDmutWZczb82UXXx+H2iZlsGs4etcjm8bhdsO9gi5rdmmPr+tEPlTHl13YWnwU4Ojo2exd1JwvT+8zMy08CJMDrCuOaiE+n9Jyr7pXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942461; c=relaxed/simple;
	bh=YSSWPWS7XZBjtsNU0b9sFnR4U5EW+Ic8hudMxj9EklA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=bFgjLVnYOhuVsMjFOnxuEG9IpCK0WViBP3FC7hn/B184QqncwC5ZU7b46xIQjH0CRGTJcQ387W91WZVEYjjdMjKiUxGr5UinZMf/t5QNTEpfAYGs2ytv1RmcbBqLF7msSFptZ9KnbKPJ8LbfAza9xTac+ukBpCgHSu5aDG50ywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2Ujhl77; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2Ujhl77"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c56321b22cso34030085a.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742942459; x=1743547259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bmIZztea64M3cifxwqlwki9RWtDOPvzsUak5Js7BLc=;
        b=V2Ujhl77KcV7NNM8vbqJCIJHb3lIgwlt5aPnJ2hpCLAHXJ6eM7ADzA15xeVjSEGUIa
         o5iMhMvM/T44iglxMbio8kyNNAX269GV6I4RWlYPUO23C3Md1j+tNiNQR5BqybOzTuhW
         evm7xYIcAByadIyWhgy+cYibmQ5jI4KB+CG/jPGkyDiKHk9FOFOqTNv/FmQzc1u2wKsP
         CGkljfb93t5crezbBoejv5AIVamAG6DYJC0LS7XiDNrLGid/tTClUdBvwmGGM6hPyiMT
         KDWEefLAM7r5P2AVrsd/2iAAjVDUcIYPxbeaKn3U9hgV/qq+iAQH+8W69jjYZGtvF7SZ
         I8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742942459; x=1743547259;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bmIZztea64M3cifxwqlwki9RWtDOPvzsUak5Js7BLc=;
        b=WukJor2BcIcV/SA+qaiP4OYZeVW1yUv1o3QwPTf+rkZVuCTP82jD3IBsxAK71dS7fk
         zrOpeCDgQNUY3/Lg0f+kvOwOQ0Jto9r2mcZf1tvZCizy0nXFlc9Jffb5x+HqiYfJs2k0
         6OOMOzLadmSWNz0zVVO/hdbkIE6mNxVW9I41x8pbhpMaBcRhY+9KgBc8Jn6qp5q0mxj0
         NRthT656PKMH4cKx5lAm9Ikyx8nBvjm0Md9O8KBbNiaKE0Ekx83LZBBibyEEwEue1Bvz
         xoKwO5NCJzPvKx9rcrpDXwORGKGZOylcbTu9sH6IGFvsC25Zc6jIeqS5xWJlfZeOv4Ou
         TtiA==
X-Forwarded-Encrypted: i=1; AJvYcCVl4aOd0kzTEpnWcWWpQ9prx5f8z2nNCgjA7KLAUHHzP/E02H2/jY/vCixXNSyMP93IYq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJH4HB+QI4ChrjX9OOTDYEXt8Tw4JJwUF3BnzdecTfYpvRa5m
	7GNGwy1OmS7Y2ilQJQj5jaJza4GXioIvuppgxjIoBueORkwA7FJH5JgcZPJx
X-Gm-Gg: ASbGnctHVzjcdxS5Qq8abgIwjys+FFjq98QB9yJJXbtT4dxxoTOm7o2q2MVigFL6cMu
	uVo0ZPZQGNIRTEn3qv7zG/tLh4ymPh9uaTC++zQzBzWkUKUvKvLaBVa0/6oV/+SPHK7oHAkKFj6
	VY3EPDvalfL3wL7OXsXXnTmqgNbZ1zCMS2d5UbaRxNCUOpaKNyBELgaYcZ2eg0aH2VRJTdbXU79
	+lo+ZDSB89iXonxkXhbp/mXDWu0npfdvSDtKv0/gEZf1tlqflm30eu3fJObcbv0yI/1WHkxLY9j
	B2fVmyKP1DhRUHbbx6caUf55/P/Gq1MvTq9IHjMcnYSvkgPkIb/oM9nbestHuowxvSnvdEZwTSD
	WXcSBZ/mEEiL1yl8Jah+Fsw==
X-Google-Smtp-Source: AGHT+IE+fYDa2pn9QsJeUMImxEXVd99lepabhbcnwy8VRh05vmBDGZ9K6vLslUsI/GjFRSHMNYvaGQ==
X-Received: by 2002:a05:620a:6884:b0:7c5:d71c:6a47 with SMTP id af79cd13be357-7c5e48e6a55mr262715585a.8.1742942458838;
        Tue, 25 Mar 2025 15:40:58 -0700 (PDT)
Received: from [192.168.1.174] (c-73-143-206-114.hsd1.ma.comcast.net. [73.143.206.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b935820asm689889185a.94.2025.03.25.15.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:40:58 -0700 (PDT)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <66e39a95-09a3-44dc-ac71-a6c02b5949c9@gmail.com>
Date: Tue, 25 Mar 2025 18:40:56 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Nikolay.Shustov@gmail.com
Subject: Re: [Question] Moving from Python2 to Python3
To: rsbecker@nexbridge.com, git@vger.kernel.org
References: <022b01db9d99$e68785c0$b3969140$@nexbridge.com>
 <Z-MgpuxFQ3xEgvsU@tapette.crustytoothpaste.net>
Content-Language: en-US
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
In-Reply-To: <Z-MgpuxFQ3xEgvsU@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

git-p4 is designed to work both with Python 2 and Python 3.

However, changing just PYTHONPATH may not to be good enough.

In general, it is necessary to make having PYTHONPATH value and the 
version of Python executable which application is run by, to be 
coherent: Python executable has to be able to work correctly with the 
libraries PYTHONPATH points to.

How to achieve it - depends on the OS where git-p4 is run.

If used from *nix like shells, git-p4 would be using Python executable 
from the shebang in the beginning of the file: #!/usr/bin/python .
On Windows, it is possible that the specific Python executable could be 
associated with .py files so that shebang maybe not in play at all.

Some OSes may require manual adjustments such as setting PYTHONPATH 
shell profile (environment variables, for Windows) and ensuring proper 
Python executable will be put in PATH. Some (Linux) may use 
update-alternatives commands to switch between Python (and other 
applications) versions easier. If it is desired to keep default Python 
of one version and run git-p4 with another, more tweaks/hackery may be 
needed.

I would recommend to refer to the documentation on the specific OS and 
also look for hints in Python related online documentation/forums.

On 3/25/25 17:31, brian m. carlson wrote:
> On 2025-03-25 at 15:23:40, rsbecker@nexbridge.com wrote:
>> Hi Git Team,
>>
>> I have Python2 and Python3 on my system. We are deprecating Python2 ASAP. Is
>> there an easy way to force git
>> to use Python3 only? Both are in /usr/bin. python has a symbolic link to
>> python2 right now, but we are probably
>> going to change that. I already have modified settings in config.mak.uname
>> PYTHON_PATH = /usr/bin/python3.
> I think only git-p4 uses Python in our codebase, so changing `PYTHON_PATH`
> should be sufficient to fix it.  As far as I know, git-p4 currently
> supports both, so things should just work.
>
> Of course, I might be mistaken, since I don't use git-p4.
