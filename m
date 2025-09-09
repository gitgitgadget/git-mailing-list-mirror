Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91D1F0E2E
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433638; cv=none; b=ux8/UGFZq9nzkeb2fzUvNvPkA6Jz8jGofcL+scY8GoiOhyNodrVHr9RGVlb17D8t6CyR17llGGKaMv+avhKs9Cv/Bt3yPiVUKq0if5mANXv5/I+Kj0Jfd4If/U3FcHhoXLrzgM3ugbKAcxwyUufploHzl9JhHwJyJehSj3aKpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433638; c=relaxed/simple;
	bh=9rfsQZUs51QFETmVfwGB/ggK36DO0P0sADTtnPZLZQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTF8iCfd0IMNzy75fFWjThS24DjiVE/360UtAWKm6yKLng6uhoAWW7f4DQAegFVZWINdo3zD3JdYtBeZs0RL2EhT+9L8mA5sUxyoQFDLpSqI8v+mJicU1SK+xYnc/1lkJ+XXvjPakhbkvusLdnuq3hzazIQ9XqWc/cJ8OJJTYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzn7h1Fr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzn7h1Fr"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-772627dd50aso7316379b3a.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757433637; x=1758038437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rfsQZUs51QFETmVfwGB/ggK36DO0P0sADTtnPZLZQk=;
        b=Vzn7h1FrhHyWd66bOE+hDYJxaw9a6e9JJCDrmDT9ptgUvuVojcb+5uPKDz/y1+7aTm
         oUZBvxN5OU35yJaLeJUvEbenvFg031oZaNdrM9SCBiKKW/pccOdcbqafpSVN0M+7lBFl
         NgSfxfVbXXR78xFlJ/E4pTbpa2cA8Mft+zjJ46d6ftY83kaeV1+VAYHBKnqO5Q+FxvTn
         uWP4f9UZwhKiysGppvQijzl0S3H+3e/afZvq1Ncku+G3LCXyFxv9htwU68yWSIj35Lhm
         9OHxZqgYr/TMZSb3qmQtchtnKad8yncQMIIgUdOca3fjEe9n7r8K9MH7vRIniwL2G82C
         L8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757433637; x=1758038437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rfsQZUs51QFETmVfwGB/ggK36DO0P0sADTtnPZLZQk=;
        b=nU9bbxyOIrGHyTtm/Q1FCpYsJRkm5OZW1Ac7Yil5NLPEGFgtXN3mClK1P56JXqpnms
         uiffei9V7b/z4XWfNd7K9olurv5S2eTmgAHCabqVj4ex1NJaGPjsz/wxpaG5FrikzepV
         6DWDn5/fckg6czy/rXnzxqniEV/frxCiGMjMZbwQczTxl8wexRsR6M3R7X/61lNX/Sxu
         lESQ5IHSyA2W0Er3IC4CPavDM3jJxCf3rr3YPciGTn+Szhf8NnJNdMjBUIWWmxUcqZFm
         +rXGfmnXZ+VwCKvVRGCS5w+g2QouevOPFlvXC6ZROatYS2zdlvd6K/ctYF8t69etjWlV
         bPbA==
X-Gm-Message-State: AOJu0YxIG9bYb1uja2feT7FRDYFVPF3Y9aOq/LeocWoQ7IM+UgizRLhb
	aWdBOyFP5jEstflBhvQ8XpSW0adItbdPHJGiqZNmcMV6GIfkuZBGumOj5HhBfw==
X-Gm-Gg: ASbGncvQVoi142kNBt/KP5QIhl7IN3mR8vGuexsRTIHIqn5HdC9dJ/nSwT7AvLn51oc
	v1Pg4BDptNd3CjbGdH4V/58gIX880h1YzEWSiC6ZYk7Yd0QTBbr0Afn7CjUHxY0JC/vCFc5wJ8X
	Bn+4H4kg3u+Z3UgkUVp5jl9G3qntB6lTBdIu7qoqAkajzp9eS49a70l9k1ml4mAUG3pYntuZ/1W
	FuqinrPfsKy8GMNbUIoZAWrid/W3ezAhVVMbaDfFVnphakM1w9HZl1W/kUcGl4LlmhJZ6fhOnmX
	f+xNquVPO4F4YlLZxgD/e1pySGXElT2lJvAhnLQQ0AsPL/8vqt+iBu+S8SQnLk5+klXS4H4Z4K1
	3or+RjUOf3bFIyggo/cw/e9eAlnkNNuvxp/hX+vC6QeFiriva4w6Vx9wKF0o1H421nZrtDw==
X-Google-Smtp-Source: AGHT+IGkWi5k1lctx0HvLSAuCYLUzU/byoLrhvgmyI9eE/Cc4vM9Sj/y8U0AZbAJv6VWOsmYEYHG8A==
X-Received: by 2002:a17:902:ce03:b0:231:d0da:5e1f with SMTP id d9443c01a7336-25179686313mr143218165ad.21.1757433636516;
        Tue, 09 Sep 2025 09:00:36 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27bec860sm1813875ad.34.2025.09.09.09.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 09:00:35 -0700 (PDT)
Message-ID: <b8df3605-7afe-4121-ae50-095dfd671df9@gmail.com>
Date: Tue, 9 Sep 2025 09:00:34 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is Git Add Supposed to Work Like This (git 2.50)?
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>
 <20250907233456.GA1281511@coredump.intra.peff.net>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <20250907233456.GA1281511@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/25 4:34 PM, Jeff King wrote:

> I guess one could argue either way (though probably not at this point in
> time, as switching behaviors would cause confusion). But one challenge
> with "partial success" like this is that the exit code is binary. If we
> return "0" even though some items were ignored, callers may miss a
> failure. If we return "1" even though some items were added, callers may
> not realize they've mutated the state (and might need to rollback
> depending on what they were trying to accomplish).

If this were a big deal, which it isn't, I'd suggest a command line
flag that says what to do if there's an invalid file specified on
the command line. One setting of the flag would result in the
current behavior and the other setting would result in all the
invalid file(s) being ignored and the valid file(s) being
handled normally.

Jon

