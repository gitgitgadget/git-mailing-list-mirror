Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815291805E
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641354; cv=none; b=dpOeqRauKSLqsr18AnFuWq2ZDk27igYY675/BdjN8uU3CcS50rAqqUWmTIwlWiHs+lEfZn+u3OtXb8Pz0v0z/vZyiA6at5nOG89cjqO9hh4MrYKFXKtKRZVcQforbOhCQwblRGyYyXqHparii0lslg1RMZq/NIGBtV/8YvLfHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641354; c=relaxed/simple;
	bh=Na9dx0KC7WZGYhNcoB3tJoeqnFxULr+KyGe/jwD8H0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2X9Qwyrr/NNHbwxp2CxpFYtkISZWxerKCfVKzBkJhhsk9pSlq5jHdc3P+FHeUei6NVmkZLVNke+HBIKyDHzJu0RO8Jbp73r8EGqeRIQ05R5IniiEgerVgigxiK9RstlmwtOGhPChjaF7uhgnXU+HnVZszkIGGgZtM7KAGL1zpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY97UNYr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY97UNYr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46d25f99d5aso3165e9.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758641351; x=1759246151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QJJOz4zRhP9NQd7AsouBBOv2z9Z9vilJ9hZnkzGAiTA=;
        b=LY97UNYrG7WLeqOBewOzF9sA7sK330khegXpf1O5txpAw/kWXMVDXLJqbw0uYK9BaX
         7k8Jg2vAHAsYyBjXrW9+nvHfyy/RbkUSv/cO9PaQjf5QWVovd0ANd1t0Ubg5FERsUfOE
         v7dg0OQqOQIOTpVCpdZVrWtENY5i5Dcimc8HLBFv6SuvJw2SDpgxCV4rk3cjpo4+iEW4
         lwNx+fTX4UCIiYQaHZ/NyciSeSo2Gw1CyrcaZA4tvTkGj6OLXDGJsbjnDdocHf3qA3wQ
         lth2MqH3MVtHSWjDqMMYR4mfw5obq3XnNDJ4u7Bw8n3zFO08t9CoVbsXH69oA6lFX/Im
         fteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641351; x=1759246151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJJOz4zRhP9NQd7AsouBBOv2z9Z9vilJ9hZnkzGAiTA=;
        b=Kh1esk7Y/kH7pCAD0zURjGpTRPyYnyQLK8XuSk/Qh7QmrLkvnNNIbolRkDJZPE5rRV
         KeSH/QX2VL+RkfkbpiwK9zH85GZRsOWqzbjbw5/+KkdE8g8pefbgUQzpSupMs3IG7xXW
         2aaiU/Ml3fwbBVJWWVJ1obdkSNWwyUK0OUNYPHdV/NCpHp0j72pgPbk8f4XFKYW/7xPn
         crYiK1l0xZXVRbcut2inEBLAkRDD3c0lZwwDbeSF/8fZso/sYqz2Uly5iwABt1UHfh1B
         +NrDv9GNH7wCcyZar4XCYIPBKEfD9KVCnNmgHU8qtmD1EH7Knj/6TwR3fo3jTJaFO38j
         JQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq19Boj80NwJQ9BJuKaBV4bB8VWqnw8deu5ugWlZ5EG0BNYoa83+Dv4SyCTGft3mDOIRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqosJLaxlL/cejQal8mI95kW5W+t6E9uQ9okvfPdAhoLXJYLq
	1bQJnysir6CO1ODGffuunG72onr/mVHUWYN3Z4fBF541jKKK0Pn5pNFh
X-Gm-Gg: ASbGnctX1r5f7oQ3P5mZUrLUodzYVEP5SLBXPiqdYaJmlsGdqNC1vhPMGqFqYWOyi1D
	AB1jCc9QsGQzCThhPPu4QhIhKON0R0TCR35h02tFTNOTEEhHZUmKu9qcGuRS3wnYlJ+7jT38RZN
	c5XSYpQhBlQpCCAvUA1fJqx7Z8kJmX8jbuMYg5uLaVDCs2Pz4tmGmvd4QF1WmBKmqSvAgJ0QvPq
	nj8+EXYm4qA0QffQM+1t4dNWpwFAGEXKFbvG6qAIY0Ni7Wvv8fxNwimMbK43yVM37OO0cX3CVAe
	ngu8T2TiW8nyGtezixRrkA5PH31JZgRqQjI2HC16+UCt7RxeNqA45243TGvMLs8b/OpGGuMK27t
	BDxKejjUr7iFCB8DJk8ICAVcY5Cj4eJIzChbKucmJ4Ab2OiHz3bi+BpGn+D8LgfuejZxgK+LmGO
	T0jXg4Ht+HrA==
X-Google-Smtp-Source: AGHT+IFh5V1g43XUjLHgyUr3dX+q5YSQ0riDisoUhdS3JAJteJKZT5QKwwk6AF8d7dbRRScCth192g==
X-Received: by 2002:a05:6000:186f:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-405d090c6d0mr3047146f8f.16.1758641350732;
        Tue, 23 Sep 2025 08:29:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f02f332c31sm18436939f8f.45.2025.09.23.08.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:29:10 -0700 (PDT)
Message-ID: <d323c453-a800-413d-82d6-b0db0a4b76c0@gmail.com>
Date: Tue, 23 Sep 2025 16:29:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 7/9] BreakingChanges: announce Rust becoming mandatory
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>,
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
 <20250923-b4-pks-rust-breaking-change-v6-7-59076fee486a@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250923-b4-pks-rust-breaking-change-v6-7-59076fee486a@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 23/09/2025 10:45, Patrick Steinhardt wrote:
> ++
> +The Git project will declare the last version before Git 3.0 to be a long-term
> +support release. This long-term release will receive important bug fixes for at
> +least four release cycles and security fixes for six release cycles. The Git
> +project will hand over maintainership of the long-term release to distributors
> +in case they need to extend the life of that long-term release even further. In
> +that case, the backporting process will be handled by these distributors, but
> +the long-term release tags will be created in the canonical Git repository.
> ++
> +We will evaluate the impact on downstream distributions before making Rust
> +mandatory in Git 3.0. If we see that the impact on downstream distributions
> +would be significant, we may decide to defer this breaking change to a
> +subsequent minor release. This evaluation will also take into account our own
> +learnings with how painful it is to keep Rust an optional component.

I think this last paragraph is a welcome addition as it makes it clear 
we're not going to blindly pursue rust if it causes widespread problems. 
Personally I'd say "experience" rather than "learnings" but that's 
probably me being a grumpy pedant.

Thanks

Phillip

