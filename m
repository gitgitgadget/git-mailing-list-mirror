Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5712B89
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183277; cv=none; b=piOyS5rL+h63A+x9TZr2uRUcpkCWGuOO96PPWxfAdBQXrE+AvWddJ5ygAsiS5r///5v0bznSf81Y8coKFVCTBHj4pIpJzGBrH6NtspbnX1cBNqB8wLFobu25mGNaJJFvBdp18/rEKWN5vFaS9RPASXCtc3J25X1zPi7lp1leOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183277; c=relaxed/simple;
	bh=iuXYOFmez8HGkzGtlvdIt3Dn2EHyCXiZ+vYFP6igENM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgJnmlJdcWZEWKvgoo5UFGy9zvOaWRzyes/fTubegvbeRrRdQ3N0EHoDVnsc3v43MiGMVrRaKxcvaRzRTbKm7gQCZbHuP1okZWlp4qUm2DJoQ0NZjZIP2wfbSVPYE58f+t9dbgLLUOR8/dnDksnAd6nqpgio4JsRZA9UTB1QVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gebuJbkf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gebuJbkf"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso32364191fa.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718183274; x=1718788074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mWGkNyv/k+hgfT5gRHXmOCCIlwi8SpQNukUCvBsQ/7g=;
        b=gebuJbkfF0vDCZ913vtCKrzi3ZK5/FYV/pqb85wYRwwREKloh3xnsZNG0xYWLCpVxL
         Jk92SSJd0q+cBjru3zYHxWpqk6kuyDCg8qjF+CMherfMybaJ5/jeFT2NEs5JPgNdSbx7
         X0fYIsQiqnB4Y56ryPfvwu1+YyJEPbiDckKkdqrnUIrPz1DKI2bqlNnNj3vF3l/VX8RV
         aEWLrz4dBJnehB6239s7in8CLL61Ys9bxZQ9Kai25cg3iI7B9jlAFC+GYIdhSmw38MMv
         /p9Qhvg11gDdQZ2xl7/yYiy3bFIvEoY3NMoLx7PNHtsqEGcFrHPMYHDtJD4W9TP1SziU
         zP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718183274; x=1718788074;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWGkNyv/k+hgfT5gRHXmOCCIlwi8SpQNukUCvBsQ/7g=;
        b=iK0g7cQyiwKIa99s3R2p2WlwJweYkR7L93ci/KVKQzCXiCTeiR4pEI7+x6CGadwSUw
         apdv0vEMjU2TNK77utdVsnhhPErSTq/XI6KlMMt8xkRaSU+IqLtUdd58q5i904/X9uN/
         HoH+IDIw5m6prbaq8r+nMWskFUkCadjP22niuKZhYAN66O8KqQ8I5QMtWsPfrb5uyUMw
         YiRrZLqYWRF1ecLzc66vykYGmqTFty3SSyJ9covtLAw0p9jMWdnLYCNStES2PeCj9bXp
         DaIpH82aXbLteKSeG+5nDR7+VPmjeSGk6Sm2C766u2MvYetCRY5jF557Tw3rk+N8wJiP
         InOA==
X-Gm-Message-State: AOJu0YxRn9dSoaoVwIIZV6puqPaoOvUsKDOmMQHLfeiXj6GHHSSVc2/P
	s2Ebs0Bliyip0jjtZYPWPW5nDbMtXpSGTHssRqvDL/PXA5sbAKAA
X-Google-Smtp-Source: AGHT+IHewfwGUh6jXmyg3dhH+YBxXdxtkndkGmMJZ5EBn3pJzmZf9LE2EOk3JQdEAAV4U0AHFORV1g==
X-Received: by 2002:a2e:8808:0:b0:2eb:d6a7:feba with SMTP id 38308e7fff4ca-2ebfc932920mr7085671fa.16.1718183273416;
        Wed, 12 Jun 2024 02:07:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9fcsm17840085e9.4.2024.06.12.02.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 02:07:53 -0700 (PDT)
Message-ID: <2c2aade1-ee83-4ea2-94ae-3d6714a52db1@gmail.com>
Date: Wed, 12 Jun 2024 10:07:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
To: Junio C Hamano <gitster@pobox.com>,
 darcy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, darcy <acednes@gmail.com>
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
 <xmqq1q58ejnw.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq1q58ejnw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/06/2024 18:40, Junio C Hamano wrote:
> "darcy via GitGitGadget" <gitgitgadget@gmail.com> writes:
 >
>> +/* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
>> +static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
> 
> I wonder if this should be of timestamp_t type instead, as the check
> is done against *timestamp in parse_date_basic() where *timestamp is
> of type timestamp_t to match?

I think that would make sense. We'd want to cast one of the numbers to 
timestamp_t to ensure that sum uses a wide enough integer as well. Using 
2100L is probably OK but an explicit cast would be clearer I think.

Best Wishes

Phillip
