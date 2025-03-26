Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E708C1F
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984275; cv=none; b=iyMGsFpQzJXTbFdofoSsMiujle0sovLUCvVZbom7sBjubYyFgO7wgNR7ErKTj3mRCGrv7+6IYgSHtJlJfar0/SONk67amSu4lyfLSaolWWDfRzbilpE3qPO9+Iue701KgRWr2klyz1zXs55olLQKNQjYXRGzbDJN6zblxTxFh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984275; c=relaxed/simple;
	bh=/b4bbMyHB0ORGZEJh8MP/2gIZrHib07G+J00jeHM/do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAFdmlc8IKBs+0YkchrAVmL7ni4/BJjayPUiuDTLWfjwFivAFBi8Az5HNSyfIPfB6FL7IK3ZLoubeJmlxtM2aqtB3jorL3M+hTFiXv2uDEGkyiawpKA4eWKddthRZDiShaSQayHx5TFt91xX6QlORjEIlrrsBoYC/AERLCEiDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njBXggfn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njBXggfn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso60998745e9.2
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742984272; x=1743589072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KStSODRiZEGjyGLvSmAppX04SnUvMW/bC0kpVz1hETU=;
        b=njBXggfnD0gE+10UyLDA65j24SPbkBz2mijJer7YgPjWLWVd0X3EGL+CrFSl28FlJW
         30SpJLVIBdVHeYBDGE6pX3I3TG0wq5H2J3R4DS/YKf3ftIWQyBGzAxhI5wrkqN/ovQ9b
         4C2ljLlClJUFEto16hCMldWCKx/o4z9g8WUw4L7OaC6yWV++D/6+3V4xIHAmExkowyF2
         9A3ICOceTlyp+hKBIJX3Ow4P1fj+YEYIKl2dNzQtjb+kzBMHiI6kPLqbSAMjty7sDzgm
         xZDH88/nyVdTJPVm6E1Ch/4cMV3P/BypNnrmWqM5WigG+mOyhh6WBkroS03JVK6nSj75
         Gp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742984272; x=1743589072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KStSODRiZEGjyGLvSmAppX04SnUvMW/bC0kpVz1hETU=;
        b=outoahaWCPyi/waIr39GTa50uK4SPZ0P/s6Y/+GnE0cn7FUrK/5GkTqo+ErpoNKD0w
         pClcihn0+CIhB7ix1LZ1SX0724USO7WZ1rQ882Ysm+7ct0jpB2ArIc2P47FGpQ1GBBwU
         eAb9MIGGAep04Z7rKtp+/+rWVO6+lkkpdi7R24xiqE2B/S9g0E6eBj1vbrIJ1LX3E2dP
         A7Rnk1RYddTF1HmL2iihv8EVtCRJATBASyuQ+JVRpFR/gZHP78SYAsIQxa0qvM7u298W
         QMOsyodRCMXZTLk0OTeXYPTSBZ66TYC2cvfKkSfCPwKo9s+b1DfJqiP+pz1Sz4UBuOX8
         TU5g==
X-Forwarded-Encrypted: i=1; AJvYcCWB12ZtzFhJXR0WpV2V1HQgL81YJzmP+WfsJRrtJTpAeSzl/9SCfxNFXzhxOBTIxldt3t8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/ZXs3C69GJflDg7vDtKJuQqG2UScUcNeBn8W18iWauX1tdZ2
	OE2IgxahIZPbF+E3tzjnbmH12DEXKkVLaV8lz4BTzbP6uDIie2jkT0giLQ==
X-Gm-Gg: ASbGnctaR56HwGYU3d0v+296/47shc+wrb681LF9JFx6WYZXa4o/nvmNky/0JAQVtyi
	IWv6QsHk2IfqB1qiQKgg0apS3qgrTrsamo9kE0L8yjbaEjMJZb71I+krjZNeVHtlZJyATAYCqIL
	5InXfSi2Gp+8fo22svzTXLl6hd5s5UTro5wUpzbzdH4nXKwQ5dKm7AXMyfBulAjcesKm6AiYuAy
	i6AgA1rGXd9CrCmMIXAULF3MksOzvodC9n1tFKRJBT9XBrZ/KO2hJTxQGLqCfIMyitrKXg9PG8S
	sFend83YONpLCIXedVZRjcNi6I92SObiMGPZG8GONUt/41tQqZ8GWQPfWQbqjKdsTZ4LiJBryE5
	vsEADJ7gArQmMuSjmy+5Ysik3o1TjRCU=
X-Google-Smtp-Source: AGHT+IGQaPTcpDNn+/nu3qW7x0DlkuAIyItZ9UPwx/fFdbKc8ra5F9nE+0/2XsB2OdLxasTXItHSTg==
X-Received: by 2002:a05:600c:15c8:b0:43d:94:cff0 with SMTP id 5b1f17b1804b1-43d51a91d05mr114263035e9.19.1742984271756;
        Wed, 26 Mar 2025 03:17:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9ec84sm175377935e9.26.2025.03.26.03.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 03:17:51 -0700 (PDT)
Message-ID: <ad57203b-8925-4f88-add6-763c2d80afac@gmail.com>
Date: Wed, 26 Mar 2025 10:17:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 06/10] diff-delta: explicitly mark intentional use of
 the comma operator
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
 Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <5e0e8325620395196608a0851f1f6fc9408f6090.1742945534.git.gitgitgadget@gmail.com>
 <Z-OWoK-DlvnxXPkO@pks.im> <050f5d65-32eb-fd26-1461-579b06018dc6@gmx.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <050f5d65-32eb-fd26-1461-579b06018dc6@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 26/03/2025 07:20, Johannes Schindelin wrote:
> Hi Patrick,
> On Wed, 26 Mar 2025, Patrick Steinhardt wrote:
>> Hm. I think the end result is even more confusing than before. Why don't
>> we introduce curly braces here, same as in preceding commits?
> 
> The interleaved -/+ lines make it admittedly hard to see what I meant.
> I'll unwind it a bit (presenting only the `moff` part, the same
> consideration applies to `msize`):
> 
> 		if (moff & 0x000000ff)
> 			(void)(out[outpos++] = moff >> 0),  i |= 0x01;
> 		if (moff & 0x0000ff00)
> 			(void)(out[outpos++] = moff >> 8),  i |= 0x02;
> 		if (moff & 0x00ff0000)
> 			(void)(out[outpos++] = moff >> 16), i |= 0x04;
> 		if (moff & 0xff000000)
> 			(void)(out[outpos++] = moff >> 24), i |= 0x08;
> 
> In this form, it is very obvious (from comparing the right-side half of
> the lines) that a shifted version of `moff` is appended to `out` and `i`
> gets a bit set, and the correlation between shift width and the set bit
> is relatively easy to see and validate (at least my brain has an easy time
> here, thanks to the alignment and thanks to visual similarity between the
> non-blank parts).
> 
> It is admittedly quite a bit harder not to be distracted by the repetitive
> `(void)(out[...` parts to understand and validate the `if` conditions on
> the left-hand side,

That makes it pretty unreadable for me. If you're worried about the 
vertical space we could perhaps keep both statements on a single line so 
that we're only adding a single newline for the closing brace rather 
than two.

Best Wishes

Phillip

  but thanks to those repetitive parts being identical,
> and being only one line between those `if` lines, I can bring my brain to
> focus only on the differences of the bitmask and understand and verify
> them with relatively little effort.
> 
> When I compared this form to the following, the cognitive load to wrap my
> head around the code is quite a bit higher there:
> 
> 		if (moff & 0x000000ff) {
> 			out[outpos++] = moff >> 0;
> 			i |= 0x01;
> 		}
> 		if (moff & 0x0000ff00) {
> 			out[outpos++] = moff >> 8;
> 			i |= 0x02;
> 		}
> 		if (moff & 0x00ff0000) {
> 			out[outpos++] = moff >> 16;
> 			i |= 0x04;
> 		}
> 		if (moff & 0xff000000) {
> 			out[outpos++] = moff >> 24;
> 			i |= 0x08;
> 		}
> 
> The reason is the visual distance between the near-identical code.
> 
> Having said that, I do realize that my brain quite possibly works in
> special ways here and that the general preference is to go with the latter
> form.
> 
> Do you have a strong opinion which form to use?
> 
> Ciao,
> Johannes
> 

