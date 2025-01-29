Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A51FDD
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738157896; cv=none; b=RFA2kCYWFz8U34ScJWgVfu7iTf7SHes9bz8teiOGRI+YAdZ8CO+4fwelRIFds8fisr2G64ynSf+objVgnAtqQvrY37+BnihZEVzNaif+x5+2DCcxr2wRslS4Y5NC+jdkDS2blOhSsRgH54zsUUmQR49QyqQJdXL/GqakJ5zkvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738157896; c=relaxed/simple;
	bh=FXU7ITERwvmlVwj8PvmGpPhiFsoY1apdtD6J9zfLCw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSGddBGuIgR2cXTJbwbCgm/b7pQ/j8tBvF7mChf9goLnSVxVWCZoAj+q59qrDvQitzpCqA5KJeFdGlQA1CIVMofh9PcxCO04DWsWJ4ba/PNJhuRvOfeNBTPEj5VQ8nXSWMgE3PPySJGrSWTB5MIP8tpbpZwvPZ3SI6RX6QvLVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2LSHTQl; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2LSHTQl"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e58a90c6059so863252276.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 05:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738157893; x=1738762693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNOy2s3VO6eM4D07091H3i16TW+/39D0ohetCX24Avo=;
        b=A2LSHTQlbXm6zk4DQRga296r4HEf/R/EvjeeU1/MqNPhv6h9QXGfADQdaW8f0Tv0lc
         UD75uA/ENutGtG/OHx5Z+zJMoYFufiXGO5jcQplDg7mwQo3KHkNTby3c+1AUWfBEKQkN
         1U1J/JZMkB4jSlW/WpJYHXT6tk7L6SldohevJe5hJqtV1dvWoN4lMGlPIRWDBPs82ZEI
         fYq0hcWWf04agGlRyg42jg8eWjuTpAHcnBhxhNUXlYNFlXWQs8PBh+rPldQnJipO8+xc
         6F8B5T5XxuH8fwY8Guj/PHzTsLVJqBz96E0w/lCwzkgppT0kRhno3MeMZyu2YA6fyHqo
         pS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738157893; x=1738762693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNOy2s3VO6eM4D07091H3i16TW+/39D0ohetCX24Avo=;
        b=avHULolMrtUu+5xynC+HMI9k0UV0v1y/OeS1eSZDtNSNnIHVDSyhIKVXRHVPoYVoXl
         DpIiKatObgYnP64BbDmEIYO1O7VZRWxPDXeH6MG4O5DgomwnKxuLJCEKIHfyt+6vLq+f
         tPFLRbNNEtVk8Oog09O+B9pOJ/OaKi6J7Hz8sOmZmoimK0P61+F1l5i8GraLGAFOUY7G
         6wMn+WZUVqh30ZzYcBBtykQN6eAjvKV/N7L4s9pNoyUVcR/jRb3OB2Nw1lS/frqg2DmA
         eMhdR+7ef9VmqdMcs8de3gvjqoy3fAE1GDKTctKM7bak90HQB+5k5wbYaeWNqP1VKuS1
         AzGA==
X-Gm-Message-State: AOJu0YzMyg4Car9qT2VvdSigaNYslgctFj6n8/yxmz8VAzsmGknr/5w9
	ylDh20qDZoUCfCchVhZlM+HvqIaB+7TSsYLZWrb+woUwpfCs4Iix
X-Gm-Gg: ASbGncvmjDJocomTLFGBH2SmfDQoLwFaAdH7DqcoaHV1CKITAS0c6Ij9TmXEKOQizwz
	pTwhNbXTCuZ4OYrs5j8Bid3P65MNcx9mk33Sy2euAWZ0rSgNnWPsYxdboGjpF/XbR1BSH/xzm/L
	eMcRbIWp/Am5ukuCRS9Coc+GtO39GR6V2jk+OXgUL2Z2NzKwO6Ox0I76WGsNsz9xuXxnCDjFy5H
	8+8JgceF2SxBNgv1/yNmZin+Q3Yey/aJoTL3wUmzw5HYqJZbEAgPEr8Dse7SQGSEZ40tar1WcPp
	s40Jm2+TUWD1ag5CZno5134LenmvRIz4lY8kMcisgGtVpJvActxSxqaMJuEP21fvtIhC5rik2/9
	s
X-Google-Smtp-Source: AGHT+IHJF7FEiyLJVaZbD3VOfR9Rof09EBH4XCgn7/hWjauXG2dTs2dxFDNwneEqUbPxMUQzw9aDew==
X-Received: by 2002:a05:690c:6285:b0:6dd:b8ff:c29c with SMTP id 00721157ae682-6f797730641mr59579857b3.17.1738157893587;
        Wed, 29 Jan 2025 05:38:13 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:89cc:5f2b:c6ab:6d1? ([2600:1700:60ba:9810:89cc:5f2b:c6ab:6d1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757a2d5besm22852517b3.97.2025.01.29.05.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 05:38:12 -0800 (PST)
Message-ID: <001e3382-e851-41a4-acc2-48e44501efca@gmail.com>
Date: Wed, 29 Jan 2025 08:38:12 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] pack-objects: add --name-hash-version option
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
 ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>
References: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
 <7ee1845144fda5b8192dfa13eaab3cbd669b39ed.1738004555.git.gitgitgadget@gmail.com>
 <xmqqy0ywoszt.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqy0ywoszt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/25 4:18 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +/**
>> + * Check whether the name_hash_version chosen by user input is apporpriate,
> 
> appropriate.  Will tweak while queueing, so no need to resend only
> to change this.
Thank you for catching and fixing this!

-Stolee
