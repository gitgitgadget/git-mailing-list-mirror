Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDBD2FF
	for <git@vger.kernel.org>; Sun, 18 May 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747581184; cv=none; b=IKiyyf0VMAtPSMFbCkeAXTa3jRtWc9dc9dERsSeLO2L2dWkcuPbQYAFbuz61MPH1IT9BLZ05ZxFrbNTMIz14apXDadH5ZqLTeKY3ZqV57LgfN9ZNdkNUnbP3KsuD9J/WjyWCVaOr/0ulrIlxUeLSzzJp62WQY1GIUAzOt4Xakro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747581184; c=relaxed/simple;
	bh=l/TZc43yPpUL6oFnFCT6JBYM7tPJgjSA6bFjHn5jfwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlhPc63hPomwARvUMnYnlSw/CbjB5h6mwd9r2luT+J5Wf7nUgub3nzPA2WAwbHiiwWotsR3q4bLwxGXEjB0tlKfnd2aQ1gRqwlWazFYWCxrVumj0dE2iSZ1o6xvXZom4aoSSaDR/S9DSVaeQdMRNcY/uPYSzQvTHqeBX+cxXfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBlbg6mz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBlbg6mz"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3217110b3a.2
        for <git@vger.kernel.org>; Sun, 18 May 2025 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747581182; x=1748185982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZlPmJMjU/HDF7AyemEr/gQWOa3yDQ3OiZTWT9iAc+A=;
        b=XBlbg6mzB+7nQyPuD1ytgZQdF1SRz3IdVUGi6QNRR1IvzCvaYp3ZqNF0vMDasu0L0U
         PVkfVPx+prVCwiH1n1Ir8mKkss/NZn8aJ9n9w2Ps4WbOfW38M6L87zuumZMYJ0KKTEnk
         mXfKXJOxt7l98SMJ8CwELuxa7FExgcc71XR6o5+iOGvZSFPMlSLQZS7NVEEGiwMz0Cqj
         akpK4y+ILDjbltTRAYr8ElnIZmD+Rz+ty8r6n1A0q5/41w3wWeRwM5Ju61tyTUX/T0uK
         ZQBpA/AKbySLAZkrrqajiAWJn4xnCGJPhDmN54gz0hOXZzW4M5+Ov4Isc2BiAI+A3vN+
         w/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747581182; x=1748185982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZlPmJMjU/HDF7AyemEr/gQWOa3yDQ3OiZTWT9iAc+A=;
        b=hhD9tMeqjQHbyEcLzeviEtA89Pnll7ZciVlRFPBxgWiMC7vdMhKqua/EYcm60BhU7C
         EVJNFgEvEvtrgW9wYO9aRvepVgytp7KKqZGD53y14m2ESD7/g/SH1Xqupanr/vKlb9yZ
         QLqYeOC9NwSZqOLw7FbWQsYFozhPSfNWmK+km6w0E8b4+iwn1hNRY0n1Wu5pBp798VlM
         i6982Sy+sWYkzmNKjF7t1lN6sRHoNigkrESyCLXMcoKX5GshMMweyF4MkEiY28YMkyUB
         2qbX65ADBmT+3oj2VjXOb4uB0nUw0F1RhD/clBWaW04eVOppWgxaizegYimgB8vVRWTx
         YlRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKOuZNSnIPxd7NdFN8lxxFEDXxwZiq5Q7+zvoTuM50WlGEg3zl69zhPA95lDSbwk2Oxc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHEKklZ4W5dUYLl18EcTnfJa2ahuCIB0ijURYoHnvij7uaARJ
	IZgMl3apt9a4rQ3NSI2HNQ4CVcrSkwkGbWh61HJAY1TgJfAXWwrlWCoT
X-Gm-Gg: ASbGnctanMSE/4YmTuQklTG5Px/PrNO7PCSZRYV53v0+62jS9vDWM54P4mQMhVtPwnm
	mAMb5cRfRabJfngvf5Mjg2CUvc21jtrF6r8A9Tur3yAaD5WTuucLc+FgSK2ovSlmOolwnHj8Gxi
	CRpEzAQmm3IKIpxzEg8CI3pDSk5oeIIdx500foH/RcjAQCqe8SoQAWEh80Ni61L0FA64/Jz8uyq
	Osdma0JOsQiXCJlq+S2aCFVDOy6/i0edK66IHJQ10Dn4QZyyqDrDK/KwmbbQGfriC6Nmew1x0yA
	LE9VOPUaBANF3IlnzojDZhAopVQgGWVeFjG5BQXyeN0NniwJUXam9fm9vxaZLN7QhaW5yDaJiwe
	auuvdWidrmWfQtrwx7iWZow==
X-Google-Smtp-Source: AGHT+IH7CljgtwAgRw4coc6jw6J0bR9acoz9ETAM6Cutq5y1hLoABzQMN2LvpQeOxZreoAFV1bMhWQ==
X-Received: by 2002:a05:6a20:d705:b0:215:de5f:febc with SMTP id adf61e73a8af0-216219bd5fcmr14067237637.27.1747581182463;
        Sun, 18 May 2025 08:13:02 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf5a357sm4653384a12.10.2025.05.18.08.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 08:13:02 -0700 (PDT)
Message-ID: <6c05cf29-3fd5-44b9-910b-0baf435027b9@gmail.com>
Date: Sun, 18 May 2025 08:13:01 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question About Sorting the Index
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <1008ijb$6j0$1@ciao.gmane.io> <xmqqfrh3qe2w.fsf@gitster.g>
 <e2a24cbb-1438-46b9-b546-82c9f6dc7ebf@gmail.com>
 <CABPp-BGRxierdcqWz2ZNdvLLrSSSR937CgOvC19vQkeUeC1pFg@mail.gmail.com>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <CABPp-BGRxierdcqWz2ZNdvLLrSSSR937CgOvC19vQkeUeC1pFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/17/25 10:13 PM, Elijah Newren wrote:

> Isn't the idea essentially the split index we already have?  (See the
> "SPLIT INDEX" section of the git-update-index manual.)

I admittedly hadn't read that before. Yes, it's similar.
But, I think I better become more familiar with this man
page before I take up any more of this list's time.

One observation - wouldn't things be nice if the index entries
were (somehow) the same length.

Jon

