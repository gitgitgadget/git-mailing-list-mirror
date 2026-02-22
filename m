Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6EA19539F
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771799734; cv=none; b=uCHtQxHqWm0MQEn1bvDgpwy2RUx5zq85/UCIFQoI68PzqZM5lu5ovmptbTijAR8jGyAJ6BBKjINAcBJQqhstk26LHsjp+QDjxawz1iIniD5/n8jGseFXmZmXB2yFk8cXWNKAK91syurYrb5w080rrt0+pOtj/GJvMPxusZJUSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771799734; c=relaxed/simple;
	bh=Cr96cDo3aAw1tmUpyEdes/ZzNt045654zuhwFOe+WNA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=owvZgDewSP23ZoLDXwGronbICwjax7xnbyDPz70pd8vfengPH4eEVu3DftaFgZYtBSbaorM7MpiA1hnXYeFRUijxNlASpVonhxl+jkXF1BrBLSq26AJnltsfflXEb9YYQYj+cFs9WHwR8F5Ag01muPgw1BaAom38saCJPdGFYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMeLIWzO; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMeLIWzO"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bd8097c709so2491619eec.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 14:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771799733; x=1772404533; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4fk1g4ZPFEHME1t8VLIyGFt4eXssUodF5OaDz7scxE=;
        b=kMeLIWzO2EW1d4fR8E/tPUA9/aaTekM/RG83akFXMbclWU/lT4DWy++1Wn/+wiVjOX
         EZyCXYPbrFS3GlFhqhXYrmiNxJMYR2s4BtPXyLwK1LDw7IR7yVNSAf0f3JnYU5n0mYiy
         YbnZQR6/9lYYV7bbzCIH5wW3HUdKz4IPbX8YV8H2UCMphgktCpJfpYRYFccx4X/YATZU
         XpvDnKJMGZqXqO6MceoETrMl6j9BnJO/zTe/KPjg5Q0qiIu+yMg4TgD2c0fhT7zAq6wg
         AXG7kd2Efq+8wqq0vJ++KQdbW9OJSOOyO/eRzKzjHwaw2ksC6Nu2pypHfrGflylR3SmS
         hrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771799733; x=1772404533;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4fk1g4ZPFEHME1t8VLIyGFt4eXssUodF5OaDz7scxE=;
        b=OBxrkmibfJj2tDCQQWtnPNeNaGl+6Q+QIz/aH7248KwOuQUYB2cYCZwT90eacn5t0H
         1LVKtA0qdS4La/J8LsTJC+zuPAdAVZdHsLZ7rnAtq3bEcSRe/5jVLtNapWsv7IIbBXi6
         g2tfYuhEH6MVP3FuOile+rzXuH3T5/l/1kBI3niheOWroEKFk2VpfH28g8j7EA0azCNq
         WGqPNo3r4QTXym5daeGmL9xUYv1tUg+j0N45HJmGgh5S+t1MFOZ0uWwVXjx7Btuj1iog
         L1EnEc2c7BqyXbDXumGMPqvxN6/yD76xFMqJGiHUiMOg0O2bYl/kXmvg0cpJMDfh6UIz
         NfQA==
X-Gm-Message-State: AOJu0YxacSx+Zcc88sFiJPXOC9jKsaibrmd7E1BQEf4eQ9V1z11UzzZd
	OTPCycUxWUXQW4qxDwDrTvuk0x813/6K5+UHjQ64VlcQVjTmchoOu22FJ9FTnQ==
X-Gm-Gg: AZuq6aLeKMnDc6+wDLZkbS3vFOQbxBERgHsE2mzkDSNIC3lqrVUaEhg7AnE5BJytMm4
	HlgozUJqaUnp+W7qhpy2UzxbQ7upqXvrT9jkb9jwFKgDVsxLAFJzSoDo8XpnQ4JR2QUbwnyLd7Y
	VbEXA52nmTLNJiYjTk0dTPhqstqfegFzyF/e4w51g71xZpRa+N0A7bm4iiWa6G2m4UoeW3h+QTu
	bqDTxtrdHw+SyyYoUduw/Ns8rcB9CyVuO4Ky62nC9m1vYK5sREdbFex2u4iJGEP7jn3MY8mi8y2
	gxluZIozl3BPZiJrwlP2z3BeA8VKtXL7h9tV9vHB9RszwKjSLH1b4kWRzu2opOTFAij+qfUk2C7
	/XX5dnkCF5PIf+okzNrjFwJaP942NWCWNgEdZQFZTfCKL8A46M81PC7cr11X6l3CAyeODD4xJo6
	PE3DGMndG6CcdFeTmRlMJVsPEFjivoyAqGZg2q58zhNnoRsUiSX7afRg==
X-Received: by 2002:a05:7300:6417:b0:2b7:a3a9:9c28 with SMTP id 5a478bee46e88-2bd7bd5a17dmr3054473eec.20.1771799732689;
        Sun, 22 Feb 2026 14:35:32 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe78b9sm3751435eec.18.2026.02.22.14.35.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Feb 2026 14:35:32 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 6/8] t1901: use tr in git repo structure output instead of
 expected value
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aZgzmlVfuXgI2UJ9@pks.im>
Date: Sun, 22 Feb 2026 19:35:19 -0300
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 jltobler@gmail.com,
 avila.jn@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <052D94B7-D26B-4308-8349-159F16BDA6CC@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260218211845.96009-7-lucasseikioshiro@gmail.com> <aZgzmlVfuXgI2UJ9@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3864.400.21)


>> The test 'keyvalue and nul format', as it description says, test both
>> keyvalue and nul format. These formats are similar, differing only in
>> their field separator (= in the former, LF in the latter) and their
>> record separator (LF in the former, NUL in the latter). This way, both
>> formats can be tested using the same expected output and only replacing
>> the separators in one of the output formats.
> 
> Hm, okay. I have to admit I don't quite understand what we gain here. We
> have to use tr(1) regardless of how we do it, and I cannot see that
> either of these alternatives is clearly superior compared to the other.

I should be clearer about this in my description. Of course, both
approaches work here but this won't output a NUL character if the test
fails, which could be considered as a binary file to diff.

Actually, this is something that Junio saw in a previous patch, and this
was his comment about it [1]:

> * Instead of munging the expected file so that it contains a NUL,
>   and compare the actual output with it, munge the NUL terminated
>   outout to make it text and compare with the expected file in text
>   format. This matters when tests start to fail as test_cmp will
>   show the "diff" output when it fails, and comparing NUL
>   terminated files, which are "binary" in the eyes of the "diff"
>   utility.

But anyway, I'll make it clear in my next version.

Thanks!

[1] xmqqh5txfv7b.fsf@gitster.g
